local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_OriginalVFX_20261025]]
local pack=root..'/Z_Mod/Volibear/FL803_Volibear_VFXGoc_20261025'
local baseline=os.getenv('KRFL_VFX_BASELINE')=='1'
local notes,snapshots={},{}
local function write(path,s)local f=assert(io.open(path,'wb'));f:write(s);f:close()end
local function pass(s)notes[#notes+1]='PASS '..s end
function love.load()
 local ok,err=xpcall(function()
  package.path=root..'/kr3-desktop/?.lua;'..root..'/kr3/?.lua;'..root..'/all-desktop/?.lua;'..root..'/all/?.lua;'..root..'/lib/?.lua;'..root..'/?.lua;'..package.path
  love.filesystem.setRequirePath('game/kr3-desktop/?.lua;game/kr3/?.lua;game/all-desktop/?.lua;game/all/?.lua;game/lib/?.lua;?.lua;?/init.lua')
  KR_GAME='kr3';KR_TARGET='desktop';KR_PLATFORM='win';KR_FL_VERSION='8.0.3';DEBUG=false
  KR_PATH_ALL='game/all';KR_PATH_ALL_TARGET='game/all-desktop';KR_PATH_GAME='game/kr3';KR_PATH_GAME_TARGET='game/kr3-desktop'
  require('constants');TICK_LENGTH=1/FPS;DRAW_FPS=FPS;require('klua.table');require('klua.dump')
  package.loaded.version={identity='KRFL_voli_original_vfx',string='isolated'}
  require('klua.log').level=0
  package.preload.allied_volibear=function()return assert(loadfile(pack..(baseline and '/BACKUP_TRUOC_VA' or '/CAP_NHAT')..'/all/allied_volibear.lua'))()end
  package.preload.volibear_original_vfx=function()return assert(loadfile(pack..'/CAP_NHAT/all/volibear_original_vfx.lua'))()end
  assert(loadfile(pack..'/CAP_NHAT/all/allied_volibear.lua'));assert(loadfile(pack..'/CAP_NHAT/all/volibear_original_vfx.lua'))
  require('i18n').load_locale('en')
  local storage=require('storage');local slot=table.deepclone(require('data.slot_template'))
  storage.slot=slot;storage.active_slot_idx=1;storage.load_slot=function()return slot end
  storage.save_slot=function()error('Probe must not write a save')end
  storage.load_settings=function()return {locale='en',texture_size='fullhd'}end
  local A=require('animation_db');A:load();local E=require('entity_db');E:load()
  require('grid_db'):load('level01');require('path_db'):load('level01',{left=-10000,right=10000,bottom=-10000,top=10000})
  local C=require('allied_boss_common');local def=require('allied_volibear');local t=def.register()
  local update=t.main_script.update;def.register();assert(t.main_script.update==update,'Double update wrapper')
  assert(t.health.hp_max==2695 and t.melee.range==107 and t.render.sprites[1].scale.x==-.68)
  pass('Lua compile, native registration, rounded stats, size/facing/range and idempotent update wrapper')
  local I=require('klove.image_db');I:setMaxThreads(8)
  for _,name in ipairs(def.textures)do I:queue_load_atlas(1,name=='go_volibear_original_vfx' and 'vfxassets' or 'assets',name)end
  local deadline=love.timer.getTime()+30
  while not I:queue_load_done()do assert(love.timer.getTime()<deadline,'Atlas timeout');love.event.pump();love.timer.sleep(.001)end
  for key,a in pairs(A.db)do if (key:find(def.name,1,true)==1 or key:find('voli_original_',1,true)==1)and a.prefix and a.frames then
   for _,frame in ipairs(a.frames)do local name=string.format('%s_%04d',a.prefix,frame);local ss=assert(I:s(name),name);assert(I:i(ss.atlas))end
  end end
  if not baseline then
   local image=assert(I:i('go_volibear_original_vfx'));assert(image:getWidth()==1024 and image:getHeight()==1024)
   local atlas=assert(love.filesystem.load('vfxassets/go_volibear_original_vfx.lua'))();local count=0
   local data=love.image.newImageData('vfxassets/go_volibear_original_vfx.png')
   for _,ss in pairs(atlas)do
    count=count+1;local q=ss.f_quad;assert(q[1]>=0 and q[2]>=0 and q[1]+q[3]<=1024 and q[2]+q[4]<=1024)
    local visible=false;for y=0,q[4]-1,3 do for x=0,q[3]-1,3 do local _,_,_,alpha=data:getPixel(q[1]+x,q[2]+y);if alpha>30 then visible=true end end end
    assert(visible,'Empty converted frame')
   end
   assert(count==33,'Unexpected VFX frame count '..count)
  end
  pass('Native image loader decodes/uploads all hero textures and every animation frame resolves')
  local sim=require('simulation');simulation=sim
  local store,visuals,inserted,peak
  sim.queue_insert_entity=function(_,e)
   assert(not e.enemy and not e.soldier,'VFX summoned a combat unit')
   store.entities[e.id]=e;inserted[#inserted+1]=e
   if e.template_name=='volibear_original_vfx'then visuals[e.id]={e=e,co=coroutine.create(e.main_script.update)}end
  end
  sim.queue_remove_entity=function(_,e)e.pending_removal=true;store.entities[e.id]=nil;visuals[e.id]=nil end
  local function reset(at)
   store={tick_ts=at or 0,tick=0,entities={},damage_queue={}}
   visuals,inserted,peak={},{},0
   local h=E:create_entity(def.name);h.id=1000000;h.pos={x=0,y=0};h.nav_rally.new=false;h.boss_casting=true;h.soldier.target_id=nil
   store.entities[h.id]=h;def.hold(h,store);return h
  end
  local function enemy(id,x,boss)
   local e=E:create_entity('enemy_gnoll_reaver');e.id=1000000+id;e.pos={x=x or 40,y=0};e.fixture=id
   e.nav_path.pi,e.nav_path.spi,e.nav_path.ni=1,1,10;e.health.hp,e.health.hp_max=10000,10000
   if boss then e.vis.flags=require('bit').bor(e.vis.flags,F_BOSS)end
   store.entities[e.id]=e;return e
  end
  local function pump(dt)
   store.tick_ts=store.tick_ts+(dt or TICK_LENGTH);store.tick=store.tick+1
   local count=0
   for _,v in pairs(visuals)do
    count=count+1
    local good,message=coroutine.resume(v.co,v.e,store);assert(good,message)
   end
   peak=math.max(peak,count)
  end
  local function run(fn,tick)
   local co=coroutine.create(fn);local n=0
   repeat
    local good,message=coroutine.resume(co);assert(good,message);n=n+1
    if tick then tick(n)end;pump();assert(n<600,'Spell coroutine stalled')
   until coroutine.status(co)=='dead'
  end
  local function snapshot(name,h)
   local s=h.boss_state
   snapshots[#snapshots+1]=string.format('%s hp=%.6f max=%d mp=%.6f pos=%.6f,%.6f speed=%.6f range=%d stacks=%d',name,h.health.hp,h.health.hp_max,s.mp,h.pos.x,h.pos.y,h.motion.max_speed,h.melee.range,s.stacks)
   for _,d in ipairs(store.damage_queue)do snapshots[#snapshots+1]=string.format('D %d %.6f %d',store.entities[d.target_id].fixture,d.value,d.damage_type)end
   store.damage_queue={}
  end
  local function kinds()
   local out={};for _,e in ipairs(inserted)do if e.kind then out[e.kind]=(out[e.kind]or 0)+1 end end;return out
  end
  do
   local h=reset();local target=enemy(1,40);h.soldier.target_id=target.id
   run(function()assert(def.automatic(h,store,{target}))end);assert(h.boss_state.q_end)
   run(function()assert(def.automatic(h,store,{target}))end)
   assert(not h.boss_state.q_end and h.motion.max_speed==85 and store.damage_queue[1].value==184)
   snapshot('Q',h)
   if not baseline then local k=kinds();assert(k.q_charge==1 and k.q_hit==1 and not k.slash)end
   pass('Q charge/impact/stun cleanup; Q does not emit normal-attack slash')
   h=reset(10);target=enemy(1,40);h.boss_state.last.voli_q=10
   run(function()assert(def.automatic(h,store,{target}))end);assert(store.damage_queue[1].value==252);snapshot('W1',h)
   local mark=h.boss_state.vfx_marks and h.boss_state.vfx_marks[target.id]
   pump(5.1);h.boss_state.last.voli_q=store.tick_ts;h.health.hp=1500
   run(function()assert(def.automatic(h,store,{target}))end);assert(store.damage_queue[1].value==379);snapshot('W2',h)
   if not baseline then local k=kinds();assert(k.w_hit==2 and k.heal==1 and k.w_mark==1 and h.boss_state.vfx_marks[target.id]==mark)end
   pass('W mark/recast/heal; one persistent mark per owner and target')
   h=reset(20);target=enemy(1,40);enemy(2,50,true);h.boss_state.last.voli_q=20;h.boss_state.last.voli_w=20
   run(function()assert(def.automatic(h,store,{target}))end)
   pump(1.3);def.hold(h,store)
   assert(#store.damage_queue==2 and h.boss_state.shield==377);snapshot('E',h)
   local incoming=E:create_damage();incoming.source_id,incoming.target_id,incoming.value,incoming.damage_type=target.id,h.id,100,DAMAGE_PHYSICAL
   h.health.on_damage(h,store,incoming)
   snapshot('E shield',h)
   if not baseline then local k=kinds();assert(k.e_warning==1 and k.e_hit==1 and k.shield==1)end
   pass('E two-second delayed hit, troop cap/boss damage and shield unchanged; visual warning/bolt/shield emitted')
   h=reset(30);target=enemy(1,40);for i=2,5 do enemy(i,40+i*5)end
   for _=1,6 do local a=h.melee.attacks[h.boss_state.hand];assert(a.fn_can(h,store,a));assert(a.fn_damage(h,store,a,target)==134);pump(.05);def.hold(h,store)end
   assert(h.boss_state.stacks==5 and #store.damage_queue==10);snapshot('P and attacks',h)
   if not baseline then local k=kinds();assert(k.slash==6 and k.chain==10 and k.p_charge)end
   pass('Normal alternating strikes and five-target passive chain preserve damage and attack cadence')
   pump(6.2);def.hold(h,store);pump();assert(h.boss_state.stacks==0);snapshot('P expiry',h)
   h=reset(40);enemy(1,100);h.health.hp=1800;local old_bans=h.vis.bans
   run(function()def.active(h,store,{x=100,y=0})end)
   assert(h.pos.x==100 and h.melee.range==131 and h.health.hp_max==3220 and h.vis.bans==old_bans and h.render.sprites[1].offset.y==0,'R state cleanup')
   snapshot('R',h)
   if not baseline then local k=kinds();assert(k.r_warning==1 and k.r_leap==1 and k.r_hit==1)end
   pump(12);def.hold(h,store);assert(h.melee.range==107 and h.health.hp_max==2695);snapshot('R expiry',h)
   pass('R jump/landing/bonus health/range/expiry preserve gameplay and restore movement flags')
   h=reset(60);enemy(1,100);old_bans=h.vis.bans
   run(function()def.active(h,store,{x=100,y=0})end,function(n)if n==8 then h.health.hp=0;h.health.dead=true end end)
   assert(h.pos.x==0 and h.render.sprites[1].offset.y==0 and h.vis.bans==old_bans)
   if not baseline then assert(not kinds().r_hit,'R impact emitted after midair death')end
   pass('No R impact after death in midair')
  end
  if not baseline then
   local FX=require('volibear_original_vfx')
   local h=reset(100);local target=enemy(1,40);h.boss_state.q_end=104;h.boss_state.shield=10;h.boss_state.shield_end=103
   local q=FX.emit(h,store,'q_charge',{follow_id=h.id,face=true,y=65})
   local shield=FX.emit(h,store,'shield',{follow_id=h.id,face=true,y=70})
   h.render.sprites[1].flip_x=true;h.pos={x=50,y=20};pump(.1)
   assert(q.pos.x==50 and q.pos.y==85 and q.render.sprites[2].offset.x==35,'Follow/mirror detached')
   h.boss_state.q_end=nil;h.boss_state.shield=0;pump();assert(q.pending_removal and shield.pending_removal)
   h.boss_state.marks[target.id]=108;FX.mark(h,store,target);pump()
   h.health.dead=true;pump();assert(not next(h.boss_state.vfx_marks))
   assert(not next(visuals),'Owner-bound effect survived death')
   pass('Moving/turning attachments mirror correctly; Q/shield stop on expiry/consumption; marks stop and release IDs on death')
   h=reset(110)
   local body=h.render.sprites[1];body.name='q_attack';body.ts=store.tick_ts-.3;body.fps=30
   local qhit=FX.emit(h,store,'q_hit',{follow_id=h.id,face=true,x=42,y=75})
   pump(.001);assert(qhit.pos.y>190 and qhit.pos.x<0,'Q effect did not follow raised paws')
   body.flip_x=true;pump(.001);assert(qhit.pos.x>0,'Q paw attachment did not mirror')
   body.ts=store.tick_ts-.48;pump(.001);assert(qhit.pos.y<0 and qhit.pos.x<0,'Q effect did not descend with final paw pose')
   pass('Q strike tracks the actual exported paw positions from raised pose to ground slam, mirrored in both directions')
   h=reset(115);target=enemy(1,40);h.boss_state.marks[target.id]=123
   FX.mark(h,store,target);FX.emit(h,store,'p_charge',{follow_id=h.id})
   h.boss_state={born=115,last={}};pump();assert(not next(visuals),'Effects survived reset state')
   pass('Partially rebuilt respawn state safely stops old marks and charged aura')
   h=reset(120);target=enemy(1,40)
   for _,kind in ipairs({'slash','hit','chain','p_charge','q_charge','q_hit','w_hit','heal','e_warning','e_hit','shield','r_warning','r_leap','r_hit'})do
    if kind=='p_charge'then h.boss_state.stacks=5;h.boss_state.stack_end=126 end
    h.boss_state.q_end=124;h.boss_state.shield=10;h.boss_state.shield_end=123
    FX.emit(h,store,kind)
   end
   for _=1,280 do pump()end;assert(not next(visuals),'Effect did not expire')
   pass('All 15 effect types expire; sprites have no combat/targeting components')
   local weak=setmetatable({},{__mode='v'})
   for i=1,20 do
    local h=reset(150+i);local target=enemy(1,40);h.boss_state.marks[target.id]=store.tick_ts+8;FX.mark(h,store,target)
    weak[i]=store;weak[100+i]=h;weak[200+i]=target
   end
   store,visuals,inserted=nil,nil,nil;collectgarbage();collectgarbage();assert(not next(weak),'VFX retained old stores/actors')
   pass('20 discarded stores, Volibears and marked enemies collected; no saved state or global actor cache')
   -- Preview uses the native atlas lookup, animation database and renderer transforms.
   local RU=require('render_utils');local G=love.graphics;local canvas=G.newCanvas(1200,800)
   G.push('all');G.setCanvas(canvas);G.clear(29,34,43,255);G.setFont(G.newFont(18))
   local function draw(name,pos,sp)
    local ss=assert(I:s(name),name)
    G.setColor(sp.color or {255,255,255});local r,g,b=G.getColor();G.setColor(r,g,b,sp.alpha or 255)
    G.draw(I:i(ss.atlas),RU.frame_draw_params({ss=ss,pos={x=pos.x,y=REF_H-pos.y},offset=sp.offset or {x=0,y=0},anchor=sp.anchor or {x=.5,y=.5},scale=sp.scale or {x=1,y=1},r=sp.r or 0,flip_x=sp.flip_x}))
   end
   local scenes={
    {title='NORMAL ATTACK',pose='volibear_attack1_0012',effects={'slash','hit'}},
    {title='PASSIVE / LIGHTNING CHAIN',pose='volibear_attack2_0012',effects={'p_charge','chain'}},
    {title='Q / THUNDERING SMASH',pose='volibear_q_attack_0005',effects={'q_charge','q_hit'}},
    {title='W / MARK AND HEAL',pose='volibear_w_slash_0008',effects={'w_hit','w_mark','heal'}},
    {title='E / SKY SPLITTER',pose='volibear_idle_0001',effects={'e_warning','e_hit','shield'}},
    {title='R / STORMBRINGER',pose='volibear_r_impact_0015',effects={'r_hit'}}
   }
   for index,scene in ipairs(scenes)do
    local col,row=(index-1)%3,math.floor((index-1)/3);local bx,by=col*400+150,row*400+310
    G.setColor(69,80,95,255);G.line(col*400,by,col*400+400,by)
    G.setColor(240,225,195,255);G.print(scene.title,col*400+20,row*400+18)
    local h=reset(200);local target=enemy(1,95);h.boss_state.q_end=204;h.boss_state.stacks=5;h.boss_state.stack_end=206;h.boss_state.shield=100;h.boss_state.shield_end=203;h.boss_state.marks[target.id]=208
    if index==3 then h.render.sprites[1].name='q_attack';h.render.sprites[1].ts=199.8;h.render.sprites[1].fps=30 end
    local emitted={}
    for _,kind in ipairs(scene.effects)do
     local opts={follow_id=h.id,face=true,y=70}
     if kind=='e_hit'or kind=='e_warning'or kind=='r_hit'then opts={pos={x=0,y=0}}
     elseif kind=='w_mark'then opts={follow_id=target.id,y=target.health_bar.offset.y+12}
     elseif kind=='hit'then opts={pos={x=95,y=20}}
     elseif kind=='chain'then opts={pos={x=68,y=38},width=100,angle=-.45}
     elseif kind=='slash'or kind=='q_hit'or kind=='w_hit'then opts={follow_id=h.id,face=true,x=42,y=75}end
     emitted[#emitted+1]=FX.emit(h,store,kind,opts)
    end
    pump(.09)
    local function effect(e,ground)
     for _,sp in ipairs(e.render.sprites)do if (sp.z==Z_DECALS)==ground then
      local name=sp.animated and A:fn(sp.name,store.tick_ts-sp.ts,sp.loop,sp.fps)or sp.name
      draw(name,{x=bx+e.pos.x,y=by-e.pos.y},sp)
     end end
    end
    for _,e in ipairs(emitted)do effect(e,true)end
    draw(scene.pose,{x=bx,y=by},{anchor=h.render.sprites[1].anchor,scale=h.render.sprites[1].scale})
    for _,e in ipairs(emitted)do effect(e,false)end
   end
   G.setCanvas();G.pop()
   write(pack..'/XEM_TRUOC_VFX.png',canvas:newImageData():encode('png'):getString())
   pass('Native renderer preview generated for normal attacks, passive and Q/W/E/R')
   for _,name in ipairs(def.textures)do I:queue_unload_atlas(name,1)end
   while not I:queue_unload_done()do end
   for _,ss in pairs(I.db_atlas)do assert(ss.atlas~='go_volibear_original_vfx','VFX atlas retained after unload')end
   assert(not I.db_images.go_volibear_original_vfx)
   for _=1,3 do
    I:queue_load_atlas(1,'vfxassets','go_volibear_original_vfx')
    while not I:queue_load_done()do love.event.pump();love.timer.sleep(.001)end
    assert(I:s('voli_original_e_bolt_0001'))
    I:queue_unload_atlas('go_volibear_original_vfx',1);while not I:queue_unload_done()do end
    assert(not I.db_images.go_volibear_original_vfx)
   end
   pass('VFX atlas unloads and reloads cleanly on three cycles with eight image workers')
  end
 end,debug.traceback)
 if not ok then notes[#notes+1]='FAIL '..err end
 local tag=baseline and 'baseline' or 'candidate'
 write(task..'/'..tag..'_result.txt',table.concat(notes,'\n'))
 write(task..'/'..tag..'_gameplay.txt',table.concat(snapshots,'\n'))
 love.event.quit()
end
