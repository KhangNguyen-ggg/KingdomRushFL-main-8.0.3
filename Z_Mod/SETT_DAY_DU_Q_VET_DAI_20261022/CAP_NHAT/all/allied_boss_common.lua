-- Allied adaptations of FL 8.0.3 boss skills. Never execute enemy boss scripts.
local E = require("entity_db")
local A = require("animation_db")
local U = require("utils")
local SU = require("script_utils")
local V = require("klua.vector")
local bit = require("bit")
local M = {}
-- Native data is read-only and shared, never deep-cloned into every hero.
local native_by_kind, boss_by_kind = {}, {}
local function insert(e) require("simulation"):queue_insert_entity(e) end
local function remove(e) require("simulation"):queue_remove_entity(e) end
local function sound(name) if name then require("sound_db"):queue(name) end end
local function copy(p) return V.vclone(p) end
local function dist(a, b) return math.sqrt((a.x-b.x)^2+(a.y-b.y)^2) end
local function alive(e) return e and not e.pending_removal and e.health and not e.health.dead and (e.health.hp or 0) > 0 end
local function owner_alive(e)
	local boss = e and boss_by_kind[e.boss_kind]
	return alive(e) or boss and boss.owner_alive and boss.owner_alive(e)
end
local function entity_cache(store)
	local cache = store._allied_enemy_cache
	if not cache then cache = {list={},corpses={}}; store._allied_enemy_cache = cache end
	if cache.ts ~= store.tick_ts then
		local n,c = 0,0
		for _,e in pairs(store.entities) do
			if e.enemy and alive(e) then n=n+1; cache.list[n]=e end
			if (e.enemy or e.soldier) and e.health and e.health.dead then c=c+1; cache.corpses[c]=e end
		end
		for i=#cache.list,n+1,-1 do cache.list[i]=nil end
		for i=#cache.corpses,c+1,-1 do cache.corpses[i]=nil end
		cache.ts = store.tick_ts
	end
	return cache
end
local function enemy_list(store) return entity_cache(store).list end
local function target_rank(e)
	local flags=e.vis.flags
	return bit.band(flags,F_BOSS)~=0 and 2 or bit.band(flags,F_MINIBOSS)~=0 and 1 or 0
end
local function target_before(a,b,pos)
	local ar,br=target_rank(a),target_rank(b)
	if ar~=br then return ar>br end
	local ah,bh=a.health.hp_max or 0,b.health.hp_max or 0
	if ah~=bh then return ah>bh end
	local ad,bd=(a.pos.x-pos.x)^2+(a.pos.y-pos.y)^2,(b.pos.x-pos.x)^2+(b.pos.y-pos.y)^2
	if ad~=bd then return ad<bd end
	return a.id<b.id
