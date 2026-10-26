local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_LoL20_20261023]]
local stage=root..'/Z_Mod/Volibear/FL803_Volibear_LoL20_Real3D_20261023/CAP_NHAT'
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
   local file=stage..'/all/'..name..'.lua';package.preload[name]=function()return assert(loadfile(file))()end
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
  local I=require('klove.image_db');I:setMaxThreads(8)
  for _,group in ipairs(def.textures)do I:queue_load_atlas(1,'assets',group)end
  local timeout=love.timer.getTime()+30
  while not I:queue_load_done()do assert(love.timer.getTime()<timeout,'Atlas load timeout');love.event.pump();love.timer.sleep(0.002)end
  for key,a in pairs(A.db)do if key:find('hero_allied_volibear_prestige',1,true)==1 and a.prefix and a.frames then
   for _,frame in ipairs(a.frames)do local name=a.prefix..'_'..string.format('%04d',frame);local sprite=assert(I:s(name),'Missing '..name);assert(I:i(sprite.atlas))end
  end end
  assert(I:s('encyclopedia_creep_thumbs_volibear_prestige') and I:s('encyclopedia_creeps_volibear_prestige') and I:s(h.info.portrait))
  write('PASS real game animation/entity/component databases; Navira blue + Sett + new Volibear registration/creation; no duplicate tick wrapper; native slow insert/remove; regen and R expiry; Infinite scripted insertion with 3 names; all Volibear atlas groups loaded at 8 workers and all frames resolved. No stage, F1 bulk load or user-save writes. Lua '..math.floor(collectgarbage('count')/1024)..' MiB.')
 end,debug.traceback)
 if not ok then write('FAIL '..tostring(err))end
 love.event.quit()
end
