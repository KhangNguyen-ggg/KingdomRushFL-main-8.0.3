local log = require("klua.log"):new("game_scripts")

require("klua.table")

local km = require("klua.macros")
local signal = require("hump.signal")
local earnings_stats = require("earnings_stats")
local AC = require("achievements")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local P = require("path_db")
local S = require("sound_db")
local SU = require("script_utils_123")
local U = require("utils_123")
local ULH = require("utils_lh")
local LU = require("level_utils")
local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local F = require("klove.font_db")
local I = require("klove.image_db")
local G = love.graphics
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("scripts_123")
local K45 = require("game_scripts-45")

local function queue_insert(store, e)
	simulation:queue_insert_entity(e)
end

local function queue_remove(store, e)
	simulation:queue_remove_entity(e)
end

local function queue_damage(store, damage)
	store.damage_queue[#store.damage_queue + 1] = damage
end

local function fts(v)
	return v / FPS
end

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or e.pos
end

--少林
scripts.tower_shaolin = {}

function scripts.tower_shaolin.get_info(this)
	local a = this.attacks.list[1]
	local b = E:get_template(a.bullet)
	local min, max = b.bullet.damage_min, b.bullet.damage_max

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = this.attacks.enemy_cooldown

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_shaolin.insert(this, store)
	this.aura1 = nil
	if this.auras then
		for _, a in pairs(this.auras.list) do
			local e = E:create_entity(a.name)
			e.pos = V.vclone(this.pos)
			e.aura.level = 1
			e.aura.source_id = this.id
			e.aura.ts = store.tick_ts
			if this.powers and this.powers.lion.level >= 1 then
				this.aura1 = e
				queue_insert(store, e)
			end
		end
	end
	if this.tower.level == 4 then
		if not this.barrack.rally_pos and this.tower.default_rally_pos then
			this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
		end
	end

	return true
end

function scripts.tower_shaolin.remove(this, store)
	
	if this.pixies then
		for _, e in pairs(this.pixies) do
			if e.is_stun == true then
				SU.stun_dec(e.target_stun)
			end
			e.owner = nil

			queue_remove(store, e)
		end
	end
	
	if this.aura1 then
		queue_remove(store, this.aura1)
	end

	if this.tower.level == 4 then
		for _, s in pairs(this.barrack.soldiers) do
			if s.health then
				s.health.dead = true
			end

			queue_remove(store, s)
		end
	end

	return true
end

function scripts.tower_shaolin.update(this, store)
	local a = this.attacks
	this.pixies = {}
	a.ts = store.tick_ts
	this.idle_offsets = {v(-18, -1),v(21, -3),v(5, -9),
		v(-18, -1),v(21, -3),v(5, -9)}
	local pow_d = this.powers and this.powers.dragon
	local pow_l = this.powers and this.powers.lion
	local pow_t = this.powers and this.powers.total
	local enemy_cooldowns = {}
	local ba = this.barrack

	local function spawn_pixie()
		local e = E:create_entity("decal_shaolin_lvl"..this.tower.level)
		local po = this.idle_offsets[#this.pixies + 1]

		e.idle_pos = po
		e.pos.x, e.pos.y = this.pos.x + po.x, this.pos.y + po.y

		queue_insert(store, e)
		table.insert(this.pixies, e)
		e.render.sprites[1].hidden = true

		e.owner = this
	end

	spawn_pixie()
	spawn_pixie()
	spawn_pixie()

	this.anim_play_out = false
	this.anim_play_in = false
	while true do
		if this.tower.blocked then
			-- block empty
		else
			if pow_t and pow_t.changed and #this.pixies < 6 then
				pow_t.changed = nil

				spawn_pixie()
			end

			if pow_l and pow_l.changed then
				pow_l.changed = nil
				this.render.sprites[5].hidden = false
				if this.aura1 == nil then
					local e = E:create_entity("aura_tower_shaolin_gold")
					e.pos = V.vclone(this.pos)
					e.aura.level = 1
					e.aura.source_id = this.id
					e.aura.ts = store.tick_ts
								
					this.aura1 = e
								
					if this.powers and this.powers.lion.level >= 1 then
						queue_insert(store, e)				
					end
				end
			end
			

			if pow_d and pow_d.level > 0 then
					if pow_d.changed then
						pow_d.changed = nil
	
						local s = ba.soldiers[1]
	
						if s and store.entities[s.id] then
							s.unit.level = pow_d.level
							s.health.armor = s.health.armor
							s.health.hp_max = s.health.hp_max
							s.health.hp = s.health.hp_max
	
							local ma = s.melee.attacks[1]
	
							ma.damage_min = ma.damage_min
							ma.damage_max = ma.damage_max
						end
					end
	
					local s = ba.soldiers[1]
	
					if s and s.health.dead then
						last_soldier_pos = s.pos
					end
	
					if not s or s.health.dead and store.tick_ts - s.health.death_ts > s.health.dead_lifetime then
						local ns = E:create_entity(ba.soldier_type)
	
						ns.soldier.tower_id = this.id
						--ns.pos = last_soldier_pos or V.v(ba.rally_pos.x, ba.rally_pos.y)
						if not ba.rally_pos and this.tower.default_rally_pos then
							ba.rally_pos = V.vclone(this.tower.default_rally_pos)
						end
						ns.pos = V.v(ba.rally_pos.x, ba.rally_pos.y)
						ns.nav_rally.pos = V.vclone(ba.rally_pos)
						ns.nav_rally.center = V.vclone(ba.rally_pos)
						ns.nav_rally.new = true
						ns.unit.level = 1
						ns.health.armor = ns.health.armor
						ns.health.hp_max = ns.health.hp_max
	
						local ma = ns.melee.attacks[1]
	
						ma.damage_min = ma.damage_min
						ma.damage_max = ma.damage_max
	
						queue_insert(store, ns)
	
						ba.soldiers[1] = ns
						s = ns
					end
	
					if ba.rally_new then
						ba.rally_new = false
	
						signal.emit("rally-point-changed", this)

						if s then
							s.nav_rally.pos = V.vclone(ba.rally_pos)
							s.nav_rally.center = V.vclone(ba.rally_pos)
							s.nav_rally.new = true
	
							if not s.health.dead then
								S:queue(this.sound_events.change_rally_point)
							end
						end
					end
			end

			if store.tick_ts - a.ts > a.cooldown then
				for pixie_count, pixie in pairs(this.pixies) do
					local target, attack

					if pixie.target or store.tick_ts - pixie.attack_ts <= a.pixie_cooldown then
						-- block empty
					else
						attack = a.list[1]

						if not attack then
							-- block empty
						else
							target = U.find_foremost_enemy(store.entities, this.pos, 0, a.range,false, attack.vis_flags, attack.vis_bans, function(e)
								return not table.contains(a.excluded_templates, e.template_name) and (not enemy_cooldowns[e.id] or enemy_cooldowns[e.id] < store.tick_ts)
							end)

							if not target then
								-- block empty
							else
								if pixie_count == 1 then
									this.anim_play_out = true
								end
								enemy_cooldowns[target.id] = store.tick_ts + a.enemy_cooldown
								pixie.attack_ts = store.tick_ts
								pixie.target_id = target.id
								pixie.attack = attack
								pixie.attack_level = pixie_count
								a.ts = store.tick_ts

								break
							end
						end
					end
				end
			end
			if this.anim_play_in == true then 
				U.y_animation_play(this, "in", nil, store.tick_ts, false, 3)
				U.y_animation_play(this, "in", nil, store.tick_ts, false, 4)
				this.anim_play_in = false
			end

			if this.anim_play_out == true then 
				U.y_animation_play(this, "out", nil, store.tick_ts, false, 3)
				U.y_animation_play(this, "out", nil, store.tick_ts, false, 4)
				this.anim_play_out = false
			end
		end

		coroutine.yield()
	end
end

scripts.decal_shaolin = {}

function scripts.decal_shaolin.update(this, store)
	local iflip = this.idle_flip
	local o, slot_pos, slot_flip, enemy_flip
	local punchInName = {"punchIn", "kickIn"}
	local punchOutName = {"punchOut", "kickOut"}
	--U.y_animation_play(this, "punchIn", slot_flip, store.tick_ts)
	this.is_stun = false
	this.target_stun = nil

	while true do
		if this.target_id ~= nil then
			local target = store.entities[this.target_id]

			if not target or target.health.dead then
				-- block empty
			else

				if band(target.vis.bans, F_STUN) == 0 and band(target.vis.flags, F_BOSS) == 0 and (not target.enemy.blockers or #target.enemy.blockers == 0) then
					SU.stun_inc(target)
					this.is_stun = true
					this.target_stun = target
				end

				this.render.sprites[1].hidden = false
				local is_air = band(target.vis.flags, F_FLYING) ~= 0
				local random_action = 1
				if is_air then
					this.pos.x, this.pos.y = target.pos.x + target.unit.hit_offset.x, target.pos.y
					this.tween.disabled = false
					this.tween.props[1].disabled = false
					this.tween.props[1].ts = store.tick_ts
					this.tween.props[1].keys[2][2].y = math.max(target.unit.hit_offset.y - 20, 5)
					U.animation_start(this, "dragonPunchUp", nil, store.tick_ts)
				else
					slot_pos, slot_flip, enemy_flip = U.melee_slot_position(this, target, 1)
					this.pos.x, this.pos.y = slot_pos.x, slot_pos.y
					random_action = math.random(1, 2)
					U.animation_start(this, punchInName[random_action], slot_flip, store.tick_ts)
				end
				U.y_wait(store, fts(6))

				if target and not target.health.dead then
					local bullet = E:get_template(this.attack.bullet).bullet
					local fx = E:create_entity(bullet.hit_fx)
					if is_air then
						fx.pos.x = target.pos.x + target.unit.hit_offset.x
						fx.pos.y = target.pos.y + target.unit.hit_offset.y
					else
						fx.render.sprites[1].hidden = true
					end
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					local d = SU.create_bullet_damage(bullet, target.id, this.id)
					queue_damage(store, d)
				end

				if is_air then
					U.animation_start(this, "dragonPunchDown", nil, store.tick_ts)
					U.y_wait(store, fts(5))
					this.tween.disabled = true
					this.tween.props[1].disabled = true
					U.y_animation_play(this, "dragonPunchOut", nil, store.tick_ts)
				else
					U.y_animation_wait(this)
					U.y_animation_play(this, punchOutName[random_action], slot_flip, store.tick_ts)
				end

				if this.is_stun then
					SU.stun_dec(target)
					this.is_stun = false
					this.target_stun = nil
				end

				if this.attack_level == 1 then
					this.owner.anim_play_in = true
				end
				
				this.render.sprites[1].hidden = true

				o = this.idle_pos
				this.pos.x, this.pos.y = this.owner.pos.x + o.x, this.owner.pos.y + o.y

				--U.y_animation_play(this, "punchIn", slot_flip, store.tick_ts)
			end

			this.target_id = nil
		elseif store.tick_ts - iflip.ts > iflip.cooldown then
			U.animation_start(this, table.random(iflip.animations), math.random() < 0.5, store.tick_ts, iflip.loop)

			iflip.ts = store.tick_ts
		end

		coroutine.yield()
	end
end

scripts.mod_gold = {}

function scripts.mod_gold.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if not target or target.health.dead or not target.motion or target.motion.invulnerable or not target.enemy then
		return false
	end

	if this.modifier.excluded_templates and table.contains(this.modifier.excluded_templates, target.template_name) then
		log.paranoid("mod_slow.insert not inserted to %s because of excluded_templates", target.id)

		return false
	end

	log.paranoid("mod_slow.insert (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)

	--target.motion.max_speed = target.motion.max_speed * this.slow.factor
	if not target._gold_factor then
		target._gold_factor = 1
		if target.enemy.gold then
			target._gold_origin = target.enemy.gold
		else
			target._gold_origin = 20
		end
	end
	target._gold_factor = target._gold_factor * this.slow.factor
	local old_gold = target.enemy.gold or 0
	target.enemy.gold = math.floor(target._gold_origin * target._gold_factor)
	earnings_stats.adjust_enemy_bonus(target, "tower_shaolin", target.enemy.gold - old_gold)
	this.modifier.ts = store.tick_ts

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_gold.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]

	if target and target.health and target.motion and target.enemy then
		--target.motion.max_speed = target.motion.max_speed / this.slow.factor
		target._gold_factor = target._gold_factor / this.slow.factor
		local old_gold = target.enemy.gold or 0
		target.enemy.gold = math.floor(target._gold_origin * target._gold_factor)
		earnings_stats.adjust_enemy_bonus(target, "tower_shaolin", target.enemy.gold - old_gold)

		log.paranoid("mod_slow.remove (%s)-%s for (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.debug("mod_slow.remove target is nil for id %s", this.modifier.target_id)
	end

	return true
end

scripts.aura_tower_shaolin_gold = {}

function scripts.aura_tower_shaolin_gold.insert(this, store, script)
	this.aura.ts = store.tick_ts
	if this.render then
		for _, s in pairs(this.render.sprites) do
			s.ts = store.tick_ts
		end
	end

	if this.aura.source_id then
		local target = store.entities[this.aura.source_id]

		if target and this.render and this.aura.use_mod_offset and target.unit and target.unit.mod_offset then
			this.render.sprites[1].offset.x, this.render.sprites[1].offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
		end
	end

	this.actual_duration = this.aura.duration

	if this.aura.duration_inc then
		this.actual_duration = this.actual_duration + this.aura.level * this.aura.duration_inc
	end

	return true
end

function scripts.aura_tower_shaolin_gold.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local cycles_count = 0
	local victims_count = 0

	for _, ps_n in pairs(this.ps_names) do
		local ps = E:create_entity(ps_n)

		ps.particle_system.emit_area_spread = V.vv(this.aura.radius)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	if this.aura.track_source and this.aura.source_id then
		local te = store.entities[this.aura.source_id]

		if te and te.pos then
			this.pos = te.pos
		end
	end

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	if this.aura.apply_delay then
		last_hit_ts = last_hit_ts + this.aura.apply_delay
	end

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		if this.aura.cycles and cycles_count >= this.aura.cycles or this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.actual_duration then
			break
		end

		if this.aura.stop_on_max_count and this.aura.max_count and victims_count >= this.aura.max_count then
			break
		end

		if this.aura.track_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if not te or te.health and te.health.dead and not this.aura.track_dead then
				break
			end
		end

		if this.aura.requires_magic then
			local te = store.entities[this.aura.source_id]

			if not te or not te.enemy then
				goto label_1060_0
			end

			if this.render then
				this.render.sprites[1].hidden = not te.enemy.can_do_magic
			end

			if not te.enemy.can_do_magic then
				goto label_1060_0
			end
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_1060_0
			end
		end

		if this.aura.requires_alive_source and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.health and te.health.dead then
				goto label_1060_0
			end
		end

		if not (store.tick_ts - last_hit_ts >= this.aura.cycle_time) or this.aura.apply_duration and first_hit_ts and store.tick_ts - first_hit_ts > this.aura.apply_duration then
			-- block empty
		else
			if this.render and this.aura.cast_resets_sprite_id then
				this.render.sprites[this.aura.cast_resets_sprite_id].ts = store.tick_ts
			end

			first_hit_ts = first_hit_ts or store.tick_ts
			last_hit_ts = store.tick_ts
			cycles_count = cycles_count + 1

			local targets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
			end)

			for i, target in ipairs(targets) do
				if this.aura.targets_per_cycle and i > this.aura.targets_per_cycle then
					break
				end

				if this.aura.max_count and victims_count >= this.aura.max_count then
					break
				end

				local mods = this.aura.mods or {
					this.aura.mod
				}

				for _, mod_name in pairs(mods) do
					local new_mod = E:create_entity(mod_name)

					new_mod.modifier.level = this.aura.level
					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						new_mod.render = nil
					end

					queue_insert(store, new_mod)

					victims_count = victims_count + 1
				end
			end
		end

		::label_1060_0::

		coroutine.yield()
	end

	signal.emit("aura-apply-mod-victims", this, victims_count)
	queue_remove(store, this)
end


--冰龙
scripts.hero_eiskalt = {}
--[[
function scripts.hero_eiskalt.get_info(this)
	local m = E:get_template("fireball_eiskalt")
	local min, max = m.bullet.damage_min, m.bullet.damage_max

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		damage_type = DAMAGE_MAGICAL,
		armor = this.health.armor,
		respawn = this.health.dead_lifetime
	}
end
]]--
function scripts.hero_eiskalt.get_info(this)
	local t = scripts.hero_basic.get_info_ranged(this)
	local m = E:get_template(this.ranged.attacks[1].bullet)
    	t.ranged_damage_max = m.bullet.damage_max * this.unit.damage_factor
		t.ranged_damage_min = m.bullet.damage_min * this.unit.damage_factor
		t.ranged_damage_type = m.bullet.damage_type
	return t
end

function scripts.hero_eiskalt.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local b = E:get_template("fireball_eiskalt")

	b.bullet.damage_max = ls.ranged_damage_max[hl]
	b.bullet.damage_min = ls.ranged_damage_min[hl]

	--确定科技等级和数值
	--local m = E:get_template("mod_dracolich_disease")

	--m.dps.damage_min = ls.disease_damage[hl]
	--m.dps.damage_max = ls.disease_damage[hl]

	local s

	--普攻爆炸
	s = this.hero.skills.explosion
	if initial and s.level >= 0 then
		b = E:get_template("fireball_eiskalt")
		b.bullet.damage_radius = s.damage_radius[s.level]
	end


	--冻土
	s = this.hero.skills.coldfury
	if initial and s.level > 0 then
		this.timed_attacks.list[3].disabled = nil
		this.timed_attacks.list[3].cooldown = s.cooldown_time[s.level]
	end

	--雪球
	s = this.hero.skills.frosty
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[1]
		a.disabled = nil
		a.damage_min = s.damage_min[s.level]
		a.damage_max = s.damage_max[s.level]
	end

	--冰刺
	s = this.hero.skills.icepeak
	if initial and s.level > 0 then
		local a = this.timed_attacks.list[2]
		a.disabled = nil
		b = E:get_template("eiskalt_icepeaks")
		b.damage_min = s.damage_min[s.level]
		b.damage_max = s.damage_max[s.level]
	end

	--冰龙大招
	s = this.hero.skills.ultimate
	if initial and s.level >= 0 then
		local u = E:get_template("hero_eiskalt_ultimate")
		u.duration = s.duration[s.level]
	end



	this.health.hp = this.health.hp_max
end

function scripts.hero_eiskalt.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.ranged.order = U.attack_order(this.ranged.attacks)

	return true
end

function scripts.hero_eiskalt.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, force_idle_ts


	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	force_idle_ts = true

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			force_idle_ts = true
		end

		while this.nav_rally.new do
			SU.y_hero_new_rally(store, this)
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end


		--4技能：冰刺（原脊骨雨），召唤物从骨头换成冰刺且固定8根
		a = this.timed_attacks.list[2]
		skill = this.hero.skills.icepeak
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.4)
			else
				local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, {
					pi
				}, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, a, 0.4)
				else
					local s_pi, s_spi, s_ni = unpack(nodes[1])
					local flip = target.pos.x < this.pos.x

					U.animation_start(this, "icePeaks", flip, store.tick_ts)
					--skeleton_glow_fx()
					U.y_wait(store, a.spawn_time)

					local delay = 0
					--local n_step = ni < s_ni and -2 or 2
					local n_step = ni < s_ni and -4 or 4

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

					for i = 1, skill.count[skill.level] do
						local e = E:create_entity(a.entity)

						e.pos = P:node_pos(pi, spi, ni)
						e.render.sprites[1].prefix = e.render.sprites[1].prefix
						e.render.sprites[1].flip_x = math.random() > 0.5
						e.delay = delay
						e.bullet.source_id = this.id
						e.bullet.level = this.hero.skills.icepeak.level

						queue_insert(store, e)

						delay = delay + fts(U.frandom(2, 3))
						ni = ni + n_step
						spi = km.zmod(spi + math.random(1, 2), 3)
					end

					U.y_animation_wait(this)

					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)

					goto label_386_1
				end
			end
		end

		--2技能：永恒冻土（原撞击地面）
		--抄了1代冰女的代码
		a = this.timed_attacks.list[3]
		skill = this.hero.skills.coldfury
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

			if not target then
				SU.delay_attack(store, a, 0.13333333333333333)
			else
				local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, {	pi}, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, a, 0.4)
				else
					local s_pi, s_spi, s_ni = unpack(nodes[1])
					local flip = target.pos.x < this.pos.x
					local start_ts = store.tick_ts

					U.animation_start(this, "coldFury", flip, store.tick_ts)
					S:queue(a.sound)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_61_0
					end

					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					local delay = 0
					local n_step = ni < s_ni and -a.step or a.step

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + a.nodes_offset or ni)

					for i = 1, 8 do
						local b = E:create_entity(a.bullet)

						b.pos = P:node_pos(pi, spi, ni)
						b.render.sprites[1].prefix = b.render.sprites[1].prefix
						b.render.sprites[1].flip_x = not flip
						b.delay = delay

						queue_insert(store, b)

                        local fx = E:create_entity(b.aura.hit_decal)
                        fx.pos = V.vclone(b.pos)
                        fx.delay = delay
                        queue_insert(store, fx)

						delay = delay + 0.05
						ni = ni + n_step
						spi = km.zmod(spi + 1, 3)
					end

					SU.y_hero_animation_wait(this)

					goto label_61_0
				end
			end
		end

		::label_61_0::

		--3技能：大雪球（原瘟疫载体）
		a = this.timed_attacks.list[1]
		skill = this.hero.skills.frosty
		if not a.disabled and store.tick_ts - a.ts > a.cooldown then
			local targets_info = U.find_enemies_in_paths(store.entities, this.pos, a.range_nodes_min, a.range_nodes_max, nil, a.vis_flags, a.vis_bans)

			if not targets_info then
				SU.delay_attack(store, a, 0.4)
			else
				local target

				for _, ti in pairs(targets_info) do
					if GR:cell_is(ti.enemy.pos.x, ti.enemy.pos.y, TERRAIN_LAND) then
						target = ti.enemy

						break
					end
				end

				if not target then
					SU.delay_attack(store, a, 0.4)
				else
					local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
					local nodes = P:nearest_nodes(this.pos.x, this.pos.y, {
						pi
					}, nil, nil, NF_RALLY)

					if #nodes < 1 then
						SU.delay_attack(store, a, 0.4)
					else
						local s_pi, s_spi, s_ni = unpack(nodes[1])
						local dir = ni < s_ni and -1 or 1
						local offset = math.random(a.range_nodes_min, a.range_nodes_min + 5)

						s_ni = km.clamp(1, #P:path(s_pi), s_ni + (dir > 0 and offset or -offset))

                        local target_node = P:node_pos(s_pi, s_spi, s_ni, true)
						local flip = target_node.x < this.pos.x

						S:queue(a.sound)
						U.animation_start(this, "frosty", flip, store.tick_ts)
						U.y_wait(store, a.spawn_time)

                        local e = E:create_entity(a.entity)

                        e.bullet.from = v(this.pos.x + (flip and -1 or 1) * a.spawn_offset.x, this.pos.y + a.spawn_offset.y)
                        e.bullet.to = v(target_node.x, target_node.y)
                        e.bullet.level = this.hero.skills.frosty.level
                        --e.pos.x, e.pos.y = this.pos.x + (flip and -1 or 1) * a.spawn_offset.x, this.pos.y + a.spawn_offset.y
                        --e.nav_path.pi = s_pi
                        --e.nav_path.spi = math.random(1, 3)
                        --e.nav_path.ni = s_ni
                        --e.nav_path.dir = dir
                        --e.aura.source_id = this.id
                        --e.aura.level = this.hero.skills.frosty.level

                        queue_insert(store, e)

						U.y_animation_wait(this)

						force_idle_ts = true
						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)

						goto label_386_1
					end
				end
			end
		end

		--普攻，可直接沿用骨龙的
		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			elseif store.tick_ts - a.ts < a.cooldown then
				-- block empty
			elseif math.random() > a.chance then
				-- block empty
			else
				local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
				local bullet_t = E:get_template(a.bullet)
				local bullet_speed = bullet_t.bullet.min_speed
				local flight_time = bullet_t.bullet.flight_time
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans, function(v)
					local v_pos = v.pos

					if not v.nav_path then
						return false
					end

					local n_pos = P:node_pos(v.nav_path)

					if V.dist(n_pos.x, n_pos.y, v_pos.x, v_pos.y) > 5 then
						return false
					end

					if a.nodes_limit and (P:get_start_node(v.nav_path.pi) + a.nodes_limit > v.nav_path.ni or P:get_end_node(v.nav_path.pi) - a.nodes_limit < v.nav_path.ni) then
						return false
					end

					if v.motion and v.motion.speed then
						local node_offset

						if flight_time then
							node_offset = P:predict_enemy_node_advance(v, flight_time + a.shoot_time)
						else
							local dist = V.dist(origin.x, origin.y, v.pos.x, v.pos.y)

							node_offset = P:predict_enemy_node_advance(v, dist / bullet_speed)
						end

						v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
					end

					local dist_x = math.abs(v_pos.x - this.pos.x)
					local dist_y = math.abs(v_pos.y - this.pos.y)

					return dist_x > 45
				end)

				if target then
					local start_ts = store.tick_ts
					local b, emit_fx, emit_ps, emit_ts
					local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
					local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
					local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
					local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

					U.animation_start(this, an, af, store.tick_ts)

					while store.tick_ts - start_ts < a.shoot_time do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_386_0
						end

						coroutine.yield()
					end

					S:queue(a.sound)

					b = E:create_entity(a.bullet)
					b.bullet.target_id = target.id
					b.bullet.source_id = this.id
					b.pos = V.vclone(this.pos)
					b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
					b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
					b.bullet.from = V.vclone(b.pos)
					b.bullet.to = V.v(t_pos.x, t_pos.y)
					--print("damage radius"..b.bullet.damage_radius)
					--b.bullet.damage_radius = 20 + 20 * this.hero.skills.explosion.level

					queue_insert(store, b)

					a.ts = start_ts

					while not U.animation_finished(this) do
						if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
							goto label_386_0
						end

						coroutine.yield()
					end

					force_idle_ts = true

					::label_386_0::

					goto label_386_1
				end
			end
		end

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)

		force_idle_ts = nil

		::label_386_1::

		coroutine.yield()
	end
