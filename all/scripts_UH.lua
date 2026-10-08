local log = require("klua.log"):new("scripts_UH")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot
local km = require("klua.macros")
local signal = require("hump.signal")
local earnings_stats = require("earnings_stats")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local P = require("path_db")
local S = require("sound_db")
local UP = require("upgrades")
local LU = require("level_utils")
local W = require("wave_db")
local U = require("utils")
local V = require("klua.vector")
local game_gui = require("game_gui")
local simulation = require("simulation")
local scripts = require("scripts")
local scripts4 = require("scripts_4")
local scripts5 = require("scripts_5")
local SU5 = require("script_utils_5")
local U5 = require("utils_5")
local SH = require("klove.shader_db")
local utils_UH = require("utils_UH")
local copy = table.deepclone

local ok_rebbborn, scripts_rebbborn = pcall(require, "game_scripts-1-rebbborn")

if ok_rebbborn and scripts_rebbborn.hero_voltaire and not scripts4.hero_voltaire then
	scripts4.hero_voltaire = scripts_rebbborn.hero_voltaire
end

scripts4.hero_voltaire = scripts4.hero_voltaire or {}

local function current_game()
	return require("game")
end

local function current_game_mp()
	local g = current_game()

	if not g.mp then
		g.mp = {
			pos = {},
			button = {},
			istouch = nil
		}
	end

	return g.mp
end

local function create_entity(name)
	if name == "damage" and E.create_damage then
		return E:create_damage()
	end

	return E:create_entity(name)
end

local function T(name)
	return E:get_template(name)
end

local function fts(v)
	return v / FPS
end

local function queue_insert(store, e)
	simulation:queue_insert_entity(e)
end

local function queue_remove(store, e)
	simulation:queue_remove_entity(e)
end

local function queue_damage(store, damage)
	store.damage_queue[#store.damage_queue + 1] = damage
end

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end
local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or
		e.pos
end

local scripts_UH = {}

function scripts_UH:init()
	SU = require("script_utils")
end

function scripts_UH:utils()
	local function is_dying(targets, n, bullet_t, ready_e)
		local store = require("game").store
		local dying = false
		local t = targets[1]
		local damage = 0
		local n = n or 1
		local bullet_table = bullet_t or {}
		local ready_e = ready_e or {}

		-- 若找到下一个目标，并且没有超过 5 次递归
		if targets[2] and n < 5 then
			-- 若没有已筛选出的实体表
			if #bullet_table == 0 or #ready_e == 0 then
				-- 遍历所有实体，筛选出指定实体
				for _, e in pairs(store.entities) do
					-- 筛选子弹实体
					if e.bullet then
						local b = e.bullet

						if b.target_id and b.damage_type and b.damage_min and b.damage_max then
							table.insert(bullet_table, e)
						end

						-- 筛选准备远程攻击的实体
					elseif e.ready_ranged_order_index then
						local i = e.ready_ranged_order_index
						local b = T(e.ranged.attacks[i].bullet).bullet

						if b.damage_type and b.damage_min and b.damage_max then
							table.insert(ready_e, e)
						end
					end
				end
			end

			if bullet_table and #bullet_table > 0 then
				-- 遍历已筛选出的子弹实体表
				for _, e in ipairs(bullet_table) do
					if e.bullet.target_id == t.id then
						local b = e.bullet
						-- 若子弹会秒杀敌人,递归处理下一个目标
						if band(b.damage_type, DAMAGE_EAT, DAMAGE_INSTAKILL) ~= 0 then
							table.remove(targets, 1)

							dying = true

							goto back
							-- 若子弹是基础伤害类型，计算伤害
						elseif band(b.damage_type, DAMAGE_BASE_TYPES) ~= 0 then
							local te = store.entities[t.id]

							local protection = 0

							if band(b.damage_type, DAMAGE_POISON) ~= 0 then
								protection = te.health.poison_armor
							elseif band(b.damage_type, DAMAGE_PHYSICAL) ~= 0 then
								protection = te.health.armor - b.reduce_armor
							elseif band(b.damage_type, DAMAGE_MAGICAL) ~= 0 then
								protection = te.health.magic_armor - b.reduce_magic_armor
							elseif band(b.damage_type, bor(DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)) ~= 0 then
								protection = (te.health.armor - b.reduce_armor) / 2
							elseif band(b.damage_type, DAMAGE_DWAARP) ~= 0 then
								protection = (te.health.armor - b.reduce_armor) / 4
							elseif b.damage_type == DAMAGE_NONE then
								protection = 1
							end

							local rounded_damage = math.random(b.damage_min * 1.5, b.damage_max / 1.5)

							if band(b.damage_type, DAMAGE_MAGICAL) ~= 0 and te.health.damage_factor_magical then
								rounded_damage = km.round(rounded_damage * te.health.damage_factor_magical)
							end

							rounded_damage = km.round(rounded_damage * te.health.damage_factor)

							local actual_damage = math.floor(rounded_damage * km.clamp(0, 1, 1 - protection))

							-- 若目标濒死，递归处理下一个目标
							damage = damage + actual_damage
							if damage >= te.health.hp then
								table.remove(targets, 1)

								dying = true

								goto back
							end
						end
					end
				end
			end

			if ready_e and #ready_e > 0 then
				-- 遍历已筛选出的准备远程攻击的实体表
				for _, e in ipairs(ready_e) do
					if e.ready_ranged_target.id == t.id then
						local i = e.ready_ranged_order_index
						local b = T(e.ranged.attacks[i].bullet).bullet

						-- 若攻击会秒杀敌人,递归处理下一个目标
						if band(b.damage_type, DAMAGE_EAT, DAMAGE_INSTAKILL) ~= 0 then
							table.remove(targets, 1)

							dying = true

							goto back
							-- 若攻击是基础伤害类型，计算伤害
						elseif band(b.damage_type, DAMAGE_BASE_TYPES) ~= 0 then
							local te = store.entities[t.id]

							local protection = 0

							if band(b.damage_type, DAMAGE_POISON) ~= 0 then
								protection = te.health.poison_armor
							elseif band(b.damage_type, DAMAGE_PHYSICAL) ~= 0 then
								protection = te.health.armor - b.reduce_armor
							elseif band(b.damage_type, DAMAGE_MAGICAL) ~= 0 then
								protection = te.health.magic_armor - b.reduce_magic_armor
							elseif band(b.damage_type, bor(DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)) ~= 0 then
								protection = (te.health.armor - b.reduce_armor) / 2
							elseif band(b.damage_type, DAMAGE_DWAARP) ~= 0 then
								protection = (te.health.armor - b.reduce_armor) / 4
							elseif b.damage_type == DAMAGE_NONE then
								protection = 1
							end

							local rounded_damage = math.random(b.damage_min * 1.5, b.damage_max / 1.5)

							if band(b.damage_type, DAMAGE_MAGICAL) ~= 0 and te.health.damage_factor_magical then
								rounded_damage = km.round(rounded_damage * te.health.damage_factor_magical)
							end

							rounded_damage = km.round(rounded_damage * te.health.damage_factor)

							local actual_damage = math.floor(rounded_damage * km.clamp(0, 1, 1 - protection))

							-- 若目标濒死，递归处理下一个目标
							damage = damage + actual_damage
							if damage >= te.health.hp then
								table.remove(targets, 1)

								dying = true

								goto back
							end
						end
					end
				end
			end
		end

		::back::
		if dying then
			return is_dying(targets, n + 1, bullet_table, ready_e)
		else
			return t
		end
	end

	function U.find_nearest_enemy(entities, origin, min_range, max_range, flags, bans, filter_func)
		local targets = U.find_enemies_in_range(entities, origin, min_range, max_range, flags, bans, filter_func)

		if not targets or #targets == 0 then
			return nil
		else
			table.sort(targets, function(e1, e2)
				return V.dist(e1.pos.x, e1.pos.y, origin.x, origin.y) < V.dist(e2.pos.x, e2.pos.y, origin.x, origin.y)
			end)

			return is_dying(targets), targets
		end
	end

	function U.find_foremost_enemy(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func,
								   min_override_flags)
		flags = flags or 0
		bans = bans or 0
		min_override_flags = min_override_flags or 0

		local enemies = {}

		for _, e in pairs(entities) do
			if e.pending_removal or not e.enemy or not e.nav_path or not e.vis or e.health and e.health.dead or band(e.vis.flags, bans) ~= 0 or band(e.vis.bans, flags) ~= 0 or filter_func and not filter_func(e, origin) then
				-- block empty
			else
				local e_pos, e_ni

				if prediction_time and e.motion and e.motion.speed then
					if e.motion.forced_waypoint then
						local dt = prediction_time == true and 1 or prediction_time

						e_pos = V.v(e.pos.x + dt * e.motion.speed.x, e.pos.y + dt * e.motion.speed.y)
						e_ni = e.nav_path.ni
					else
						local node_offset = P:predict_enemy_node_advance(e, prediction_time)

						e_ni = e.nav_path.ni + node_offset
						e_pos = P:node_pos(e.nav_path.pi, e.nav_path.spi, e_ni)
					end
				else
					e_pos = e.pos
					e_ni = e.nav_path.ni
				end

				if U.is_inside_ellipse(e_pos, origin, max_range) and P:is_node_valid(e.nav_path.pi, e_ni) and (min_range == 0 or band(e.vis.flags, min_override_flags) ~= 0 or not U.is_inside_ellipse(e_pos, origin, min_range)) then
					e.__ffe_pos = V.vclone(e_pos)

					table.insert(enemies, e)
				end
			end
		end

		if not enemies or #enemies == 0 then
			return nil, nil
		else
			table.sort(enemies, function(e1, e2)
				local p1 = e1.nav_path
				local p2 = e2.nav_path

				return P:nodes_to_goal(p1.pi, p1.spi, p1.ni) < P:nodes_to_goal(p2.pi, p2.spi, p2.ni)
			end)

			local is_dying = is_dying(enemies)
			return is_dying, enemies, is_dying.__ffe_pos
		end
	end
end

function scripts_UH:script_utils()
	function SU.soldier_pick_ranged_target_and_attack(store, this)
		local in_range = false
		local awaiting_target

		for _, i in pairs(this.ranged.order) do
			local a = this.ranged.attacks[i]

			if a.disabled then
				-- block empty
			elseif a.sync_animation and not this.render.sprites[1].sync_flag then
				-- block empty
			else
				local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range,
					a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

				if target then
					if pred_pos then
						log.paranoid(" target.pos:%s,%s  pred_pos:%s,%s", target.pos.x, target.pos.y, pred_pos.x,
							pred_pos.y)
					end

					local ready = store.tick_ts - a.ts >= a.cooldown

					if this.ranged.forced_cooldown then
						ready = ready and store.tick_ts - this.ranged.forced_ts >= this.ranged.forced_cooldown
					end

					if not ready then
						awaiting_target = target
					elseif math.random() <= a.chance then
						this.ready_ranged_order_index = i
						this.ready_ranged_target = target
						return target, a, pred_pos
					else
						a.ts = store.tick_ts
					end
				end
			end
		end

		return awaiting_target, nil
	end

	function SU.y_soldier_ranged_attacks(store, this)
		local target, attack, pred_pos = SU.soldier_pick_ranged_target_and_attack(store, this)

		if not target then
			return false, A_NO_TARGET
		end

		if not attack then
			return false, A_IN_COOLDOWN
		end

		local start_ts = store.tick_ts
		local attack_done

		U.set_destination(this, this.pos)

		if attack.loops then
			attack_done = SU.y_soldier_do_loopable_ranged_attack(store, this, target, attack)
		else
			attack_done = SU.y_soldier_do_ranged_attack(store, this, target, attack, pred_pos)
		end

		if attack_done then
			attack.ts = start_ts

			if attack.shared_cooldown then
				for _, aa in pairs(this.ranged.attacks) do
					if aa ~= attack and aa.shared_cooldown then
						aa.ts = attack.ts
					end
				end
			end

			if this.ranged.forced_cooldown then
				this.ranged.forced_ts = start_ts
			end
		end

		if attack_done then
			return false, A_DONE
		else
			return true
		end
	end
end

function scripts_UH:scripts()
end

function scripts_UH:enhance1()
	-- 大锤
	function scripts.hero_malik.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_81_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local an, af = U.animation_name_facing_point(this, a.animation, this.pos)

					U.animation_start(this, an, af, store.tick_ts, false)

					S:queue(a.sound)

					if U.y_wait(store, a.spawn_time, function()
							return SU.hero_interrupted(this)
						end) then
						goto label_81_0
					end

					local e = create_entity(a.entity)
					e.pos = V.vclone(this.pos)
					e.tower.default_rally_pos = v(this.pos.x, this.pos.y - 30)

					queue_insert(store, e)

					local fx = create_entity(a.fx)

					fx.pos = V.vclone(this.pos)
					fx.render.sprites[2].ts = store.tick_ts
					fx.tween.ts = store.tick_ts

					queue_insert(store, fx)

					S:stop(a.sound)

					a.disabled = true
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_81_0::

			coroutine.yield()
		end
	end

	-- 波林
	function scripts.hero_bolin.level_up(this, store)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local rf = this.timed_attacks.list[1]
		local b = E:get_template(rf.bullet)

		b.bullet.damage_min = ls.ranged_damage_min[hl]
		b.bullet.damage_max = ls.ranged_damage_max[hl]

		local s, sl

		s = this.hero.skills.tar
		sl = s.xp_level_steps[hl]

		if sl then
			s.level = sl

			local a = this.timed_attacks.list[2]

			a.disabled = nil

			local tar = E:get_template("aura_bolin_tar")

			tar.duration = s.duration[sl]
		end

		s = this.hero.skills.mines
		sl = s.xp_level_steps[hl]

		if sl then
			s.level = sl

			local a = this.timed_attacks.list[3]

			a.disabled = nil

			local m = E:get_template("decal_bolin_mine")

			m.damage_min = s.damage_min[sl]
			m.damage_max = s.damage_max[sl]
		end

		s = this.hero.skills.grenade
		sl = s.xp_level_steps[hl]

		if sl then
			s.level = sl

			local a = this.timed_attacks.list[4]

			a.disabled = nil

			local m = T(a.bullet)

			m.bullet.damage_min = s.damage_min[sl]
			m.bullet.damage_max = s.damage_max[sl]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_bolin.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta
		local shoot_count = 0

		U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_47_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.tar

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range,
						true,
						a.vis_flags, a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.5)
					else
						local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + 5

						if not P:is_node_valid(pi, ni) then
							ni = target.nav_path.ni
						end

						if not P:is_node_valid(pi, ni) then
							SU.delay_attack(store, a, 0.5)
						else
							local start_ts = store.tick_ts
							local flip = target.pos.x < this.pos.x

							U.animation_start(this, "tar", flip, store.tick_ts)
							SU.hero_gain_xp_from_skill(this, skill)

							if U.y_wait(store, a.shoot_time, function()
									return SU.hero_interrupted(this)
								end) then
								-- block empty
							else
								a.ts = start_ts

								local af = this.render.sprites[1].flip_x
								local b = create_entity(a.bullet)
								local o = a.bullet_start_offset

								b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
								b.bullet.to = target and pred_pos
								b.pos = V.vclone(b.bullet.from)
								b.bullet.source_id = this.id

								queue_insert(store, b)

								if not U.y_animation_wait(this) then
									goto label_47_0
								end
							end
						end
					end
				end

				a = this.timed_attacks.list[4]
				skill = this.hero.skills.grenade

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range,
						true, a.vis_flags,
						a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.05)
					else
						U.animation_start(this, "mine", target.pos.x < this.pos.x, store.tick_ts)
						SU.hero_gain_xp_from_skill(this, skill)

						if U.y_wait(store, a.shoot_time, function()
								return SU.hero_interrupted(this)
							end) then
							-- block empty
						else
							a.ts = store.tick_ts

							local af = this.render.sprites[1].flip_x
							local b = create_entity(a.bullet)
							local o = a.bullet_start_offset

							b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
							b.bullet.to = target and pred_pos
							b.pos = V.vclone(b.bullet.from)
							b.bullet.source_id = this.id

							queue_insert(store, b)

							if not U.y_animation_wait(this) then
								goto label_47_0
							end
						end
					end
				end

				a = this.timed_attacks.list[3]
				skill = this.hero.skills.mines

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					local nearest = P:nearest_nodes(this.pos.x, this.pos.y)

					if not nearest or #nearest < 1 then
						SU.delay_attack(store, a, 0.5)
					else
						local pi, spi, ni = unpack(nearest[1])

						spi = math.random(1, 3)

						local no = math.random(a.node_offset[1], a.node_offset[2])

						ni = ni + no

						if not P:is_node_valid(pi, ni) then
							ni = ni - no
						end

						local start_ts = store.tick_ts
						local mine_pos = P:node_pos(pi, spi, ni)
						local flip = mine_pos.x < this.pos.x

						U.animation_start(this, "mine", flip, store.tick_ts)
						SU.hero_gain_xp_from_skill(this, skill)

						if U.y_wait(store, a.shoot_time, function()
								return SU.hero_interrupted(this)
							end) then
							-- block empty
						else
							a.ts = start_ts

							local af = this.render.sprites[1].flip_x
							local b = create_entity(a.bullet)
							local o = a.bullet_start_offset

							b.bullet.from = V.v(this.pos.x + (af and -1 or 1) * o.x, this.pos.y + o.y)
							b.bullet.to = mine_pos
							b.pos = V.vclone(b.bullet.from)
							b.bullet.source_id = this.id

							queue_insert(store, b)

							if not U.y_animation_wait(this) then
								goto label_47_0
							end
						end
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				else
					a = this.timed_attacks.list[1]

					if store.tick_ts - a.ts >= a.cooldown then
						local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range,
							a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

						if not target then
							-- block empty
						else
							local flip = target.pos.x < this.pos.x
							local b, an, af, ai

							an, af, ai = U.animation_name_facing_point(this, a.aim_animation, target.pos)

							U.animation_start(this, an, af, store.tick_ts, 1)
							U.set_destination(this, this.pos)

							for si, st in pairs(a.shoot_times) do
								if U.y_wait(store, a.shoot_times[si], function()
										return SU.hero_interrupted(this)
									end) then
									goto label_47_0
								end

								if not target then
									-- block empty
								end

								local target_dist = V.dist(target.pos.x, target.pos.y, this.pos.x, this.pos.y)

								if si > 1 and (not target or target.health.death or not target_dist or not (target_dist >= a.min_range) or target_dist <= a.max_range or true) then
									target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range,
										a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

									if not target then
										break
									end
								end

								an, af, ai = U.animation_name_facing_point(this, a.shoot_animation, target.pos)

								U.animation_start(this, an, af, store.tick_ts, 1)

								if U.y_wait(store, a.shoot_time, function()
										return SU.hero_interrupted(this)
									end) then
									goto label_47_0
								end

								b = create_entity(a.bullet)
								b.pos = V.vclone(this.pos)

								if a.bullet_start_offset then
									local offset = a.bullet_start_offset[ai]

									b.pos.x, b.pos.y = b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y
								end

								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x,
									target.pos.y + target.unit.hit_offset.y)
								b.bullet.target_id = target.id
								b.bullet.shot_index = si
								b.bullet.source_id = this.id
								b.bullet.xp_dest_id = this.id

								queue_insert(store, b)
							end

							U.y_animation_wait(this)

							a.ts = store.tick_ts

							U.animation_start(this, "reload", nil, store.tick_ts)

							if U.y_animation_wait(this) then
								goto label_47_0
							end
						end
					end

					if SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_47_0::
			coroutine.yield()
		end
	end

	-- 小马哥
	function scripts.hero_magnus.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local ra = this.ranged.attacks[1]
		local b = E:get_template(ra.bullet)

		b.bullet.damage_min = ls.ranged_damage_min[hl]
		b.bullet.damage_max = ls.ranged_damage_max[hl]

		local s, sl

		s = this.hero.skills.mirage
		sl = s.xp_level_steps[hl]

		local a = this.timed_attacks.list[1]

		if sl then
			s.level = sl
			a.disabled = nil
			a.count = s.count[sl]

			local il = E:get_template(a.entity)

			il.level = hl
			il.health.hp_max = ls.hp_max[sl] * s.health_factor
			il.melee.attacks[1].damage_min = math.floor(ls.melee_damage_min[sl] * s.damage_factor)
			il.melee.attacks[1].damage_max = math.floor(ls.melee_damage_max[sl] * s.damage_factor)

			local ira = il.ranged.attacks[1]
			local ib = E:get_template(ira.bullet)

			ib.bullet.damage_min = math.floor(ls.ranged_damage_min[sl] * s.damage_factor)
			ib.bullet.damage_max = math.floor(ls.ranged_damage_max[sl] * s.damage_factor)
		end

		s = this.hero.skills.arcane_rain
		sl = s.xp_level_steps[hl]

		local a = this.timed_attacks.list[2]

		if sl then
			s.level = sl
			a.disabled = nil

			local c = E:get_template(a.entity)

			c.count = s.count[sl]

			local r = E:get_template(c.entity)

			r.damage_min = s.damage[sl]
			r.damage_max = s.damage[sl]
		end

		s = this.hero.skills.mirage_big
		sl = s.xp_level_steps[hl]
		local s_rain = this.hero.skills.mirage_big_arcane_rain
		local a = this.timed_attacks.list[3]

		if sl then
			s.level = sl
			a.disabled = nil
			a.count = s.count[sl]

			local il = T(a.entity)

			il.level = hl
			il.health.hp_max = ls.hp_max[sl] * s.health_factor
			il.melee.attacks[1].damage_min = math.floor(ls.melee_damage_min[sl] * s.damage_factor)
			il.melee.attacks[1].damage_max = math.floor(ls.melee_damage_max[sl] * s.damage_factor)

			local ira = il.ranged.attacks[1]
			local ib = T(ira.bullet)

			ib.bullet.damage_min = math.floor(ls.ranged_damage_min[sl] * s.damage_factor)
			ib.bullet.damage_max = math.floor(ls.ranged_damage_max[sl] * s.damage_factor)

			local ta = this.timed_attacks.list[3]
			local a = T(ta.entity).timed_attacks.list[1]

			a.disabled = nil

			local c = T(a.entity)

			c.count = s_rain.count[sl]

			local r = T(c.entity)

			r.damage_min = s_rain.damage[sl]
			r.damage_max = s_rain.damage[sl]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_magnus.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_75_0
					end
				end

				skill = this.hero.skills.mirage
				a = this.timed_attacks.list[1]

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if U.y_wait(store, a.cast_time, function()
							return SU.hero_interrupted(this)
						end) then
						goto label_75_0
					end

					SU.hero_gain_xp_from_skill(this, skill)

					a.ts = store.tick_ts

					local rotations = a.entity_rotations[a.count]

					for i = 1, a.count do
						local angle = rotations[i]
						local o = V.v(V.rotate(angle, a.initial_pos.x, a.initial_pos.y))
						local r = V.v(V.rotate(angle, a.initial_rally.x, a.initial_rally.y))
						local e = create_entity(a.entity)
						local rx, ry = this.pos.x + r.x, this.pos.y + r.y

						e.nav_rally.center = V.v(rx, ry)
						e.nav_rally.pos = V.v(rx, ry)
						e.pos.x, e.pos.y = this.pos.x + o.x, this.pos.y + o.y
						e.tween.ts = store.tick_ts
						e.tween.props[1].keys[1][2].x = -o.x
						e.tween.props[1].keys[1][2].y = -o.y
						e.render.sprites[1].flip_x = this.render.sprites[1].flip_x
						e.owner = this

						queue_insert(store, e)
					end

					for _, v in pairs(a.entity_rotations) do
						for i, r in pairs(v) do
							v[i] = r + a.rotation_angle
						end
					end

					if not U.y_animation_wait(this) then
						goto label_75_0
					end
				end

				skill = this.hero.skills.arcane_rain
				a = this.timed_attacks.list[2]

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound)

						local flip = target.pos.x < this.pos.x

						U.animation_start(this, a.animation, flip, store.tick_ts)

						if U.y_wait(store, a.cast_time, function()
								return SU.hero_interrupted(this)
							end) then
							goto label_75_0
						end

						SU.hero_gain_xp_from_skill(this, skill)

						a.ts = store.tick_ts

						local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni

						if #target.enemy.blockers == 0 and P:is_node_valid(pi, ni + 5) then
							ni = ni + 5
						end

						local pos = P:node_pos(pi, spi, ni)
						local e = create_entity(a.entity)

						e.pos = pos

						queue_insert(store, e)

						if not U.y_animation_wait(this) then
							goto label_75_0
						end
					end
				end

				skill = this.hero.skills.mirage_big
				a = this.timed_attacks.list[3]

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if U.y_wait(store, a.cast_time, function()
							return SU.hero_interrupted(this)
						end) then
						goto label_75_0
					end

					SU.hero_gain_xp_from_skill(this, skill)

					a.ts = store.tick_ts

					local rotations = a.entity_rotations[a.count]

					for i = 1, a.count do
						local e = create_entity(a.entity)

						e.nav_rally.center = V.v(this.pos.x, this.pos.y)
						e.nav_rally.pos = V.v(this.pos.x, this.pos.y)
						e.pos = v(this.pos.x, this.pos.y)
						e.tween.ts = store.tick_ts
						e.render.sprites[1].flip_x = this.render.sprites[1].flip_x
						e.owner = this

						queue_insert(store, e)
					end

					if not U.y_animation_wait(this) then
						goto label_75_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				else
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_75_0::

			coroutine.yield()
		end
	end

	scripts.soldier_magnus_illusion_big = {}
	function scripts.soldier_magnus_illusion_big.update(this, store, script)
		local brk, stam, star

		this.reinforcement.ts = store.tick_ts
		this.render.sprites[1].ts = store.tick_ts

		if this.reinforcement.fade or this.reinforcement.fade_in then
			SU.y_reinforcement_fade_in(store, this)
		elseif this.render.sprites[1].name == "raise" then
			if this.sound_events and this.sound_events.raise then
				S:queue(this.sound_events.raise)
			end

			this.health_bar.hidden = true

			this.render.sprites[1].prefix = "soldier_magnus_illusion"

			U.y_animation_play(this, "raise", nil, store.tick_ts, 1)

			this.render.sprites[1].prefix = "hero_magnus"
			this.render.sprites[1].name = "idle"

			if not this.health.dead then
				this.health_bar.hidden = nil
			end
		end

		while true do
			if this.health.dead or this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
				if this.health.hp > 0 then
					this.reinforcement.hp_before_timeout = this.health.hp
				end

				this.health.hp = 0

				this.render.sprites[1].prefix = "soldier_magnus_illusion"
				SU.y_soldier_death(store, this)

				return
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				SU.soldier_courage_upgrade(store, this)

				a = this.timed_attacks.list[1]

				if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
					local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						a.ts = store.tick_ts
						S:queue(a.sound)

						local flip = target.pos.x < this.pos.x

						U.animation_start(this, a.animation, flip, store.tick_ts)

						if U.y_wait(store, a.cast_time, function()
								return SU.hero_interrupted(this)
							end) then
							goto label_33_1
						end

						local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni

						if #target.enemy.blockers == 0 and P:is_node_valid(pi, ni + 5) then
							ni = ni + 5
						end

						local pos = P:node_pos(pi, spi, ni)
						local e = create_entity(a.entity)

						e.pos = pos

						queue_insert(store, e)

						if not U.y_animation_wait(this) then
							goto label_33_1
						end
					end
				end

				if this.melee then
					brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

					if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
						goto label_33_1
					end
				end

				if this.ranged then
					brk, star = SU.y_soldier_ranged_attacks(store, this)

					if brk or star == A_DONE then
						goto label_33_1
					elseif star == A_IN_COOLDOWN then
						goto label_33_0
					end
				end

				if this.melee.continue_in_cooldown and stam == A_IN_COOLDOWN then
					goto label_33_1
				end

				if SU.soldier_go_back_step(store, this) then
					goto label_33_1
				end

				::label_33_0::

				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end

			::label_33_1::

			coroutine.yield()
		end
	end

	-- 火男
	function scripts.hero_ignus.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta, target, attack_done

		U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		local aura = create_entity(this.particles_aura)

		aura.aura.source_id = this.id

		queue_insert(store, aura)

		local ps = create_entity(this.run_particles_name)

		ps.particle_system.track_id = this.id
		ps.particle_system.emit = false

		queue_insert(store, ps)

		while true do
			ps.particle_system.emit = false

			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					ps.particle_system.emit = true

					if SU.y_hero_new_rally(store, this) then
						goto label_71_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or h.dead then
					-- block empty
				else
					a = this.timed_attacks.list[2]
					skill = this.hero.skills.surge_of_flame

					if sta ~= A_NO_TARGET and not a.disabled and store.tick_ts - a.ts >= a.cooldown then
						local target = U.find_first_target(store.entities, this.pos, a.min_range, a.max_range,
							a.vis_flags, a.vis_bans, function(e)
								if not e.enemy or not e.nav_path or not e.nav_path.pi then
									return false
								end

								local ps, pe = P:get_visible_start_node(e.nav_path.pi),
									P:get_visible_end_node(e.nav_path.pi)

								return (#e.enemy.blockers or 0) == 0 and e.nav_path.ni > ps + a.nodes_margin and
									e.nav_path.ni < pe - a.nodes_margin
							end)

						if not target then
							-- block empty
						else
							U.unblock_target(store, this)
							U.block_enemy(store, this, target)
							SU.hero_gain_xp_from_skill(this, skill)

							local slot_pos, slot_flip = U.melee_slot_position(this, target, 1)
							local vis_bans = this.vis.bans

							this.vis.bans = F_ALL
							this.health.ignore_damage = true
							this.motion.max_speed = this.motion.max_speed * a.speed_factor

							U.set_destination(this, slot_pos)
							S:queue(a.sound)
							U.y_animation_play(this, a.animations[1], nil, store.tick_ts)

							local aura = create_entity(a.aura)

							aura.aura.source_id = this.id

							queue_insert(store, aura)

							while not this.motion.arrived do
								U.walk(this, store.tick_length, nil, true)
								coroutine.yield()
							end

							this.nav_rally.center = V.vclone(this.pos)
							this.nav_rally.pos = V.vclone(this.pos)

							S:queue(a.sound_end)
							U.y_animation_play(this, a.animations[2], nil, store.tick_ts)

							a.ts = store.tick_ts
							this.vis.bans = vis_bans
							this.health.ignore_damage = nil
							this.motion.max_speed = this.motion.max_speed / a.speed_factor

							goto label_71_0
						end
					end

					a = this.timed_attacks.list[1]
					skill = this.hero.skills.flaming_frenzy

					if sta ~= A_NO_TARGET and not a.disabled and store.tick_ts - a.ts >= a.cooldown then
						if U.frandom(0, 1) >= a.chance then
							goto label_71_0
						end

						local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
							a.vis_bans)

						if not targets then
							-- block empty
						else
							local start_ts = store.tick_ts
							local flip = targets[1].pos.x < this.pos.x

							U.animation_start(this, a.animation, flip, store.tick_ts)
							S:queue(a.sound)

							if U.y_wait(store, a.cast_time, function()
									return SU.hero_interrupted(this)
								end) then
								goto label_71_0
							end

							SU.hero_gain_xp_from_skill(this, skill)

							a.ts = start_ts
							targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
								a.vis_bans)

							if targets then
								for _, t in pairs(targets) do
									local fx = create_entity(a.hit_fx)

									fx.pos = V.vclone(t.pos)

									if t.unit and t.unit.mod_offset then
										fx.pos.x, fx.pos.y = fx.pos.x + t.unit.mod_offset.x,
											fx.pos.y + t.unit.mod_offset.y
									end

									for i = 1, #fx.render.sprites do
										fx.render.sprites[i].ts = store.tick_ts
									end

									queue_insert(store, fx)

									local d = create_entity("damage")

									d.damage_type = a.damage_type
									d.source_id = this.id
									d.target_id = t.id
									d.value = math.random(a.damage_min, a.damage_max)

									queue_damage(store, d)

									local mod = create_entity(this.timed_attacks.list[1].mod)

									-- mod.modifier.source_id = this.id
									mod.modifier.target_id = t.id

									queue_insert(store, mod)
								end
							end

							this.health.hp = this.health.hp + this.health.hp_max * a.heal_factor
							this.health.hp = km.clamp(0, this.health.hp_max, this.health.hp)

							local e = create_entity(a.decal)

							e.pos = V.vclone(this.pos)
							e.render.sprites[1].ts = store.tick_ts

							queue_insert(store, e)

							if not U.y_animation_wait(this) then
								-- block empty
							end

							goto label_71_0
						end
					end

					if sta ~= A_NO_TARGET then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_71_0::

			coroutine.yield()
		end
	end

	function scripts.aura_ignus_surge_of_flame.update(this, store)
		local source = store.entities[this.aura.source_id]
		if not source then
			queue_remove(store, this)

			return
		end

		this.pos = source.pos

		local s = source.render.sprites[1]
		local ps = create_entity(this.particles_name)

		ps.particle_system.track_id = source.id
		ps.particle_system.emit = true

		queue_insert(store, ps)

		local a = this.aura
		local ts = 0
		local targets

		while s.name == this.damage_state do
			if store.tick_ts - ts + 1e-09 <= a.cycle_time then
				-- block empty
			else
				targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius, a.damage_flags or 0,
					a.damage_bans or 0) or {}
				ts = store.tick_ts

				for _, t in pairs(targets) do
					local d = create_entity("damage")

					d.damage_type = a.damage_type
					d.source_id = this.id
					d.target_id = t.id
					d.value = math.random(a.damage_min, a.damage_max)

					queue_damage(store, d)

					local fx = create_entity(a.hit_fx)

					fx.pos = V.vclone(t.pos)

					if t.unit and t.unit.mod_offset then
						fx.pos.x, fx.pos.y = fx.pos.x + t.unit.mod_offset.x, fx.pos.y + t.unit.mod_offset.y
					end

					for i = 1, #fx.render.sprites do
						fx.render.sprites[i].ts = store.tick_ts
					end

					queue_insert(store, fx)

					local mod = create_entity(this.aura.mod)

					mod.modifier.source_id = this.id
					mod.modifier.target_id = t.id

					queue_insert(store, mod)
				end
			end

			coroutine.yield()
		end
		ps.particle_system.emit = false

		queue_remove(store, this)
	end

	-- 迪纳斯
	function scripts.hero_denas.insert(this, store)
		this.hero.fn_level_up(this, store, true)

		for _, t in pairs(E:filter_templates("tower")) do
			t.tower.price = km.clamp(0, t.tower.price, t.tower.price - this.sale)
		end

		return true
	end

	-- 钢锯
	function scripts.hero_hacksaw.fn_can_timber(this, store, a, target)
		return target.health.hp >= a.trigger_min_hp
	end

	-- 鬼侍
	function scripts.hero_oni.fn_can_death_strike_instakill(this, store, a, target)
		return target.health.hp >= a.trigger_min_hp and target.health.hp <= a.trigger_instakill_max_hp
	end

	function scripts.hero_oni.fn_can_death_strike(this, store, a, target)
		return target.health.hp >= a.trigger_min_hp
	end

	-- 电击手
	function scripts4.hero_voltaire.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local s, l, a, y

		s = this.hero.skills.toss
		l = s.xp_level_steps[hl]
		a = this.ranged.attacks[1]
		a_2 = this.ranged.attacks[2]
		y = E:get_template("b_volt")

		if l then
			s.level = l
			a.disabled = nil
			a.cooldown = s.cooldown[l]
			a_2.disabled = nil
			y.bullet.damage_max = s.damage_max[l]
			y.bullet.damage_min = s.damage_min[l]
			y.bullet.xp_gain_factor = s.xp_gain[l]
			y.bullet.damage_radius = s.radius[l]
			E:get_template(y.bullet.mod).modifier.duration = s.stun_duration[l]
			local r = y.bullet.damage_radius / 40
			E:get_template(y.bullet.hit_fx).render.sprites[1].scale = v(r, r)
		end

		s = this.hero.skills.tesla
		l = s.xp_level_steps[hl]
		a = this.timed_attacks.list[1]
		y = E:get_template("mini_tesla")

		if l then
			s.level = sl
			a.disabled = nil
			y.attack_count = s.attack_count[l]
		end

		this.health.hp = this.health.hp_max
	end
