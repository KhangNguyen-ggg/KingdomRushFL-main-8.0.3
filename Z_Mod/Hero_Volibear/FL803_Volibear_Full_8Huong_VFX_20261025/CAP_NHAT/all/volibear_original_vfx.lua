-- Original skin09 textures, composed as short-lived KR sprites; never deals damage.
local M={}
local E,I,V,A
local gold,white,violet={255,202,115},{255,243,215},{192,155,255}
-- Paw centers measured in the existing 512px Q export, before its horizontal mirror.
local q_hands={{248,241},{246,122},{288,26},{307,20},{308,38},{312,34},{283,65},{199,340}}
local plans={
 slash={life=.24,layers={{"claw",105,82,color=gold,spin=2},{"trail",115,52,color=white,alpha=155}}},
 hit={life=.20,layers={{"flare",60,60,color=gold,grow=.7},{"spark",32,32,color=white}}},
 chain={life=.18,layers={{"chain",100,15,color=white,alpha=220}}},
 p_charge={life=.65,flag="passive",layers={{"flame",70,70,x=-27,color=gold,animated=true},{"flame",62,62,x=30,color=violet,animated=true,alpha=155}}},
 q_charge={life=4,flag="q",layers={{"flame",110,110,color=gold,animated=true,alpha=180},{"trail",155,65,x=-35,color=white,alpha=150},{"paw",75,40,y=-60,ground=true,color=gold,alpha=120}}},
 q_hit={life=.32,layers={{"claw",145,110,color=gold,spin=3},{"impact",95,95,color=white,animated=true}}},
 w_hit={life=.32,layers={{"w_bite",105,95,color=gold,grow=.35},{"impact",75,85,color=white,animated=true}}},
 w_mark={life=8,layers={{"mark",32,32,color=gold,alpha=230}}},
 heal={life=.6,layers={{"flame",105,125,color=gold,animated=true,alpha=160},{"spark",42,65,y=30,color=white,grow=.3}}},
 e_warning={life=2,layers={{"e_ring",162,86,ground=true,color=gold},{"r_warning",162,86,ground=true,color=white,alpha=175}}},
 e_hit={life=.55,layers={{"e_bolt",62,300,y=145,color=gold,alpha=240},{"e_hit",42,265,y=125,color=white},{"e_ring",180,96,ground=true,color=gold,grow=.5},{"cloud",125,80,y=18,animated=true,alpha=135}}},
 shield={life=3,flag="shield",layers={{"shield",140,165,color=gold,spin=.6,alpha=160},{"shield",130,155,color=white,spin=-.8,alpha=115}}},
 r_warning={life=1,layers={{"r_warning",250,132,ground=true,color=gold},{"r_ring",250,132,ground=true,color=white,alpha=150}}},
 r_leap={life=1,layers={{"flame",155,160,color=gold,animated=true,alpha=150},{"r_trail",175,85,x=-35,color=violet,alpha=150}}},
 r_hit={life=.85,layers={{"r_crater",260,140,ground=true,alpha=180},{"r_cracks",265,145,ground=true,color=gold},{"r_ring",300,160,ground=true,color=white,grow=.85},{"impact",160,130,y=35,animated=true,color=gold}}}
}
local function alive(e)return e and not e.pending_removal and e.health and not e.health.dead and e.health.hp>0 end
local function facing_left(body)
 local direction=body.volibear_move_direction
 if direction~=nil then return direction>=3 and direction<=5 end
 return body.flip_x or false
end
local function remove(e,store)
 if e.kind=="w_mark" then
  local owner=store.entities[e.owner_id];local s=owner and owner.boss_state
  if s and s.vfx_marks and s.vfx_marks[e.follow_id]==e.id then s.vfx_marks[e.follow_id]=nil end
 end
 require("simulation"):queue_remove_entity(e)
end
local function update(e,store)
 local plan=plans[e.kind]
 while store.tick_ts-e.started<e.life do
  local owner=store.entities[e.owner_id];local s=owner and owner.boss_state
  if plan.flag and (not alive(owner) or not s or plan.flag=="q" and not s.q_end or
   plan.flag=="passive" and ((s.stacks or 0)<5 or store.tick_ts>=(s.stack_end or 0)) or
   plan.flag=="shield" and (store.tick_ts>=(s.shield_end or 0) or (s.shield or 0)<=0)) then break end
  if e.kind=="w_mark" and (not alive(owner) or not s or not s.marks or (s.marks[e.follow_id] or 0)<=store.tick_ts)then break end
  if e.follow_id then
   local target=store.entities[e.follow_id]
   if not alive(target)then break end
   local body=target.render and target.render.sprites[1]
   local sign=e.face and body and facing_left(body) and -1 or 1
   if e.kind=="q_hit" and body.name=="q_attack" then
    local name=A:fn(body.prefix.."_q_attack",store.tick_ts-body.ts,false,body.fps)
    local hand=q_hands[tonumber(name:match('_(%d+)$'))]
    local size=math.abs(body.scale.y)
    e.dx,e.dy=(266-hand[1])*size,(331-hand[2])*size
   end
   e.pos.x=target.pos.x+sign*e.dx;e.pos.y=target.pos.y+e.dy+(e.face and body.offset.y or 0)
   if e.face and body then for _,sprite in ipairs(e.render.sprites)do sprite.flip_x=facing_left(body) end end
  end
  local elapsed=store.tick_ts-e.started;local t=elapsed/e.life
  local fade=math.min(1,elapsed/.04)*math.min(1,(e.life-elapsed)/math.min(.15,e.life*.4))
  for i,sprite in ipairs(e.render.sprites)do
   local layer=plan.layers[i];local grow=layer.grow and (.6+layer.grow*t) or 1
   sprite.alpha=math.floor((layer.alpha or 220)*fade)
   sprite.scale.x=e.scales[i].x*grow;sprite.scale.y=e.scales[i].y*grow
   sprite.r=e.angle+(layer.ground and 0 or layer.spin or 0)*elapsed*(sprite.flip_x and -1 or 1)
   sprite.offset.x=(layer.x or 0)*e.size*(e.face and sprite.flip_x and -1 or 1)
   sprite.offset.y=(layer.y or 0)*e.size
   if e.kind=="q_charge" and owner.render.sprites[1].volibear_move_direction~=nil then
    local angle=owner.render.sprites[1].volibear_move_direction*math.pi/4
    if i==2 then
     sprite.r=angle;sprite.flip_x=false
     sprite.offset.x=-35*math.cos(angle);sprite.offset.y=-35*math.sin(angle)
    elseif i==3 then sprite.r=angle-math.pi/2;sprite.flip_x=false end
   end
  end
  coroutine.yield()
 end
 remove(e,store)
