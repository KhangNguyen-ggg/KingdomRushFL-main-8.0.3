-- Skin09 art adapted to KR sprites; visual entities never deal damage or block units.
local M={}
local E,I,V,A
local anchors=require('volibear_vfx_anchors')
local gold,white,violet,peach={255,205,135},{255,245,220},{194,156,229},{255,178,162}
local plans={
 aura={life=12,flag='living',layers={
  {'flame',48,65,attach=4,color=gold,animated=true,alpha=85},{'flame',48,65,attach=5,color=peach,animated=true,alpha=85},
  {'spiral',43,48,attach=1,color=violet,spin=.6,alpha=45},{'spiral',43,48,attach=2,color=gold,spin=-.6,alpha=45}}},
 windup={life=.4,flag='living',layers={{'smoke_lick',28,65,color=gold,alpha=100},{'orb',35,35,color=gold,alpha=90}}},
 slash={life=.28,flag='living',layers={{'claw',82,66,color=gold,spin=2,alpha=190},{'trail',95,40,color=peach,alpha=160}}},
 hit={life=.24,layers={{'flare',55,55,color=gold,grow=.6},{'blast',42,42,color=white,animated=true}}},
 chain={life=.23,layers={{'bolt',100,18,color=gold,alpha=245},{'chain',100,13,color=white,alpha=190}}},
 p_charge={life=.5,flag='living',layers={{'ring_flame',120,64,ground=true,color=gold,grow=.8},{'spark',55,55,y=75,color=white}}},
 q_cast={life=.5,flag='living',layers={{'ring_flame',105,55,ground=true,color=gold,grow=.7},{'smoke',100,65,y=20,animated=true,alpha=135}}},
 q_charge={life=4,flag='q',layers={{'flame',57,70,attach=1,color=gold,animated=true,alpha=170},{'trail',125,52,x=-35,color=white,alpha=100},{'flame',57,70,attach=2,color=peach,animated=true,alpha=170}}},
 q_step={life=.75,layers={{'paw',28,25,ground=true,color=gold,alpha=155},{'paw_spark',35,35,ground=true,color=gold,animated=true,alpha=100}}},
 q_swing={life=.5,flag='q',layers={{'energy_gold',70,90,attach=1,color=gold,alpha=130},{'energy_gold',70,90,attach=2,color=gold,alpha=130}}},
 q_hit={life=.34,flag='living',layers={{'claw',118,95,color=gold,spin=3},{'impact',80,80,color=white,animated=true},{'smoke_lick',35,95,color=peach,alpha=140}}},
 q_impact={life=.42,layers={{'ring_flame',115,60,ground=true,color=gold,grow=.6},{'bolt',110,24,y=25,color=gold},{'blast',80,90,y=30,color=white,animated=true}}},
 w_hit={life=.4,layers={{'scratch',8,85,x=-13,r=-.6,color=gold},{'scratch',8,90,r=-.6,color=peach},{'scratch',8,85,x=13,r=-.6,color=white},{'impact',65,70,animated=true,color=gold}}},
 w_mark={life=8,flag='mark',layers={{'mark',29,32,color=gold,alpha=230},{'orb',35,35,color=peach,alpha=45}}},
 w_chomp={life=.5,flag='living',layers={{'bear',150,150,alpha=200,grow=.7},{'orb',100,85,color=gold,alpha=80},{'paw_spark',75,85,color=white,animated=true}}},
 heal={life=.65,flag='living',layers={{'orb',95,110,color=gold,alpha=75},{'spark',28,28,x=-22,y=20,color=white,drift=50},{'spark',24,24,x=24,y=35,color=gold,drift=40},{'ring_fine',105,56,y=-65,ground=true,color=gold,grow=.7}}},
 e_warning={life=2,layers={{'e_ring',162,86,ground=true,color=gold},{'ring_fine',162,86,ground=true,color=peach,spin=-.6,alpha=140},{'smoke_lick',40,160,y=75,color=gold,alpha=55},{'cloud',130,65,y=6,animated=true,alpha=100},{'dragon',145,100,y=25,orbit=true,alpha=160}}},
 e_hit={life=.65,layers={{'e_bolt',70,330,y=160,color=gold,alpha=245,finish=.35},{'e_hit',42,295,y=142,color=white,finish=.3},{'e_ring',180,96,ground=true,color=gold,grow=.65},{'cloud',150,90,y=20,animated=true,alpha=140},{'crack_ring',170,90,ground=true,color=peach,alpha=160},{'blast',70,100,y=35,animated=true,color=white}}},
 e_ground={life=1.4,layers={{'ground_hole',158,84,ground=true,alpha=120},{'crack_ring',165,87,ground=true,color=gold,alpha=125}}},
 shield={life=3,flag='shield',layers={{'shield',140,163,color=gold,spin=.6,alpha=135},{'shield_edge',145,165,color=peach,spin=-.5,alpha=160},{'spiral',125,143,color=gold,spin=.4,alpha=40}}},
 shield_hit={life=.22,flag='living',layers={{'shield_edge',150,170,color=white,alpha=200},{'spark',38,38,color=gold}}},
 shield_break={life=.4,layers={{'shield_edge',150,170,color=gold,grow=.8,alpha=155},{'smoke',105,100,animated=true,color=peach,alpha=100}}},
 r_warning={life=1,layers={{'r_warning',250,132,ground=true,color=gold},{'r_ring',250,132,ground=true,color=peach,alpha=160},{'ring_fine',250,132,ground=true,color=gold,alpha=120}}},
 r_leap={life=1,flag='living',layers={{'flame',115,125,color=gold,animated=true,alpha=110},{'trail',125,60,x=-35,color=violet,alpha=80},{'smoke_lick',45,125,color=peach,alpha=90}}},
 r_hit={life=.9,layers={{'r_cracks',265,145,ground=true,color=gold},{'r_ring',300,160,ground=true,color=white,grow=.85},{'impact',160,130,y=35,animated=true,color=gold},{'blowback',260,90,y=38,color=gold,grow=.9,alpha=170},{'smoke',245,120,y=35,animated=true,color=peach,alpha=130},{'cylinder',170,190,y=70,color=gold,alpha=120}}},
 r_ground={life=1.6,layers={{'r_crater',260,140,ground=true,alpha=170},{'crack_ring',270,144,ground=true,color=gold,alpha=135}}},
 r_form={life=12,flag='ult',layers={{'ring_fine',130,70,ground=true,color=gold,alpha=70},{'flame',85,110,attach=4,color=gold,animated=true,alpha=150},{'flame',85,110,attach=5,color=peach,animated=true,alpha=145},{'energy',75,85,attach=1,alpha=110},{'energy_gold',75,85,attach=2,color=gold,alpha=115}}},
 r_end={life=.55,layers={{'ring_fine',130,70,ground=true,color=gold,grow=.8,alpha=150},{'smoke',100,120,y=65,color=peach,animated=true,alpha=115}}},
 death={life=1.1,layers={{'smoke',130,150,y=65,color=violet,animated=true,alpha=130},{'smoke_lick',70,140,y=70,color=gold,alpha=115,drift=40},{'ring_fine',120,64,ground=true,color=gold,grow=.5,alpha=125}}},
 respawn={life=.8,flag='living',layers={{'ring_flame',130,70,ground=true,color=gold,grow=.5},{'smoke_lick',55,140,y=75,color=gold,alpha=110},{'spark',70,70,y=90,color=white}}}
}
local function alive(e)return e and not e.pending_removal and e.health and not e.health.dead and e.health.hp>0 end
local function facing_left(body)
 local dir=body.volibear_move_direction
 return dir~=nil and dir>=3 and dir<=5 or dir==nil and body.flip_x or false
