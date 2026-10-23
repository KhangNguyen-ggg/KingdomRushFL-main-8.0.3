import fs from 'node:fs';
const root='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const task='D:/CodexTemp/KRFL_RAM_v4_20261023';
const old='D:/CodexTemp/KRFL_Boss9_Crash_20261022';
fs.mkdirSync(task+'/full',{recursive:true});
for(const dir of ['all','all-desktop','kr3','kr3-desktop','lib','dove_modules'])if(!fs.existsSync(task+'/full/'+dir))fs.symlinkSync(root+'/'+dir,task+'/full/'+dir,'junction');
for(const e of fs.readdirSync(old+'/full',{withFileTypes:true}))if(e.isFile()&&e.name!=='main.lua')fs.copyFileSync(old+'/full/'+e.name,task+'/full/'+e.name);
let s=fs.readFileSync(old+'/full/main.lua','utf8').replaceAll(old,task).replaceAll('KRFL_boss9_full_isolated','KRFL_ram_v4_isolated');
s=s.replace(/package.preload\['klove.image_db'\][^\n]+\npackage.preload\['main_utils'\][^\n]+/,'');
const preloads=['klove.image_db','klove.font_db','klove.sso'].map(name=>`package.preload['${name}']=function()return assert(loadfile((baseline and ROOT or TASK..'/candidate')..'/lib/${name.replaceAll('.','/')}.lua'))()end`).join('\n');
const otherFiles=['all/game.lua','all/systems.lua','all/exoskeleton.lua','all/gg_views.lua','all/sound_db.lua','all/main_utils.lua','all/director.lua','all-desktop/game_gui.lua','all-desktop/screen_map.lua','lib/hump/signal.lua','lib/klove/kui.lua'];
const otherPreloads=otherFiles.map(file=>{const name=file.replace(/^(all|all-desktop|lib)\//,'').replace(/\.lua$/,'').replaceAll('/','.');return `package.preload['${name}']=function()return assert(loadfile(TASK..'/candidate/${file}'))()end`;}).join('\n');
s=s.replace("assert(loadfile(ROOT..'/main.lua'))()",preloads+'\n'+otherPreloads+"\nassert(loadfile(ROOT..'/main.lua'))()");
s=s.replace("if baseline then write('full_result.txt','BASELINE PASS one entry into level 87 with 9 bosses');love.event.quit();return end",'');
s=s.replace("if game_frames==120 then",`if game_frames==100 then
    game.store.level.update=nil;game.store.level.co=nil;game.store.level.run_complete=true;game.store.waves_finished=true
    require('systems').level:on_update(0,game.store.tick_ts,game.store)
    assert(game.store.game_outcome,'Victory path was not triggered')
   end
   if game_frames==120 then`);
s=s.replace('120 updates/draws per entry,','120 updates/draws and a forced victory path per entry,');
s=s.replace('<220','<360');
s=s.replace('completed==3','completed==6').replace('PASS 3 real entries','PASS 6 real entries').replace('max_threads=8','max_threads=4');
s=s.replace('local observations={}',`local observations={}
local ffi=require('ffi')
ffi.cdef[[typedef struct {unsigned long cb; unsigned long PageFaultCount; size_t PeakWorkingSetSize; size_t WorkingSetSize; size_t QuotaPeakPagedPoolUsage; size_t QuotaPagedPoolUsage; size_t QuotaPeakNonPagedPoolUsage; size_t QuotaNonPagedPoolUsage; size_t PagefileUsage; size_t PeakPagefileUsage; size_t PrivateUsage;} RamCounters;
void* GetCurrentProcess(void); int GetProcessMemoryInfo(void*, RamCounters*, unsigned long);]]
local kernel=ffi.load('kernel32');local psapi=ffi.load('psapi')
local function private_mb()local c=ffi.new('RamCounters');c.cb=ffi.sizeof(c);assert(psapi.GetProcessMemoryInfo(kernel.GetCurrentProcess(),c,c.cb)~=0);return tonumber(c.PrivateUsage)/1048576 end`);
s=s.replace("old_stores=%d',completed,collectgarbage('count')/1024,love.graphics.getStats().texturememory/1048576,retained)","old_stores=%d private=%.1f MiB',completed,collectgarbage('count')/1024,love.graphics.getStats().texturememory/1048576,retained,private_mb())");
fs.writeFileSync(task+'/full/main.lua',s);
fs.writeFileSync(task+'/full/conf.lua',fs.readFileSync(old+'/full/conf.lua','utf8').replaceAll('KRFL_boss9_full_isolated','KRFL_ram_v4_isolated'));
let monitor=fs.readFileSync(old+'/run-probe.ps1','utf8').replaceAll(old.replaceAll('/','\\'),task.replaceAll('/','\\')).replace("$helper=Join-Path $taskRoot 'runtime\\love-probe.exe'",`$helper='${old.replaceAll('/','\\')}\\runtime\\love-probe.exe'`).replace('-gt 240','-gt 390');
monitor=monitor.replace("if($process.PrivateMemorySize64 -gt", "$freeCommit=(Get-CimInstance Win32_OperatingSystem).FreeVirtualMemory\n if($freeCommit -lt 262144 -or $process.PrivateMemorySize64 -gt");
fs.writeFileSync(task+'/run-probe.ps1',monitor);
console.log('Prepared separate full game test with read-only user save.');