end
function M.register()
 E,I,V,A=require("entity_db"),require("klove.image_db"),require("klua.vector"),require("animation_db")
 for name,count in pairs({flame=8,impact=4,cloud=4})do
  local frames={};for i=1,count do frames[i]=i end
  A.db["voli_original_"..name]={prefix="voli_original_"..name,frames=frames}
 end
 if E.entities.volibear_original_vfx then return end
 local t=E:register_t("volibear_original_vfx","decal_scripted")
 t.main_script.insert=nil;t.main_script.update=update
end
function M.emit(owner,store,kind,opts)
 opts=opts or {};local plan=assert(plans[kind],kind)
 local e=E:create_entity("volibear_original_vfx")
 e.kind,e.owner_id,e.follow_id,e.face=kind,owner.id,opts.follow_id,opts.face
 e.pos=V.vclone(opts.pos or owner.pos);e.dx,e.dy=opts.x or 0,opts.y or 0
 e.started,e.life,e.angle=store.tick_ts,plan.life,opts.angle or 0
 e.render.sprites={};e.scales={}
 local size=opts.size or 1;e.size=size
 for i,layer in ipairs(plan.layers)do
  local sp=E:clone_c("sprite");local name="voli_original_"..layer[1]
  local ss=assert(I:s(name.."_0001"),"Missing Volibear VFX texture: "..name)
  sp.animated,sp.loop=layer.animated or false,layer[1]=="flame"
  sp.name=sp.animated and name or name.."_0001";sp.ts=store.tick_ts
  sp.fps=layer[1]=="flame" and 12 or 4/plan.life
  sp.anchor=V.v(.5,.5);sp.offset=V.v((layer.x or 0)*size,(layer.y or 0)*size)
  sp.scale=V.v((opts.width or layer[2])*size/ss.size[1],layer[3]*size/ss.size[2])
  e.scales[i]=V.vclone(sp.scale);sp.r=e.angle;sp.alpha=0;sp.color=layer.color
  sp.flip_x=opts.face and facing_left(owner.render.sprites[1]) or false
  sp.z=layer.ground and Z_DECALS or Z_OBJECTS+1
  e.render.sprites[i]=sp
 end
 if e.follow_id then
  local target=store.entities[e.follow_id]
  if target then e.pos.x=target.pos.x+(e.face and facing_left(target.render.sprites[1]) and -1 or 1)*e.dx;e.pos.y=target.pos.y+e.dy end
 end
 require("simulation"):queue_insert_entity(e)
 return e
end
function M.strike(owner,store,target,kind)
 local size=owner.boss_state and owner.boss_state.ult_end and 1.25 or 1
 M.emit(owner,store,kind or "slash",{follow_id=owner.id,face=true,x=42*size,y=75*size,size=size})
 local offset=target.unit and target.unit.hit_offset or {x=0,y=20}
 M.emit(owner,store,"hit",{pos={x=target.pos.x+offset.x,y=target.pos.y+offset.y}})
end
function M.chain(owner,store,from,target)
 local offset=target.unit and target.unit.hit_offset or {x=0,y=20}
 local finish={x=target.pos.x+offset.x,y=target.pos.y+offset.y}
 local dx,dy=finish.x-from.x,finish.y-from.y
 M.emit(owner,store,"chain",{pos={x=(from.x+finish.x)/2,y=(from.y+finish.y)/2},width=math.max(8,math.sqrt(dx*dx+dy*dy)),angle=math.atan2(dy,dx)})
 return finish
end
function M.mark(owner,store,target)
 local s=owner.boss_state;s.vfx_marks=s.vfx_marks or {}
 local previous=store.entities[s.vfx_marks[target.id] or -1]
 if previous and not previous.pending_removal then previous.started=store.tick_ts;return end
 local offset=target.health_bar and target.health_bar.offset.y or 30
 local e=M.emit(owner,store,"w_mark",{follow_id=target.id,y=offset+12})
 s.vfx_marks[target.id]=e.id
end
function M.tick(owner,store)
 local s=owner.boss_state
 if alive(owner) and s.stacks>=5 and store.tick_ts<s.stack_end and store.tick_ts>=(s.vfx_charge_at or 0)then
  s.vfx_charge_at=store.tick_ts+.6
  M.emit(owner,store,"p_charge",{follow_id=owner.id,face=true,y=70})
 end
end
return M
