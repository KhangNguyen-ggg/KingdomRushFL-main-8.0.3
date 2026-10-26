-- Red allied Navira gains strength from nearby troops; no summons or permanent stacks.
local M={}
local C,E,U,A,bit
M.description="Vua dọn lính. Mỗi lính/miniboss trong tầm 240: +8% sát thương lên lính, +3% tốc đánh, giảm 2% sát thương nhận từ lính; tối đa 20 mục tiêu (+160%/+60%/40%). Đấm thường và đấm chuẩn quét mọi địch trong vùng. Lính bị Navira hạ nổ lan 180 +6% HP tối đa của xác (tối đa 650 cơ bản) phép trong tầm 140, có thể gây chuỗi nổ; mỗi hạ gục giảm 0,4 giây hồi đấm lớn. Đấm lớn hồi 10–6 giây theo số lính. Tia hồn gây 240 phép lên lính; khi có lính gần, hồi 8 giây và bắn 3–8 tia. Boss không cấp cộng dồn, không phát nổ và không nhận phần sát thương cộng thêm này. Giữ hút xác hồi máu, đánh bay, miễn khống chế và lướt địa hình."

local function troop(e)
 return e and e.enemy and e.vis and not (bit.band(e.vis.flags,F_BOSS)~=0 and bit.band(e.vis.flags,F_MINIBOSS)==0)
end
local function state(this,store)
 local s=C.state(this,store)
 if not s.horde then s.horde={count=0} end
 return s.horde
end
local function damage(this,target,store,value)
 local d=E:create_damage()
 d.source_id,d.target_id,d.value,d.damage_type=this.id,target.id,value,bit.bor(DAMAGE_MAGICAL,DAMAGE_NO_DODGE)
 store.damage_queue[#store.damage_queue+1]=d
end
local function restore(this)
 local base=this.navira_horde
 for _,attack in ipairs(this.melee.attacks) do attack.cooldown,attack.hit_time=base.cooldown,base.hit_time end
 for i,sprite in ipairs(this.render.sprites) do sprite.fps=base.fps[i] end
end
function M.tick(this,store)
 if not C.alive(this) then
  if this.boss_state then this.boss_state.horde=nil end
  restore(this)
  return
 end
 local s=state(this,store)
 if store.tick_ts>=(s.next_scan or 0) then
  s.next_scan=store.tick_ts+0.25
  local count=0
  for _,target in pairs(store.entities) do
   if C.alive(target) and troop(target) and bit.band(target.vis.bans,F_AREA)==0 and U.is_inside_ellipse(target.pos,this.pos,240) then
    count=count+1
    if count==20 then break end
   end
  end
  s.count=count
  local speed=1+0.03*count
  for _,attack in ipairs(this.melee.attacks) do attack.cooldown=this.navira_horde.cooldown/speed end
 end
 for i,sprite in ipairs(this.render.sprites) do
  if sprite.name~="attack" and sprite.name~="charged_attack" then sprite.fps=this.navira_horde.fps[i] end
 end
 if s.blasts and store.tick_ts>=(s.next_blast or 0) then
  s.next_blast=store.tick_ts+0.1
  -- Drain a bounded number each update; queued items hold numbers, never corpses.
  for _=1,4 do
   if s.head>s.tail then break end
   local blast=s.blasts[s.head];s.blasts[s.head]=nil;s.head=s.head+1
   C.area(store,this,blast,140,blast.damage,blast.damage,DAMAGE_MAGICAL,nil,nil,false)
   local visual=C.visual("mod_bullet_stage_19_navira_heal",blast,store,0.45,"idle")
   if visual then
    local sprite=visual.render.sprites[1]
    sprite.offset={x=0,y=25};sprite.scale={x=1.7,y=1.7};sprite.alpha=210;sprite.shader="p_navira_ember"
   end
  end
  if s.head>s.tail then s.blasts,s.head,s.tail=nil,nil,nil end
 end
end
function M.attack_start(this,store,attack)
 M.tick(this,store)
 local s=state(this,store)
 s.attack_speed=1+0.03*s.count
 attack.hit_time=this.navira_horde.hit_time/s.attack_speed
 for i,sprite in ipairs(this.render.sprites) do
  if sprite.animated and not sprite.ignore_start then sprite.fps=(this.navira_horde.fps[i] or A.fps)*s.attack_speed end
 end
end
function M.animation_speed(this,store) return state(this,store).attack_speed or 1 end
function M.punch_cooldown(this,store) return 10-0.2*state(this,store).count end
function M.ray_count(this,store) return 3+math.floor(state(this,store).count/4) end
function M.ray_cooldown(this,store,native) return state(this,store).count>0 and 8 or native end
function M.ray(this,target,store)
 if C.alive(this) and C.alive(target) and troop(target) then damage(this,target,store,240) end
end
function M.apply(t)
 C,E,U,A,bit=require("allied_boss_common"),require("entity_db"),require("utils"),require("animation_db"),require("bit")
 for _,attack in ipairs(t.melee.attacks) do attack.count=nil;attack.track_damage=true end
 if t.navira_horde then return end
 t.navira_horde={cooldown=t.melee.attacks[1].cooldown,hit_time=t.melee.attacks[1].hit_time,fps={}}
 for i,sprite in ipairs(t.render.sprites) do t.navira_horde.fps[i]=sprite.fps end
 local previous_prepare=t.unit.prepare_damage
 t.unit.prepare_damage=function(this,target,store,d)
  if previous_prepare then previous_prepare(this,target,store,d) end
  if troop(target) then d.value=d.value*(1+0.08*state(this,store).count) end
 end
 local previous_dealt=t.unit.on_damage_dealt
 t.unit.on_damage_dealt=function(this,target,store,d,amount,direct)
  if previous_dealt then previous_dealt(this,target,store,d,amount,direct) end
  if not C.alive(this) or not troop(target) or target.health.hp>0 or target._navira_horde_exploded then return end
  target._navira_horde_exploded=true
  local s=state(this,store)
  if not s.blasts then s.blasts,s.head,s.tail={},1,0 end
  s.tail=s.tail+1
  s.blasts[s.tail]={x=target.pos.x,y=target.pos.y,damage=math.min(650,180+0.06*target.health.hp_max)}
  local owner=C.state(this,store)
  owner.last.punch=(owner.last.punch or owner.born)-0.4
 end
 local previous_damage=t.health.on_damage
 t.health.on_damage=function(this,store,d)
  if previous_damage and not previous_damage(this,store,d) then return false end
  local source=store.entities[d.source_id]
  local dealer=source and source.modifier and store.entities[source.modifier.source_id] or
   source and source.bullet and store.entities[source.bullet.source_id] or source
  if troop(dealer) and (d.value or 0)>0 and bit.band(d.damage_type,bit.bor(DAMAGE_ARMOR,DAMAGE_MAGICAL_ARMOR,DAMAGE_INSTAKILL,DAMAGE_EAT))==0 then
   d.value=d.value*(1-0.02*state(this,store).count)
  end
  return true
 end
end
return M