end
local function projected(body,now)
 local name=body.animated==false and body.name or body.animation and A:fni(body.animation,now-body.ts,body.loop,body.fps)or A:fn(body.prefix..'_'..body.name,now-body.ts,body.loop,body.fps)
 return anchors[name],body.volibear_move_direction~=nil and math.abs(body.scale.y)or math.abs(body.scale.y)/.68
end
local function point(body,points,scale,index)
 if not points then return 0,70*scale end
 local sign=body.volibear_move_direction==nil and body.flip_x and -1 or 1
 if index==6 then return(points[1]+points[3])*.5*scale*sign,(points[2]+points[4])*.5*scale end
 return points[index*2-1]*scale*sign,points[index*2]*scale
end
local function remove(e,store)
 if e.kind=='w_mark'then
  local owner=store.entities[e.owner_id];local s=owner and owner.boss_state
  if s and s.vfx_marks and s.vfx_marks[e.follow_id]==e.id then s.vfx_marks[e.follow_id]=nil end
 end
 require('simulation'):queue_remove_entity(e)
end
local function valid(e,owner,s,now)
 local flag=plans[e.kind].flag
 if flag and(not alive(owner)or not s or not s.voli_ready)then return false end
 if flag=='q'and(not s.q_end or now>=s.q_end)then return false end
 if flag=='shield'and(now>=(s.shield_end or 0)or(s.shield or 0)<=0)then return false end
 if flag=='ult'and(not s.ult_end or now>=s.ult_end)then return false end
 if flag=='mark'and(not s.marks or(s.marks[e.follow_id]or 0)<=now)then return false end
 if e.cast_name and(owner.unit.is_stunned or owner.render.sprites[1].name~=e.cast_name or owner.render.sprites[1].ts~=e.cast_ts)then return false end
 return true