end

--冰冻烟雾
scripts.eiskalt_cold_fury_smoke = {}
function scripts.eiskalt_cold_fury_smoke.update(this, store)
    U.sprites_hide(this)
    if this.delay then
        U.y_wait(store, this.delay)
    end
    for _, s in pairs(this.render.sprites) do
        s.ts = store.tick_ts
    end
    U.sprites_show(this)
    this.tween.disabled = false
    this.tween.ts = store.tick_ts
end

--冰刺
scripts.eiskalt_icepeaks = {}

function scripts.eiskalt_icepeaks.update(this, store)
	local b = this.bullet

	U.sprites_hide(this)

	if this.delay then
		U.y_wait(store, this.delay)
	end

	U.sprites_show(this)

	local start_ts = store.tick_ts

	this.pos.x = this.pos.x + math.random(-4, 4)
	this.pos.y = this.pos.y + math.random(-5, 5)

	S:queue(this.sound_events.delayed_insert)
	U.animation_start(this, "in", nil, store.tick_ts, false)

	this.tween.ts = store.tick_ts

	U.y_wait(store, b.hit_time)

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, b.damage_radius, b.damage_flags, b.damage_bans)

	if targets then
		for _, target in pairs(targets) do
			local d = E:create_damage()

			d.damage_type = b.damage_type
			d.source_id = this.id
			d.target_id = target.id
			d.value = 0 
			if band(target.vis.flags, F_BOSS) == 0 then
				d.value = target.health.hp_max * 0.1 * b.level--百分比伤害
			end
			queue_damage(store, d)

			if b.mod then
				local m = E:create_entity(b.mod)

				m.modifier.source_id = this.id
				m.modifier.target_id = target.id
				m.modifier.xp_dest_id = b.source_id

				queue_insert(store, m)
			end
		end
	end

	U.y_wait(store, b.duration - (store.tick_ts - start_ts))
	U.y_animation_play(this, "out", nil, store.tick_ts, false)
	queue_remove(store, this)
end

--冰球
scripts.hero_eiskalt_frosty = {}

function scripts.hero_eiskalt_frosty.insert(this, store)
	next_pos = P:node_pos(this.nav_path)

	if not next_pos then
		return false
	end

	return true
end

function scripts.hero_eiskalt_frosty.update(this, store)
	local y_off = 20
	local a = this.aura
	local m = this.motion
	local nav = this.nav_path
	local dt = store.tick_length
	local start_ni = nav.ni
	local start_ts = store.tick_ts
	local hit_ts = 0

	a.duration = a.duration + U.frandom(-a.duration_var, 0)
	m.max_speed = m.max_speed + math.random(0, m.max_speed_var)

	local step = m.max_speed * dt
	local next_pos = P:node_pos(nav)

	next_pos.y = next_pos.y + y_off

	U.set_destination(this, next_pos)

	local v_heading = V.v(0, 0)

	v_heading.x, v_heading.y = V.normalize(next_pos.x - this.pos.x, next_pos.y - this.pos.y)

	local th_dist = 25
	local turn_speed = math.pi * 1.5
	local enemies_hit = {}

	if this.delay then
		this.render.sprites[1].hidden = true

		U.y_wait(store, this.delay)

		this.render.sprites[1].hidden = nil
	end

	--local ps = E:create_entity("ps_dracolich_plague")

	--ps.particle_system.track_id = this.id

	--queue_insert(store, ps)

	while true do
		if this.tween.disabled and store.tick_ts - start_ts > a.duration then
			this.tween.disabled = nil
			this.tween.ts = store.tick_ts
			--ps.particle_system.emit = false
		end

		if th_dist > V.len(m.dest.x - this.pos.x, m.dest.y - this.pos.y) then
			nav.ni = nav.ni + math.random(6, 11) * nav.dir

			local p_len = #P:path(nav.pi)

			if nav.ni <= 1 or p_len <= nav.ni then
				a.duration = 0
			end

			nav.ni = km.clamp(1, p_len, nav.ni)
			nav.spi = km.zmod(nav.spi + math.random(1, 2), 3)
			next_pos = P:node_pos(nav)
			next_pos.y = next_pos.y + y_off

			U.set_destination(this, next_pos)
		end

		local dx, dy = V.sub(m.dest.x, m.dest.y, this.pos.x, this.pos.y)
		local sa = km.short_angle(V.angleTo(dx, dy), V.angleTo(v_heading.x, v_heading.y))
		local angle_step = math.min(turn_speed * dt, math.abs(sa)) * km.sign(sa) * -1

		v_heading.x, v_heading.y = V.rotate(angle_step, v_heading.x, v_heading.y)

		local sx, sy = V.mul(step, v_heading.x, v_heading.y)

		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, sx, sy)
		m.speed.x, m.speed.y = sx / dt, sy / dt
		this.render.sprites[1].r = V.angleTo(v_heading.x, v_heading.y)

		if store.tick_ts - hit_ts > a.damage_cycle then
			hit_ts = store.tick_ts

			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius, a.damage_flags, a.damage_bans, function(v)
				return not table.contains(enemies_hit, v)
			end)

			if not targets then
				-- block empty
			else
				for _, e in pairs(targets) do
					local d = E:create_damage()

					d.source_id = this.id
					d.target_id = e.id
					d.value = math.random(a.damage_min, a.damage_max)
					d.damage_type = a.damage_type

					queue_damage(store, d)

					if a.mod then
						local m = E:create_entity(a.mod)

						m.modifier.source_id = this.id
						m.modifier.target_id = e.id
						m.modifier.xp_dest_id = a.source_id

						queue_insert(store, m)
					end

					table.insert(enemies_hit, e)
				end
			end
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

--冰球 5代死灵版

scripts.aura_eiskalt_skill_rider = {}

function scripts.aura_eiskalt_skill_rider.update(this, store, script)
	local first_hit_ts
	local last_hit_ts = 0
	local sid_rider = 1
	local sid_fx = 2
	local target_pos = this.pos
	local fading = false
	local spawned_fx = false
	local path_ni = 1
	local path_spi = 1
	local path_pi = 1
	local available_paths = {}

	for k, v in pairs(P.paths) do
		table.insert(available_paths, k)
	end

	if store.level.ignore_walk_backwards_paths then
		available_paths = table.filter(available_paths, function(k, v)
			return not table.contains(store.level.ignore_walk_backwards_paths, v)
		end)
	end

	local nearest = P:nearest_nodes(this.pos.x, this.pos.y, available_paths)

	if #nearest > 0 then
		path_pi, path_spi, path_ni = unpack(nearest[1])

		for _, n in pairs(nearest) do
			local _path_pi, _path_spi, _path_ni = unpack(n)

			if _path_pi == this.path_id then
				path_pi, path_spi, path_ni = _path_pi, _path_spi, _path_ni

				break
			end
		end
	end

	path_spi = 1
	path_ni = path_ni - 3

	local distance = 0

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	if this.aura.apply_delay then
		last_hit_ts = last_hit_ts + this.aura.apply_delay
	end

	local function hit_enemies()
		local targets = table.filter(store.entities, function(k, v)
			return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
		end)

		for i, target in ipairs(targets) do
			local already_hit_target = false
			local has_mod, mods = U.has_modifiers(store, target, this.aura.mod)

			if has_mod then
				for _, mod in pairs(mods) do
					if mod.modifier.source_id == this.id then
						already_hit_target = true

						break
					end
				end
			end

			if already_hit_target then
				-- block empty
			else
				this.damage_max = this.damage_max_config[this.aura.level]
				this.damage_min = this.damage_min_config[this.aura.level]

				if target and not target.health.dead and target.enemy then
					queue_damage(store, SU.create_attack_damage(this, target.id, this.id))

					local hit_fx = E:create_entity(this.hit_fx)

					hit_fx.pos = V.vclone(target.pos)
					hit_fx.pos.x, hit_fx.pos.y = hit_fx.pos.x + target.unit.hit_offset.x, hit_fx.pos.y + target.unit.hit_offset.y
					hit_fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, hit_fx)

					local new_mod = E:create_entity(this.aura.mod)

					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						new_mod.render = nil
					end

					queue_insert(store, new_mod)
				end
			end
		end
	end

	path_ni = path_ni - 3
	target_pos = P:node_pos(path_pi, path_spi, path_ni)

	local flip_x = target_pos.x < this.pos.x

	U.animation_start(this, "spawn", flip_x, store.tick_ts, 1, sid_rider)
	--U.y_wait(store, fts(21))
	hit_enemies()
	--U.y_wait(store, fts(10))

	this.tween.props[1].disabled = true
	this.tween.props[1].ts = store.tick_ts

	local psA = E:create_entity(this.particles_name_A)

	psA.particle_system.track_id = this.id
	psA.particle_system.emit = true

	queue_insert(store, psA)

	local psB = E:create_entity(this.particles_name_B)

	psB.particle_system.track_id = this.id
	psB.particle_system.emit = true

	queue_insert(store, psB)

	local function rider_go_back_step()
		if V.veq(this.pos, target_pos) then
			this.motion.arrived = true

			return false
		else
			U.set_destination(this, target_pos)

			if U.walk(this, store.tick_length) then
				return false
			else
				local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)

				U.animation_start(this, an, af, store.tick_ts, -1, sid_rider)

				return true
			end
		end
	end

	local function run_backwards()
		local last_pos = this.pos

		distance = V.dist2(target_pos.x, target_pos.y, this.pos.x, this.pos.y)

		if distance < 25 then
			path_ni = path_ni - 3
			target_pos = P:node_pos(path_pi, path_spi, path_ni)
		end

		rider_go_back_step()

		--[[
		if not spawned_fx then
			local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
			local hit_fx

			if an == "walk_side" then
				hit_fx = E:create_entity(this.spawn_side_fx)
			elseif an == "walk_front" then
				hit_fx = E:create_entity(this.spawn_front_fx)
			else
				hit_fx = E:create_entity(this.spawn_back_fx)
			end

			hit_fx.pos = V.vclone(this.pos)
			hit_fx.render.sprites[1].ts = store.tick_ts
			hit_fx.render.sprites[1].flip_x = af

			queue_insert(store, hit_fx)

			spawned_fx = true
		end
		]]--

		local r = V.angleTo(target_pos.x - last_pos.x, target_pos.y - last_pos.y)

		psA.particle_system.emit_offset.x, psA.particle_system.emit_offset.y = V.rotate(r, psA.emit_offset_relative.x, psA.emit_offset_relative.y)
		psB.particle_system.emit_offset.x, psB.particle_system.emit_offset.y = V.rotate(r, psB.emit_offset_relative.x, psB.emit_offset_relative.y)
	end

	local function check_start_fade()
		if fading then
			return false
		end

		local fade_duration = this.tween.props[1].keys[2][1]

		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts + fade_duration > this.actual_duration then
			return true
		end

		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, available_paths)

		if #nearest > 0 then
			path_pi, path_spi, path_ni = unpack(nearest[1])

			return path_ni < 10
		end

		return false
	end

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		this.render.sprites[1].offset.y = 0
		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.actual_duration or fading and this.render.sprites[1].alpha <= 0 then
			break
		end

		if check_start_fade() then
			fading = true
			this.tween.props[1].disabled = false
			this.tween.reverse = true
			this.tween.props[1].ts = store.tick_ts
		end

		if this.aura.source_vis_flags and this.aura.source_id then
			local te = store.entities[this.aura.source_id]

			if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
				goto label_651_0
			end
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			if this.aura.apply_duration and first_hit_ts and store.tick_ts - first_hit_ts > this.aura.apply_duration then
				goto label_651_0
			end

			first_hit_ts = first_hit_ts or store.tick_ts
			last_hit_ts = store.tick_ts

			hit_enemies()
		end

		run_backwards()

		::label_651_0::

		coroutine.yield()
	end

	queue_remove(store, this)
