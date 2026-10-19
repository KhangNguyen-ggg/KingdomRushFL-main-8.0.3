-- Blue Navira keeps one opponent until death, retreat or loss of contact.
local M={}
local C,E,U,bit
local function state(this,store)
 local s=C.state(this,store)
 if not s.duel then s.duel={stacks=0,guards=3,guard_refresh=store.tick_ts+10} end
 if store.tick_ts>=s.duel.guard_refresh then s.duel.guards,s.duel.guard_refresh=3,store.tick_ts+10 end
 return s.duel
end
local function valid(this,target)
 return C.alive(target) and target.enemy and target.pos and C.dist(this.pos,target.pos)<=450
end
local function lock(s,target)
 if s.target_id~=target.id then s.target_id,s.stacks=target.id,0 end
 return target
end
function M.release(this,store)
 local s=state(this,store)
 s.target_id,s.stacks=nil,0
end
function M.current(this,store)
 local s=state(this,store)
 if not C.alive(this) or this.nav_rally.new then M.release(this,store);return end
 local blocked=store.entities[this.soldier.target_id]
 if valid(this,blocked) and U.blocker_rank(store,this) and bit.band(blocked.vis.flags,F_FLYING)==0 then return lock(s,blocked) end
 local target=store.entities[s.target_id]
 if valid(this,target) then return target end
 M.release(this,store)
end
function M.select(this,store,target)
 if not valid(this,target) then return false end
 local current=M.current(this,store)
 if current and current.id~=target.id then return false end
 lock(state(this,store),target)
 if not this.navira_duel_sort then
  this.navira_duel_sort=function(a,b,center)
   if a.id==b.id then return false end
   local s=this.boss_state and this.boss_state.duel
   if s and s.target_id and (a.id==s.target_id or b.id==s.target_id) then return a.id==s.target_id end
   return C.target_before(a,b,center)
  end
 end
 this.melee.fn_sort_targets=this.navira_duel_sort
 return true
end
local function damage(this,target,store,value,kind,ray)
 if not C.alive(target) or not target.enemy then return end
 local d=E:create_damage()
 d.source_id,d.target_id=this.id,target.id
 d.value,d.damage_type=value,kind or bit.bor(DAMAGE_TRUE,DAMAGE_MODIFIER)
 d.navira_duel_ray=ray
 store.damage_queue[#store.damage_queue+1]=d
end
local function on_damage_dealt(this,target,store,d,amount,direct)
 if not C.alive(this) or not target.enemy then return end
 local s=state(this,store)
 if this.nav_rally.new or target.id~=s.target_id then return end
 if direct and (d.navira_duel_ray or d.track_damage and bit.band(d.damage_type,DAMAGE_MODIFIER)==0) then
  s.stacks=math.min(20,s.stacks+1)
  if C.alive(target) then damage(this,target,store,target.health.hp_max*0.002*s.stacks) end
 end
 if bit.band(d.damage_type,DAMAGE_NO_LIFESTEAL)==0 then
  this.health.hp=math.min(this.health.hp_max,this.health.hp+amount*0.4)
 end
 if not C.alive(target) then s.target_id,s.stacks=nil,0 end
end
function M.burst(this,store,target)
 if M.current(this,store)~=target then return false end
 damage(this,target,store,840+target.health.hp_max*0.12)
 return true
end
function M.ray(this,store,target)
 if M.current(this,store)~=target then return false end
 damage(this,target,store,280,DAMAGE_MAGICAL,true)
 damage(this,target,store,target.health.hp_max*0.01)
 return true
end
function M.tick(this,store) M.current(this,store) end
function M.apply(t)
 C,E,U,bit=require("allied_boss_common"),require("entity_db"),require("utils"),require("bit")
 if not t.navira_duelist then t.navira_duel_previous_pick_filter=t.melee.fn_can_pick end
 -- The common picker is rebuilt on registration; its filter preserves the duel for flying foes too.
 t.melee.fn_can_pick=function(this,target)
  local s=this.boss_state and this.boss_state.duel
  local previous=this.navira_duel_previous_pick_filter
  return (not s or not s.target_id or s.target_id==target.id) and (not previous or previous(this,target))
 end
 if t.navira_duelist then return end
 t.navira_duelist=true
 t.unit.on_damage_dealt=on_damage_dealt
 local previous_prepare=t.unit.prepare_damage
 t.unit.prepare_damage=function(this,target,store,d)
  if previous_prepare then previous_prepare(this,target,store,d) end
  if d.track_damage and bit.band(d.damage_type,DAMAGE_MODIFIER)==0 and M.current(this,store)==target then
   d.value=d.value*(1+0.15*state(this,store).stacks)
  end
 end
 local previous=t.health.on_damage
 t.health.on_damage=function(this,store,d)
  if previous and not previous(this,store,d) then return false end
  local target=M.current(this,store)
  if not target then return true end
  local s=state(this,store)
  local source=store.entities[d.source_id]
  local dealer=source and source.modifier and store.entities[source.modifier.source_id] or
   source and source.bullet and store.entities[source.bullet.source_id] or source
  if not dealer or dealer.id~=target.id then return true end
  if (d.value or 0)>0 and bit.band(d.damage_type,bit.bor(DAMAGE_ARMOR,DAMAGE_MAGICAL_ARMOR))==0 then
   if s.guards>0 and not (source.modifier or source.dps) and bit.band(d.damage_type,bit.bor(DAMAGE_MODIFIER,DAMAGE_POISON))==0 then
    s.guards=s.guards-1
    damage(this,target,store,target.health.hp_max*0.02)
    C.visual("mod_bullet_stage_19_navira_heal",this.pos,store,0.35,"idle")
    return false
   end
   d.value=d.value*(1-0.03*s.stacks)
  end
  return true
 end
end
return M