end

function scripts_UH:enhance2()
	-- 沙王
	function scripts.hero_alric.insert(this, store, script)
		this.hero.fn_level_up(this, store, true)

		this.melee.order = U.attack_order(this.melee.attacks)

		if this.hero.skills.toughness.level > 0 then
			local aura = create_entity("death_rider_aura_alric")

			aura.aura.source_id = this.id

			queue_insert(store, aura)
		end

		return true
	end

	function scripts.hero_alric.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		for i = 1, 3 do
			this.melee.attacks[i].damage_min = ls.melee_damage_min[hl]
			this.melee.attacks[i].damage_max = ls.melee_damage_max[hl]
		end

		local s

		s = this.hero.skills.swordsmanship

		if s.level > 0 then
			for i = 1, 3 do
				this.melee.attacks[i].damage_min = this.melee.attacks[i].damage_min + s.extra_damage[s.level]
				this.melee.attacks[i].damage_max = this.melee.attacks[i].damage_max + s.extra_damage[s.level]
			end
		end

		s = this.hero.skills.spikedarmor

		if initial and s.level > 0 then
			this.health.spiked_armor = s.values[s.level]
		end

		s = this.hero.skills.toughness

		if s.level > 0 then
			this.health.hp_max = this.health.hp_max + s.hp_max[s.level]
			this.regen.health = this.regen.health + s.regen[s.level]
		end

		s = this.hero.skills.flurry

		if initial and s.level > 0 then
			this.melee.attacks[3].disabled = nil
			this.melee.attacks[3].cooldown = s.cooldown[s.level]
			this.melee.attacks[3].loops = s.loops[s.level]
		end

		s = this.hero.skills.sandwarriors

		if initial and s.level > 0 then
			this.timed_attacks.list[1].disabled = nil

			local e = E:get_template(this.timed_attacks.list[1].entity)

			e.lifespan.duration = s.lifespan[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	-- 船长
	function scripts.hero_pirate.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local bt = E:get_template(this.ranged.attacks[1].bullet)

		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]

		local s

		s = this.hero.skills.swordsmanship

		if s.level > 0 then
			for i = 1, #this.melee.attacks do
				local ma = this.melee.attacks[i]

				ma.damage_min = ma.damage_min + s.extra_damage[s.level]
				ma.damage_max = ma.damage_max + s.extra_damage[s.level]
			end
		end

		s = this.hero.skills.looting

		if initial and s.level > 0 then
			local m = E:get_template("mod_pirate_loot")

			m.percent = s.percent[s.level]

			T("mod_pirate_loot_c").extra_gold = s.mod_extra_gold[s.level]
		end

		s = this.hero.skills.kraken

		if initial and s.level > 0 then
			this.timed_attacks.list[1].disabled = false

			local ka = E:get_template("kraken_aura")

			ka.max_active_targets = s.max_enemies[s.level]

			local m = E:get_template("mod_slow_kraken")

			m.slow.factor = s.slow_factor[s.level]
		end

		s = this.hero.skills.scattershot

		if initial and s.level > 0 then
			this.timed_attacks.list[2].disabled = false

			local barrel = E:get_template("pirate_exploding_barrel")

			barrel.fragments = s.fragments[s.level]

			local bf = E:get_template("barrel_fragment")

			bf.bullet.damage_min = s.fragment_damage[s.level]
			bf.bullet.damage_max = bf.bullet.damage_min
		end

		s = this.hero.skills.toughness

		if s.level > 0 then
			this.health.hp_max = this.health.hp_max + s.hp_max[s.level]
			this.regen.health = this.regen.health + s.regen[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.mod_pirate_loot.update(this, store)
		local m = this.modifier
		this.modifier.ts = store.tick_ts

		while true do
			local target = store.entities[m.target_id]

			if not target or m.duration >= 0 and store.tick_ts - m.ts > m.duration or not target.pos then
				queue_remove(store, this)
			else
				this.pos = target.pos

				if target.health and target.enemy and target.health.dead and (target.enemy.gold or 0) > 0 then
					local fx = create_entity("fx_coin_jump")

					fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
					fx.render.sprites[1].ts = store.tick_ts

					if target.health_bar then
						fx.render.sprites[1].offset.y = target.health_bar.offset.y
					end

					queue_insert(store, fx)
					queue_remove(store, this)
				end

				if this.render and target.unit and target.enemy and (target.enemy.gold or 0) > 0 then
					local s = this.render.sprites[1]
					local flip_sign = 1

					if target.render then
						flip_sign = target.render.sprites[1].flip_x and -1 or 1
					end

					if m.health_bar_offset and target.health_bar then
						local hb = target.health_bar.offset
						local hbo = m.health_bar_offset

						s.offset.x, s.offset.y = hb.x + hbo.x * flip_sign, hb.y + hbo.y
					elseif m.use_mod_offset and target.unit.mod_offset then
						s.offset.x, s.offset.y = target.unit.mod_offset.x * flip_sign, target.unit.mod_offset.y
					end
				end
			end

			coroutine.yield()
		end
	end

	function scripts.mod_pirate_loot.remove(this, store)
		local target = store.entities[this.modifier.target_id]

		if target and target.enemy and target.health and not target.health.dead and target.enemy.gold then
			target.enemy.gold = km.clamp(0, target.enemy.gold, target.enemy.gold - this.extra_loot)
			earnings_stats.adjust_enemy_bonus(target, "hero_pirate", -this.extra_loot)
		end

		return true
	end

	scripts.mod_pirate_loot_c = {}

	function scripts.mod_pirate_loot_c.insert(this, store)
		local target = store.entities[this.modifier.target_id]

		if not target or not target.health or target.health.dead then
			return false
		end

		target.enemy.gold = target.enemy.gold + this.extra_gold
		earnings_stats.adjust_enemy_bonus(target, "hero_pirate", this.extra_gold)

		return true
	end

	function scripts.mod_pirate_loot_c.update(this, store)
		local m = this.modifier
		this.modifier.ts = store.tick_ts

		while true do
			local target = store.entities[m.target_id]

			if not target or not target.pos then
				queue_remove(store, this)
			else
				this.pos = target.pos

				if target.health and target.health.dead then
					local fx = create_entity("fx_coin_jump")

					fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
					fx.render.sprites[1].ts = store.tick_ts

					if target.health_bar then
						fx.render.sprites[1].offset.y = target.health_bar.offset.y
					end

					queue_insert(store, fx)
					queue_remove(store, this)
				end

				if this.render and target.unit then
					local s = this.render.sprites[1]
					local flip_sign = 1

					if target.render then
						flip_sign = target.render.sprites[1].flip_x and -1 or 1
					end

					if m.health_bar_offset and target.health_bar then
						local hb = target.health_bar.offset
						local hbo = m.health_bar_offset

						s.offset.x, s.offset.y = hb.x + hbo.x * flip_sign, hb.y + hbo.y
					elseif m.use_mod_offset and target.unit.mod_offset then
						s.offset.x, s.offset.y = target.unit.mod_offset.x * flip_sign, target.unit.mod_offset.y
					end
				end
			end

			coroutine.yield()
		end
	end

	-- 兽王
	function scripts.beastmaster_falcon.update(this, store)
		local sf = this.render.sprites[1]
		local h = this.owner
		local fm = this.force_motion
		local ca = this.custom_attack

		sf.offset.y = this.flight_height

		U.y_animation_play(this, "respawn", nil, store.tick_ts)
		U.animation_start(this, "idle", nil, store.tick_ts, true)

		while true do
			if h.health.dead then
				U.y_animation_play(this, "death", nil, store.tick_ts)
				queue_remove(store, this)

				return
			end

			if store.tick_ts - ca.ts > ca.cooldown then
				local target = U.find_nearest_enemy(store.entities, this.pos, ca.min_range, ca.max_range, ca.vis_flags,
					ca.vis_bans)

				if not target then
					SU.delay_attack(store, ca, 0.13333333333333333)
				else
					S:queue(ca.sound)
					U.animation_start(this, "attack_fly", af, store.tick_ts, false)

					local accel = 180
					local max_speed = 300
					local min_speed = 60
					local mspeed = min_speed
					local dist = V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)
					local start_dist = dist
					local start_h = sf.offset.y
					local target_h = target.unit.hit_offset.y

					while dist > mspeed * store.tick_length and not target.health.dead do
						local tx, ty = target.pos.x, target.pos.y
						local dx, dy = V.mul(mspeed * store.tick_length,
							V.normalize(V.sub(tx, ty, this.pos.x, this.pos.y)))

						this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, dx, dy)
						sf.offset.y = km.clamp(0, this.flight_height * 1.5,
							start_h + (target_h - start_h) * (1 - dist / start_dist))
						sf.flip_x = dx < 0

						coroutine.yield()

						dist = V.dist(this.pos.x, this.pos.y, target.pos.x, target.pos.y)
						mspeed = km.clamp(min_speed, max_speed, mspeed + accel * store.tick_length)
					end

					if target.health.dead then
						ca.ts = store.tick_ts
					else
						this.pos.x, this.pos.y = target.pos.x, target.pos.y - 1

						local d = create_entity("damage")

						d.source_id = this.id
						d.target_id = target.id
						d.value = math.random(ca.damage_min, ca.damage_max)
						d.damage_type = ca.damage_type
						d.xp_gain_factor = ca.xp_gain_factor
						d.xp_dest_id = h.id

						queue_damage(store, d)
						U.y_animation_play(this, "attack_hit", nil, store.tick_ts, 1)

						local mod = create_entity(this.custom_attack.mod)

						mod.modifier.source_id = this.id
						mod.modifier.target_id = target.id

						queue_insert(store, mod)

						ca.ts = store.tick_ts
					end
				end
			end

			U.animation_start(this, "idle", nil, store.tick_ts, true)

			local dx, dy = V.sub(h.pos.x, h.pos.y, this.pos.x, this.pos.y)

			if V.len(dx, dy) > 50 then
				fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(1440, V.mul(4, dx, dy)))
			end

			if V.len(fm.a.x, fm.a.y) > 1 then
				fm.v.x, fm.v.y = V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y))
				fm.a.x, fm.a.y = 0, 0
			else
				fm.v.x, fm.v.y = 0, 0
				fm.a.x, fm.a.y = 0, 0
			end

			this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, V.mul(store.tick_length, fm.v.x, fm.v.y))
			fm.a.x, fm.a.y = V.trim(1800, V.mul(-0.75, fm.v.x, fm.v.y))
			sf.offset.y = km.clamp(0, this.flight_height, sf.offset.y + this.flight_speed * store.tick_length)
			sf.flip_x = fm.v.x < 0

			coroutine.yield()
		end
	end

	-- 大法师
	function scripts.hero_wizard.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local m = E:get_template("mod_ray_wizard")

		m.damage_max = ls.ranged_damage_max[hl]
		m.damage_min = ls.ranged_damage_min[hl]

		local s

		s = this.hero.skills.magicmissile

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[2]

			a.disabled = nil
			a.loops = s.count[s.level]

			local b = E:get_template("missile_wizard")

			b.bullet.damage_max = s.damage[s.level]
			b.bullet.damage_min = s.damage[s.level]
		end

		s = this.hero.skills.chainspell

		if initial and s.level > 0 then
			local a = this.ranged.attacks[2]

			a.disabled = nil

			local b = E:get_template("ray_wizard_chain")

			b.bounces = s.bounces[s.level]
		end

		s = this.hero.skills.disintegrate

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.total_damage = s.total_damage[s.level]
			a.count = s.count[s.level]

			if store then
				a.ts = store.tick_ts
			end

			local a = this.timed_attacks.list[3]

			a.disabled = nil

			local twister = T(a.entity)

			twister.enemies_max = s.twister_enemies_max[s.level]
		end

		s = this.hero.skills.arcanereach

		if initial and s.level > 0 then
			local factor = 1 + s.extra_range_factor[s.level]

			this.ranged.attacks[1].max_range = this.ranged.attacks[1].max_range * factor
			this.ranged.attacks[2].max_range = this.ranged.attacks[2].max_range * factor

			this.timed_attacks.list[2].max_range = this.timed_attacks.list[2].max_range * factor

			this.timed_attacks.list[1].max_range = this.timed_attacks.list[1].max_range * factor
			this.timed_attacks.list[3].max_range = this.timed_attacks.list[3].max_range * factor
		end

		s = this.hero.skills.arcanefocus

		if s.level > 0 then
			local extra = s.extra_damage[s.level]
			local m = E:get_template("mod_ray_wizard")

			m.damage_max = m.damage_max + extra
			m.damage_min = m.damage_min + extra
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_wizard.update(this, store, script)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_302_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.disintegrate

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local triggers = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
						a.vis_bans, function(v)
							return v.health.hp <= a.total_damage
						end)

					if not triggers then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius, a
							.vis_flags, a.vis_bans, function(v)
								return v.health.hp <= a.total_damage
							end)

						if not targets then
							SU.delay_attack(store, a, 0.13333333333333333)

							goto label_302_0
						end

						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)
						S:queue(a.sound)
						U.animation_start(this, a.animation, nil, store.tick_ts)
						U.y_wait(store, a.hit_time)

						local remaining_damage = a.total_damage
						local count = a.count

						for _, t in pairs(targets) do
							if remaining_damage <= 0 or count == 0 then
								break
							end

							if remaining_damage >= t.health.hp then
								remaining_damage = remaining_damage - t.health.hp
								count = count - 1

								local d = create_entity("damage")

								d.damage_type = DAMAGE_EAT
								d.target_id = t.id
								d.source_id = this.id

								queue_damage(store, d)

								local fx = create_entity("fx_wizard_disintegrate")

								fx.pos.x, fx.pos.y = t.pos.x + t.unit.hit_offset.x, t.pos.y + t.unit.hit_offset.y
								fx.render.sprites[1].ts = store.tick_ts

								queue_insert(store, fx)
							end
						end

						U.y_animation_wait(this)

						goto label_302_0
					end
				end

				a = this.timed_attacks.list[3]
				skill = this.hero.skills.disintegrate

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range,
						a.node_prediction, a.vis_flags, a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)
						S:queue(a.sound)

						U.animation_start(this, a.animation, nil, store.tick_ts)
						U.y_wait(store, a.spawn_time)

						local twister = create_entity(a.entity)
						local np = twister.nav_path

						np.pi = target.nav_path.pi
						np.spi = target.nav_path.spi
						np.ni = target.nav_path.ni + P:predict_enemy_node_advance(target, true)
						twister.pos = P:node_pos(np.pi, np.spi, np.ni)

						queue_insert(store, twister)

						U.y_animation_wait(this)

						goto label_302_0
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.magicmissile

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false,
						a.vis_flags, a.vis_bans)

					if target then
						local start_ts = store.tick_ts

						if SU.y_soldier_do_loopable_ranged_attack(store, this, target, a) then
							a.ts = start_ts

							SU.hero_gain_xp_from_skill(this, skill)
						end

						goto label_302_0
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or U.is_blocked_valid(store, this) then
					-- block empty
				else
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_302_0::

			coroutine.yield()
		end
	end

	-- 沙塔
	function scripts.hero_alien.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local s

		s = this.hero.skills.energyglaive

		if initial and s.level > 0 then
			local a = this.ranged.attacks[1]

			a.disabled = nil

			local b = E:get_template(a.bullet)

			b.bullet.damage_min = s.damage[s.level]
			b.bullet.damage_max = s.damage[s.level]
			b.bounce_chance = s.bounce_chance[s.level]
		end

		s = this.hero.skills.purificationprotocol

		if initial and s.level > 0 then
			local a = this.auras.list[1]

			local e = T(a.aura)

			e.aura.damage = s.damage[s.level]
		end

		s = this.hero.skills.abduction

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil

			a.total_hp = s.total_hp[s.level]
			a.total_targets = s.total_targets[s.level]
		end

		s = this.hero.skills.vibroblades

		if s.level > 0 then
			local a = this.melee.attacks[1]

			a.damage_min = a.damage_min + s.extra_damage[s.level]
			a.damage_max = a.damage_max + s.extra_damage[s.level]
			a.damage_type = s.damage_type
		end

		s = this.hero.skills.finalcountdown

		if initial and s.level > 0 then
			this.selfdestruct.disabled = nil
			this.selfdestruct.damage = s.damage[s.level]
		end

		this.health.hp = this.health.hp_max
		this.ranged.attacks[1].ts = -this.ranged.attacks[1].cooldown
		this.timed_attacks.list[1].ts = -this.timed_attacks.list[1].cooldown
		this.timed_attacks.list[2].ts = -this.timed_attacks.list[2].cooldown
	end

	function scripts.hero_alien.insert(this, store, script)
		this.hero.fn_level_up(this, store, true)

		this.melee.order = U.attack_order(this.melee.attacks)
		this.ranged.order = U.attack_order(this.ranged.attacks)

		if this.hero.skills.purificationprotocol.level > 0 then
			local e = create_entity(this.auras.list[1].aura)
			e.aura.source_id = this.id
			e.ts = store.tick_ts

			queue_insert(store, e)
		end

		return true
	end

	function scripts.hero_alien.update(this, store, script)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_329_1
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				::label_329_0::

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.purificationprotocol

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target = U.find_random_enemy(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound)
						U.animation_start(this, a.animation, nil, store.tick_ts)

						if U.y_wait(store, a.spawn_time, function()
								return SU.hero_interrupted(this)
							end) then
							-- block empty
						else
							a.ts = store.tick_ts - a.spawn_time

							SU.hero_gain_xp_from_skill(this, skill)

							local e = create_entity(a.entity)

							e.pos = V.vclone(target.pos)
							e.target_id = target.id

							queue_insert(store, e)

							e.owner = this

							U.y_animation_wait(this)

							goto label_329_1
						end
					end
				end

				brk, sta = SU.y_soldier_ranged_attacks(store, this)

				if brk then
					-- block empty
				else
					brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

					if brk or sta ~= A_NO_TARGET then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_329_1::

			coroutine.yield()
		end
	end

	scripts.alien_purification_drone_cursor_aura = {}

	function scripts.alien_purification_drone_cursor_aura.update(this, store)
		local sid = 2
		local attacking
		local h = store.entities[this.aura.source_id]
		local mp = current_game_mp().button
		this.pos = h.pos
		local aura = this.aura
		local offset = this.offset

		S:queue(this.sound_events.insert)
		U.y_animation_play(this, "appear_long", nil, store.tick_ts, 1, sid)
		U.animation_start(this, "idle", nil, store.tick_ts, true, sid)

		S:stop(this.sound_events.insert)

		while true do
			local x, y = game_gui.window:get_mouse_position()
			x, y = game_gui.window:screen_to_view(x, y)
			local wx, wy = game_gui:u2g(v(x, y))

			this.pos = v(wx, wy)

			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, aura.radius, aura.vis_flags,
				aura.vis_bans)

			if targets then
				if not attacking then
					attacking = true
					this.render.sprites[1].hidden = false
					this.render.sprites[3].hidden = false
					S:queue(this.sound_events.loop)
				end

				if store.tick_ts - this.ts > aura.cycle_time then
					this.ts = store.tick_ts
					for _, t in pairs(targets) do
						local d = create_entity("damage")

						d.source_id = this.id
						d.target_id = t.id
						d.value = aura.damage
						d.damage_type = aura.damage_type

						queue_damage(store, d)
					end
				end
			elseif attacking then
				attacking = nil
				S:stop(this.sound_events.loop)
				this.render.sprites[1].hidden = true
				this.render.sprites[3].hidden = true
			end

			a = h.timed_attacks.list[1]
			skill = h.hero.skills.abduction

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				for i = 1, 3 do
					this.render.frames[i].shader = SH:get(this.render.sprites[i].shader)
				end

				if mp[2] then
					local abduction_hp, abduction_count = 0, 0
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.attack_radius, a.vis_flags,
						a.vis_bans,
						function(v)
							local ok = abduction_hp == 0 and abduction_count == 0 and v.health.hp > a.total_hp or
								abduction_hp + v.health.hp <= a.total_hp and
								abduction_count < a.total_targets and
								not table.contains(a.invalid_templates, v.template_name) and
								P:is_node_valid(v.nav_path.pi, v.nav_path.ni + 10) and
								P:is_node_valid(v.nav_path.pi, v.nav_path.ni - 10)

							if ok then
								abduction_hp = abduction_hp + v.health.hp
								abduction_count = abduction_count + 1
							end

							return ok
						end)

					if targets then
						a.ts = store.tick_ts
						S:queue(a.sound)
						local e = create_entity(a.entity)

						e.pos = this.pos
						e.owner = h
						e.targets = targets

						queue_insert(store, e)
					end
				end
			else
				for i = 1, 3 do
					this.render.frames[i].shader = nil
				end
			end

			mp[2] = nil
			coroutine.yield()
		end
	end

	function scripts.alien_abduction_ship.update(this, store)
		local a = this.owner.timed_attacks.list[1]
		local enemy_decals = {}

		for _, e in pairs(this.targets) do
			U.animation_start(e, "idle", nil, store.tick_ts, true)

			local es = create_entity("abducted_enemy_decal")

			es.pos = e.pos
			es.render = table.deepclone(e.render)
			es.tween.disabled = true

			queue_insert(store, es)
			table.insert(enemy_decals, es)

			local d = create_entity("damage")

			d.damage_type = DAMAGE_EAT
			d.source_id = this.id
			d.target_id = e.id

			queue_damage(store, d)
		end

		this.tween.ts = store.tick_ts
		U.y_wait(store, 1.5)

		this.render.sprites[3].hidden = nil
		this.render.sprites[3].ts = store.tick_ts

		U.y_wait(store, fts(10))

		for i, ed in ipairs(enemy_decals) do
			ed.tween.disabled = nil
			ed.tween.ts = store.tick_ts + (i - 1) * 0.1
		end

		U.y_animation_wait(this, 3)

		this.render.sprites[3].hidden = true
	end

	-- 火龙
	function scripts.hero_dragon.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		local b = E:get_template("fireball_dragon")

		b.bullet.damage_max = ls.ranged_damage_max[hl]
		b.bullet.damage_min = ls.ranged_damage_min[hl]

		local s

		s = this.hero.skills.blazingbreath

		if initial and s.level > 0 then
			local a = this.ranged.attacks[2]

			a.disabled = nil

			local b = E:get_template("breath_dragon")

			b.bullet.damage_min = s.damage[s.level]
			b.bullet.damage_max = s.damage[s.level]
		end

		s = this.hero.skills.feast

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.damage = s.damage[s.level]
			a.devour_chance = s.devour_chance[s.level]
		end

		s = this.hero.skills.fierymist

		if initial and s.level > 0 then
			local a = this.ranged.attacks[3]

			a.disabled = nil

			local aura = E:get_template("aura_fierymist_dragon")

			aura.aura.duration = s.duration[s.level]

			local m = E:get_template("mod_slow_fierymist")

			m.slow.factor = s.slow_factor[s.level]
		end

		s = this.hero.skills.wildfirebarrage

		if initial and s.level > 0 then
			local a = this.ranged.attacks[4]

			a.disabled = nil

			local b = E:get_template("wildfirebarrage_dragon")

			b.explosions = s.explosions[s.level]
		end

		s = this.hero.skills.reignoffire

		if initial and s.level > 0 then
			local b = E:get_template("fireball_dragon")

			b.bullet.mod = "mod_dragon_reign"

			local b = E:get_template("breath_dragon")

			b.bullet.mod = "mod_dragon_reign"

			local m = E:get_template("mod_dragon_reign")

			m.dps.damage_min = s.dps[s.level] * m.dps.damage_every / m.modifier.duration
			m.dps.damage_max = s.dps[s.level] * m.dps.damage_every / m.modifier.duration

			local b = E:get_template("wildfirebarrage_dragon")

			b.bullet.mod = "mod_dragon_reign"
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_dragon.update(this, store)
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

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.feast

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local target = U.find_nearest_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
					a.vis_bans)

				if not target then
					SU.delay_attack(store, a, 0.13333333333333333)
				else
					SU.hero_gain_xp_from_skill(this, skill)

					a.ts = store.tick_ts

					SU.stun_inc(target)
					S:queue(a.sound)
					U.animation_start(this, "feast", target.pos.x < this.pos.x, store.tick_ts)

					local steps = math.floor(fts(9) / store.tick_length)
					local step_x, step_y = V.mul(1 / steps, target.pos.x - this.pos.x, target.pos.y - this.pos.y - 1)

					for i = 1, steps do
						this.pos.x, this.pos.y = this.pos.x + step_x, this.pos.y + step_y

						coroutine.yield()
					end

					local fx = create_entity("fx_dragon_feast")

					fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
					fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, fx)

					local d = create_entity("damage")

					d.damage_type = DAMAGE_PHYSICAL
					d.value = a.damage
					d.target_id = target.id
					d.source_id = this.id

					local actual_damage = U.predict_damage(target, d)

					if band(target.vis.bans, F_EAT) == 0 and (math.random() < a.devour_chance or actual_damage >= target.health.hp) then
						if target.unit.can_explode then
							d.damage_type = DAMAGE_EAT

							local fxn, default_fx

							if target.unit.explode_fx and target.unit.explode_fx ~= "fx_unit_explode" then
								fxn = target.unit.explode_fx
								default_fx = false
							else
								fxn = "fx_dragon_feast_explode"
								default_fx = true
							end

							local fx = create_entity(fxn)
							local fxs = fx.render.sprites[1]

							fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
							fxs.ts = store.tick_ts

							if default_fx then
								fxs.scale = fxs.size_scales[target.unit.size]
							else
								fxs.name = fxs.size_names[target.unit.size]
							end

							queue_insert(store, fx)
						else
							d.damage_type = DAMAGE_INSTAKILL
						end
					end

					queue_damage(store, d)
					SU.stun_dec(target)
					U.y_animation_wait(this)

					force_idle_ts = true

					goto label_362_1
				end
			end

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
					local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false,
						a.vis_flags, a.vis_bans, function(v)
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

								if a.name == "fierymist" or a.name == "blazingbreath" then
									v_pos = P:node_pos(v.nav_path.pi, 1, v.nav_path.ni + node_offset)
								else
									v_pos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + node_offset)
								end
							end

							local dist_x = math.abs(v_pos.x - this.pos.x)
							local dist_y = math.abs(v_pos.y - this.pos.y)

							if a.name == "fierymist" or a.name == "blazingbreath" then
								return dist_x > a.min_range and dist_y < 80
							else
								return dist_x > 65
							end
						end)

					if target then
						local start_ts = store.tick_ts
						local b, emit_fx, emit_ps, emit_ts, node_offset

						if flight_time then
							node_offset = P:predict_enemy_node_advance(target, flight_time + a.shoot_time)
						else
							local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)

							node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
						end

						local t_pos

						if a.name == "fierymist" or a.name == "blazingbreath" then
							t_pos = P:node_pos(target.nav_path.pi, 1, target.nav_path.ni + node_offset)
						else
							t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + node_offset)
						end

						local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

						U.animation_start(this, an, af, store.tick_ts)

						while store.tick_ts - start_ts < a.shoot_time do
							if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
								goto label_362_0
							end

							coroutine.yield()
						end

						S:queue(a.sound)

						b = create_entity(a.bullet)
						b.bullet.target_id = target.id
						b.bullet.source_id = this.id
						b.pos = V.vclone(this.pos)
						b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
						b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(t_pos.x, t_pos.y)

						queue_insert(store, b)

						if a.xp_from_skill then
							SU.hero_gain_xp_from_skill(this, this.hero.skills[a.xp_from_skill])
						end

						a.ts = start_ts

						if a.emit_ps and b.bullet.flight_time then
							local dest = V.vclone(b.bullet.to)

							if a.name == "fierymist" or a.name == "blazingbreath" then
								dest.y = dest.y + 15
							end

							emit_ts = store.tick_ts

							local ps = create_entity(a.emit_ps)
							local mspeed = V.dist(dest.x, dest.y, b.bullet.from.x, b.bullet.from.y) /
								b.bullet.flight_time

							ps.particle_system.emit_direction = V.angleTo(dest.x - b.bullet.from.x,
								dest.y - b.bullet.from.y)
							ps.particle_system.emit_speed = {
								mspeed,
								mspeed
							}
							ps.particle_system.flip_x = af
							ps.pos.x, ps.pos.y = b.bullet.from.x, b.bullet.from.y

							queue_insert(store, ps)

							emit_ps = ps
						end

						if a.emit_fx then
							local fx = create_entity(a.emit_fx)

							fx.pos.x, fx.pos.y = b.bullet.from.x, b.bullet.from.y
							fx.render.sprites[1].ts = store.tick_ts
							fx.render.sprites[1].flip_x = af

							if af and fx.render.sprites[1].offset.x then
								fx.render.sprites[1].offset.x = -1 * fx.render.sprites[1].offset.x
							end

							queue_insert(store, fx)

							emit_fx = fx
						end

						while not U.animation_finished(this) do
							if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
								goto label_362_0
							end

							coroutine.yield()
						end

						force_idle_ts = true

						::label_362_0::

						if emit_ps then
							emit_ps.particle_system.emit = false
							emit_ps.particle_system.source_lifetime = 0
						end

						if emit_fx then
							emit_fx.render.sprites[1].hidden = true
						end

						goto label_362_1
					end
				end
			end

			SU.soldier_idle(store, this, force_idle_ts)
			SU.soldier_regen(store, this)

			force_idle_ts = nil

			::label_362_1::

			coroutine.yield()
		end
	end

	-- 螃蟹
	function scripts.hero_crab.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local s

		s = this.hero.skills.battlehardened

		if initial and s.level > 0 then
			this.invuln.disabled = nil
			this.invuln.chance = s.chance[s.level]
		end

		s = this.hero.skills.pincerattack

		if initial and s.level > 0 then
			local pa = this.timed_attacks.list[1]

			pa.disabled = nil
			pa.damage_min = s.damage_min[s.level]
			pa.damage_max = s.damage_max[s.level]
		end

		s = this.hero.skills.shouldercannon

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[2]

			a.disabled = nil

			a.loops = s.loops[s.level]
		end

		s = this.hero.skills.burrow

		if initial and s.level > 0 then
			this.burrow.disabled = nil
			this.burrow.extra_speed = s.extra_speed[s.level]
			this.burrow.damage_radius = s.damage_radius[s.level]
			this.nav_grid.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_ICE)
		end

		s = this.hero.skills.hookedclaw

		if initial and s.level > 0 then
			local pa = this.timed_attacks.list[1]

			if not pa.disabled then
				pa.damage_min = pa.damage_min + s.extra_damage[s.level]
				pa.damage_max = pa.damage_max + s.extra_damage[s.level]
			end
		end

		if s.level > 0 then
			this.melee.attacks[1].damage_min = this.melee.attacks[1].damage_min + s.extra_damage[s.level]
			this.melee.attacks[1].damage_max = this.melee.attacks[1].damage_max + s.extra_damage[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_crab.update(this, store, script)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					local b = this.burrow
					local r = this.nav_rally

					if not b.disabled and V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > b.min_distance then
						r.new = false

						U.unblock_target(store, this)

						local vis_bans = this.vis.bans

						this.vis.bans = F_ALL
						this.health.immune_to = F_ALL

						local original_speed = this.motion.max_speed

						this.motion.max_speed = this.motion.max_speed + b.extra_speed
						this.unit.marker_hidden = true

						S:queue(this.sound_events.change_rally_point)
						S:queue(this.sound_events.burrow_in)
						U.y_animation_play(this, "burrow_in", r.pos.x < this.pos.x, store.tick_ts)

						this.health_bar._orig_offset = this.health_bar.offset
						this.health_bar.offset = b.health_bar_offset
						this.unit._orig_hit_offset = this.unit.hit_offset
						this.unit.hit_offset = b.hit_offset
						this.unit._orig_mod_offset = this.unit.mod_offset
						this.unit.mod_offset = b.mod_offset

						local water_trail = create_entity("ps_water_trail")

						water_trail.particle_system.track_id = this.id
						water_trail.particle_system.emit = false
						water_trail.particle_system.z = Z_OBJECTS - 1

						queue_insert(store, water_trail)

						::label_379_0::

						local last_t = band(GR:cell_type(this.pos.x, this.pos.y), TERRAIN_TYPES_MASK)
						local dest = r.pos
						local n = this.nav_grid

						while not V.veq(this.pos, dest) do
							local w = table.remove(n.waypoints, 1) or dest

							U.set_destination(this, w)

							local ani = last_t == TERRAIN_WATER and "burrow_water" or "burrow_land"
							local an, af = U.animation_name_facing_point(this, ani, this.motion.dest)

							U.animation_start(this, an, af, store.tick_ts, true)

							while not this.motion.arrived do
								if r.new then
									r.new = false

									goto label_379_0
								end

								U.walk(this, store.tick_length)
								coroutine.yield()

								this.motion.speed.x, this.motion.speed.y = 0, 0

								local t = band(GR:cell_type(this.pos.x, this.pos.y), TERRAIN_TYPES_MASK)

								if t ~= last_t then
									if last_t and bor(last_t, t) == bor(TERRAIN_WATER, TERRAIN_LAND) then
										local fx = create_entity("fx_enemy_splash")

										fx.render.sprites[1].name = "big"
										fx.render.sprites[1].ts = store.tick_ts
										fx.render.sprites[1].sort_y_offset = 0
										fx.pos = V.vclone(this.pos)

										queue_insert(store, fx)

										if this.sound_events and this.sound_events.water_splash then
											S:queue(this.sound_events.water_splash)
										end
									end

									local in_water = t == TERRAIN_WATER
									local ani = in_water and "burrow_water" or "burrow_land"
									local an, af = U.animation_name_facing_point(this, ani, this.motion.dest)

									U.animation_start(this, an, af, store.tick_ts, true)

									water_trail.particle_system.emit = in_water
									last_t = t
								end
							end
						end

						this.health_bar.offset = this.health_bar._orig_offset
						this.unit.hit_offset = this.unit._orig_hit_offset
						this.unit.mod_offset = this.unit._orig_mod_offset

						SU.hero_gain_xp_from_skill(this, this.hero.skills.burrow)

						for i, pos in pairs({
							V.v(10, -16),
							V.v(-12, -14),
							V.v(22, -1),
							V.v(-24, -1)
						}) do
							local fx = create_entity("fx")

							fx.render.sprites[1].name = "fx_hero_crab_quake"
							fx.render.sprites[1].ts = store.tick_ts + (i - 1) * 0.1
							fx.render.sprites[1].scale = V.v(0.8, 0.8)
							fx.render.sprites[1].alpha = 166
							fx.render.sprites[1].anchor.y = 0.24
							fx.pos.x, fx.pos.y = this.pos.x + pos.x, this.pos.y + pos.y

							queue_insert(store, fx)
						end

						S:queue(this.sound_events.burrow_out)
						U.y_animation_play(this, "burrow_out", r.pos.x < this.pos.x, store.tick_ts)

						this.motion.max_speed = original_speed
						this.vis.bans = vis_bans
						this.health.immune_to = 0
						this.unit.marker_hidden = nil
					elseif SU.y_hero_new_rally(store, this) then
						goto label_379_2
					end
				end

				if this.invuln and this.invuln.pending then
					local e = create_entity(this.invuln.aura_name)

					e.aura.ts = store.tick_ts
					e.aura.source_id = this.id

					queue_insert(store, e)

					local skill = this.hero.skills.battlehardened

					SU.hero_gain_xp_from_skill(this, skill)
					S:queue(this.invuln.sound)
					U.y_animation_play(this, this.invuln.animation, nil, store.tick_ts)

					this.invuln.ts = store.tick_ts
					this.invuln.pending = nil
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.pincerattack

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local left_targets, right_targets = {}, {}
					local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
						a.vis_flags, a.vis_bans, function(v)
							local px, py = this.pos.x, this.pos.y
							local vx, vy = v.pos.x, v.pos.y
							local rx, ry = a.damage_size.x, a.damage_size.y

							if vy >= py - ry / 2 and vy < py + ry / 2 then
								if px < vx and vx < px + rx then
									table.insert(right_targets, v)

									return true
								elseif vx < px and vx > px - rx then
									table.insert(left_targets, v)

									return true
								end
							end

							return false
						end)

					if not targets or #left_targets < a.min_count and #right_targets < a.min_count then
						SU.delay_attack(store, a, 0.13333333333333333)

						goto label_379_1
					end

					if #left_targets > #right_targets then
						targets = left_targets
					else
						targets = right_targets
					end

					local start_ts = store.tick_ts

					S:queue(a.sound)

					local an, af = U.animation_name_facing_point(this, a.animation, targets[1].pos)

					U.animation_start(this, an, af, store.tick_ts, false)

					local flip_x = this.render.sprites[1].flip_x

					while store.tick_ts - start_ts < a.hit_time do
						if SU.hero_interrupted(this) then
							goto label_379_2
						end

						coroutine.yield()
					end

					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans, function(v)
							local px, py = this.pos.x, this.pos.y
							local vx, vy = v.pos.x, v.pos.y
							local rx, ry = a.damage_size.x, a.damage_size.y

							if vy >= py - ry / 2 and vy < py + ry / 2 then
								if not flip_x and px < vx and vx < px + rx then
									return true
								elseif flip_x and vx < px and vx > px - rx then
									return true
								end
							end

							return false
						end)

					if targets then
						table.sort(targets, function(e1, e2)
							return e1.nav_path.ni < e2.nav_path.ni
						end)

						for _, t in pairs(targets) do
							local d = create_entity("damage")

							d.source_id = this.id
							d.target_id = t.id
							d.value = math.random(a.damage_min, a.damage_max)
							d.damage_type = a.damage_type

							queue_damage(store, d)

							t.pos = V.v(targets[1].pos.x + math.random(-7, 7), targets[1].pos.y + math.random(-3, 3))
							t.nav_path = copy(targets[1].nav_path)
						end
					end

					while not U.animation_finished(this) do
						if SU.hero_interrupted(this) then
							goto label_379_2
						end

						coroutine.yield()
					end

					goto label_379_2

					this.render.sprites[1].flip_x = flip_x
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.shouldercannon

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local triggers = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
						a.vis_flags, a.vis_bans)

					if not triggers or #triggers < a.min_count then
						SU.delay_attack(store, a, 0.13333333333333333)

						goto label_379_1
					else
						local trigger = triggers[1]
						an, af, ai = U.animation_name_facing_point(this, a.animations[1], trigger.pos)

						U.y_animation_play(this, an, af, store.tick_ts, false, 1)

						SU.hero_gain_xp_from_skill(this, skill)

						local wait = a.shoot_times[1]

						for i = 1, a.loops do
							local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range,
								a.vis_flags, a.vis_bans)

							if target then
								an, af, ai = U.animation_name_facing_point(this, a.animations[2], target.pos)
								U.animation_start(this, an, af, store.tick_ts, false, 1)

								U.y_wait(store, wait)

								b = create_entity(a.bullet)
								b.pos = V.vclone(this.pos)

								local offset = a.bullet_start_offset[ai]
								b.pos = v(b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y)

								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x,
									target.pos.y + target.unit.hit_offset.y)
								b.bullet.target_id = target.id
								b.bullet.source_id = this.id

								queue_insert(store, b)

								while not U.animation_finished(this, 1) do
									if not target or this.health.dead or this.nav_rally and this.nav_rally.new then
										a.ts = a.ts - a.offset_cooldown
										goto label_379_2
									elseif this.unit.is_stunned then
										a.ts = a.ts - a.offset_cooldown
										goto label_379_3
									end

									coroutine.yield()
								end

								a.ts = store.tick_ts
								wait = a.shoot_times[2]
							end
						end

						::label_379_3::

						U.y_animation_play(this, a.animations[3], af, store.tick_ts, false, 1)
					end

					this.render.sprites[1].flip_x = flip_x
				end

				::label_379_1::

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif brk or sta == A_NO_TARGET then
					a = this.timed_attacks.list[2]
					skill = this.hero.skills.shouldercannon

					if not a.disabled and store.tick_ts - a.ts > a.cooldown then
						local triggers = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
							a.vis_flags, a.vis_bans)

						if not triggers or #triggers < a.min_count then
							SU.delay_attack(store, a, 0.13333333333333333)

							goto label_379_1
						else
							local trigger = triggers[1]
							an, af, ai = U.animation_name_facing_point(this, a.animations[1], trigger.pos)

							U.y_animation_play(this, an, af, store.tick_ts, false, 1)

							SU.hero_gain_xp_from_skill(this, skill)

							local wait = a.shoot_times[1]

							for i = 1, a.loops do
								local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range,
									a.vis_flags, a.vis_bans)

								if target then
									an, af, ai = U.animation_name_facing_point(this, a.animations[2], target.pos)
									U.animation_start(this, an, af, store.tick_ts, false, 1)

									U.y_wait(store, wait)

									b = create_entity(a.bullet)
									b.pos = V.vclone(this.pos)

									local offset = a.bullet_start_offset[ai]
									b.pos = v(b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y)

									b.bullet.from = V.vclone(b.pos)
									b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x,
										target.pos.y + target.unit.hit_offset.y)
									b.bullet.target_id = target.id
									b.bullet.source_id = this.id

									queue_insert(store, b)

									while not U.animation_finished(this, 1) do
										if not target or this.health.dead or this.nav_rally and this.nav_rally.new then
											a.ts = a.ts - a.offset_cooldown
											goto label_379_2
										elseif this.unit.is_stunned then
											a.ts = a.ts - a.offset_cooldown
											goto label_379_3
										end

										coroutine.yield()
									end

									a.ts = store.tick_ts
									wait = a.shoot_times[2]
								end
							end

							::label_379_3::

							U.y_animation_play(this, a.animations[3], af, store.tick_ts, false, 1)
						end

						this.render.sprites[1].flip_x = flip_x
					end

					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				end
			end

			::label_379_2::

			coroutine.yield()
		end
	end

	scripts.mod_dragon_reign = {}
	function scripts.mod_dragon_reign.update(this, store, script)
		local cycles, total_damage = 0, 0
		local m = this.modifier
		local dps = this.dps
		local dmin = dps.damage_min + m.level * dps.damage_inc
		local dmax = dps.damage_max + m.level * dps.damage_inc
		local fx_ts = 0

		local function do_damage(target, value)
			total_damage = total_damage + value

			local d = create_entity("damage")

			d.source_id = this.id
			d.target_id = target.id
			d.value = value
			d.damage_type = dps.damage_type
			d.pop = dps.pop
			d.pop_chance = dps.pop_chance
			d.pop_conds = dps.pop_conds

			queue_damage(store, d)

			local target = U.find_nearest_enemy(store.entities, target.pos, 0, m.spread_range, m.vis_flags, m.vis_bans,
				function(e)
					return e.id ~= m.target_id and not U.has_modifiers(store, e, this.mod)
				end)

			if target and store.tick_ts - m.spread_ts >= m.spread_time then
				m.spread_ts = store.tick_ts
				if this.mod then
					local new_mod = create_entity(this.mod)
					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id
					new_mod.modifier.ts = store.tick_ts
					new_mod.modifier.spread_ts = store.tick_ts
					new_mod.modifier.level = m.level

					queue_insert(store, new_mod)
				end
			end
		end

		local target = store.entities[m.target_id]

		if not target then
			queue_remove(store, this)

			return
		end

		this.pos = target.pos

		while true do
			target = store.entities[m.target_id]

			if not target or target.health.dead then
				break
			end

			if store.tick_ts - m.ts >= m.duration - 1e-09 then
				if dps.damage_last then
					do_damage(target, dps.damage_last)
				end

				break
			end

			if this.render and m.use_mod_offset and target.unit.mod_offset then
				local so = this.render.sprites[1].offset

				so.x, so.y = target.unit.mod_offset.x, target.unit.mod_offset.y
			end

			if dps.damage_every and store.tick_ts - dps.ts >= dps.damage_every then
				cycles = cycles + 1
				dps.ts = dps.ts + dps.damage_every

				local damage_value = math.random(dmin, dmax)

				if cycles == 1 and dps.damage_first then
					damage_value = dps.damage_first
				end

				if not dps.kill then
					damage_value = km.clamp(0, target.health.hp - 1, damage_value)
				end

				do_damage(target, damage_value)

				if dps.fx and (not dps.fx_every or store.tick_ts - fx_ts >= dps.fx_every) then
					fx_ts = store.tick_ts

					local fx = create_entity(dps.fx)

					if dps.fx_tracks_target then
						fx.pos = target.pos

						if m.use_mod_offset and target.unit.mod_offset then
							fx.render.sprites[1].offset.x = target.unit.mod_offset.x
							fx.render.sprites[1].offset.y = target.unit.mod_offset.y
						end
					else
						fx.pos = V.vclone(this.pos)

						if m.use_mod_offset and target.unit.mod_offset then
							fx.pos.x, fx.pos.y = fx.pos.x + target.unit.mod_offset.x, fx.pos.y + target.unit.mod_offset
								.y
						end
					end

					fx.render.sprites[1].ts = store.tick_ts
					fx.render.sprites[1].runs = 0

					if fx.render.sprites[1].size_names then
						fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
					end

					if fx.render.sprites[1].use_blood_color and target.unit.blood_color then
						fx.render.sprites[1].name = fx.render.sprites[1].name .. "_" .. target.unit.blood_color
					end

					if dps.fx_target_flip and target and target.render then
						fx.render.sprites[1].flip_x = target.render.sprites[1].flip_x
					end

					queue_insert(store, fx)
				end
			end

			coroutine.yield()
		end

		log.paranoid(">>>>> id:%s - mod_dps cycles:%s total_damage:%s", this.id, cycles, total_damage)
		queue_remove(store, this)
	end

	-- 库绍
	function scripts.hero_monk.update(this, store, script)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				a = this.dodge
				skill = this.hero.skills.cranestyle

				if not a.disabled and a.active then
					a.active = false

					local target = store.entities[this.soldier.target_id]

					if not target or target.health.dead then
						-- block empty
					else
						local vis_bans = this.vis.bans

						this.vis.bans = F_ALL
						this.health_bar.hidden = true

						SU.hide_modifiers(store, this, true)

						a.ts = store.tick_ts

						SU.hero_gain_xp_from_skill(this, skill)
						S:queue(a.sound, {
							delay = fts(15)
						})
						U.animation_start(this, a.animation, nil, store.tick_ts)

						if SU.y_hero_wait(store, this, a.hit_time) then
							this.vis.bans = vis_bans
							this.health_bar.hidden = this.health.dead

							goto label_372_2
						end

						local d = create_entity("damage")

						d.source_id = this.id
						d.target_id = target.id
						d.value = a.damage
						d.damage_type = a.damage_type

						queue_damage(store, d)

						this.vis.bans = vis_bans
						this.health_bar.hidden = false

						SU.show_modifiers(store, this, true)

						if SU.y_hero_animation_wait(this) then
							goto label_372_2
						end
					end
				end

				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_372_2
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.dragonstyle

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
						a.vis_flags, a.vis_bans)

					if not targets then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						local start_ts = store.tick_ts

						S:queue(a.sound, {
							delay = fts(5)
						})

						local an, af = U.animation_name_facing_point(this, a.animation, targets[1].pos)

						U.animation_start(this, an, af, store.tick_ts, false)

						while store.tick_ts - start_ts < a.hit_time do
							if SU.hero_interrupted(this) then
								goto label_372_2
							end

							coroutine.yield()
						end

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius, a.damage_flags,
							a.damage_bans)

						if targets then
							for _, t in pairs(targets) do
								local d = create_entity("damage")

								d.source_id = this.id
								d.target_id = t.id
								d.value = math.random(a.damage_min, a.damage_max)
								d.damage_type = a.damage_type

								queue_damage(store, d)

								local mod = create_entity(a.mod)

								mod.modifier.ts = store.tick_ts
								mod.modifier.source_id = this.id
								mod.modifier.target_id = t.id

								queue_insert(store, mod)
							end
						end

						while not U.animation_finished(this) do
							if SU.hero_interrupted(this) then
								break
							end

							coroutine.yield()
						end

						goto label_372_2
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.leopardstyle

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a
						.vis_bans)

					if not targets then
						SU.delay_attack(store, a, 0.13333333333333333)

						goto label_372_1
					end

					U.unblock_target(store, this)

					this.health.ignore_damage = true
					this.health_bar.hidden = true

					local start_ts = store.tick_ts
					local start_pos = V.vclone(this.pos)
					local last_target
					local i = 1

					U.animation_start(this, "leopard_start", nil, store.tick_ts, false)

					while not U.animation_finished(this) do
						if SU.hero_interrupted(this) then
							goto label_372_0
						end

						coroutine.yield()
					end

					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					while i <= a.loops do
						i = i + 1
						targets = U.find_enemies_in_range(store.entities, start_pos, 0, a.range, a.vis_flags, a.vis_bans)

						if not targets then
							break
						end

						if #targets > 1 then
							targets = table.filter(targets, function(k, v)
								return v ~= last_target
							end)
						end

						local target = table.random(targets)

						last_target = target

						local animation, animation_idx = table.random(a.hit_animations)
						local hit_time = a.hit_times[animation_idx]
						local hit_pos = U.melee_slot_position(this, target, 1)
						local last_ts = store.tick_ts

						this.pos.x, this.pos.y = hit_pos.x, hit_pos.y

						if band(target.vis.bans, F_STUN) == 0 then
							SU.stun_inc(target)
						end

						local sound = (i - 1) % 3 == 0 and "HeroMonkMultihitScream" or "HeroMonkMultihitPunch"

						S:queue(sound)

						local an, af = U.animation_name_facing_point(this, animation, target.pos)

						U.animation_start(this, an, af, store.tick_ts)

						while hit_time > store.tick_ts - last_ts do
							if SU.hero_interrupted(this) then
								SU.stun_dec(target)

								goto label_372_0
							end

							coroutine.yield()
						end

						local d = create_entity("damage")

						d.source_id = this.id
						d.target_id = target.id
						d.value = math.random(a.damage_min, a.damage_max)

						queue_damage(store, d)

						local mod = create_entity(a.mod)

						mod.modifier.ts = store.tick_ts
						mod.modifier.source_id = this.id
						mod.modifier.target_id = target.id

						queue_insert(store, mod)

						local poff = a.particle_pos[animation_idx]
						local fx = create_entity("fx")

						fx.pos.x, fx.pos.y = (af and -1 or 1) * poff.x + this.pos.x, poff.y + this.pos.y
						fx.render.sprites[1].name = "fx_hero_monk_particle"
						fx.render.sprites[1].ts = store.tick_ts
						fx.render.sprites[1].sort_y_offset = -2

						queue_insert(store, fx)

						while not U.animation_finished(this) do
							if SU.hero_interrupted(this) then
								SU.stun_dec(target)

								goto label_372_0
							end

							coroutine.yield()
						end

						SU.stun_dec(target)
					end

					::label_372_0::

					this.health.ignore_damage = nil
					this.health_bar.hidden = false
					this.pos.x, this.pos.y = start_pos.x, start_pos.y

					U.y_animation_play(this, "leopard_end", nil, store.tick_ts, 1)
				end

				::label_372_1::

				local target = SU.soldier_pick_melee_target(store, this)

				if target and target.unit then
					local ta = target.unit.damage_factor
					local a = this.melee.attacks[5]

					if ta and ta <= a.limit_damage_factor then
						a.damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_INSTAKILL)
						a.vis_flags = bor(F_INSTAKILL)
						a.vis_bans = bor(F_BOSS)
					else
						a.damage_type = DAMAGE_TRUE
						a.vis_flags = 0
						a.vis_bans = 0
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_372_2::

			coroutine.yield()
		end
	end

	-- 骨龙
	function scripts.hero_dracolich.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, force_idle_ts

		local function skeleton_glow_fx()
			local fx = create_entity("fx_dracolich_skeleton_glow")

			fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
			fx.render.sprites[1].ts = store.tick_ts
			fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x
			fx.render.sprites[1].anchor.y = this.render.sprites[1].anchor.y

			queue_insert(store, fx)
		end

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

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.bonegolem

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range * 1.5, a.vis_flags,
					a.vis_bans, function(v)
						local offset = P:predict_enemy_node_advance(v, a.spawn_time)
						local ppos = P:node_pos(v.nav_path.pi, v.nav_path.spi, v.nav_path.ni + offset)

						return P:is_node_valid(v.nav_path.pi, v.nav_path.ni + offset, NF_RALLY) and
							GR:cell_is_only(ppos.x, ppos.y, TERRAIN_LAND)
					end)
				local spawn_pos

				if target then
					local offset = P:predict_enemy_node_advance(target, a.spawn_time)

					spawn_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + offset)
				else
					local positions = P:get_all_valid_pos(this.pos.x, this.pos.y, a.min_range, a.max_range, TERRAIN_LAND,
						nil, NF_RALLY)

					spawn_pos = table.random(positions)
				end

				if not spawn_pos then
					SU.delay_attack(store, a, 0.4)
				else
					S:queue(a.sound)
					U.animation_start(this, "golem", nil, store.tick_ts)
					skeleton_glow_fx()
					U.y_wait(store, a.spawn_time)

					local e = create_entity(a.entity)

					e.pos = V.vclone(spawn_pos)
					e.nav_rally.pos = V.vclone(spawn_pos)
					e.nav_rally.center = V.vclone(spawn_pos)
					e.render.sprites[1].flip_x = math.random() < 0.5

					queue_insert(store, e)

					e.owner = this

					U.y_animation_wait(this)

					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)

					goto label_386_1
				end
			end

			a = this.timed_attacks.list[2]
			skill = this.hero.skills.spinerain

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
					a.vis_bans)

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

						U.animation_start(this, "spinerain", flip, store.tick_ts)
						skeleton_glow_fx()
						U.y_wait(store, a.spawn_time)

						local delay = 0
						local n_step = ni < s_ni and -2 or 2

						ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

						for i = 1, skill.count[skill.level] do
							local e = create_entity(a.entity)

							e.pos = P:node_pos(pi, spi, ni)
							e.render.sprites[1].prefix = e.render.sprites[1].prefix .. math.random(1, 3)
							e.render.sprites[1].flip_x = not flip
							e.delay = delay
							e.bullet.source_id = this.id

							queue_insert(store, e)

							delay = delay + fts(U.frandom(1, 3))
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

			a = this.timed_attacks.list[3]
			skill = this.hero.skills.diseasenova

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
					a.vis_bans)

				if not targets or #targets < a.min_count then
					SU.delay_attack(store, a, 0.4)
				else
					local start_ts = store.tick_ts

					this.health_bar.hidden = true
					this.health.ignore_damage = true

					U.animation_start(this, "nova", nil, store.tick_ts)
					S:queue(a.sound, {
						delay = fts(10)
					})
					U.y_wait(store, a.hit_time)

					for _, target in pairs(targets) do
						local d = create_entity("damage")

						d.damage_type = a.damage_type
						d.source_id = this.id
						d.target_id = target.id
						d.value = math.random(a.damage_min, a.damage_max)

						queue_damage(store, d)

						if a.mod then
							local m = create_entity(a.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id
							m.modifier.xp_dest_id = this.id

							queue_insert(store, m)
						end
					end

					local fi, fo = 10, 35

					for i = 1, 6 do
						local rx, ry = V.rotate(2 * math.pi * i / 6, 1, 0)
						local fx = create_entity("fx_dracolich_nova_cloud")

						fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
						fx.tween.props[2].keys = {
							{
								0,
								V.v(rx * fi, ry * fi)
							},
							{
								fts(20),
								V.v(rx * fo, ry * fo)
							}
						}
						fx.tween.ts = store.tick_ts

						queue_insert(store, fx)
					end

					local fx = create_entity("fx_dracolich_nova_explosion")

					fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
					fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, fx)

					local fx = create_entity("fx_dracolich_nova_decal")

					fx.pos.x, fx.pos.y = this.pos.x, this.pos.y
					fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, fx)
					U.y_animation_wait(this)

					this.render.sprites[1].hidden = true

					U.y_wait(store, a.respawn_delay)

					this.render.sprites[1].hidden = nil

					S:queue(a.respawn_sound)
					U.y_animation_play(this, "respawn", nil, store.tick_ts)

					this.health_bar.hidden = false
					this.health.ignore_damage = false
					force_idle_ts = true
					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)
				end
			end

			a = this.timed_attacks.list[4]
			skill = this.hero.skills.plaguecarrier

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local targets_info = U.find_enemies_in_paths(store.entities, this.pos, a.range_nodes_min,
					a.range_nodes_max, nil, a.vis_flags, a.vis_bans)

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

							local flip = P:node_pos(s_pi, s_spi, s_ni, true).x < this.pos.x

							S:queue(a.sound)
							U.animation_start(this, "plague", flip, store.tick_ts)
							U.y_wait(store, a.spawn_time)

							local delay = 0

							for i = 1, a.count do
								local e = create_entity(a.entity)

								e.pos.x, e.pos.y = this.pos.x + (flip and -1 or 1) * a.spawn_offset.x,
									this.pos.y + a.spawn_offset.y
								e.nav_path.pi = s_pi
								e.nav_path.spi = math.random(1, 3)
								e.nav_path.ni = s_ni
								e.nav_path.dir = dir
								e.delay = delay
								e.aura.source_id = this.id

								queue_insert(store, e)

								delay = delay + fts(U.frandom(1, 3))
							end

							U.y_animation_wait(this)

							force_idle_ts = true
							a.ts = store.tick_ts

							SU.hero_gain_xp_from_skill(this, skill)

							goto label_386_1
						end
					end
				end
			end

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
					local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans, function(v)
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

							return dist_x > a.min_range
						end)

					if target then
						local start_ts = store.tick_ts
						local b, emit_fx, emit_ps, emit_ts
						local dist = V.dist(origin.x, origin.y, target.pos.x, target.pos.y)
						local node_offset = P:predict_enemy_node_advance(target, dist / bullet_speed)
						local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi,
							target.nav_path.ni + node_offset)
						local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

						U.animation_start(this, an, af, store.tick_ts)

						while store.tick_ts - start_ts < a.shoot_time do
							if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
								goto label_386_0
							end

							coroutine.yield()
						end

						S:queue(a.sound)

						b = create_entity(a.bullet)
						b.bullet.target_id = target.id
						b.bullet.source_id = this.id
						b.pos = V.vclone(this.pos)
						b.pos.x = b.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
						b.pos.y = b.pos.y + a.bullet_start_offset[ai].y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(t_pos.x, t_pos.y)

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

	-- 猴神
	function scripts.hero_monkey_god.get_info(this)
		local info = scripts.hero_basic.get_info_melee(this)

		if this.clone then
			info.respawn = nil
		end

		return info
	end

	function scripts.hero_monkey_god.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		local a = this.melee.attacks[1]

		a.damage_max = ls.damage_max[hl]
		a.damage_min = ls.damage_min[hl]
		a = this.melee.attacks[2]
		a.damage_max = ls.damage_max[hl]
		a.damage_min = ls.damage_min[hl]

		local s

		s = this.hero.skills.spinningpole

		if initial and s.level > 0 then
			local a = this.melee.attacks[3]

			a.disabled = nil
			a.damage_min = s.damage[s.level]
			a.damage_max = s.damage[s.level]
			a.loops = s.loops[s.level]
		end

		s = this.hero.skills.tetsubostorm

		if initial and s.level > 0 then
			local a = this.melee.attacks[4]

			a.disabled = nil
			a.damage_min = s.damage[s.level]
			a.damage_max = s.damage[s.level]
		end

		s = this.hero.skills.monkeypalm

		if initial and s.level > 0 then
			local a = this.melee.attacks[5]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.modifier.duration = s.silence_duration[s.level]
			m.stun_duration = s.stun_duration[s.level]
		end

		s = this.hero.skills.angrygod

		if initial and s.level > 0 then
			a = this.timed_attacks.list[1]
			a.disabled = nil

			local m = E:get_template(a.mod)

			m.received_damage_factor = s.received_damage_factor[s.level]
		end

		s = this.hero.skills.divinenature

		if initial and s.level > 0 then
			local a = E:get_template("aura_monkey_god_divinenature")

			a.hps.heal_min = s.hp[s.level]
			a.hps.heal_max = s.hp[s.level]
			a.hps.heal_every = s.cooldown[s.level]

			local a = this.timed_attacks.list[2]

			a.disabled = nil
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_monkey_god.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta
		local cloud_trail = create_entity("ps_monkey_god_trail")

		cloud_trail.particle_system.track_id = this.id
		cloud_trail.particle_system.track_offset = V.v(0, 50)
		cloud_trail.particle_system.emit = false
		cloud_trail.particle_system.z = Z_OBJECTS

		queue_insert(store, cloud_trail)
		if not this.clone then
			U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		end

		this.health_bar.hidden = false

		while true do
			if h.dead or this.clone and store.tick_ts - this.clone.ts > this.clone.duration then
				if this.clone then
					this.ui.can_click = false
					this.health.hp = 0

					SU.y_soldier_death(store, this)

					this.tween.disabled = nil
					this.tween.ts = store.tick_ts

					return
				else
					SU.y_hero_death_and_respawn(store, this)
				end
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					local r = this.nav_rally
					local cw = this.cloudwalk
					local force_cloudwalk = false

					for _, p in pairs(this.nav_grid.waypoints) do
						if GR:cell_is(p.x, p.y, bor(TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_NOWALK)) then
							force_cloudwalk = true

							break
						end
					end

					if force_cloudwalk or V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > cw.min_distance then
						r.new = false

						U.unblock_target(store, this)

						local vis_bans = this.vis.bans

						this.vis.bans = F_ALL
						this.health.immune_to = F_ALL

						local original_speed = this.motion.max_speed

						this.motion.max_speed = this.motion.max_speed + cw.extra_speed
						this.unit.marker_hidden = true
						this.health_bar.hidden = true

						S:queue(this.sound_events.change_rally_point)
						S:queue(this.sound_events.cloud_start)
						SU.hide_modifiers(store, this, true)
						U.y_animation_play(this, cw.animations[1], r.pos.x < this.pos.x, store.tick_ts)
						SU.show_modifiers(store, this, true)
						S:queue(this.sound_events.cloud_loop)

						cloud_trail.particle_system.emit = true
						this.render.sprites[2].hidden = nil
						this.render.sprites[1].z = Z_BULLETS

						local ho = this.unit.hit_offset
						local mo = this.unit.mod_offset

						this.unit.hit_offset = cw.hit_offset
						this.unit.mod_offset = cw.mod_offset

						::label_433_0::

						local dest = r.pos
						local n = this.nav_grid

						while not V.veq(this.pos, dest) do
							local w = table.remove(n.waypoints, 1) or dest

							U.set_destination(this, w)

							local an, af = U.animation_name_facing_point(this, cw.animations[2], this.motion.dest)

							U.animation_start(this, an, af, store.tick_ts, true)

							while not this.motion.arrived do
								if r.new then
									r.new = false

									goto label_433_0
								end

								U.walk(this, store.tick_length)
								coroutine.yield()

								this.motion.speed.x, this.motion.speed.y = 0, 0
							end
						end

						cloud_trail.particle_system.emit = false

						S:stop(this.sound_events.cloud_loop)
						S:queue(this.sound_events.cloud_end, this.sound_events.cloud_end_args)
						SU.hide_modifiers(store, this, true)
						U.y_animation_play(this, cw.animations[3], nil, store.tick_ts)
						SU.show_modifiers(store, this, true)

						this.render.sprites[1].z = Z_OBJECTS
						this.render.sprites[2].hidden = true
						this.motion.max_speed = original_speed
						this.vis.bans = vis_bans
						this.health.immune_to = 0
						this.unit.marker_hidden = nil
						this.health_bar.hidden = nil
						this.unit.hit_offset = ho
						this.unit.mod_offset = mo
					elseif SU.y_hero_new_rally(store, this) then
						goto label_433_2
					end
				end

				if SU.hero_level_up(store, this) and not this.clone then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.angrygod

				if this.clone and not a.disabled and store.tick_ts - a.ts > a.cooldown then
					if U.get_blocked(store, this) and U.is_blocked_valid(store, this) then
						SU.delay_attack(store, a, 0.3333333333333333)
					else
						local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
							a.vis_flags, a.vis_bans)

						if not targets or #targets < a.min_count then
							SU.delay_attack(store, a, 0.2)
						else
							S:queue(a.sound_start)
							U.y_animation_play(this, a.animations[1], nil, store.tick_ts, 1)

							local loop_ts = store.tick_ts

							a.ts = store.tick_ts

							SU.hero_gain_xp_from_skill(this, skill)
							S:queue(a.sound_loop)

							for i = 1, a.loops do
								U.animation_start(this, a.animations[2], nil, store.tick_ts, false)

								local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range,
									a.max_range, a.vis_flags, a.vis_bans)

								if targets then
									for _, target in pairs(targets) do
										local m = create_entity(a.mod)

										m.modifier.target_id = target.id
										m.modifier.source_id = this.id
										m.modifier.duration = m.modifier.duration + U.frandom(-0.15, 0.15)
										m.render.sprites[1].ts = store.tick_ts

										queue_insert(store, m)
									end
								end

								while not U.animation_finished(this) do
									if SU.hero_interrupted(this) then
										goto label_433_1
									end

									coroutine.yield()
								end
							end

							::label_433_1::

							S:stop(a.sound_loop)
							U.y_animation_play(this, a.animations[3], nil, store.tick_ts, 1)

							goto label_433_2
						end
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.divinenature

				if not this.clone and not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true, NF_RALLY)

					if #nearest < 1 then
						SU.delay_attack(store, a, 0.3333333333333333)
					else
						local ns = {}

						ns.pi = nearest[1][1]
						ns.spi = math.random(1, 3)
						ns.ni = nearest[1][3] - math.random(a.nodes_offset[1], a.nodes_offset[2])

						local node_pos = P:node_pos(ns)

						if not P:is_node_valid(ns.pi, ns.ni, NF_RALLY) or band(GR:cell_type(node_pos.x, node_pos.y), bor(TERRAIN_NOWALK, TERRAIN_FAERIE)) ~= 0 then
							SU.delay_attack(store, a, 0.3333333333333333)
						else
							S:queue(a.sound)
							U.animation_start(this, a.animation, nil, store.tick_ts, false)
							U.y_wait(store, a.spawn_time)

							local spawn_pos = V.v(
								this.pos.x + (this.render.sprites[1].flip_x and -1 or 1) * a.spawn_offset.x,
								this.pos.y + a.spawn_offset.y)
							local clone = create_entity(a.entity)

							clone.pos = spawn_pos
							clone.nav_rally.pos = node_pos
							clone.nav_rally.center = V.vclone(node_pos)
							clone.nav_rally.new = true
							clone.render.sprites[1].flip_x = this.render.sprites[1].flip_x
							clone.clone.ts = store.tick_ts
							clone.clone.duration = skill.duration[skill.level]
							clone.hero.level = this.hero.level
							clone.hero.xp = this.hero.xp

							for sn, s in pairs(this.hero.skills) do
								clone.hero.skills[sn].level = s.level
							end

							queue_insert(store, clone)
							SU.hero_gain_xp_from_skill(this, skill)
							U.y_animation_wait(this)

							a.ts = store.tick_ts
						end
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_433_2::

			coroutine.yield()
		end
	end