end

--普攻
scripts.fireball_eiskalt = {}

function scripts.fireball_eiskalt.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local tl = store.tick_length
	local ps
	local targeted_hit_offset = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	local target = store.entities[b.target_id]

	if target then
		local dist = V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)
		local node_offset = P:predict_enemy_node_advance(target, dist / mspeed)

		b.to = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)

		if band(target.vis.flags, F_FLYING) ~= 0 and target.unit and target.unit.hit_offset then
			targeted_hit_offset = true
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * tl do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * tl, this.pos.y + b.speed.y * tl
		this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

		coroutine.yield()
	end

	local hit_center = V.vclone(b.to)

	if target and target.unit and target.unit.hit_offset and targeted_hit_offset then
		hit_center.y = hit_center.y - target.unit.hit_offset.y
	end

	local targets = U.find_enemies_in_range(store.entities, hit_center, 0, b.damage_radius, b.vis_flags, b.vis_bans)

	if targets then
		for _, e in pairs(targets) do
			local d = SU.create_bullet_damage(b, e.id, this.id)

			d.xp_dest_id = b.source_id

			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = e.id
				mod.modifier.source_id = b.source_id
				mod.xp_dest_id = b.source_id

				queue_insert(store, mod)
			end
		end
	end

	S:queue(this.sound_events.hit)

	local fx, air_hit

	if b.hit_fx_air and target and target.vis and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = E:create_entity(b.hit_fx_air)
		air_hit = true
	elseif b.hit_fx then
		fx = E:create_entity(b.hit_fx)
	end

	if fx then
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, fx)
	end

	if b.hit_decal and not air_hit then
		fx = E:create_entity(b.hit_decal)
		fx.pos.x, fx.pos.y = b.to.x, b.to.y
		fx.render.sprites[1].ts = 0

		queue_insert(store, fx)
	end

	queue_remove(store, this)
end

--冰龙大招
scripts.hero_eiskalt_ultimate = {}
function scripts.hero_eiskalt_ultimate.can_fire_fn(this, x, y, store)
	return not GR:cell_is(x, y, TERRAIN_FAERIE) and P:valid_node_nearby(x, y, 1.4285714285714286, NF_POWER_3)
end

function scripts.hero_eiskalt_ultimate.insert(this, store, script)
	for _, e in pairs(store.entities) do
		if e.template_name == this.template_name then
			log.debug("atomic_freeze already exists, force silent removal")
			queue_remove(store, e)

			this.skip_ice_slabs = true
		end
	end

	return true
end

function scripts.hero_eiskalt_ultimate.update(this, store, script)
	--signal.emit("atomic-freeze-starts")

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, 9999, this.vis_flags, this.vis_bans, function(e)
		return not table.contains(this.excluded_templates, e.template_name)
	end)

	local mod 
	if targets then
		for _, target in pairs(targets) do

			if band(target.vis.flags, F_BOSS) == 0 and band(target.vis.bans, F_FREEZE) == 0 then
				mod = E:create_entity(this.mod)
				mod.modifier.target_id = target.id
				mod.modifier.duration = this.duration

				queue_insert(store, mod)
			end

			
		end
	end

	if this.skip_ice_slabs then
		for _, e in pairs(store.entities) do
			if e.template_name == "decal_user_item_atomic_freeze_slab" then
				e.render.sprites[1].ts = store.tick_ts
			end
		end
	else
		for i = 1, 10 do
			local rpos = P:get_random_position(20, bor(TERRAIN_LAND, TERRAIN_WATER))

			if not rpos then
				log.debug("user_item_atomic_freeze: could not find random position for slab decal. i:%s", i)
			else
				local e = E:create_entity("decal_user_item_atomic_freeze_slab")

				e.duration = this.duration
				e.pos = rpos
				e.render.sprites[1].ts = store.tick_ts
				e.render.sprites[1].name = string.format(e.render.sprites[1].name, math.random(1, e.decals_count))
				e.render.sprites[1].scale = V.v(U.random_sign(), 1)

				queue_insert(store, e)
			end
		end
	end

	--[[
    if mod then
        local overlay_tween_time = 0.5
        local overlay = E:create_entity("overlay_eiskalt_freeze")
        overlay.pos.x, overlay.pos.y = REF_W / 2, REF_H / 2
        overlay.tween.props[1].keys = {
            { 0, 0 },
            { overlay_tween_time, this.freeze_alpha_min }
        }
        overlay.tween.props[1].ts = store.tick_ts
        queue_insert(store, overlay)

        local begin_ts = store.tick_ts
        while begin_ts + mod.modifier.duration > store.tick_ts do
            if not overlay.tween.props[1].loop and store.tick_ts - begin_ts > overlay_tween_time then
                overlay.tween.props[1].loop = true
                overlay.tween.props[1].keys = {
                    { 0, this.freeze_alpha_min },
                    { 0.8, this.freeze_alpha_max },
                    { 1.6, this.freeze_alpha_min }
                }
                overlay.tween.props[1].ts = store.tick_ts
            end

            this.rain.ts = store.tick_ts
            local rain = this.rain
            rain.ts = store.tick_ts

            local angle = U.frandom(rain.angle_min, rain.angle_max)

            for i = 1, rain.count do
                angle = angle + U.frandom(-rain.angle_between, rain.angle_between)

                local dist = math.random(rain.distance_min, rain.distance_max)
                local ox, oy = V.rotate(angle, dist, 0)
                local delay = U.frandom(0.001, rain.delay_max)
                local pos = V.v(math.random(-REF_OX, REF_W + REF_OX), math.random(0, REF_H))
                local e = E:create_entity("fx_power_eiskalt_drop")

                e.pos.x, e.pos.y = pos.x, pos.y
                e.render.sprites[1].offset = V.v(-ox, -oy)
                e.render.sprites[1].r = angle
                e.render.sprites[1].alpha = math.random(rain.alpha_min, rain.alpha_max)
                e.tween.props[1].keys = {
                    { 0, 0 },
                    { 0.001, 255 }
                }
                e.tween.props[2] = E:clone_c("tween_prop")
                e.tween.props[2].keys = {
                    { 0, V.v(-ox, -oy) },
                    { 0.001, V.v(-ox, -oy) },
                    { rain.duration, V.v(0, 0) }
                }
                e.tween.props[2].name = "offset"
                e.tween.ts = store.tick_ts + delay

                queue_insert(store, e)
            end
            coroutine.yield()
        end

        overlay.tween.props[1].keys = {
            { 0, overlay.render.sprites[1].alpha },
            { overlay_tween_time, 0 }
        }
        overlay.tween.props[1].ts = store.tick_ts
        overlay.tween.props[1].loop = false
        overlay.tween.remove = false
	end
	]]
	U.y_wait(store, this.duration)

	--signal.emit("atomic-freeze-ends")
	queue_remove(store, this)
end

--沼巨
scripts.tower_swamp_monster = {}
--[[
function scripts.tower_swamp_monster.get_info(this)
	if not this.tower_upgrade_persistent_data.current_mode or this.tower_upgrade_persistent_data.current_mode == 0 then
		local s = E:create_entity(this.barrack.soldier_type)

		if this.powers then
			for pn, p in pairs(this.powers) do
				for i = 1, p.level do
					SU.soldier_power_upgrade(s, pn)
				end
			end
		end

		local s_info = s.info.fn(s)
		local attacks

		if s.melee and s.melee.attacks then
			attacks = s.melee.attacks
		elseif s.ranged and s.ranged.attacks then
			attacks = s.ranged.attacks
		end

		local min, max

		for _, a in pairs(attacks) do
			if a.damage_min then
				min, max = a.damage_min, a.damage_max

				break
			end
		end

		if min and max then
			min, max = math.ceil(min), math.ceil(max)
		end

		return {
			type = STATS_TYPE_TOWER_BARRACK,
			hp_max = s.health.hp_max,
			damage_min = min,
			damage_max = max,
			armor = s.health.armor,
			respawn = s.health.dead_lifetime
		}
	else
		local b = E:create_entity(this.attacks.list[1].bullet)
		return {
			damage_min = math.ceil(b.bullet.damage_min * this.tower.damage_factor),
			damage_max = math.ceil(b.bullet.damage_max * this.tower.damage_factor),
			range = this.attacks.range,
			type = STATS_TYPE_TOWER,
			cooldown = this.attacks.list[1].cooldown
		}
	end
end
]]--
function scripts.tower_swamp_monster.get_info(this)
	if not this.tower_upgrade_persistent_data.current_mode or this.tower_upgrade_persistent_data.current_mode == 0 then
	   local s = E:create_entity(this.barrack.soldier_type)

	   if this.powers then
	   	for pn, p in pairs(this.powers) do
	   		for i = 1, p.level do
	   			SU.soldier_power_upgrade(s, pn)
	   		end
	   	end
	   end

	   if s.unit and this.tower then
			s.unit.damage_factor = (s.unit.damage_factor or 1) * (this.tower.damage_factor or 1)
	   end
   
	   local s_info = s.info.fn(s)
       local attacks, damage_type
       local min, max
	   local yes_melee = true
       local no_ranged = true
	   local dodge_chance
	   local dodge = nil
   
       if s.melee and s.melee.attacks then
           attacks = s.melee.attacks
           for _, a in pairs(attacks) do
               if a.damage_min then
                   min, max = a.damage_min, a.damage_max
                   damage_type = a.damage_type
                   break
               end
           end
           if s.unit and min then
               min, max = min * s.unit.damage_factor, max * s.unit.damage_factor
           end
   
           if min and max then
               min, max = math.ceil(min), math.ceil(max)
           end
       end
   
       local ranged_min, ranged_max
       local ranged_damage_type
	   local ranged_damage_type
       if s.ranged and s.ranged.attacks then
	   	ranged_attacks = s.ranged.attacks
           for _, a in pairs(ranged_attacks) do
               if not a.disabled and a.bullet then
                   local b = E:get_template(a.bullet)
                   local level = a.level
                   if b and b.bullet.damage_min and b.bullet.damage_max then
                       if level and b.bullet.damage_inc then
                           ranged_min, ranged_max = b.bullet.damage_min + (b.bullet.damage_inc * level),
                               b.bullet.damage_max + (b.bullet.damage_inc * level)
                       else
                           ranged_min, ranged_max = b.bullet.damage_min,b.bullet.damage_max
                       end
                       ranged_damage_type = b.bullet.damage_type
                       break
                   end
               end
           end
   
           if s.unit and ranged_min then
               ranged_min, ranged_max = ranged_min * s.unit.damage_factor, ranged_max * s.unit.damage_factor
           end
   
           if ranged_min and ranged_max then
               ranged_min, ranged_max = math.ceil(ranged_min), math.ceil(ranged_max)
           end
       end
   
       if ranged_damage_type then
           no_ranged = false
       end
   
       local melee_count = 0
       if s.melee and s.melee.attacks then
           melee_count = #s.melee.attacks
       end
   
       if no_ranged and melee_count > 1 then
           while melee_count > 1 do
               local a = s.melee.attacks[melee_count]
               if a.damage_min and not a.disabled then
                   ranged_min, ranged_max = a.damage_min, a.damage_max
                   ranged_damage_type = a.damage_type
                   if s.unit then
                       ranged_min, ranged_max = ranged_min * s.unit.damage_factor, ranged_max * s.unit.damage_factor
                   end
                   ranged_min, ranged_max = math.ceil(ranged_min), math.ceil(ranged_max)
                   break
               end
               melee_count = melee_count - 1
           end
       end
   
	   if s.dodge then
	   	dodge = true
	   	dodge_chance = s.dodge.chance
	   end
   
	   local armor = band(s.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1 or s.health.armor
	   local magic_armor = band(s.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1 or s.health.magic_armor
   
       return {
           type = STATS_TYPE_TOWER_BARRACK,
           hp_max = s.health.hp_max,
   
           damage_min = min,
           damage_max = max,
           damage_type = damage_type,
	   	   damage_icon = s.info.damage_icon,
   
           ranged_damage_min = ranged_min,
           ranged_damage_max = ranged_max,
           ranged_damage_type = ranged_damage_type,
	   	   ranged_damage_icon = s.info.ranged_damage_icon,
   
           armor = armor,
           magic_armor = magic_armor,
	   	   dodge = dodge,
	   	   dodge_chance = dodge_chance,			
           respawn = s.health.dead_lifetime,
           no_ranged = no_ranged,
	   	yes_melee = yes_melee
       }
	else
		local b = E:create_entity(this.attacks.list[1].bullet)
		local dt = b.bullet.damage_type
		return {
			damage_min = math.ceil(b.bullet.damage_min * this.tower.damage_factor),
			damage_max = math.ceil(b.bullet.damage_max * this.tower.damage_factor),
			damage_type = dt,
			range = this.attacks.range,
			type = STATS_TYPE_TOWER,
			cooldown = this.attacks.list[1].cooldown
		}
	end
end

function scripts.tower_swamp_monster.insert(this, store, script)
	if not this.barrack.rally_pos and this.tower.default_rally_pos then
		this.barrack.rally_pos = V.vclone(this.tower.default_rally_pos)
	end

	return true
end

function scripts.tower_swamp_monster.remove(this, store, script)
	for _, s in pairs(this.barrack.soldiers) do
		if s.health then
			s.health.dead = true
		end

		queue_remove(store, s)
	end

	return true
end

function scripts.tower_swamp_monster.update(this, store, script)
	local shooter_sid = this.tower.level == 4 and 4 or 2
	local ab = this.attacks and this.attacks.list[1]

	if this.tower_upgrade_persistent_data.current_mode == nil then
		this.tower_upgrade_persistent_data.current_mode = 0
	end

	b_type = this.barrack.soldier_type
	this.tower_upgrade_persistent_data.collect_hp = this.tower_upgrade_persistent_data.current_mode == 1 and E:get_template(b_type).health.hp_max or 0
	if this.tower.level < 4 then
		if this.tower_upgrade_persistent_data.current_mode == 0 then 
			this.render.sprites[2].hidden = true
			this.barrack.max_soldiers = 1
		else
			this.render.sprites[2].hidden = false
			this.barrack.max_soldiers = 0
		end
	else
		if this.tower_upgrade_persistent_data.current_mode == 0 then 
			this.render.sprites[2].hidden = false
			this.render.sprites[3].hidden = false
			this.render.sprites[4].hidden = true
			this.render.sprites[5].hidden = true
			this.render.sprites[6].hidden = true
			this.barrack.max_soldiers = 1
		else
			this.render.sprites[2].hidden = true
			this.render.sprites[3].hidden = true
			this.render.sprites[4].hidden = false
			this.render.sprites[5].hidden = false
			this.render.sprites[6].hidden = false
			this.barrack.max_soldiers = 0
		end
	end


	local attacks = {}
	if ab then
		table.insert(attacks, ab)--射击
		--table.insert(pows, nil)
	end
	local check_hp_store = false

	local function check_change_mode()
		if this.change_mode then
			this.change_mode = false
			--死亡状态下不能切换
			if this.tower_upgrade_persistent_data.current_mode == 0 and this.barrack.soldiers[1].health.dead then
				return false
			end

			if this.tower_upgrade_persistent_data.current_mode == 0 then
				this.tower_upgrade_persistent_data.collect_hp = math.max(this.barrack.soldiers[1].health.hp, 1)
				this.barrack.max_soldiers = 0
				if this.barrack.soldiers[1] and this.barrack.soldiers[1].health then
					this.barrack.soldiers[1].health.dead = true
				end

				queue_remove(store, this.barrack.soldiers[1])
				this.tower_upgrade_persistent_data.current_mode = 1
			else
				this.barrack.max_soldiers = 1
				this.tower_upgrade_persistent_data.current_mode = 0
				check_hp_store = true
			end

			if this.tower.level < 4 then
				if this.tower_upgrade_persistent_data.current_mode == 0 then 
					this.render.sprites[2].hidden = true
				else
					this.render.sprites[2].hidden = false
				end
			else
				if this.tower_upgrade_persistent_data.current_mode == 0 then 
					this.render.sprites[2].hidden = false
					this.render.sprites[3].hidden = false
					this.render.sprites[4].hidden = true
					this.render.sprites[5].hidden = true
					this.render.sprites[6].hidden = true
				else
					this.render.sprites[2].hidden = true
					this.render.sprites[3].hidden = true
					this.render.sprites[4].hidden = false
					this.render.sprites[5].hidden = false
					this.render.sprites[6].hidden = false
				end
			end
			S:queue("SwampMonsterTaunt")
			return true
		end

		return false
	end

	local function sync_soldier_tower_damage_factor(s)
		if not s or not s.unit then
			return
		end

		local factor = this.tower and this.tower.damage_factor or 1
		local applied = s._tower_damage_factor or 1

		if applied ~= factor then
			s.unit.damage_factor = (s.unit.damage_factor or 1) / applied * factor
			s._tower_damage_factor = factor
		end
	end

	while true do
		
		local b = this.barrack

		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					for _, s in pairs(b.soldiers) do
						s.powers[pn].level = p.level
						s.powers[pn].changed = true
					end
				end
			end
		end

		check_change_mode()

		if not this.tower.blocked then
			for i = 1, b.max_soldiers do
				local s = b.soldiers[i]

				if not s or s.health.dead and not store.entities[s.id] then
					s = E:create_entity(b.soldier_type)
					s.soldier.tower_id = this.id
					s.pos = V.v(V.add(this.pos.x, this.pos.y, b.respawn_offset.x, b.respawn_offset.y))
					s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers)
					s.nav_rally.new = true

					if this.powers then
						for pn, p in pairs(this.powers) do
							s.powers[pn].level = p.level
						end
					end

					sync_soldier_tower_damage_factor(s)

					queue_insert(store, s)

					b.soldiers[i] = s

					signal.emit("tower-spawn", this, s)

				end
			end
		end

		if b.rally_new then
			b.rally_new = false

			signal.emit("rally-point-changed", this)

			local all_dead = true

			for i, s in ipairs(b.soldiers) do
				s.nav_rally.pos, s.nav_rally.center = U.rally_formation_position(i, b, b.max_soldiers, b.rally_angle_offset)
				s.nav_rally.new = true
				all_dead = all_dead and s.health.dead
			end

			if not all_dead then
				S:queue(this.sound_events.change_rally_point)
			end
		end

		if check_hp_store == true and b.soldiers[1] then 
			check_hp_store = false
			b.soldiers[1].health.hp = math.min(b.soldiers[1].health.hp_max, this.tower_upgrade_persistent_data.collect_hp)
			this.tower_upgrade_persistent_data.collect_hp = 0
		end

		if this.tower.blocked or this.tower_upgrade_persistent_data.current_mode == 0 then
			coroutine.yield()
		else
			for i, aa in pairs(attacks) do
				if aa and not aa.disabled and store.tick_ts - aa.ts > aa.cooldown then 
					if aa == ab then
						local target
						target = U.find_foremost_enemy(store.entities, tpos(this), 0, this.attacks.range, false, aa.vis_flags, aa.vis_bans)
						if not target then
							--SU.delay_attack(store, aa, fts(5))
						else
							local enemy_id = target.id
							local shoot_pos = pred_pos

							aa.ts = store.tick_ts

							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, target.pos, shooter_sid, soffset)
							local start_offset = aa.bullet_start_offset

							if this.tower.level == 4 then
								U.animation_start_group(this, an, af, store.tick_ts, false, "layers")
							else
								U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
							end
							U.y_wait(store, ab.shoot_time)
							if target then
								local b = E:create_entity(aa.bullet)
								b.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
								b.pos = V.vclone(b.bullet.from)
								b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
								b.bullet.target_id = target.id
								b.bullet.source_id = this.id
								b.bullet.damage_min = math.ceil(b.bullet.damage_min * this.tower.damage_factor)
								b.bullet.damage_max = math.ceil(b.bullet.damage_max * this.tower.damage_factor)

								--投手的额外mod
								if this.powers and this.powers.stun.level > 0 and math.random() < this.powers.stun.mod_chance[this.powers.stun.level] then
									b.bullet.mod = "mod_swamp_stun"
								end
								if this.powers and this.powers.instakill.level > 0
									and math.random() < this.powers.instakill.mod_chance[this.powers.instakill.level]
									and band(target.vis.flags, bor(F_BOSS, F_MINIBOSS)) == 0
									and band(target.vis.bans, F_INSTAKILL) == 0 then
									b.render.sprites[1].name = "Swamp_monster_tower_proyectile_instakill_lvl4"
									b.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS)
								end
								if this.powers and this.powers.eat.level > 0 then
									local d = SU.create_bullet_damage(b.bullet, target.id, this.id)
									--queue_damage(store, d)
									local will_kill = U.predict_damage(target, d) >= target.health.hp
									if will_kill then
										this.tower_upgrade_persistent_data.collect_hp = this.tower_upgrade_persistent_data.collect_hp + this.powers.eat.hp
									end
								end
								queue_insert(store, b)
							end
							while not U.animation_finished(this, shooter_sid) do
								coroutine.yield()
							end
							local an2 = an == "shootUp" and "idleUp" or "idle" 
							if this.tower.level == 4 then
								U.animation_start_group(this, an2, af, store.tick_ts, true, "layers")
							else
								U.animation_start(this, an2, af, store.tick_ts, true, shooter_sid)
							end
						end		
					end
				end
			end

		end
		coroutine.yield()
	end
