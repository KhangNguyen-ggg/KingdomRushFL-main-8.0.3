local ROOT=[[D:/CodexTemp/KRFL_RAM_803_805_20261025/source803]]
local TASK=[[D:/CodexTemp/KRFL_RAM_803_805_20261025/deferred803]]
local canvas=true
local function write(name,s)local f=assert(io.open(TASK..'/'..name,'wb'));f:write(s);f:close()end
package.path=ROOT..'/?.lua;'..package.path
package.preload['director']=function()return assert(loadfile('D:/CodexTemp/KRFL_RAM_803_805_20261025/candidate/all/director.lua'))()end
package.preload['game_gui']=function()return assert(loadfile('D:/CodexTemp/KRFL_RAM_803_805_20261025/candidate/all-desktop/game_gui.lua'))()end
package.preload['klove.image_db']=function()return assert(loadfile('D:/CodexTemp/KRFL_RAM_803_805_20261025/candidate/lib/klove/image_db.lua'))()end
assert(loadfile(ROOT..'/main.lua'))()
version.identity='KRFL_RAM_compare_'..TASK:match('[^/]+$')
local base_load,base_update=love.load,love.update
local started,last_state,game_frames,map_frames,completed=0,nil,0,0,0
local observations={}
local ffi=require('ffi')
ffi.cdef[[typedef struct {unsigned long cb; unsigned long PageFaultCount; size_t PeakWorkingSetSize; size_t WorkingSetSize; size_t QuotaPeakPagedPoolUsage; size_t QuotaPagedPoolUsage; size_t QuotaPeakNonPagedPoolUsage; size_t QuotaNonPagedPoolUsage; size_t PagefileUsage; size_t PeakPagefileUsage; size_t PrivateUsage;} RamCounters; void* GetCurrentProcess(void); int GetProcessMemoryInfo(void*, RamCounters*, unsigned long);]]
local kernel,psapi=ffi.load('kernel32'),ffi.load('psapi')
local function note(tag)
 local c=ffi.new('RamCounters');c.cb=ffi.sizeof(c);assert(psapi.GetProcessMemoryInfo(kernel.GetCurrentProcess(),c,c.cb)~=0)
 local I=package.loaded['klove.image_db'];local n,canvases=0,0
 if I then for _,v in pairs(I.db_images)do if v[1]then n=n+1;if v[1]:typeOf('Canvas')then canvases=canvases+1 end end end end
 local s=string.format('%s lua=%.1f texture=%.1f private=%.1f working=%.1f images=%d canvases=%d seconds=%.2f',tag,collectgarbage('count')/1024,love.graphics.getStats().texturememory/1048576,tonumber(c.PrivateUsage)/1048576,tonumber(c.WorkingSetSize)/1048576,n,canvases,love.timer.getTime()-started)
 observations[#observations+1]=s;write('metrics.txt',table.concat(observations,'\n'));print(s)
end
local function fail(err)write('result.txt','FAIL '..tostring(err));love.event.quit()end
function love.load()
 local ok,err=xpcall(function()
  local storage=require('storage')
  local chunk=assert(loadfile('C:/Users/user/AppData/Roaming/kingdom_rush_origins/fl_save/slot_2.lua'));setfenv(chunk,{})
  local slot=chunk();slot_for_audit=slot
  -- Match the same official hero and F1 resource flags in both versions.
  slot.liuhui_hero.useinfinitehero=false;slot.liuhui_hero.usedoublehero=false;slot.heroes.selected='hero_catha'
  storage.slot=slot;storage.active_slot_idx=1
  storage.load_slot=function()return slot end;storage.save_slot=function()return true end;storage.save_settings=function()return true end
  storage.load_settings=function()return {width=1280,height=720,fullscreen=false,vsync=false,texture_size='fullhd',locale='zh-Hans',skip_settings_dialog=true,screen='map',max_threads=8,volume_fx=0,volume_music=0,image_db_uses_canvas=canvas}end
  started=love.timer.getTime();base_load({})
  assert(main.params.image_db_uses_canvas==canvas,'Canvas override not applied')
  local I=require('klove.image_db');local original=I.queue_load_atlas
  local requested={}
  I.queue_load_atlas=function(self,scale,path,name)requested[#requested+1]={scale=scale,path=path,name=name};return original(self,scale,path,name)end
  _G.audit_requested=requested
 end,debug.traceback)
 if not ok then fail(err)end
end
function love.update(dt)
 local ok,err=xpcall(function()
  base_update(dt)
  local D=package.loaded.director;local item=D and D.active_item;local state=item and item.item_name
  if state~=last_state then last_state=state;map_frames=0;game_frames=0 end
  if state=='map'then
   map_frames=map_frames+1
   if map_frames==20 then
    collectgarbage();collectgarbage();note('map'..completed)
    if completed==1 then write('result.txt','PASS same stage56, same official hero/F1, 180 game updates/draws and return to map. Save writes disabled.\n'..table.concat(observations,'\n'));love.event.quit();return end
    audit_requested={};local I=require('klove.image_db');local original=I.queue_load_atlas
    I.queue_load_atlas=function(self,scale,path,name)audit_requested[#audit_requested+1]={scale=scale,path=path,name=name};return original(self,scale,path,name)end
    D:item_done_callback('map',{next_item_name='game',level_idx=56,level_mode=GAME_MODE_CAMPAIGN,level_difficulty=DIFFICULTY_NORMAL,campaign_variant=CAMPAIGN_VARIANT_REGULAR})
   end
  elseif state=='game'then
   game_frames=game_frames+1
   if game_frames==1 then
    note('stage-entry')
    local rows={};for _,r in ipairs(audit_requested)do rows[#rows+1]=r.name..'\t'..r.scale end;write('requested.tsv',table.concat(rows,'\n'))
    local I=require('klove.image_db');rows={};for key,v in pairs(I.db_images)do if v[1]then rows[#rows+1]=string.format('%s\t%d\t%d\t%s',key,v[2],v[3],v[1]:type())end end;table.sort(rows);write('loaded.tsv',table.concat(rows,'\n'))
   end
   if game_frames==30 then
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
    local basekeys={};local lite=assert(io.open('D:/CodexTemp/KRFL_RAM_803_805_20261025/lite803/loaded.tsv','rb'));for line in lite:lines()do basekeys[line:match('^([^\t]+)')]=true end;lite:close()
    local baseline=assert(io.open('D:/CodexTemp/KRFL_RAM_803_805_20261025/baseline803/loaded.tsv','rb'));for line in baseline:lines()do local key=line:match('^([^\t]+)');if not basekeys[key]then assert(I:i(key),'F1 did not restore original image '..key)end end;baseline:close()
    local count=0;for _ in pairs(I.atlas_uses)do count=count+1 end
    D:load_deferred_cheat_textures(item)
    local after=0;for _ in pairs(I.atlas_uses)do after=after+1 end;assert(count==after,'Second F1 load retained another owner')
    collectgarbage();collectgarbage();note('after-F1')
   end
   if game_frames==180 then
    local I=require('klove.image_db');assert(not next(I.missing_images),'Missing loaded image')
    collectgarbage();collectgarbage();note('stage-steady')
    local data=love.graphics.newScreenshot():encode('png');write('stage.png',data:getString())
    completed=completed+1;D:item_done_callback('game',{next_item_name='map'})
   end
  end
  assert(love.timer.getTime()-started<350,'Probe timeout')
 end,debug.traceback)
 if not ok then fail(err)end
end
love.errhand=function(err)fail(debug.traceback(tostring(err),2))end