end

function scripts_UH:enhance3()
	-- 艾莉丹
	function scripts.hero_elves_archer.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local bt = E:get_template(this.ranged.attacks[1].bullet)

		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]

		local s

		s = this.hero.skills.multishot

		if initial and s.level > 0 then
			local a = this.ranged.attacks[2]

			a.disabled = nil
			a.max_loops = s.loops[s.level]
		end

		s = this.hero.skills.porcupine

		if initial and s.level > 0 then
			bt.bullet.damage_inc = s.damage_inc[s.level]
			bt.bullet.limit_p = s.max[s.level]
		end

		s = this.hero.skills.nimble_fencer

		if initial and s.level > 0 then
			this.dodge.disabled = nil
			this.dodge.chance = s.chance[s.level]
		end

		s = this.hero.skills.double_strike

		if initial and s.level > 0 then
			local a = this.melee.attacks[2]

			a.disabled = nil
			a.damage_min = s.damage_min[s.level]
			a.damage_max = s.damage_max[s.level]
		end

		s = this.hero.skills.ultimate

		if initial and s.level > 0 then
			-- block empty
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_elves_archer.update(this, store)
		local h = this.health
		local he = this.hero
		local brk, sta, a, skill
		local is_sword = false
		local porcupine_target, porcupine_level = nil, 0

		local function update_porcupine(attack, target)
			if porcupine_target == target and this.hero.skills.porcupine.level > 0 then
				porcupine_level = math.min(porcupine_level + 1, T("arrow_hero_elves_archer").bullet.limit_p)
				attack.level = porcupine_level
				if porcupine_level >= math.ceil(T("arrow_hero_elves_archer").bullet.limit_p / 1.35) then
					T("arrow_hero_elves_archer").bullet.damage_type = this.hero.skills.porcupine.damage_type
					T("arrow_hero_elves_archer_s").bullet.damage_type = this.hero.skills.porcupine.damage_type
				else
					T("arrow_hero_elves_archer").bullet.damage_type = DAMAGE_PHYSICAL
					T("arrow_hero_elves_archer_s").bullet.damage_type = DAMAGE_PHYSICAL
				end
			else
				porcupine_level = 0
				attack.level = 0
			end

			porcupine_target = target
		end

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			this.regen.is_idle = nil

			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				if this.dodge and this.dodge.active then
					this.dodge.active = false
					this.dodge.counter_attack_pending = true
				end

				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_79_4
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				if this.melee then
					local target = SU.soldier_pick_melee_target(store, this)

					if not target then
						-- block empty
					else
						if is_sword then
							local slot_pos = U.melee_slot_position(this, target)

							if slot_pos and not V.veq(slot_pos, this.pos) then
								U.y_animation_play(this, "sword2bow", nil, store.tick_ts)

								is_sword = false
							end
						end

						if SU.soldier_move_to_slot_step(store, this, target) then
							goto label_79_4
						end

						local attack = SU.soldier_pick_melee_attack(store, this, target)

						if not attack then
							goto label_79_4
						end

						if not is_sword then
							U.y_animation_play(this, "bow2sword", nil, store.tick_ts)

							is_sword = true
						end

						if attack.xp_from_skill then
							SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
						end

						local attack_done = SU.y_soldier_do_single_melee_attack(store, this, target, attack)

						U.animation_start(this, "idle_sword", nil, store.tick_ts, true)

						goto label_79_4
					end
				end

				if is_sword then
					U.y_animation_play(this, "sword2bow", nil, store.tick_ts)

					is_sword = false
				end

				if this.ranged then
					local target, attack, pred_pos = SU.soldier_pick_ranged_target_and_attack(store, this)

					if not target then
						goto label_79_3
					end

					this.regen.is_idle = true

					if not attack then
						goto label_79_3
					end

					U.set_destination(this, this.pos)

					local attack_done
					local start_ts = store.tick_ts

					if attack.max_loops then
						local an, af, ai = U.animation_name_facing_point(this, attack.animations[1], target.pos)

						U.y_animation_play(this, an, af, store.tick_ts, 1)

						local retarget_flag
						local loops, loops_done = attack.max_loops, 0
						local pred_shots
						local b = create_entity(attack.bullet)
						local d = SU.create_bullet_damage(b.bullet)

						::label_79_0::

						if retarget_flag then
							retarget_flag = nil

							local n_target, _, n_pred_pos = U.find_foremost_enemy(store.entities, this.pos,
								attack.min_range, attack.max_range, attack.node_prediction, attack.vis_flags,
								attack.vis_bans, function(v)
									return v ~= target
								end, F_FLYING)

							if n_target then
								target = n_target
								pred_pos = n_pred_pos
							else
								goto label_79_1
							end
						end

						update_porcupine(attack, target)

						d.value = math.ceil((b.bullet.damage_min + b.bullet.damage_max + 2 * attack.level * (b.bullet.damage_inc or 0)) /
							2)
						pred_shots = math.ceil(target.health.hp / U.predict_damage(target, d))

						log.paranoid("+++ pred_shots:%s d.value:%s target.hp:%s", pred_shots, d.value, target.health.hp)

						loops = math.min(attack.max_loops - loops_done, pred_shots)

						for i = 1, loops do
							an, af, ai = U.animation_name_facing_point(this, attack.animations[2], target.pos)

							U.animation_start(this, an, af, store.tick_ts, false)

							while store.tick_ts - this.render.sprites[1].ts < attack.shoot_times[1] do
								if SU.hero_interrupted(this) then
									goto label_79_2
								end

								coroutine.yield()
							end

							local b = create_entity(attack.bullet)

							b.pos = V.vclone(this.pos)

							if attack.bullet_start_offset then
								local offset = attack.bullet_start_offset[1]

								b.pos.x, b.pos.y = b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y
							end

							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x,
								target.pos.y + target.unit.hit_offset.y)
							b.bullet.target_id = target.id
							b.bullet.source_id = this.id
							b.bullet.xp_dest_id = this.id
							b.bullet.level = attack.level

							queue_insert(store, b)

							if attack.xp_from_skill then
								SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
							end

							attack_done = true
							loops_done = loops_done + 1

							while not U.animation_finished(this) do
								if SU.hero_interrupted(this) then
									goto label_79_2
								end

								coroutine.yield()
							end

							if target.health.dead or band(F_RANGED, target.vis.bans) ~= 0 then
								retarget_flag = true

								goto label_79_0
							end

							update_porcupine(attack, target)
						end

						if loops_done < attack.max_loops then
							retarget_flag = true

							goto label_79_0
						end

						::label_79_1::

						an, af, ai = U.animation_name_facing_point(this, attack.animations[3], target.pos)

						U.animation_start(this, an, af, store.tick_ts, 1)

						while not U.animation_finished(this) do
							if SU.hero_interrupted(this) then
								break
							end

							coroutine.yield()
						end
					else
						update_porcupine(attack, target)

						attack_done = SU.y_soldier_do_ranged_attack(store, this, target, attack, pred_pos)
					end

					::label_79_2::

					if attack_done then
						attack.ts = start_ts
					end

					goto label_79_4
				end

				::label_79_3::

				if SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)

					this.regen.is_idle = true
				end
			end

			::label_79_4::

			coroutine.yield()
		end
	end

	-- 埃里汎
	function scripts.hero_arivan.insert(this, store)
		this.hero.fn_level_up(this, store, true)

		this.melee.order = U.attack_order(this.melee.attacks)
		this.ranged.order = U.attack_order(this.ranged.attacks)

		local b = this.hero.skills.stone_dance
		if b.level > 0 then
			local a = create_entity("aura_arivan_stone_dance")

			a.aura.damage = T("hero_arivan").hero.skills.stone_dance.damage[b.level]
			a.aura.source_id = this.id
			a.aura.ts = store.tick_ts
			a.pos = this.pos
			this.timed_attacks.list[2].aura = a

			queue_insert(store, a)
		end

		return true
	end

	function scripts.hero_arivan.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta
		local iii = 1

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_90_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.stone_dance

				if not a.disabled and #a.aura.stones == a.aura.max_stones then
					a.ts = store.tick_ts
				end

				if not a.disabled and store.tick_ts - a.ts > a.cooldown and #a.aura.stones < a.aura.max_stones then
					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)
					U.y_wait(store, a.hit_time)

					local aura = a.aura

					local stone = create_entity("arivan_stone")

					local angle = iii * 2 * math.pi / aura.max_stones % (2 * math.pi)

					stone.pos = U.point_on_ellipse(this.pos, aura.rot_radius, angle)
					stone.render.sprites[1].name = string.format(stone.render.sprites[1].name, iii)
					stone.render.sprites[1].ts = store.tick_ts

					queue_insert(store, stone)
					table.insert(aura.stones, stone)

					iii = #a.aura.stones

					while iii > 3 do
						iii = iii - 3
					end

					aura.aura.ts = store.tick_ts

					U.y_animation_wait(this)

					a.ts = store.tick_ts

					goto label_90_0
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.seal_of_fire

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target = U.find_nearest_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.26666666666666666)
					else
						local pred_pos = target.pos
						local start_ts = store.tick_ts
						local an, af = U.animation_name_facing_point(this, a.animations[1], pred_pos)

						U.y_animation_play(this, an, af, store.tick_ts, 1)

						for i = 1, a.loops do
							an, af = U.animation_name_facing_point(this, a.animations[2], pred_pos)

							U.animation_start(this, an, af, store.tick_ts, false)

							for si, st in pairs(a.shoot_times) do
								while st > store.tick_ts - this.render.sprites[1].ts do
									if SU.hero_interrupted(this) then
										goto label_90_0
									end

									coroutine.yield()
								end

								local offset = a.bullet_start_offset[si]
								local b = create_entity(a.bullet)

								target = U.find_nearest_enemy(store.entities, this.pos, a.min_range, a.max_range,
									a.vis_flags, a.vis_bans)

								if target then
									local dist = V.dist(this.pos.x, this.pos.y + offset.y, target.pos.x, target.pos.y)

									pred_pos = P:predict_enemy_pos(target, dist / b.bullet.min_speed)
								end

								a.ts = store.tick_ts
								b.pos = V.vclone(this.pos)
								b.pos.x, b.pos.y = b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(pred_pos)
								b.bullet.to.x, b.bullet.to.y = b.bullet.to.x + U.frandom(-1, 1),
									b.bullet.to.y + U.frandom(-1, 1)
								b.bullet.source_id = this.id
								b.bullet.xp_dest_id = this.id

								queue_insert(store, b)
							end

							while not U.animation_finished(this) do
								if SU.hero_interrupted(this) then
									goto label_90_0
								end

								coroutine.yield()
							end
						end

						SU.hero_gain_xp_from_skill(this, skill)
						U.animation_start(this, a.animations[3], nil, store.tick_ts, false)

						while not U.animation_finished(this) do
							if SU.hero_interrupted(this) then
								break
							end

							coroutine.yield()
						end

						goto label_90_0
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				else
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_90_0::

			coroutine.yield()
		end
	end

	function scripts.fireball_arivan.update(this, store)
		local b = this.bullet
		local mspeed = b.min_speed
		local target, ps

		S:queue(this.sound_events.summon)
		U.animation_start(this, "idle", nil, store.tick_ts, false)
		U.y_wait(store, this.idle_time)

		ps = create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
		S:queue(this.sound_events.travel)

		while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > 2 * (mspeed * store.tick_length) do
			coroutine.yield()

			mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
			this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length,
				this.pos.y + b.speed.y * store.tick_length
			this.render.sprites[1].r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)

			if ps then
				ps.particle_system.emit_direction = this.render.sprites[1].r
			end
		end

		local targets = U.find_enemies_in_range(store.entities, b.to, 0, b.damage_radius, b.damage_flags, b.damage_bans)

		if targets then
			for _, target in pairs(targets) do
				local d = create_entity("damage")

				d.damage_type = b.damage_type
				d.value = math.ceil(U.frandom(b.damage_min, b.damage_max))
				d.source_id = this.id
				d.target_id = target.id

				queue_damage(store, d)

				local mod = create_entity(this.mod)

				mod.modifier.source_id = this.id
				mod.modifier.target_id = target.id

				queue_insert(store, mod)
			end
		end

		S:queue(this.sound_events.hit)

		if b.hit_fx then
			local fx = create_entity(b.hit_fx)

			fx.pos = V.vclone(b.to)
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
		end

		coroutine.yield()
		queue_remove(store, this)
	end

	function scripts.aura_arivan_stone_dance.update(this, store)
		local rot_phase = 0
		local owner = store.entities[this.aura.source_id]
		local ct = this.aura.cycle_time

		if not owner then
			log.error("aura_arivan_stone_dance owner is missing.")
			queue_remove(store, this)

			return
		end

		local last_ts = store.tick_ts
		this.pos = owner.pos

		while true do
			if owner.health.dead and #this.stones > 1 then
				for i = #this.stones, 1, -1 do
					local stone = this.stones[i]
					local fx = create_entity("fx_arivan_stone_explosion")

					fx.pos = stone.pos
					fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, fx)
					queue_remove(store, stone)
					table.remove(this.stones, i)
				end
			end

			if this.shield_active then
				this.shield_active = false

				local s = this.render.sprites[1]

				s.hidden = false
				s.ts = store.tick_ts
				s.runs = 0
				s.flip_x = owner.render.sprites[1].flip_x
			end

			if store.tick_ts - this.aura.ts > fts(13) then
				rot_phase = rot_phase + this.rot_speed * store.tick_length
			end

			for i, t in ipairs(this.stones) do
				local a = (i * 2 * math.pi / this.max_stones + rot_phase) % (2 * math.pi)

				t.pos = U.point_on_ellipse(this.pos, this.rot_radius, a)
			end

			if #this.stones < 1 then
				owner.vis.bans = band(owner.vis.bans, bnot(this.owner_vis_bans))
			else
				owner.vis.bans = bor(owner.vis.bans, this.owner_vis_bans)
			end

			local a = this.aura

			a.cycle_time = ct - #this.stones * 0.225
			if not owner.health.dead and store.tick_ts - last_ts >= a.cycle_time then
				last_ts = store.tick_ts

				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.radius, a.vis_flags, a.vis_bans)

				if targets then
					for _, target in pairs(targets) do
						local d = create_entity("damage")

						d.damage_type = a.damage_type
						d.value = a.damage
						d.target_id = target.id
						d.source_id = this.id

						queue_damage(store, d)
					end
				end
			end

			coroutine.yield()
		end
	end

	-- 格雷森
	function scripts.hero_regson.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		for i = 1, 3 do
			this.melee.attacks[i].damage_min = ls.melee_damage_min[hl]
			this.melee.attacks[i].damage_max = ls.melee_damage_max[hl]
		end

		local s

		s = this.hero.skills.blade

		if initial and s.level > 0 then
			this.melee.attacks[4].damage_max = s.damage[s.level] / 2
			this.melee.attacks[4].damage_min = s.damage[s.level] / 2
			this.melee.attacks[5].chance = s.instakill_chance[s.level]
			this.melee.attacks[5].damage_max = s.damage[s.level] / 2
			this.melee.attacks[5].damage_min = s.damage[s.level] / 2
		end

		s = this.hero.skills.heal

		if initial and s.level > 0 then
			local hb = E:get_template("decal_regson_heal_ball")

			hb.hp_factor = s.heal_factor[s.level]
		end

		s = this.hero.skills.path

		if s.level > 0 then
			this.health.hp_max = this.health.hp_max + s.extra_hp[s.level]
		end

		s = this.hero.skills.slash

		if initial and s.level > 0 then
			local a = this.melee.attacks[6]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.damage_max = s.damage_max[s.level]
			m.damage_min = s.damage_min[s.level]

			local a = this.melee.attacks[7]

			local m = T(a.mod)

			m.damage_max = s.damage_max[s.level]
			m.damage_min = s.damage_max[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local u = E:get_template("hero_regson_ultimate")

			u.cooldown = s.cooldown[s.level]
			u.damage_boss = s.damage_boss[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.aura_regson_blade.update(this, store)
		local hero = store.entities[this.aura.source_id]
		local a = hero.melee.attacks
		local slash = hero.hero.skills.slash

		if not hero then
			log.error("hero not found for aura_regson_blade")
			queue_remove(store, this)

			return
		end

		this.blade_ts = store.tick_ts

		while true do
			if this.blade_active and store.tick_ts - this.blade_active_ts > this.blade_duration then
				this.blade_active = false
				this.blade_ts = store.tick_ts

				for i = 1, 3 do
					a[i].disabled = nil
				end

				a[6].disabled = slash.level == 0
				a[7].disabled = true

				for i = 4, 5 do
					a[i].disabled = true
				end

				hero.idle_flip.animations[1] = "idle"
				hero.render.sprites[1].angles.walk[1] = "run"
			elseif not this.blade_active and U.is_blocked_valid(store, hero) and store.tick_ts - this.blade_ts > this.blade_cooldown then
				hero.blade_pending = true
				this.blade_active = true
				this.blade_active_ts = store.tick_ts

				for i = 1, 3 do
					a[i].disabled = true
				end

				a[6].disabled = true
				a[7].disabled = slash.level == 0

				for i = 4, 5 do
					a[i].disabled = nil
				end

				hero.idle_flip.animations[1] = "berserk_idle"
				hero.render.sprites[1].angles.walk[1] = "berserk_run"
			end

			coroutine.yield()
		end
	end

	-- 大瑞格
	function scripts.hero_rag.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta, ranged_done

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_144_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[4]
				skill = this.hero.skills.raggified

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
						a.vis_flags, a.vis_bans, function(e)
							return e.health.hp < a.max_target_hp and GR:cell_is_only(e.pos.x, e.pos.y, TERRAIN_LAND)
						end)

					if not targets then
						SU.delay_attack(store, a, 0.16666666666666666)
					else
						table.sort(targets, function(e1, e2)
							return e1.health.hp > e2.health.hp
						end)

						local target = targets[1]
						a.ts = store.tick_ts

						if not SU.y_soldier_do_ranged_attack(store, this, target, a) then
							goto label_144_0
						end
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.kamihare

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.range_nodes_min,
						a.range_nodes_max, nil, a.vis_flags, a.vis_bans, true, function(e)
							return not U.flag_has(P:path_terrain_props(e.nav_path.pi), TERRAIN_FAERIE)
						end)

					if not target_info then
						SU.delay_attack(store, a, 0.16666666666666666)
					else
						local target = target_info[1].enemy
						local origin = target_info[1].origin
						local start_ts = store.tick_ts
						local bullet_to_ni = origin[3] - 5
						local bullet_to = P:node_pos(origin[1], 1, bullet_to_ni)
						local flip = bullet_to.x < this.pos.x

						S:queue(a.sound, {
							delay = a.sound_delay
						})
						U.animation_start(this, a.animations[1], flip, store.tick_ts)

						if SU.y_hero_wait(store, this, a.spawn_time) then
							-- block empty
						else
							SU.hero_gain_xp_from_skill(this, skill)

							a.ts = store.tick_ts

							for i = 1, a.count do
								SU.y_hero_wait(store, this, fts(2))

								local pi, spi, ni = origin[1], km.zmod(i, 3), bullet_to_ni + math.random(-10, 0)

								if not P:is_node_valid(pi, ni) then
									log.debug("cannot spawn kamihare in invalid node: %s,%s,%s", pi, spi, ni)
								else
									local e = create_entity(a.entity)

									e.pos = P:node_pos(pi, spi, ni)
									e.nav_path.pi = pi
									e.nav_path.spi = spi
									e.nav_path.ni = ni

									local b = create_entity(a.bullet)

									b.pos.x = this.pos.x + math.random(-3, 3) + a.spawn_offset.x
									b.pos.y = this.pos.y + math.random(0, 3) + a.spawn_offset.y
									b.bullet.from = V.vclone(b.pos)
									b.bullet.to = V.vclone(e.pos)
									b.bullet.hit_payload = e
									b.render.sprites[1].flip_x = flip
									b.render.sprites[1].ts = store.tick_ts

									queue_insert(store, b)
								end
							end

							U.animation_start(this, a.animations[2], nil, store.tick_ts)
							SU.y_hero_animation_wait(this)

							a.ts = store.tick_ts
						end

						goto label_144_0
					end
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.angry_gnome

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target = U.find_random_enemy(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags,
						a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						local pred_pos = P:predict_enemy_pos(target, fts(12))
						local thing = table.random(a.things)

						a.animation = "throw_" .. thing
						a.bullet = a.bullet_prefix .. thing
						a.ts = store.tick_ts

						if not SU.y_soldier_do_ranged_attack(store, this, target, a, pred_pos) then
							goto label_144_0
						end
					end
				end

				a = this.timed_attacks.list[3]
				skill = this.hero.skills.hammer_time

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local nodes, start_node, end_node, next_node, damage_ts
					local target, targets = U.find_nearest_enemy(store.entities, this.pos, 0, a.max_range, a.vis_flags,
						a.vis_bans)
					local total_hp = not targets and 0 or table.reduce(targets, function(e, hp_sum)
						return e.health.hp + hp_sum
					end)

					if not target or total_hp < a.trigger_hp then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						U.unblock_target(store, this)
						S:queue(a.sound_loop)
						U.y_animation_play(this, a.animations[1], nil, store.tick_ts)

						if SU.hero_interrupted(this) then
							-- block empty
						else
							SU.hero_gain_xp_from_skill(this, skill)

							a.ts = store.tick_ts
							nodes = P:nearest_nodes(this.pos.x, this.pos.y, {
								target.nav_path.pi
							}, nil, true)

							if #nodes == 0 then
								log.error("hammer_time could not find a valid node near %s,%s", this.pos.x, this.pos.y)

								goto label_144_0
							end

							start_node = {
								pi = nodes[1][1],
								spi = nodes[1][2],
								ni = nodes[1][3]
							}
							end_node = table.deepclone(target.nav_path)
							next_node = table.deepclone(start_node)
							next_node.dir = start_node.ni > end_node.ni and -1 or 1
							end_node.ni = next_node.dir * a.nodes_range + start_node.ni

							U.animation_start(this, a.animations[2], nil, store.tick_ts, true)

							damage_ts = store.tick_ts - a.damage_every

							while store.tick_ts - a.ts < a.duration and not SU.hero_interrupted(this) do
								if U.walk(this, store.tick_length) then
									if math.abs(next_node.ni - start_node.ni) == a.nodes_range then
										next_node.dir = next_node.dir * -1
									end

									next_node.ni = next_node.ni + next_node.dir
									next_node.spi = next_node.spi == 3 and 2 or 3

									U.set_destination(this, P:node_pos(next_node))

									this.render.sprites[1].flip_x = this.motion.dest.x < this.pos.x
								end

								if store.tick_ts - damage_ts >= a.damage_every then
									damage_ts = store.tick_ts

									S:queue(a.sound_hit)

									local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.damage_radius,
										a.vis_flags, a.vis_bans)

									if targets then
										for _, t in pairs(targets) do
											local d = SU.create_attack_damage(a, t.id, this.id)

											queue_damage(store, d)

											local m = create_entity(a.mod)

											m.modifier.source_id = this.id
											m.modifier.target_id = t.id

											queue_insert(store, m)
										end
									end
								end

								coroutine.yield()
							end
						end

						a.ts = store.tick_ts

						S:stop(a.sound_loop)
						U.y_animation_play(this, a.animations[3], nil, store.tick_ts)

						goto label_144_0
					end
				end

				if not ranged_done then
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk then
						goto label_144_0
					end

					if sta == A_DONE then
						ranged_done = true
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta == A_DONE or sta == A_NO_TARGET then
					ranged_done = nil
				end

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_144_0::

			coroutine.yield()
		end
	end

	-- 树人
	function scripts.hero_bravebark.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local s

		s = this.hero.skills.rootspikes

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.ts = store.tick_ts
			a.damage_max = s.damage_max[s.level]
			a.damage_min = s.damage_min[s.level]
		end

		s = this.hero.skills.oakseeds

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[2]

			a.disabled = nil
			a.ts = store.tick_ts

			local st = E:get_template(a.entity)

			st.health.hp_max = s.soldier_hp_max[s.level]
			st.melee.attacks[1].damage_max = s.soldier_damage_max[s.level]
			st.melee.attacks[1].damage_min = s.soldier_damage_min[s.level]
		end

		s = this.hero.skills.branchball

		if initial and s.level > 0 then
			local a = this.melee.attacks[2]

			a.trigger_min_hp = s.trigger_min_hp[s.level]
			a.disabled = nil
			a.ts = store.tick_ts
		end

		s = this.hero.skills.springsap

		if initial and s.level > 0 then
			local a = this.springsap

			a.disabled = nil
			a.ts = store.tick_ts

			local aura = E:get_template(a.aura)

			aura.aura.duration = s.duration[s.level]

			local mod = E:get_template(aura.aura.mod)

			mod.hps.heal_min = s.hp_per_cycle[s.level]
			mod.hps.heal_max = s.hp_per_cycle[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local u = E:get_template("hero_bravebark_ultimate")

			u.count = s.count[s.level]
			u.damage = s.damage[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	scripts.soldier_bravebark = {}
	function scripts.soldier_bravebark.update(this, store, script)
		local brk, stam, star

		this.reinforcement.ts = store.tick_ts
		this.render.sprites[1].ts = store.tick_ts

		if this.reinforcement.fade or this.reinforcement.fade_in then
			SU.y_reinforcement_fade_in(store, this)
		elseif this.render.sprites[1].name == "raise" then
			if this.sound_events and this.sound_events.raise then
				S:queue(this.sound_events.raise)
			end

			this.health_bar.hidden = true

			U.y_animation_play(this, "raise", nil, store.tick_ts, 1)

			if not this.health.dead then
				this.health_bar.hidden = nil
			end
		end

		while true do
			if this.health.dead or this.reinforcement.duration and store.tick_ts - this.reinforcement.ts > this.reinforcement.duration then
				if this.health.hp > 0 then
					this.reinforcement.hp_before_timeout = this.health.hp
				end

				store.player_gold = store.player_gold + this.gold

				this.health.hp = 0

				SU.y_soldier_death(store, this)

				return
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				SU.soldier_courage_upgrade(store, this)

				if this.melee then
					brk, stam = SU.y_soldier_melee_block_and_attacks(store, this)

					if brk or stam == A_DONE or stam == A_IN_COOLDOWN and not this.melee.continue_in_cooldown then
						goto label_33_1
					end
				end

				if this.ranged then
					brk, star = SU.y_soldier_ranged_attacks(store, this)

					if brk or star == A_DONE then
						goto label_33_1
					elseif star == A_IN_COOLDOWN then
						goto label_33_0
					end
				end

				if this.melee.continue_in_cooldown and stam == A_IN_COOLDOWN then
					goto label_33_1
				end

				if SU.soldier_go_back_step(store, this) then
					goto label_33_1
				end

				::label_33_0::

				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end

			::label_33_1::

			coroutine.yield()
		end
	end

	function scripts.hero_bravebark_ultimate.update(this, store)
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true, NF_POWER_3)

		if #nodes < 1 then
			log.error("hero_bravebark_ultimate: could not find valid node")
			queue_remove(store, this)

			return
		end

		local node_f = {
			pi = nodes[1][1],
			spi = math.random(1, 3),
			ni = nodes[1][3]
		}
		local node_b = {
			pi = nodes[1][1],
			spi = math.random(1, 3),
			ni = nodes[1][3]
		}
		local count = this.count
		local dir = 1
		local node

		for i = 1, 2 * count do
			node = dir == 1 and node_f or node_b

			local node_pos = P:node_pos(node.pi, node.spi, node.ni)

			if P:is_node_valid(node.pi, node.ni) and not GR:cell_is(node_pos.x, node_pos.y, TERRAIN_FAERIE) then
				local nni = node.ni + dir * math.random(this.sep_nodes_min, this.sep_nodes_max - 1)
				local nspi = km.zmod(node.spi + math.random(1, 2), 3)

				node.spi, node.ni = nspi, nni

				local e = create_entity(this.decal)

				e.render.sprites[1].prefix = e.render.sprites[1].prefix .. math.random(1, 3)
				e.pos = node_pos
				e.render.sprites[1].ts = store.tick_ts

				queue_insert(store, e)

				local targets = U.find_enemies_in_range(store.entities, e.pos, 0, this.damage_radius, this.vis_flags,
					this.vis_bans)

				if targets then
					local e = create_entity(this.entity)

					e.pos = node_pos
					e.nav_rally.center = V.vclone(e.pos)
					e.nav_rally.pos = V.vclone(e.pos)

					queue_insert(store, e)

					for _, target in pairs(targets) do
						local m = create_entity(this.mod)

						m.modifier.target_id = target.id
						m.modifier.source_id = this.id

						queue_insert(store, m)

						local d = create_entity("damage")

						d.value = this.damage
						d.source_id = this.id
						d.target_id = target.id

						queue_damage(store, d)
					end
				end

				if count % 2 == 0 then
					U.y_wait(store, U.frandom(this.show_delay_min, this.show_delay_max))
				end

				count = count - 1
			end

			if count <= 0 then
				break
			end

			dir = -1 * dir
		end

		queue_remove(store, this)
	end

	function scripts.hero_bravebark.fn_can_branchball(this, store, a, target)
		return target.health.hp >= a.trigger_min_hp
	end

	-- 维兹南
	function scripts.hero_veznan.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_154_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[3]
				skill = this.hero.skills.arcanenova

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local target, targets = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range,
						a.cast_time, a.vis_flags, a.vis_bans)

					if not target or #targets < 2 then
						SU.delay_attack(store, a, 0.3333333333333333)
					else
						local af = target.pos.x < this.pos.x

						U.animation_start(this, a.animation, af, store.tick_ts, false)
						U.y_wait(store, a.hit_time)

						local node = table.deepclone(target.nav_path)

						node.spi = 1

						local node_pos = P:node_pos(node)
						local targets = U.find_enemies_in_range(store.entities, node_pos, 0, a.damage_radius, a
							.vis_flags, a.vis_bans)

						if targets then
							SU.hero_gain_xp_from_skill(this, skill)

							for _, t in pairs(targets) do
								queue_damage(store, SU.create_attack_damage(a, t.id, this.id))

								local m = create_entity(a.mod)

								m.modifier.source_id = this.id
								m.modifier.target_id = t.id

								queue_insert(store, m)
							end
						end

						S:queue(a.cast_sound)

						local fx = create_entity(a.hit_fx)

						fx.pos.x, fx.pos.y = node_pos.x, node_pos.y

						U.animation_start(fx, nil, nil, store.tick_ts, false)
						queue_insert(store, fx)
						U.y_wait(store, fts(5))

						local decal = create_entity(a.hit_decal)

						decal.pos.x, decal.pos.y = node_pos.x, node_pos.y
						decal.tween.ts = store.tick_ts
						decal.render.sprites[2].ts = store.tick_ts

						queue_insert(store, decal)
						U.y_animation_wait(this)

						a.ts = store.tick_ts
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.shackles

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local triggers = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags,
						a.vis_bans)

					if not triggers then
						SU.delay_attack(store, a, 0.3333333333333333)
					else
						local first_target = table.random(triggers)
						local targets = U.find_enemies_in_range(store.entities, first_target.pos, 0, a.radius,
							a.vis_flags, a.vis_bans)
						local af = first_target.pos.x < this.pos.x

						U.animation_start(this, a.animation, af, store.tick_ts, false)
						U.y_wait(store, a.cast_time)
						S:queue(a.cast_sound)
						SU.hero_gain_xp_from_skill(this, skill)

						for i = 1, math.min(#targets, a.max_count) do
							local target = targets[i]

							for _, m_name in pairs(a.mods) do
								local m = create_entity(m_name)

								m.modifier.target_id = target.id
								m.modifier.source_id = this.id

								queue_insert(store, m)
							end
						end

						U.y_animation_wait(this)

						a.ts = store.tick_ts
					end
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.soulburn

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local triggers = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags,
						a.vis_bans, function(e)
							return skill.level == 3 or e.health.hp_max <= a.total_hp
						end)

					if not triggers then
						SU.delay_attack(store, a, 0.3333333333333333)
					else
						local e_hp = 0
						for _, e in pairs(triggers) do
							e_hp = e_hp + e.health.hp
						end

						if e_hp <= a.total_hp * a.trigger_min_total_hp then
							goto label_154_1
						end

						table.sort(triggers, function(e1, e2)
							return e1.health.hp > e2.health.hp
						end)

						local targets = {}
						local first_target = triggers[1]

						table.insert(targets, first_target)

						local hp_count = first_target.health.hp

						if hp_count < a.total_hp then
							for _, t in pairs(triggers) do
								if t ~= first_target and hp_count + t.health.hp_max <= a.total_hp and U.is_inside_ellipse(t.pos, first_target.pos, a.radius) then
									table.insert(targets, t)

									hp_count = hp_count + t.health.hp_max
								end
							end
						end

						S:queue(a.sound)

						local af = first_target.pos.x < this.pos.x

						U.animation_start(this, a.animations[1], af, store.tick_ts, false)
						U.y_wait(store, a.cast_time)

						local balls = {}
						local o = V.v(a.balls_dest_offset.x * (this.render.sprites[1].flip_x and -1 or 1),
							a.balls_dest_offset.y)

						for _, target in pairs(targets) do
							local d = create_entity("damage")

							d.damage_type = DAMAGE_EAT
							d.target_id = target.id
							d.source_id = this.id

							queue_damage(store, d)

							local fx = create_entity(a.hit_fx)

							fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
							fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
							fx.render.sprites[1].ts = store.tick_ts

							queue_insert(store, fx)

							local b = create_entity(a.ball)

							b.from = V.v(target.pos.x + target.unit.mod_offset.x, target.pos.y + target.unit.mod_offset
								.y)
							b.to = V.v(this.pos.x + o.x, this.pos.y + o.y)
							b.pos = V.vclone(b.from)
							b.target = target

							queue_insert(store, b)
							table.insert(balls, b)
						end

						U.y_animation_wait(this)
						U.animation_start(this, a.animations[2], nil, store.tick_ts, true)

						while true do
							coroutine.yield()

							local arrived = true

							for _, ball in pairs(balls) do
								arrived = arrived and ball.arrived
							end

							if arrived then
								break
							end

							if h.dead then
								goto label_154_0
							end
						end

						SU.hero_gain_xp_from_skill(this, skill)
						U.animation_start(this, a.animations[3], nil, store.tick_ts, false)
						U.y_animation_wait(this)

						a.ts = store.tick_ts
					end
				end

				::label_154_1::

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				else
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk then
						-- block empty
					elseif SU.soldier_go_back_step(store, this) then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_154_0::

			coroutine.yield()
		end
	end

	-- 火凤凰
	function scripts.hero_phoenix.insert(this, store)
		if not scripts.hero_basic.insert(this, store) then
			return false
		end

		if this.hero.skills.purification.level > 0 then
			local a = create_entity("aura_phoenix_purification")

			a.aura.source_id = this.id
			a.aura.ts = store.tick_ts
			a.pos = this.pos

			queue_insert(store, a)
		end

		if this.hero.skills.inmolate.level > 0 then
			local a = create_entity(this.auras.list[1].name)

			a.aura.source_id = this.id
			a.aura.ts = store.tick_ts

			queue_insert(store, a)
		end

		return true
	end

	function scripts.hero_phoenix.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		local b = E:get_template(this.ranged.attacks[1].bullet)
		local ba = E:get_template(b.bullet.hit_payload)

		ba.aura.damage_max = ls.ranged_damage_max[hl]
		ba.aura.damage_min = ls.ranged_damage_min[hl]

		local a = E:get_template("aura_phoenix_egg")

		a.custom_attack.damage_max = ls.egg_explosion_damage_max[hl]
		a.custom_attack.damage_min = ls.egg_explosion_damage_min[hl]

		local m = E:get_template(a.aura.mod)

		m.dps.damage_min = ls.egg_damage[hl]
		m.dps.damage_max = ls.egg_damage[hl]

		local s

		s = this.hero.skills.inmolate

		if initial and s.level > 0 then
			local sd = this.selfdestruct

			sd.disabled = nil
			sd.damage_min = s.damage_min[s.level]
			sd.damage_max = s.damage_max[s.level]

			local a = this.timed_attacks.list[1]

			a.disabled = nil

			T("inmolate_aura_phoenix").every_damage = s.every_damage[s.level]
		end

		s = this.hero.skills.purification

		if initial and s.level > 0 then
			local au = E:get_template("aura_phoenix_purification")

			au.aura.targets_per_cycle = s.max_targets[s.evel]

			local b = E:get_template("missile_phoenix_small")

			b.bullet.damage_max = s.damage_max[s.level]
			b.bullet.damage_min = s.damage_min[s.level]
		end

		s = this.hero.skills.blazing_offspring

		if initial and s.level > 0 then
			local a = this.ranged.attacks[2]

			a.disabled = nil
			a.shoot_times = {}

			for i = 1, s.count[s.level] do
				table.insert(a.shoot_times, fts(4))
			end

			local b = E:get_template(a.bullet)

			b.bullet.damage_max = s.damage_max[s.level]
			b.bullet.damage_min = s.damage_min[s.level]
		end

		s = this.hero.skills.flaming_path

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[2]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.custom_attack.damage = s.damage[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local au = E:get_template(s.controller_name)

			au.aura.damage_max = s.damage_max[s.level]
			au.aura.damage_min = s.damage_min[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	scripts.inmolate_aura_phoenix = {}

	function scripts.inmolate_aura_phoenix.update(this, store)
		local hero = store.entities[this.aura.source_id]
		local last_ts = store.tick_ts

		while true do
			if not hero.health.dead and store.tick_ts - last_ts > this.every_damage then
				last_ts = store.tick_ts
				hero.health.hp = km.clamp(0, hero.health.hp_max, hero.health.hp - this.damage)
			end

			coroutine.yield()
		end
	end

	-- 莉恩
	function scripts.hero_lynn.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[2].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[2].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[4].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[4].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[5].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[5].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[6].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[6].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[7].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[7].damage_max = ls.melee_damage_max[hl]

		local s

		s = this.hero.skills.hexfury

		if initial and s.level > 0 then
			this.melee.attacks[3].loops = s.loops[s.level]
			this.melee.attacks[3].disabled = nil
		end

		s = this.hero.skills.despair

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.modifier.duration = s.duration[s.level]
			m.speed_factor = s.speed_factor[s.level]
			m.inflicted_damage_factor = s.damage_factor[s.level]
		end

		s = this.hero.skills.weakening

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[2]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.modifier.duration = s.duration[s.level]
			m.armor_reduction = s.armor_reduction[s.level]
			m.magic_armor_reduction = s.magic_armor_reduction[s.level]
		end

		s = this.hero.skills.charm_of_unluck

		if initial and s.level > 0 then
			this.dodge.chance = s.chance[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local m = E:get_template("mod_lynn_ultimate")

			m.dps.damage_max = s.damage[s.level]
			m.dps.damage_min = s.damage[s.level]
			m.explode_damage = s.explode_damage[s.level]

			if s.level > 0 then
				this.melee.attacks[1].mod = "mod_lynn_ultimate_s"
				this.melee.attacks[2].mod = "mod_lynn_ultimate_s"
			end
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_lynn.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		this.health_bar.hidden = false

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				if this.dodge and this.dodge.active and this.dodge.last_check_ts ~= store.tick_ts then
					this.dodge.active = nil
				end

				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_183_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.despair

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a
						.vis_bans)

					if not targets or #targets < a.min_count then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound, a.sound_args)
						U.animation_start(this, a.animation, nil, store.tick_ts)

						if SU.y_hero_wait(store, this, a.hit_time) then
							-- block empty
						else
							SU.hero_gain_xp_from_skill(this, skill)

							a.ts = store.tick_ts
							targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags,
								a.vis_bans)

							if targets then
								for i, target in ipairs(targets) do
									if i > a.max_count then
										break
									end

									local m = create_entity(a.mod)

									m.modifier.source_id = this.id
									m.modifier.target_id = target.id

									queue_insert(store, m)
								end
							end

							SU.y_hero_animation_wait(this)
						end

						goto label_183_0
					end
				end

				a = this.timed_attacks.list[2]
				skill = this.hero.skills.weakening

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local blocked = U.get_blocked(store, this)

					if not blocked or blocked.health.armor == 0 and blocked.health.magic_armor == 0 or not U.is_blocked_valid(store, this) then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound, a.sound_args)
						U.animation_start(this, a.animation, nil, store.tick_ts)

						if SU.y_hero_wait(store, this, a.hit_time) then
							-- block empty
						else
							a.ts = store.tick_ts
							blocked = U.get_blocked(store, this)

							if blocked and U.is_blocked_valid(store, this) then
								SU.hero_gain_xp_from_skill(this, skill)

								local m = create_entity(a.mod)

								m.modifier.source_id = this.id
								m.modifier.target_id = blocked.id

								queue_insert(store, m)
							end

							SU.y_hero_animation_wait(this)
						end

						goto label_183_0
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta == A_DONE then
					local m = this.melee
					local ma = m.attacks

					if (not m.alreadymelee or m.alreadymelee == 1) and this.hero.skills.weakening.level > 0 then
						m.alreadymelee = 4
						ma[4].disabled = nil
						ma[5].disabled = nil
						ma[1].disabled = true
						ma[2].disabled = true
						ma[6].disabled = true
						ma[7].disabled = true
					elseif m.alreadymelee == 4 and this.hero.skills.despair.level > 0 then
						m.alreadymelee = 6
						ma[6].disabled = nil
						ma[7].disabled = nil
						ma[1].disabled = true
						ma[2].disabled = true
						ma[4].disabled = true
						ma[5].disabled = true
					elseif m.alreadymelee == 6 and this.hero.skills.ultimate.level > 0 then
						m.alreadymelee = 1
						ma[1].disabled = nil
						ma[2].disabled = nil
						ma[4].disabled = true
						ma[5].disabled = true
						ma[6].disabled = true
						ma[7].disabled = true
					end
				end

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_183_0::

			coroutine.yield()
		end
	end

	function scripts.hero_lynn.fn_damage_melee(this, store, attack, target)
		local skill = this.hero.skills.hexfury
		local value = math.ceil(this.unit.damage_factor * math.random(attack.damage_min, attack.damage_max))
		local mods = {
			"mod_lynn_curse",
			"mod_lynn_despair",
			"mod_lynn_ultimate",
			"mod_lynn_weakening",
			"mod_lynn_ultimate_s",
			"mod_lynn_weakening_s",
			"mod_lynn_despair_s"
		}

		if skill.level > 0 and U.has_modifier_in_list(store, target, mods) then
			value = value + math.ceil(this.unit.damage_factor * skill.extra_damage)

			log.debug(" fn_damage_melee LYNN: +++ adding extra damage %s", skill.extra_damage)
		end

		return value
	end

	-- 狮王
	function scripts.hero_bruce.insert(this, store)
		if not scripts.hero_basic.insert(this, store) then
			return false
		end

		local a = create_entity("aura_bruce_hps")

		a.aura.source_id = this.id
		a.aura.ts = store.tick_ts
		a.pos = this.pos

		queue_insert(store, a)

		if this.hero.skills.lions_fur.level > 0 then
			local a = create_entity(this.auras.list[1].name)

			a.aura.source_id = this.id

			queue_insert(store, a)
		end

		return true
	end

	function scripts.hero_bruce.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[2].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[2].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[3].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[3].damage_max = ls.melee_damage_max[hl]

		local s

		s = this.hero.skills.sharp_claws

		if initial and s.level > 0 then
			local a = this.melee.attacks[3]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.dps.damage_min = s.damage[s.level]
			m.dps.damage_max = s.damage[s.level]
			m.extra_bleeding_damage = s.extra_damage[s.level]
		end

		s = this.hero.skills.kings_roar

		if initial and s.level > 0 then
			local a = this.timed_attacks.list[1]

			a.disabled = nil

			local m = E:get_template(a.mod)

			m.modifier.duration = s.stun_duration[s.level]

			T("aura_bruce_every_hp").aura.every_hp = s.every_hp[s.level]
		end

		s = this.hero.skills.lions_fur

		if s.level > 0 then
			this.health.hp_max = this.health.hp_max + s.extra_hp[s.level]

			T("aura_bruce_hps").hps.heal_every = s.heal_every[s.level]
		end

		s = this.hero.skills.grievous_bites

		if initial and s.level > 0 then
			local a = this.melee.attacks[4]

			a.disabled = nil
			a.damage_max = s.damage[s.level]
			a.damage_min = s.damage[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local u = E:get_template(s.controller_name)

			u.count = s.count[s.level]

			local e = E:get_template(u.entity)

			e.custom_attack.damage_boss = s.damage_boss[s.level]

			local m = E:get_template("mod_lion_bruce_damage")

			m.dps.damage_max = s.damage_per_tick[s.level]
			m.dps.damage_min = s.damage_per_tick[s.level]
		end

		this.health.hp = this.health.hp_max
	end

	function scripts.hero_bruce.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill, brk, sta

		this.health_bar.hidden = false

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)

		while true do
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_174_0
					end
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				a = this.timed_attacks.list[1]
				skill = this.hero.skills.kings_roar

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a
						.vis_bans)

					if not targets or #targets < a.min_count then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound, a.sound_args)
						U.animation_start(this, a.animation, nil, store.tick_ts)

						if SU.y_hero_wait(store, this, a.hit_time) then
							-- block empty
						else
							SU.hero_gain_xp_from_skill(this, skill)

							a.ts = store.tick_ts
							targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, a.vis_flags,
								a.vis_bans)

							if targets then
								for i, target in ipairs(targets) do
									if i > a.max_count then
										break
									end

									local m = create_entity(a.mod)

									m.modifier.source_id = this.id
									m.modifier.target_id = target.id

									queue_insert(store, m)
								end
							end

							h.hp = km.clamp(h.hp - skill.damage[skill.level], 100, h.hp_max)
							h.hp = h.hp + (h.hp_max - h.hp) * skill.heal_hp[skill.level]

							SU.y_hero_animation_wait(this)
						end

						goto label_174_0
					end
				end

				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_174_0::

			coroutine.yield()
		end
	end

	function scripts.hero_bruce.fn_chance_sharp_claws(this, store, attack, target)
		return U.has_modifier_types(store, target, MOD_TYPE_BLEED) or
			this.health.hp < this.health.hp_max * attack.trigger_hp or
			math.random() < attack.chance
	end

	function scripts.mod_bruce_sharp_claws.insert(this, store)
		local target = store.entities[this.modifier.target_id]
		local hero = store.entities[this.modifier.source_id]

		if not target then
			log.debug("mod_bruce_sharp_claws:%s cannot find target with id:%s", this.id, this.modifier.target_id)

			return false
		end

		local has_mods, mods = U.has_modifier_types(store, target, this.modifier.type)

		if has_mods then
			local d = create_entity("damage")

			d.value = this.extra_bleeding_damage
			d.target_id = target.id
			d.source_id = this.id

			queue_damage(store, d)

			hero.health.hp = km.clamp(0, hero.health.hp_max, hero.health.hp + this.heal_hp)

			return false
		else
			if not scripts.mod_dps.insert(this, store) then
				return false
			end

			local ref = store.entities[this.modifier.source_id]

			if ref then
				SU.hero_gain_xp_from_skill(ref, ref.hero.skills[this.xp_from_skill])
			end

			return true
		end
	end

	scripts.aura_bruce_every_hp = {}
	function scripts.aura_bruce_every_hp.update(this, store)
		local owner = store.entities[this.aura.source_id]

		local every_hp = this.aura.every_hp
		local hp_max = owner.health.hp_max
		local hp_loss = 0
		local hp_last = hp_max

		while true do
			local hp = owner.health.hp

			if hp > 0 and not owner.health.dead then
				local hp_l = hp_last - hp -- 此前血量与当前血量之差，正数损失血量，负数回血量

				if hp_l > 0 then -- 如果损失血量则计入
					hp_loss = hp_loss + hp_l

					while hp_loss >= every_hp do
						-- 当损失血量大于等于设定的阈值
						hp_loss = hp_loss - every_hp

						local power_ts = utils_UH.get_power_ts(store, 3, 13)

						utils_UH.set_power_ts(power_ts - this.aura.every_tick, 3, 13)
					end
				end

				hp_last = hp
			else
				hp_last = hp_max
				hp_loss = 0
			end

			coroutine.yield()
		end
	end

	-- 堕天使
	scripts.aura_lilith_soul_eater = {}

	function scripts.aura_lilith_soul_eater.update(this, store)
		local a = this.aura
		local hero = store.entities[a.source_id]
		local last_ts = store.tick_ts

		if not hero then
			log.error("hero not found for aura_lilith_soul_eater")
			queue_remove(store, this)

			return
		end

		while true do
			hero.soul_eater.active = store.tick_ts - hero.soul_eater.last_ts >= a.cooldown

			if not hero.health.dead and hero.soul_eater.active and store.tick_ts - last_ts >= a.cycle_time then
				last_ts = store.tick_ts

				local triggers = U.find_enemies_in_range(store.entities, hero.pos, 0, a.radius, a.vis_flags, a.vis_bans,
					function(e)
						return not table.contains(a.excluded_templates, e.template_name)
					end)

				if not triggers then
					last_ts = store.tick_ts - this.aura.cooldown + 0.3333333333333333 - 1e-06
				else
					table.sort(triggers, function(e1, e2)
						return e1.melee.attacks[1].damage_max > e2.melee.attacks[1].damage_max
					end)

					local first_target = triggers[1]

					if first_target and first_target.melee.attacks[1].damage_max > this.limit_min_damage then
						local m = create_entity(a.mod)

						m.modifier.source_id = hero.id
						m.modifier.target_id = first_target.id

						queue_insert(store, m)
					else
						last_ts = store.tick_ts - this.aura.cooldown + 0.3333333333333333 - 1e-06
					end
				end
			end

			coroutine.yield()
		end
	end

	-- 浮士德
	function scripts.hero_faustus.get_info(this)
		local m = E:get_template("bolt_faustus")
		local c = this.ranged.attacks[1].bullet_count
		local min, max = c * m.bullet.damage_min, c * m.bullet.damage_max

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

	function scripts.hero_faustus.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]

		local b = E:get_template(this.ranged.attacks[1].bullet)

		b.bullet.damage_max = ls.ranged_damage_max[hl]
		b.bullet.damage_min = ls.ranged_damage_min[hl]

		local s

		s = this.hero.skills.dragon_lance

		if initial and s.level > 0 then
			local a = this.ranged.attacks[2]

			a.disabled = nil

			local b = E:get_template(a.bullet)

			b.bullet.damage_max = s.damage_max[s.level]
			b.bullet.damage_min = s.damage_min[s.level]
		end

		s = this.hero.skills.teleport_rune

		if initial and s.level > 0 then
			local a = this.ranged.attacks[3]

			a.disabled = nil

			local aura = E:get_template(a.bullet)

			aura.aura.targets_per_cycle = s.max_targets[s.level]
		end

		s = this.hero.skills.enervation

		if initial and s.level > 0 then
			local a = this.ranged.attacks[4]

			a.disabled = nil

			local aura = E:get_template(a.bullet)

			aura.aura.targets_per_cycle = s.max_targets[s.level]

			local mod = E:get_template(aura.aura.mod)

			mod.modifier.duration = s.duration[s.level]

			T("mod_liquid_fire_faustus_l").dps.damage_max = s.mod_damage[s.level]
			T("mod_liquid_fire_faustus_l").dps.damage_min = s.mod_damage[s.level]
			T("mod_liquid_fire_faustus_l").modifier.duration = s.duration[s.level]
		end

		s = this.hero.skills.liquid_fire

		if initial and s.level > 0 then
			local a = this.ranged.attacks[5]

			a.disabled = nil

			local b = E:get_template(a.bullet)

			b.flames_count = s.flames_count[s.level]

			local m = E:get_template("mod_liquid_fire_faustus")

			m.dps.damage_max = s.mod_damage[s.level]
			m.dps.damage_min = s.mod_damage[s.level]
		end

		s = this.hero.skills.ultimate

		if initial then
			local m = E:get_template("mod_minidragon_faustus")

			m.dps.damage_max = s.mod_damage[s.level]
			m.dps.damage_min = s.mod_damage[s.level]
		end

		this.health.hp = this.health.hp_max
	end