end

--沼巨战士
scripts.soldier_swamp_monster = {}

function scripts.soldier_swamp_monster.insert(this, store)
	if scripts.soldier_barrack.insert(this, store) then
		if this.powers then
			for pn, p in pairs(this.powers) do

				if pn == "instakill" then
						--this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
						--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
				end
					if pn == "stun" then
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						
					end
			end
		end

		return true
	end

	return false
end

function scripts.soldier_swamp_monster.update(this, store)
	local brk, sta
	local tower = store.entities[this.soldier.tower_id]

	local function sync_tower_damage_factor()
		tower = store.entities[this.soldier.tower_id]

		local factor = tower and tower.tower and tower.tower.damage_factor or 1
		local applied = this._tower_damage_factor or 1

		if this.unit and applied ~= factor then
			this.unit.damage_factor = (this.unit.damage_factor or 1) / applied * factor
			this._tower_damage_factor = factor
		end
	end

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	while true do
		if this.powers then
			for pn, p in pairs(this.powers) do
				if p.changed then
					p.changed = nil

					SU.soldier_power_upgrade(this, pn)

					if pn == "instakill" then
						--this.health.dark_spiked_armor = p.dark_spiked_armor[p.level]
						--this.render.sprites[1].prefix = "soldier_dark_knight_spikes"
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
					end
					if pn == "stun" then
						this.melee.attacks[1].chance = 1 - this.powers.stun.level * this.melee.attacks[2].chance_inc - this.powers.instakill.level * this.melee.attacks[3].chance_inc
						this.melee.attacks[2].chance = this.powers.stun.level * this.melee.attacks[2].chance_inc
						this.melee.attacks[3].chance = this.powers.instakill.level * this.melee.attacks[3].chance_inc
						
					end
					--print(this.melee.attacks[1].chance.." "..this.melee.attacks[2].chance.." "..this.melee.attacks[3].chance)
				end
			end
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			sync_tower_damage_factor()
			--[[
			if this.dodge and this.dodge.active then
				local ca = this.dodge.shield

				this.dodge.active = false

				if this.powers[this.dodge.power_name].level > 0 and store.tick_ts - ca.ts > ca.cooldown then
					local start_ts = store.tick_ts

					ca.ts = 0
					this.health.ignore_damage = true
					this.vis.bans = bor(this.vis.bans, F_NET)

					S:queue(ca.sound)
					U.y_animation_play(this, ca.animation_start, nil, store.tick_ts, 1)
					U.y_wait(store, ca.hit_time)

					while store.tick_ts - start_ts < ca.duration do
						if store.tick_ts - ca.ts > ca.damage_every then
							ca.ts = store.tick_ts
						end
						
						if this.nav_rally.new then
							this.vis.bans = band(this.vis.bans, bnot(F_NET))
							this.health.ignore_damage = false
							goto label_612_1
						end

						coroutine.yield()
					end

					this.vis.bans = band(this.vis.bans, bnot(F_NET))
					
					U.y_animation_play(this, ca.animation_end, nil, store.tick_ts, 1)
					
					this.health.ignore_damage = false

					SU.soldier_idle(store, this)
					signal.emit("soldier-dodge", this)
				end
			end
			]]--
			::label_612_1::
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_61_1
				end
			end

			--brk, sta = SU.y_soldier_melee_block_and_attacks(store, this) --y_swamp_melee_block_and_attacks
			brk, sta = SU.y_swamp_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else

				if brk or sta == A_DONE then
					goto label_61_1
				elseif sta == A_IN_COOLDOWN then
					goto label_61_0
				end

				if SU.soldier_go_back_step(store, this) then
					goto label_61_1
				end

				::label_61_0::

				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_61_1::

		coroutine.yield()
	end
end



-- SC Reset 3.6 branch towers -------------------------------------------------

local function sc_source_tower(store, source_id)
	local source = store.entities[source_id]

	if source and source.tower and not source.tower.destroy then
		return source
	end
end

local function sc_source_damage_factor(store, source_id)
	local source = sc_source_tower(store, source_id)

	return source and source.tower.damage_factor or 1
end

local function sc_apply_mod(store, name, source_id, target_id, level, duration)
	local mod = E:create_entity(name)

	mod.modifier.source_id = source_id
	mod.modifier.target_id = target_id
	mod.modifier.level = level or 0
	if duration then
		mod.modifier.duration = duration
	end

	queue_insert(store, mod)
	return mod
end

local function sc_refresh_or_apply_mod(store, name, source_id, target_id, level, duration, refresh_source)
	for _, entity in pairs(store.entities) do
		if entity.template_name == name and entity.modifier and entity.modifier.target_id == target_id then
			entity.modifier.ts = store.tick_ts
			entity.modifier.level = level or entity.modifier.level
			entity.modifier.duration = duration or entity.modifier.duration
			if refresh_source then
				entity.modifier.source_id = source_id
			end
			return entity
		end
	end

	return sc_apply_mod(store, name, source_id, target_id, level, duration)
end

local function sc_queue_damage(store, source_id, target, value, damage_type)
	local damage = E:create_damage()

	damage.source_id = source_id
	damage.target_id = target.id
	damage.value = value
	damage.damage_type = damage_type
	queue_damage(store, damage)
end

local function sc_radius(source_diameter)
	return source_diameter / 2
end

local function sc_spawn_reinforcement(store, name, pos, rally_pos)
	local soldier = E:create_entity(name)

	soldier.pos = V.vclone(pos)
	if soldier.nav_rally then
		soldier.nav_rally.pos = V.vclone(rally_pos or pos)
		soldier.nav_rally.center = V.vclone(rally_pos or pos)
		soldier.nav_rally.new = true
	end
	queue_insert(store, soldier)
	return soldier
end

local function sc_spawn_path_soldier(store, name, pos)
	local nodes = P:nearest_nodes(pos.x, pos.y, nil, nil, true)

	if not nodes or #nodes == 0 then
		log.error("SC branch tower could not find an active path at %s,%s", pos.x, pos.y)
		return nil
	end

	local pi = nodes[1][1]
	local spi = math.random(1, #P.paths[pi])
	local subpath_nodes = P:nearest_nodes(pos.x, pos.y, {pi}, {spi}, true)
	local node = subpath_nodes[1] or nodes[1]
	local soldier = E:create_entity(name)

	soldier.nav_path.pi = node[1]
	soldier.nav_path.spi = node[2]
	soldier.nav_path.ni = node[3]
	soldier.pos = V.vclone(pos)
	queue_insert(store, soldier)
	return soldier
end

local function sc_path_positions(target, count, spacing)
	local positions = {}

	if not target or not target.nav_path then
		return positions
	end

	local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
	local first_offset = -math.floor((count - 1) / 2) * spacing
	local path = P.paths[pi] and P.paths[pi][spi]

	if not path then
		return positions
	end

	for i = 1, count do
		local path_ni = km.clamp(1, #path, ni + first_offset + (i - 1) * spacing)
		local pos = P:node_pos(pi, spi, path_ni)

		if pos then
			positions[#positions + 1] = V.vclone(pos)
		end
	end

	return positions
end

local function sc_find_crowded_enemy(store, origin, range, crowd_range, vis_flags, vis_bans)
	local candidates = U.find_enemies_in_range(store.entities, origin, 0, range, vis_flags, vis_bans) or {}
	local best, best_count

	for _, candidate in pairs(candidates) do
		local crowd = U.find_enemies_in_range(store.entities, candidate.pos, 0, crowd_range, vis_flags, vis_bans) or {}

		if not best_count or #crowd > best_count then
			best = candidate
			best_count = #crowd
		end
	end

	return best
end

local function sc_fire_bullet(store, name, source, target, offset)
	local bullet = E:create_entity(name)
	local start = offset or V.v(0, 0)
	local hit_offset = target.unit and target.unit.hit_offset or V.v(0, 0)

	bullet.pos = V.v(source.pos.x + start.x, source.pos.y + start.y)
	bullet.bullet.from = V.vclone(bullet.pos)
	bullet.bullet.to = V.v(target.pos.x + hit_offset.x, target.pos.y + hit_offset.y)
	bullet.bullet.target_id = target.id
	bullet.bullet.source_id = source.id
	if source.tower then
		bullet.bullet.damage_factor = source.tower.damage_factor
	end
	queue_insert(store, bullet)
	return bullet
end

scripts.sc_branch_barrack = {}

function scripts.sc_branch_barrack.insert(this, store, script)
	local ok = scripts.tower_barrack.insert(this, store, script)

	if ok and this.sc_controller then
		local controller = E:create_entity(this.sc_controller)
		controller.source_id = this.id
		controller.pos = V.vclone(this.pos)
		queue_insert(store, controller)
		this.sc_controller_id = controller.id
	end

	return ok
end

function scripts.sc_branch_barrack.remove(this, store, script)
	if this.sc_controller_id and store.entities[this.sc_controller_id] then
		queue_remove(store, store.entities[this.sc_controller_id])
	end

	return scripts.tower_barrack.remove(this, store, script)
end

function scripts.sc_branch_barrack.update(this, store, script)
	local function sync_soldier_powers(soldier)
		if not this.powers or not soldier.powers then
			return
		end

		for power_name, tower_power in pairs(this.powers) do
			local soldier_power = soldier.powers[power_name]

			if soldier_power then
				soldier_power.level = tower_power.level
				for _, attacks in pairs({soldier.melee and soldier.melee.attacks, soldier.ranged and soldier.ranged.attacks}) do
					if attacks then
						for _, attack in pairs(attacks) do
							if attack.power_name == power_name then
								attack.level = tower_power.level
								attack.disabled = tower_power.level == 0 and true or nil
								if attack.damage_inc then
									attack._sc_damage_min = attack._sc_damage_min or attack.damage_min
									attack._sc_damage_max = attack._sc_damage_max or attack.damage_max
									attack.damage_min = attack._sc_damage_min + attack.damage_inc * tower_power.level
									attack.damage_max = attack._sc_damage_max + attack.damage_inc * tower_power.level
								end
							end
						end
					end
				end
				if soldier.timed_actions then
					for _, action in pairs(soldier.timed_actions.list) do
						if action.power_name == power_name then
							action.level = tower_power.level
							action.disabled = tower_power.level == 0 and true or nil
						end
					end
				end
			end
		end
	end

	while true do
		local barrack = this.barrack

		if this.powers then
			for _, power in pairs(this.powers) do
				if power.changed then
					power.changed = nil
				end
			end
		end

		for _, soldier in pairs(barrack.soldiers) do
			if soldier then
				sync_soldier_powers(soldier)
			end
		end

		if not this.tower.blocked then
			for i = 1, barrack.max_soldiers do
				local soldier = barrack.soldiers[i]

				if not soldier or soldier.health.dead and not store.entities[soldier.id] then
					soldier = E:create_entity(barrack.soldier_type)
					soldier.soldier.tower_id = this.id
					soldier.soldier.tower_soldier_idx = i
					soldier.pos = V.v(this.pos.x + barrack.respawn_offset.x, this.pos.y + barrack.respawn_offset.y)
					soldier.nav_rally.pos, soldier.nav_rally.center = U.rally_formation_position(i, barrack, barrack.max_soldiers)
					soldier.nav_rally.new = true

					sync_soldier_powers(soldier)

					queue_insert(store, soldier)
					barrack.soldiers[i] = soldier
					signal.emit("tower-spawn", this, soldier)
				end
			end
		end

		if barrack.rally_new then
			barrack.rally_new = false
			signal.emit("rally-point-changed", this)

			for i, soldier in ipairs(barrack.soldiers) do
				if soldier and soldier.nav_rally then
					soldier.nav_rally.pos, soldier.nav_rally.center = U.rally_formation_position(i, barrack, barrack.max_soldiers, barrack.rally_angle_offset)
					soldier.nav_rally.new = true
				end
			end

			S:queue(this.sound_events.change_rally_point)
		end

		coroutine.yield()
	end
end

scripts.sc_rat_controller = {}

scripts.sc_harpooner = {}

function scripts.sc_harpooner.insert(this, store, script)
	if this.soldier.tower_soldier_idx == 2 then
		this.render.sprites[1].prefix = "harpooner_girl"
		this.ranged.attacks[1].bullet = "bullet_sc_harpooner_girl"
	end

	return scripts.soldier_barrack.insert(this, store, script)
end

scripts.sc_harpooner_stun_roll = {}

function scripts.sc_harpooner_stun_roll.insert(this, store)
	if math.random() < 0.25 then
		sc_apply_mod(store, "mod_sc_harpooner_stun", this.modifier.source_id, this.modifier.target_id)
	end
	return false
end

scripts.sc_path_soldier = {}

function scripts.sc_path_soldier.get_info(this)
	local info = scripts.soldier_barrack.get_info(this)

	info.respawn = nil
	return info
end

function scripts.sc_path_soldier.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)
	this.nav_path.ni = this.nav_path.ni + math.random(3, 6)
	this.pos = P:node_pos(this.nav_path.pi, this.nav_path.spi, this.nav_path.ni)

	return this.pos ~= nil
end

function scripts.sc_path_soldier.update(this, store, script)
	local attack = this.melee.attacks[1]
	local next_pos = V.vclone(this.pos)

	while true do
		if this.health.dead then
			this.health.hp = 0
			SU.y_soldier_death(store, this)
			queue_remove(store, this)
			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, true)
		else
			local brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if not brk and sta == A_NO_TARGET then
				local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {this.nav_path.pi}, {this.nav_path.spi})

				if nearest and nearest[1] and nearest[1][3] < this.nav_path.ni then
					this.nav_path.ni = nearest[1][3]
				end

				local target
				while next_pos and not target and not this.health.dead and not this.unit.is_stunned do
					U.set_destination(this, next_pos)
					local an, af = U.animation_name_facing_point(this, "walk", this.motion.dest)
					U.animation_start(this, an, af, store.tick_ts, true)
					U.walk(this, store.tick_length)
					coroutine.yield()
					target = U.find_foremost_enemy(store.entities, this.pos, 0, this.melee.range, false, attack.vis_flags, attack.vis_bans)
					next_pos = P:next_entity_node(this, store.tick_length)
				end

				if this.health.dead or not next_pos then
					this.health.hp = 0
					U.y_animation_play(this, "death", nil, store.tick_ts, 1)
					queue_remove(store, this)
					return
				end
			end
		end

		coroutine.yield()
	end
end

scripts.sc_poisonous_rat = {}

