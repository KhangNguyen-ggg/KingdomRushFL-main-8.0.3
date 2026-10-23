local ROOT=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local TASK=[[D:/CodexTemp/KRFL_RAM_v4_20261023]]
local results={}
local function write(s)local f=assert(io.open(TASK..'/cache-check-result.txt','wb'));f:write(s);f:close()end
local function pass(s)results[#results+1]='PASS '..s end
local function read(file)local f=assert(io.open(file,'rb'));local s=f:read('*a');f:close();return s end
local function section(file,a,b,env)
 local s=read(file);local first=assert(s:find(a,1,true));local last=assert(s:find(b,first+1,true))
 local chunk=assert(loadstring(s:sub(first,last-1)));setfenv(chunk,setmetatable(env,{__index=_G}));chunk()
end
function love.load()
 local ok,err=xpcall(function()
  package.path=ROOT..'/lib/?.lua;'..ROOT..'/all/?.lua;'..ROOT..'/?.lua;'..package.path
  require('klua.table');require('klua.log').level=require('klua.log').OFF_LEVEL
  local files={'all/game.lua','all/systems.lua','all/exoskeleton.lua','all/gg_views.lua','all/sound_db.lua','all/main_utils.lua','all/director.lua','all-desktop/game_gui.lua','all-desktop/screen_map.lua','lib/hump/signal.lua','lib/klove/kui.lua','lib/klove/image_db.lua','lib/klove/font_db.lua','lib/klove/sso.lua'}
  for _,f in ipairs(files)do assert(loadfile(TASK..'/candidate/'..f))end
  pass('All 14 cumulative payload files compile in bundled LuaJIT')
  local I={db_images={}};local creates=0
  function I:add_image(name,image)assert(not self.db_images[name]);self.db_images[name]=image end
  function I:remove_image(name)self.db_images[name]=nil end
  local F={}
  function F:create_text_image(text,size,alignment,font,font_size,color,line_height,scale)
   creates=creates+1;size.x=size.x/(scale or 1)
   local w=text=='HUGE' and 4096 or text:match('^LARGE') and 512 or 64;local h=text=='HUGE' and 4096 or text:match('^LARGE') and 512 or 32
   return {getDimensions=function()return w,h end}
  end
  local sys={}
  section(TASK..'/candidate/all/systems.lua','sys.texts = {}','sys.particle_system = {}',{sys=sys,I=I,F=F})
  local store={tick=1,screen_scale=2}
  local function entity(text,color)
   return {id=1,render={sprites={{}}},texts={list={{sprite_id=1,text=text,size={x=128,y=64},alignment='center',font_name='body',font_size=18,color=color or {255,255,255,255}}}}}
  end
  for i=1,1000 do local e=entity('120');sys.texts:on_insert(e,store);assert(e.texts.list[1].size.x==128);sys.texts:on_remove(e,store)end
  assert(creates==1,'Equal text/color values did not reuse texture')
  local a,b=entity('120'),entity('120',{254,255,255,255});sys.texts:on_insert(a,store);sys.texts:on_insert(b,store)
  assert(a.texts.list[1].image_name~=b.texts.list[1].image_name,'Different colors share texture')
  sys.texts:on_remove(a,store);assert(I.db_images[b.texts.list[1].image_name]);sys.texts:on_remove(b,store)
  pass('1000 equal text events use one texture; different colors stay separate; render scaling does not mutate entity size')
  sys.texts:clear_cache();assert(next(I.db_images)==nil)
  local active={}
  for i=1,128 do active[i]=entity('active '..i);sys.texts:on_insert(active[i],store)end
  local extra=entity('uncached');sys.texts:on_insert(extra,store);assert(not extra.texts.list[1].image_cache_key)
  for _,e in ipairs(active)do assert(I.db_images[e.texts.list[1].image_name],'Live texture evicted at capacity')end
  local ename=extra.texts.list[1].image_name;sys.texts:on_remove(extra,store);assert(not I.db_images[ename])
  for _,e in ipairs(active)do sys.texts:on_remove(e,store)end
  local count=0;for _ in pairs(I.db_images)do count=count+1 end;assert(count==128)
  for i=1,500 do local e=entity('new '..i);sys.texts:on_insert(e,store);sys.texts:on_remove(e,store)end
  count=0;for _ in pairs(I.db_images)do count=count+1 end;assert(count==128,'Cache exceeds count limit')
  local huge=entity('HUGE');sys.texts:on_insert(huge,store);assert(not huge.texts.list[1].image_cache_key)
  local hname=huge.texts.list[1].image_name;sys.texts:on_remove(huge,store);assert(not I.db_images[hname])
  sys.texts:clear_cache();assert(next(I.db_images)==nil)
  pass('128-entry limit preserves all active textures, evicts only unused entries, bypasses oversized text and clears on exit')
  for i=1,30 do local e=entity('LARGE '..i);sys.texts:on_insert(e,store);sys.texts:on_remove(e,store)end
  count=0;for _ in pairs(I.db_images)do count=count+1 end;assert(count==8,'Texture byte limit not enforced')
  sys.texts:clear_cache();assert(next(I.db_images)==nil)
  pass('8 MiB pixel-data budget evicts unused large text before reaching the count limit')
  local signal=assert(loadfile(TASK..'/candidate/lib/hump/signal.lua'))()
  local SSO=assert(loadfile(TASK..'/candidate/lib/klove/sso.lua'))()
  local simulation={};local exo={unload_all=function()end};local rally={clear_state=function()end};local game={}
  local env={game=game,signal=signal,SSO=SSO,simulation=simulation,RU={destroy=function()end},require=function(name)if name=='systems'then return sys elseif name=='exoskeleton'then return exo elseif name=='hero_auto_rally'then return rally else return require(name)end end}
  section(TASK..'/candidate/all/game.lua','function game:destroy()','function game:update_debug(',env)
  local weak=setmetatable({},{__mode='v'});local global_calls=0
  signal.register('cachecheck-global',function()global_calls=global_calls+1 end)
  for i=1,100 do
   local old={entities={},tag=i};weak[i]=old;game.store=old;simulation.store=old;game.simulation=simulation;game.game_gui={destroy=function()end}
   signal.begin_stage();signal.register('cachecheck-stage',function()return old end)
   SSO:reset(old.entities);SSO:create('targets',0,0,100,100)
   sys.texts:on_insert(entity('stage '..i),store)
   game:destroy();assert(not game.store and not simulation.store and not SSO.bb_all_entities and next(I.db_images)==nil)
  end
  collectgarbage();collectgarbage();assert(next(weak)==nil,'Finished stage retained')
  signal.emit('cachecheck-global');assert(global_calls==1)
  pass('100 combined game teardown cycles release stores, text textures, target grids and stage listeners; global listener survives')
 end,debug.traceback)
 write(table.concat(results,'\n')..(ok and '' or '\nFAIL '..tostring(err)));love.event.quit()
end
