local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_LoadFix_20261024]]
local stage=root..'/Z_Mod/Volibear/FL803_Volibear_CanChan_HuongDi_LoadNhanh_20261024/CAP_NHAT'
local function write(s)local f=assert(io.open(task..'/native_result.txt','wb'));f:write(s);f:close()end
function love.load()
 local ok,err=xpcall(function()
  package.path=root..'/kr3-desktop/?.lua;'..root..'/kr3/?.lua;'..root..'/all-desktop/?.lua;'..root..'/all/?.lua;'..root..'/lib/?.lua;'..package.path
  love.filesystem.setRequirePath('game/kr3-desktop/?.lua;game/kr3/?.lua;game/all-desktop/?.lua;game/all/?.lua;game/lib/?.lua;?.lua;?/init.lua')
  KR_GAME='kr3';KR_TARGET='desktop';KR_PLATFORM='win';KR_FL_VERSION='8.0.3';DEBUG=false
  KR_PATH_ALL='game/all';KR_PATH_ALL_TARGET='game/all-desktop';KR_PATH_GAME='game/kr3';KR_PATH_GAME_TARGET='game/kr3-desktop'
  require('constants');TICK_LENGTH=1/FPS;DRAW_FPS=FPS;require('klua.table');require('klua.dump')
  package.loaded.version={identity='KRFL_voli_lol20_native',string='isolated'}
  local log=require('klua.log');log.level=log.OFF_LEVEL
  for _,name in ipairs({'allied_volibear','volibear_animation_map','allied_bosses','allied_boss_common','infinite_heroes'})do
   local file=(name=='allied_volibear' and stage or root)..'/all/'..name..'.lua';package.preload[name]=function()return assert(loadfile(file))()end
  end
  require('i18n').load_locale('en')
  local storage=require('storage');local slot=table.deepclone(require('data.slot_template'))
  storage.slot=slot;storage.active_slot_idx=1;storage.load_slot=function()return slot end;storage.save_slot=function()return true end
  storage.load_settings=function()return {locale='en',texture_size='fullhd'}end
  local A=require('animation_db');A:load();local E=require('entity_db');E:load()
  local registry=require('allied_bosses');local templates={};local ids={}
  for _,boss in ipairs(registry.list)do assert(not ids[boss.name],'Duplicate boss '..boss.name);ids[boss.name]=true end
  for _,name in ipairs({'hero_allied_navira_blue','hero_allied_sett','hero_allied_volibear_prestige'})do
   templates[name]=assert(registry.register(name));assert(E:create_entity(name))
  end
  local h=E:create_entity('hero_allied_volibear_prestige');h.pos={x=0,y=0}
  local def=registry.get(h.template_name);local common=require('allied_boss_common');local store={tick_ts=0,entities={[h.id]=h},damage_queue={}}
  def.hold(h,store)
  assert(h.health.hp_max==2695 and h.volibear_mana==1727 and h.melee.attacks[1].damage_min==134)
  assert(h.regen.health==0 and h.volibear_tick_wrapper)
  local wrapped=templates[h.template_name].main_script.update;registry.register(h.template_name)
  assert(templates[h.template_name].main_script.update==wrapped,'Update wrapped twice')
  h.health.hp=1000;store.tick_ts=1;def.hold(h,store);assert(h.health.hp==1005)
  h.health.hp_max=3220;h.health.hp=1500;h.boss_state.ult_end=1.1
  store.tick_ts=2;def.hold(h,store);assert(h.health.hp_max==2695 and not h.boss_state.ult_end)
  local target=E:create_entity('enemy_gnoll_reaver');target.pos={x=25,y=0};store.entities[target.id]=target
  -- Register the custom slow in real components and run its native insert/remove callbacks.
  local slow=E:create_entity('voli_lol20_slow');slow.modifier.source_id=h.id;slow.modifier.target_id=target.id
  local speed=target.motion.max_speed;assert(slow.main_script.insert(slow,store));assert(math.abs(target.motion.max_speed-speed*0.6)<0.001)
  slow.main_script.remove(slow,store);assert(math.abs(target.motion.max_speed-speed)<0.001)
  local names={'hero_allied_navira_blue','hero_allied_sett','hero_allied_volibear_prestige'}
  local infinite=require('infinite_heroes');slot.liuhui_hero={useinfinitehero=true,infiniteheroes=names}
  assert(#infinite.settings(slot).infiniteheroes==3 and infinite.active({level={manual_hero_insertion=true},infinite_hero_names=names}))
  package.loaded['klove.image_db']=assert(loadfile(stage..'/lib/klove/image_db.lua'))();local I=require('klove.image_db');I:setMaxThreads(8)
  for _,group in ipairs(def.textures)do I:queue_load_atlas(1,'assets',group)end
  local timeout=love.timer.getTime()+30
  while not I:queue_load_done()do assert(love.timer.getTime()<timeout,'Atlas load timeout');love.event.pump();love.timer.sleep(0.002)end
  for key,a in pairs(A.db)do if key:find('hero_allied_volibear_prestige',1,true)==1 and a.prefix and a.frames then
   for _,frame in ipairs(a.frames)do local name=a.prefix..'_'..string.format('%04d',frame);local sprite=assert(I:s(name),'Missing '..name);assert(I:i(sprite.atlas))end
  end end
  assert(I:s('encyclopedia_creep_thumbs_volibear_prestige') and I:s('encyclopedia_creeps_volibear_prestige') and I:s(h.info.portrait))
  assert(h.melee.range==107)
  local sp=h.render.sprites[1];assert(sp.scale.x==-0.68 and sp.scale.y==0.68)
  local RU=require('render_utils');local ss=assert(I:s('volibear_idle_0001'))
  local f={ss=ss,pos={x=0,y=0},offset={x=0,y=0},anchor=sp.anchor,scale=sp.scale,r=0,flip_x=false}
  local _,_,_,_,sx,sy,ox,oy=RU.frame_draw_params(f)
  assert(sx<0 and sy>0 and math.abs(oy-select(4,ss.quad:getViewport()))<1.1,'Feet anchor')
  f.flip_x=true;local _,_,_,_,left_sx=RU.frame_draw_params(f);assert(left_sx>0,'Left-facing mirror')
  local set=assert(loadfile(root..'/kr3-desktop/assets/images/fullhd/go_enemy_set.lua'))().Set_Idle_0001
  assert(math.abs(select(4,ss.quad:getViewport())*sy-set.f_quad[4])<1,'Height versus Set')
  h.health.hp_max=3220;h.boss_state.ult_end=2.5;h.melee.range=131;sp.scale={x=-0.85,y=0.85}
  store.tick_ts=3;def.hold(h,store);assert(h.melee.range==107 and sp.scale.x==-0.68)
  def.respawn(h);assert(h.melee.range==107 and sp.offset.y==0 and sp.scale.x==-0.68)
  I:queue_load_atlas(1,'assets','go_enemy_set')
  while not I:queue_load_done()do love.event.pump();love.timer.sleep(0.001)end
  local G=love.graphics;local canvas=G.newCanvas(1000,470)
  G.push('all');G.setCanvas(canvas);G.clear(28,32,40,255);G.origin();G.setScissor();G.setFont(G.newFont(17))
  local function draw(name,x,y,anchor,scale,flip,offset)
   local ss=assert(I:s(name));local f={ss=ss,pos={x=x,y=REF_H-y},offset=offset or {x=0,y=0},anchor=anchor,scale=scale,r=0,flip_x=flip}
   G.setColor(255,255,255,255);G.draw(I:i(ss.atlas),RU.frame_draw_params(f))
  end
  for _,x in ipairs({150,400,650,870})do G.setColor(85,105,125,255);G.line(x-75,310,x+75,310);G.circle('line',x,310,25,30)end
  draw('volibear_idle_0001',150,310,{x=.5,y=.13},{x=.37,y=.37},false)
  draw('Set_Idle_0001',400,310,{x=.5,y=7/220},{x=1,y=1},false)
  draw('volibear_idle_0001',650,310,sp.anchor,sp.scale,false)
  draw('volibear_run_0001',870,310,sp.anchor,sp.scale,true)
  G.setColor(230,235,245,255)
  G.print('Before: feet too high',65,65);G.print('Set: 150px body',322,65);G.print('New: face right',573,65);G.print('New: face left',800,65)
  G.print('New Volibear: 150px tall | feet aligned to selection | mirrored at sprite scale',140,380)
  G.print('Set shown with feet on the same guide for height comparison.',210,415)
  G.pop();local pixels=canvas:newImageData();local encoded=pixels:encode('png');local out=assert(io.open(task..'/preview.png','wb'));out:write(encoded:getString());out:close()
  write('PASS size/feet anchor/negative-scale facing/Set height/range/ultimate expiry/respawn; real game animation/entity/component databases; Navira blue + Sett + new Volibear registration/creation; no duplicate tick wrapper; native slow insert/remove; regen and R expiry; Infinite scripted insertion with 3 names; all Volibear atlas groups loaded at 8 workers and all frames resolved. No stage, F1 bulk load or user-save writes. Lua '..math.floor(collectgarbage('count')/1024)..' MiB.')
 end,debug.traceback)
 if not ok then write('FAIL '..tostring(err))end
 love.event.quit()
end