function scripts.sc_poisonous_rat.update(this, store, script)
	local sprite = this.render.sprites[1]

	if this.spawn_delay and this.spawn_delay > 0 then
		sprite.hidden = true
		U.y_wait(store, this.spawn_delay)
		sprite.hidden = nil
	end

	local aura_ts = store.tick_ts - this.aura.cooldown
	local next_pos = P:next_entity_node(this, store.tick_length)

	while next_pos do
		if store.tick_ts - aura_ts >= this.aura.cooldown then
			aura_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.aura.range, F_MOD, bor(F_FLYING, F_NIGHTMARE)) or {}

			for _, target in ipairs(targets) do
				sc_refresh_or_apply_mod(store, "mod_sc_rat_swarm_dot", this.source_id, target.id, this.level, ({5, 6, 7})[this.level])
				sc_refresh_or_apply_mod(store, "mod_sc_rat_swarm_slow", this.source_id, target.id, this.level, ({5, 6, 7})[this.level])
			end
		end

		U.set_destination(this, next_pos)
		local animation, flip = U.animation_name_facing_point(this, "walk", this.motion.dest)

		U.animation_start(this, animation, flip, store.tick_ts, true)
		U.walk(this, store.tick_length)
		coroutine.yield()
		next_pos = P:next_entity_node(this, store.tick_length)
	end

	queue_remove(store, this)
end

function scripts.sc_rat_controller.update(this, store)
	local shooter_data = {
		{sprite = 4, offset = V.v(-14, 45)},
		{sprite = 5, offset = V.v(4, 34)}
	}
	local next_shot_ts = {store.tick_ts, store.tick_ts}
	local idle_ts = {}
	local small_ts = store.tick_ts - 7
	local swarm_ts = store.tick_ts
	local big_ts = store.tick_ts
	local big_rat_id
	local swarm_animation_end_ts

	while true do
		local tower = sc_source_tower(store, this.source_id)

		if not tower then
			break
		end

		this.pos = tower.pos
		if swarm_animation_end_ts and store.tick_ts >= swarm_animation_end_ts then
			U.animation_start(tower, "IdleBase", nil, store.tick_ts, true, 2)
			U.animation_start(tower, "idle", nil, store.tick_ts, true, 3)
			swarm_animation_end_ts = nil
		end

		for index, data in ipairs(shooter_data) do
			if idle_ts[index] and store.tick_ts >= idle_ts[index] then
				U.animation_start(tower, "idle", nil, store.tick_ts, true, data.sprite)
				idle_ts[index] = nil
			end

			if not tower.tower.blocked and store.tick_ts >= next_shot_ts[index] then
				local shooter_pos = V.v(tower.pos.x + data.offset.x, tower.pos.y + data.offset.y)
				local target = U.find_random_enemy(store.entities, shooter_pos, 0, sc_radius(300), F_RANGED, F_NIGHTMARE)

				if target then
					local flip = target.pos.x < shooter_pos.x
					local shot_offset = V.v(data.offset.x + (flip and -10 or 10), data.offset.y + 12)

					U.animation_start(tower, "range", flip, store.tick_ts, false, data.sprite)
					sc_fire_bullet(store, "sc_rat_small_bolt", tower, target, shot_offset)
					next_shot_ts[index] = store.tick_ts + U.frandom(0.8, 1)
					idle_ts[index] = store.tick_ts + 0.3
				end
			end
		end

		if not tower.tower.blocked and store.tick_ts - small_ts >= 7 then
			small_ts = store.tick_ts
			S:queue("UndergroundWarriorsSkill")
			local level = tower.powers.training.level
			local soldier = sc_spawn_path_soldier(store, "soldier_sc_underground", tower.pos)

			if soldier then
				soldier.health.hp_max = ({100, 120, 145, 175})[level + 1]
				soldier.health.hp = soldier.health.hp_max
				soldier.health.armor = ({0, 0.1, 0.2, 0.3})[level + 1]
				soldier.melee.attacks[1].damage_min = 17
				soldier.melee.attacks[1].damage_max = 25
				soldier.melee.attacks[2].damage_min = 17
				soldier.melee.attacks[2].damage_max = 25
				soldier.melee.attacks[2].chance = ({0, 0.2, 0.3, 0.4})[level + 1]
				soldier.melee.attacks[2].mod = ({nil, "mod_sc_underground_stun_1", "mod_sc_underground_stun_2", "mod_sc_underground_stun_3"})[level + 1]
			end
		end

		local big_level = tower.powers.big_rat.level
		local big_rat = big_rat_id and store.entities[big_rat_id]
		if big_level > 0 and not big_rat and store.tick_ts - big_ts >= ({34, 29, 24})[big_level] then
			big_ts = store.tick_ts
			big_rat = sc_spawn_path_soldier(store, "soldier_sc_big_rat", tower.pos)
			if big_rat then
				big_rat.health.hp_max = ({480, 540, 620})[big_level]
				big_rat.health.hp = big_rat.health.hp_max
				big_rat_id = big_rat.id
			end
		end

		local swarm_level = tower.powers.rat_swarm.level
		if swarm_level > 0 and not tower.tower.blocked and store.tick_ts - swarm_ts >= 18 then
			local target = U.find_random_enemy(store.entities, tower.pos, 0, sc_radius(280), F_MOD, bor(F_FLYING, F_NIGHTMARE), function(enemy)
				return enemy.nav_path ~= nil
			end)

			if target then
				swarm_ts = store.tick_ts
				S:queue("UndergroundWarriorsRatSwarm")
				U.animation_start(tower, "IdleBaseSkillAction", nil, store.tick_ts, false, 2)
				U.animation_start(tower, "IdleBaseSkillAction", nil, store.tick_ts, false, 3)
				swarm_animation_end_ts = store.tick_ts + 0.7

				for i = 1, 6 do
					local rat = E:create_entity("unit_sc_poisonous_rat")
					local pi = target.nav_path.pi
					local spi = math.random(1, #P.paths[pi])
					local nodes = P:nearest_nodes(target.pos.x, target.pos.y, {pi}, {spi}, true)
					local node = nodes and nodes[1]

					rat.nav_path.pi = pi
					rat.nav_path.spi = node and node[2] or target.nav_path.spi
					rat.nav_path.ni = node and node[3] or target.nav_path.ni
					rat.nav_path.dir = -1
					rat.pos = V.vclone(target.pos)
					rat.source_id = tower.id
					rat.level = swarm_level
					rat.spawn_delay = (i - 1) * 0.1
					queue_insert(store, rat)
				end
			end
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.sc_rat_shield = {}

function scripts.sc_rat_shield.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	this.modifier.duration = ({3, 4, 5})[this.modifier.level]
	this.previous_ignore_damage = target.health.ignore_damage
	target.health.ignore_damage = true
	this.modifier.ts = store.tick_ts
	return true
end

function scripts.sc_rat_shield.remove(this, store)
	local target = store.entities[this.modifier.target_id]

	if target and target.health then
		target.health.ignore_damage = this.previous_ignore_damage or false
	end
	return true
end

scripts.sc_avenger_controller = {}

function scripts.sc_avenger_controller.update(this, store)
	local curse_ts = {}

	while true do
		local tower = sc_source_tower(store, this.source_id)

		if not tower then
			break
		end
		this.pos = tower.pos

		for _, soldier in pairs(tower.barrack.soldiers) do
			if soldier and soldier.health and not soldier.health.dead then
				-- Adjust only the stance's base resistance; direct assignment each tick
				-- would erase temporary bonuses such as the KR6 priestess aura.
				local base_armor = soldier.soldier.target_id and 0.5 or 0.9
				local previous_armor = soldier.sc_avenger_base_armor or 0.9

				if base_armor ~= previous_armor then
					SU.armor_inc(soldier, base_armor - previous_armor)
					soldier.sc_avenger_base_armor = base_armor
				end

				local base_magic_armor = 0.45 * math.min(tower.powers.magic_armor.level, 2)
				local previous_magic_armor = soldier.sc_avenger_base_magic_armor or 0

				if base_magic_armor ~= previous_magic_armor then
					SU.magic_armor_inc(soldier, base_magic_armor - previous_magic_armor)
					soldier.sc_avenger_base_magic_armor = base_magic_armor
				end
				local level = soldier.powers.death_curse.level
				if curse_ts[soldier.id] == nil then
					curse_ts[soldier.id] = store.tick_ts
				end
				local last_ts = curse_ts[soldier.id]

				if level > 0 and store.tick_ts - last_ts >= 7.5 then
					local targets = U.find_enemies_in_range(store.entities, soldier.pos, 0, sc_radius(150), F_MOD, F_NIGHTMARE) or {}
					if #targets >= 2 then
						curse_ts[soldier.id] = store.tick_ts
					for _, target in pairs(targets) do
						if not U.has_modifiers(store, target, "mod_sc_avenger_curse") then
							sc_apply_mod(store, "mod_sc_avenger_curse", soldier.id, target.id, level, 9999)
						end
					end
					end
				end
			end
		end
		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.sc_avenger_bonus = {}

function scripts.sc_avenger_bonus.insert(this, store)
	local source = store.entities[this.modifier.source_id]
	local target = store.entities[this.modifier.target_id]
	local level = source and source.powers and source.powers.twilight_blade.level or 0

	if target and target.health and not target.health.dead and level > 0 then
		sc_queue_damage(store, source.id, target, ({5, 10})[level], DAMAGE_TRUE)
	end
	return false
end

scripts.sc_avenger_curse = {}

function scripts.sc_avenger_curse.update(this, store)
	local target = store.entities[this.modifier.target_id]

	while target and not target.health.dead and store.tick_ts - this.modifier.ts < this.modifier.duration do
		this.pos = target.pos
		coroutine.yield()
		target = store.entities[this.modifier.target_id]
	end

	if target and target.health.dead then
		local burst = E:create_entity("aura_sc_avenger_curse_burst")
		burst.pos = V.vclone(target.pos)
		burst.aura.source_id = this.modifier.source_id
		burst.aura.level = this.modifier.level
		queue_insert(store, burst)
	end
	queue_remove(store, this)
end

scripts.sc_avenger_curse_burst = {}

function scripts.sc_avenger_curse_burst.update(this, store)
	local damage = ({30, 55, 80})[this.aura.level]
	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(120), F_AREA, F_NIGHTMARE) or {}

	for _, target in pairs(targets) do
		sc_queue_damage(store, this.aura.source_id, target, damage, DAMAGE_MAGICAL)
	end
	queue_remove(store, this)
end

scripts.sc_forest_heal = {}

function scripts.sc_forest_heal.update(this, store)
	local level = this.aura.level
	local source = store.entities[this.aura.source_id]
	local start_ts = store.tick_ts
	local tick_ts = store.tick_ts - 0.5

	if source then
		this.pos = source.pos
	end

	while source and not source.health.dead and store.tick_ts - start_ts < 5 do
		this.pos = source.pos
		if store.tick_ts - tick_ts >= 0.5 then
			tick_ts = store.tick_ts
			local allies = U.find_soldiers_in_range(store.entities, this.pos, 0, sc_radius(300), F_FRIEND, 0) or {}

			for _, ally in pairs(allies) do
				if ally.health and not ally.health.dead then
					local amount = ({12, 24, 36})[level]
					ally.health.hp = km.clamp(0, ally.health.hp_max, ally.health.hp + amount)
					signal.emit("health-regen", ally, amount)
				end
			end
		end
		coroutine.yield()
		source = store.entities[this.aura.source_id]
	end

	queue_remove(store, this)
end

scripts.sc_forest_roots = {}

function scripts.sc_forest_roots.update(this, store)
	local source = store.entities[this.aura.source_id]

	if source then
		this.pos = source.pos
	end
	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(330), F_MOD, bor(F_FLYING, F_BOSS, F_NIGHTMARE)) or {}
	local count = math.min(#targets, ({7, 8})[this.aura.level])

	for i = 1, count do
		sc_apply_mod(store, "mod_sc_forest_roots", this.aura.source_id, targets[i].id, this.aura.level, ({4, 7})[this.aura.level])
	end
	queue_remove(store, this)
end

scripts.sc_slow_dps = {}

function scripts.sc_slow_dps.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead or not target.motion then
		return false
	end
	target.motion.max_speed = target.motion.max_speed * this.slow.factor
	this.modifier.ts = store.tick_ts
	this.dps.ts = store.tick_ts - this.dps.damage_every
	if this.render then
		this.render.sprites[1].ts = store.tick_ts
		this.render.sprites[1].z = target.render and target.render.sprites[1].z or Z_EFFECTS
	end
	return true
end

function scripts.sc_slow_dps.update(this, store)
	local target = store.entities[this.modifier.target_id]

	while target and not target.health.dead and store.tick_ts - this.modifier.ts < this.modifier.duration do
		this.pos = target.pos
		if store.tick_ts - this.dps.ts >= this.dps.damage_every then
			this.dps.ts = store.tick_ts
			sc_queue_damage(store, this.modifier.source_id, target, math.random(this.dps.damage_min, this.dps.damage_max), this.dps.damage_type)
		end
		coroutine.yield()
		target = store.entities[this.modifier.target_id]
	end
	queue_remove(store, this)
end

function scripts.sc_slow_dps.remove(this, store)
	local target = store.entities[this.modifier.target_id]

	if target and target.motion then
		target.motion.max_speed = target.motion.max_speed / this.slow.factor
	end
	return true
end

scripts.sc_nuclear_tower = {}

function scripts.sc_nuclear_tower.get_info(this)
		return {
			type = STATS_TYPE_TOWER,
			damage_min = 77,
			damage_max = 77,
			damage_type = DAMAGE_MAGICAL,
			range = this.attacks.range,
			cooldown = 4.3
		}
end

function scripts.sc_nuclear_tower.update(this, store)
	local attack_ts = store.tick_ts - 4.3
	local zone_power = this.powers.toxic_zone
	local zone_cooldown = 28
	local zone_ts = zone_power.level > 0 and store.tick_ts - zone_cooldown or store.tick_ts

	while true do
		for _, power in pairs(this.powers) do
			if power.changed then
				if power == zone_power and power.level > 0 then
					-- The original skill starts ready when it is bought.  Do not tie
					-- its first cast to the age of the tower.
					zone_ts = store.tick_ts - zone_cooldown
				end
				power.changed = nil
			end
		end

		if zone_power.level > 0 and not this.tower.blocked and store.tick_ts - zone_ts >= zone_cooldown then
			zone_ts = store.tick_ts
			S:queue("WasteDisposerSkill")
			U.animation_start(this, "discharge", nil, store.tick_ts, false, 2)
			U.y_wait(store, 0.6)

			local zone = E:create_entity("aura_sc_nuclear_zone")
			zone.aura.source_id = this.id
			zone.pos = V.vclone(this.pos)
			queue_insert(store, zone)

			-- This sequence is enqueued by the four dummy animation skills in
			-- the source data.  It is intentionally not cancelled by blocking.
			for _ = 1, 3 do
				U.y_animation_play(this, "loop", nil, store.tick_ts, 1, 2)
			end
			U.y_animation_play(this, "charge", nil, store.tick_ts, 1, 2)
			U.animation_start(this, "idle", nil, store.tick_ts, true, 2)
		elseif not this.tower.blocked and store.tick_ts - attack_ts >= 4.3 then
			local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.attacks.range, 0, F_RANGED, bor(F_FLYING, F_NIGHTMARE))

			if target then
				attack_ts = store.tick_ts
				S:queue("WasteDisposerThrow")
				U.animation_start(this, "discharge", nil, store.tick_ts, false, 2)
				U.y_wait(store, 0.35)
				local bullet = sc_fire_bullet(store, "bullet_sc_nuclear", this, target, V.v(0, 48))
				-- Nuclear projectiles target the floor, not the unit's elevated
				-- hit point.  The impact, area damage and blob all share this point.
				bullet.bullet.to = V.vclone(target.pos)
				bullet.power_levels = {
					efficiency = this.powers.efficiency.level,
					super_blob = this.powers.super_blob.level
				}
				U.y_animation_wait(this, 2)
				U.animation_start(this, "idle", nil, store.tick_ts, true, 2)
			end
		end

		coroutine.yield()
	end
end

scripts.sc_nuclear_bomb = {}

function scripts.sc_nuclear_bomb.update(this, store)
	local b = this.bullet
	local start_ts = store.tick_ts
	local from = V.vclone(b.from)

	while store.tick_ts - start_ts < b.flight_time do
		local p = km.clamp(0, 1, (store.tick_ts - start_ts) / b.flight_time)
		this.pos.x = from.x + (b.to.x - from.x) * p
		this.pos.y = from.y + (b.to.y - from.y) * p + math.sin(p * math.pi) * 42
		coroutine.yield()
	end

	local impact = E:create_entity("fx_sc_nuclear_impact")
	impact.pos = V.vclone(b.to)
	queue_insert(store, impact)
	S:queue("WasteDisposerFall")

	local targets = U.find_enemies_in_range(store.entities, b.to, 0, b.damage_radius, F_RANGED, bor(F_FLYING, F_NIGHTMARE)) or {}
	for _, target in pairs(targets) do
		sc_queue_damage(store, b.source_id, target, 77 * (b.damage_factor or 1), DAMAGE_MAGICAL)
		target.health.armor = math.max(0, (target.health.armor or 0) - 0.02)
	end

	local levels = this.power_levels or {efficiency = 0, super_blob = 0}
	local blob_name = levels.super_blob > 0 and "soldier_sc_nuclear_blob_big" or "soldier_sc_nuclear_blob"
	local blob = sc_spawn_reinforcement(store, blob_name, b.to, b.to)
	blob.soldier.tower_id = b.source_id
	blob.sc_efficiency_level = levels.efficiency
	blob.unit.death_animation = levels.efficiency > 0 and "skillDeath" or "death"
	if levels.super_blob > 0 then
		blob.sc_blob_level = levels.super_blob
		blob.health.hp_max = ({120, 156, 204})[levels.super_blob]
		blob.health.hp = blob.health.hp_max
		blob.melee.attacks[1].damage_min = ({8, 9, 10})[levels.super_blob]
		blob.melee.attacks[1].damage_max = ({15, 17, 18})[levels.super_blob]
	end

	local decay = E:create_entity("controller_sc_nuclear_decay")
	decay.source_id = b.source_id
	decay.target_id = blob.id
	decay.efficiency_level = levels.efficiency
	decay.pos = blob.pos
	queue_insert(store, decay)
	queue_remove(store, this)
end

scripts.sc_nuclear_decay = {}
scripts.sc_nuclear_blob = {}

function scripts.sc_nuclear_blob.update(this, store, script)
	this.health_bar.hidden = true
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = nil
	return K45.kr4_soldier_barrack.update(this, store, script)
end

