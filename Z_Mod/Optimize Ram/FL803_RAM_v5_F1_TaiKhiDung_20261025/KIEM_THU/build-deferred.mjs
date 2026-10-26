import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
const root='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const task='D:/CodexTemp/KRFL_RAM_803_805_20261025';
const files=['all/director.lua','all-desktop/game_gui.lua','lib/klove/image_db.lua'];
for(const file of files){const dest=task+'/before/'+file;fs.mkdirSync(path.dirname(dest),{recursive:true});if(!fs.existsSync(dest))fs.copyFileSync(root+'/'+file,dest);}
let director=fs.readFileSync(root+'/all/director.lua','utf8');
function replaceOnce(source,from,to){assert.equal(source.split(from).length,2,'Unique replacement: '+from.slice(0,80));return source.replace(from,to);}
director=replaceOnce(director,'\t\tlocal sc_branch_loaded = false','\t\tgame.deferred_cheat_textures = {}\n\t\tgame.deferred_cheat_scale_textures = {}\n\n\t\tlocal sc_branch_loaded = false');
function deferBlock(start,end){const a=director.indexOf(start),b=director.indexOf(end,a+start.length);assert(a>=0&&b>a);const s=director.slice(a,b).replaceAll('game.scale_required_textures','game.deferred_cheat_scale_textures').replaceAll('game.required_textures','game.deferred_cheat_textures');director=director.slice(0,a)+s+director.slice(b);}
deferBlock('\t\t\tif not nostalgic_classic and user_data.liuhui.cheathero then','\t\t\t-- SC Reset');
deferBlock('\t\t\tif not nostalgic_classic and user_data.liuhui.cheat5 == true then','\t\t\tif args.level_idx == 5 then');
// Menu icons stay available before any cheat is purchased.
director=replaceOnce(director,'table.insert(game.deferred_cheat_textures, "gui_common_5_D")','table.insert(game.required_textures, "gui_common_5_D")');
director=replaceOnce(director,'table.insert(game.deferred_cheat_textures, "rebborn_hero_summon_icons")','table.insert(game.required_textures, "rebborn_hero_summon_icons")');
const method=`function director:load_deferred_cheat_textures(game)
\tlocal normal = game.deferred_cheat_textures or {}
\tlocal scaled = game.deferred_cheat_scale_textures or {}
\tif #normal == 0 and #scaled == 0 then return end

\t-- shortcut: load F1 art together on first purchase; split by menu if this load stays too large.
\tself:load_texture_groups(replace_locale(normal), self.params.texture_size, game.ref_res, true, "game")
\tself:load_texture_groups(replace_locale(scaled), self.params.texture_size, game.ref_res * TEXTURE_SIZE_FACTOR.kr_45, true, "game")
\tG.push("all")
\twhile not I:queue_load_done() do
\t\tlove.event.pump()
\t\tG.setCanvas()
\t\tG.origin()
\t\tG.setScissor()
\t\tG.clear()
\t\tgame:draw()
\t\tlocal w, h = G.getWidth(), G.getHeight()
\t\tG.origin()
\t\tG.setScissor()
\t\tG.setColor(0, 0, 0, 220)
\t\tG.rectangle("fill", 0, h - 60, w, 60)
\t\tG.setColor(255, 255, 255, 255)
\t\tG.rectangle("fill", 20, h - 25, (w - 40) * I.progress, 8)
\t\tG.present()
\t\tlove.timer.sleep(0.001)
\tend
\tG.pop()
\tlove.timer.step()
\ttable.append(game.required_textures, normal)
\ttable.append(game.scale_required_textures, scaled)
\tgame.deferred_cheat_textures = nil
\tgame.deferred_cheat_scale_textures = nil
end

`;
director=replaceOnce(director,'function director:load_texture_groups(',method+'function director:load_texture_groups(');
let gui=fs.readFileSync(root+'/all-desktop/game_gui.lua','utf8');
const at=gui.indexOf('function TowerMenuButton:on_click()');assert(at>=0);
let click=gui.slice(at);
click=replaceOnce(click,'\tself:disable()\n\n\tlocal inhibit_sounds = false','\tif item.action == "tw_upgrade" and (item.action_arg == "Goldfinger" or item.action_arg == "g5_special_buy" or item.action_arg == "tower_hero_buy_e") then\n\t\trequire("director"):load_deferred_cheat_textures(game_gui.game)\n\tend\n\n\tself:disable()\n\n\tlocal inhibit_sounds = false');
gui=gui.slice(0,at)+click;
for(const [file,source] of [['all/director.lua',director],['all-desktop/game_gui.lua',gui]]){const dest=task+'/candidate/'+file;fs.mkdirSync(path.dirname(dest),{recursive:true});fs.writeFileSync(dest,source);}
console.log('Staged deferred F1 texture loading; live files untouched.');
