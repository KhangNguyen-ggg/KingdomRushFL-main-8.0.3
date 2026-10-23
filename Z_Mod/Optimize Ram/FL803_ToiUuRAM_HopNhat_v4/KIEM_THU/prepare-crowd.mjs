import fs from 'node:fs';
const task='D:/CodexTemp/KRFL_RAM_v4_20261023';
let s=fs.readFileSync(task+'/full/main.lua','utf8');
s=s.replace("slot.liuhui_hero=slot.liuhui_hero or {}",`slot.liuhui=slot.liuhui or {}
  slot.liuhui.cheat=true
  for _,key in ipairs({'cheat5','cheat6','cheathero','cheat5_dragon','cheat5_special'})do slot.liuhui[key]=false end
  slot.liuhui_hero=slot.liuhui_hero or {}`);
s=s.replace("if game_frames==100 then",`if completed==0 and game_frames==10 then
    local E=require('entity_db');local P=require('path_db')
    game.store.lives=10000
    for i=1,160 do local e=E:create_entity('enemy_giant_rat');e.nav_path.pi=1;e.nav_path.spi=1;e.nav_path.ni=P:get_start_node(1)+(i%50);game.simulation:queue_insert_entity(e)end
   end
   if completed==0 and game_frames==60 then
    local n=0;for _,e in pairs(game.store.entities)do if e.enemy then n=n+1 end end
    assert(n>=150,'Crowd fixture failed to spawn')
    observations[#observations+1]=string.format('crowd: %d live enemy entities rendered/updated with 9 bosses',n)
   end
   if completed==0 and game_frames==600 then
    for _,e in pairs(game.store.entities)do if e.enemy then e.health.dead=true;game.simulation:queue_remove_entity(e)end end
   end
   if (completed==0 and game_frames==620) or (completed>0 and game_frames==100) then`);
s=s.replace('if game_frames==120 then','if (completed==0 and game_frames==640) or (completed>0 and game_frames==120) then');
s=s.replace('Current slot 2 configuration read-only.','Isolated slot 2 copy: first-three-generation tower cheat enabled; extra generation 5/6 and extra hero/dragon cheats disabled for this test only.');
fs.writeFileSync(task+'/full/main.lua',s);
let monitor=fs.readFileSync(task+'/run-probe.ps1','utf8').replace('$freeCommit -lt 262144','$freeCommit -lt 1048576');
fs.writeFileSync(task+'/run-probe.ps1',monitor);
