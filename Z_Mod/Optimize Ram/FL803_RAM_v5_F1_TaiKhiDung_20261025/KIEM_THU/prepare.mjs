import fs from 'node:fs';
import path from 'node:path';
const task='D:/CodexTemp/KRFL_RAM_803_805_20261025';
const old='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const newer='E:/BaiduNetdiskDownload/FL8.0.5电脑版-解压到空文件夹直玩，自动接档';
const dirs=['all','all-desktop','kr3','kr3-desktop','lib','dove_modules'];
for(const [name,root] of [['source803',old],['source805',newer]])if(!fs.existsSync(task+'/'+name))fs.symlinkSync(root,task+'/'+name,'junction');
const harness=fs.readFileSync(task+'/probe.lua','utf8');
for(const [name,source,canvas]of [['baseline803',old,'true'],['image803',old,'false'],['game805',newer,'false'],['canvas805',newer,'true'],['candidate803',old,'true'],['trim803',old,'true'],['lite803',old,'true'],['lite805',newer,'false'],['deferred803',old,'true'],['bosses803',old,'true'],['baselineBoss803',old,'true']]){
 const dir=task+'/'+name;fs.mkdirSync(dir,{recursive:true});
 for(const sub of dirs)if(!fs.existsSync(dir+'/'+sub))fs.symlinkSync(source+'/'+sub,dir+'/'+sub,'junction');
 for(const file of ['features.lua','main_globals.lua','mod.lua','version.lua','log_levels_release.lua'])fs.copyFileSync(source+'/'+file,dir+'/'+file);
 let main=harness.replaceAll('__TASK__',dir).replaceAll('__ROOT__',task+(source===newer?'/source805':'/source803')).replaceAll('__CANVAS__',canvas);
 if(name==='candidate803'||name==='trim803')main=main.replace("assert(loadfile(ROOT..'/main.lua'))()",`package.preload['klove.image_db']=function()return assert(loadfile('${task}/candidate/lib/klove/image_db.lua'))()end\nassert(loadfile(ROOT..'/main.lua'))()`);
 if(name==='trim803')main=main.replace("note('stage-steady')",`note('stage-steady');ffi.cdef('int _heapmin(void);');local crt=ffi.load('msvcr120');local rc=crt._heapmin();note('after-heapmin-'..rc)`);
 if(name.startsWith('lite'))main=main.replace('local slot=chunk()',`local slot=chunk();for _,key in ipairs({'cheat5','cheat6','cheathero','cheat5_dragon','cheat5_special'})do slot.liuhui[key]=false end`);
 if(name==='deferred803'||name==='bosses803'){
  const preloads=[['director','all/director.lua'],['game_gui','all-desktop/game_gui.lua'],['klove.image_db','lib/klove/image_db.lua']].map(([module,file])=>`package.preload['${module}']=function()return assert(loadfile('${task}/candidate/${file}'))()end`).join('\n');
  main=main.replace("assert(loadfile(ROOT..'/main.lua'))()",preloads+"\nassert(loadfile(ROOT..'/main.lua'))()");
  main=main.replace("if game_frames==180 then",`if game_frames==30 then
    assert(#item.deferred_cheat_textures>0 and #item.deferred_cheat_scale_textures>0,'F1 images not deferred')
    assert(item.store.entities and slot_for_audit.liuhui.cheat5 and slot_for_audit.liuhui.cheat6 and slot_for_audit.liuhui.cheathero,'F1 flags changed')
    collectgarbage();collectgarbage();note('before-F1')
   end
   if game_frames==60 then
    local holder;for _,entity in pairs(item.store.entities)do if entity.tower and entity.tower.type=='holder'then holder=entity;break end end
    assert(holder,'No real holder for F1 purchase')
    TowerMenuButton.on_click({parent={},item={action='tw_upgrade',action_arg='g5_special_buy'},entity=holder,disable=function()end})
    assert(holder.tower.upgrade_to=='g5_special_buy','F1 purchase was not dispatched')
    assert(item.deferred_cheat_textures==nil and item.deferred_cheat_scale_textures==nil,'F1 loading not completed')
    local I=require('klove.image_db')
    local basekeys={};local lite=assert(io.open('${task}/lite803/loaded.tsv','rb'));for line in lite:lines()do basekeys[line:match('^([^\\t]+)')]=true end;lite:close()
    local baseline=assert(io.open('${task}/baseline803/loaded.tsv','rb'));for line in baseline:lines()do local key=line:match('^([^\\t]+)');if not basekeys[key]then assert(I:i(key),'F1 did not restore original image '..key)end end;baseline:close()
    local count=0;for _ in pairs(I.atlas_uses)do count=count+1 end
    D:load_deferred_cheat_textures(item)
    local after=0;for _ in pairs(I.atlas_uses)do after=after+1 end;assert(count==after,'Second F1 load retained another owner')
    collectgarbage();collectgarbage();note('after-F1')
   end
   if game_frames==180 then`);
  main=main.replace('local slot=chunk()','local slot=chunk();slot_for_audit=slot');
 }
 if(name==='bosses803'||name==='baselineBoss803'){
  main=main.replace("slot.liuhui_hero.useinfinitehero=false;slot.liuhui_hero.usedoublehero=false;slot.heroes.selected='hero_catha'",`slot.liuhui_hero.useinfinitehero=true;slot.liuhui_hero.usedoublehero=false;slot.heroes.selected='hero_catha';local names={'hero_allied_volibear_prestige','hero_allied_navira'};slot.liuhui_hero.infiniteheroes=names;slot.liuhui_hero.infinite_teams={{name='isolated',heroes=names}};slot.liuhui_hero.infinite_team_index=1;for _,key in ipairs({'cheat','cheat5','cheat6','cheathero','cheat5_dragon','cheat5_special'})do slot.liuhui[key]=true end`);
  main=main.replace('level_idx=56','level_idx=87');
  main=main.replace('PASS same stage56, same official hero/F1, 180 game updates/draws and return to map.', 'PASS slot 3 copy, stage87 (2-27), Volibear + Navira, all F1 enabled, 180 game updates/draws and return to map.');
  main=main.replace("collectgarbage();collectgarbage();note('before-F1')",`local kinds={};for _,entity in pairs(item.store.entities)do if entity.boss_kind then kinds[entity.boss_kind]=true end end;assert(kinds.volibear_prestige and kinds.navira,'Both selected bosses must be present');collectgarbage();collectgarbage();note('before-F1-two-bosses')`);
 }
 fs.writeFileSync(dir+'/main.lua',main);
 fs.writeFileSync(dir+'/conf.lua',`function love.conf(t) t.identity='KRFL_RAM_compare_${name}';t.window.width=64;t.window.height=64;t.window.visible=false;t.console=false;t.modules.joystick=false;t.modules.physics=false end\n`);
}
console.log('Prepared isolated probes with read-only save copies.');