end

function scripts_UH:enhance4()
end

function scripts_UH:enhance5()
	local function y_hero_melee_block_and_attacks(store, hero)
		local target = SU.soldier_pick_melee_target(store, hero)

		if not target then
			return false, A_NO_TARGET
		end

		if SU.soldier_move_to_slot_step(store, hero, target) then
			return true
		end

		local attack = SU.soldier_pick_melee_attack(store, hero, target)

		if not attack then
			return false, A_IN_COOLDOWN
		end

		local upg = UP:get_upgrade("heroes_lethal_focus")
		local triggered_lethal_focus = false
		local attack_pop = attack.pop
		local attack_pop_chance = attack.pop_chance

		if attack.basic_attack and upg then
			if not hero._lethal_focus_deck then
				hero._lethal_focus_deck = SU.deck_new(upg.trigger_cards, upg.total_cards)
			end

			triggered_lethal_focus = SU.deck_draw(hero._lethal_focus_deck)
		end

		if triggered_lethal_focus then
			hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor
			attack.pop = {
				"pop_crit_heroes"
			}
			attack.pop_chance = 1
		end

		if attack.xp_from_skill then
			SU.hero_gain_xp_from_skill(hero, hero.hero.skills[attack.xp_from_skill])
		end

		local attack_done

		if attack.loops then
			attack_done = SU.y_soldier_do_loopable_melee_attack(store, hero, target, attack)
		elseif attack.type == "area" then
			attack_done = SU.y_soldier_do_single_area_attack(store, hero, target, attack)
		else
			attack_done = SU.y_soldier_do_single_melee_attack(store, hero, target, attack)
		end

		if triggered_lethal_focus then
			hero.unit.damage_factor = hero.unit.damage_factor / upg.damage_factor
			attack.pop = attack_pop
			attack.pop_chance = attack_pop_chance
		end

		if attack_done then
			return false, A_DONE
		else
			return true
		end
	end

	local function y_hero_ranged_attacks(store, hero)
		local target, attack, pred_pos = SU.soldier_pick_ranged_target_and_attack(store, hero)

		if not target then
			return false, A_NO_TARGET
		end

		if not attack then
			return false, A_IN_COOLDOWN
		end

		local upg = UP:get_upgrade("heroes_lethal_focus")
		local triggered_lethal_focus = false
		local bullet_t = E:get_template(attack.bullet)
		local bullet_use_unit_damage_factor = bullet_t.bullet.use_unit_damage_factor
		local bullet_pop = bullet_t.bullet.pop
		local bullet_pop_conds = bullet_t.bullet.pop_conds

		if attack.basic_attack and upg then
			if not hero._lethal_focus_deck then
				hero._lethal_focus_deck = SU.deck_new(upg.trigger_cards, upg.total_cards)
			end

			triggered_lethal_focus = SU.deck_draw(hero._lethal_focus_deck)
		end

		if triggered_lethal_focus then
			if bullet_t.bullet.damage_radius > 0 then
				hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor_area
			else
				hero.unit.damage_factor = hero.unit.damage_factor * upg.damage_factor
			end

			bullet_t.bullet.use_unit_damage_factor = true
			bullet_t.bullet.pop = {
				"pop_crit"
			}
			bullet_t.bullet.pop_conds = DR_DAMAGE
		end

		local start_ts = store.tick_ts
		local attack_done

		U.set_destination(hero, hero.pos)

		if attack.loops then
			attack_done = SU.y_soldier_do_loopable_ranged_attack(store, hero, target, attack)
		else
			attack_done = SU.y_soldier_do_ranged_attack(store, hero, target, attack, pred_pos)
		end

		if attack_done then
			attack.ts = start_ts

			if attack.shared_cooldown then
				for _, aa in pairs(hero.ranged.attacks) do
					if aa ~= attack and aa.shared_cooldown then
						aa.ts = attack.ts
					end
				end
			end

			if hero.ranged.forced_cooldown then
				hero.ranged.forced_ts = start_ts
			end
		end

		if triggered_lethal_focus then
			hero.unit.damage_factor = hero.unit.damage_factor / upg.damage_factor
			bullet_t.bullet.use_unit_damage_factor = bullet_use_unit_damage_factor
			bullet_t.bullet.pop = bullet_pop
			bullet_t.bullet.pop_conds = bullet_pop_conds
		end

		if attack_done then
			return false, A_DONE
		else
			return true
		end
	end

	-- 维斯珀
	function scripts5.hero_vesper.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[2].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[2].damage_max = ls.melee_damage_max[hl]

		local bt = E:get_template(this.ranged.attacks[1].bullet)

		bt.bullet.damage_min = ls.ranged_short_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_short_damage_max[hl]

		local bt = E:get_template(this.ranged.attacks[2].bullet)

		bt.bullet.damage_min = ls.ranged_long_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_long_damage_max[hl]

		local s, sl

		s = this.hero.skills.arrow_to_the_knee
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - ARROW TO THE KNEE - %i", this.template_name, hl, sl)

			local a = this.ranged.attacks[3]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local b = E:get_template(a.bullet)

			b.bullet.damage_min = s.damage_min[sl]
			b.bullet.damage_max = s.damage_max[sl]

			local m = E:get_template(b.bullet.mod)

			m.modifier.duration = s.stun_duration[sl]
		end

		s = this.hero.skills.ricochet
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - RICOCHET - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local b = E:get_template(a.bullet)

			b.bullet.damage_min = s.damage_min[sl]
			b.bullet.damage_max = s.damage_max[sl]
			b.bounces = s.bounces[sl]
		end

		s = this.hero.skills.martial_flourish
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - MARTIAL FLOURISH - %i", this.template_name, hl, sl)

			local a = this.melee.attacks[3]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]
			a.damage_min = s.damage_min[sl]
			a.damage_max = s.damage_max[sl]
		end

		s = this.hero.skills.disengage
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - DISENGAGE - %i", this.template_name, hl, sl)

			local d = this.dodge

			d.disabled = nil
			d.cooldown = s.cooldown[sl]

			local b = E:get_template(d.bullet)

			b.bullet.damage_min = s.damage_min[sl]
			b.bullet.damage_max = s.damage_max[sl]
		end

		s = this.hero.skills.ultimate
		sl = s.level

		if sl >= 0 then
			log.info("LEVELUP - %s - %i - ULTIMATE - %i", this.template_name, hl, sl)

			local uc = E:get_template(s.controller_name)

			uc.cooldown = s.cooldown[sl]

			local aura = T(this.auras.list[1].aura)
			local b = T(aura.bullet)
			b.bullet.damage_max = this.hero.skills.ultimate.arrows_aura_damage[sl]
			b.bullet.damage_min = this.hero.skills.ultimate.arrows_aura_damage[sl]
		end

		this.health.hp = this.health.hp_max
		this.hero.melee_active_status = {}

		for index, attack in ipairs(this.melee.attacks) do
			this.hero.melee_active_status[index] = attack.disabled
		end
	end

	function scripts5.hero_vesper.insert(this, store)
		this.hero.fn_level_up(this, store, true)

		this.melee.order = U.attack_order(this.melee.attacks)
		this.ranged.order = U.attack_order(this.ranged.attacks)

		if this.hero.skills.ultimate.level > 0 then
			local aura = create_entity(this.auras.list[1].aura)
			aura.aura.source_id = this.id
			aura.ts = store.tick_ts

			queue_insert(store, aura)
		end

		return true
	end

	scripts5.vesper_arrow_aura = {}
	function scripts5.vesper_arrow_aura.update(this, store)
		local distance = 2
		local count = this.arrow_count

		while true do
			if store.tick_ts - this.ts > this.aura.cycle_time then
				this.ts = store.tick_ts
				local x, y = game_gui.window:get_mouse_position()
				x, y = game_gui.window:screen_to_view(x, y)
				local wx, wy = game_gui:u2g(v(x, y))

				for i = 1, count do
					this.pos = v(wx + math.random(-8, 8) + i * 5, wy + math.random(-8, 8) + i * 3)

					U.y_wait(store, this.delay)
					local b = create_entity(this.bullet)

					b.bullet.from = V.v(this.pos.x + math.random(-170, -140), this.pos.y + REF_H)
					b.bullet.to = this.pos
					b.pos = V.vclone(b.bullet.from)

					queue_insert(store, b)
				end
			end

			coroutine.yield()
		end
	end

	-- 尼鲁
	function scripts5.hero_muyrn.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

		local bt = E:get_template(this.ranged.attacks[1].bullet)

		bt.bullet.damage_min = ls.ranged_damage_min[hl]
		bt.bullet.damage_max = ls.ranged_damage_max[hl]

		local s, sl

		s = this.hero.skills.sentinel_wisps
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - SENTINEL WISPS - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]
			a.max_summons = s.max_summons[sl]

			local e = E:get_template(a.entity)

			e.duration = s.wisp_duration[sl]

			local b = E:get_template(e.ranged.attacks[1].bullet)

			b.bullet.damage_min = s.wisp_damage_min[sl]
			b.bullet.damage_max = s.wisp_damage_max[sl]
		end

		s = this.hero.skills.verdant_blast
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - VERDANT BLAST - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[4]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local b = E:get_template(a.bullet)

			b.bullet.damage_min = s.damage_min[sl]
			b.bullet.damage_max = s.damage_max[sl]

			local a = this.timed_attacks.list[5]
			a.cooldown = s.heal_live_cooldown[sl]

			a.disabled = nil
		end

		s = this.hero.skills.leaf_whirlwind
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - LEAF WHIRLWIND - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[2]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local aura = E:get_template(a.aura)

			aura.aura.duration = s.duration[sl]
			aura.aura.damage_min = s.damage_min[sl]
			aura.aura.damage_max = s.damage_max[sl]

			local mod = E:get_template(a.mod)

			mod.modifier.duration = s.duration[sl]
			mod.hps.heal_min = s.heal_min[sl]
			mod.hps.heal_max = s.heal_max[sl]
		end

		s = this.hero.skills.faery_dust
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - FAERY DUST - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[3]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local aura = E:get_template(a.aura)
			local mod = E:get_template(aura.aura.mods[1])

			mod.inflicted_damage_factor = s.damage_factor[sl]
			mod.modifier.duration = s.duration[sl]

			local mod_fx = E:get_template(aura.aura.mods[2])

			mod_fx.modifier.duration = fts(26)
		end

		s = this.hero.skills.ultimate
		sl = s.level

		if sl >= 0 then
			log.info("LEVELUP - %s - %i - ULTIMATE - %i", this.template_name, hl, sl)

			local uc = E:get_template(s.controller_name)

			uc.cooldown = s.cooldown[sl]

			local a = E:get_template(uc.aura)
			local m_slow = E:get_template(a.aura.mods[1])

			m_slow.slow.factor = s.slow_factor[sl]

			local m_damage = E:get_template(a.aura.mods[2])

			m_damage.dps.damage_min = s.damage_min[sl]
			m_damage.dps.damage_max = s.damage_max[sl]
		end

		this.health.hp = this.health.hp_max
		this.hero.melee_active_status = {}

		for index, attack in ipairs(this.melee.attacks) do
			this.hero.melee_active_status[index] = attack.disabled
		end
	end

	function scripts5.hero_muyrn.update(this, store)
		local h = this.health
		local a, skill, brk, sta

		local function distribute_summons(x, y, qty)
			local positions = {}
			local offset_options = {
				{
					{
						0,
						20
					}
				},
				{
					{
						-20,
						0
					},
					{
						20,
						0
					}
				},
				{
					{
						0,
						15
					},
					{
						-20,
						0
					},
					{
						20,
						0
					}
				}
			}
			local offsets = offset_options[qty]

			for _, offset in ipairs(offsets) do
				if qty <= #positions then
					break
				end

				local pos = V.v(x + offset[1], y + offset[2])

				table.insert(positions, pos)
			end

			return positions
		end

		local function shoot_bullet(attack, enemy, dest, flying)
			local b = create_entity(attack.bullet)

			b.pos.x, b.pos.y = this.pos.x + attack.bullet_start_offset.x, this.pos.y + attack.bullet_start_offset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = dest
			b.bullet.target_id = enemy and enemy.id
			b.bullet.source_id = this.id

			if flying then
				b.bullet.ignore_hit_offset = false
				b.bullet.hit_fx = b.bullet.hit_fx_flying
				b.bullet.hit_decal = nil
				b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			end

			queue_insert(store, b)

			return b
		end

		this.health_bar.hidden = false

		local treewalk_trail = create_entity(this.treewalk.trail)

		treewalk_trail.particle_system.track_id = this.id
		treewalk_trail.particle_system.emit = false

		queue_insert(store, treewalk_trail)

		while true do
			if h.dead then
				SU5.y_hero_death_and_respawn_kr5(store, this)
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				SU5.heroes_visual_learning_upgrade(store, this)
				SU5.heroes_lone_wolves_upgrade(store, this)
				SU5.alliance_merciless_upgrade(store, this)
				SU5.alliance_corageous_upgrade(store, this)

				while this.nav_rally.new do
					local r = this.nav_rally
					local tw = this.treewalk
					local force_treewalk = false

					for _, p in pairs(this.nav_grid.waypoints) do
						if GR:cell_is(p.x, p.y, bor(TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_NOWALK)) then
							force_treewalk = true

							break
						end
					end

					if force_treewalk or V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > tw.min_distance then
						r.new = false

						U.unblock_target(store, this)

						local vis_bans = this.vis.bans

						this.vis.bans = F_ALL
						this.health.immune_to = F_ALL

						local original_speed = this.motion.max_speed

						this.motion.max_speed = this.motion.max_speed + tw.extra_speed
						this.unit.marker_hidden = true
						this.health_bar.hidden = true

						S:queue(this.sound_events.change_rally_point)
						S:queue(this.treewalk.sound)

						treewalk_trail.particle_system.emit = true

						::label_283_0::

						local dest = r.pos
						local n = this.nav_grid

						while not V.veq(this.pos, dest) do
							local w = table.remove(n.waypoints, 1) or dest

							U.set_destination(this, w)

							local an, af = U.animation_name_facing_point(this, tw.animations[1], this.motion.dest)

							U.animation_start(this, an, af, store.tick_ts, true)

							while not this.motion.arrived do
								if r.new then
									r.new = false

									goto label_283_0
								end

								U.walk(this, store.tick_length)
								coroutine.yield()

								this.motion.speed.x, this.motion.speed.y = 0, 0
							end
						end

						treewalk_trail.particle_system.emit = false

						S:stop(this.treewalk.sound)
						SU.hide_modifiers(store, this, true)
						U.y_animation_play(this, tw.animations[2], nil, store.tick_ts)
						SU.show_modifiers(store, this, true)

						this.motion.max_speed = original_speed
						this.vis.bans = vis_bans
						this.health.immune_to = 0
						this.unit.marker_hidden = nil
						this.health_bar.hidden = nil
					elseif SU.y_hero_new_rally(store, this) then
						goto label_283_1
					end
				end

				skill = this.hero.skills.sentinel_wisps
				a = this.timed_attacks.list[1]

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_trigger, a
						.vis_flags, a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))
					else
						local start_ts = store.tick_ts

						S:queue(a.sound)
						U.animation_start(this, a.animation, nil, store.tick_ts, false)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_283_1
						end

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local positions = distribute_summons(this.pos.x, this.pos.y, a.max_summons)

						for i, pos in ipairs(positions) do
							local e = create_entity(a.entity)

							e.pos = pos
							e.owner_id = this.id
							e.wisp_order = i

							queue_insert(store, e)
						end

						SU.y_hero_animation_wait(this)
					end
				end

				skill = this.hero.skills.leaf_whirlwind
				a = this.timed_attacks.list[2]

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range_trigger, a
						.vis_flags, a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))
					else
						local start_ts = store.tick_ts

						S:queue(a.sound)

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local aura = create_entity(a.aura)

						aura.aura.source_id = this.id
						aura.aura.ts = store.tick_ts
						aura.pos = this.pos

						queue_insert(store, aura)

						local aura_decal = create_entity(a.aura_decal)

						aura_decal.duration = aura.aura.duration
						aura_decal.pos = this.pos
						aura_decal.source_id = this.id

						queue_insert(store, aura_decal)

						local mod = create_entity(a.mod)

						mod.modifier.source_id = this.id
						mod.modifier.target_id = this.id

						queue_insert(store, mod)
					end
				end

				skill = this.hero.skills.faery_dust
				a = this.timed_attacks.list[3]

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local _, enemies = U5.find_foremost_enemy(store.entities, this.pos, 0, a.max_range_trigger, false,
						a.vis_flags, a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))
					else
						local aim_target, _ = U5.find_entity_most_surrounded(enemies)
						local start_ts = store.tick_ts

						S:queue(a.sound)

						local an, af, ai = U5.animation_name_facing_point(this, a.animation, aim_target.pos)

						U5.animation_start(this, an, af, store.tick_ts, false)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_283_1
						end

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local _, enemies = U5.find_foremost_enemy(store.entities, this.pos, 0, a.max_range_effect, false,
							a.vis_flags, a.vis_bans)

						if enemies then
							aim_target, _ = U5.find_entity_most_surrounded(enemies)
						end

						local aura = create_entity(a.aura)

						aura.aura.source_id = this.id
						aura.aura.ts = store.tick_ts
						aura.aura.level = skill.level

						local ni = aim_target.nav_path.ni + P:predict_enemy_node_advance(aim_target, a.node_prediction)

						aura.pos = P:node_pos(aim_target.nav_path.pi, 1, ni)
						aura.pos_pi = aim_target.nav_path.pi
						aura.pos_ni = ni

						queue_insert(store, aura)
						SU.y_hero_animation_wait(this)
					end
				end

				skill = this.hero.skills.verdant_blast
				a = this.timed_attacks.list[4]

				if not a.disabled and store.tick_ts - a.ts > a.cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range,
						a.vis_flags, a.vis_bans)

					if not enemies then
						SU.delay_attack(store, a, fts(10))
					else
						local start_ts = store.tick_ts
						local enemy = enemies[1]
						local enemy_pos = V.vclone(enemy.pos)

						S:queue(a.sound)

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local an, af, _ = U.animation_name_facing_point(this, a.animation, enemy_pos)

						U.animation_start(this, an, af, store.tick_ts, false)

						if SU.y_hero_wait(store, this, a.shoot_time) then
							goto label_283_1
						end

						enemies = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a
							.vis_flags, a.vis_bans)

						if enemies and #enemies > 0 then
							enemy = enemies[1]
							enemy_pos = V.vclone(enemy.pos)
						end

						local flip_x = enemy_pos.x - this.pos.x < 0

						this.render.sprites[1].flip_x = flip_x

						local flying = U.flag_has(enemy.vis.flags, F_FLYING)

						shoot_bullet(a, enemy, enemy_pos, flying)

						for _, aa in pairs(this.ranged.attacks) do
							aa.ts = store.tick_ts
						end

						SU.y_hero_animation_wait(this)
					end
				end

				a = this.timed_attacks.list[5]
				skill = this.hero.skills.verdant_blast

				if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.lives < 21 and store.lives ~= 1 then
					a.ts = store.tick_ts

					U.animation_start(this, a.animation, nil, store.tick_ts)

					store.lives = store.lives + a.heal_live

					SU.y_hero_animation_wait(this)
				end

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				brk, sta = y_hero_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					brk, sta = y_hero_ranged_attacks(store, this)

					if brk then
						-- block empty
					else
						SU.soldier_idle(store, this)
						SU.soldier_regen(store, this)
					end
				end
			end

			::label_283_1::

			coroutine.yield()
		end
	end

	-- 毒液
	function scripts5.hero_venom.level_up(this, store, initial)
		local hl = this.hero.level
		local ls = this.hero.level_stats

		this.health.hp_max = ls.hp_max[hl]
		this.regen.health = ls.regen_health[hl]
		this.health.armor = ls.armor[hl]
		this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		this.melee.attacks[2].damage_min = ls.melee_damage_min[hl]
		this.melee.attacks[2].damage_max = ls.melee_damage_max[hl]

		local s, sl

		s = this.hero.skills.ranged_tentacle
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - HEARTSEEKER - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[1]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]

			local b = E:get_template(a.bullet)

			b.bullet.damage_min = s.damage_min[sl]
			b.bullet.damage_max = s.damage_max[sl]
			b.bleed_chance = s.bleed_chance[sl]

			local m = E:get_template(b.bullet.mods[1])

			m.dps.damage_min = s.bleed_damage_min[sl]
			m.dps.damage_max = s.bleed_damage_max[sl]
			m.dps.damage_every = s.bleed_every[sl]
			m.modifier.duration = s.bleed_duration[sl]
		end

		s = this.hero.skills.inner_beast
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - INNER BEAST - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[2]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]
		end

		if sl > 0 then
			local damage_min = ls.melee_damage_min[hl] * s.damage_factor[sl]
			local damage_max = ls.melee_damage_max[hl] * s.damage_factor[sl]

			this.melee.attacks[3].damage_min = damage_min
			this.melee.attacks[3].damage_max = damage_max
			this.melee.attacks[4].damage_min = damage_min
			this.melee.attacks[4].damage_max = damage_max
			this.melee.attacks[5].damage_min = damage_min
			this.melee.attacks[5].damage_max = damage_max
		end

		s = this.hero.skills.floor_spikes
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - FLOOR SPIKES - %i", this.template_name, hl, sl)

			local a = this.timed_attacks.list[3]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]
			a.spikes = s.spikes[sl]

			local sp = E:get_template(a.spike_template[1])

			sp.damage_min = s.damage_min[sl]
			sp.damage_max = s.damage_max[sl]

			local sp = E:get_template(a.spike_template[2])

			sp.damage_min = s.damage_min[sl]
			sp.damage_max = s.damage_max[sl]
		end

		s = this.hero.skills.eat_enemy
		sl = s.level

		if sl > 0 and initial then
			log.info("LEVELUP - %s - %i - EAT ENEMY - %i", this.template_name, hl, sl)

			local a = this.melee.attacks[6]

			a.disabled = nil
			a.cooldown = s.cooldown[sl]
			a.regen = s.regen[sl]
		end

		s = this.hero.skills.ultimate
		sl = s.level

		if sl >= 0 then
			log.info("LEVELUP - %s - %i - ULTIMATE - %i", this.template_name, hl, sl)

			local uc = E:get_template(s.controller_name)

			uc.cooldown = s.cooldown[sl]

			local aura = E:get_template(uc.aura)

			aura.end_damage_min = s.damage_min[sl]
			aura.end_damage_max = s.damage_max[sl]
			aura.aura.duration = s.duration[sl]

			for _, tp_aura in ipairs(uc.auras) do
				local teleport_aura = T(tp_aura)

				teleport_aura.aura.damage_min = s.damage_min[sl]
				teleport_aura.aura.damage_max = s.damage_max[sl]
				teleport_aura.aura.duration = s.duration[sl]
			end
		end

		this.health.hp = this.health.hp_max
		this.hero.melee_active_status = {}

		for index, attack in ipairs(this.melee.attacks) do
			this.hero.melee_active_status[index] = attack.disabled
		end
	end

	function scripts5.hero_venom.update(this, store)
		local h = this.health
		local a, skill, brk, sta
		local ranged_tentacle_attack = this.timed_attacks.list[1]
		local inner_beast_attack = this.timed_attacks.list[2]
		local floor_spikes_attack = this.timed_attacks.list[3]
		local eat_enemy_attack = this.melee.attacks[6]
		local last_ts = store.tick_ts
		local last_target
		local last_target_ts = store.tick_ts
		local base_speed = this.motion.max_speed

		this.is_transformed = false

		if not ranged_tentacle_attack.disabled then
			ranged_tentacle_attack.ts = store.tick_ts - ranged_tentacle_attack.cooldown
		end

		if not inner_beast_attack.disabled then
			inner_beast_attack.ts = store.tick_ts - inner_beast_attack.cooldown
		end

		if not floor_spikes_attack.disabled then
			floor_spikes_attack.ts = store.tick_ts - floor_spikes_attack.cooldown
		end

		if not eat_enemy_attack.disabled then
			eat_enemy_attack.ts = store.tick_ts - eat_enemy_attack.cooldown
		end

		local function y_transform_in()
			local a = inner_beast_attack
			local start_ts = store.tick_ts

			S:queue(a.sound_in, {
				delay = fts(10)
			})

			this.health.ignore_damage = true

			U.y_animation_play(this, a.animation_in, nil, store.tick_ts)

			this.health.ignore_damage = false
			a.ts = start_ts
			last_ts = start_ts

			SU.hero_gain_xp_from_skill(this, skill)

			this.melee.attacks[1].disabled = true
			this.melee.attacks[2].disabled = true
			this.melee.attacks[3].disabled = false
			this.melee.attacks[4].disabled = false
			this.melee.attacks[5].disabled = false
			this._bar_offset = V.vclone(this.health_bar.offset)
			this._bar_type = this.health_bar.type
			this._click_rect = table.deepclone(this.ui.click_rect)
			this._hit_mod_offset = V.vclone(this.unit.hit_offset)
			this.health_bar.offset = V.vclone(this.beast.health_bar_offset)
			this.health_bar.type = this.beast.health_bar_type
			this.ui.click_rect = table.deepclone(this.beast.click_rect)
			this.unit.hit_offset = V.vclone(this.beast.hit_mod_offset)
			this.unit.mod_offset = V.vclone(this.beast.hit_mod_offset)
			this.render.sprites[1].prefix = "hero_venom_hero_beast"
			this.unit.size = UNIT_SIZE_MEDIUM
			this.is_transformed = true
		end

		local function y_transform_out()
			local a = inner_beast_attack

			S:queue(a.sound_out, {
				delay = fts(10)
			})
			U.y_animation_play(this, a.animation_out, nil, store.tick_ts)

			this.melee.attacks[1].disabled = false
			this.melee.attacks[2].disabled = false
			this.melee.attacks[3].disabled = true
			this.melee.attacks[4].disabled = true
			this.melee.attacks[5].disabled = true
			this.health_bar.offset = V.vclone(this._bar_offset)
			this.health_bar.type = this._bar_type
			this.ui.click_rect = table.deepclone(this._click_rect)
			this.unit.hit_offset = V.vclone(this._hit_mod_offset)
			this.unit.mod_offset = V.vclone(this._hit_mod_offset)
			this.render.sprites[1].prefix = "hero_venom_hero"
			this.unit.size = UNIT_SIZE_SMALL
			this.is_transformed = false
		end

		this.health_bar.hidden = false

		while true do
			if h.dead then
				if this.is_transformed then
					y_transform_out()
				end

				local d = E:create_entity(this.death_decal)

				d.pos.x, d.pos.y = this.pos.x, this.pos.y
				d.hero_venom = this

				queue_insert(store, d)
				SU5.y_hero_death_and_respawn_kr5(store, this)

				this.motion.max_speed = base_speed
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					local r = this.nav_rally
					local tw = this.slimewalk
					local force_slimewalk = false

					for _, p in pairs(this.nav_grid.waypoints) do
						if GR:cell_is(p.x, p.y, bor(TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_NOWALK)) then
							force_slimewalk = true

							break
						end
					end

					if not this.is_transformed and (force_slimewalk or V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > tw.min_distance) then
						r.new = false

						U.unblock_target(store, this)

						local vis_bans = this.vis.bans

						this.vis.bans = F_ALL
						this.health.immune_to = F_ALL

						local original_speed = this.motion.max_speed

						this.motion.max_speed = this.motion.max_speed + tw.extra_speed
						this.unit.marker_hidden = true
						this.health_bar.hidden = true

						S:queue(this.sound_events.change_rally_point)
						S:queue(this.slimewalk.sound)

						::label_416_0::

						local dest = r.pos
						local n = this.nav_grid
						local an, af = U.animation_name_facing_point(this, tw.animations[1], this.motion.dest)

						U.y_animation_play(this, an, not af, store.tick_ts)

						while not V.veq(this.pos, dest) do
							local w = table.remove(n.waypoints, 1) or dest

							U.set_destination(this, w)

							local an, af = U.animation_name_facing_point(this, tw.animations[2], this.motion.dest)

							U.animation_start(this, an, af, store.tick_ts, true, 1, true)

							local runs = this.render.sprites[1].runs - 1

							while not this.motion.arrived do
								if r.new then
									r.new = false

									goto label_416_0
								end

								U.walk(this, store.tick_length)
								coroutine.yield()

								this.motion.speed.x, this.motion.speed.y = 0, 0

								if this.render.sprites[1].runs ~= runs then
									local slimewalk_decal = E:create_entity(this.slimewalk.decal)

									slimewalk_decal.ts = store.tick_ts
									slimewalk_decal.pos = V.vclone(this.pos)

									U.animation_start(slimewalk_decal, "idle", false, store.tick_ts)
									queue_insert(store, slimewalk_decal)

									runs = this.render.sprites[1].runs
								end
							end
						end

						S:stop(this.slimewalk.sound)
						SU.hide_modifiers(store, this, true)
						U.y_animation_play(this, tw.animations[3], nil, store.tick_ts)
						SU.show_modifiers(store, this, true)

						this.motion.max_speed = original_speed
						this.vis.bans = vis_bans
						this.health.immune_to = 0
						this.unit.marker_hidden = nil
						this.health_bar.hidden = nil
					elseif SU.y_hero_new_rally(store, this) then
						goto label_416_2
					end
				end

				SU5.heroes_visual_learning_upgrade(store, this)
				SU5.heroes_lone_wolves_upgrade(store, this)
				SU5.alliance_merciless_upgrade(store, this)
				SU5.alliance_corageous_upgrade(store, this)

				if SU.hero_level_up(store, this) then
					if this.is_transformed then
						local fx = E:create_entity(this.beast.lvl_up_fx)

						fx.pos = V.vclone(this.pos)

						for i = 1, #fx.render.sprites do
							fx.render.sprites[i].ts = store.tick_ts
						end

						queue_insert(store, fx)
					else
						U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
					end
				end

				skill = this.hero.skills.ranged_tentacle
				a = ranged_tentacle_attack

				if not this.is_transformed and not a.disabled and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local target, _, pred_pos = U5.find_foremost_enemy(store.entities, tpos(this), a.min_range,
						a.max_range, a.node_prediction, a.vis_flags, a.vis_bans)

					if not target then
						SU.delay_attack(store, a, fts(10))
					else
						local enemy_id = target.id
						local enemy_pos = target.pos

						last_ts = store.tick_ts

						local an, af, ai = U.animation_name_facing_point(this, a.animation, enemy_pos)

						U.animation_start(this, an, af, store.tick_ts, false)
						S:queue(a.sound)

						local start_offset = V.vclone(a.bullet_start_offset)

						if af then
							start_offset.x = start_offset.x * -1
						end

						U.y_wait(store, a.shoot_time)

						if SU.soldier_interrupted(this) then
							-- block empty
						else
							local target, _, pred_pos = U5.find_foremost_enemy(store.entities, tpos(this), a.min_range,
								a.max_range, a.shoot_time, a.vis_flags, a.vis_bans)

							if target then
								enemy_id = target.id
								enemy_pos = target.pos
							end

							if not target then
								-- block empty
							else
								a.ts = last_ts

								local b = E:create_entity(a.bullet)

								b.pos.x, b.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(pred_pos)
								b.bullet.to.x = b.bullet.to.x + target.unit.hit_offset.x
								b.bullet.to.y = b.bullet.to.y + target.unit.hit_offset.y
								b.bullet.target_id = enemy_id
								b.bullet.source_id = this.id
								b.bullet.level = this.hero.level

								queue_insert(store, b)
								SU.hero_gain_xp_from_skill(this, skill)
								U.y_animation_wait(this)

								goto label_416_2
							end
						end
					end
				end

				a = inner_beast_attack
				skill = this.hero.skills.inner_beast

				if not this.is_transformed and not a.disabled and this.health.hp <= this.health.hp_max * skill.trigger_hp and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					y_transform_in()
				end

				if this.is_transformed and store.tick_ts - a.ts > skill.duration then
					y_transform_out()
				end

				skill = this.hero.skills.floor_spikes
				a = floor_spikes_attack

				if not this.is_transformed and not a.disabled and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, a.range_trigger_min,
						a.range_trigger_max, a.vis_flags, a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))

						goto label_416_1
					end

					local targets = table.filter(enemies, function(k, v)
						local vpi = v.nav_path.pi
						local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
							vpi
						})
						local pi, spi, ni = unpack(nearest[1])

						return ni > v.nav_path.ni
					end)

					if not targets or #targets < a.min_targets then
						SU.delay_attack(store, a, fts(10))

						goto label_416_1
					end

					local path = targets[1].nav_path.pi
					local start_ts = store.tick_ts

					S:queue(a.sound_in, {
						delay = fts(10)
					})

					local flip = targets[1].pos.x < this.pos.x

					U.animation_start(this, a.animation_in, flip, store.tick_ts, false)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_416_2
					end

					a.ts = start_ts
					last_ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					local nodes_between_spikes = 2
					local spikes = {}

					local function spawn_spike(pi, spi, ni, spike_id)
						local pos = P:node_pos(pi, spi, ni)

						pos.x = pos.x + math.random(-4, 4)
						pos.y = pos.y + math.random(-5, 5)

						local s = E:create_entity(a.spike_template[math.random(1, #a.spike_template)])

						s.pos = V.vclone(pos)

						queue_insert(store, s)

						spikes[spike_id] = s
					end

					local nearest = P:nearest_nodes(this.pos.x, this.pos.y, {
						path
					})

					if #nearest > 0 then
						local pi, spi, ni = unpack(nearest[1])
						local initial_offset = 1

						ni = ni - initial_offset

						local count = a.spikes / 3
						local ni_aux
						local spike_id = 1

						for i = 1, count do
							ni_aux = ni - i * nodes_between_spikes

							if P:is_node_valid(pi, ni_aux) then
								spawn_spike(pi, 1, ni_aux, spike_id)

								spike_id = spike_id + 1

								U.y_wait(store, fts(1))
							end

							ni_aux = ni - i * (nodes_between_spikes + 1)

							if P:is_node_valid(pi, ni_aux) then
								spawn_spike(pi, 2, ni_aux, spike_id)

								spike_id = spike_id + 1

								U.y_wait(store, fts(1))
								spawn_spike(pi, 3, ni_aux, spike_id)

								spike_id = spike_id + 1

								U.y_wait(store, fts(1))
							end
						end
					end

					U.animation_start(this, a.animation_idle, nil, store.tick_ts, true)
					U.y_wait(store, fts(20))
					S:queue(a.sound_out)

					for i = #spikes, 1, -1 do
						spikes[i].hide = true

						U.y_wait(store, fts(1))
					end

					U.animation_start(this, a.animation_out, nil, store.tick_ts, false)
					SU.y_hero_animation_wait(this)

					goto label_416_2
				end

				::label_416_1::

				brk, sta = y_hero_melee_block_and_attacks(store, this)

				if sta == A_DONE then
					if this.is_transformed then
						this.health.hp = this.health.hp + this.health.hp_max * this.beast.regen_health

						if this.health.hp > this.health.hp_max then
							this.health.hp = this.health.hp_max
						end
					elseif this.melee.last_attack.attack == eat_enemy_attack then
						this.health.hp = this.health.hp + this.health.hp_max * eat_enemy_attack.regen

						if this.health.hp > this.health.hp_max then
							this.health.hp = this.health.hp_max
						end

						local mod = E:create_entity(eat_enemy_attack.mod_regen)

						mod.modifier.target_id = this.id

						queue_insert(store, mod)
					end
				end

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_416_2::

			coroutine.yield()
		end
	end

	function scripts5.hero_venom_ultimate.update(this, store)
		local owner = store.entities[this.owner.id]

		local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

		if #nearest > 0 then
			local pi, spi, ni = unpack(nearest[1])

			if P:is_node_valid(pi, ni) then
				S:queue(this.sound)

				local aura = E:create_entity(this.aura)

				aura.aura.source_id = this.id
				aura.aura.ts = store.tick_ts

				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)

				if #nodes < 1 then
					log.debug("cannot insert venom ulti, no valid nodes nearby %s,%s", x, y)

					return nil
				end

				local pi, spi, ni = unpack(nodes[1])
				local npos = P:node_pos(pi, 1, ni)

				aura.pos = npos
				aura.pos_pi = pi
				aura.pos_ni = ni

				S:queue(this.sound)
				queue_insert(store, aura)

				local function create_teleport_aura(aura)
					local teleport_aura = E:create_entity(aura)

					teleport_aura.aura.source_id = owner.id
					teleport_aura.aura.ts = store.tick_ts
					teleport_aura.ts = store.tick_ts

					teleport_aura.pos = npos
					teleport_aura.pos_pi = pi
					teleport_aura.pos_ni = ni

					queue_insert(store, teleport_aura)

					return teleport_aura
				end

				if not owner.teleport_start_aura then
					owner.teleport_start_aura = create_teleport_aura(this.auras[1])
				elseif not owner.teleport_end_aura then
					owner.teleport_end_aura = create_teleport_aura(this.auras[2])
				else
					local power_ts = utils_UH.get_power_ts(store, 3, 51)

					utils_UH.set_power_ts(power_ts - this.compensate_cooldown, 3, 51)
				end
			end
		end

		queue_remove(store, this)
	end

	scripts5.venom_teleport_start_aura = {}

	function scripts5.venom_teleport_start_aura.insert(this, store)
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil,
			nil, true)

		if #nodes < 1 then
			return false
		end

		this.on_node = nodes[1][3]

		return true
	end

	function scripts5.venom_teleport_start_aura.update(this, store)
		local aura = this.aura
		local owner = store.entities[aura.source_id]

		U.y_animation_play(this, "in", false, store.tick_ts, false)

		while true do
			local targets = U.find_targets_in_range(store.entities, this.pos, 0, aura.radius, aura.vis_flags,
				aura.vis_bans)

			if targets and store.tick_ts - this.ts > aura.cycle_time then
				U.animation_start(this, "attack", false, store.tick_ts)

				U.y_wait(store, aura.hit_time)

				this.ts = store.tick_ts

				for _, t in pairs(targets) do
					if t.enemy then
						local d = create_entity("damage")
						d.target_id = t.id
						d.source_id = aura.source_id
						d.damage_type = aura.damage_type
						d.value = math.random(aura.damage_min, aura.damage_max)

						queue_damage(store, d)
					end
				end

				if not this.disabled and owner.teleport_end_aura then
					if targets[1].enemy and this.on_node > owner.teleport_end_aura.on_node then
						owner.teleport_end_aura.disabled = true
						owner.teleport_end_aura.ts = store.tick_ts

						utils_UH.set_entity_pos(store, targets[1].id, owner.teleport_end_aura.pos)
					elseif targets[1].soldier then
						owner.teleport_end_aura.disabled = true
						owner.teleport_end_aura.ts = store.tick_ts

						utils_UH.set_entity_pos(store, targets[1].id, owner.teleport_end_aura.pos)
					end
				end
			end

			if store.tick_ts - aura.ts > aura.duration then
				queue_remove(store, this)
			end

			this.disabled = false
			coroutine.yield()
		end

		queue_remove(store, this)
	end

	function scripts5.venom_teleport_start_aura.remove(this, store)
		local aura = this.aura
		local owner = store.entities[aura.source_id]

		owner.teleport_start_aura = nil

		return true
	end

	scripts5.venom_teleport_end_aura = {}

	function scripts5.venom_teleport_end_aura.insert(this, store)
		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil,
			nil, true)

		if #nodes < 1 then
			return false
		end

		this.on_node = nodes[1][3]

		return true
	end

	function scripts5.venom_teleport_end_aura.update(this, store)
		local aura = this.aura
		local owner = store.entities[aura.source_id]

		U.y_animation_play(this, "in", false, store.tick_ts, false)

		while true do
			local targets = U.find_targets_in_range(store.entities, this.pos, 0, aura.radius, aura.vis_flags,
				aura.vis_bans)

			if targets and store.tick_ts - this.ts > aura.cycle_time then
				U.animation_start(this, "attack", false, store.tick_ts)

				U.y_wait(store, aura.hit_time)

				this.ts = store.tick_ts

				for _, t in pairs(targets) do
					if t.enemy then
						local d = create_entity("damage")
						d.target_id = t.id
						d.source_id = aura.source_id
						d.damage_type = aura.damage_type
						d.value = math.random(aura.damage_min, aura.damage_max)

						queue_damage(store, d)
					end
				end

				if not this.disabled and owner.teleport_start_aura then
					if targets[1].enemy and this.on_node > owner.teleport_start_aura.on_node then
						owner.teleport_start_aura.disabled = true
						owner.teleport_start_aura.ts = store.tick_ts

						utils_UH.set_entity_pos(store, targets[1].id, owner.teleport_start_aura.pos)
					elseif targets[1].soldier then
						owner.teleport_start_aura.disabled = true
						owner.teleport_start_aura.ts = store.tick_ts

						utils_UH.set_entity_pos(store, targets[1].id, owner.teleport_start_aura.pos)
					end
				end
			end

			if store.tick_ts - aura.ts > aura.duration then
				queue_remove(store, this)
			end

			this.disabled = false
			coroutine.yield()
		end

		queue_remove(store, this)
	end

	function scripts5.venom_teleport_end_aura.remove(this, store)
		local aura = this.aura
		local owner = store.entities[aura.source_id]
		owner.teleport_end_aura = nil

		return true
	end

	-- 土木人
	function scripts5.hero_builder.insert(this, store)
		this.hero.fn_level_up(this, store, true)

		this.melee.order = U.attack_order(this.melee.attacks)

		if this.hero.skills.lunch_break.level > 0 then
			local aura = create_entity(this.auras.list[1].aura)
			aura.aura.source_id = this.id

			queue_insert(store, aura)
		end

		return true
	end

	function scripts5.hero_builder.update(this, store)
		local h = this.health
		local a, skill, brk, sta
		local overtime_work_attack = this.timed_attacks.list[1]
		local lunch_break_attack = this.timed_attacks.list[2]
		local demolition_man_attack = this.timed_attacks.list[3]
		local defensive_turret_attack = this.timed_attacks.list[4]
		local last_ts = store.tick_ts
		local last_target
		local last_target_ts = store.tick_ts
		local base_speed = this.motion.max_speed

		if not overtime_work_attack.disabled then
			overtime_work_attack.ts = store.tick_ts - overtime_work_attack.cooldown
		end

		if not lunch_break_attack.disabled then
			lunch_break_attack.ts = store.tick_ts - lunch_break_attack.cooldown
		end

		if not demolition_man_attack.disabled then
			demolition_man_attack.ts = store.tick_ts - demolition_man_attack.cooldown
		end

		if not defensive_turret_attack.disabled then
			defensive_turret_attack.ts = store.tick_ts - defensive_turret_attack.cooldown
		end

		this.health_bar.hidden = false

		while true do
			if h.dead then
				SU5.y_hero_death_and_respawn_kr5(store, this)

				this.motion.max_speed = base_speed
			end

			if this.unit.is_stunned then
				SU.soldier_idle(store, this)
			else
				while this.nav_rally.new do
					if SU.y_hero_new_rally(store, this) then
						goto label_353_1
					end
				end

				SU5.heroes_visual_learning_upgrade(store, this)
				SU5.heroes_lone_wolves_upgrade(store, this)
				SU5.alliance_merciless_upgrade(store, this)
				SU5.alliance_corageous_upgrade(store, this)

				if SU.hero_level_up(store, this) then
					U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
				end

				skill = this.hero.skills.overtime_work
				a = overtime_work_attack

				if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
						a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))
					else
						local start_ts = store.tick_ts

						S:queue(a.sound, {
							delay = fts(10)
						})
						U.animation_start(this, a.animation, nil, store.tick_ts, 1)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_353_1
						end

						a.ts = start_ts
						last_ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
							a.vis_bans)

						local e = create_entity(a.entity)

						e.pos.x = this.pos.x + 10
						e.pos.y = this.pos.y - 10
						e.nav_rally.center = V.v(this.pos.x, this.pos.y)
						e.nav_rally.pos = V.vclone(e.pos)

						queue_insert(store, e)

						local fx = create_entity(a.spawn_fx)

						fx.pos.x, fx.pos.y = e.pos.x, e.pos.y
						fx.render.sprites[1].ts = store.tick_ts

						queue_insert(store, fx)

						e = create_entity(a.entity)
						e.pos.x = this.pos.x - 10
						e.pos.y = this.pos.y + 10
						e.nav_rally.center = V.v(this.pos.x, this.pos.y)
						e.nav_rally.pos = V.vclone(e.pos)

						queue_insert(store, e)

						fx = create_entity(a.spawn_fx)
						fx.pos.x, fx.pos.y = e.pos.x, e.pos.y
						fx.render.sprites[1].ts = store.tick_ts

						queue_insert(store, fx)
						SU.y_hero_animation_wait(this)

						goto label_353_1
					end
				end

				a = lunch_break_attack
				skill = this.hero.skills.lunch_break

				if not a.disabled and this.health.hp <= this.health.hp_max * a.lost_health and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local start_ts = store.tick_ts

					U.animation_start(this, a.animation, nil, store.tick_ts, 1)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_353_1
					end

					a.ts = start_ts
					last_ts = start_ts

					S:queue(a.sound, {
						delay = fts(10)
					})
					SU.hero_gain_xp_from_skill(this, skill)

					local mod = create_entity(a.mod)

					mod.modifier.target_id = this.id
					mod.modifier.source_id = this.id

					queue_insert(store, mod)
					U.y_animation_wait(this)
				end

				skill = this.hero.skills.demolition_man
				a = demolition_man_attack

				if this.soldier.target_id and not last_target or this.soldier.target_id ~= last_target then
					last_target = this.soldier.target_id
					last_target_ts = store.tick_ts
				end

				if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_target_ts > a.min_fight_cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags,
						a.vis_bans)

					if not enemies or #enemies < a.min_targets then
						SU.delay_attack(store, a, fts(10))
					else
						local start_ts = store.tick_ts

						S:queue(a.sound, {
							delay = fts(10)
						})

						local fx = create_entity(a.fx)

						fx.pos = this.pos
						fx.render.sprites[1].ts = store.tick_ts
						fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x

						queue_insert(store, fx)
						U.animation_start(this, a.animation .. "_start", nil, store.tick_ts, 1)
						U.animation_start(fx, "start", nil, store.tick_ts, 1)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_353_1
						end

						a.ts = start_ts
						last_ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local aura = create_entity(a.aura)

						aura.aura.source_id = this.id
						aura.aura.ts = store.tick_ts
						aura.pos = this.pos

						queue_insert(store, aura)
						U.animation_start(this, a.animation .. "_loop", nil, store.tick_ts, true)
						U.animation_start(fx, "loop", nil, store.tick_ts, true)

						if SU.y_hero_wait(store, this, aura.aura.duration - (store.tick_ts - a.ts)) then
							-- block empty
						end

						queue_remove(store, aura)
						U.animation_start(fx, "end", nil, store.tick_ts, 1)
						U.y_animation_play(this, a.animation .. "_end", nil, store.tick_ts, 1)
						SU.y_hero_animation_wait(this)
						queue_remove(store, fx)

						goto label_353_1
					end
				end

				skill = this.hero.skills.defensive_turret
				a = defensive_turret_attack

				if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.tick_ts - last_ts > a.min_cooldown then
					local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
					local pi, spi, ni = unpack(nearest[1])
					local turret_pos = P:node_pos(pi, spi, ni)
					local new_pos = {}

					new_pos.x, new_pos.y = turret_pos.x - a.spawn_offset.x, turret_pos.y

					if this.pos.x > turret_pos.x then
						new_pos.x = turret_pos.x + a.spawn_offset.x
					end

					local node_limit = math.floor(a.min_distance_from_border / P.average_node_dist)
					local nodes_to_goal = P:nodes_to_goal(pi, spi, ni)
					local nodes_from_start = P:nodes_from_start(pi, spi, ni)

					if nodes_to_goal < node_limit or nodes_from_start < node_limit then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						local start_ts = store.tick_ts

						this.motion.max_speed = a.build_speed

						local se = this.sound_events

						this.sound_events = nil

						this.sound_events = se
						this.motion.max_speed = base_speed

						local an, af, ai = U.animation_name_facing_point(this, a.animation, new_pos)

						U.animation_start(this, an, af, store.tick_ts, 1)

						this.health_bar.hidden = true

						local _vis = {}

						_vis.bans, _vis.flags = this.vis.bans, this.vis.flags
						this.vis.bans = F_ALL
						this.vis.flags = F_NONE
						this.ui.can_select = false

						SU.remove_modifiers(store, this)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_353_1
						end

						a.ts = start_ts
						last_ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local e = create_entity(a.entity)
						local epos = new_pos

						e.flip_x = this.render.sprites[1].flip_x
						e.pos = V.vclone(epos)

						queue_insert(store, e)
						S:queue(a.sound_cast, {
							delay = fts(10)
						})

						e.sound_destroy = a.sound_destroy

						while not U.animation_finished(this) do
							coroutine.yield()
						end

						this.health_bar.hidden = false
						this.vis.bans = _vis.bans
						this.vis.flags = _vis.flags
						this.ui.can_select = true

						goto label_353_1
					end
				end

				::label_353_0::

				brk, sta = y_hero_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					-- block empty
				elseif SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end

			::label_353_1::

			coroutine.yield()
		end
	end

	function scripts5.mod_hero_builder_lunch_break.insert(this, store)
		local m = this.modifier
		local target = store.entities[m.target_id]

		if not target or not target.health or target.health.dead then
			return false
		end

		target.health.hp = km.clamp(0, target.health.hp_max, target.health.hp + target.health.hp * this.heal_hp)

		return true
	end

	scripts5.hero_builder_extra_hp_max_aura = {}

	function scripts5.hero_builder_extra_hp_max_aura.update(this, store)
		local aura = this.aura
		local source = store.entities[aura.source_id]
		local origin_hp_max = source.health.hp_max

		while true do
			this.pos = V.vclone(source.pos)

			local turrets = utils_UH.find_entities_in_range(store.entities, this.pos, 0, aura.radius, aura.vis_flags,
				aura.vis_bans, function(v)
					return v.template_name == "decal_hero_builder_defensive_turret"
				end)

			if turrets then
				local hp_max_factor = 1 + #turrets * aura.extra_hp_max

				source.health.hp_max = origin_hp_max * hp_max_factor
			else
				source.health.hp_max = origin_hp_max
			end

			coroutine.yield()
		end

		queue_remove(store, this)
	end

	scripts5.aura_hero_builder_ultimate = {}

	function scripts5.aura_hero_builder_ultimate.update(this, store, script)
		this.aura.ts = store.tick_ts

		local last_hit_ts = 0
		local cycles_count = 0

		while true do
			if this.aura.cycles then
				if cycles_count >= this.aura.cycles then
					break
				end
			elseif this.aura.duration >= 0 and store.tick_ts - this.aura.ts >= this.aura.duration + this.aura.level * this.aura.duration_inc then
				break
			end

			if this.aura.track_source and this.aura.source_id then
				local te = store.entities[this.aura.source_id]

				if not te or te.health and te.health.dead then
					queue_remove(store, this)

					return
				end

				if te and te.pos then
					this.pos.x, this.pos.y = te.pos.x, te.pos.y
				end
			end

			if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
				cycles_count = cycles_count + 1
				last_hit_ts = store.tick_ts

				local mods = this.aura.mods or {
					this.aura.mod
				}

				local targets = table.filter(store.entities, function(k, v)
					return v.unit and v.vis and v.health and not v.health.dead and
						band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and
						U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and
						(not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and
						(not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and
						(not this.aura.excluded_entities or not table.contains(this.aura.excluded_entities, v.id))
				end)

				for _, target in pairs(targets) do
					local d = create_entity("damage")

					d.source_id = this.id
					d.target_id = target.id

					local dmin, dmax = this.aura.damage_min, this.aura.damage_max

					if this.aura.damage_inc then
						dmin = dmin + this.aura.damage_inc * this.aura.level
						dmax = dmax + this.aura.damage_inc * this.aura.level
					end

					d.value = math.random(dmin, dmax)
					d.damage_type = this.aura.damage_type
					d.track_damage = this.aura.track_damage
					d.xp_dest_id = this.aura.xp_dest_id
					d.xp_gain_factor = this.aura.xp_gain_factor

					queue_damage(store, d)

					local m = create_entity(mods[1])

					m.modifier.level = this.aura.level
					m.modifier.target_id = target.id
					m.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						m.render = nil
					end

					queue_insert(store, m)
				end

				local targets_m = table.filter(store.entities, function(k, v)
					return v.unit and v.vis and v.health and not v.health.dead and
						band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and
						U.is_inside_ellipse(v.pos, this.pos, this.aura.radius * this.aura.radius_long_inc) and
						(not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and
						(not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and
						(not this.aura.excluded_entities or not table.contains(this.aura.excluded_entities, v.id))
				end)

				for _, target in pairs(targets_m) do
					local m = create_entity(mods[2])

					m.modifier.level = this.aura.level
					m.modifier.target_id = target.id
					m.modifier.source_id = this.id

					if this.aura.hide_source_fx and target.id == this.aura.source_id then
						m.render = nil
					end

					queue_insert(store, m)
				end
			end

			coroutine.yield()
		end

		queue_remove(store, this)
	end

	-- 圣龙
	function scripts5.mod_hero_lumenir_sword_hit.update(this, store, script)
		local m = this.modifier

		this.modifier.ts = store.tick_ts

		local target = store.entities[m.target_id]
		local time_hit = this.time_hit
		local decal_spawn_time = this.decal_spawn_time
		local damaged = false
		local decal_spawned = false

		if not target or not target.pos then
			queue_remove(store, this)

			return
		end

		this.pos = target.pos

		S:queue(this.sound)

		while true do
			target = store.entities[m.target_id]

			if m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
				queue_remove(store, this)

				return
			end

			if not damaged and time_hit < store.tick_ts - m.ts then
				damaged = true

				if target and not target.health.dead then
					local d = create_entity("damage")

					d.source_id = this.id
					d.target_id = target.id
					d.value = this.damage[m.level]
					d.damage_type = this.damage_type

					queue_damage(store, d)
				end

				local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.stun_range, this
					.stun_vis_flags, this.stun_bans)

				if targets then
					for _, target in pairs(targets) do
						local s = create_entity(this.mod_stun)

						s.modifier.target_id = target.id
						s.modifier.source_id = m.source_id
						s.modifier.duration = this.stun_duration[m.level]

						queue_insert(store, s)

						local d = create_entity("damage")

						d.damage_type = this.aura_damage_type
						d.value = this.aura_damage
						d.target_id = target.id

						queue_damage(store, d)
					end
				end
			end

			if not decal_spawned and decal_spawn_time < store.tick_ts - m.ts then
				decal_spawned = true

				local decal = create_entity(this.hit_decal)

				decal.pos = V.vclone(this.pos)
				decal.render.sprites[1].ts = store.tick_ts

				queue_insert(store, decal)
			end

			coroutine.yield()
		end
	end

	-- 安雅
	function scripts5.arrow_hero_hunter_ricochet.update(this, store)
		local b = this.bullet
		local target = store.entities[b.target_id]
		local dest = V.vclone(b.to)
		local bounce_count = 0
		local already_hit = {}
		local last_target
		local start_ts = store.tick_ts

		this.end_bounces = false

		local function create_arrow_trail(from, target)
			local bullet = create_entity(this.trail_arrow)

			bullet.pos = V.vclone(this.pos)
			bullet.bullet.from = V.vclone(from)
			bullet.bullet.to = V.vclone(target.pos)
			bullet.bullet.to.x = bullet.bullet.to.x + target.unit.hit_offset.x
			bullet.bullet.to.y = bullet.bullet.to.y + target.unit.hit_offset.y
			bullet.bullet.target_id = target.id
			bullet.bullet.source_id = this.id
			bullet.bullet.xp_dest_id = this.id

			queue_insert(store, bullet)
		end

		::label_467_0::

		if not b.ignore_hit_offset and this.track_target and target and target.motion then
			b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
		end

		if last_target ~= nil then
			this.pos = V.vclone(last_target.pos)

			if last_target.unit.hit_offset then
				this.pos.x, this.pos.y = this.pos.x + last_target.unit.hit_offset.x,
					this.pos.y + last_target.unit.hit_offset.y
			end
		end

		if b.hit_time > fts(1) then
			while store.tick_ts - start_ts < b.hit_time do
				coroutine.yield()

				if target and U.flag_has(target.vis.bans, F_RANGED) then
					target = nil
				end
			end
		end

		if target then
			create_arrow_trail(this.pos, target)
		end

		if this.ray_duration then
			while store.tick_ts - start_ts < this.ray_duration do
				coroutine.yield()
			end
		end

		if target and not target.health.dead then
			S:queue(this.sound_bounce)

			if b.mod or b.mods then
				local mods = b.mods or {
					b.mod
				}

				for _, mod_name in pairs(mods) do
					local m = create_entity(mod_name)

					m.modifier.source_id = this.id
					m.modifier.target_id = target.id
					m.bounce_count = bounce_count

					queue_insert(store, m)

					local beast = create_entity("soldier_hero_hunter_beast")

					beast.pos = V.vclone(target.pos)
					beast.owner = store.entities[this.id]
					beast.owner_offset = v(0, -10)

					queue_insert(store, beast)
				end
			end

			table.insert(already_hit, target.id)

			last_target = target
		end

		if b.hit_fx then
			local sfx = create_entity(b.hit_fx)

			sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
			sfx.render.sprites[1].ts = store.tick_ts
			sfx.render.sprites[1].runs = 0

			queue_insert(store, sfx)
		end

		S:queue(this.sound)
		U.y_wait(store, this.time_between_bounces)

		if target then
			local search_pos = V.vclone(target.pos)

			if bounce_count < this.bounces then
				local targets = U.find_enemies_in_range(store.entities, search_pos, 0, this.bounce_range, b.vis_flags,
					b.vis_bans, function(v)
						return not table.contains(already_hit, v.id)
					end)

				if targets then
					table.sort(targets, function(e1, e2)
						return V.dist(this.pos.x, this.pos.y, e1.pos.x, e1.pos.y) <
							V.dist(this.pos.x, this.pos.y, e2.pos.x, e2.pos.y)
					end)

					target = targets[1]
					bounce_count = bounce_count + 1
					b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
					b.target_id = target.id

					goto label_467_0
				end
			end
		end

		this.end_bounces = true

		queue_remove(store, this)
	end

	-- 狮鹫

	-- 木龙
	function scripts5.hero_dragon_arb.update(this, store)
		local h = this.health
		local he = this.hero
		local a, skill
		local shadow_sprite = this.render.sprites[2]
		local upg_lf = UP:get_upgrade("heroes_lethal_focus")

		this.ultimate_ts = store.tick_ts

		local s_ult = this.hero.skills.ultimate
		local attack_arborean_spawns = this.timed_attacks.list[1]
		local attack_thorn_bleed = this.timed_attacks.list[2]
		local attack_tower_runes = this.timed_attacks.list[3]
		local attack_tower_plants = this.timed_attacks.list[4]
		local power_index = 3

		if store.selected_team and this.template_name == store.selected_team[1] then
			power_index = 1
		end

		this.tween.disabled = false
		this.tween.ts = store.tick_ts
		this.health_bar.hidden = false

		local passive_controller = create_entity(this.controller_passive)

		passive_controller.root_zones_dequeue = passive_controller.root_zones_dequeue or {}
		passive_controller.root_zones_queue = passive_controller.root_zones_queue or {}
		passive_controller.root_zones = passive_controller.root_zones or {}

		queue_insert(store, passive_controller)

		local function attack_is_tower_valid(v, a)
			local is_tower = v.tower and not v.pending_removal and not v.tower.blocked and
				(not a.excluded_templates or not table.contains(a.excluded_templates, v.template_name)) and v.vis and
				band(v.vis.flags, a.vis_bans) == 0 and band(v.vis.bans, a.vis_flags) == 0 and
				not table.contains(a.exclude_tower_kind, v.tower.kind) and v.tower.can_be_mod and
				U.is_inside_ellipse(v.pos, this.pos, a.max_range) and
				(a.min_range == 0 or not U.is_inside_ellipse(v.pos, this.pos, a.min_range))

			return is_tower
		end

		local function attack_get_towers(a)
			local targets = table.filter(store.entities, function(k, v)
				return attack_is_tower_valid(v, a)
			end)

			if targets and #targets > 0 then
				return targets
			end

			return nil
		end

		this.desired_rotation = 0

		local function update_dragon_rotation(new_rotation)
			if new_rotation then
				this.desired_rotation = new_rotation
			end

			local current_rotation = math.abs(this.render.sprites[1].r)
			local rotation = U.ease_value(current_rotation, this.desired_rotation, 0.2, "linear")

			if not this.render.sprites[1].flip_x then
				rotation = -rotation
			end

			this.render.sprites[1].r = rotation
			this.render.sprites[3].r = rotation
		end

		local function y_hero_dragon_arb_walk_waypoints(store, this, animation)
			local animation = animation or "walk"
			local r = this.nav_rally
			local n = this.nav_grid
			local dest = r.pos
			local x_to_flip = KR_GAME == "kr5" and 2 or 0
			local last_af

			while not V.veq(this.pos, dest) do
				local w = table.remove(n.waypoints, 1) or dest
				local unsnap = #n.waypoints > 0

				U.set_destination(this, w)

				local an, af = U.animation_name_facing_point(this, animation, this.motion.dest)
				local new_af = af

				if x_to_flip > math.abs(this.pos.x - this.motion.dest.x) then
					new_af = last_af
				end

				U.animation_start(this, an, new_af, store.tick_ts, true)

				last_af = new_af

				local start_ts = store.tick_ts
				local time_to_accel = 0.7
				local dist_to_break = 50
				local orig_vx = r.pos.x - this.pos.x
				local rotation_multiplier = math.min(math.abs(orig_vx) / 300, 1)
				local current_dir = -1

				if orig_vx > 0 then
					current_dir = 1
				end

				local same_dir = false

				if this.old_rally_dir == current_dir then
					same_dir = true
				end

				local old_rally_ease_step = same_dir and this.old_rally_ease_step or nil

				this.old_rally_dir = current_dir

				while not this.motion.arrived do
					if this.health.dead and not this.health.ignore_damage then
						return true
					end

					if r.new then
						return false
					end

					local vx, vy = V.sub(r.pos.x, r.pos.y, this.pos.x, this.pos.y)
					local dist = V.len(vx, vy)
					local stored_max_speed = this.motion.max_speed
					local target_ease_step, ease_from

					if dist_to_break < dist then
						target_ease_step = (store.tick_ts - start_ts) / time_to_accel
						ease_from = 0
					else
						target_ease_step = dist / dist_to_break
						ease_from = 20
					end

					local ease_step = target_ease_step

					if old_rally_ease_step then
						ease_step = U.ease_value(old_rally_ease_step, target_ease_step,
							math.min(1, (store.tick_ts - start_ts) / (time_to_accel / 2)), "linear")
					end

					this.motion.max_speed = U.ease_value(ease_from, stored_max_speed, ease_step, "quad-in")
					this.old_rally_ease_step = ease_step

					local desired_rotation = math.rad(13 * this.motion.max_speed / stored_max_speed) *
						rotation_multiplier

					update_dragon_rotation(desired_rotation)
					U.walk(this, store.tick_length, nil, unsnap)

					this.motion.max_speed = stored_max_speed

					coroutine.yield()

					this.motion.speed.x, this.motion.speed.y = 0, 0
				end

				this.old_rally_ease_step = nil
				this.old_rally_dir = nil
			end
		end

		local function y_hero_dragon_arb_new_rally(store, this)
			local r = this.nav_rally

			if r.new then
				r.new = false

				U.unblock_target(store, this)

				if this.sound_events then
					S:queue(this.sound_events.change_rally_point)
				end

				local vis_bans = this.vis.bans
				local prev_immune = this.health.immune_to

				this.vis.bans = F_ALL
				this.health.immune_to = r.immune_to

				local out = y_hero_dragon_arb_walk_waypoints(store, this)

				U.animation_start(this, "idle", nil, store.tick_ts, true)

				this.vis.bans = vis_bans
				this.health.immune_to = prev_immune

				return out
			end
		end

		U.animation_start_group(this, this.idle_flip.last_animation, nil, store.tick_ts - fts(4), this.idle_flip.loop,
			this.render.sprites[1].group)

		while true do
			if h.dead then
				signal.emit("lock-user-power", power_index)
				SU.remove_modifiers(store, this, this.hero.skills.ultimate.mod)
				U.sprites_hide(this, 3, 3, true)
				SU5.y_hero_death_and_respawn_kr5(store, this)
				U.animation_start_group(this, this.idle_flip.last_animation, nil, store.tick_ts, this.idle_flip.loop,
					this.render.sprites[1].group)
				U.sprites_show(this, 3, 3, true)

				this.tween.props[2].disabled = false
				this.tween.props[2].ts = store.tick_ts
				this.tween.reverse = false

				signal.emit("unlock-user-power", power_index)
			end

			if this.ultimate_active and store.tick_ts > this.ultimate_ts + s_ult.duration[s_ult.level] then
				this.tween.reverse = true
				this.tween.props[2].disabled = false
				this.tween.props[2].ts = store.tick_ts

				SU.y_hero_wait(store, this, this.tween.props[2].keys[2][1])

				this.ultimate_active = false

				SU.remove_modifiers(store, this, s_ult.mod)
			end

			while this.nav_rally.new do
				local r = this.nav_rally
				local start_pos = V.vclone(this.pos)

				y_hero_dragon_arb_new_rally(store, this)
			end

			SU5.heroes_visual_learning_upgrade(store, this)
			SU5.heroes_lone_wolves_upgrade(store, this)
			SU5.alliance_merciless_upgrade(store, this)
			SU5.alliance_corageous_upgrade(store, this)

			if SU.hero_level_up(store, this) then
				U.y_animation_play_group(this, "lvlup", nil, store.tick_ts, 1, this.render.sprites[1].group)
			end

			for _, i in pairs(this.ranged.order) do
				do
					local a = this.ranged.attacks[i]

					if a.disabled then
						-- block empty
					elseif a.sync_animation and not this.render.sprites[1].sync_flag then
						-- block empty
					elseif store.tick_ts - a.ts < a.cooldown then
						-- block empty
					elseif i == 1 then
						local bullet_t = E:get_template(a.bullet)
						local flight_time = bullet_t.bullet.flight_time
						local target = U5.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false,
							a.vis_flags, a.vis_bans, function(v)
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
									local node_offset = P:predict_enemy_node_advance(v, flight_time + a.shoot_time)

									v_pos = P:node_pos(v.nav_path.pi, 1, v.nav_path.ni + node_offset)
								end

								local b_pos = V.vclone(this.pos)
								local bullet_start_offset = V.v(0, 0)
								local flip = this.pos.x > v_pos.x

								if a.bullet_start_offset and #a.bullet_start_offset == 2 then
									local offset_index = flip and 2 or 1

									bullet_start_offset = a.bullet_start_offset[offset_index]
								end

								b_pos.x = b_pos.x + (flip and -1 or 1) * bullet_start_offset.x
								b_pos.y = b_pos.y + bullet_start_offset.y

								local angle_d = math.deg(V.angleTo(v_pos.x - b_pos.x, v_pos.y - b_pos.y))

								angle_d = angle_d + 90
								angle_d = math.abs(angle_d)

								if angle_d > a.max_angle then
									return false
								end

								local dist_x = math.abs(v_pos.x - this.pos.x)
								local diff_y = math.abs(v_pos.y - this.pos.y)

								return dist_x > a.min_range / 2 and diff_y < a.min_range_dy
							end)

						if target then
							local start_ts = store.tick_ts
							local b, targets, emit_ps, emit_ts, bullet_start_offset
							local apply_thorn_bleed = false

							if not attack_thorn_bleed.disabled and store.tick_ts - attack_thorn_bleed.ts >= attack_thorn_bleed.cooldown then
								apply_thorn_bleed = true
							end

							local node_offset = P:predict_enemy_node_advance(target, flight_time)
							local t_pos = P:node_pos(target.nav_path.pi, target.nav_path.spi,
								target.nav_path.ni + node_offset)
							local an, af, ai = U.animation_name_facing_point(this, a.animation, t_pos)

							U.animation_start_group(this, an, af, store.tick_ts, false, this.render.sprites[1].group)
							S:queue(a.start_sound, a.start_sound_args)

							local triggered_lethal_focus

							while store.tick_ts - start_ts < a.shoot_times[1] do
								if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
									goto label_575_0
								end

								coroutine.yield()
							end

							S:queue(a.sound)

							b = create_entity(a.bullet_ray)
							b.bullet.target_id = target.id
							b.bullet.source_id = this.id
							b.bullet.xp_dest_id = this.id
							b.pos = V.vclone(this.pos)
							bullet_start_offset = v(0, 0)

							if a.bullet_start_offset and #a.bullet_start_offset == 2 then
								local offset_index = af and 2 or 1

								bullet_start_offset = a.bullet_start_offset[offset_index]
							end

							b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x
							b.pos.y = b.pos.y + bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)

							if b.bullet.ignore_hit_offset then
								b.bullet.to = V.v(t_pos.x, t_pos.y)
							else
								b.bullet.to = V.v(t_pos.x + target.unit.hit_offset.x, t_pos.y + target.unit.hit_offset.y)
							end

							queue_insert(store, b)

							if this.ultimate_active or apply_thorn_bleed then
								local diff = V.v(b.bullet.to.x - b.pos.x, b.bullet.to.y - b.pos.y)
								local normal_x, normal_y = V.normalize(diff.x, diff.y)
								local angle = V.angleTo(normal_x, normal_y)

								local function create_mouth_fx(fx_t, offset)
									local fx = create_entity(fx_t)

									fx.pos = V.v(b.pos.x + normal_x * offset, b.pos.y + normal_y * offset)

									local s = fx.render.sprites[1]

									s.r = angle
									s.ts = store.tick_ts
									s.flip_x = this.render.sprites[1].flip_x

									if s.flip_x then
										s.r = s.r + math.rad(180)
									end

									queue_insert(store, fx)
								end

								if this.ultimate_active then
									create_mouth_fx(a.ultimate_fx, a.ultimate_fx_offset)
								end

								if apply_thorn_bleed then
									create_mouth_fx(a.spikes_fx, a.spikes_fx_offset)
								end
							end

							if apply_thorn_bleed then
								b = create_entity(a.bullet_spikes)
								b.bullet.target_id = target.id
								b.bullet.source_id = this.id
								b.bullet.xp_dest_id = this.id
								b.pos = V.vclone(this.pos)
								bullet_start_offset = v(0, 0)

								if a.bullet_start_offset and #a.bullet_start_offset == 2 then
									local offset_index = af and 2 or 1

									bullet_start_offset = a.bullet_start_offset[offset_index]
								end

								b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x + math.random(-5, 5)
								b.pos.y = b.pos.y + bullet_start_offset.y + math.random(-5, 5)
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.v(t_pos.x + math.random(-20, 20), t_pos.y + math.random(-20, 20))

								queue_insert(store, b)
								SU.hero_gain_xp_from_skill(this, this.hero.skills.thorn_bleed)
							end

							if a.xp_from_skill then
								SU.hero_gain_xp_from_skill(this, this.hero.skills[a.xp_from_skill])
							end

							if upg_lf then
								if not this._lethal_focus_deck then
									this._lethal_focus_deck = SU.deck_new(upg_lf.trigger_cards, upg_lf.total_cards)
								end

								triggered_lethal_focus = SU.deck_draw(this._lethal_focus_deck)
							end

							for shot_time_i = 1, #a.shoot_times do
								while store.tick_ts - start_ts < a.shoot_times[shot_time_i] do
									if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
										goto label_575_0
									end

									coroutine.yield()
								end

								b = create_entity(a.bullet)
								b.bullet.target_id = target.id
								b.bullet.source_id = this.id
								b.bullet.xp_gain_factor = a.xp_gain_factor
								b.bullet.xp_dest_id = this.id
								b.pos = V.vclone(this.pos)
								bullet_start_offset = v(0, 0)

								if a.bullet_start_offset and #a.bullet_start_offset == 2 then
									local offset_index = af and 2 or 1

									bullet_start_offset = a.bullet_start_offset[offset_index]
								end

								b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x + math.random(-5, 5)
								b.pos.y = b.pos.y + bullet_start_offset.y + math.random(-5, 5)
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.v(t_pos.x + math.random(-20, 20), t_pos.y + math.random(-20, 20))
								b.bullet.damage_max = b.bullet.damage_max / #a.shoot_times
								b.bullet.damage_min = b.bullet.damage_min / #a.shoot_times
								b.bullet.shot_index = i

								if b.bullet.use_unit_damage_factor then
									b.bullet.damage_factor = this.unit.damage_factor
								end

								b.cached_controller_dragon_arb_passive_id = passive_controller.id

								if apply_thorn_bleed then
									b.bullet.mod = table.deepclone(attack_thorn_bleed.mod)

									if this.ultimate_active then
										b.instakill_chance = attack_thorn_bleed.instakill_chance
									end
								end

								if triggered_lethal_focus then
									b.bullet.damage_factor = b.bullet.damage_factor * upg_lf.damage_factor_area
									b.bullet.pop = {
										"pop_crit"
									}
									b.bullet.pop_chance = 1
									b.bullet.pop_conds = DR_DAMAGE
								end

								queue_insert(store, b)
							end

							if apply_thorn_bleed then
								attack_thorn_bleed.ts = start_ts
							end

							a.ts = start_ts

							SU.y_hero_animation_wait(this)
							U.animation_start_group(this, this.idle_flip.last_animation, nil, store.tick_ts,
								this.idle_flip.loop, this.render.sprites[1].group)

							::label_575_0::

							goto label_575_1
						end
					end
				end

				::label_575_1::
			end

			skill = this.hero.skills.arborean_spawn
			a = attack_arborean_spawns

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local root_zones = passive_controller.root_zones or {}
				local plant_zones = table.filter(root_zones, function(k, v)
					if not U.is_inside_ellipse({
							x = v.x,
							y = v.y
						}, this.pos, a.max_range) then
						return false
					end

					if a.min_range ~= 0 and not not U.is_inside_ellipse({
							x = v.x,
							y = v.y
						}, this.pos, a.min_range) then
						return false
					end

					local enemies = U.find_enemies_in_range(store.entities, {
						x = v.x,
						y = v.y
					}, 0, a.spawn_max_range_to_enemy, a.vis_flags, a.vis_bans)

					if not enemies or #enemies < 1 then
						return false
					end

					return true
				end)

				if not plant_zones or #plant_zones < a.min_targets then
					SU.delay_attack(store, a, fts(10))
				else
					plant_zones = table.random_order(plant_zones)
					plant_zones = table.slice(plant_zones, 1, a.max_targets)

					local start_ts = store.tick_ts

					S:queue(a.sound)
					U.animation_start_group(this, a.animation, nil, store.tick_ts, false, this.render.sprites[1].group)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_575_2
					end

					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					for i = 1, #plant_zones do
						local zone_target = plant_zones[i]
						local b = create_entity(a.bullet)

						b.bullet.target_id = nil
						b.bullet.source_id = this.id
						b.bullet.xp_dest_id = this.id
						b.pos = V.vclone(this.pos)

						local bullet_start_offset = v(0, 0)
						local af = this.render.sprites[1].flip_x

						if a.bullet_start_offset and #a.bullet_start_offset == 2 then
							local offset_index = af and 2 or 1

							bullet_start_offset = a.bullet_start_offset[offset_index]
						end

						b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x
						b.pos.y = b.pos.y + bullet_start_offset.y
						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(zone_target.x, zone_target.y)
						b.bullet.level = skill.level
						b.bullet.payload = (this.ultimate_active and a.spawn_evolved or a.spawn) .. "_lvl" .. skill
							.level
						b.cached_controller_dragon_arb_passive_id = passive_controller.id
						b.zone_target_id = zone_target.zone_id

						queue_insert(store, b)

						if SU.y_hero_wait(store, this, a.shoots_delay) then
							goto label_575_2
						end
					end

					SU.y_hero_animation_wait(this)
				end
			end

			skill = this.hero.skills.tower_runes
			a = attack_tower_runes

			if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.wave_group_number > 0 then
				local towers = attack_get_towers(a)

				if not towers then
					SU.delay_attack(store, a, fts(10))
				else
					local start_ts = store.tick_ts

					S:queue(a.sound)
					U.animation_start_group(this, a.animation, nil, store.tick_ts, false, this.render.sprites[1].group)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_575_2
					end

					towers = attack_get_towers(a)

					if not towers then
						SU.delay_attack(store, a, fts(60))
						SU.y_hero_animation_wait(this)

						goto label_575_2
					end

					towers = table.random_order(towers)
					towers = table.slice(towers, 1, a.max_targets)
					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					for i = 1, #towers do
						local target = towers[i]

						if not store.entities[target.id] then
							-- block empty
						elseif not attack_is_tower_valid(target, a) then
							-- block empty
						else
							local b = create_entity(a.bullet)

							b.bullet.target_id = target.id
							b.bullet.source_id = this.id
							b.bullet.xp_dest_id = this.id
							b.pos = V.vclone(this.pos)

							local bullet_start_offset = v(0, 0)
							local af = this.render.sprites[1].flip_x

							if a.bullet_start_offset and #a.bullet_start_offset == 2 then
								local offset_index = af and 2 or 1

								bullet_start_offset = a.bullet_start_offset[offset_index]
							end

							b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x
							b.pos.y = b.pos.y + bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.v(target.pos.x, target.pos.y + 16)

							queue_insert(store, b)

							if SU.y_hero_wait(store, this, a.shoots_delay) then
								goto label_575_2
							end
						end
					end

					SU.y_hero_animation_wait(this)
				end
			end

			skill = this.hero.skills.tower_plants
			a = attack_tower_plants

			if not a.disabled and store.tick_ts - a.ts > a.cooldown and store.wave_group_number > 0 then
				local towers = attack_get_towers(a)

				if not towers then
					SU.delay_attack(store, a, fts(10))
				else
					local start_ts = store.tick_ts

					S:queue(a.sound)
					U.animation_start_group(this, a.animation, nil, store.tick_ts, false, this.render.sprites[1].group)

					if SU.y_hero_wait(store, this, a.cast_time) then
						goto label_575_2
					end

					towers = attack_get_towers(a)

					if not towers then
						SU.delay_attack(store, a, fts(60))
						SU.y_hero_animation_wait(this)

						goto label_575_2
					end

					towers = table.random_order(towers)
					towers = table.slice(towers, 1, a.max_targets)
					a.ts = start_ts

					SU.hero_gain_xp_from_skill(this, skill)

					for i = 1, #towers do
						local target = towers[i]

						if not store.entities[target.id] then
							-- block empty
						elseif not attack_is_tower_valid(target, a) then
							-- block empty
						else
							local b = create_entity(a.bullet)

							b.bullet.target_id = target.id
							b.bullet.source_id = this.id
							b.bullet.xp_dest_id = this.id
							b.pos = V.vclone(this.pos)

							local bullet_start_offset = v(0, 0)
							local af = this.render.sprites[1].flip_x

							if a.bullet_start_offset and #a.bullet_start_offset == 2 then
								local offset_index = af and 2 or 1

								bullet_start_offset = a.bullet_start_offset[offset_index]
							end

							b.pos.x = b.pos.x + (af and -1 or 1) * bullet_start_offset.x
							b.pos.y = b.pos.y + bullet_start_offset.y
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.vclone(target.tower.default_rally_pos)

							if target.tower.team == TEAM_LINIREA then
								b.bullet.hit_payload = a.plant_linirea
							else
								b.bullet.hit_payload = a.plant_dark_army
							end

							queue_insert(store, b)
							SU.y_hero_wait(store, this, a.shots_delay)
						end
					end

					SU.y_hero_animation_wait(this)
				end
			end

			SU.soldier_idle(store, this)

			this.render.sprites[3].flip_x = this.render.sprites[1].flip_x

			SU.soldier_regen(store, this)

			::label_575_2::

			coroutine.yield()
		end
	end

	-- 骨龙
	function scripts5.hero_dragon_bone.insert(this, store)
		this.hero.fn_level_up(this, store, true)

		this.ranged.order = U.attack_order(this.ranged.attacks)

		if this.hero.skills.ultimate.level > 0 then
			local aura = E:create_entity("death_rider_aura_dragon_bone")
			aura.aura.source_id = this.id

			queue_insert(store, aura)
		end

		return true
	end

	scripts5.death_rider_aura_dragon_bone = {}

	function scripts5.death_rider_aura_dragon_bone.update(this, store, script)
		local first_hit_ts
		local last_hit_ts = 0
		local cycles_count = 0
		local victims_count = 0

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

			if this.aura.track_source and this.aura.source_id then
				local te = store.entities[this.aura.source_id]

				if not te or te.health and te.health.dead and not this.aura.track_dead then
					break
				end
			end

			if this.aura.requires_magic then
				local te = store.entities[this.aura.source_id]

				if not te or not te.enemy then
					goto label_88_0
				end

				if this.render then
					this.render.sprites[1].hidden = not te.enemy.can_do_magic
				end

				if not te.enemy.can_do_magic then
					goto label_88_0
				end
			end

			if this.aura.source_vis_flags and this.aura.source_id then
				local te = store.entities[this.aura.source_id]

				if te and te.vis and band(te.vis.bans, this.aura.source_vis_flags) ~= 0 then
					goto label_88_0
				end
			end

			if this.aura.requires_alive_source and this.aura.source_id then
				local te = store.entities[this.aura.source_id]

				if te and te.health and te.health.dead then
					goto label_88_0
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

				local targets = utils_UH.find_entities_in_range(store.entities, this.pos, 0, this.aura.radius,
					this.aura.vis_flags, this.aura.vis_bans, function(v, origin)
						if v then
							print()
						end
						return (v.unit or v.tower) and
							(not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and
							(not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and
							(not this.aura.filter_source or this.aura.source_id ~= v.id) and
							(not this.aura.filter_func or this.aura.filter_func(v, origin))
					end)

				if targets then
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
			end

			::label_88_0::

			coroutine.yield()
		end

		signal.emit("aura-apply-mod-victims", this, victims_count)
		queue_remove(store, this)
	end

	scripts5.mod_death_rider_dragon_bone = {}

	function scripts5.mod_death_rider_dragon_bone.insert(this, store, script)
		local m = this.modifier
		local target = store.entities[m.target_id]

		if not target then
			return false
		end

		if target.tower then
			target.tower.damage_factor = target.tower.damage_factor * this.tower_inflicted_damage_factor
		else
			target.health.armor = target.health.armor + this.extra_armor
			target.unit.damage_factor = target.unit.damage_factor * this.inflicted_damage_factor
		end

		return true
	end

	function scripts5.mod_death_rider_dragon_bone.remove(this, store, script)
		local m = this.modifier
		local target = store.entities[m.target_id]

		if target then
			if target.tower then
				target.tower.damage_factor = target.tower.damage_factor / this.tower_inflicted_damage_factor
			else
				target.health.armor = target.health.armor - this.extra_armor
				target.unit.damage_factor = target.unit.damage_factor / this.inflicted_damage_factor
			end
		end

		return true
	end

	function scripts5.mod_death_rider_dragon_bone.update(this, store, script)
		local m = this.modifier

		this.modifier.ts = store.tick_ts

		local target = store.entities[m.target_id]

		if not target or not target.pos then
			queue_remove(store, this)

			return
		end

		this.pos = target.pos

		while true do
			target = store.entities[m.target_id]

			if not target or m.duration >= 0 and store.tick_ts - m.ts > m.duration then
				queue_remove(store, this)

				return
			end

			if this.render then
				local s = this.render.sprites[1]
				local flip_sign = 1

				if target.render then
					flip_sign = target.render.sprites[1].flip_x and -1 or 1
				end

				if m.health_bar_offset and target.health_bar then
					local hb = target.health_bar.offset
					local hbo = m.health_bar_offset

					s.offset.x, s.offset.y = hb.x + hbo.x * flip_sign, hb.y + hbo.y
				elseif m.use_mod_offset and target.unit and target.unit.mod_offset then
					s.offset.x, s.offset.y = target.unit.mod_offset.x * flip_sign, target.unit.mod_offset.y
				end
			end

			coroutine.yield()
		end
	end
end

return scripts_UH
