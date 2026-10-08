local E = require("entity_db")
local U = require("utils_6")
local SU = require("script_utils_6")
local V = require("klua.vector")
local bit = require("bit")

local function enemies(store, pos, range)
	return U.find_enemies_in_range(store.entities, pos, 0, range, 0, 0) or {}
end

local function all_enemies(store)
	local result = {}
	for _, entity in pairs(store.entities) do
		if entity.enemy and entity.health and not entity.health.dead and not entity.pending_removal then
			result[#result + 1] = entity
		end
	end
	return result
end

local function damage(store, source, target, value, damage_type, armor_pierce)
	local d = E:create_damage()
	d.source_id = source
	d.target_id = target.id
	d.value = value
	d.damage_type = damage_type
	if armor_pierce then
		d.reduce_armor = armor_pierce
	end
	store.damage_queue[#store.damage_queue + 1] = d
end

local function modifier(store, name, source, target, duration)
	local m = E:create_entity(name)
	m.modifier.source_id = source
	m.modifier.target_id = target.id
	m.modifier.duration = duration
	simulation:queue_insert_entity(m)
end

local function weak(store, source, target, duration)
	modifier(store, "mod_silent_weak", source, target, duration)
	target.silent_weak_until = math.max(target.silent_weak_until or 0, store.tick_ts + duration)
end

local function ranged_heal(hero)
	if hero.hero.skills.upg_c.level > 0 then
		hero.health.hp = math.min(hero.health.hp_max,
			hero.health.hp + hero.health.hp_max * 0.02)
	end
end

local function launch(store, hero, target, min_damage, max_damage, poison, weakness, giant)
	local p = E:create_entity("bullet_silent_knife")
	p.pos = V.vclone(hero.pos)
	p.pos.y = p.pos.y + 28
	p.bullet.from = V.vclone(p.pos)
	p.bullet.to = V.vclone(target.pos)
	p.bullet.target_id = target.id
	p.bullet.source_id = hero.id
	p.bullet.damage_min = min_damage
	p.bullet.damage_max = max_damage
	p.silent_poison = poison
	p.silent_weak = weakness
	p.silent_giant = giant
	simulation:queue_insert_entity(p)
	ranged_heal(hero)
end

local function ready(store, attack)
	return store.tick_ts - (attack.ts or -1000) >= attack.cooldown
end

local function cast(store, hero, animation)
	U.animation_start(hero, animation, nil, store.tick_ts, false, 1)
	return not SU.y_hero_wait(store, hero, 0.2)
end

return function(scripts)
	scripts.hero_silent = {}
	function scripts.hero_silent.get_info(this)
		return {
			type = STATS_TYPE_SOLDIER,
			hp = this.health.hp,
			hp_max = this.health.hp_max,
			damage_min = this.silent_ranged_damage_min,
			damage_max = this.silent_ranged_damage_max,
			damage_type = DAMAGE_PHYSICAL,
			armor = this.health.armor,
			respawn = this.health.dead_lifetime
		}
	end

	function scripts.hero_silent.melee_damage(this, store, attack, target)
		local value = math.ceil(this.unit.damage_factor * math.random(attack.damage_min, attack.damage_max))
		if this.hero.skills.upg_d.level > 0 and target.silent_weak_until
			and target.silent_weak_until > store.tick_ts then
			value = math.ceil(value * 1.5)
		end
		return value
	end

	function scripts.hero_silent.level_up(this, store, initial)
		local level = this.hero.level
		local stats = this.hero.level_stats
		this.health.hp_max = stats.hp_max[level]
		this.regen.health = stats.regen_health[level]
		this.health.armor = this.hero.skills.talent_1.disabled and 0 or 1
		this.melee.attacks[1].damage_min = stats.melee_damage_min[level]
		this.melee.attacks[1].damage_max = stats.melee_damage_max[level]
		this.melee.attacks[1].mod = this.hero.skills.upg_e.level > 0 and "mod_silent_catalyst" or nil
		this.silent_ranged_damage_min = stats.ranged_damage_min[level] + (this.hero.skills.upg_b.level > 0 and 9 or 0)
		this.silent_ranged_damage_max = stats.ranged_damage_max[level] + (this.hero.skills.upg_b.level > 0 and 9 or 0)
		this.silent_apply_weak = this.hero.skills.upg_b.level > 0
		this.health.hp = this.health.hp_max
	end

	function scripts.hero_silent.insert(this, store)
		this.hero.fn_level_up(this, store, true)
		this.melee.order = U.attack_order(this.melee.attacks)
		this.ranged.order = U.attack_order(this.ranged.attacks)
		this.silent_finisher_uses = 0
		return true
	end

	function scripts.hero_silent.update(this, store)
		local attacks = this.timed_attacks.list
		while true do
			if this.health.dead then
				SU.y_hero_death_and_respawn_kr5(store, this)
			elseif this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					SU.y_hero_new_rally(store, this)
				end
				SU.hero_level_up(store, this)
				local targets = enemies(store, this.pos, 180)
				local target = targets[1]
				local a, b, c, ult = attacks[1], attacks[2], attacks[3], attacks[4]
				if this.hero.skills.ultimate.active and this.hero.skills.skill_a.level == 3
					and this.hero.skills.skill_b.level == 3 and this.hero.skills.skill_c.level == 3
					and not ready(store, a) and not ready(store, b) and not ready(store, c)
					and ready(store, ult) and #all_enemies(store) > 0 then
					if cast(store, this, "ultimate") then
						for _, enemy in ipairs(all_enemies(store)) do
							damage(store, this.id, enemy, 300, DAMAGE_TRUE)
						end
						ult.ts = store.tick_ts
						SU.hero_gain_xp_from_skill(this, this.hero.skills.ultimate)
					end
				elseif target and not this.hero.skills.talent_2.disabled and ready(store, attacks[5]) then
					if cast(store, this, "summon") then
						for i = 1, 4 do
							local offset = attacks[5].entity_offsets[i]
							local clone = E:create_entity("soldier_silent_clone")
							clone.pos.x = this.pos.x + offset.x
							clone.pos.y = this.pos.y + offset.y
							clone.nav_rally.center = V.vclone(clone.pos)
							clone.nav_rally.pos = V.vclone(clone.pos)
							clone.render.sprites[1].flip_x = this.render.sprites[1].flip_x
							clone.tween.ts = store.tick_ts
							clone.tween.props[1].keys[1][2].x = -offset.x
							clone.tween.props[1].keys[1][2].y = -offset.y
							clone.silent_owner_id = this.id
							clone.silent_offset = V.vclone(offset)
							simulation:queue_insert_entity(clone)
						end
						attacks[5].ts = store.tick_ts
					end
				elseif target and this.hero.skills.skill_a.level > 0 and ready(store, a) then
					if cast(store, this, "skill_a") then
						local tier = this.hero.skills.skill_a.level
						local count = ({3, 4, 6})[tier]
						local mins, maxs = ({19, 37, 55})[tier], ({28, 57, 76})[tier]
						for i = 1, math.min(count, #targets) do
							launch(store, this, targets[i], mins, maxs,
								"mod_silent_poison_" .. tier,
								this.hero.skills.upg_b.level > 0 and 3 or nil)
						end
						a.ts = store.tick_ts
						SU.hero_gain_xp_from_skill(this, this.hero.skills.skill_a)
					end
				elseif #enemies(store, this.pos, 100) > 0
					and this.hero.skills.skill_b.level > 0 and ready(store, b) then
					if cast(store, this, "skill_b") then
						local tier = this.hero.skills.skill_b.level
						for _, enemy in ipairs(enemies(store, this.pos, 100)) do
							local value = ({30, 40, 170})[tier]
							if this.hero.skills.upg_d.level > 0 and enemy.silent_weak_until
								and enemy.silent_weak_until > store.tick_ts then
								value = math.ceil(value * 1.5)
							end
							damage(store, this.id, enemy, value, DAMAGE_PHYSICAL)
							modifier(store, "mod_silent_stun", this.id, enemy, ({1, 2, 5})[tier])
							weak(store, this.id, enemy, ({2, 4, 10})[tier])
						end
						b.ts = store.tick_ts
						SU.hero_gain_xp_from_skill(this, this.hero.skills.skill_b)
					end
				elseif target and this.hero.skills.skill_c.level > 0 and ready(store, c) then
					if cast(store, this, "skill_c") then
						local tier = this.hero.skills.skill_c.level
						local count = ({4, 6, 8})[tier] + math.floor(this.silent_finisher_uses / 3)
						local min_damage = ({8, 11, 14})[tier] + this.silent_finisher_uses
						local max_damage = ({17, 21, 25})[tier] + this.silent_finisher_uses
						local thrown = 0
						for i = 1, count do
							if target.health.dead then break end
							launch(store, this, target, min_damage, max_damage, nil,
								this.hero.skills.upg_b.level > 0 and 3 or nil)
							thrown = thrown + 1
							U.y_wait(store, 0.08)
						end
						local knife = E:create_entity("bullet_silent_giant")
						knife.pos = V.vclone(this.pos)
						knife.pos.y = knife.pos.y + 28
						knife.silent_source_id = this.id
						knife.silent_dx = target.pos.x - this.pos.x
						knife.silent_dy = target.pos.y - this.pos.y
						knife.silent_count = thrown
						simulation:queue_insert_entity(knife)
						this.silent_finisher_uses = this.silent_finisher_uses + 1
						c.ts = store.tick_ts
						SU.hero_gain_xp_from_skill(this, this.hero.skills.skill_c)
					end
				else
					local interrupted, status = SU.y_soldier_melee_block_and_attacks(store, this)
					if not interrupted and status == A_NO_TARGET then
						local ranged_interrupted, ranged_status = SU.y_soldier_ranged_attacks(store, this)
						if ranged_status == A_DONE then ranged_heal(this) end
						if not ranged_interrupted then
							if not SU.soldier_go_back_step(store, this) then
								SU.soldier_idle(store, this)
							end
						end
					end
				end
				SU.soldier_regen(store, this)
			end
			coroutine.yield()
		end
	end

	scripts.silent_knife = {}
	function scripts.silent_knife.insert(this, store, script)
		if this.template_name == "bullet_silent_basic" then
			local owner = store.entities[this.bullet.source_id]
			if owner and owner.silent_ranged_damage_min then
				this.bullet.damage_min = owner.silent_ranged_damage_min
				this.bullet.damage_max = owner.silent_ranged_damage_max
				this.bullet.mod = owner.silent_apply_weak and "mod_silent_weak" or nil
			end
		end
		return scripts.bolt.insert(this, store, script)
	end
	function scripts.silent_knife.update(this, store, script)
		local target_id = this.bullet.target_id
		local source_id = this.bullet.source_id
		local poison, weak_duration = this.silent_poison, this.silent_weak
		scripts.bolt.update(this, store, script)
		local target = store.entities[target_id]
		local hit_damage
		for i = #store.damage_queue, 1, -1 do
			local d = store.damage_queue[i]
			if d.source_id == this.id and d.target_id == target_id then
				hit_damage = d
				break
			end
		end
		if hit_damage and target and target.health and not target.health.dead then
			local was_weak = target.silent_weak_until and target.silent_weak_until > store.tick_ts
			local owner = store.entities[source_id]
			if poison then modifier(store, poison, source_id, target, 4.5) end
			if weak_duration then
				weak(store, source_id, target, weak_duration)
			elseif this.bullet.mod == "mod_silent_weak" then
				target.silent_weak_until = math.max(target.silent_weak_until or 0, store.tick_ts + 3)
			end
			if was_weak and owner and owner.hero and owner.hero.skills.upg_d.level > 0 then
				hit_damage.value = math.ceil(hit_damage.value * 1.5)
			end
		end
	end

	scripts.silent_giant = {}
	function scripts.silent_giant.insert(this, store)
		return true
	end
	function scripts.silent_giant.update(this, store)
		local len = math.sqrt(this.silent_dx ^ 2 + this.silent_dy ^ 2)
		if len == 0 then len = 1 end
		local dx, dy = this.silent_dx / len, this.silent_dy / len
		local distance, hit = 0, {}
		while distance < 400 do
			local step = math.min(400 - distance, 750 * store.tick_length)
			this.pos.x = this.pos.x + dx * step
			this.pos.y = this.pos.y + dy * step
			distance = distance + step
			for _, target in ipairs(enemies(store, this.pos, 30)) do
				if not hit[target.id] then
					hit[target.id] = true
					local value = 40 + 10 * this.silent_count
					local owner = store.entities[this.silent_source_id]
					if owner and owner.hero and owner.hero.skills.upg_d.level > 0
						and target.silent_weak_until and target.silent_weak_until > store.tick_ts then
						value = math.ceil(value * 1.5)
					end
					damage(store, this.silent_source_id, target, value, DAMAGE_PHYSICAL,
						(target.health.armor or 0) * math.min(1, 0.03 * this.silent_count))
				end
			end
			coroutine.yield()
		end
		simulation:queue_remove_entity(this)
	end

	scripts.silent_clone = {}
	function scripts.silent_clone.insert(this, store)
		local owner = store.entities[this.silent_owner_id]
		if not owner then return false end
		this.silent_damage_min = owner.silent_ranged_damage_min
		this.silent_damage_max = owner.silent_ranged_damage_max
		this.health.hp = this.health.hp_max
		return true
	end
	function scripts.silent_clone.update(this, store)
		local expiry, last = store.tick_ts + 15, -1000
		local walking = false
		while store.tick_ts < expiry and not this.health.dead do
			local owner = store.entities[this.silent_owner_id]
			if not owner or owner.health.dead then
				break
			end
			local follow_x = owner.pos.x + this.silent_offset.x
			local follow_y = owner.pos.y + this.silent_offset.y
			local distance = V.dist(this.pos.x, this.pos.y, follow_x, follow_y)
			if distance > 45 or (walking and distance > 8) then
				U.set_destination(this, V.v(follow_x, follow_y))
				if not walking then
					U.animation_start(this, "walk", nil, store.tick_ts, true, 1)
					walking = true
				end
				U.walk(this, store.tick_length)
			else
				if walking then
					this.motion.arrived = true
					walking = false
					U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
				end
				if store.tick_ts - last >= 1 then
					local target = enemies(store, this.pos, 180)[1]
					if target then
						U.animation_start(this, "ranged", nil, store.tick_ts, false, 1)
						damage(store, this.id, target,
							math.random(this.silent_damage_min, this.silent_damage_max), DAMAGE_PHYSICAL)
						last = store.tick_ts
					else
						U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
					end
				end
			end
			coroutine.yield()
		end
		simulation:queue_remove_entity(this)
	end
end