function scripts.sc_nuclear_decay.update(this, store)
	local tick_ts = store.tick_ts
	local target = store.entities[this.target_id]

	while target and not target.health.dead do
		this.pos = target.pos
		if store.tick_ts - tick_ts >= 1 then
			tick_ts = store.tick_ts
			sc_queue_damage(store, this.source_id, target, target.health.hp_max * 0.06, DAMAGE_TRUE)
		end
		coroutine.yield()
		target = store.entities[this.target_id]
	end

	if target and this.efficiency_level > 0 then
		local burst_pos = V.vclone(target.pos)

		-- The upgraded blob's source death modifier triggers one second into
		-- skillDeath rather than at the first frame of the death animation.
		U.y_wait(store, 1)
		local burst = E:create_entity("aura_sc_nuclear_death")
		burst.pos = burst_pos
		burst.aura.source_id = this.source_id
		burst.aura.level = this.efficiency_level
		queue_insert(store, burst)
	end
	queue_remove(store, this)
end

scripts.sc_nuclear_burst = {}

function scripts.sc_nuclear_burst.update(this, store)
	local level = this.aura.level

	U.animation_start(this, "spawn", nil, store.tick_ts, false, 1, true)

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(75), F_AREA, bor(F_FLYING, F_NIGHTMARE)) or {}

	for _, target in pairs(targets) do
		sc_queue_damage(store, this.aura.source_id, target, ({28, 42, 56})[level], DAMAGE_PHYSICAL)
	end

	local residue = E:create_entity("aura_sc_nuclear_residue")
	residue.pos = V.vclone(this.pos)
	residue.aura.source_id = this.aura.source_id
	residue.aura.level = level
	queue_insert(store, residue)
	U.y_animation_wait(this, 1)
	queue_remove(store, this)
end

scripts.sc_nuclear_residue = {}

function scripts.sc_nuclear_residue.update(this, store)
	local start_ts = store.tick_ts
	local tick_ts = store.tick_ts - 0.1

	U.animation_start(this, "run", nil, store.tick_ts, false, 1, true)

	while store.tick_ts - start_ts < 2 do
		if store.tick_ts - tick_ts >= 0.1 then
			tick_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(130), F_MOD, bor(F_FLYING, F_NIGHTMARE)) or {}

			for _, target in pairs(targets) do
				sc_refresh_or_apply_mod(store, "mod_sc_nuclear_residue", this.aura.source_id, target.id, this.aura.level, 4, true)
			end
		end
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.sc_nuclear_residue_mod = {}

function scripts.sc_nuclear_residue_mod.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end
	this.modifier.ts = store.tick_ts
	this.tick_ts = store.tick_ts - 0.1
	this.pos = target.pos
	this.render.sprites[1].ts = store.tick_ts
	return true
end

function scripts.sc_nuclear_residue_mod.update(this, store)
	local target = store.entities[this.modifier.target_id]

	while target and not target.health.dead and store.tick_ts - this.modifier.ts < this.modifier.duration do
		this.pos = target.pos
		if store.tick_ts - this.tick_ts >= 0.1 then
			this.tick_ts = this.tick_ts + 0.1
			local damage_per_tick = ({1.4, 2, 2.7})[this.modifier.level]
			sc_queue_damage(store, this.modifier.source_id, target, damage_per_tick * sc_source_damage_factor(store, this.modifier.source_id), DAMAGE_MAGICAL)
		end
		coroutine.yield()
		target = store.entities[this.modifier.target_id]
	end
	queue_remove(store, this)
end

scripts.sc_nuclear_zone = {}

function scripts.sc_nuclear_zone.update(this, store)
	local start_ts = store.tick_ts
	local tick_ts = store.tick_ts - 1.5

	for _, sprite in ipairs(this.render.sprites) do
		local offset = sprite.offset or V.v(0, 0)
		local x = this.pos.x + offset.x
		local y = this.pos.y + offset.y

		sprite.ts = store.tick_ts
		sprite.sc_nuclear_visible = P:valid_node_nearby(x, y, 0.5)
		sprite.hidden = not sprite.sc_nuclear_visible
		sprite.alpha = 0
	end

	while store.tick_ts - start_ts < 10 do
		local elapsed = store.tick_ts - start_ts
		local decal_alpha

		if elapsed < 0.2 then
			decal_alpha = 255 * elapsed / 0.2
		elseif elapsed < 6.7 then
			decal_alpha = 255
		elseif elapsed < 7 then
			decal_alpha = 255 * (7 - elapsed) / 0.3
		else
			decal_alpha = 0
		end

		for _, sprite in ipairs(this.render.sprites) do
			sprite.alpha = decal_alpha
			sprite.hidden = not sprite.sc_nuclear_visible or elapsed >= 7
		end

		if store.tick_ts - tick_ts >= 1.5 then
			tick_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(300), F_RANGED, bor(F_FLYING, F_NIGHTMARE)) or {}
			for _, target in pairs(targets) do
				sc_queue_damage(store, this.aura.source_id, target, 9 * sc_source_damage_factor(store, this.aura.source_id), DAMAGE_MAGICAL)
				target.health.armor = math.max(0, (target.health.armor or 0) - 0.01)
			end
		end
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.sc_drone_tower = {}

function scripts.sc_drone_tower.remove(this, store, script)
	for _, entity in pairs(store.entities) do
		if entity.modifier and entity.modifier.source_id == this.id and
			(entity.template_name == "mod_sc_drone_support" or
				entity.template_name == "mod_sc_drone_soldier_damage") then
			queue_remove(store, entity)
		end
	end

	return scripts.sc_branch_barrack.remove(this, store, script)
end

scripts.sc_drone_controller = {}

scripts.sc_drone = {}

function scripts.sc_drone.update(this, store)
	local attack = this.ranged.attacks[1]
	local sprite = this.render.sprites[1]
	local index = this.soldier.tower_soldier_idx or 1
	local target_offsets = {
		V.v(-18, 10),
		V.v(18, 10),
		V.v(0, -14)
	}
	local target_offset = target_offsets[index] or V.v(0, 0)
	local phase = (index - 1) * 2 * math.pi / 3
	local attack_ts = store.tick_ts - attack.cooldown
	local dest = V.vclone(this.pos)

	local function move_towards(point)
		dest.x, dest.y = point.x, point.y
		sprite.flip_x = dest.x < this.pos.x
		U.force_motion_step(this, store.tick_length, dest)
	end

	local function patrol(center)
		local angle = phase + store.tick_ts * 1.35
		move_towards(V.v(center.x + math.cos(angle) * 32, center.y + math.sin(angle) * 18))
	end

	U.animation_start(this, "walk", nil, store.tick_ts, true, 1)

	while true do
		local tower = this.soldier.tower_id and store.entities[this.soldier.tower_id]

		if this.health.dead or not tower then
			queue_remove(store, this)
			return
		end

		if this.nav_rally.new then
			this.nav_rally.new = false
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, true, 1)
			coroutine.yield()
		else
			local center = tower.pos
			local search_range = tower.barrack and tower.barrack.rally_range or attack.max_range
			local target = U.find_nearest_enemy(store.entities, center, 0, search_range, attack.vis_flags, attack.vis_bans)
			local target_pos = target and V.v(target.pos.x + target_offset.x, target.pos.y + target_offset.y)

			-- 调集范围决定无人机能发现多远的目标；攻击范围只决定无人机
			-- 巡航到离目标多近时才开始射击。
			if target and V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y) > attack.max_range then
				move_towards(target_pos)
				coroutine.yield()

			elseif target and store.tick_ts - attack_ts >= attack.cooldown then
				local animation, flip = U.animation_name_facing_point(this, attack.animation, target.pos)
				local start_ts = store.tick_ts

				attack_ts = store.tick_ts
				S:queue(attack.sound)
				U.animation_start(this, animation, flip, store.tick_ts, false, 1)

				for _, shoot_time in ipairs(attack.shoot_times) do
					while store.tick_ts - start_ts < shoot_time do
						if not store.entities[target.id] or target.health.dead then
							break
						end
						move_towards(V.v(target.pos.x + target_offset.x, target.pos.y + target_offset.y))
						coroutine.yield()
					end

					if not store.entities[target.id] or target.health.dead then
						break
					end

					sc_fire_bullet(store, attack.bullet, this, target, V.v(0, 10))
				end

				while not U.animation_finished(this, 1) do
					if store.entities[target.id] and not target.health.dead then
						move_towards(V.v(target.pos.x + target_offset.x, target.pos.y + target_offset.y))
					else
						patrol(center)
					end
					coroutine.yield()
				end

				U.animation_start(this, "walk", nil, store.tick_ts, true, 1)
			elseif target then
				move_towards(target_pos)
				coroutine.yield()
			else
				patrol(center)
				coroutine.yield()
			end
		end
	end
end

function scripts.sc_drone_controller.update(this, store)
	local bomb_ts = store.tick_ts
	local big_ts = store.tick_ts
	this.big_id = nil
	this.big_spawn_pending = false
	local aura_level = 0
	local aura_mods = {}
	local soldier_aura_level = 0
	local soldier_aura_mods = {}

	local function clear_mods(mods)
		for _, mod in pairs(mods) do
			if store.entities[mod.id] then
				queue_remove(store, mod)
			end
		end
	end

	while true do
		local tower = sc_source_tower(store, this.source_id)
		if not tower then
			break
		end
		this.pos = tower.pos
		--tower.powers.support.price_inc = tower.powers.support.level >= 2 and 280 or 270

		local drone_level = tower.powers.drone_upgrade.level
		for index, soldier in pairs(tower.barrack.soldiers) do
			if soldier and soldier.ranged and soldier.render then
				local upgraded = index <= drone_level
				local attack = soldier.ranged.attacks[1]

				if soldier.sc_drone_upgraded ~= upgraded then
					soldier.sc_drone_upgraded = upgraded
					attack.bullet = upgraded and "bullet_sc_drone_upgraded" or "bullet_sc_drone"
					attack.cooldown = upgraded and 0.8 or 1
					soldier.render.sprites[1].prefix = upgraded and "dronehivedrone_skilla" or "dronehivedrone"
					if soldier.render.sprites[2] then
						soldier.render.sprites[2].name = upgraded and "asst_dronehive_drone_shadow_skillA" or "asst_dronehive_drone_shadow"
					end
					U.animation_start(soldier, "idle", nil, store.tick_ts, true)
				end
			end
		end

		if drone_level ~= soldier_aura_level then
			clear_mods(soldier_aura_mods)
			soldier_aura_mods = {}
			soldier_aura_level = drone_level
		end
		if drone_level > 0 then
			local in_range = {}
			local soldiers = U.find_soldiers_in_range(store.entities, tower.pos, 0, sc_radius(500), F_FRIEND, 0) or {}

			for _, soldier in pairs(soldiers) do
				if soldier.unit and soldier.id ~= tower.id and not soldier.health.dead then
					in_range[soldier.id] = true
					if not soldier_aura_mods[soldier.id] then
						local mod = E:create_entity("mod_sc_drone_soldier_damage")
						mod.modifier.source_id = tower.id
						mod.modifier.target_id = soldier.id
						mod.inflicted_damage_factor = ({1.2, 1.35, 1.5})[drone_level]
						queue_insert(store, mod)
						soldier_aura_mods[soldier.id] = mod
					end
				end
			end

			for id, mod in pairs(soldier_aura_mods) do
				if not in_range[id] then
					if store.entities[mod.id] then
						queue_remove(store, mod)
					end
					soldier_aura_mods[id] = nil
				end
			end
		end

		if not tower.tower.blocked and store.tick_ts - bomb_ts >= 12 then
			local target = U.find_foremost_enemy(store.entities, tower.pos, 0, sc_radius(3000), false, F_RANGED, bor(F_FLYING, F_NIGHTMARE))
			if target then
				bomb_ts = store.tick_ts
				S:queue("DroneHiveSkill")
				U.animation_start(tower, "specialDroneOpen", nil, store.tick_ts, false, 2)
				U.y_wait(store, 0.9)
				if target.health.dead then
					target = U.find_foremost_enemy(store.entities, tower.pos, 0, sc_radius(3000), false, F_RANGED, bor(F_FLYING, F_NIGHTMARE))
				end

				if target then
				local bullet = E:create_entity("bullet_sc_drone_orbital")
				bullet.pos = V.v(tower.pos.x + 29, tower.pos.y + 26)
				bullet.bullet.from = V.vclone(bullet.pos)
				bullet.bullet.to = V.vclone(target.pos)
				bullet.bullet.target_id = target.id
				bullet.bullet.source_id = tower.id
				queue_insert(store, bullet)
				end
				U.animation_start(tower, "specialDroneClose", nil, store.tick_ts, false, 2)
			end
		end

		local level = tower.powers.support.level
		if level ~= aura_level then
			clear_mods(aura_mods)
			aura_mods = {}
			aura_level = level
		end
		if level > 0 then
			local in_range = {}
			for _, other in pairs(store.entities) do
				if other.tower and not other.tower_holder and other.id ~= tower.id and not other.tower.destroy and V.dist(other.pos.x, other.pos.y, tower.pos.x, tower.pos.y) <= sc_radius(500) then
					in_range[other.id] = true
					if not aura_mods[other.id] then
						local mod = E:create_entity("mod_sc_drone_support")
						mod.modifier.source_id = tower.id
						mod.modifier.target_id = other.id
						mod.modifier.level = level
						mod.range_factor = ({1.05, 1.1, 1.15})[level]
						mod.damage_factor = ({1.16, 1.32, 1.48})[level]
						queue_insert(store, mod)
						aura_mods[other.id] = mod
					end
				end
			end
			for id, mod in pairs(aura_mods) do
				if not in_range[id] then
					if store.entities[mod.id] then
						queue_remove(store, mod)
					end
					aura_mods[id] = nil
				end
			end
		end

		local big_level = tower.powers.big_drone.level
		local big = this.big_id and store.entities[this.big_id]
		local rally_pos = tower.barrack and tower.barrack.rally_pos or tower.pos

		if big and big.nav_rally and rally_pos then
			local synced_pos = big.sc_drone_rally_pos

			if not synced_pos or synced_pos.x ~= rally_pos.x or synced_pos.y ~= rally_pos.y then
				big.nav_rally.pos = V.vclone(rally_pos)
				big.nav_rally.center = V.vclone(rally_pos)
				big.nav_rally.new = true
				big.sc_drone_rally_pos = V.vclone(rally_pos)
			end
		end

		if big_level > 0 and not big and not this.big_spawn_pending and store.tick_ts - big_ts >= ({16, 13})[big_level] then
			local target = U.find_foremost_enemy(store.entities, tower.pos, 0, sc_radius(280), false, F_RANGED, bor(F_FLYING, F_NIGHTMARE))

			if target then
				big_ts = store.tick_ts
				this.big_spawn_pending = true
				S:queue("DroneHiveBigEject")
				U.animation_start(tower, "skillBinSpawn", nil, store.tick_ts, false, 2)
				U.y_wait(store, 0.233)
				local bullet = E:create_entity("bullet_sc_big_drone_spawn")
				bullet.pos = V.v(tower.pos.x - 25, tower.pos.y + 13)
				bullet.bullet.from = V.vclone(bullet.pos)
				bullet.bullet.to = V.vclone(target.pos)
				bullet.bullet.source_id = tower.id
				bullet.level = big_level
				bullet.controller_id = this.id
				queue_insert(store, bullet)
			end
		end
		coroutine.yield()
	end

	clear_mods(aura_mods)
	clear_mods(soldier_aura_mods)
	queue_remove(store, this)
end

scripts.sc_drone_orbital = {}
scripts.sc_drone_orbital_projectile = {}
scripts.sc_big_drone_spawn = {}
scripts.sc_big_drone = {}
scripts.sc_one_shot_fx = {}

function scripts.sc_big_drone_spawn.update(this, store)
	local start_ts = store.tick_ts
	local flight_time = 0.6
	local from = V.vclone(this.bullet.from)
	local to = V.vclone(this.bullet.to)

	while store.tick_ts - start_ts < flight_time do
		local p = km.clamp(0, 1, (store.tick_ts - start_ts) / flight_time)
		this.pos.x = from.x + (to.x - from.x) * p
		this.pos.y = from.y + (to.y - from.y) * p + math.sin(p * math.pi) * 55
		coroutine.yield()
	end

	local tower = store.entities[this.bullet.source_id]
	local rally_pos = tower and tower.barrack and tower.barrack.rally_pos or to
	local big = sc_spawn_reinforcement(store, "soldier_sc_big_drone", to, rally_pos)
	S:queue("DroneHiveBigLand")
	big.soldier.tower_id = this.bullet.source_id
	big.sc_drone_rally_pos = V.vclone(rally_pos)
	big.health.hp_max = ({245, 340})[this.level]
	big.health.hp = big.health.hp_max
	local controller = store.entities[this.controller_id]
	if controller then
		controller.big_id = big.id
		controller.big_spawn_pending = false
	end
	queue_remove(store, this)
end

function scripts.sc_big_drone.update(this, store, script)
	this.health_bar.hidden = true
	U.y_animation_play(this, "shootDron", nil, store.tick_ts, 1)
	this.health_bar.hidden = nil
	this.idle_flip.last_animation = "walk"
	return K45.kr4_soldier_barrack.update(this, store, script)
end

function scripts.sc_one_shot_fx.update(this, store)
	for _, sprite in ipairs(this.render.sprites or {}) do
		if sprite.animated then
			sprite.ts = store.tick_ts
		end
	end

	U.y_wait(store, this.duration or 0.6)
	queue_remove(store, this)
end

function scripts.sc_drone_orbital_projectile.update(this, store)
	local bullet = this.bullet
	local start_ts = store.tick_ts
	local from = V.vclone(this.pos)
	local flight_time = math.max(0.35, V.dist(from.x, from.y, bullet.to.x, bullet.to.y) / 600)

	while store.tick_ts - start_ts < flight_time do
		local target = store.entities[bullet.target_id]

		if target and not target.health.dead then
			bullet.to = V.vclone(target.pos)
		end
		local progress = km.clamp(0, 1, (store.tick_ts - start_ts) / flight_time)
		this.pos.x = from.x + (bullet.to.x - from.x) * progress
		this.pos.y = from.y + (bullet.to.y - from.y) * progress
		coroutine.yield()
	end

	local burst = E:create_entity("aura_sc_drone_orbital")
	burst.pos = V.vclone(bullet.to)
	burst.aura.source_id = bullet.source_id
	burst.target_id = bullet.target_id
	queue_insert(store, burst)
	queue_remove(store, this)
end