end
local function pick_melee_target(this,store,center)
	local targets=U.find_enemies_in_range(store.entities,center,0,this.melee.range,F_BLOCK,bit.bor(F_FLYING,F_CLIFF),function(e)
		return (not e.enemy.max_blockers or #e.enemy.blockers<e.enemy.max_blockers) and
			bit.band(require("grid_db"):cell_type(e.pos.x,e.pos.y),TERRAIN_NOWALK)==0 and
			(not this.melee.fn_can_pick or this.melee.fn_can_pick(this,e))
	end) or {}
	if this.melee.can_attack_air then
		local attack=this.melee.attacks[1]
		local air=U.find_enemies_in_range(store.entities,this.pos,0,this.melee.range,F_AREA,F_CLIFF,function(e)
			local hit=copy(this.pos)
			if attack.hit_offset then
				hit.x=hit.x+(e.pos.x<this.pos.x and -1 or 1)*attack.hit_offset.x
				hit.y=hit.y+attack.hit_offset.y
			end
			return bit.band(e.vis.flags,F_FLYING)~=0 and U.is_inside_ellipse(e.pos,hit,attack.damage_radius) and
				(not this.melee.fn_can_pick or this.melee.fn_can_pick(this,e))
		end) or {}
		for _,target in ipairs(air) do targets[#targets+1]=target end
	end
	table.sort(targets,function(a,b) return target_before(a,b,center) end)
	return targets[1]
end
local function enemies(store, p, radius, ground, unordered)
	local out = {}
	for _, e in ipairs(enemy_list(store)) do
		if alive(e) and (not ground or bit.band(e.vis.flags, F_FLYING) == 0) and U.is_inside_ellipse(e.pos, p, radius) then out[#out+1] = e end
	end
	if not unordered then table.sort(out, function(a,b)
		return target_before(a,b,p)
	end) end
	return out
end
local function damage(store, owner, e, lo, hi, kind)
	if not e.enemy or not alive(e) then return end
	local d = E:create_entity("damage")
	d.source_id, d.target_id = owner.id, e.id
	local factor=owner.unit and owner.unit.damage_factor or 1
	d.value, d.damage_type = math.floor(math.random(math.floor(lo),math.floor(hi or lo))*factor), kind or DAMAGE_PHYSICAL
	store.damage_queue[#store.damage_queue+1] = d
end
local function animate(e, name, store, loop)
	for i,s in ipairs(e.render.sprites) do
		if s.animated and not s.ignore_start then
			local selected=s.prefix and (A.db[s.prefix.."_"..name] and name or "idle") or s.name
			U.animation_start(e, selected, nil, store.tick_ts, loop, i)
		end
	end
end
local function state(e, store)
	if not e.boss_state then e.boss_state = {born=store.tick_ts,last={},summons={},phase=1,obelisk=0,threshold=1} end
	return e.boss_state
end
local function ready(e, store, key, cd)
	local s = state(e,store)
	return store.tick_ts-(s.last[key] or s.born) >= cd
end
local function stamp(e,store,key) state(e,store).last[key]=store.tick_ts end

-- Visual-only effects get their own lifetime: no spawners or enemy callbacks.
local function visual(source, pos, store, duration, animation)
	local native = E.entities[source]
	if not native or not native.render then return end
	local name = "allied_visual_"..source
	if not E.entities[name] then
		local t = E:register_t(name,"decal_scripted")
		t.render = table.deepclone(native.render)
		t.main_script.insert = nil
		t.main_script.update = function(this,st)
			local start=st.tick_ts
			while st.tick_ts-start < this.life do coroutine.yield() end
			remove(this)
		end
	end
	local e = E:create_entity(name)
	e.pos, e.life = copy(pos), duration or 1
	if animation then animate(e,animation,store,true) end
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts; s.hidden=false end
	insert(e)
	return e
end
local function stun(store, owner, target, duration)
	if not alive(target) or not target.enemy or bit.band(target.vis.bans,F_STUN) ~= 0 then return end
	local m = E:create_entity("mod_stun")
	m.modifier.source_id, m.modifier.target_id, m.modifier.duration = owner.id,target.id,duration
	insert(m)
end
local function area(store,owner,pos,radius,lo,hi,kind,duration,count,ground)
	for i,e in ipairs(enemies(store,pos,radius,ground,not count)) do
		if count and i>count then break end
		if bit.band(e.vis.bans,F_AREA)==0 then
			if lo and lo>0 then damage(store,owner,e,lo,hi,kind) end
			if duration then stun(store,owner,e,duration) end
		end
	end
end

-- Summons are soldiers, not enemy templates with an allegiance flag changed.
local function pending_replacement(e,store)
    return e.death_summon and not e._replaced and e.health.dead and
        store.tick_ts<e.expires and owner_alive(e.boss_owner)
end
local function summon(owner, source, pos, store, lifetime)
	local native = assert(E.entities[source], "Missing allied summon: "..source)
	local name = "allied_summon_"..source
	if not E.entities[name] then
		local t = E:register_t(name,"soldier")
		E:add_comps(t,"melee","nav_rally","nav_grid")
		t.render, t.health_bar = table.deepclone(native.render),table.deepclone(native.health_bar)
		for _,s in ipairs(t.render.sprites) do
			if s.animated and not s.ignore_start then
				local prefix = s.prefix
				s.name="idle"
				s.angles={walk={A.db[prefix.."_walk"] and "walk" or "walkingRightLeft", A.db[prefix.."_walkUp"] and "walkUp" or "walkingUp", A.db[prefix.."_walkDown"] and "walkDown" or "walkingDown"}}
				for i,a in ipairs(s.angles.walk) do if not A.db[prefix.."_"..a] then s.angles.walk[i]=s.angles.walk[1] end end
			end
		end
		t.health.hp_max = type(native.health.hp_max)=="table" and native.health.hp_max[1] or native.health.hp_max
		t.health.hp, t.health.armor, t.health.magic_armor = t.health.hp_max,native.health.armor or 0,native.health.magic_armor or 0
		t.motion.max_speed = 60
		t.unit.size = native.unit.size
		t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=copy(native.unit.hit_offset),copy(native.unit.mod_offset),copy(native.unit.marker_offset)
		t.unit.death_animation = native.unit.death_animation or "death"
		t.ui.click_rect=table.deepclone(native.ui.click_rect)
		t.info=table.deepclone(native.info);t.info.fn=require("scripts").hero_basic.get_info_melee
		t.soldier.melee_slot_offset=V.v(10,0)
		t.melee.range=90
		local a = E:clone_c("area_attack")
		local n = native.melee.attacks[1]
		for _,key in ipairs({"damage_min","damage_max","damage_type","cooldown","hit_time","animation","hit_fx"}) do if n[key]~=nil then a[key]=n[key] end end
		a.hit_offset=V.v(10,0);a.count=n.count or n.max_count or 1;a.damage_radius=n.damage_radius or 25
		a.vis_flags,a.vis_bans,a.damage_bans,a.damage_flags=F_BLOCK,bit.bor(F_FLYING,F_CLIFF),F_FLYING,F_AREA
		t.melee.attacks[1]=a
		t.main_script.insert=nil
		t.main_script.update=function(this,st)
			while true do
				if this.health.dead then
                    if pending_replacement(this,st) then
                        this._replaced=true
                        summon(this.boss_owner,this.death_summon,this.pos,st,this.expires-st.tick_ts)
                    end
					SU.y_soldier_death(st,this);remove(this);return
				end
				if st.tick_ts>=this.expires or not owner_alive(this.boss_owner) then
					U.unblock_target(st,this);remove(this);return
				end
				local boss = boss_by_kind[this.boss_owner.boss_kind]
				if boss.summon_passive then boss.summon_passive(this,st) end
				if this.unit.is_stunned then SU.soldier_idle(st,this)
				elseif this.nav_rally.new then SU.y_soldier_new_rally(st,this)
				else
					local interrupted,result=SU.y_soldier_melee_block_and_attacks(st,this)
					if not interrupted and result==A_NO_TARGET and not SU.soldier_go_back_step(st,this) then SU.soldier_idle(st,this) end
				end
				coroutine.yield()
			end
		end
	end
	local e = E:create_entity(name)
	e.pos, e.boss_owner, e.summon_source, e.expires = copy(pos),owner,source,store.tick_ts+(lifetime or 60)
	e.death_summon = native.death_spawns and native.death_spawns.name
	e.nav_rally.pos,e.nav_rally.center,e.nav_rally.new=copy(pos),copy(pos),true
	e.health.hp=e.health.hp_max
    local boss=boss_by_kind[owner.boss_kind]
    if boss.configure_summon then boss.configure_summon(owner,e,store) end
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts end
	local s=state(owner,store)
	for i=#s.summons,1,-1 do
		local old=s.summons[i]
        if not alive(old) and not pending_replacement(old,store) or old._replaced or store.tick_ts>=old.expires then table.remove(s.summons,i) end
	end
	s.summons[#s.summons+1]=e
	insert(e)
	return e
end
local function living_summons(owner,store)
	local out=state(owner,store).summons
	for i=#out,1,-1 do
		local e=out[i]
        if not alive(e) and not pending_replacement(e,store) or store.tick_ts>=e.expires or e._replaced then table.remove(out,i) end
	end
	return out
end
local function group(owner,source,pos,count,store,life)
	for i=1,count do
		local angle=2*math.pi*(i-1)/count
		summon(owner,source,V.v(pos.x+18*math.cos(angle),pos.y+12*math.sin(angle)),store,life)
	end
end
function M.raise(owner,store,source,radius,cd,cap)
	if not ready(owner,store,"raise",cd) then return end
	stamp(owner,store,"raise")
	local boss_owner=owner.boss_owner or owner
	if #living_summons(boss_owner,store)>=cap then return end
	for _,e in ipairs(entity_cache(store).corpses) do
		if e.enemy and e.health and e.health.dead and not e._allied_corpse_claimed and e.unit and bit.band(e.vis.flags,bit.bor(F_FLYING,F_BOSS,F_MINIBOSS))==0 and U.is_inside_ellipse(e.pos,owner.pos,radius) then
			e._allied_corpse_claimed=true
            return summon(boss_owner,source,e.pos,store,60)
		end
	end
end

-- Same native projectile graphics; target/damage lifecycle belongs to allies.
local function projectile(owner, source, target, pos, store, spec)
	local native=assert(E.entities[source],"Missing allied projectile: "..source)
	local name="allied_projectile_"..source
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		t.render=table.deepclone(native.render)
		t.main_script.update=function(this,st)
			local start=st.tick_ts
			local from=copy(this.pos)
			while st.tick_ts-start<this.flight do
				if alive(this.target) then
					this.destination=copy(this.target.pos)
					if this.spec.hit_offset and this.target.unit and this.target.unit.hit_offset then
						this.destination.x=this.destination.x+this.target.unit.hit_offset.x
						this.destination.y=this.destination.y+this.target.unit.hit_offset.y
					end
				end
				if this.spec.rotate then
					local sprite=this.render.sprites[1]
					sprite.r=(math.atan2 or math.atan)(this.destination.y-from.y,this.destination.x-from.x)
				end
				local f=math.min(1,(st.tick_ts-start)/this.flight)
				if this.spec.beam then
					local sprite=this.render.sprites[1]
					local dx,dy=this.destination.x-from.x,this.destination.y-from.y
					sprite.r=(math.atan2 or math.atan)(dy,dx)
					sprite.scale=V.v(dist(from,this.destination)/186,1)
				else
					this.pos.x=from.x+(this.destination.x-from.x)*f
					this.pos.y=from.y+(this.destination.y-from.y)*f+math.sin(f*math.pi)*this.arc
				end
				coroutine.yield()
			end
			if this.spec.summon then group(this.boss_owner,this.spec.summon,this.destination,this.spec.count,st,45)
			elseif this.spec.radius then area(st,this.boss_owner,this.destination,this.spec.radius,this.spec.lo,this.spec.hi,this.spec.kind,this.spec.stun,nil,false)
			elseif alive(this.target) then
				if (this.spec.lo or 0)>0 then damage(st,this.boss_owner,this.target,this.spec.lo,this.spec.hi,this.spec.kind) end
				if this.spec.stun then stun(st,this.boss_owner,this.target,this.spec.stun) end
			end
			if this.spec.fx then visual(this.spec.fx,this.destination,st,this.spec.fx_duration or 1) end
			if this.spec.decal then visual(this.spec.decal,this.destination,st,2) end
			if this.spec.on_hit then this.spec.on_hit(this.boss_owner,this.destination,st) end
			sound(this.hit_sound)
			remove(this)
		end
	end
	local e=E:create_entity(name)
	e.pos=V.v(owner.pos.x,owner.pos.y+(spec.height or 40))
	if spec.offset_x then e.pos.x=e.pos.x+spec.offset_x end
	e.target,e.destination,e.boss_owner,e.spec=target,copy(pos),owner,table.deepclone(spec)
	e.spec.fx=e.spec.fx or native.bullet.hit_fx
	e.spec.decal=native.bullet.decal_fx
	e.hit_sound=native.sound_events and native.sound_events.hit
	sound(native.sound_events and native.sound_events.insert)
	e.flight,e.arc=spec.flight or math.max(0.2,dist(e.pos,pos)/350),spec.arc or 0
	for _,s in ipairs(e.render.sprites) do
		s.ts=store.tick_ts
		if s.animated and s.prefix then
			if A.db[s.prefix.."_flying"] then s.name="flying"
			elseif A.db[s.prefix.."_run"] then s.name="run" end
		end
	end
	insert(e)
	return e
end

local function passive(this,store)
	local s=state(this,store)
	if store.tick_ts-(s.cleanup_ts or s.born)>=1 then living_summons(this,store);s.cleanup_ts=store.tick_ts end
	local boss=boss_by_kind[this.boss_kind]
	if boss.passive then boss.passive(this,store) end
end
local function wait(this,store,duration,step)
	local start=store.tick_ts
	while store.tick_ts-start<duration do
		if not alive(this) or this.unit.is_stunned then return false end
		passive(this,store)
		if step and step() then return alive(this) and not this.unit.is_stunned end
		coroutine.yield()
	end
	return alive(this) and not this.unit.is_stunned
end
local function cast(this,store,animation,time,sound_name)
	-- Stationary skills keep their melee slot; movement releases it when leaving.
	sound(sound_name)
	animate(this,animation,store,false)
	return wait(this,store,time or 0.5,function() return this.nav_rally.new end) and not this.nav_rally.new
end

-- Shared only by the Hammerhold adaptations. Always restore temporary flags.
function M.land(this,pos)
	this.pos=copy(pos)
	this.nav_rally.pos,this.nav_rally.center,this.nav_rally.new=copy(pos),copy(pos),false
	this.nav_grid.waypoints=nil
	U.set_destination(this,this.pos)
	this.motion.arrived=true
	this.motion.speed.x,this.motion.speed.y=0,0
end
function M.move_form(this,store,duration,factor,animation,step,shield,until_arrived)
	U.unblock_target(store,this)
	local speed,bans,ignore=this.motion.max_speed,this.vis.bans,this.health.ignore_damage
	this.motion.max_speed=speed*factor
	this.vis.bans=bit.bor(bans,F_BLOCK,F_STUN)
	if shield then this.health.ignore_damage=true end
	this.boss_form=true
	this.nav_grid.waypoints=nil
	animate(this,animation,store,true)
	local completed=wait(this,store,duration,function()
		if not step then
			if this.nav_rally.new then
				this.nav_rally.new=false;U.set_destination(this,this.nav_rally.pos)
			end
			if not this.motion.arrived and this.motion.dest then U.walk(this,store.tick_length) end
		else step() end
		return until_arrived and this.motion.arrived
	end)
	this.motion.max_speed,this.vis.bans,this.health.ignore_damage=speed,bans,ignore
	this.boss_form=nil
	return completed
end

local function automatic(this,store)
	local boss=boss_by_kind[this.boss_kind]
	local skill,s=boss.skill,state(this,store)
	if store.tick_ts < (s.next_ai or s.born + (this.id % 8) / 32) then return false end
	s.next_ai=store.tick_ts+0.25
	-- Claim a nearby ground enemy through normal melee before beginning a skill.
	if not U.blocker_rank(store,this) then
		local target=SU.soldier_pick_melee_target(store,this)
		if target and bit.band(target.vis.flags,F_FLYING)==0 then return false end
	end
	local targets=enemies(store,this.pos,math.max(500,skill.range),false)
	if boss.active and #targets>0 and ready(this,store,"active",skill.cooldown) then
		local pos
		if boss.active_radius then
			if #enemies(store,this.pos,boss.active_radius(native_by_kind[this.boss_kind]),not boss.can_attack_air)>0 then pos=copy(this.pos) end
		else
			for _,target in ipairs(targets) do
				if dist(this.pos,target.pos)<=skill.range and bit.band(target.vis.flags,F_FLYING)==0 and
					require("path_db"):valid_node_nearby(target.pos.x,target.pos.y,nil,NF_RALLY) and
					require("grid_db"):cell_is_only(target.pos.x,target.pos.y,bit.bor(TERRAIN_LAND,TERRAIN_ICE)) then
					pos=copy(target.pos); break
				end
			end
		end
		if pos then stamp(this,store,"active");boss.active(this,store,pos);return true end
	end
	return boss.automatic and boss.automatic(this,store,targets) or false
end
function M.decorate(t,native,def)
	local kind=def.kind;assert(def.skill)
	SU=require("script_utils")
	boss_by_kind[kind]=def
	native_by_kind[kind] = native
	-- Repair aliases only after animation/template reloads, not on every spawn.
	local repair = false
	for i,sp in ipairs(native.render.sprites) do
		local dst=t.render.sprites[i]
		if sp.animated and dst and sp.prefix and dst.prefix and
			A.db[dst.prefix.."_skill_alias_ready"] ~= A.db[sp.prefix.."_idle"] then repair=true end
	end
	if repair then
		local aliases={}
		for i,sp in ipairs(native.render.sprites) do
			local dst=t.render.sprites[i]
			if sp.animated and dst and sp.prefix and dst.prefix then
				local prefix=sp.prefix.."_"
				for key,a in pairs(A.db) do
					if key:sub(1,#prefix)==prefix then aliases[dst.prefix.."_"..key:sub(#prefix+1)]=a end
				end
				aliases[dst.prefix.."_skill_alias_ready"]=A.db[sp.prefix.."_idle"]
			end
		end
		for key,a in pairs(aliases) do A.db[key]=a end
	end

	if def.prepare then def.prepare(t) end
	t.melee.can_attack_air=def.can_attack_air
	if def.can_attack_air then
		for _,attack in ipairs(t.melee.attacks) do
			attack.vis_flags=bit.bor(bit.band(attack.vis_flags,bit.bnot(F_BLOCK)),F_AREA)
			attack.vis_bans=bit.band(attack.vis_bans,bit.bnot(F_FLYING))
			attack.damage_bans=bit.band(attack.damage_bans,bit.bnot(F_FLYING))
		end
	end
	t.melee.fn_pick_target=pick_melee_target
	t.melee.fn_sort_targets=target_before
	t.health.immune_to=bit.bor(t.health.immune_to or 0,DAMAGE_INSTAKILL,DAMAGE_EAT)
	t.vis.bans=bit.bor(t.vis.bans,F_INSTAKILL,F_EAT)
	if t.boss_kind then return t end
	t.boss_kind=kind
	t.hero.skills={}
	t.main_script.update=function(this,store)
		while true do
			state(this,store)
			if this.health.dead then
				this.boss_command=nil
				if not (def.dead and def.dead(this,store)) then
					SU.y_hero_death_and_respawn(store,this)
					this.boss_state=nil
					if def.respawn then def.respawn(this) end
				end
            elseif def.hold and def.hold(this,store) then
                -- The owner is temporarily reforming; its army retains its remaining lifetime.
            elseif this.unit.is_stunned then SU.soldier_idle(store,this)
			else
				passive(this,store)
				if this.nav_rally.new then
					if def.rally then def.rally(this,store) else SU.y_hero_new_rally(store,this) end
				else
					this.boss_casting=true
					local used=automatic(this,store)
					this.boss_casting=nil
					if not used then
						local interrupted,result=SU.y_soldier_melee_block_and_attacks(store,this)
						if not interrupted and result==A_NO_TARGET and not SU.soldier_go_back_step(store,this) then SU.soldier_idle(store,this);SU.soldier_regen(store,this) end
					end
				end
			end
			this.hero.xp_queued=0
			coroutine.yield()
		end
	end
	return t
end

function M.create(def)
	local name=def.name
	local E, A = require("entity_db"), require("animation_db")
	local scripts, GS = require("scripts"), require("game_settings")
	local V, bit = require("klua.vector"), require("bit")
	local boss = assert(E:get_template(def.source), "Boss template missing: " .. def.source)
	local render = E.entities[name] and E.entities[name].render or table.deepclone(boss.render)
	-- Normalize names per visual layer, including bosses with no walking animation.
	for i, sprite in ipairs(render.sprites) do
		if sprite.animated and not sprite.ignore_start then
			local source, prefix = boss.render.sprites[i].prefix, name .. "_layer" .. i
			local function alias(target, candidates)
				for _, candidate in ipairs(candidates) do
					local animation = A.db[source .. "_" .. candidate]
					if animation then A.db[prefix .. "_" .. target] = animation; return end
				end
				error("Boss animation missing: " .. source .. "_" .. target)
			end
			alias("idle", {"idle", "walk"})
			alias("attack", {boss.melee and boss.melee.attacks[1].animation or "attack", "attack", "melee"})
			alias("death", {boss.unit.death_animation or "death", "death", "deathIn"})
			alias("walk", {"walk", "walkingRightLeft", "idle"})
			alias("walkUp", {"walkUp", "walkingUp", "walk", "idle"})
			alias("walkDown", {"walkDown", "walkingDown", "walk", "idle"})
			alias("respawn", {"idle", "walk"})
			sprite.prefix, sprite.name = prefix, "idle"
			sprite.angles = {walk = {"walk", "walkUp", "walkDown"}}
			sprite.hidden = false
		end
	end
	-- Animation databases may reload independently of entity templates.
	if E.entities[name] then return M.decorate(E.entities[name], boss, def) end
	local t = E:register_t(name, "hero")
	E:add_comps(t, "melee")
	t.render = render
	t.health.hp_max = type(boss.health.hp_max) == "table" and boss.health.hp_max[1] or boss.health.hp_max
	t.health.hp, t.health.armor, t.health.magic_armor = t.health.hp_max, boss.health.armor or 0, boss.health.magic_armor or 0
	t.health.dead_lifetime = 20
	t.health_bar = table.deepclone(boss.health_bar)
	t.health_bar.hidden = false
	t.motion.max_speed = 60
	t.regen.cooldown, t.regen.health = 1, math.ceil(t.health.hp_max / 100)
	t.info.fn, t.info.i18n_key = scripts.hero_basic.get_info_melee, boss.info.i18n_key
	t.info.portrait, t.info.hero_portrait = def.icon, def.icon
	t.ui.click_rect = table.deepclone(boss.ui.click_rect)
	t.unit.size = boss.unit.size
	t.unit.hit_offset, t.unit.mod_offset, t.unit.marker_offset = V.vclone(boss.unit.hit_offset), V.vclone(boss.unit.mod_offset), V.vclone(boss.unit.marker_offset)
	t.soldier.melee_slot_offset = V.v(25, 0)
	t.melee.range = 100
	local attack = E:clone_c("area_attack")
	local native = boss.melee and boss.melee.attacks[1]
		attack.damage_min, attack.damage_max = native.damage_min, native.damage_max
		attack.damage_type, attack.cooldown, attack.hit_time = native.damage_type, native.cooldown, native.hit_time
		attack.damage_radius, attack.count = native.damage_radius or 45, native.count or native.max_count or 8
		attack.hit_offset = native.hit_offset and V.vclone(native.hit_offset) or V.v(25, 0)
	attack.animation, attack.vis_flags = "attack", F_BLOCK
	attack.vis_bans, attack.damage_bans, attack.damage_flags = bit.bor(F_FLYING, F_CLIFF), F_FLYING, F_AREA
	attack.xp_gain_factor = 0
	if native then attack.sound = native.sound or native.sound_hit; attack.hit_fx = native.hit_fx end
	t.melee.attacks[1] = attack
	t.hero.skills = {}
	t.hero.fn_level_up = function(this, store, initial)
		this.hero.level, this.hero.xp, this.hero.xp_queued = 10, GS.hero_xp_thresholds[9], 0
		if initial then this.health.hp = this.health.hp_max end
	end
	t.main_script.insert = scripts.hero_basic.insert
	return M.decorate(t, boss, def)
end

M.alive,M.copy,M.dist=alive,copy,dist
M.state,M.ready,M.stamp=state,ready,stamp
M.animate,M.wait,M.cast=animate,wait,cast
M.area,M.visual,M.projectile=area,visual,projectile
M.summon,M.living_summons=summon,living_summons
M.insert,M.remove=insert,remove
M.target_before=target_before
function M.corpses(store) return entity_cache(store).corpses end
function M.native(this) return native_by_kind[this.boss_kind] end
return M
