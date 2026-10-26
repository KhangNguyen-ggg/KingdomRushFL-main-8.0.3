local task=[[D:/CodexTemp/KRFL_Voli_LoL20_20261023]]
local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local stage=root..'/Z_Mod/Volibear/FL803_Volibear_LoL20_Real3D_20261023/CAP_NHAT'
local function write(name,s)local f=assert(io.open(task..'/'..name,'wb'));f:write(s);f:close()end
local function clone(v)if type(v)~='table'then return v end;local out={};for k,x in pairs(v)do out[k]=clone(x)end;return out end
function love.load()
 local ok,err=xpcall(function()
  local bit=require('bit');_G.FPS=30
  for i,key in ipairs({'F_BLOCK','F_FLYING','F_CLIFF','F_MOD','F_STUN','F_SLOW','F_AREA','F_BOSS','F_MINIBOSS','DAMAGE_PHYSICAL','DAMAGE_MAGICAL','DAMAGE_ARMOR','DAMAGE_MAGICAL_ARMOR','F_TELEPORT'})do _G[key]=2^(i-1)end
  UNIT_SIZE_MEDIUM=2
  local A={db={}};local E={entities={}}
  function E:clone_c(kind)return kind=='sprite' and {offset={x=0,y=0},animated=true}or {}end
  function E:register_t(name,base)
   local t={render={},slow={},modifier={},main_script={}}
   self.entities[name]=t;return t
  end
  function E:create_entity(name)local t=clone(assert(self.entities[name],'Missing entity '..name));t.template_name=name;return t end
  function E:create_damage()return {reduce_armor=0,reduce_magic_armor=0}end
  E:register_t('mod_stun')
  local t={render={sprites={{prefix='candidate'}}},health={damage_factor=1},health_bar={},regen={},motion={},unit={},ui={},soldier={},melee={},info={},main_script={update=function()while true do coroutine.yield()end end}}
  local C={}
  function C.create(def)def.prepare(t);return t end
  function C.state(e,store)if not e.boss_state then e.boss_state={born=store.tick_ts,last={},summons={}}end;return e.boss_state end
  function C.alive(e)return e and not e.pending_removal and e.health and not e.health.dead and e.health.hp>0 end
  function C.ready(e,store,key,cd)local s=C.state(e,store);return store.tick_ts-(s.last[key]or s.born)>=cd end
  function C.stamp(e,store,key)C.state(e,store).last[key]=store.tick_ts end
  function C.copy(p)return{x=p.x,y=p.y}end
  function C.dist(a,b)return math.sqrt((a.x-b.x)^2+(a.y-b.y)^2)end
  function C.animate(e,name,store,loop)local sp=e.render.sprites[1];sp.name=name;sp.ts=store.tick_ts;sp.loop=loop end
  local inserts={};function C.insert(e)inserts[#inserts+1]=e end
  function C.remove(e)e.removed=true end
  function C.land(e,pos)e.pos=C.copy(pos);e.nav_rally.new=false end
  local U={}
  function U.find_enemies_in_range(entities,pos,min,max,flags,bans)
   local found={};for _,e in pairs(entities)do if e.enemy and C.alive(e)and bit.band(e.vis.bans,flags)==0 and C.dist(pos,e.pos)<=max then found[#found+1]=e end end;return found
  end
  function U.predict_damage(e,d)return math.floor(d.value*(1-(d.damage_type==DAMAGE_MAGICAL and e.health.magic_armor or e.health.armor))+0.5)end
  function U.unblock_target(store,e)e.soldier.target_id=nil;e.unblocked=true end
  package.loaded.allied_boss_common=C;package.loaded.entity_db=E;package.loaded.animation_db=A;package.loaded.utils=U
  package.loaded['klua.vector']={v=function(x,y)return{x=x,y=y}end}
  package.loaded.i18n={msgs={vi={}}}
  package.loaded.volibear_animation_map=assert(loadfile(stage..'/all/volibear_animation_map.lua'))()
  local def=assert(loadfile(stage..'/all/allied_volibear.lua'))();def.register()
  assert(def.stats.hp==2695 and def.stats.ad==134 and def.stats.armor==137 and def.stats.mr==72 and def.stats.hp_regen==5)
  assert(def.stats.attacks_per_minute==54 and t.health.armor==0.58 and t.health.magic_armor==0.42)
  for _,file in ipairs({'allied_boss_common','infinite_heroes','allied_bosses'})do assert(loadfile(stage..'/all/'..file..'.lua'))end
  local sprites={};local frame_count=0;local image_count=0
  for _,name in ipairs(love.filesystem.getDirectoryItems('assets'))do
   if name:match('%.lua$')then
    for key,a in pairs(assert(love.filesystem.load('assets/'..name))())do
     sprites[key]=a;if key:match('^volibear_.*_%d+$')then frame_count=frame_count+1 end
    end
   elseif name:match('%.png$')then
    local data=love.image.newImageData('assets/'..name);local image=love.graphics.newImage(data);image_count=image_count+1
    image=nil;data=nil;collectgarbage();collectgarbage()
   end
  end
  assert(frame_count==341 and image_count==19)
  for key,a in pairs(A.db)do for _,frame in ipairs(a.frames)do assert(sprites[a.prefix..'_'..string.format('%04d',frame)],'Missing '..key..' frame '..frame)end end
  local raw={db={}};package.loaded.volibear_animation_map.register('candidate',raw)
  for key,a in pairs(raw.db)do
   local needed={};for _,f in ipairs(a.frames)do needed[f]=true end
   for _,f in ipairs(A.db[key].frames)do needed[f]=nil end
   assert(next(needed)==nil,'Dropped exported pose '..key)
  end
  local air,land=A.db.candidate_jump,A.db.candidate_land
  assert(air.prefix=='volibear_r_impact' and land.prefix=='volibear_r_impact' and air.frames[#air.frames]<=12 and land.frames[1]>=13)
  local store={tick_ts=0,entities={},damage_queue={}}
  local function hero()
   local e=clone(t);e.id=1;e.pos={x=0,y=0};e.vis={flags=0,bans=0};e.health.dead=false;e.unit.damage_factor=1;e.nav_rally={new=false};e.motion.max_speed=85
   e.soldier.target_id=nil;e.boss_casting=true;e.boss_state=nil;store.entities[1]=e;return e
  end
  local function enemy(id,x,boss)
   local e={id=id,enemy={},pos={x=x,y=0},vis={flags=boss and F_BOSS or 0,bans=0},health={hp=100000,hp_max=100000},motion={max_speed=50}}
   store.entities[id]=e;return e
  end
  local function run(fn,tick)
   local co=coroutine.create(fn);local n=0
   repeat local good,message=coroutine.resume(co);assert(good,message);store.tick_ts=store.tick_ts+1/30;n=n+1;if tick then tick(n)end;assert(n<600,'Coroutine timeout')until coroutine.status(co)=='dead'
  end
  local h=hero();def.hold(h,store);assert(def.can_cast_active(h,store))
  h.health.hp=2000;store.tick_ts=2;h.unit.is_stunned=true;def.hold(h,store);assert(h.health.hp==2010,'Regen must work while stunned/in combat');h.unit.is_stunned=false
  local target=enemy(10,40);h.soldier.target_id=target.id
  run(function()assert(def.automatic(h,store,{target}))end)
  assert(h.boss_state.q_end and h.motion.max_speed>85,'Q charge')
  local before=#store.damage_queue;run(function()assert(def.automatic(h,store,{target}))end)
  assert(store.damage_queue[before+1].value==184 and h.motion.max_speed==85 and not h.boss_state.q_end,'Q hit/cleanup')
  assert(inserts[#inserts].template_name=='mod_stun' and inserts[#inserts].modifier.target_id==10,'Q exact target stun')
  store.tick_ts=5;h.boss_state.last.voli_q=5
  before=#store.damage_queue;run(function()assert(def.automatic(h,store,{target}))end)
  assert(store.damage_queue[before+1].value==252,'W1')
  store.tick_ts=10.8;h.health.hp=1500;before=#store.damage_queue
  run(function()assert(def.automatic(h,store,{target}))end)
  assert(store.damage_queue[before+1].value==379 and h.health.hp>1800,'W2 bonus/heal')
  h=hero();store.tick_ts=20;def.hold(h,store);target=enemy(10,40)
  h.boss_state.last.voli_q=20;h.boss_state.last.voli_w=20
  local boss=enemy(11,50,true)
  run(function()assert(def.automatic(h,store,{target}))end)
  h.unit.is_stunned=true;store.tick_ts=22.1;before=#store.damage_queue;def.hold(h,store)
  local values={};for i=before+1,#store.damage_queue do values[store.damage_queue[i].target_id]=store.damage_queue[i].value end
  assert(values[10]==610 and values[11]==15200,'E cap on normal enemy, percent HP on boss')
  assert(h.boss_state.shield==377,'E shield even while stunned')
  local incoming={value=100,damage_type=DAMAGE_PHYSICAL};local old_shield=h.boss_state.shield
  assert(not h.health.on_damage(h,store,incoming)and h.boss_state.shield==old_shield-42,'Shield after resistances')
  store.tick_ts=26;assert(h.health.on_damage(h,store,{value=100,damage_type=DAMAGE_PHYSICAL}),'Shield expiry')
  h=hero();store.tick_ts=30;def.hold(h,store);target=enemy(10,40)
  local attack=h.melee.attacks[1];for i=1,5 do attack.fn_damage(h,store,attack,target)end
  assert(h.boss_state.stacks==5 and h.melee.attacks[1].cooldown>0)
  before=#store.damage_queue;attack.fn_damage(h,store,attack,target)
  assert(#store.damage_queue>before and store.damage_queue[before+1].value==68,'Passive procs each attack at full stacks')
  store.tick_ts=37;def.hold(h,store);assert(h.boss_state.stacks==0,'Passive expires')
  h=hero();store.tick_ts=40;def.hold(h,store);h.health.hp=1800;target=enemy(10,100)
  local old_bans=h.vis.bans;run(function()def.active(h,store,{x=100,y=0})end)
  assert(h.health.hp_max==3220 and h.melee.range==71 and h.health.hp<2400,'R bonus HP/range')
  assert(h.pos.x==100 and h.vis.bans==old_bans and not h.boss_form and h.render.sprites[1].offset.y==0,'R landing cleanup')
  assert(not h.health.ignore_damage,'R is not invulnerability')
  local r_damage=false;for _,d in ipairs(store.damage_queue)do if d.value==700 then r_damage=true end end;assert(r_damage,'R epicenter damage')
  store.tick_ts=53;def.hold(h,store);assert(h.health.hp_max==2695 and h.melee.range==58,'R expiry')
  h.boss_state.mp=0;assert(not def.can_cast_active(h,store),'Mana gate');h.health.hp=1;def.respawn(h);assert(h.health.hp==2695 and h.motion.max_speed==85)
  h=hero();store.tick_ts=60;def.hold(h,store);target=enemy(10,40)
  run(function()def.automatic(h,store,{target})end)
  h.unit.is_stunned=true;def.hold(h,store)
  assert(not h.boss_state.q_end and h.motion.max_speed==85 and C.ready(h,store,'voli_q',10),'Q interrupted refund and speed cleanup')
  h=hero();store.tick_ts=70;def.hold(h,store)
  run(function()def.active(h,store,{x=100,y=0})end,function(n)if n==8 then h.health.hp=0;h.health.dead=true end end)
  assert(h.pos.x==0 and h.vis.bans==0 and not h.boss_form and h.render.sprites[1].offset.y==0,'R death restores position and flags')
  h=hero();store.tick_ts=80;def.hold(h,store);h.pos={x=200,y=0};h.boss_state.e_pos={x=0,y=0};h.boss_state.e_at=80
  def.hold(h,store);assert(not h.boss_state.shield,'E grants no shield outside radius')
  h.boss_state.shield=10;h.boss_state.shield_end=90
  local d={value=100,damage_type=DAMAGE_PHYSICAL};assert(h.health.on_damage(h,store,d) and math.abs(d.value-100*32/42)<0.001,'Partial shield preserves overflow')
  local ui=assert(io.open(stage..'/all-desktop/screen_map.lua','rb'));local code=ui:read('*a');ui:close()
  assert(loadstring(code,'screen_map syntax'))
  local start=assert(code:find('function HeroRoomView:update_sett_skill_panel',1,true));local finish=assert(code:find('function HeroRoomView:construct_allied_boss',start,true))
  local function view(size)
   local obj={size=size,children={},colors={},buttons={}}
   function obj:add_child(child)child.parent=self;self.children[#self.children+1]=child end
   function obj:remove_child(child)for i,c in ipairs(self.children)do if c==child then table.remove(self.children,i);child.parent=nil;return end end;error('Unknown child')end
   return obj
  end
  local env={HeroRoomView={},v=function(x,y)return{x=x,y=y}end,KView={new=function(_,size)return view(size)end},KButton={new=function(_,size)return view(size)end},KImageView={new=function(_,name)local o=view({x=56,y=56});o.image=name;return o end},S={queue=function()end}}
  local panel_chunk=assert(loadstring(code:sub(start,finish-1),'skill panel'));setfenv(panel_chunk,setmetatable(env,{__index=_G}));panel_chunk()
  local room={bio_text={pos={},parent=view({})},bio_header={}}
  local first={name='sett',skill_cards={}};for i=1,5 do first.skill_cards[i]={icon='sett'..i,title='title',description='description'}end
  env.HeroRoomView.update_sett_skill_panel(room,first);local old_panel=room.sett_skill_panel
  env.HeroRoomView.update_sett_skill_panel(room,def)
  assert(old_panel.parent==nil and room.sett_skill_panel.boss_name==def.name,'Skill panel must rebuild on hero change')
  assert(room.sett_skill_panel.buttons[1].children[1].image=='volibear_skill_p','Volibear icon must replace cached Sett icon')
  write('unit_result.txt','PASS: rounded level-20 stats, all 341 exported frames retained, 19 PNGs decoded/uploaded, module syntax, Q charge/hit/stun/cleanup/interruption refund, W mark/recast/heal, E delay/cap/boss/shield/expiry/outside radius, post-resistance shield/overflow, passive repeated chain/expiry, R damage/leap/health/range/expiry/death/flag cleanup, mana gate, respawn and Sett-to-Volibear skill panel icon refresh. Game stage entry NOT tested.')
 end,debug.traceback)
 if not ok then write('unit_result.txt','FAIL '..tostring(err))end
 love.event.quit()
end
