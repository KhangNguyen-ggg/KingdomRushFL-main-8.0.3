-- Spirit Blossom Sett: original kit, twin companions, and alternating spirit forms.
local C,E,A,U,SU,V,P,GR,bit,FX
local M={list={}}
local stats={health={hp_max=2400,armor=0.3},melee={attacks={{damage_min=90,damage_max=135}}}}
local descriptions={
 "Song Hồn Hoang Thú: đấm trái 90, phải 135 nhanh hơn; hồi nền 4 HP/s, thêm 4 HP/s mỗi 5% HP mất; tăng 0,2% sát thương mỗi 1% HP mất. Q: cường hóa 2 đấm. W: tích sát thương đã chịu, đổi thành khiên và đấm chuẩn ở giữa, vật lý hai bên. E: kéo hai phía, làm chậm; trúng cả hai phía thì choáng. R: ôm quái nhảy đập đất, nổ theo HP mục tiêu. Boss miễn kéo vẫn chịu sát thương. Chỉ số đã chuyển thể cho KR.",
 "Bộ kỹ năng Sett gốc + hai hồn thú riêng: Thanh Lang đánh nhanh, Tử Hổ đỡ đòn và hồi máu cho chủ. Mỗi Sett tối đa 2 thú; thú chết hồi lại sau 12 giây, đi theo chủ. Q cường hóa 2 đấm; W tích Gan Góc thành khiên và đấm; E kéo/choáng hai phía; R ôm quái đập đất. Boss miễn kéo vẫn chịu sát thương.",
 "Bộ kỹ năng Sett gốc + đổi hồn mỗi 10 giây. Thanh Lang: +40% tốc đánh, +25% tốc chạy. Tử Hổ: giảm 25% sát thương nhận, hút 20% sát thương đấm và W mạnh hơn 25%. Q cường hóa 2 đấm; W đổi Gan Góc thành khiên và phản đòn; E kéo/choáng hai phía; R ôm quái đập đất."
}
local function state(this,store)
 local s=C.state(this,store)
 if not s.sett then s.sett={grit=0,next_hand=1,last_hit=store.tick_ts,regen_ts=store.tick_ts,decay_ts=store.tick_ts,pet_retry={}} end
 return s.sett
end
function M.damage_factor(this)
 local h=this.health
 return 1+0.2*math.max(0,math.min(1,1-h.hp/h.hp_max))
end
local function regenerate(this,store)
 local h=this.health
 if h.dead or h.hp<=0 then return end
 local s=state(this,store);local elapsed=math.max(0,store.tick_ts-s.regen_ts)
 local missing=math.max(0,math.min(1,1-h.hp/h.hp_max))
 local rate=4+4*math.floor(missing*20+1e-9)
 h.hp=math.min(h.hp_max,h.hp+rate*elapsed);s.regen_ts=store.tick_ts
end
local function displacement_immune(target)
 return target.unit.ignore_stun or bit.band(target.vis.flags,F_BOSS)~=0 or
  bit.band(target.vis.bans,bit.bor(F_STUN,F_TELEPORT))~=0
end
local function targets(store,pos,radius)
 local out=U.find_enemies_in_range(store.entities,pos,0,radius,F_AREA,bit.bor(F_FLYING,F_CLIFF)) or {}
 table.sort(out,function(a,b) return C.target_before(a,b,pos) end)
 return out
