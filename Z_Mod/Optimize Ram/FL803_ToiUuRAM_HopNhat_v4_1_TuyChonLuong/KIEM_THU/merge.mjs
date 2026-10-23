import fs from 'node:fs';import path from 'node:path';import cp from 'node:child_process';import crypto from 'node:crypto';
const root='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const task='D:/CodexTemp/KRFL_RAM_v4_20261023';
const hashes={};
for(const f of ['all/game.lua','all/systems.lua','all/exoskeleton.lua','all/director.lua','dove_modules/perf/memory_guard.lua'])hashes[f]=crypto.createHash('sha256').update(fs.readFileSync(root+'/'+f)).digest('hex');
fs.writeFileSync(task+'/memoryopt-live-hashes.json',JSON.stringify(hashes,null,2));
function put(file,s){fs.mkdirSync(path.dirname(task+'/candidate/'+file),{recursive:true});fs.writeFileSync(task+'/candidate/'+file,s);}
for(const file of ['all/game.lua','all/systems.lua','all/exoskeleton.lua','all/gg_views.lua','all/sound_db.lua','all-desktop/game_gui.lua','all-desktop/screen_map.lua','lib/klove/kui.lua','lib/hump/signal.lua']){
 let s=fs.readFileSync(root+'/Z_Mod/FL803_ToiUuRAM_DonStage_v2/CAP_NHAT/'+file,'utf8');
 if(file==='all/game.lua')s=s.replace('function game:restart()','function game:restart()\n\trequire("systems").texts:clear_cache()').replace('\tRU.destroy()','\tRU.destroy()\n\trequire("systems").texts:clear_cache()');
 if(file==='all/systems.lua'){
  const start=s.indexOf('sys.texts = {}'),end=s.indexOf('sys.particle_system = {}',start);if(start<0||end<0)throw Error('texts section missing');
  s=s.slice(0,start)+fs.readFileSync(task+'/text-cache.lua','utf8')+'\n'+s.slice(end);
 }
 put(file,s);
}
put('all/main_utils.lua',fs.readFileSync(root+'/all/main_utils.lua'));
// director had no changes before MemoryOpt; preserve the tested lifecycle implementation.
put('all/director.lua',cp.execFileSync('git',['show','HEAD:all/director.lua'],{cwd:root}));
console.log('Combined v2/v3 with v4 and bounded text reuse; live game untouched.');
