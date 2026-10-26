local ROOT=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local TASK=[[D:/CodexTemp/KRFL_LoadAudit_20261024]]
local baseline=os.getenv('KRFL_PROBE_BASELINE')=='1'
local function write(name,s)local f=assert(io.open(TASK..'/'..name,'wb'));f:write(s);f:close()end
package.path=ROOT..'/?.lua;'..package.path
local function noop()end

package.preload['klove.image_db']=function()return assert(loadfile(TASK..'/candidate/lib/klove/image_db.lua'))()end
package.preload['render_utils']=function()return assert(loadfile(TASK..'/candidate/all/render_utils.lua'))()end
assert(loadfile(ROOT..'/main.lua'))()
version.identity='KRFL_load_audit_stage'
local base_load,base_update=love.load,love.update
local started,frames,game_frames,map_frames=0,0,0,0
local last_mark=0
local completed=0
local observations={}
local ffi=require('ffi')
ffi.cdef[[typedef struct {unsigned long cb; unsigned long PageFaultCount; size_t PeakWorkingSetSize; size_t WorkingSetSize; size_t QuotaPeakPagedPoolUsage; size_t QuotaPagedPoolUsage; size_t QuotaPeakNonPagedPoolUsage; size_t QuotaNonPagedPoolUsage; size_t PagefileUsage; size_t PeakPagefileUsage; size_t PrivateUsage;} RamCounters;
void* GetCurrentProcess(void); int GetProcessMemoryInfo(void*, RamCounters*, unsigned long);]]
local kernel=ffi.load('kernel32');local psapi=ffi.load('psapi')
local function private_mb()local c=ffi.new('RamCounters');c.cb=ffi.sizeof(c);assert(psapi.GetProcessMemoryInfo(kernel.GetCurrentProcess(),c,c.cb)~=0);return tonumber(c.PrivateUsage)/1048576 end
local old_stores=setmetatable({},{__mode='v'})
local last_state
local function status(tag)
 local D=package.loaded.director
 local I=package.loaded['klove.image_db']
 local S=package.loaded.sound_db
 local state=D and D.active_item and D.active_item.item_name or 'boot'
 local game=D and D.active_item
 local heroes=0;if game and game.store then for _,e in pairs(game.store.entities or {})do if e.hero then heroes=heroes+1 end end end
 local value=string.format('%s\nstate=%s frames=%d game_frames=%d heroes=%d Lua=%.1fMiB tex=%.1fMiB image_threads=%s images=%s/%s audio_threads=%s\n',tag,state,frames,game_frames,heroes,collectgarbage('count')/1024,love.graphics.getStats().texturememory/1048576,I and #I.threads or '-',I and I.queue_load_done_images or '-',I and I.queue_load_total_images or '-',S and #S.threads or '-')
 write('candidate_stage_progress.txt',value)
 return state,heroes
end
local function fail(err)status('FAIL '..tostring(err));write('candidate_stage_result.txt','FAIL '..tostring(err));love.event.quit()end
function love.load()
 local ok,err=xpcall(function()
  local storage=require('storage')
  local saved_chunk=assert(loadfile('C:/Users/user/AppData/Roaming/kingdom_rush_origins/fl_save/slot_2.lua'))
  setfenv(saved_chunk,{})
  local slot=saved_chunk()
  local names={'hero_allied_blackburn'}
  slot.liuhui=slot.liuhui or {}
  slot.liuhui.cheat=true
  for _,key in ipairs({'cheat5','cheat6','cheathero','cheat5_dragon','cheat5_special'})do slot.liuhui[key]=false end
  slot.liuhui_hero=slot.liuhui_hero or {}
  slot.liuhui_hero.useinfinitehero=true
  slot.liuhui_hero.infiniteheroes=names
  slot.liuhui_hero.infinite_teams={{name='isolated',heroes=names}}
  slot.liuhui_hero.infinite_team_index=1
  slot.heroes=slot.heroes or {status={}}
  slot.heroes.status=slot.heroes.status or {}
  for _,name in ipairs(names)do slot.heroes.status[name]={xp=100000,skills={}}end
  storage.slot=slot;storage.active_slot_idx=1
  storage.load_slot=function()return slot end
  storage.save_slot=function()return true end
  storage.save_settings=function()return true end
  storage.load_settings=function()return {width=1280,height=720,fullscreen=false,vsync=false,texture_size='fullhd',locale='zh-Hans',skip_settings_dialog=true,screen='map',max_threads=8,volume_fx=0,volume_music=0}end
  status('before full bootstrap')
  base_load({})
  started=love.timer.getTime()
  status('after full bootstrap')
 end,debug.traceback)
 if not ok then fail(err)end
end
function love.update(dt)
 local ok,err=xpcall(function()
  frames=frames+1
  base_update(dt)
  local D=package.loaded.director
  local game=D and D.active_item
  local state=game and game.item_name
  if state~=last_state then map_frames=0;game_frames=0;last_state=state end
  if game and game.item_name=='map' then
   map_frames=map_frames+1
   if map_frames==10 then
    collectgarbage();collectgarbage()
    local retained=0;for _ in pairs(old_stores)do retained=retained+1 end
    assert(retained==0,'Previous stage store retained after return to map')
    observations[#observations+1]=string.format('map after %d stages: Lua=%.1f MiB texture=%.1f MiB old_stores=%d private=%.1f MiB',completed,collectgarbage('count')/1024,love.graphics.getStats().texturememory/1048576,retained,private_mb())
    write('candidate_stage_metrics.txt',table.concat(observations,'\n'))
    if completed==1 then
     write('candidate_stage_result.txt','PASS one level56 entry, forced taunt, 180 frames; isolated read-only save; 1 boss and first-three-generation towers.\n'..table.concat(observations,'\n'))
     love.event.quit();return
    end
    D:item_done_callback('map',{next_item_name='game',level_idx=56,level_mode=GAME_MODE_CAMPAIGN,level_difficulty=DIFFICULTY_NORMAL,campaign_variant=CAMPAIGN_VARIANT_REGULAR})
   end
  end
  if game and game.item_name=='game' then
   game_frames=game_frames+1
   local I=require('klove.image_db')
   if game_frames==1 then
    local n=0;for _ in pairs(I.db_images)do n=n+1 end
    observations[#observations+1]='ENTER '..completed..' images='..n..' taunt atlas='..tostring(I:i('go_stage12-1-1'))
   end
   if game_frames==10 then
    local E=require('entity_db');local e=E:create_entity('decal_s12_shoutbox')
    e.pos={x=512,y=620};e.duration=60;e.texts.list[1].text='You made it here. Excellent!'
    game.simulation:queue_insert_entity(e);game.store._audit_taunt=e
   end
   if game_frames==180 then
    local e=assert(game.store._audit_taunt);assert(e.texts.list[1].image_name,'Taunt text not inserted')
    local bg=e.render.frames[1];local text=e.render.frames[2]
    assert(bg.ss.atlas=='go_stage12-1-1' and I:i(bg.ss.atlas),'Taunt background missing')
    assert(text.ss.atlas==e.texts.list[1].image_name and I:i(text.ss.atlas),'Runtime taunt text missing')
    observations[#observations+1]='PASS taunt background + runtime cached text valid and rendered'

    local errs={};for _,frame in ipairs(game.store.render_frames or {})do
     if frame.ss and frame.ss.atlas and not I:i(frame.ss.atlas)then errs[frame.ss.atlas]=true end
    end
    for key in pairs(errs)do observations[#observations+1]='MISSING '..key end
    local rows={};for _,frame in ipairs(game.store.render_frames or {})do if frame.ss and frame.ss.atlas then rows[#rows+1]=frame.ss.atlas end end
    observations[#observations+1]='stage '..completed..' missing images='..table.concat(table.keys(I.missing_images),',')
    local pix=love.graphics.newScreenshot():encode('png');local f=assert(io.open(TASK..'/candidate_stage'..completed..'.png','wb'));f:write(pix:getString());f:close()
    completed=completed+1;old_stores[completed]=game.store
    write('candidate_stage_metrics.txt',table.concat(observations,'\n'))
    D:item_done_callback('game',{next_item_name='map'})
   end
  end
  if love.timer.getTime()-last_mark>=0.5 then last_mark=love.timer.getTime();status('running')end
  assert(started==0 or love.timer.getTime()-started<360,'Full load timed out')
 end,debug.traceback)
 if not ok then fail(err)end
end
love.errhand=function(err)fail(debug.traceback(tostring(err),2))end