end
local function update(e,store)
 local plan=plans[e.kind]
 while store.tick_ts-e.started<e.life do
  local owner=store.entities[e.owner_id];local s=owner and owner.boss_state;local now=store.tick_ts
  if not valid(e,owner,s,now)then break end
  local body,points,scale
  if e.follow_id then
   local target=store.entities[e.follow_id];if not alive(target)then break end
   body=target.render and target.render.sprites[1]
   if e.face and body then points,scale=projected(body,now)end
   local dx,dy=e.dx,e.dy
   if e.attach and body then dx,dy=point(body,points,scale,e.attach)
   elseif e.face and body and facing_left(body)then dx=-dx end
   e.pos.x=target.pos.x+dx;e.pos.y=target.pos.y+dy+(e.face and body and body.offset.y or 0)
  end
  if e.target_id then
   local target=store.entities[e.target_id];local from=store.entities[e.from_id]
   if not alive(target)or not alive(from)then break end
   local offset=target.unit.hit_offset;local fo=from.unit.hit_offset
   local ax,ay=from.pos.x+fo.x,from.pos.y+fo.y;local bx,by=target.pos.x+offset.x,target.pos.y+offset.y
   if from.id==e.owner_id then
    local sp=from.render.sprites[1];local positions,size=projected(sp,now);local x,y=point(sp,positions,size,e.origin_hand)
    ax,ay=from.pos.x+x,from.pos.y+y+sp.offset.y
   end
   local dx,dy=bx-ax,by-ay;e.pos.x,e.pos.y=(ax+bx)/2,(ay+by)/2;e.angle=math.atan2(dy,dx)
   for i,sp in ipairs(e.render.sprites)do e.scales[i].x=math.max(8,math.sqrt(dx*dx+dy*dy))/e.widths[i]end
  end
  local elapsed=now-e.started;local t=elapsed/e.life
  for i,sp in ipairs(e.render.sprites)do
   local layer=plan.layers[i];local lt=elapsed-(layer.start or 0);local life=layer.finish or e.life
   local fade=math.max(0,math.min(1,lt/.05)*math.min(1,(life-lt)/math.min(.2,life*.4)))
   local grow=layer.grow and(.6+layer.grow*t)or 1;local alpha=layer.alpha or 220
   if e.kind=='aura'then alpha=alpha*(.45+.11*(s.stacks or 0));grow=.9+.035*(s.stacks or 0)end
   if plan.flag=='ult'or e.kind=='aura'or e.kind=='shield'then alpha=alpha*(.88+.12*math.sin(elapsed*7+i))end
   if e.kind=='chain'then alpha=alpha*(.65+.35*math.abs(math.sin(elapsed*65+i)))end
   sp.alpha=math.floor(alpha*fade);sp.scale.x=e.scales[i].x*grow;sp.scale.y=e.scales[i].y*grow
   local flip=e.face and body and facing_left(body)or false;sp.flip_x=flip
   sp.r=e.angle+(layer.r or 0)*(flip and -1 or 1)+(layer.ground and 0 or layer.spin or 0)*elapsed
   sp.offset.x=(layer.x or 0)*e.size*(flip and -1 or 1);sp.offset.y=((layer.y or 0)+(layer.drift or 0)*elapsed)*e.size
   if layer.attach and body then
    local x,y=point(body,points,scale,layer.attach);sp.offset.x=sp.offset.x+x-e.dx;sp.offset.y=sp.offset.y+y-e.dy
   end
   if layer.ground and e.face and body then sp.offset.y=sp.offset.y-body.offset.y end
   if e.kind=='q_charge'and i==2 and body and body.volibear_move_direction~=nil then
    local a=body.volibear_move_direction*math.pi/4;sp.r=a;sp.flip_x=false;sp.offset.x=-35*math.cos(a);sp.offset.y=-35*math.sin(a)
   end
   if layer.orbit then
    local a=elapsed*math.pi*1.7;sp.offset.x=30*math.cos(a);sp.offset.y=25+15*math.sin(a)
    sp.name=string.format('voli_original_dragon_%04d',math.floor(a/(math.pi/4))%8+1);sp.flip_x=false
   end
   if e.kind=='w_chomp'then
    sp.offset.x=sp.offset.x+(flip and -1 or 1)*elapsed*70
    if layer[1]=='bear'then sp.flip_x=not flip end
   end
  end
  coroutine.yield()
 end
 remove(e,store)