function scripts.sc_drone_orbital.update(this, store)
	S:queue("DroneHiveExplosion")
	local source = sc_source_tower(store, this.aura.source_id)
	local damage = 96 * (source and source.tower.damage_factor or 1)
	local target = store.entities[this.target_id]

	if target and target.health and not target.health.dead then
		sc_queue_damage(store, this.aura.source_id, target, damage, DAMAGE_PHYSICAL)
	end
	queue_remove(store, this)
end

scripts.sc_thermal_tower = {}

function scripts.sc_thermal_tower.get_info(this)
	return {
		type = STATS_TYPE_TOWER,
		damage_min = 57,
		damage_max = 57,
		damage_type = DAMAGE_PHYSICAL,
		range = this.attacks.range,
		cooldown = 4
	}
end

function scripts.sc_thermal_tower.update(this, store)
	local attack_ts = store.tick_ts - 4
	local sumo_ts = store.tick_ts
	local mist_ts = store.tick_ts

	while true do
		for _, power in pairs(this.powers) do
			power.changed = nil
		end
		if not this.tower.blocked and store.tick_ts - attack_ts >= 4 then
			local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.attacks.range, false, F_RANGED, F_NIGHTMARE)
			if target then
				attack_ts = store.tick_ts
				S:queue("ThermalblastSpaSkill")
				U.animation_start(this, "baseAttack", nil, store.tick_ts, false, 2)
				U.y_wait(store, 0.35)
				local positions = sc_path_positions(target, 3, 3)

				for _, pos in ipairs(positions) do
					local geyser = E:create_entity("aura_sc_thermal_geyser")
					geyser.pos = pos
					geyser.aura.source_id = this.id
					geyser.aura.level = this.powers.geysers.level
					queue_insert(store, geyser)
					U.y_wait(store, 0.2)
				end
			end
		end

		local sumo_level = this.powers.sumo.level
		if sumo_level > 0 and not this.tower.blocked and store.tick_ts - sumo_ts >= ({15, 13, 11})[sumo_level] then
			local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.attacks.range, false, F_RANGED, bor(F_FLYING, F_NIGHTMARE))

			if target then
				sumo_ts = store.tick_ts
				S:queue("ThermalblastSpaGong")
				local sumo = sc_spawn_reinforcement(store, "soldier_sc_sumo", target.pos, target.pos)
				sumo.health.hp_max = ({160, 240, 320})[sumo_level]
				sumo.health.hp = sumo.health.hp_max
				sumo.melee.attacks[1].damage_min = ({69, 84, 102})[sumo_level]
				sumo.melee.attacks[1].damage_max = ({102, 126, 149})[sumo_level]
				sumo.reinforcement.duration = ({9, 11, 13})[sumo_level]
				local landing = E:create_entity("aura_sc_sumo_landing")
				landing.pos = V.vclone(target.pos)
				landing.aura.source_id = this.id
				queue_insert(store, landing)
			end
		end

		local mist_level = this.powers.mist.level
		if mist_level > 0 and not this.tower.blocked and store.tick_ts - mist_ts >= ({24, 21, 17})[mist_level] then
			local target = sc_find_crowded_enemy(store, this.pos, this.attacks.range, sc_radius(120), F_RANGED, bor(F_FLYING, F_NIGHTMARE))

			if target then
				mist_ts = store.tick_ts
				S:queue("ThermalblastSpaMist")
				for _, pos in ipairs(sc_path_positions(target, 8, 3)) do
					local mist = E:create_entity("aura_sc_thermal_mist")
					mist.pos = pos
					mist.aura.source_id = this.id
					mist.aura.level = mist_level
					queue_insert(store, mist)
				end
			end
		end
		coroutine.yield()
	end
end

scripts.sc_thermal_geyser = {}

function scripts.sc_thermal_geyser.update(this, store)
	-- This effect is created during combat.  Exoskeleton sprites inherit ts=0,
	-- so without an explicit restart a non-looping animation is already on its
	-- final frame (which contains only the falling droplets) when it is drawn.
	U.animation_start(this, "run", nil, store.tick_ts, false, nil, true)

	local level = this.aura.level
	local damage_factor = sc_source_damage_factor(store, this.aura.source_id)
	local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(72), F_AREA, F_NIGHTMARE) or {}
	for _, enemy in pairs(enemies) do
		sc_queue_damage(store, this.aura.source_id, enemy, 57 * damage_factor, DAMAGE_PHYSICAL)
		if level > 0 then
			sc_apply_mod(store, "mod_sc_geyser_dot", this.aura.source_id, enemy.id, level, ({1.5, 3, 4.5})[level])
		end
	end
	local allies = U.find_soldiers_in_range(store.entities, this.pos, 0, sc_radius(72), F_FRIEND, 0) or {}
	for _, ally in pairs(allies) do
		if ally.health and not ally.health.dead then
			ally.health.hp = km.clamp(0, ally.health.hp_max, ally.health.hp + 30)
			signal.emit("health-regen", ally, 30)
		end
	end
	-- Exoskeleton/layer animations do not reliably update the normal sprite
	-- completion counter.  Keep the effect alive for the 52-frame decal instead.
	U.y_wait(store, fts(52))
	queue_remove(store, this)
end

scripts.sc_geyser_dot = {}

function scripts.sc_geyser_dot.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end
	this.modifier.ts = store.tick_ts
	this.tick_ts = store.tick_ts - 0.16
	this.damage = 3 * sc_source_damage_factor(store, this.modifier.source_id)
	this.pos = target.pos
	if this.render then
		this.render.sprites[1].ts = store.tick_ts
	end
	return true
end

function scripts.sc_geyser_dot.update(this, store)
	local target = store.entities[this.modifier.target_id]

	while target and not target.health.dead and store.tick_ts - this.modifier.ts < this.modifier.duration do
		this.pos = target.pos
		if store.tick_ts - this.tick_ts >= 0.16 then
			this.tick_ts = this.tick_ts + 0.16
			sc_queue_damage(store, this.modifier.source_id, target, this.damage, DAMAGE_PHYSICAL)
		end
		coroutine.yield()
		target = store.entities[this.modifier.target_id]
	end
	queue_remove(store, this)
end

scripts.sc_sumo_landing = {}
scripts.sc_sumo = {}

function scripts.sc_sumo.update(this, store, script)
	this.health_bar.hidden = true
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = nil
	this.nav_rally.new = false
	return scripts.soldier_reinforcement.update(this, store, script)
end

function scripts.sc_sumo_landing.update(this, store)
	U.y_wait(store, 0.3)
	S:queue("ThermalblastSpaSumo")
	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(60), F_AREA, bor(F_FLYING, F_BOSS, F_NIGHTMARE)) or {}
	for _, target in pairs(targets) do
		sc_queue_damage(store, this.aura.source_id, target, 80, DAMAGE_PHYSICAL)
		sc_apply_mod(store, "mod_sc_sumo_stun", this.aura.source_id, target.id)
	end
	queue_remove(store, this)
end

scripts.sc_thermal_mist = {}

function scripts.sc_thermal_mist.update(this, store)
	local duration = ({5, 6, 8})[this.aura.level]
	local start_ts = store.tick_ts
	local tick_ts = store.tick_ts - 0.1

	while store.tick_ts - start_ts < duration do
		if store.tick_ts - tick_ts >= 0.1 then
			tick_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(95), F_MOD, bor(F_FLYING, F_BOSS, F_NIGHTMARE)) or {}

			for _, target in pairs(targets) do
				if target.sc_thermal_mist_apply_ts ~= store.tick_ts then
					target.sc_thermal_mist_apply_ts = store.tick_ts
					sc_refresh_or_apply_mod(store, "mod_sc_thermal_slow", this.aura.source_id, target.id, this.aura.level, 0.16)
					sc_refresh_or_apply_mod(store, "mod_sc_thermal_silence", this.aura.source_id, target.id, this.aura.level, 0.16)
				end
			end
		end
		coroutine.yield()
	end
	U.y_animation_play(this, "fadeout", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

scripts.sc_silence = {}

function scripts.sc_silence.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.enemy or target.health.dead then
		return false
	end
	this.previous_can_do_magic = target.enemy.can_do_magic
	this.previous_can_accept_magic = target.enemy.can_accept_magic
	target.enemy.can_do_magic = false
	target.enemy.can_accept_magic = false
	this.modifier.ts = store.tick_ts
	if this.render then
		this.render.sprites[1].ts = store.tick_ts
	end
	return true
end

function scripts.sc_silence.remove(this, store)
	local target = store.entities[this.modifier.target_id]

	if target and target.enemy then
		target.enemy.can_do_magic = this.previous_can_do_magic
		target.enemy.can_accept_magic = this.previous_can_accept_magic
	end
	return true
end

-- Fuhai Temple -------------------------------------------------------------

scripts.sc_fuhai_silence = {}

function scripts.sc_fuhai_silence.insert(this, store)
	local target = store.entities[this.modifier.target_id]

	if not target or not target.vis or not U.flags_pass(target.vis, this.modifier) then
		return false
	end
	return scripts.sc_silence.insert(this, store)
end

scripts.sc_fuhai_temple = {}

function scripts.sc_fuhai_temple.get_info(this)
	return {
		type = STATS_TYPE_TOWER,
		damage_min = math.ceil(this.attacks.damage_min * this.tower.damage_factor),
		damage_max = math.ceil(this.attacks.damage_max * this.tower.damage_factor),
		damage_type = DAMAGE_TRUE,
		range = this.attacks.range,
		cooldown = this.attacks.cooldown
	}
end

function scripts.sc_fuhai_temple.insert(this, store, script)
	this.fuhai_monks = {}
	return scripts.tower_barrack.insert(this, store, script)
end

function scripts.sc_fuhai_temple.remove(this, store, script)
	for _, monk in pairs(this.fuhai_monks or {}) do
		if monk.is_stun and monk.target_stun then
			SU.stun_dec(monk.target_stun)
			monk.is_stun = false
			monk.target_stun = nil
		end
		monk.force_remove = true
		if store.entities[monk.id] then
			queue_remove(store, monk)
		end
	end
	this.fuhai_monks = nil
	return scripts.tower_barrack.remove(this, store, script)
end

function scripts.sc_fuhai_temple.update(this, store)
	local aura_ts = store.tick_ts
	local enemy_cooldowns = {}
	local idle_offsets = {
		v(-25, 32),
		v(25, 32),
		v(-36, 20),
		v(36, 20),
		v(0, 45)
	}

	local function spawn_monk(index)
		local monk = E:create_entity("decal_sc_fuhai_monk")
		local offset = idle_offsets[index]

		monk.owner = this
		monk.owner_sprite_id = 2 + index
		monk.idle_pos = V.vclone(offset)
		monk.pos = V.v(this.pos.x + offset.x, this.pos.y + offset.y)
		monk.attack = this.attacks
		monk.attack_ts = store.tick_ts - this.attacks.cooldown
		monk.render.sprites[1].hidden = true
		queue_insert(store, monk)
		table.insert(this.fuhai_monks, monk)
	end

	spawn_monk(1)
	spawn_monk(2)

	while true do
		local monk_count = 2 + this.powers.monks.level
		local arhat_count = this.powers.arhat.level
		while #this.fuhai_monks < monk_count do
			spawn_monk(#this.fuhai_monks + 1)
		end

		for i = 1, 5 do
			this.render.sprites[2 + i].hidden = i > monk_count
		end

		for name, power in pairs(this.powers) do
			if power.changed then
				power.changed = nil
				if name == "arhat" then
					power.price_inc = power.level >= 2 and 260 or 240
				end
			end
		end

		this.barrack.max_soldiers = arhat_count
		if not this.tower.blocked then
			for i = 1, arhat_count do
				local soldier = this.barrack.soldiers[i]
				if not soldier or soldier.health.dead and not store.entities[soldier.id] then
					soldier = E:create_entity(this.barrack.soldier_type)
					soldier.soldier.tower_id = this.id
					soldier.soldier.tower_soldier_idx = i
					soldier.pos = V.v(this.pos.x + this.barrack.respawn_offset.x, this.pos.y + this.barrack.respawn_offset.y)
					soldier.nav_rally.pos, soldier.nav_rally.center = U.rally_formation_position(i, this.barrack, arhat_count)
					soldier.nav_rally.new = true
					queue_insert(store, soldier)
					this.barrack.soldiers[i] = soldier
					signal.emit("tower-spawn", this, soldier)
				end
			end
		end

		if this.barrack.rally_new then
			this.barrack.rally_new = false
			signal.emit("rally-point-changed", this)
			for i, soldier in ipairs(this.barrack.soldiers) do
				if soldier and soldier.nav_rally then
					soldier.nav_rally.pos, soldier.nav_rally.center = U.rally_formation_position(i, this.barrack, math.max(1, arhat_count), this.barrack.rally_angle_offset)
					soldier.nav_rally.new = true
				end
			end
			S:queue(this.sound_events.change_rally_point)
		end

		local aura_level = this.powers.aura.level
		if aura_level > 0 and store.tick_ts - aura_ts >= 0.1 then
			aura_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(350), F_MOD, bor(F_FLYING, F_NIGHTMARE)) or {}
			for _, target in pairs(targets) do
				sc_refresh_or_apply_mod(store, "mod_sc_fuhai_aura_slow_" .. aura_level, this.id, target.id, aura_level, 0.3)
				sc_refresh_or_apply_mod(store, "mod_sc_fuhai_aura_damage_" .. aura_level, this.id, target.id, aura_level, 0.3)
			end
		end

		if not this.tower.blocked then
			local active_count = 0
			local selected_targets = {}

			for enemy_id, cooldown_ts in pairs(enemy_cooldowns) do
				if cooldown_ts <= store.tick_ts then
					enemy_cooldowns[enemy_id] = nil
				end
			end

			for _, monk in ipairs(this.fuhai_monks) do
				if monk.target_id then
					active_count = active_count + 1
					selected_targets[monk.target_id] = true
				end
			end

			for _, monk in ipairs(this.fuhai_monks) do
				if active_count >= this.attacks.max_targets then
					break
				end
				if not monk.target_id and store.tick_ts - monk.attack_ts >= this.attacks.cooldown then
					local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.attacks.range, false,
						F_RANGED, bor(F_FLYING, F_NIGHTMARE), function(enemy)
							return not selected_targets[enemy.id] and not enemy_cooldowns[enemy.id]
						end)
					if target then
						monk.target_id = target.id
						monk.attack_ts = store.tick_ts
						enemy_cooldowns[target.id] = store.tick_ts + (this.attacks.enemy_cooldown or this.attacks.cooldown)
						selected_targets[target.id] = true
						active_count = active_count + 1
						U.animation_start(this, "out", nil, store.tick_ts, false, monk.owner_sprite_id)
					end
				end
			end
		end
		coroutine.yield()
	end
end

scripts.sc_fuhai_monk = {}

function scripts.sc_fuhai_monk.update(this, store)
	local punch_in = {"punchIn", "kickIn"}
	local punch_out = {"punchOut", "kickOut"}
	this.is_stun = false
	this.target_stun = nil

	local function release_stun()
		if this.is_stun and this.target_stun then
			SU.stun_dec(this.target_stun)
		end
		this.is_stun = false
		this.target_stun = nil
	end

	local function return_to_tower()
		local owner = this.owner
		if owner and store.entities[owner.id] and owner.render and this.owner_sprite_id then
			U.animation_start(owner, "in", nil, store.tick_ts, false, this.owner_sprite_id)
		end
		this.render.sprites[1].hidden = true
		if owner and this.idle_pos then
			this.pos.x = owner.pos.x + this.idle_pos.x
			this.pos.y = owner.pos.y + this.idle_pos.y
		end
		this.target_id = nil
	end

	while not this.force_remove do
		if this.target_id then
			local target = store.entities[this.target_id]
			local owner = this.owner

			if not target or not target.health or target.health.dead or not owner or not store.entities[owner.id] then
				release_stun()
				return_to_tower()
			else
				if target.vis and target.enemy and band(target.vis.bans, F_STUN) == 0 and
					band(target.vis.flags, bor(F_BOSS, F_MINIBOSS)) == 0 and
					(not target.enemy.blockers or #target.enemy.blockers == 0) then
					SU.stun_inc(target)
					this.is_stun = true
					this.target_stun = target
				end

				this.render.sprites[1].hidden = false
				local is_air = target.vis and band(target.vis.flags, F_FLYING) ~= 0
				local action = math.random(1, 2)
				local slot_flip

				if is_air then
					local hit_offset = target.unit and target.unit.hit_offset or V.v(0, 0)
					this.pos.x, this.pos.y = target.pos.x + hit_offset.x, target.pos.y
					this.tween.disabled = false
					this.tween.props[1].disabled = false
					this.tween.props[1].ts = store.tick_ts
					this.tween.props[1].keys[2][2].y = math.max(hit_offset.y - 20, 5)
					U.animation_start(this, "dragonPunchUp", nil, store.tick_ts)
				else
					local slot_pos
					slot_pos, slot_flip = U.melee_slot_position(this, target, 1)
					this.pos.x, this.pos.y = slot_pos.x, slot_pos.y
					U.animation_start(this, punch_in[action], slot_flip, store.tick_ts)
				end

				U.y_wait(store, this.attack_time)
				if store.entities[target.id] and not target.health.dead and store.entities[owner.id] then
					local extra = target.health.hp_max * 0.04
					if target.vis and band(target.vis.flags, bor(F_BOSS, F_MINIBOSS)) ~= 0 then
						extra = math.min(extra, 60)
					end
					sc_queue_damage(store, owner.id, target,
						(math.random(this.attack.damage_min, this.attack.damage_max) + extra) * owner.tower.damage_factor,
						DAMAGE_TRUE)
					sc_refresh_or_apply_mod(store, "mod_sc_fuhai_stun", owner.id, target.id, 0, fts(8))
					sc_refresh_or_apply_mod(store, "mod_sc_fuhai_silence", owner.id, target.id, 0, 2)
					local fx = E:create_entity("fx_sc_fuhai_hit")
					local hit_offset = target.unit and target.unit.hit_offset or V.v(0, 0)
					fx.pos = V.v(target.pos.x + hit_offset.x, target.pos.y + hit_offset.y)
					fx.render.sprites[1].ts = store.tick_ts
					queue_insert(store, fx)
					S:queue("FuhaiAttack")
				end

				if is_air then
					U.animation_start(this, "dragonPunchDown", nil, store.tick_ts)
					U.y_wait(store, fts(5))
					this.tween.disabled = true
					this.tween.props[1].disabled = true
					U.y_animation_play(this, "dragonPunchOut", nil, store.tick_ts)
				else
					U.y_animation_wait(this)
					U.y_animation_play(this, punch_out[action], slot_flip, store.tick_ts)
				end

				release_stun()
				return_to_tower()
			end
		end
		coroutine.yield()
	end

	release_stun()
	if store.entities[this.id] then
		queue_remove(store, this)
	end
end

scripts.sc_fuhai_arhat = {}

function scripts.sc_fuhai_arhat.update(this, store, script)
	this.health_bar.hidden = true
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)
	this.health_bar.hidden = nil
	return scripts.soldier_barrack.update(this, store, script)
