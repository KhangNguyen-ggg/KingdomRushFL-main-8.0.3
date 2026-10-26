local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_FullVFX_20261025]]
local pack=root..'/Z_Mod/Volibear/FL803_Volibear_Full_VFX_HoanThien_20261025'
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
  package.preload.volibear_original_vfx=function()return assert(loadfile(pack..(baseline and '/BACKUP_TRUOC_VA' or '/CAP_NHAT')..'/all/volibear_original_vfx.lua'))()end
  package.preload.volibear_vfx_anchors=function()return assert(loadfile(pack..'/CAP_NHAT/all/volibear_vfx_anchors.lua'))()end
  package.preload.volibear_movement=function()return assert(loadfile(pack..'/CAP_NHAT/all/volibear_movement.lua'))()end
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
  assert(t.health.hp_max==2695 and t.melee.range==107 and t.render.sprites[1].scale.x==1)
  pass('Lua compile, native registration, rounded stats, size/facing/range and idempotent update wrapper')
  local I=require('klove.image_db');I:setMaxThreads(8)
  for _,name in ipairs(def.textures)do I:queue_load_atlas(1,'vfxassets',name)end
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
   store={tick_ts=at or 0,tick=0,tick_length=TICK_LENGTH,entities={},damage_queue={}}
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
   table.sort(store.damage_queue,function(a,b)local fa,fb=store.entities[a.target_id].fixture,store.entities[b.target_id].fixture;return fa<fb or fa==fb and a.value<b.value end)
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
   local Movement=require('volibear_movement');local renderer=require('systems').render
   local directions={'e','ne','n','nw','w','sw','s','se'}
   for _,mode in ipairs({'normal','q','r','rq'})do
    for i=0,7 do
     local h=reset(80+i);local sp=h.render.sprites[1];local s=h.boss_state
     local angle=i*math.pi/4;h.motion.dest={x=200*math.cos(angle),y=200*math.sin(angle)};h.motion.arrived=false
     sp.name='walk';sp.loop=true
     if mode=='q'or mode=='rq'then s.q_end=store.tick_ts+4 end
     if mode=='r'or mode=='rq'then s.ult_end=store.tick_ts+12;h.health.hp_max=3220 end
     def.hold(h,store);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
     local clip=(mode=='q'or mode=='rq')and 'qrun8'or mode=='r'and 'rrun8'or 'walk8'
     assert(sp._render_frame_name:find('volibear_'..clip..'_'..directions[i+1]..'_',1,true)==1,'Wrong direction '..mode..':'..i)
     assert(not sp.flip_x and sp.scale.x==(s.ult_end and 1.25 or 1)and sp.anchor.y==34/256)
     assert(s.move_direction==i and sp.volibear_move_direction==i)
     local ts=sp.ts;local idx=sp.frame_idx
     h.motion.dest={x=200*math.cos(angle+math.pi/4),y=200*math.sin(angle+math.pi/4)}
     def.hold(h,store);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
     assert(sp.ts==ts and sp.frame_idx==idx,'Turn restarted stride')
     if s.q_end then
      local q=FX.emit(h,store,'q_charge',{follow_id=h.id,face=true,y=65});pump(.05)
      local facing=sp.volibear_move_direction*math.pi/4
      assert(math.abs(q.render.sprites[2].r-facing)<.001,'Q trail does not follow movement')
      assert(math.abs(q.render.sprites[2].offset.x+35*math.cos(facing))<.001)
     end
     sp.name='attack';sp.flip_x=i>=3 and i<=5
     Movement.update(h,store,s);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
     assert(not sp.animation and not sp.volibear_move_direction and math.abs(sp.scale.x-(s.ult_end and -.85 or -.68))<1e-9)
     assert(sp.anchor.x==266/512 and sp._render_frame_name:find('volibear_attack1_',1,true)==1,'Combat anchor or cached frame not restored')
    end
   end
   pass('Native renderer selects all eight directions in normal/Q/R/R+Q movement, keeps stride phase on turns, restores combat anchors and turns Q trails correctly')
   local SU=require('script_utils')
   for i=0,7 do
    local h=reset(300+i*3);local angle=i*math.pi/4;local destination={x=60*math.cos(angle),y=60*math.sin(angle)}
    h.nav_rally.pos=destination;h.nav_grid.waypoints=nil
    local co=coroutine.create(SU.y_hero_walk_waypoints);local frames=0
    while coroutine.status(co)~='dead'do
     def.hold(h,store);local good,msg=coroutine.resume(co,store,h);assert(good,msg)
     Movement.update(h,store,h.boss_state);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
     if not h.motion.arrived then assert(h.render.sprites[1]._render_frame_name:find('volibear_walk8_'..directions[i+1]..'_',1,true)==1)end
     pump();frames=frames+1;assert(frames<100,'Walk stalled')
    end
    assert(C.dist(h.pos,destination)<.0001,'Movement changed destination')
    SU.soldier_idle(store,h);def.hold(h,store);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
    assert(h.render.sprites[1]._render_frame_name:find('volibear_idle8_'..directions[i+1]..'_',1,true)==1,'Stop lost direction')
   end
   pass('Actual hero waypoint coroutine walks to all eight destinations, arrives correctly and keeps its direction while idle')
   local h=reset(100);local target=enemy(1,40);h.boss_state.q_end=104;h.boss_state.shield=10;h.boss_state.shield_end=103
   local q=FX.emit(h,store,'q_charge',{follow_id=h.id,face=true,y=65})
   local shield=FX.emit(h,store,'shield',{follow_id=h.id,face=true,y=70})
   h.render.sprites[1].name='attack';h.render.sprites[1].flip_x=true;require('volibear_movement').update(h,store,h.boss_state);h.pos={x=50,y=20};pump(.1)
   assert(q.pos.x==50 and q.pos.y==85 and q.render.sprites[2].offset.x==35,'Follow/mirror detached')
   h.boss_state.q_end=nil;h.boss_state.shield=0;pump();assert(q.pending_removal and shield.pending_removal)
   h.boss_state.marks[target.id]=108;FX.mark(h,store,target);pump()
   h.health.dead=true;pump();assert(not next(h.boss_state.vfx_marks))
   assert(not next(visuals),'Owner-bound effect survived death')
   pass('Moving/turning attachments mirror correctly; Q/shield stop on expiry/consumption; marks stop and release IDs on death')
   h=reset(110)
   local body=h.render.sprites[1];body.name='q_attack';body.ts=store.tick_ts-.15;body.fps=30
   require('volibear_movement').update(h,store,h.boss_state)
   local qhit=FX.emit(h,store,'q_hit',{follow_id=h.id,face=true,attach=1})
   pump(.001)
   local anchors=require('volibear_vfx_anchors');local frame=A:fn(body.prefix..'_q_attack',store.tick_ts-body.ts,false,body.fps)
   local expected=assert(anchors[frame]);assert(math.abs(qhit.pos.x-expected[1])<.001 and math.abs(qhit.pos.y-expected[2])<.001,'Q did not attach to actual projected paw')
   body.flip_x=true;pump(.001);assert(math.abs(qhit.pos.x+expected[1])<.001,'Q paw attachment did not mirror')
   body.ts=store.tick_ts-.48;pump(.001);assert(math.abs(qhit.pos.y-expected[2])>10,'Q paw did not move between poses')
   pass('Q strike follows the original projected GLB hand through raised/slam poses and mirrors correctly')
   for _,spec in ipairs({{'attack',6,2},{'attack2',7,1}})do
    local animation=A.db[body.prefix..'_'..spec[1]];local frames=animation.frames;local seen={}
    for _,f in ipairs(frames)do seen[f]=true end;for f=1,22 do assert(seen[f],'Normal attack lost an exported pose')end
    local name=A:fn(body.prefix..'_'..spec[1],.35,false,#frames)
    assert(tonumber(name:match('_(%d+)$'))==spec[2],'Attack contact is not synchronized')
    h=reset(113);body=h.render.sprites[1];body.name=spec[1];body.ts=store.tick_ts-.35;body.fps=#frames;Movement.update(h,store,h.boss_state)
    target=enemy(1,95);FX.strike(h,store,target);pump(.001)
    local slash;for _,e in ipairs(inserted)do if e.kind=='slash'then slash=e end end
    local points=require('volibear_vfx_anchors')[name];assert(math.abs(slash.pos.x-points[spec[3]*2-1])<.001 and slash.pos.x>60,'Wrong attacking hand')
   end
   pass('Normal attack contact is retimed to the unchanged damage tick; right/left attacking bones and all 22 poses are preserved')
   do
    local animation=A.db[body.prefix..'_w'];local name=A:fn(body.prefix..'_w',.25,false,#animation.frames/.75)
    assert(name=='volibear_w_slash_0006','W contact is not synchronized')
    local seen={};for _,f in ipairs(animation.frames)do seen[f]=true end;for f=1,21 do assert(seen[f])end
   end
   pass('W visual contact matches the existing 0.25-second hit and preserves all 21 original poses')
   h=reset(115);target=enemy(1,40);h.boss_state.marks[target.id]=123
   FX.mark(h,store,target);FX.emit(h,store,'p_charge',{follow_id=h.id})
   h.boss_state={born=115,last={}};pump();assert(not next(visuals),'Effects survived reset state')
   pass('Partially rebuilt respawn state safely stops old marks and charged aura')
   h=reset(120);target=enemy(1,40)
   for _,kind in ipairs({'aura','windup','slash','hit','chain','p_charge','q_cast','q_charge','q_step','q_swing','q_hit','q_impact','w_hit','w_mark','w_chomp','heal','e_warning','e_hit','e_ground','shield','shield_hit','shield_break','r_warning','r_leap','r_hit','r_ground','r_form','r_end','death','respawn'})do
    if kind=='p_charge'then h.boss_state.stacks=5;h.boss_state.stack_end=126 end
    h.boss_state.q_end=124;h.boss_state.shield=10;h.boss_state.shield_end=123
    FX.emit(h,store,kind)
   end
   for _=1,420 do pump()end;assert(not next(visuals),'Effect did not expire')
   pass('All 30 effect types expire; sprites have no combat/targeting components')
   local weak=setmetatable({},{__mode='v'})
   for i=1,20 do
    local h=reset(150+i);local target=enemy(1,40);h.boss_state.marks[target.id]=store.tick_ts+8;FX.mark(h,store,target)
    weak[i]=store;weak[100+i]=h;weak[200+i]=target
   end
   store,visuals,inserted=nil,nil,nil;collectgarbage();collectgarbage();assert(not next(weak),'VFX retained old stores/actors')
   pass('20 discarded stores, Volibears and marked enemies collected; no saved state or global actor cache')
   local complete=assert(love.filesystem.load('vfxassets/go_volibear_vfx_complete.lua'))();local count=0
   local data=love.image.newImageData('vfxassets/go_volibear_vfx_complete.png')
   for name,ss in pairs(complete)do
    count=count+1;local q=ss.f_quad;assert(I:s(name)and I:i(ss.a_name:gsub('%.png$','')))
    assert(q[1]>=0 and q[2]>=0 and q[1]+q[3]<=1024 and q[2]+q[4]<=1024)
    local lit=false;for y=0,q[4]-1,3 do for x=0,q[3]-1,3 do local _,_,_,a=data:getPixel(q[1]+x,q[2]+y);lit=lit or a>30 end end
    assert(lit,'Empty complete VFX tile '..name)
   end
   assert(count==44)
   local anchor_count=0;for name,points in pairs(require('volibear_vfx_anchors'))do
    assert(I:s(name),'Bone projection has no rendered pose '..name);assert(#points==10)
    for _,v in ipairs(points)do assert(v==v and math.abs(v)<4096)end;anchor_count=anchor_count+1
   end
   assert(anchor_count==1077)
   pass('44 additional texture/mesh tiles decode and 1077 bone projections resolve to real body poses')
   for i=0,7 do
    local h=reset(700+i);local sp=h.render.sprites[1];sp.name='walk';sp.loop=true;h.motion.arrived=false
    local a=i*math.pi/4;h.motion.dest={x=100*math.cos(a),y=100*math.sin(a)};def.hold(h,store)
    local aura;for _,v in pairs(visuals)do if v.e.kind=='aura'then aura=v.e end end;assert(aura)
    pump(.1);renderer:on_render_update(TICK_LENGTH,store.tick_ts,store)
    local frame=A:fni(sp.animation,store.tick_ts-sp.ts,true,sp.fps);local projected=require('volibear_vfx_anchors')[frame]
    for j,point in ipairs({4,5,1,2})do local layer=aura.render.sprites[j]
     assert(math.abs(layer.offset.x-projected[point*2-1])<.001 and math.abs(layer.offset.y-projected[point*2])<.001,'Aura attachment wrong in direction '..i)
    end
   end
   pass('Hand and shoulder auras attach to actual model bones in all eight views')
   do
    local h=reset(720);h.render.sprites[1].name='idle';local s=h.boss_state;s.q_end=724
    for _=1,20 do pump(.1);FX.tick(h,store)end;assert(not kinds().q_step,'Stationary Q produced footprints')
    local step_count=0
    for _=1,8 do h.pos.x=h.pos.x+25;pump(.13);FX.tick(h,store);step_count=step_count+1 end
    assert(kinds().q_step==step_count)
    local s1,s2;for _,e in ipairs(inserted)do if e.kind=='q_step'then s1,s2=s2,e end end
    assert(s1.pos.y*s2.pos.y<0,'Footprints did not alternate feet')
    s.q_end=nil;pump();local n=kinds().q_step;h.pos.x=h.pos.x+50;FX.tick(h,store);assert(kinds().q_step==n)
   end
   pass('Q footprints are distance/time limited, alternate feet and stop when stationary or expired')
   do
    local h=reset(730);local sp=h.render.sprites[1];sp.name='attack';sp.ts=store.tick_ts;sp.animation=nil;Movement.update(h,store,h.boss_state);FX.tick(h,store);pump(.05)
    local wind;for _,e in ipairs(inserted)do if e.kind=='windup'then wind=e end end;assert(wind and not wind.pending_removal)
    h.unit.is_stunned=true;pump();assert(wind.pending_removal,'Interrupted attack left a trail')
    h=reset(735);local first=enemy(1,30);local second=enemy(2,80)
    FX.chain(h,store,{x=0,y=75,id=h.id},first);FX.chain(h,store,{x=30,y=20,id=first.id},second)
    pump(.05);local link=inserted[#inserted];local old_x=link.pos.x
    second.pos.x=120;pump(.03);assert(link.pos.x>old_x,'Chain did not follow target')
    second.health.dead=true;pump();assert(link.pending_removal)
   end
   pass('Attack windup cancels on stun; chain lightning follows moving endpoints and stops on dead targets')
   do
    local h=reset(738);local target=enemy(1,50);local other=E:create_entity(def.name);other.pos={x=10,y=0};store.entities[other.id]=other;def.hold(other,store)
    h.boss_state.marks[target.id]=746;other.boss_state.marks[target.id]=746
    FX.mark(h,store,target);FX.mark(other,store,target);pump(.1)
    local first=h.boss_state.vfx_marks[target.id];local second=other.boss_state.vfx_marks[target.id]
    assert(first~=second and store.entities[first]and store.entities[second])
    h.health.dead=true;pump();assert(not store.entities[first]and store.entities[second],'One owner removed another owner mark')
    FX.mark(other,store,target);assert(other.boss_state.vfx_marks[target.id]==second)
   end
   pass('Two Volibears keep independent W marks on one target; death and refresh affect only their own mark')
   do
    local h=reset(740);h.boss_state.shield=10;h.boss_state.shield_end=743
    local d=E:create_damage();d.damage_type=DAMAGE_PHYSICAL;d.value=100;h.health.on_damage(h,store,d)
    assert(h.boss_state.shield==0 and kinds().shield_break==1)
    h.health.dead=true;FX.tick(h,store);FX.tick(h,store);assert(kinds().death==1)
    pump(2);h.health.dead=false;h.health.hp=2695;FX.tick(h,store);assert(kinds().respawn==1)
    def.respawn(h);FX.tick(h,store);assert(kinds().respawn==2)
    h=reset(750);local target=enemy(1,40);h.boss_state.last.voli_q=750
    run(function()def.automatic(h,store,{target})end);pump(5.1);h.boss_state.last.voli_q=store.tick_ts
    run(function()def.automatic(h,store,{target})end);assert(kinds().w_chomp==1 and kinds().heal==1)
    h=reset(760);run(function()def.active(h,store,{x=50,y=0})end);assert(kinds().r_form==1)
    pump(11);def.hold(h,store);assert(kinds().r_end==1)
   end
   pass('W2 bite/heal, shield break, death/respawn and R sustained/return effects emit once per event')
   do
    local h=reset(800);local heroes={h};local target=enemy(1,65)
    for i=2,8 do enemy(i,65+i*5)end
    for i=2,10 do local b=E:create_entity(def.name);b.pos={x=i*3,y=0};store.entities[b.id]=b;b.nav_rally.new=false;heroes[i]=b;def.hold(b,store)end
    for n=1,1800 do
     for _,b in ipairs(heroes)do
      def.hold(b,store)
      if n%24==0 then local a=b.melee.attacks[b.boss_state.hand];a.fn_damage(b,store,a,target)end
     end
     pump();store.damage_queue={}
     assert(peak<150,'Unbounded effect growth')
    end
    local total=0;for _,v in pairs(visuals)do total=total+1 end
    assert(total<100)
    for _,b in ipairs(heroes)do b.health.dead=true;FX.tick(b,store)end
    for _=1,75 do pump()end;assert(not next(visuals),'Effects survived all owners dying')
    pass('Ten-Volibear 60-second synthetic combat remains bounded (peak '..peak..' effects); all effects release after death')
   end
   -- Preview uses the native atlas lookup, animation database and renderer transforms.
   local RU=require('render_utils');local G=love.graphics;local canvas=G.newCanvas(1200,800)
   G.push('all');G.setCanvas(canvas);G.clear(29,34,43,255);G.setFont(G.newFont(18))
   local function draw(name,pos,sp)
    local ss=assert(I:s(name),name)
    G.setColor(sp.color or {255,255,255});local r,g,b=G.getColor();G.setColor(r,g,b,sp.alpha or 255)
    G.draw(I:i(ss.atlas),RU.frame_draw_params({ss=ss,pos={x=pos.x,y=REF_H-pos.y},offset=sp.offset or {x=0,y=0},anchor=sp.anchor or {x=.5,y=.5},scale=sp.scale or {x=1,y=1},r=sp.r or 0,flip_x=sp.flip_x}))
   end
   G.setCanvas();G.pop()
   local scenes={
    {title='ATTACK / CLAW TRAIL',name='attack',elapsed=.30,duration=1.1,kind='attack'},
    {title='PASSIVE / 5 STACKS + CHAIN',name='attack2',elapsed=.28,duration=1.1,kind='passive'},
    {title='Q / RUN + PAWPRINTS',name='walk',elapsed=.2,kind='qrun'},
    {title='Q / PAW SLAM AT 0.30s',name='q_attack',elapsed=.3,duration=.5,kind='qhit'},
    {title='W1 / SCRATCH + MARK',name='w',elapsed=.2,duration=.75,kind='w1'},
    {title='W2 / BEAR BITE + HEAL',name='w',elapsed=.2,duration=.75,kind='w2'},
    {title='E / WARNING + DRAGON',name='e_idle',elapsed=.3,duration=.8,kind='ewarn',sample=.9},
    {title='E / BOLT + GROUND IMPACT',name='e_idle',elapsed=.3,duration=.8,kind='ehit'},
    {title='E / SHIELD TAKING A HIT',name='idle',elapsed=.2,kind='shield'},
    {title='R / ASCENT',name='jump',elapsed=.3,duration=1,kind='rjump'},
    {title='R / LANDING SHOCKWAVE',name='land',elapsed=0,duration=.25,kind='rhit'},
    {title='R / 12-SECOND EMPOWERED FORM',name='walk',elapsed=.2,kind='rform'},
    {title='R / FORM ENDS',name='idle',elapsed=.2,kind='rend'},
    {title='DEATH / SPIRIT DISSIPATES',name='death',elapsed=.8,duration=5.3,kind='death'},
    {title='RESPAWN / RETURNING LIGHT',name='idle',elapsed=.2,kind='respawn'}
   }
   local function compose(list,phase)
    local sheet=G.newCanvas(1200,math.ceil(#list/3)*360)
    G.push('all');G.setCanvas(sheet);G.clear(27,34,43,255);G.setFont(G.newFont(15))
    for index,scene in ipairs(list)do
     local col,row=(index-1)%3,math.floor((index-1)/3);local bx,by=col*400+135,row*360+315
     G.setScissor(col*400,row*360,400,360)
     G.setColor(68,82,94,255);G.line(col*400+8,by,col*400+392,by)
     G.setColor(238,221,190,255);G.print(scene.title,col*400+14,row*360+12)
     local h=reset(200);local target=enemy(1,95);local s=h.boss_state;local body=h.render.sprites[1]
     body.name=scene.name;body.loop=scene.name=='idle'or scene.name=='walk';body.flip_x=false
     s.q_end=204;s.shield=100;s.shield_end=203;s.marks[target.id]=208
     if scene.kind:sub(1,1)=='r'and scene.kind~='rend'and scene.kind~='respawn'then s.ult_end=212 end
     h.motion.dest={x=200,y=0};h.motion.arrived=false
     Movement.update(h,store,s)
     if scene.duration then body.fps=#A.db[body.prefix..'_'..body.name].frames/scene.duration end
     body.ts=200-scene.elapsed-(phase or 0)*.12
     if scene.kind=='rjump'then body.offset.y=48 end
     if scene.kind=='passive'then
      s.stacks=5;s.stack_end=206;FX.tick(h,store);local endpt=FX.chain(h,store,{x=0,y=75,id=h.id},target)
      local second=enemy(2,180);FX.chain(h,store,endpt,second)
     elseif scene.kind=='attack'then FX.strike(h,store,target)
     elseif scene.kind=='qrun'then
      FX.emit(h,store,'q_charge',{follow_id=h.id,face=true})
      FX.emit(h,store,'q_step',{pos={x=-45,y=8},angle=-math.pi/2});FX.emit(h,store,'q_step',{pos={x=-70,y=-8},angle=-math.pi/2})
     elseif scene.kind=='qhit'then FX.strike(h,store,target,'q_hit')
     elseif scene.kind=='w1'or scene.kind=='w2'then
      FX.strike(h,store,target,'w_hit',scene.kind=='w2');FX.mark(h,store,target)
      if scene.kind=='w2'then FX.emit(h,store,'heal',{follow_id=h.id,face=true,y=65})end
     elseif scene.kind=='ewarn'then FX.emit(h,store,'e_warning',{pos=target.pos})
     elseif scene.kind=='ehit'then FX.emit(h,store,'e_hit',{pos=target.pos});FX.emit(h,store,'e_ground',{pos=target.pos})
     elseif scene.kind=='shield'then FX.emit(h,store,'shield',{follow_id=h.id,face=true,y=70});FX.shield_damage(h,store,false)
     elseif scene.kind=='rjump'then FX.emit(h,store,'r_leap',{follow_id=h.id,face=true,y=65});FX.emit(h,store,'r_warning',{pos=target.pos})
     elseif scene.kind=='rhit'then FX.emit(h,store,'r_ground');FX.emit(h,store,'r_hit')
     elseif scene.kind=='rform'then FX.tick(h,store)
     elseif scene.kind=='rend'then FX.emit(h,store,'r_end')
     elseif scene.kind=='death'then h.health.dead=true;FX.tick(h,store)
     elseif scene.kind=='respawn'then FX.emit(h,store,'respawn')end
     pump(scene.sample or .09+(phase or 0)*.15)
     local function effects(ground)
      for _,v in pairs(visuals)do local e=v.e
       for _,sp in ipairs(e.render.sprites)do if(sp.z==Z_DECALS)==ground then
        local name=sp.animated and A:fn(sp.name,store.tick_ts-sp.ts,sp.loop,sp.fps)or sp.name
        draw(name,{x=bx+e.pos.x,y=by-e.pos.y},sp)
       end end
      end
     end
     effects(true)
     local name=body.animation and A:fni(body.animation,store.tick_ts-body.ts,body.loop,body.fps)or A:fn(body.prefix..'_'..body.name,store.tick_ts-body.ts,body.loop,body.fps)
     draw(name,{x=bx,y=by},body);effects(false)
     if scene.kind=='passive'or scene.kind=='qhit'or scene.kind=='w1'or scene.kind=='w2'or scene.kind=='ewarn'or scene.kind=='ehit'then
      G.setColor(163,94,89,180);G.circle('line',bx+target.pos.x,by,12,24)
     end
     G.setScissor()
    end
    G.setCanvas();G.pop();return sheet
   end
   local sheet=compose(scenes,0);write(pack..'/XEM_TRUOC_VFX.png',sheet:newImageData():encode('png'):getString());sheet=nil
   for i=1,24 do
    local frame=compose({scenes[1],scenes[2],scenes[4],scenes[6],scenes[8],scenes[12]},(i-1)/23)
    write(task..'/preview_frames/'..string.format('%03d.png',i),frame:newImageData():encode('png'):getString());frame=nil;if i%4==0 then collectgarbage()end
   end
   pass('Fifteen native renderer panels and 24 animated preview frames generated from actual bone attachments')
   local sheet=G.newCanvas(2048,1088)
   G.push('all');G.setCanvas(sheet);G.clear(28,34,43,255);G.setFont(G.newFont(16))
   for row,mode in ipairs({'normal','q','r','idle'})do for i=0,7 do
    local h=reset(500);local sp=h.render.sprites[1];local s=h.boss_state
    sp.name=mode=='idle'and 'idle'or 'walk';sp.loop=true;h.motion.arrived=false
    local angle=i*math.pi/4;h.motion.dest={x=200*math.cos(angle),y=200*math.sin(angle)};s.move_direction=i
    if mode=='q'then s.q_end=504 elseif mode=='r'then s.ult_end=512;h.health.hp_max=3220 end
    def.hold(h,store);store.tick_ts=500.27;def.hold(h,store)
    local name=A:fni(sp.animation,store.tick_ts-sp.ts,true,30)
    local x,y=i*256+128,(row-1)*272+232
    G.setColor(67,82,97,255);G.line(i*256,y,(i+1)*256,y);G.circle('line',x,y,18,30)
    G.setColor(130,155,173,255);G.line(x,y,x+28*math.cos(angle),y-28*math.sin(angle))
    draw(name,{x=x,y=y},sp)
    G.setColor(240,225,195,255);G.print(mode:upper()..' / '..directions[i+1]:upper(),i*256+12,(row-1)*272+10)
   end end
   G.setCanvas();G.pop();write(pack..'/XEM_TRUOC_8_HUONG.png',sheet:newImageData():encode('png'):getString())
   pass('Eight-direction native renderer contact sheet generated for all four locomotion/idle rows')
   for _,name in ipairs(def.textures)do I:queue_unload_atlas(name,1)end
   while not I:queue_unload_done()do end
   for _,ss in pairs(I.db_atlas)do assert(ss.atlas~='go_volibear_original_vfx','VFX atlas retained after unload')end
   assert(not I.db_images.go_volibear_original_vfx)
   for _=1,3 do
    for _,tag in ipairs({'original_vfx','vfx_complete','walk8','qrun8','rrun8','idle8'})do I:queue_load_atlas(1,'vfxassets','go_volibear_'..tag)end
    while not I:queue_load_done()do love.event.pump();love.timer.sleep(.001)end
    assert(I:s('voli_original_e_bolt_0001'))
    for _,tag in ipairs({'original_vfx','vfx_complete','walk8','qrun8','rrun8','idle8'})do I:queue_unload_atlas('go_volibear_'..tag,1)end
    while not I:queue_unload_done()do end
    assert(not I.db_images.go_volibear_vfx_complete and not I.db_images.go_volibear_original_vfx and not I.db_images.go_volibear_walk8 and not I.db_images.go_volibear_qrun8 and not I.db_images.go_volibear_rrun8 and not I.db_images.go_volibear_idle8)
   end
   pass('All six VFX/locomotion atlases unload and reload cleanly on three cycles with eight image workers')
  end
 end,debug.traceback)
 if not ok then notes[#notes+1]='FAIL '..err end
 local tag=baseline and 'baseline' or 'candidate'
 write(task..'/'..tag..'_result.txt',table.concat(notes,'\n'))
 write(task..'/'..tag..'_gameplay.txt',table.concat(snapshots,'\n'))
 love.event.quit()
end