end
function M.register()
 E,I,V,A=require('entity_db'),require('klove.image_db'),require('klua.vector'),require('animation_db')
 for name,count in pairs({flame=8,impact=4,cloud=4,smoke=4,blast=4,paw_spark=4})do
  local frames={};for i=1,count do frames[i]=i end
  A.db['voli_original_'..name]={prefix='voli_original_'..name,frames=frames}
 end
 if E.entities.volibear_original_vfx then return end
 local t=E:register_t('volibear_original_vfx','decal_scripted');t.main_script.insert=nil;t.main_script.update=update
end
function M.emit(owner,store,kind,opts)
 opts=opts or {};local plan=assert(plans[kind],kind);local e=E:create_entity('volibear_original_vfx')
 e.kind,e.owner_id,e.follow_id,e.face=kind,owner.id,opts.follow_id,opts.face;e.attach=opts.attach
 e.pos=V.vclone(opts.pos or owner.pos);e.dx,e.dy=opts.x or 0,opts.y or 0
 e.started,e.life,e.angle=store.tick_ts,opts.life or plan.life,opts.angle or 0;e.cast_name,e.cast_ts=opts.cast_name,opts.cast_ts
 e.render.sprites={};e.scales={};e.widths={};e.size=opts.size or 1
 for i,layer in ipairs(plan.layers)do
  local sp=E:clone_c('sprite');local name='voli_original_'..layer[1]
  local ss=assert(I:s(name..'_0001'),'Missing Volibear VFX texture: '..name)
  sp.animated,sp.loop=layer.animated or false,layer[1]=='flame'
  sp.name=sp.animated and name or name..'_0001';sp.ts=store.tick_ts;sp.fps=sp.loop and 12 or 4/(layer.finish or e.life)
  if layer[1]=='bear'then sp.name='voli_original_bear_0008'end
  sp.anchor=V.v(.5,.5);sp.offset=V.v(0,0);sp.scale=V.v((opts.width or layer[2])*e.size/ss.size[1],layer[3]*e.size/ss.size[2])
  e.scales[i]=V.vclone(sp.scale);e.widths[i]=ss.size[1];sp.r=e.angle;sp.alpha=0;sp.color=layer.color
  sp.flip_x=opts.face and facing_left(owner.render.sprites[1])or false
  sp.z=layer.ground and Z_DECALS or Z_OBJECTS+1;e.render.sprites[i]=sp
 end
 require('simulation'):queue_insert_entity(e);return e
end
function M.strike(owner,store,target,kind,marked)
 local size=owner.boss_state.ult_end and 1.25 or 1;local body=owner.render.sprites[1];local hand=kind=='q_hit'and 6 or body.name=='attack2'and 1 or 2
 if kind=='w_hit'then
  M.emit(owner,store,kind,{follow_id=target.id,y=target.unit.hit_offset.y,size=size})
  if marked then M.emit(owner,store,'w_chomp',{follow_id=owner.id,face=true,attach=3,size=size})end
 else M.emit(owner,store,kind or'slash',{follow_id=owner.id,face=true,attach=hand,size=size})end
 local offset=target.unit and target.unit.hit_offset or{x=0,y=20}
 M.emit(owner,store,'hit',{pos={x=target.pos.x+offset.x,y=target.pos.y+offset.y},size=kind=='q_hit'and 1.3 or 1})
 if kind=='q_hit'then M.emit(owner,store,'q_impact',{pos=target.pos,size=size})end