end

-- Winter Witch -------------------------------------------------------------

scripts.sc_winter_tower = {}

function scripts.sc_winter_tower.get_info(this)
	local attack = this.attacks.list[1]
	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = math.ceil(attack.damage_min * this.tower.damage_factor),
		damage_max = math.ceil(attack.damage_max * this.tower.damage_factor),
		damage_type = DAMAGE_MAGICAL,
		range = this.attacks.range,
		cooldown = attack.cooldown
	}
end

local function sc_winter_start_cast(this, store, tower_animation)
	if this.tower.level == 4 then
		U.animation_start_group(this, tower_animation, nil, store.tick_ts, false, "winter_tower")
	end
	U.animation_start_group(this, "summon", nil, store.tick_ts, false, "winter_shooter")
end

local function sc_winter_end_cast(this, store)
	if this.tower.level == 4 then
		U.animation_start_group(this, "idle", nil, store.tick_ts, true, "winter_tower")
	end
	U.animation_start_group(this, "idle", nil, store.tick_ts, true, "winter_shooter")
end

local function sc_winter_face_target(this, target)
	local flip_x = target.pos.x < this.pos.x + this.shooter_offset.x
	for _, sprite in pairs(this.render.sprites) do
		if sprite.group == "winter_shooter" then
			sprite.flip_x = flip_x
		end
	end
	return flip_x
end

local function sc_winter_bullet_start(this, attack, flip_x)
	return V.v(
		this.shooter_offset.x + (flip_x and -attack.shoot_offset.x or attack.shoot_offset.x),
		this.shooter_offset.y + attack.shoot_offset.y)
end

function scripts.sc_winter_tower.update(this, store)
	local attack = this.attacks.list[1]
	local attack_ts = store.tick_ts - attack.cooldown
	local attack_count = 0
	local ground_ts = store.tick_ts
	local shield_ts = store.tick_ts
	local tornado_ts = store.tick_ts

	while true do
		if this.powers then
			for name, power in pairs(this.powers) do
				if power.changed then
					power.changed = nil
					if name == "ground" then
						ground_ts = store.tick_ts
						power.price_inc = 210
					elseif name == "shield" then
						shield_ts = store.tick_ts
					elseif name == "tornado" then
						tornado_ts = store.tick_ts
						power.price_inc = 250
					end
				end
			end
		end

		local cast = false
		if this.powers and not this.tower.blocked then
			local ground_level = this.powers.ground.level
			if ground_level > 0 and store.tick_ts - ground_ts >= 9.9 then
				local target = sc_find_crowded_enemy(store, this.pos, sc_radius(333), sc_radius(100), F_RANGED, bor(F_FLYING, F_NIGHTMARE))
				if target then
					ground_ts = store.tick_ts
					cast = true
					sc_winter_start_cast(this, store, "affliction")
					S:queue("WinterGround")
					U.y_wait(store, 0.4)
					for _, pos in ipairs(sc_path_positions(target, 2 + ground_level, 3)) do
						local ground = E:create_entity("aura_sc_winter_ground")
						ground.pos = pos
						ground.aura.source_id = this.id
						ground.aura.level = ground_level
						queue_insert(store, ground)
					end
					sc_winter_end_cast(this, store)
				end
			end

			local shield_level = this.powers.shield.level
			if not cast and shield_level > 0 and store.tick_ts - shield_ts >= 14 then
				local allies = U.find_soldiers_in_range(store.entities, this.pos, 0, sc_radius(333), F_FRIEND, 0) or {}
				local candidates = {}
				for _, ally in pairs(allies) do
					if ally.health and not ally.health.dead and not ally.sc_winter_shield then
						candidates[#candidates + 1] = ally
					end
				end
				table.sort(candidates, function(a, b)
					return a.health.hp / a.health.hp_max < b.health.hp / b.health.hp_max
				end)
				if #candidates > 0 then
					shield_ts = store.tick_ts
					cast = true
					sc_winter_start_cast(this, store, "teleport")
					S:queue("WinterShield")
					U.y_wait(store, 0.4)
					for i = 1, math.min(3, #candidates) do
						sc_apply_mod(store, "mod_sc_winter_shield", this.id, candidates[i].id, shield_level, 7)
					end
					sc_winter_end_cast(this, store)
				end
			end

			local tornado_level = this.powers.tornado.level
			if not cast and tornado_level > 0 and store.tick_ts - tornado_ts >= 22.5 then
				local target = U.find_foremost_enemy(store.entities, this.pos, 0, sc_radius(333), false,
					bor(F_RANGED, F_TWISTER), bor(F_FLYING, F_CLIFF, F_BOSS, F_NIGHTMARE))
				if target and target.nav_path then
					tornado_ts = store.tick_ts
					cast = true
					sc_winter_face_target(this, target)
					sc_winter_start_cast(this, store, "teleport")
					S:queue("WinterTornado")
					U.y_wait(store, 0.7)
					local tornado = E:create_entity("aura_sc_winter_tornado")
					tornado.aura.source_id = this.id
					tornado.aura.level = tornado_level
					tornado.nav_path.pi = target.nav_path.pi
					tornado.nav_path.spi = target.nav_path.spi
					tornado.nav_path.ni = target.nav_path.ni + P:predict_enemy_node_advance(target, true)
					tornado.pos = P:node_pos(tornado.nav_path.pi, tornado.nav_path.spi, tornado.nav_path.ni)
					queue_insert(store, tornado)
					sc_winter_end_cast(this, store)
				end
			end
		end

		if not cast and not this.tower.blocked and store.tick_ts - attack_ts >= attack.cooldown then
			local area = (attack_count + 1) % 3 == 0
			local target
			if area then
				target = sc_find_crowded_enemy(store, tpos(this), this.attacks.range, sc_radius(110), attack.vis_flags, attack.vis_bans)
			else
				target = U.find_nearest_enemy(store.entities, tpos(this), 0, this.attacks.range, attack.vis_flags, attack.vis_bans)
			end
			if target then
				attack_ts = store.tick_ts
				attack_count = attack_count + 1
				local flip_x = sc_winter_face_target(this, target)
				U.animation_start_group(this, "shoot", nil, store.tick_ts, false, "winter_shooter")
				U.y_wait(store, attack.shoot_time)
				if store.entities[target.id] and not target.health.dead then
					local bullet = sc_fire_bullet(store, area and attack.area_bullet or attack.bullet, this, target,
						sc_winter_bullet_start(this, attack, flip_x))
					if area then
						bullet.bullet.to = V.vclone(target.pos)
					end
					bullet.damage_min = attack.damage_min
					bullet.damage_max = attack.damage_max
					bullet.level_index = this.winter_index
					bullet.area = area
					bullet.damage_factor = this.tower.damage_factor
				end
				U.animation_start_group(this, "idle", nil, store.tick_ts, true, "winter_shooter")
			end
		end
		coroutine.yield()
	end
end

scripts.sc_winter_bullet = {}

function scripts.sc_winter_bullet.update(this, store)
	local target = store.entities[this.bullet.target_id]
	local dest = V.vclone(this.bullet.to)
	local start_ts = store.tick_ts
	local arrived = false

	U.animation_start(this, "travel", nil, store.tick_ts, true)
	while not arrived and store.tick_ts - start_ts < 3 do
		if not this.area and (not target or not target.health or target.health.dead) and this.retarget_range > 0 then
			target = U.find_nearest_enemy(store.entities, this.pos, 0, this.retarget_range, F_RANGED, F_NIGHTMARE)
			if target then
				this.bullet.target_id = target.id
			end
		end
		if not this.area and target and target.health and not target.health.dead and target.pos then
			local hit_offset = target.unit and target.unit.hit_offset or V.v(0, 0)
			dest.x, dest.y = target.pos.x + hit_offset.x, target.pos.y + hit_offset.y
		end
		local dx, dy = dest.x - this.pos.x, dest.y - this.pos.y
		local distance = math.sqrt(dx * dx + dy * dy)
		local step = this.speed * store.tick_length
		if distance <= step or distance == 0 then
			this.pos.x, this.pos.y = dest.x, dest.y
			arrived = true
		else
			this.pos.x = this.pos.x + dx / distance * step
			this.pos.y = this.pos.y + dy / distance * step
			this.render.sprites[1].r = V.angleTo(dx, dy)
			coroutine.yield()
			target = store.entities[this.bullet.target_id]
		end
	end

	local targets = {}
	if this.area then
		targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(100), F_AREA, F_NIGHTMARE) or {}
	else
		target = store.entities[this.bullet.target_id]
		if target and target.health and not target.health.dead then
			targets[1] = target
		end
	end

	for _, enemy in pairs(targets) do
		sc_queue_damage(store, this.bullet.source_id, enemy, math.random(this.damage_min, this.damage_max) * (this.damage_factor or 1), DAMAGE_MAGICAL)
		local is_boss = enemy.vis and band(enemy.vis.flags, bor(F_BOSS, F_MINIBOSS)) ~= 0
		local slow_name = "mod_sc_winter_slow_" .. this.level_index
		if is_boss then
			slow_name = "mod_sc_winter_slow_boss_" .. this.level_index
		end
		sc_refresh_or_apply_mod(store, slow_name, this.bullet.source_id, enemy.id, this.level_index, 3)
		if math.random() <= ({0.12, 0.2, 0.28})[this.level_index] then
			sc_refresh_or_apply_mod(store, "mod_sc_winter_freeze", this.bullet.source_id, enemy.id, this.level_index, 2)
		end
	end

	this.render.sprites[1].r = 0
	U.animation_start(this, "hit", nil, store.tick_ts, false)
	if this.area then
		local fx = E:create_entity("fx_sc_winter_area_hit")
		fx.pos = V.v(this.pos.x, this.pos.y + 3)
		queue_insert(store, fx)
	end
	while not U.animation_finished(this) do
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.sc_winter_ground = {}

function scripts.sc_winter_ground.update(this, store)
	local duration = ({2, 3, 4})[this.aura.level]
	local start_ts = store.tick_ts
	local cycle_ts = store.tick_ts - 0.25

	while store.tick_ts - start_ts < duration do
		if store.tick_ts - cycle_ts >= 0.2 then
			cycle_ts = store.tick_ts
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sc_radius(89), F_MOD, bor(F_FLYING, F_NIGHTMARE)) or {}
			for _, target in pairs(targets) do
				sc_refresh_or_apply_mod(store, "mod_sc_winter_ground_slow", this.aura.source_id, target.id, this.aura.level, 0.3)
			end
		end
		coroutine.yield()
	end
	queue_remove(store, this)
end

scripts.sc_winter_shield = {}

function scripts.sc_winter_shield.on_damage(this, store, damage)
	local mod = this.__sc_winter_shield_mod
	local previous_on_damage = this.__sc_winter_shield_on_damage

	if mod and mod.shield_hp and mod.shield_hp > 0 then
		local absorbed = math.min(damage.value or 0, mod.shield_hp)
		mod.shield_hp = mod.shield_hp - absorbed
		damage.value = math.max(0, (damage.value or 0) - absorbed)
		if mod.shield_hp <= 0 then
			mod.broken = true
		end
	end

	if previous_on_damage then
		return previous_on_damage(this, store, damage)
	end
	return true
end

function scripts.sc_winter_shield.insert(this, store)
	local target = store.entities[this.modifier.target_id]
	if not target or not target.health or target.health.dead or target.sc_winter_shield then
		return false
	end

	local previous_on_damage = target.health.on_damage
	if previous_on_damage == scripts.sc_winter_shield.on_damage then
		previous_on_damage = target.__sc_winter_shield_on_damage
	end

	this.shield_hp = 210
	this.modifier.ts = store.tick_ts
	target.sc_winter_shield = this
	target.__sc_winter_shield_mod = this
	target.__sc_winter_shield_on_damage = previous_on_damage
	target.health.on_damage = scripts.sc_winter_shield.on_damage
	local hp_before = target.health.hp
	target.health.hp = math.min(target.health.hp_max, target.health.hp + target.health.hp_max * 0.1)
	this.pos = target.pos
	for _, sprite in pairs(this.render.sprites) do
		sprite.ts = store.tick_ts
	end
	signal.emit("health-regen", target, target.health.hp - hp_before)
	return true
end

function scripts.sc_winter_shield.update(this, store)
	local target = store.entities[this.modifier.target_id]
	U.animation_start_group(this, "in", nil, store.tick_ts, false, "winter_shield")
	U.y_wait(store, fts(24))
	U.animation_start_group(this, "loop", nil, store.tick_ts, true, "winter_shield")

	while target and target.health and not target.health.dead and not this.broken and store.tick_ts - this.modifier.ts < this.modifier.duration do
		this.pos = target.pos
		coroutine.yield()
		target = store.entities[this.modifier.target_id]
	end
	U.animation_start_group(this, "out", nil, store.tick_ts, false, "winter_shield")
	U.y_wait(store, fts(18))
	queue_remove(store, this)
end

function scripts.sc_winter_shield.remove(this, store)
	if this.shield_removed then
		return true
	end
	this.shield_removed = true
	local target = store.entities[this.modifier.target_id]
	if target and target.health and target.__sc_winter_shield_mod == this then
		target.health.on_damage = target.__sc_winter_shield_on_damage
		target.__sc_winter_shield_mod = nil
		target.__sc_winter_shield_on_damage = nil
		if target.sc_winter_shield == this then
			target.sc_winter_shield = nil
		end
	end
	return true
end

scripts.sc_winter_tornado = {}

function scripts.sc_winter_tornado.update(this, store)
	local level = this.aura.level
	local duration = ({5, 6.25, 7.5})[level]
	local damage_per_tick = ({2, 4, 6})[level]
	local enemies_max = this.enemies_max + level * this.enemies_inc
	local np = this.nav_path
	local picked_enemies = {}

	this.picked_enemies = picked_enemies

	U.animation_start(this, "start", nil, store.tick_ts, false)
	while not U.animation_finished(this) do
		coroutine.yield()
	end

	S:queue("ArchmageTwisterTravel")
	U.animation_start(this, "travel", nil, store.tick_ts, true)
	np.ni = km.clamp(P:get_start_node(np.pi), P:get_end_node(np.pi), np.ni)
	local start_ts = store.tick_ts
	local damage_ts = start_ts
	local last_node = P:get_start_node(np.pi) + this.nodes_limit
	local terrains = band(P:path_terrain_types(np.pi), bnot(TERRAIN_CLIFF))

	local function pick_up_enemies()
		if #picked_enemies >= enemies_max then
			return
		end

		local _, enemies = U.find_foremost_enemy(store.entities, this.pos, 0, this.pickup_range, false,
			this.aura.vis_flags, this.aura.vis_bans, function(enemy)
			return enemy.enemy and enemy.enemy.counts and enemy.enemy.valid_terrains and enemy.nav_path and
				(not enemy.enemy.counts.twister or enemy.enemy.counts.twister < this.max_times_applied) and
				band(bnot(enemy.enemy.valid_terrains), terrains) == 0
		end)

		if not enemies then
			return
		end

		for _, enemy in ipairs(enemies) do
			if #picked_enemies >= enemies_max then
				break
			end

			table.insert(picked_enemies, {enemy = enemy, damage_ticks = 0})
			SU.remove_modifiers(store, enemy)
			SU.remove_auras(store, enemy)
			queue_remove(store, enemy)
			enemy.health.dead = true
			enemy.health.last_damage_types = DAMAGE_EAT
			enemy.main_script.co = nil
			enemy.main_script.runs = 0
			U.unblock_all(store, enemy)
			if enemy.ui then
				enemy.ui.can_click = false
			end
			if enemy.count_group then
				enemy.count_group.in_limbo = true
			end
		end
	end

	local function add_winter_damage()
		local elapsed = store.tick_ts - damage_ts
		if elapsed < 0.25 then
			return
		end

		local ticks = math.floor(elapsed / 0.25)
		damage_ts = damage_ts + ticks * 0.25
		for _, picked in ipairs(picked_enemies) do
			picked.damage_ticks = picked.damage_ticks + ticks
		end
	end

	while store.tick_ts - start_ts < duration and last_node < np.ni and
		band(GR:cell_type(this.pos.x, this.pos.y), TERRAIN_CLIFF) == 0 do
		local next_ni = np.ni - 5
		local next_pos = P:node_pos(np.pi, np.spi, next_ni)
		if next_pos and P:is_node_valid(np.pi, next_ni, NF_TWISTER) and
			band(GR:cell_type(next_pos.x, next_pos.y), TERRAIN_CLIFF) == 0 then
			np.ni = next_ni
		end
		np.spi = np.spi == 2 and 3 or 2
		U.set_destination(this, P:node_pos(np.pi, np.spi, np.ni))

		while not this.motion.arrived and store.tick_ts - start_ts < duration do
			U.walk(this, store.tick_length)
			pick_up_enemies()
			add_winter_damage()
			coroutine.yield()
		end
	end

	add_winter_damage()
	for _, picked in ipairs(picked_enemies) do
		local enemy = picked.enemy
		enemy.enemy.counts.twister = (enemy.enemy.counts.twister or 0) + 1
		enemy.nav_path.pi = np.pi
		enemy.nav_path.ni = km.clamp(1, #P:path(np.pi) - 1, math.random(-3, 3) + np.ni)
		enemy.pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni)
		enemy.main_script.runs = 1
		enemy.health.dead = false
		enemy.motion.forced_waypoint = nil
		if enemy.ui then
			enemy.ui.can_click = true
		end
		queue_insert(store, enemy)
	end

	coroutine.yield()
	local damage_value = damage_per_tick * sc_source_damage_factor(store, this.aura.source_id)
	for _, picked in ipairs(picked_enemies) do
		local enemy = picked.enemy
		if store.entities[enemy.id] and not enemy.health.dead then
			for _ = 1, picked.damage_ticks do
				sc_queue_damage(store, this.aura.source_id, enemy, damage_value, DAMAGE_MAGICAL)
			end
		end
	end
	this.picked_enemies = {}

	S:stop("ArchmageTwisterTravel")
	U.animation_start(this, "end", nil, store.tick_ts, false)
	while not U.animation_finished(this) do
		coroutine.yield()
	end
	queue_remove(store, this)
end

return scripts
