local M={preview=nil,current=nil}
local S=require('sound_db')
local tracks={KRFLRenTheme='tunetank-china-chinese-asian-music-349489.mp3',KRFLJadeTheme='tunetank-china-chinese-epic-music-348422.mp3'}
local function has_ren(item)
 if not item then return false end
 local store=item.store
 if store then
  local actual_heroes=0
  for _,e in pairs(store.entities or {}) do if e.hero then actual_heroes=actual_heroes+1;if e.template_name=='hero_jade_ren' then return true end end end
  if actual_heroes>0 then return false end
  for _,h in ipairs(store.main_heroes or {}) do if h.template_name=='hero_jade_ren' then return true end end
  if store.main_hero and store.main_hero.template_name=='hero_jade_ren' then return true end
  if store.main1_hero and store.main1_hero.template_name=='hero_jade_ren' then return true end
 end
 local data=item.user_data or store and store.user_data
 if not data then return false end
 if data.liuhui_hero and data.liuhui_hero.usedoublehero then
  local heroes=require('data.map_data').hero_data
  for _,idx in ipairs(data.liuhui_hero.herolist or {}) do if heroes[idx] and heroes[idx].name=='hero_jade_ren' then return true end end
  return false
 end
 return data.heroes and data.heroes.selected=='hero_jade_ren'
end
function M.install()
 if S._ren_music_installed then return end
 S._ren_music_installed=true
 for id,file in pairs(tracks) do
  S.sounds[id]={files={file},source_group='MUSIC',stream=true,loop=true,gain=.8}
  S.sound_extras[id]={}
 end
 S.groups.krfl_ren_music={sounds={'KRFLRenTheme','KRFLJadeTheme'}}
 local original=S.queue
 S.queue=function(self,id,options)
  if type(id)=='string' and (id:match('^Music') or tracks[id]) then
   M.last_regular=not tracks[id] and id or M.last_regular
   local director=package.loaded.director
   local item=director and director.active_item
   local battle=id:match('^MusicBattle') or item and item.item_name=='game'
   local ren
   if battle then ren=has_ren(item) else ren=M.preview end
   if ren==nil then ren=has_ren(item) end
   local regular=tracks[id] and (M.last_regular or 'MusicMap') or id
   local chosen=ren and (battle and 'KRFLJadeTheme' or 'KRFLRenTheme') or regular
   if tracks[chosen] then
    if not self.sources[tracks[chosen]] then self:load_group('krfl_ren_music') end
    local stopping=false
    for _,request in ipairs(self.stop_queue) do
     if request.gid=='MUSIC' or request.id==chosen then stopping=true;break end
    end
    if M.current==chosen and self:sound_is_playing(chosen) and not stopping then return end
    -- Only the latest music request may survive a map/wave transition.
    for i=#self.request_queue,1,-1 do
     local request=self.request_queue[i]
     if request.options and request.options.source_group=='MUSIC' then table.remove(self.request_queue,i) end
    end
    self:stop_group('MUSIC');M.current=chosen
    return original(self,chosen,options)
   elseif M.current then
    for i=#self.request_queue,1,-1 do
     local request=self.request_queue[i]
     if request.options and request.options.source_group=='MUSIC' then table.remove(self.request_queue,i) end
    end
    self:stop_group('MUSIC');M.current=nil
   end
  end
  return original(self,id,options)
 end
end
function M.sync_battle(store)
 if not store or not store.entities then return end
 if M.scan_store==store and store.tick_ts<(M.scan_at or 0) then return end
 M.scan_store=store;M.scan_at=store.tick_ts+.5
 local present,count=false,0
 for _,e in pairs(store.entities) do
  if e.hero then count=count+1;if e.template_name=='hero_jade_ren' then present=true end end
 end
 if count==0 then return end
 if M.battle_store==store and M.battle_ren==present then return end
 M.battle_store=store;M.battle_ren=present
 local id=M.last_regular
 if not id or not id:match('^MusicBattle') then id=string.format('MusicBattlePrep_%02d',store.level_idx) end
 S:queue(id)
end
function M.select(ren)
 M.install();M.preview=ren;S:queue('MusicMap')
end
function M.close_preview()
 M.preview=nil;S:queue('MusicMap')
end
return M