end
function M.chain(owner,store,from,target)
 local offset=target.unit.hit_offset;local finish={x=target.pos.x+offset.x,y=target.pos.y+offset.y,id=target.id}
 local dx,dy=finish.x-from.x,finish.y-from.y
 local e=M.emit(owner,store,'chain',{pos={x=(from.x+finish.x)/2,y=(from.y+finish.y)/2},width=math.max(8,math.sqrt(dx*dx+dy*dy)),angle=math.atan2(dy,dx)})
 e.from_id,e.target_id=from.id or owner.id,target.id;e.origin_hand=owner.render.sprites[1].name=='attack2'and 1 or 2;return finish
end
function M.mark(owner,store,target)
 local s=owner.boss_state;s.vfx_marks=s.vfx_marks or{}
 local previous=store.entities[s.vfx_marks[target.id]or -1]
 if previous and not previous.pending_removal then previous.started=store.tick_ts;return end
 local e=M.emit(owner,store,'w_mark',{follow_id=target.id,y=(target.health_bar and target.health_bar.offset.y or 30)+12});s.vfx_marks[target.id]=e.id
end
function M.shield_damage(owner,store,broken)
 local s=owner.boss_state
 if broken or store.tick_ts>=(s.vfx_shield_hit_at or 0)then
  s.vfx_shield_hit_at=store.tick_ts+.12;M.emit(owner,store,broken and'shield_break'or'shield_hit',{follow_id=owner.id,face=true,y=70})
 end
end
function M.tick(owner,store)
 local s=owner.boss_state;local now=store.tick_ts
 if not alive(owner)then
  if not s.vfx_dead then s.vfx_dead=true;M.emit(owner,store,'death')end
  return
 end
 if s.vfx_dead then s.vfx_dead=nil;M.emit(owner,store,'respawn')end
 if owner.volibear_vfx_respawn then owner.volibear_vfx_respawn=nil;M.emit(owner,store,'respawn')end
 if now>=(s.vfx_aura_at or 0)then s.vfx_aura_at=now+12;M.emit(owner,store,'aura',{follow_id=owner.id,face=true})end
 if(s.stacks or 0)>=5 and not s.vfx_charged then M.emit(owner,store,'p_charge')end;s.vfx_charged=(s.stacks or 0)>=5
 if s.ult_end and not s.vfx_ult then
  s.vfx_ult=M.emit(owner,store,'r_form',{follow_id=owner.id,face=true,life=s.ult_end-now}).id
 elseif not s.ult_end and s.vfx_ult then s.vfx_ult=nil;M.emit(owner,store,'r_end')end
 local body=owner.render.sprites[1]
 if(body.name=='attack'or body.name=='attack2'or body.name=='q_attack')and s.vfx_attack_ts~=body.ts then
  s.vfx_attack_ts=body.ts;local kind=body.name=='q_attack'and'q_swing'or'windup'
  local life=kind=='windup'and math.max(1/30,#A.db[body.prefix..'_'..body.name].frames/(body.fps or FPS)*.35-(now-body.ts))or nil
  M.emit(owner,store,kind,{follow_id=owner.id,face=true,attach=kind=='windup'and(body.name=='attack2'and 1 or 2)or nil,life=life,cast_name=body.name,cast_ts=body.ts})
 end
 if s.q_end then
  local previous=s.vfx_step_pos
  if not previous then s.vfx_step_pos=V.vclone(owner.pos)
  elseif now>=(s.vfx_step_at or 0)and(owner.pos.x-previous.x)^2+(owner.pos.y-previous.y)^2>=20^2 then
   local a=math.atan2(owner.pos.y-previous.y,owner.pos.x-previous.x);s.vfx_step_side=not s.vfx_step_side;local side=s.vfx_step_side and 9 or -9
   M.emit(owner,store,'q_step',{pos={x=owner.pos.x-side*math.sin(a),y=owner.pos.y+side*math.cos(a)},angle=a-math.pi/2})
   s.vfx_step_pos=V.vclone(owner.pos);s.vfx_step_at=now+.12
  end
 else s.vfx_step_pos=nil end
end
return M