end
local function hit(this,store,target,value,kind)
 if not C.alive(target) or not target.enemy or bit.band(target.vis.bans,F_AREA)~=0 then return end
 local d=E:create_damage()
 d.source_id,d.target_id,d.value,d.damage_type=this.id,target.id,value*(this.unit.damage_factor or 1)*M.damage_factor(this),kind or DAMAGE_PHYSICAL
 store.damage_queue[#store.damage_queue+1]=d
end
local function control(this,store,target,name,duration)
 local flag=name=="mod_stun" and F_STUN or F_SLOW
 if not C.alive(target) or bit.band(target.vis.bans,flag)~=0 then return end
 local e=E:create_entity(name)
 e.modifier.source_id,e.modifier.target_id,e.modifier.duration=this.id,target.id,duration
 C.insert(e)
end
local function collect_grit(this,store)
 local s=state(this,store)
 local amount=this.health.accumulated_damage or 0
 this.health.accumulated_damage=0
 if amount>0 then
  s.grit=math.min(this.health.hp_max*0.5,s.grit+amount)
  s.last_hit,s.decay_ts=store.tick_ts,store.tick_ts
 elseif store.tick_ts-s.last_hit>4 then
  s.grit=s.grit*math.pow(0.7,math.max(0,store.tick_ts-math.max(s.decay_ts,s.last_hit+4)))
  s.decay_ts=store.tick_ts
 end
 return s
end
local function decay_shield(s,now)
 if now>=(s.shield_end or 0) then s.shield=0
 elseif s.shield_started and now>s.shield_started+0.75 then
  local previous=math.max(s.shield_decay_ts or s.shield_started,s.shield_started+0.75)
  s.shield=s.shield*math.max(0,(s.shield_end-now)/(s.shield_end-previous))
 end
 s.shield_decay_ts=now
end
local function on_damage(this,store,d)
 local s=state(this,store)
 decay_shield(s,store.tick_ts)
 if bit.band(d.damage_type,bit.bor(DAMAGE_ARMOR,DAMAGE_MAGICAL_ARMOR))~=0 then return true end
 if s.form==2 then d.value=d.value*0.75 end
 -- Prototype shield absorbs incoming points before armor, with no shared damage-system patch.
 if s.shield and s.shield>0 and store.tick_ts<(s.shield_end or 0) then
  local absorbed=math.min(s.shield,math.max(0,d.value or 0))
  s.shield=s.shield-absorbed;d.value=d.value-absorbed
  if d.value<=0 then return false end
 end
 return true
end
local function punch_ready(this,store,attack)
 local s=state(this,store)
 if store.tick_ts-(s.last_punch or 0)>2 then s.next_hand=1 end
 if attack.sett_hand~=s.next_hand then return false end
 local empowered=(s.q_hits or 0)>0 and store.tick_ts<(s.q_end or 0)
 attack.animation=empowered and (attack.sett_hand==1 and "q_left" or "q_right") or (attack.sett_hand==1 and "attack" or "right")
 return true
end
local function punch_damage(this,store,attack,target)
 local s=state(this,store)
 s.next_hand,s.last_punch=3-attack.sett_hand,store.tick_ts
 local empowered=(s.q_hits or 0)>0 and store.tick_ts<(s.q_end or 0)
 local offset=target.unit and target.unit.hit_offset
 local height=offset and offset.y>0 and offset.y or 25
 local size=empowered and 42 or attack.sett_hand==2 and 30 or 26
 FX.emit(this,store,"punch_impact",{pos={x=target.pos.x,y=target.pos.y+height},width=size,height=size})
 local value=attack.damage_min
 if empowered then
  s.q_hits=s.q_hits-1;value=value+math.min(400,40+0.04*target.health.hp_max)
 end
 return value*(this.unit.damage_factor or 1)*M.damage_factor(this)
end
local function lifesteal(this,target,store,d,amount,direct)
 if not direct or not d.track_damage or not C.alive(this) then return end
 if state(this,store).form==2 then this.health.hp=math.min(this.health.hp_max,this.health.hp+amount*0.2) end
end
local function face(this,store,target,animation)
 local an,flip=U.animation_name_facing_point(this,animation,target.pos)
 U.animation_start(this,an,flip,store.tick_ts,1)
end
local function windup(this,store,duration)
 -- Keep the melee blocker attached while charging; a movement order cancels the cast.
 return C.wait(this,store,duration,function() return this.nav_rally.new end) and not this.nav_rally.new
end
local function destination(target,pos,max_distance)
 if not target.nav_path or target._sett_displaced or displacement_immune(target) then return end
 local np=target.nav_path
 local nodes=P:nearest_nodes(pos.x,pos.y,{np.pi},{np.spi},true,NF_RALLY)
 local node=nodes and nodes[1]
 if not node then return end
 local point=P:node_pos(node[1],node[2],node[3])
 if C.dist(point,target.pos)>max_distance or not GR:find_line_waypoints(target.pos,point,bit.bor(TERRAIN_LAND,TERRAIN_ICE)) then return end
 return point,node
end
local function release_displacement(e,store)
 if not e.held then return true end
 local target=store.entities[e.target_id]
 if target then
  for i,offset in ipairs(e.offsets) do target.render.sprites[i].offset.y=offset end
  target._sett_displaced=nil;SU.stun_dec(target)
  if C.alive(target) then
   local np=target.nav_path
   local nodes=P:nearest_nodes(target.pos.x,target.pos.y,{np.pi},{np.spi},true,NF_RALLY)
   if nodes and nodes[1] then np.ni=nodes[1][3] end
   target.motion.forced_waypoint=nil
   U.set_destination(target,P:node_pos(np.pi,np.spi,np.ni))
  end
 end
 e.held=false
 return true
end
local function displace(this,store,target,pos,node,duration,height)
 if target._sett_displaced or not C.alive(target) then return end
 local e=E:create_entity("sett_spirit_displacement")
 e.target_id,e.owner_id,e.start,e.finish,e.node=target.id,this.id,C.copy(target.pos),C.copy(pos),node
 e.duration,e.height,e.started,e.held=duration,height or 0,store.tick_ts,true
 e.offsets={}
 for i,sp in ipairs(target.render.sprites) do e.offsets[i]=sp.offset.y end
 target._sett_displaced=true;SU.stun_inc(target);U.unblock_all(store,target)
 C.insert(e)
 return e
end
local function haymaker(this,store,target)
 local s=collect_grit(this,store);local grit=s.grit
 s.grit=0;s.shield=grit;s.shield_end=store.tick_ts+3;s.shield_started=store.tick_ts;s.shield_decay_ts=store.tick_ts
 C.stamp(this,store,"w");face(this,store,target,"charge")
 FX.emit(this,store,"shield",{follow=true,y=30,life=0.85})
 local origin=C.copy(this.pos)
 local dx,dy=target.pos.x-origin.x,target.pos.y-origin.y
 local length=math.max(1,math.sqrt(dx*dx+dy*dy));dx,dy=dx/length,dy/length
 if not windup(this,store,0.75) then return end
 face(this,store,target,"blast")
 FX.emit(this,store,"wave",{pos={x=this.pos.x,y=this.pos.y+24},tail=true,angle=math.atan2(dy,dx)})
 local value=(200+0.5*grit)*(s.form==2 and 1.25 or 1)
 for _,enemy in ipairs(targets(store,origin,180)) do
  local ex,ey=enemy.pos.x-origin.x,enemy.pos.y-origin.y
  local along,across=ex*dx+ey*dy,math.abs(ex*dy-ey*dx)
  if along>=-12 and along<=180 and across<=25+along*0.4 then hit(this,store,enemy,value,across<=22 and DAMAGE_TRUE or DAMAGE_PHYSICAL) end
 end
 windup(this,store,0.25)
end
local function facebreaker(this,store,foes)
 local front,back=false,false
 local flip=this.render.sprites[1].flip_x
 for _,e in ipairs(foes) do if (e.pos.x>=this.pos.x)~=flip then front=true else back=true end end
 C.stamp(this,store,"e");face(this,store,foes[1],"pull")
 FX.emit(this,store,"arm",{follow=true,tail=true,y=27})
 FX.emit(this,store,"arm",{follow=true,tail=true,y=27,flip=true})
 if not windup(this,store,0.25) then return end
 for _,e in ipairs(foes) do
  if C.alive(e) and C.dist(e.pos,this.pos)<=115 then
   hit(this,store,e,160)
   control(this,store,e,front and back and "mod_stun" or "sett_spirit_slow",front and back and 1 or 0.5)
   local sign=e.pos.x<this.pos.x and -1 or 1
   local point,node=destination(e,V.v(this.pos.x+sign*22,this.pos.y),100)
   if point and C.dist(point,e.pos)>8 then displace(this,store,e,point,node,0.2,0) end
  end
 end
 windup(this,store,0.2)
end
local function showstopper(this,store,pos)
 local foes=targets(store,pos,65);local target=foes[1]
 if not target or C.dist(this.pos,target.pos)>130 then return end
 local sign=target.pos.x<this.pos.x and -1 or 1
 local point,node=destination(target,V.v(target.pos.x+sign*85,target.pos.y),110)
 local center=point or C.copy(target.pos)
 local original=C.copy(this.pos);local sp=this.render.sprites[1];local offset=sp.offset.y
 local old_bans,old_ignore=this.vis.bans,this.unit.ignore_stun
 this.vis.bans=bit.bor(old_bans,F_STUN,F_FREEZE,F_TELEPORT);this.unit.ignore_stun=true
 local value=350+math.min(1800,target.health.hp_max*0.12)
 face(this,store,target,"jump")
 local controller=point and displace(this,store,target,point,node,0.6,45)
 local began=store.tick_ts
 local completed=C.wait(this,store,0.6,function()
  if this.nav_rally.new then return true end
  if controller then
   local f=math.min(1,(store.tick_ts-began)/0.6)
   this.pos.x=original.x+(center.x-sign*22-original.x)*f;this.pos.y=original.y+(center.y-original.y)*f
   sp.offset.y=offset+45*math.sin(math.pi*f)
  end
 end)
 sp.offset.y=offset
 this.vis.bans,this.unit.ignore_stun=old_bans,old_ignore
 if controller then
  if completed and not this.nav_rally.new and C.alive(target) then target.pos=C.copy(center);target.nav_path.ni=node[3] end
  release_displacement(controller,store);C.remove(controller)
 end
 if not completed or this.nav_rally.new then return end
 if controller then C.land(this,V.v(center.x-sign*22,center.y)) end
 face(this,store,{pos=center},"land")
 FX.emit(this,store,"ring",{pos=center})
 FX.emit(this,store,"impact",{pos=center})
 for i=1,5 do FX.emit(this,store,"petal",{pos=center}) end
 for _,enemy in ipairs(targets(store,center,125)) do
  hit(this,store,enemy,value*math.max(0.25,1-C.dist(enemy.pos,center)/165))
  if not displacement_immune(enemy) then control(this,store,enemy,"sett_spirit_r_slow",1) end
 end
 if C.alive(target) and controller then U.block_enemy(store,this,target) end
 windup(this,store,0.25)
end
local function summon_passive(pet,store)
 local owner=pet.boss_owner
 if not C.alive(owner) or store.tick_ts<(pet.sett_follow_ts or 0) then return end
 pet.sett_follow_ts=store.tick_ts+0.5
 local side=pet.sett_spirit==1 and -1 or 1
 local point=V.v(owner.pos.x+side*40,owner.pos.y-12)
 if not GR:cell_is_only(point.x,point.y,bit.bor(TERRAIN_LAND,TERRAIN_ICE)) then point=C.copy(owner.pos) end
 local distance=C.dist(pet.pos,owner.pos)
 if distance>140 then U.unblock_target(store,pet);pet.nav_rally.new=true end
 if not pet.soldier.target_id then
  pet.nav_rally.pos,pet.nav_rally.center=point,C.copy(owner.pos)
  if distance>70 then pet.nav_rally.new=true end
 end
end
local function configure_summon(owner,pet)
 local index=owner._sett_summoning;pet.sett_spirit=index
 pet.death_summon=nil;pet.expires=math.huge
 pet.health.hp_max=index==1 and 900 or 1400;pet.health.hp=pet.health.hp_max
 pet.health.armor=index==1 and 0.1 or 0.35;pet.health.magic_armor=0.2
 pet.health_bar.offset=V.v(0,33);pet.unit.death_animation="death"
 pet.info.i18n_key=index==1 and "SETT_SPIRIT_WOLF" or "SETT_SPIRIT_TIGER"
 pet.info.portrait=index==1 and "info_portrait_sett_wolf" or "info_portrait_sett_tiger"
 pet.motion.max_speed=100;pet.ui.click_rect={pos=V.v(-20,0),size=V.v(40,32)}
 local sp=E:clone_c("sprite");sp.prefix="sett_spirit_pet_"..index;sp.anchor=V.v(0.5,0.15);sp.scale=V.v(0.16,0.16)
 sp.angles={walk={"walk","walk","walk"}};pet.render.sprites={sp}
 local a=pet.melee.attacks[1];a.damage_min=index==1 and 40 or 70;a.damage_max=a.damage_min
 a.cooldown=index==1 and 0.7 or 1.2;a.hit_time=0.2;a.animation="attack";a.hit_fx=nil;a.count=1;a.track_damage=true
 if index==2 then pet.unit.on_damage_dealt=function(this,target,store,d,amount,direct)
  if direct and d.track_damage and C.alive(this.boss_owner) then
   local h=this.boss_owner.health;h.hp=math.min(h.hp_max,h.hp+amount*0.2)
  end
 end end
end
local function passive(this,store)
 local s=collect_grit(this,store)
 FX.track(this,store)
 decay_shield(s,store.tick_ts)
 if this.sett_variant==3 then
  s.form=math.floor((store.tick_ts-C.state(this,store).born)/10)%2+1
  local fast=s.form==1
  this.melee.attacks[1].cooldown=fast and 1/1.4 or 1
  this.melee.attacks[2].cooldown=fast and 0.2/1.4 or 0.2
  local tint=this.render.sprites[1].color
  tint[1],tint[2],tint[3]=fast and 190 or 255,fast and 225 or 185,fast and 255 or 250
 end
 local speed=this.sett_variant==3 and s.form==1 and 1.25 or 1
 if store.tick_ts<(s.q_speed_end or 0) then
  local foe=store.entities[s.q_target_id or -1]
  if not this.nav_rally.new and C.alive(foe) then speed=speed*1.3 end
 end
 this.motion.max_speed=84*speed
 if this.sett_variant==2 and store.tick_ts>=(s.pets_ts or 0) then
  s.pets_ts=store.tick_ts+0.5
  local live={};for _,pet in ipairs(C.living_summons(this,store)) do live[pet.sett_spirit]=true end
  for index=1,2 do
   if live[index] then s.pet_retry[index]=nil
   elseif not s.pets_born or s.pet_retry[index] and store.tick_ts>=s.pet_retry[index] then
    this._sett_summoning=index
    C.summon(this,"enemy_wolf",V.v(this.pos.x+(index==1 and -35 or 35),this.pos.y),store,math.huge)
    this._sett_summoning=nil;s.pet_retry[index]=nil
   elseif not s.pet_retry[index] then s.pet_retry[index]=store.tick_ts+12 end
  end
  s.pets_born=true
 end
end
local function automatic(this,store)
 local foes=targets(store,this.pos,110);local target=store.entities[this.soldier.target_id or -1] or foes[1]
 if not C.alive(target) then return false end
 local s=collect_grit(this,store)
 if C.ready(this,store,"w",10) and s.grit>=this.health.hp_max*0.2 then haymaker(this,store,target);return true end
 if #foes>0 and C.ready(this,store,"e",8) then facebreaker(this,store,foes);return true end
 if C.ready(this,store,"q",6) then
  C.stamp(this,store,"q");s.q_hits,s.next_hand,s.q_end,s.q_speed_end=2,1,store.tick_ts+5,store.tick_ts+1.5
  -- Q palms are synchronized to the two melee animations by the visual tracker.
  s.q_target_id=target.id;this.motion.max_speed=this.motion.max_speed*1.3
  for _,a in ipairs(this.melee.attacks) do a.ts=store.tick_ts-2 end
 end
 return false
end
local function prepare(t)
 t.sett_tick=regenerate;t.sett_damage_factor=M.damage_factor
 local insert=t.main_script.insert
 t.main_script.insert=function(this,store)
  if insert and insert(this,store)==false then return false end
  state(this,store);FX.track(this,store);return true
 end
 local prefix=t.render.sprites[1].prefix
 local function animation(name,atlas,frames,repeats)
  local out={};for _,frame in ipairs(frames) do for i=1,repeats or 1 do out[#out+1]=frame end end
  A.db[prefix.."_"..name]={prefix=atlas,frames=out}
 end
 for _,name in ipairs({"walk","walkUp","walkDown"}) do animation(name,"sett_walk_v2",{1,2,3,4,5,6,7,8},2) end
 animation("idle","sett_walk_v2",{9,10,11,12,13,14,15,16},5)
 animation("attack","sett_combat_v2",{1,2,3,4,5,6,7,8})
 animation("right","sett_combat_v2",{9,10,11,12,13,14,15,16})
 animation("q_left","sett_combat_v2",{9,10,11,12,13,14,15,16})
 animation("q_right","sett_combat_v2",{1,2,3,4,5,6,7,8})
 animation("pull","sett_skills_v2",{1,2,3,4,5,6,7,8},2)
 animation("charge","sett_skills_v2",{9,9,9,10,10,10,10,10,10,10,11},2)
 animation("blast","sett_skills_v2",{12,17,18,19},2)
 animation("jump","sett_jump_v2",{1,2,3,4,5,6},3)
 animation("land","sett_jump_v2",{7,8},4)
 animation("death","sett_spirit",{15,16},5)
 animation("respawn","sett_walk_v2",{9,10,11},3)
 animation("levelup","sett_jump_v2",{8},3)
 local sp=E:clone_c("sprite");sp.prefix=prefix;sp.anchor=V.v(0.5,0.15);sp.scale=V.v(0.29,0.29)
 sp.color={255,255,255,255};sp.angles={walk={"walk","walkUp","walkDown"}};t.render.sprites={sp}
 t.health.hp_max,t.health.hp,t.health.armor,t.health.magic_armor=2400,2400,0.3,0.15
 t.health.accumulated_damage_factor=1;t.health.on_damage=on_damage;t.health.dead_lifetime=20
 t.health_bar.offset=V.v(0,58);t.health_bar.type=HEALTH_BAR_SIZE_MEDIUM
 t.regen.health=0;t.motion.max_speed=84;t.unit.size=UNIT_SIZE_MEDIUM
 t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=V.v(0,35),V.v(0,35),V.v(0,0)
 t.ui.click_rect={pos=V.v(-24,0),size=V.v(48,55)}
 t.unit.on_damage_dealt=lifesteal;t.unit.death_animation="death"
 t.melee.range=90;t.soldier.melee_slot_offset=V.v(22,0)
 t.melee.attacks={}
 for hand=1,2 do
  local a=E:clone_c("melee_attack")
  a.damage_min=hand==1 and 90 or 135;a.damage_max=a.damage_min
  a.damage_type=DAMAGE_PHYSICAL;a.cooldown=hand==1 and 1 or 0.2;a.hit_time=4/FPS
  a.animation=hand==1 and "attack" or "right";a.sett_hand=hand
  a.fn_can,a.fn_damage,a.shared_cooldown,a.track_damage=punch_ready,punch_damage,true,true
  a.vis_flags,a.vis_bans=F_BLOCK,bit.bor(F_FLYING,F_CLIFF);a.xp_gain_factor=0;a.sound="MeleeSword"
  t.melee.attacks[hand]=a
 end
 t.melee.order={1,2};t.info.i18n_key=string.upper(t.template_name or t.name or "HERO_ALLIED_SETT")
end
local function register_effects()
 if not E.entities.sett_spirit_slow then
  local t=E:register_t("sett_spirit_slow","mod_slow");t.render=nil;t.slow.factor=0.5;t.modifier.duration=0.5
  t=E:register_t("sett_spirit_r_slow","sett_spirit_slow");t.slow.factor=0.01;t.modifier.duration=1
 end
 if not E.entities.sett_spirit_displacement then
  local t=E:register_t("sett_spirit_displacement","decal_scripted");t.render=nil;t.main_script.remove=release_displacement
  t.main_script.update=function(e,store)
   while e.held and store.tick_ts-e.started<e.duration do
    local target=store.entities[e.target_id];local owner=store.entities[e.owner_id]
    if not C.alive(target) or not C.alive(owner) then break end
    local f=math.min(1,(store.tick_ts-e.started)/e.duration)
    target.pos.x=e.start.x+(e.finish.x-e.start.x)*f;target.pos.y=e.start.y+(e.finish.y-e.start.y)*f
    for i,offset in ipairs(e.offsets) do target.render.sprites[i].offset.y=offset+e.height*math.sin(math.pi*f) end
    coroutine.yield()
   end
   if e.held and C.alive(store.entities[e.target_id]) and C.alive(store.entities[e.owner_id]) then
    local target=store.entities[e.target_id];target.pos=C.copy(e.finish);target.nav_path.ni=e.node[3]
   end
   release_displacement(e,store);C.remove(e)
  end
 end
 for index=1,2 do
  local start=index==1 and 0 or 4
  for name,frames in pairs({idle={1},walk={2,3,2,3},attack={1,4,4,1},death={1}}) do
   local out={};for _,f in ipairs(frames) do for i=1,3 do out[#out+1]=start+f end end
   A.db["sett_spirit_pet_"..index.."_"..name]={prefix="sett_spirit_pet",frames=out}
  end
 end
end
local function skill_cards(variant)
 local extra=({
  "Bản Gốc: dùng trọn bộ P/Q/W/E/R.",
  "Song Thú: Thanh Lang 900 HP, 40 dmg/0,7s. Tử Hổ 1.400 HP, 70 dmg/1,2s; hồi chủ bằng 20% sát thương thực gây ra. Thú chết gọi lại sau 12s.",
  "Nhập Hồn đổi mỗi 10s: Thanh Lang +40% tốc đánh, +25% tốc chạy. Tử Hổ giảm 25% sát thương nhận, hút 20% đấm/W, W mạnh thêm 25%."
 })[variant]
 return {
  {key="P",icon="sett_skill_passive",title="Nội tại — Gan góc song hồn",description="Hồi nền 4 HP/s + 4 HP/s mỗi 5% HP mất, liên tục khi còn sống kể cả gồng/choáng. Mỗi 1% HP mất tăng 0,2% sát thương đấm và Q/W/E/R; còn 5% HP được +19%. Hồi HP giảm hệ số này. "..extra},
  {key="Q",icon="sett_skill_q",title="Q — Chưởng song hồn",description="Hồi chiêu 6s. Hai đòn tiếp theo trong 5s được cường hóa: trái tím quặp vào, phải xanh xòe ra. Mỗi đòn cộng 40 + 4% HP tối đa mục tiêu, phần cộng giới hạn 400; chịu hệ số nội tại. Tăng 30% tốc chạy đuổi mục tiêu trong 1,5s. Tự dùng khi có địch."},
  {key="W",icon="sett_skill_w",title="W — Cuồng thú quyền",description="Hồi chiêu 10s. Tích sát thương thực đã chịu thành Gan Góc, tối đa 50% HP tối đa. Đủ 20% HP thì tự gồng 0,75s, đổi toàn bộ Gan Góc thành khiên 3s. Đòn chưởng gây 200 + 50% Gan Góc: giữa gây sát thương chuẩn, hai bên vật lý; chịu hệ số nội tại."},
  {key="E",icon="sett_skill_e",title="E — Song hồn hội tụ",description="Hồi chiêu 8s. Kéo địch hai phía trong tầm 110. Gây 160 sát thương vật lý cơ bản, chịu hệ số nội tại. Có địch cả hai phía: choáng 1s; chỉ một phía: chậm 50% trong 0,5s. Boss và mục tiêu miễn kéo/choáng không bị kéo. Tự dùng khi đủ điều kiện."},
  {key="R",icon="sett_skill_r",title="R — Hủy diệt đấu trường",description="Hồi chiêu 20s. Chọn mục tiêu gần điểm chỉ định, nhảy đập sau 0,6s. Sát thương vật lý cơ bản 350 + 12% HP tối đa mục tiêu, phần cộng giới hạn 1.800; chịu hệ số nội tại. Nổ bán kính 125, giảm theo khoảng cách. Boss/miễn khống chế chỉ chịu sát thương, không bị bế hoặc làm chậm. Có thể bấm R trong trận; tự dùng khi bật tự động."}
 }
end
for index,kind in ipairs({"sett","sett_beasts","sett_forms"}) do
 local def={name="hero_allied_"..kind,kind=kind,title=({"Sett Gốc","Sett Song Thú","Sett Nhập Hồn"})[index],source="enemy_set",
  icon="encyclopedia_creep_thumbs_sett",custom_portrait=true,preview_stats=stats,hero_class="Đấu sĩ - Song Hồn",textures={"go_sett_spirit","ui_sett_spirit","go_sett_motion_v2","go_sett_soul_fx","go_sett_q","go_sett_strikes"},sounds={},
  skill={label="R",cooldown=20,range=125,description=descriptions[index]}}
 if index==2 then def.textures[#def.textures+1]="go_sett_spirit_pets" end
 def.skill_cards=skill_cards(index)
 def.prepare=prepare;def.passive=passive;def.automatic=automatic;def.active=showstopper
 def.configure_summon=configure_summon;def.summon_passive=summon_passive
 def.respawn=function(this) this.health.accumulated_damage=0;this.render.sprites[1].offset.y=0;this.sett_soul_tracker_pending=nil end
 local variant=index
 function def.register()
  C=require("allied_boss_common");E=require("entity_db");A=require("animation_db");U=require("utils");SU=require("script_utils")
  V=require("klua.vector");P=require("path_db");GR=require("grid_db");bit=require("bit")
  register_effects()
  FX=require("sett_visuals");FX.register()
  local t=C.create(def);t.sett_variant=variant;t.info.i18n_key=string.upper(def.name);t.info.portrait="info_portrait_sett"
  for _,msgs in pairs(require("i18n").msgs) do
   msgs[t.info.i18n_key.."_NAME"]=def.title
   msgs.SETT_SPIRIT_WOLF_NAME,msgs.SETT_SPIRIT_TIGER_NAME="Thanh Lang","Tử Hổ"
  end
  return t
 end
 M.list[index]=def
end
return M
