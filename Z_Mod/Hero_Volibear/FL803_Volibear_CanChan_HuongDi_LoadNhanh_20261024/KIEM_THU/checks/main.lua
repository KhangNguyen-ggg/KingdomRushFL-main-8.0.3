local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_LoadFix_20261024]]
local pack=root..'/Z_Mod/Volibear/FL803_Volibear_CanChan_HuongDi_LoadNhanh_20261024'
local results={}
local function read(p)local f=assert(io.open(p,'rb'));local s=f:read('*a');f:close();return s end
local function section(src,a,b,env)
 local first=assert(src:find(a,1,true));local last=assert(src:find(b,first+1,true))
 local f=assert(loadstring(src:sub(first,last-1)));setfenv(f,setmetatable(env,{__index=_G}));f()
end
local function pass(s)results[#results+1]='PASS '..s end
function love.load()
 local ok,err=xpcall(function()
  package.path=root..'/lib/?.lua;'..root..'/all/?.lua;'..root..'/?.lua;'..package.path
  require('klua.table');require('klua.log').level=require('klua.log').OFF_LEVEL
  for _,file in ipairs({'all/allied_volibear.lua','all/director.lua','all/sound_db.lua','lib/klove/image_db.lua','all-desktop/screen_map.lua'})do assert(loadfile(pack..'/CAP_NHAT/'..file))end
  pass('5 payload files compile')
  local function db(base)return assert(loadfile(base..'/lib/klove/image_db.lua'))()end
  local I=db(pack..'/CAP_NHAT')
  I.db_images={shared={true},unique={true}}
  I.atlas_uses={['a-1.000000']=1,['b-1.000000']=1}
  I:merge_atlas_frames({same={group='a-1.000000',atlas='shared'},onlyA={group='a-1.000000',atlas='shared'}})
  I:merge_atlas_frames({same={group='b-1.000000',atlas='unique'},onlyB={group='b-1.000000',atlas='shared'}})
  I:unload_atlas('b',1,true)
  assert(I.db_atlas.same.group=='a-1.000000' and I.db_images.shared and not I.db_images.unique)
  I:unload_atlas('a',1,true);assert(not next(I.db_images) and not next(I.db_atlas_shadow))
  pass('Duplicate frame restoration and shared texture lifetime')
  local img=db(pack..'/CAP_NHAT');img:setMaxThreads(8);local count=0
  local create=love.graphics.newImage
  love.graphics.newImage=function(...)count=count+1;return create(...)end
  img:queue_load_atlas(1,'assets','go_volibear_idle');img:queue_load_atlas(2,'assets','go_volibear_idle')
  while not img:queue_load_done()do love.event.pump();love.timer.sleep(0.001)end
  love.graphics.newImage=create
  assert(count==1,'Same PNG uploaded twice: '..count)
  img:unload_atlas('go_volibear_idle',2,true)
  assert(img:s('volibear_idle_0001').ref_scale==1 and img.db_images.go_volibear_idle)
  img:unload_atlas('go_volibear_idle',1);assert(not img.db_images.go_volibear_idle)
  pass('Same PNG queued at two scales uploads once; unloading either group preserves the other')
  for _,base in ipairs({pack..'/BACKUP_TRUOC_VA',pack..'/CAP_NHAT'})do
   local img=db(base)
   for group=1,80 do
    local name='test'..group;local key=name..'-1.000000';img.atlas_uses[key]=1
    for n=1,300 do
     local texture='texture'..group..'_'..(n%8);img.db_images[texture]={true}
     img.db_atlas[name..'_'..n]={group=key,atlas=texture}
    end
    img:queue_unload_atlas(name,1)
   end
   local start=love.timer.getTime();local frames=1
   while not img:queue_unload_done()do frames=frames+1 end
   assert(not next(img.db_images) and not next(img.db_atlas) and not next(img.atlas_uses))
   results[#results+1]=string.format('UNLOAD %s: 80 groups/24000 frames, %.3fs CPU, %d update calls',base:match('[^/]+$'),love.timer.getTime()-start,frames)
  end
  -- A busy Lua heap approximates map/template data while atlas uploads run.
  local heap={};for i=1,120000 do heap[i]={i,{x=i,y=i},'fixture'..i}end
  local tags={'attack1','attack2','death','e_channel','e_idle','e_windup','idle','knockup','q_attack','q_intro','q_outro','r_cast','r_impact','r_outro','r_run','respawn','run','w_slash'}
  local groups={};for _,tag in ipairs(tags)do groups[#groups+1]='go_volibear_'..tag end
  for _,name in ipairs({'go_enemy_set','go_enemies_blackburn','ui_sett_spirit','ui_lich_king'})do groups[#groups+1]=name end
  local realgc=collectgarbage
  for cycle=1,3 do for _,base in ipairs({pack..'/BACKUP_TRUOC_VA',pack..'/CAP_NHAT'})do
   local img=db(base);img:setMaxThreads(8);local full,steps=0,0
   collectgarbage=function(mode,...)if not mode or mode=='collect'then full=full+1 elseif mode=='step'then steps=steps+1 end;return realgc(mode,...)end
   local start=love.timer.getTime()
   for _,group in ipairs(groups)do img:queue_load_atlas(1,'assets',group)end
   local deadline=love.timer.getTime()+30
   while not img:queue_load_done()do assert(love.timer.getTime()<deadline);love.event.pump();love.timer.sleep(0.001)end
   collectgarbage=realgc
   assert(img:s('volibear_idle_0001'))
   results[#results+1]=string.format('LOAD %s cycle %d: %.3fs, full GC=%d, steps=%d, Lua=%.1fMiB, texture=%.1fMiB',base:match('[^/]+$'),cycle,love.timer.getTime()-start,full,steps,realgc('count')/1024,love.graphics.getStats().texturememory/1048576)
   for _,group in ipairs(groups)do img:queue_unload_atlas(group,1)end
   while not img:queue_unload_done()do end
   assert(not next(img.db_images) and not next(img.db_atlas));img=nil;realgc('collect')
  end end
  assert(#heap==120000);heap=nil;realgc('collect')
  pass('18 Real3D groups + Set/Blackburn/Sett UI/Lich UI loaded and fully removed on 3 cycles, 8 workers')
  local D={item_props={map={type='screen',src='map',show_loading=true}},params={texture_size='fullhd',width=64,height=64},next_item_args={level_idx=99}}
  local order={};local function event(s)order[#order+1]=s end
  local loading={required_textures={},init=function()event('init')end,close=function()end,draw=function()event('draw')end,update_required_textures=function(_,_,idx)assert(idx==99);event('target')end}
  local map={required_textures={}}
  local G={isActive=function()return true end}
  for _,name in ipairs({'push','setCanvas','origin','setScissor','clear','pop'})do G[name]=function()end end
  G.present=function()event('present')end
  function D:reset_screen_params()end
  function D:load_texture_groups(_,_,_,queued)event(queued and 'queue' or 'loading-art')end
  function D:load_sound_groups()end
  section(read(pack..'/CAP_NHAT/all/director.lua'),'function director:queue_load_item_named(','function director:load_texture_groups(',{director=D,G=G,log={debug=function()end},game={store={level_idx=1}},i18n={current_locale='en'},replace_locale=function(t)return t end,require=function(name)return name=='screen_loading' and loading or map end})
  D:queue_load_item_named('map')
  assert(table.concat(order,',')=='target,loading-art,init,draw,present,queue',table.concat(order,','))
  pass('Destination stage artwork selected; loading presented before destination resource queue')
  local S=assert(loadfile(pack..'/CAP_NHAT/all/sound_db.lua'))();local removed=0
  S.unload_group=function()removed=removed+1 end
  for n=1,24 do S:queue_unload_group('group'..n)end
  local ticks=1;while not S:queue_unload_done()do ticks=ticks+1 end
  assert(removed==24 and ticks>=3 and ticks<24)
  pass('Sound unload queue processes batches and drains fully')
  local G=love.graphics;local canvas=G.newCanvas(16,16);G.setCanvas(canvas)
  G.push('all');G.setCanvas();G.origin();G.setScissor();G.clear();G.present();G.pop()
  assert(G.getCanvas()==canvas);G.setCanvas()
  pass('Loading presentation uses default framebuffer and restores previous graphics state')
  -- Verify the existing teardown releases old stage actors and listeners.
  local signal=assert(loadfile(root..'/lib/hump/signal.lua'))();local SSO=assert(loadfile(root..'/lib/klove/sso.lua'))()
  local sim={};local game={};local rally={clear_state=function(self,s)self.store=nil end}
  local env={game=game,signal=signal,SSO=SSO,simulation=sim,RU={destroy=function()end},require=function(name)
   if name=='systems'then return {texts={clear_cache=function()end}} elseif name=='exoskeleton'then return {unload_all=function()end} elseif name=='hero_auto_rally'then return rally end
   return require(name)
  end}
  section(read(root..'/all/game.lua'),'function game:destroy()','function game:update_debug(',env)
  local weak=setmetatable({},{__mode='v'})
  for i=1,3 do
   signal.begin_stage();local store={entities={{hero=true},{tower=true}}};weak[i]=store;game.store=store;sim.store=store;rally.store=store
   game.game_gui={destroy=function()end};signal.register('test-old-stage',function()return store end)
   game:destroy();assert(not game.store and not sim.store and not rally.store)
  end
  realgc('collect');realgc('collect');assert(not next(weak))
  pass('Existing game teardown frees 3 old stores, hero/tower tables and stage listeners; no teardown rewrite needed')
 end,debug.traceback)
 if not ok then results[#results+1]='FAIL '..tostring(err)end
 local f=assert(io.open(task..'/checks_result.txt','wb'));f:write(table.concat(results,'\n'));f:close();love.event.quit()
end
