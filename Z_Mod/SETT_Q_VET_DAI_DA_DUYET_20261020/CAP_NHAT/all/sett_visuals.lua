-- Short-lived, render-only Spirit Blossom effects; no combat or targeting flags.
local E,U,V,I,A
local M={}
local effects={
 punch_left={frame=5,life=11/FPS,width=60,height=52,strike=true,basic=true},
 punch_right={frame=1,life=11/FPS,width=69,height=59.8,strike=true,basic=true},
 punch_impact={frame=9,life=8/FPS,width=52,height=52,basic=true},
 heal={frame=9,life=8/FPS,width=38,height=38,basic=true,healing=true},
 q_left={frame=1,life=11/FPS,width=46.75,height=37.4,q=true,strike=true},
 q_right={frame=5,life=12/FPS,width=50.15,height=40.8,q=true,strike=true},
 palm={frame=1,life=0.24,width=65,height=45},
 palm_blue={frame=2,life=0.24,width=60,height=42},
 arm={frame=3,life=0.5,width=105,height=55},
 ring={frame=4,life=0.65,width=250,height=120,ground=true},
 wave={frame=5,life=0.42,width=200,height=115},
 shield={frame=6,life=0.65,width=100,height=110},
 petal={frame=7,life=0.75,width=13,height=13},
 impact={frame=8,life=0.5,width=150,height=85,ground=true}
}
local function remove(e) require("simulation"):queue_remove_entity(e) end
local function alive(e) return e and not e.pending_removal and e.health and not e.health.dead end
-- Hand centers calibrated against the two existing combat sprite rows.
local blue_hand={x={-5,-11,-11,26,27,29,19,15,-2},y={22,29,29,22,22,25,25,23,20}}
local purple_hand={x={17,-9,-9,-1,26,31,20,14,18},y={27,28,28,32,22,21,20,18,20}}
local q_hands={
 q_left={x={17,-10,-10,22,25,26,4,13,18},y={27,32,32,27,26,24,26,20,23}},
 q_right={x={-5,-10,-10,26,27,29,19,15,-2},y={23,29,29,24,24,25,23,20,20}}
}
local q_centers={{166,96},{165,96},{166,96},{166,96},{96,68},{94,68},{90,68},{95,68},{100,61},{92,55},{92,55},{95,61},{96,59},{96,59},{96,59},{96,59}}
local function attach_hand(e,owner,now)
 local sp=e.render.sprites[1];local body=owner.render.sprites[1]
 local tick=math.max(1,math.ceil((now-e.started)*FPS+1e-9));local frame=math.min(9,tick)
 sp.flip_x=body.flip_x or false;sp.r=0
 local hand=(e.strike_animation=="attack" or e.strike_animation=="q_left") and purple_hand or blue_hand
 if q_hands[e.effect_kind] then
  hand=q_hands[e.effect_kind]
  local frames=A.db[sp.name].frames;local n=frames[math.min(#frames,tick)]
  local ss=I:s(string.format("sett_q_palm_%04i",n));local center=q_centers[n]
  sp.anchor=V.v(center[1]/ss.size[1],1-center[2]/ss.size[2])
  local tail=e.render.sprites[2]
  if tail then
   local seam=n<=4 and 112 or 68
   tail.anchor=V.v(seam/ss.size[1],sp.anchor.y);tail.flip_x=sp.flip_x
   tail.offset.x=sp.offset.x+(sp.flip_x and -1 or 1)*(seam-center[1])*e.sx*(ss.ref_scale or 1)
   tail.offset.y=sp.offset.y
  end
 end
 e.pos.x=owner.pos.x+(sp.flip_x and -1 or 1)*hand.x[frame]
 e.pos.y=owner.pos.y+hand.y[frame]
end
local function update(e,store)
 local sp=e.render.sprites[1];local plan=effects[e.effect_kind]
 local began=e.started or store.tick_ts
 while store.tick_ts-began<e.life do
  local t=(store.tick_ts-began)/e.life
  local owner=store.entities[e.owner_id]
  if plan.basic and not plan.healing and alive(owner) then
   local name=owner.render.sprites[1].name
   if name=="q_left" or name=="q_right" then break end
  end
  if plan.strike then
   if not alive(owner) or owner.unit.is_stunned or owner.nav_rally.new then break end
   if t<0.4 and owner.render.sprites[1].name~=e.strike_animation then break end
   attach_hand(e,owner,store.tick_ts)
  end
  if e.follow then
   if not alive(owner) then break end
   e.pos.x,e.pos.y=owner.pos.x,owner.pos.y
  end
  if plan.healing then sp.offset.y=e.heal_y+12*t end
  if e.effect_kind=="petal" then
   e.pos.x=e.origin.x+e.vx*(store.tick_ts-began)+math.sin(t*6)*3
   e.pos.y=e.origin.y+e.vy*(store.tick_ts-began)
   sp.r=t*2.4
  end
  local expand=plan.strike and 1 or e.effect_kind=="arm" and math.sin(t*math.pi) or e.effect_kind=="ring" and (0.45+0.75*t) or 0.8+0.25*t
  sp.scale.x=e.sx*expand;sp.scale.y=e.sy*(e.effect_kind=="ring" and expand or 1)
  sp.alpha=math.floor(e.peak_alpha*math.min(1,t*12)*math.min(1,(1-t)*4))
  if plan.q then
   local tail=e.render.sprites[2]
   tail.scale.x=sp.scale.x*2;tail.scale.y=sp.scale.y;tail.alpha=sp.alpha
  end
  coroutine.yield()
 end
 remove(e)
end
function M.register()
 E=require("entity_db");U=require("utils");V=require("klua.vector");I=require("klove.image_db")
 A=require("animation_db")
 A.db.sett_q_left={prefix="sett_q_hand",frames={1,1,1,2,2,3,3,4,4,4,4}}
 A.db.sett_q_right={prefix="sett_q_hand",frames={5,6,7,8,9,10,11,12,13,14,15,16}}
 A.db.sett_q_tail_left={prefix="sett_q_tail",frames=A.db.sett_q_left.frames}
 A.db.sett_q_tail_right={prefix="sett_q_tail",frames=A.db.sett_q_right.frames}
 A.db.sett_basic_left={prefix="sett_strike",frames={5,5,5,6,6,7,7,8,8,8,8}}
 A.db.sett_basic_right={prefix="sett_strike",frames={1,1,1,2,2,3,3,4,4,4,4}}
 A.db.sett_basic_impact={prefix="sett_strike",frames={9,9,10,10,11,11,12,12}}
 if E.entities.sett_soul_visual then return end
 local t=E:register_t("sett_soul_visual","decal_scripted")
 t.main_script.update=update;t.main_script.insert=nil
 t.render.sprites[1].animated=false
 t=E:register_t("sett_soul_tracker","decal_scripted");t.render=nil
 t.main_script.update=function(e,store)
  local last,next_petal,next_aura=nil,store.tick_ts,store.tick_ts
  while true do
   local owner=store.entities[e.owner_id]
   if not alive(owner) then break end
   if owner.sett_tick then owner.sett_tick(owner,store) end
   local body=owner.render.sprites[1]
   if not owner.sett_spirit and store.tick_ts>=next_petal then
    if last and (owner.pos.x-last.x)^2+(owner.pos.y-last.y)^2>9 then
     M.emit(owner,store,"petal",{pos={x=owner.pos.x,y=owner.pos.y+8}})
    end
    last=V.vclone(owner.pos);next_petal=store.tick_ts+0.16
   end
   local s=owner.boss_state and owner.boss_state.sett
   local q=body.name=="q_left" or body.name=="q_right"
   local hand=(body.name=="q_left" or body.name=="attack") and 1 or (body.name=="q_right" or body.name=="right") and 2
   if s and hand and (not q or (s.q_hits or 0)>0 and store.tick_ts<(s.q_end or 0)) and body.ts~=s.strike_fx_ts then
    s.strike_fx_ts=body.ts
    local target=store.entities[owner.soldier.target_id or -1]
    if alive(target) and not owner.unit.is_stunned and not owner.nav_rally.new then
     local kind=q and (hand==1 and "q_left" or "q_right") or (hand==1 and "punch_left" or "punch_right")
     M.emit(owner,store,kind,{target_id=target.id,started=body.ts})
    end
   end
   if s and s.grit>=owner.health.hp_max*0.45 and store.tick_ts>=next_aura then
    M.emit(owner,store,"shield",{follow=true,y=31,alpha=150});next_aura=store.tick_ts+0.45
   end
   -- Mutate the existing tint: the renderer holds this table by reference.
   if body.color then
    local form=s and s.form
    body.color[1],body.color[2],body.color[3]=form==1 and 190 or 255,form==1 and 225 or form==2 and 185 or 255,form==2 and 250 or 255
   end
   coroutine.yield()
  end
  remove(e)
 end
end
function M.emit(owner,store,kind,opts)
 opts=opts or {};local plan=assert(effects[kind])
 local e=E:create_entity("sett_soul_visual");local sp=e.render.sprites[1]
 sp.name=string.format(plan.q and "sett_q_palm_%04i" or plan.basic and "sett_strike_%04i" or "sett_soul_fx_%04i",plan.frame)
 local ss=assert(I:s(sp.name),"Missing Sett effect: "..sp.name)
 local ref=ss.ref_scale or 1
 e.pos=V.vclone(opts.pos or owner.pos);e.origin=V.vclone(e.pos)
 e.effect_kind,e.owner_id,e.life,e.follow=kind,owner.id,opts.life or plan.life,opts.follow
 e.target_id,e.started=opts.target_id,opts.started
 if plan.q or plan.basic then
  local names={q_left="sett_q_left",q_right="sett_q_right",punch_left="sett_basic_left",punch_right="sett_basic_right",punch_impact="sett_basic_impact",heal="sett_basic_impact"}
  sp.name=names[kind];sp.animated,sp.loop,sp.ts=true,false,opts.started or store.tick_ts
 end
 if plan.strike then e.started=opts.started or store.tick_ts;e.strike_animation=owner.render.sprites[1].name end
 e.peak_alpha=opts.alpha or (plan.q and 140 or 235)
 e.sx,e.sy=(opts.width or plan.width)/(ss.size[1]*ref),(opts.height or plan.height)/(ss.size[2]*ref)
 e.vx,e.vy=math.random(-16,16),math.random(16,35)
 sp.scale=V.v(e.sx,e.sy);sp.anchor=V.v(kind=="q_right" and 0.77 or plan.strike and 0.65 or opts.tail and 0 or 0.5,kind=="q_right" and 0.23 or 0.5)
 sp.offset=V.v(opts.x or 0,opts.y or 0);sp.r=opts.angle or 0;sp.flip_x=opts.flip or (plan.strike and owner.render.sprites[1].flip_x) or false
 sp.color=opts.color
 if plan.healing then sp.color={140,255,185,255};e.heal_y=sp.offset.y end
 sp.z=plan.ground and Z_DECALS or Z_FLYING_HEROES+1
 if plan.q then
  sp.alpha=0;sp.draw_order=2
  local tail=E:clone_c("sprite");tail.name=kind=="q_left" and "sett_q_tail_left" or "sett_q_tail_right"
  tail.animated,tail.loop,tail.ts=true,false,sp.ts;tail.z,tail.color,tail.alpha=sp.z,sp.color,0
  tail.scale=V.v(e.sx*2,e.sy);tail.draw_order=1;e.render.sprites[2]=tail
 end
 if plan.strike then attach_hand(e,owner,store.tick_ts) end
 require("simulation"):queue_insert_entity(e)
 return e
end
function M.track(owner,store)
 local existing=owner.sett_soul_tracker and store.entities[owner.sett_soul_tracker]
 if existing and not existing.pending_removal then return end
 if owner.sett_soul_tracker_pending then return end
 local e=E:create_entity("sett_soul_tracker");e.owner_id=owner.id
 owner.sett_soul_tracker=e.id;owner.sett_soul_tracker_pending=true
 e.main_script.insert=function(this,st)
  local hero=st.entities[this.owner_id]
  if not alive(hero) then return false end
  hero.sett_soul_tracker_pending=nil;return true
 end
 require("simulation"):queue_insert_entity(e)
end
return M
