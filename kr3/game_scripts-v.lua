local log = require("klua.log"):new("game_scripts")

require("klua.table")

local km = require("klua.macros")
local signal = require("hump.signal")
local AC = require("achievements")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local earnings_stats = require("earnings_stats")
local P = require("path_db")
local S = require("sound_db")
local SU = require("script_utils_v")
local U = require("utils_v")--"utils_v"
local LU = require("level_utils")
local UP = require("upgrades")
--local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("game_scripts_v1")

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

local IS_PHONE = KR_TARGET == "phone"
local IS_CONSOLE = KR_TARGET == "console"

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or e.pos
end

---蜥蜴人狙击塔
scripts.arrow_v = {}

function scripts.arrow_v.update(this, store, script)
	local b = this.bullet
	local ps
	local s = this.render.sprites[1]

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length <= b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.rotation_speed then
			s.r = s.r + b.rotation_speed * store.tick_length
		else
			s.r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)

			if b.asymmetrical and math.abs(s.r) > math.pi / 2 then
				s.flip_y = true
			end
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end

		if b.hide_radius then
			s.hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius

			if ps then
				ps.particle_system.emit = not s.hidden
			end
		end
	end

	local hit = false
	local target = store.entities[b.target_id]

	if target and target.health and not target.health.dead then
		local target_pos = V.vclone(target.pos)

		if target.unit and target.unit.hit_offset and not b.ignore_hit_offset then
			target_pos.x, target_pos.y = target_pos.x + target.unit.hit_offset.x, target_pos.y + target.unit.hit_offset.y
		end

		if V.dist(this.pos.x, this.pos.y, target_pos.x, target_pos.y) < b.hit_distance and not SU.unit_dodges(store, target, true) and (not b.hit_chance or math.random() < b.hit_chance) then
			hit = true
			
			table.insert(b.seen_targets, target.id)

			local d = SU.create_bullet_damage(b, target.id, this.id)
			
			local u = UP:get_upgrade("archer_precision")
			
			if u and math.random() < u.chance and b.can_split then
				local u = UP:get_upgrade_info("archer_precision_v")
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.visflags, this.visbans, function(e)
				return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
			end)
				if enemy then	
					local b2 = E:create_entity(u.bullet)
					
					b2.bullet.damage_factor = b.damage_factor
					b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
					b2.bullet.from = V.vclone(b2.pos)
					b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					b2.bullet.target_id = enemy.id
					b2.bullet.seen_targets = b.seen_targets
					b2.bullet.damage_min = b.damage_min
					b2.bullet.damage_max = b.damage_max
					
					queue_insert(store, b2)
				end
			end
			
			queue_damage(store, d)

			if b.mod then
				local mods = type(b.mod) == "table" and b.mod or {
					b.mod
				}

				for _, mod_name in pairs(mods) do
					local mod = E:create_entity(mod_name)

					mod.modifier.source_id = this.id
					mod.modifier.target_id = target.id
					mod.modifier.level = b.level
					mod.modifier.source_damage = d

					queue_insert(store, mod)
				end
			end

			if b.hit_fx then
				local fx = E:create_entity(b.hit_fx)

				fx.pos = V.vclone(target_pos)
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.hit_blood_fx and target.unit.blood_color ~= BLOOD_NONE then
				local sfx = E:create_entity(b.hit_blood_fx)

				sfx.pos = V.vclone(target_pos)
				sfx.render.sprites[1].ts = store.tick_ts

				if sfx.use_blood_color and target.unit.blood_color then
					sfx.render.sprites[1].name = target.unit.blood_color
					sfx.render.sprites[1].r = s.r
				end

				queue_insert(store, sfx)
			end
		end
	end

	if not hit then
		if GR:cell_is(this.pos.x, this.pos.y, TERRAIN_WATER) then
			if b.miss_fx_water then
				local water_fx = E:create_entity(b.miss_fx_water)

				water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
				water_fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, water_fx)
			end
		else
			if b.miss_fx then
				local fx = E:create_entity(b.miss_fx)

				fx.pos.x, fx.pos.y = b.to.x, b.to.y
				fx.render.sprites[1].ts = store.tick_ts

				queue_insert(store, fx)
			end

			if b.miss_decal then
				local decal = E:create_entity("decal_tween")

				decal.pos = V.vclone(b.to)
				decal.tween.props[1].keys = {
					{
						0,
						255
					},
					{
						2.1,
						0
					}
				}
				decal.render.sprites[1].ts = store.tick_ts
				decal.render.sprites[1].name = b.miss_decal
				decal.render.sprites[1].animated = false
				decal.render.sprites[1].z = Z_DECALS

				if b.rotation_speed then
					decal.render.sprites[1].flip_x = b.rotation_speed > 0
				else
					decal.render.sprites[1].r = -math.pi / 2 * (1 + (0.5 - math.random()) * 0.35)
				end

				if b.miss_decal_anchor then
					decal.render.sprites[1].anchor = b.miss_decal_anchor
				end

				queue_insert(store, decal)
			end
		end
	end

	if b.payload then
		local p = E:create_entity(b.payload)

		p.pos.x, p.pos.y = b.to.x, b.to.y
		p.target_id = b.target_id
		p.source_id = this.id

		if p.aura then
			p.aura.level = b.level
		end

		queue_insert(store, p)
	end

	if ps and ps.particle_system.emit then
		s.hidden = true
		ps.particle_system.emit = false

		U.y_wait(store, ps.particle_system.particle_lifetime[2])
	end

	queue_remove(store, this)
end
scripts.tower_archer_v = {}

function scripts.tower_archer_v.insert(this, store, script)
	return true
end

function scripts.tower_archer_v.update(this, store, script)
	local at = this.attacks
	local a = this.attacks.list[1]
	local last_enemy, last_enemy_shots
	local shooter_sprite_ids = table.slice({
		3,
		4,
		5
	}, 1, #a.bullet_start_offset)
	local last_target_pos = V.v(0, 0)

	a.ts = store.tick_ts

	while true do
		local enemy

		if this.tower.blocked then
			-- block empty
		elseif store.tick_ts - a.ts < a.cooldown then
			-- block empty
		else
			enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

			if enemy then
				a.ts = store.tick_ts
				a.count = a.count + 1

				local shooter_idx = a.count % #a.bullet_start_offset + 1
				local shooter_sid = shooter_sprite_ids[shooter_idx]
				local start_offset = a.bullet_start_offset[shooter_idx]
				local s = this.render.sprites[shooter_sid]
				local an, af = U.animation_name_facing_point(this, "shoot", enemy.pos, shooter_sid, start_offset)

				U.animation_start(this, an, af, store.tick_ts, 1, shooter_sid)

				last_target_pos = enemy.pos

				while store.tick_ts - a.ts < a.shoot_time do
					coroutine.yield()
				end

				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

				if enemy then
					last_target_pos = enemy.pos

					local an, af = U.animation_name_facing_point(this, "shoot", enemy.pos, shooter_sid, start_offset)

					this.render.sprites[shooter_sid].flip_x = af

					local bullet = E:create_entity(a.bullet)

					bullet.bullet.damage_factor = this.tower.damage_factor
					bullet.pos.x, bullet.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
					bullet.bullet.from = V.vclone(bullet.pos)
					bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
					bullet.bullet.target_id = enemy.id
					bullet.visbans = a.vis_bans
					bullet.visflags = a.vis_flags

					if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
						local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

						bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
					end

					local u = UP:get_upgrade("archer_piercing")

					if u and enemy.health and enemy.health.armor > 0 then
						if last_enemy and last_enemy == enemy then
							last_enemy_shots = last_enemy_shots + 1

							local dmg_inc = km.clamp(0, bullet.bullet.armor_damage_max, last_enemy_shots * bullet.bullet.armor_damage_inc)

							bullet.bullet.reduce_armor = bullet.bullet.reduce_armor + dmg_inc
						else
							last_enemy = enemy
							last_enemy_shots = 0
						end
					end

					queue_insert(store, bullet)
				end
			end

			if store.tick_ts - a.ts > this.tower.long_idle_cooldown then
				for _, sid in pairs(shooter_sprite_ids) do
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

					U.animation_start(this, an, af, store.tick_ts, -1, sid)
				end
			end
		end

		coroutine.yield()
	end
end
scripts.tower_deathcoil = {}

function scripts.tower_deathcoil.get_info(this)
	local t = scripts.tower_common.get_info(this)
	local pow_c = this.powers.charged

	if pow_c.level > 0 then
		t.damage_min = t.damage_min + pow_c.charged_damage
		t.damage_max = t.damage_max + pow_c.charged_damage
	end

	return t
end

function scripts.tower_deathcoil.remove(this, store)
	local a = this.attacks.list[1]
	local crosshair = store.entities[a.crosshair_id]
								
	if crosshair then
		queue_remove(store, crosshair)
	end
	
	local aim_ray_id = store.entities[a.ray_id]
	
	if aim_ray_id then
		queue_remove(store, aim_ray_id)
	end

	return true
end

function scripts.tower_deathcoil.update(this, store, script)
	local at = this.attacks
	local a = this.attacks.list[1]
	local as = this.attacks.list[2]
	local last_enemy, last_enemy_shots, last_seen_enemy
	local shooter_sprite_id = 5
	local last_target_pos = V.v(0, 0)
	local shooting = nil
	local last_reduce_armor = 0
	local idle_ts
	local pow_c = this.powers.charged
	local pow_s = this.powers.stun
	local charged = nil
	local reaim = nil
	
	idle_ts = store.tick_ts

	a.ts = store.tick_ts
	as.ts = store.tick_ts

	while true do
		local enemy
		
		::label_5123_0::

		if this.tower.blocked then
			coroutine.yield()
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_c then
						-- block empty
					elseif pow == pow_s then
						as.disabled = false
					end
				end
			end
			
			if pow_c.charged_damage > 0 then
				this.render.sprites[6].hidden = false
				if charged then
					S:queue("SaurianSniperCharge")
					charged = nil
				end
			else
				charged = nil
				this.render.sprites[6].hidden = true
			end
			
			if pow_s.level > 0 and store.tick_ts - as.ts >= as.cooldown then
				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, as.vis_flags, as.vis_bans, function(e)
--						return e and not e.health.dead and band(e.vis.flags, F_SPELLCASTER) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
						return e and not e.health.dead and band(e.vis.flags) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
					end)

				if enemy then
					as.ts = store.tick_ts
					
					if not shooting and (not last_seen_enemy or last_seen_enemy ~= enemy) then
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_start", enemy.pos, shooter_sprite_id)
					
						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
					end

					while store.tick_ts - as.ts < as.shoot_time do
						coroutine.yield()
					end
					
					if enemy then
					
						S:queue("SaurianSniperStunAim")
						
						this.render.sprites[7].hidden = false
							
						local an, af = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
						
						U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
						local start_ts = store.tick_ts
						
						while store.tick_ts - start_ts < as.aim_time do
							coroutine.yield()
						end

						enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, as.vis_flags, as.vis_bans, function(e)
--							return e and not e.health.dead and band(e.vis.flags, F_SPELLCASTER) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
							return e and not e.health.dead and band(e.vis.flags) ~= 0 and not U.has_modifiers(store, e, "mod_deathcoil_stun")
						end)

						if enemy then
							
							shooting = true

							local an, af, aidx = U.animation_name_facing_point(this, "shoot_loop", enemy.pos, shooter_sprite_id)
						
							U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
							U.y_wait(store, as.shoot_time)
							
							if enemy then

								this.render.sprites[shooter_sprite_id].flip_x = af
								
								if af then
									aidx = aidx + 3
								end
								
								local bullet = E:create_entity(as.bullet)
								
								bullet.pos.x, bullet.pos.y = this.pos.x + as.bullet_start_offset[aidx].x, this.pos.y + as.bullet_start_offset[aidx].y
								bullet.bullet.from = V.vclone(bullet.pos)
								bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
								bullet.bullet.target_id = enemy.id
								bullet.visbans = as.vis_bans
								bullet.visflags = as.vis_flags
								bullet.bullet.level = pow_s.level
								bullet.bullet.source_id = this.id

								if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
									local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

									bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
								end

								queue_insert(store, bullet)
								
								last_seen_enemy = enemy
							end
						end
							
						this.render.sprites[7].hidden = true
						
						U.y_animation_wait(this, shooter_sprite_id)
					end
					
					idle_ts = store.tick_ts
				end

				if store.tick_ts - idle_ts > this.tower.long_idle_cooldown then
					
					if shooting then
						local an, af = U.animation_name_facing_point(this, "shoot_end", this.tower.long_idle_pos, shooter_sprite_id)
						if this.render.sprites[shooter_sprite_id].flip_x then
							af = true
						end

						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
						
						shooting = nil
					end
				
					an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sprite_id)
					
					if this.render.sprites[shooter_sprite_id].flip_x then
						af = true
					end

					U.animation_start(this, an, af, store.tick_ts, -1, shooter_sprite_id)
				end
			end
		
			if store.tick_ts - a.ts >= a.cooldown or reaim then
				
				enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

				if enemy then
					a.ts = store.tick_ts
					
					if not shooting and (not last_seen_enemy or last_seen_enemy ~= enemy) then
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_start", enemy.pos, shooter_sprite_id)
					
						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
					end

					while store.tick_ts - a.ts < a.shoot_time do
						coroutine.yield()
					end

					enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, at.range, false, a.vis_flags, a.vis_bans)

					if enemy then
						
						local m = E:create_entity(a.crosshair_name)

						m.modifier.source_id = this.id
						m.modifier.target_id = enemy.id
						m.render.sprites[1].ts = store.tick_ts

						queue_insert(store, m)
						
						a.crosshair_id = m.id
						
						local ray = E:create_entity(a.ray)
						
						local an, af, aidx = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
						
						if af then
							aidx = aidx + 3
						end

						ray.pos.x, ray.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
						ray.bullet.from = V.vclone(ray.pos)
						ray.bullet.to = V.vclone(enemy.pos)
						ray.bullet.target_id = enemy.id

						queue_insert(store, ray)
						
						a.ray_id = ray.id
						
						shooting = true
						last_target_pos = enemy.pos
						
						local b = E:get_template(a.bullet)
						
						local d = E:create_damage()
						
						d.value = math.max(1, math.ceil(this.tower.damage_factor * b.bullet.damage_min))
						d.damage_type = b.bullet.damage_type
						
						local damage_max = math.max(1, math.ceil(this.tower.damage_factor * b.bullet.damage_max))
						
						if pow_c.level > 0 then
							d.value = d.value + pow_c.charged_damage
							damage_max = damage_max + pow_c.charged_damage
						end
						
						local u = UP:get_upgrade("archer_piercing")

						if u and enemy.health and enemy.health.armor > 0 then
							if last_enemy and last_enemy == enemy then

								local dmg_inc = km.clamp(0, b.bullet.armor_damage_max, last_enemy_shots * b.bullet.armor_damage_inc)
								last_reduce_armor = b.bullet.reduce_armor + dmg_inc
							else
								last_reduce_armor = 0
							end
						end
						
						d.reduce_armor = last_reduce_armor
						
						local charge_ts = store.tick_ts
			
						if reaim then
							reaim = nil
						end
						
						while d.value < damage_max and not this.tower.blocked and U.is_inside_ellipse(enemy.pos, this.pos, at.range + 15) do
							if store.tick_ts - charge_ts > a.charge_tick then
								charge_ts = store.tick_ts
								d.value = math.max(1, math.ceil(d.value * 1.1))
							end
							local an, af, aidx = U.animation_name_facing_point(this, "shoot_aim", enemy.pos, shooter_sprite_id)
					
							U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
							
							if af then
								aidx = aidx + 3
							end
							
							local aim_ray_id = store.entities[a.ray_id]
							
							if aim_ray_id then
								aim_ray_id.pos.x, aim_ray_id.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
								aim_ray_id.bullet.from = V.vclone(aim_ray_id.pos)
							end
							
							local next = P:next_entity_node(enemy, store.tick_length)
							
							if not enemy or enemy.health.dead or enemy.health.hp == 0 or not next then
								
								local crosshair = store.entities[a.crosshair_id]
								
								if crosshair then
									queue_remove(store, crosshair)
								end
								
								local aim_ray_id = store.entities[a.ray_id]
								
								if aim_ray_id then
									queue_remove(store, aim_ray_id)
								end
								
								reaim = true
								
								goto label_5123_0
							end
							
							if U.predict_damage(enemy, d) >= enemy.health.hp then
								break
							end
							
							coroutine.yield()
						end
						
						local damage_total 
						
						if pow_c.level > 0 then
							damage_total =  math.min(b.bullet.damage_max + pow_c.charged_damage, d.value)
						else
							damage_total =  math.min(b.bullet.damage_max, d.value)
						end

						local an, af, aidx = U.animation_name_facing_point(this, "shoot_loop", enemy.pos, shooter_sprite_id)
					
						U.animation_start(this, an, af, store.tick_ts, false, shooter_sprite_id)
						U.y_wait(store, a.shoot_time)

						last_target_pos = enemy.pos

						this.render.sprites[shooter_sprite_id].flip_x = af
						
						if af then
							aidx = aidx + 3
						end
						
						local bullet = E:create_entity(a.bullet)

						bullet.bullet.damage_min = damage_total
						bullet.bullet.damage_max = damage_total
						bullet.bullet.damage_factor = this.tower.damage_factor
						bullet.pos.x, bullet.pos.y = this.pos.x + a.bullet_start_offset[aidx].x, this.pos.y + a.bullet_start_offset[aidx].y
						bullet.bullet.from = V.vclone(bullet.pos)
						bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
						bullet.bullet.target_id = enemy.id
						bullet.visbans = a.vis_bans
						bullet.visflags = a.vis_flags
						
						if pow_c.charged_damage > 0 then
							bullet.render.sprites[1].prefix = "tower_deathcoil_charged"
							bullet.bullet.hit_fx = "fx_deathcoil_charged_hit"
							bullet.sound_events.insert = "SaurianSniperChargedBullet"
						end

						if bullet.bullet.flight_time_min and bullet.bullet.flight_time_factor then
							local dist = V.dist(bullet.bullet.to.x, bullet.bullet.to.y, bullet.bullet.from.x, bullet.bullet.from.y)

							bullet.bullet.flight_time = bullet.bullet.flight_time_min + dist / at.range * bullet.bullet.flight_time_factor
						end

						local u = UP:get_upgrade("archer_piercing")

						if u and enemy.health and enemy.health.armor > 0 then
							if last_enemy and last_enemy == enemy then
								last_enemy_shots = last_enemy_shots + 1

								local dmg_inc = km.clamp(0, bullet.bullet.armor_damage_max, last_enemy_shots * bullet.bullet.armor_damage_inc)

								bullet.bullet.reduce_armor = bullet.bullet.reduce_armor + dmg_inc
							else
								last_enemy = enemy
								last_enemy_shots = 0
							end
						end

						queue_insert(store, bullet)
						
						local next = P:next_entity_node(enemy, store.tick_length)
						
						if pow_c.level > 0 and damage_total < damage_max then
							if next then
								pow_c.charged_damage = math.ceil((damage_max - damage_total) * pow_c.factor[pow_c.level])
							end
							if this.render.sprites[6].hidden then
								charged = true
							end
						else
							pow_c.charged_damage = 0
						end
						
						local crosshair = store.entities[a.crosshair_id]
						
						if crosshair then
							queue_remove(store, crosshair)
						end
						
						local aim_ray_id = store.entities[a.ray_id]
						
						if aim_ray_id then
							queue_remove(store, aim_ray_id)
						end
						
						last_seen_enemy = enemy
					end
					
					U.y_animation_wait(this, shooter_sprite_id)
					
					idle_ts = store.tick_ts
				end

				if store.tick_ts - idle_ts > this.tower.long_idle_cooldown then
					
					if shooting then
						local an, af = U.animation_name_facing_point(this, "shoot_end", this.tower.long_idle_pos, shooter_sprite_id)
						if this.render.sprites[shooter_sprite_id].flip_x then
							af = true
						end

						U.y_animation_play(this, an, af, store.tick_ts, 1, shooter_sprite_id)
						
						shooting = nil
					end
				
					an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sprite_id)
					
					if this.render.sprites[shooter_sprite_id].flip_x then
						af = true
					end

					U.animation_start(this, an, af, store.tick_ts, -1, shooter_sprite_id)
				end
			end

			coroutine.yield()
		end
	end
end

scripts.bolt_deathcoil = {}

function scripts.bolt_deathcoil.update(this, store, script)
	local b = this.bullet
	local s = this.render.sprites[1]
	local mspeed = b.min_speed
	local target, ps
	local new_target = false
	local target_invalid = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_75_0::

	if b.store and not b.target_id then
		S:queue(this.sound_events.summon)

		s.z = Z_OBJECTS
		s.sort_y_offset = b.store_sort_y_offset

		U.animation_start(this, "idle", nil, store.tick_ts, true)

		if ps then
			ps.particle_system.emit = false
		end
	else
		S:queue(this.sound_events.travel)

		s.z = Z_BULLETS
		s.sort_y_offset = nil

		U.animation_start(this, "flying", nil, store.tick_ts, s.loop)

		if ps then
			ps.particle_system.emit = true
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		coroutine.yield()

		if not target_invalid then
			target = store.entities[b.target_id]
		end

		if target and not new_target then
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance or band(target.vis.bans, F_RANGED) ~= 0 then
				target_invalid = true
				target = nil
			end
		end

		if target and target.health and not target.health.dead then
			if b.ignore_hit_offset then
				b.to.x, b.to.y = target.pos.x, target.pos.y
			else
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end

			new_target = false
		end

		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length

		if not b.ignore_rotation then
			s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end
	end

	while b.store and not b.target_id do
		coroutine.yield()

		if b.target_id then
			mspeed = b.min_speed
			new_target = true

			goto label_75_0
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		
		local u = UP:get_upgrade("archer_precision")
			
		if u and math.random() < u.chance and b.can_split then
			local u = UP:get_upgrade_info("archer_precision_v")
			local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.vis_flags, this.vis_bans, function(e)
			return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
		end)
			if enemy then	
				local b2 = E:create_entity(u.bullet)
				
				b2.bullet.damage_factor = b.damage_factor
				b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
				b2.bullet.from = V.vclone(b2.pos)
				b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
				b2.bullet.target_id = enemy.id
				b2.bullet.seen_targets = b.seen_targets
				b2.bullet.damage_min = b.damage_min
				b2.bullet.damage_max = b.damage_max
				
				queue_insert(store, b2)
			end
		end

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				m.modifier.source_id = b.source_id

				queue_insert(store, m)
			end
		end

		if b.hit_payload then
			local hp = b.hit_payload

			hp.pos.x, hp.pos.y = this.pos.x, this.pos.y

			queue_insert(store, hp)
		end
	end

	if b.payload then
		local hp = b.payload

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		queue_insert(store, hp)
	end

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0

		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.mod_deathcoil_crosshair = {}

function scripts.mod_deathcoil_crosshair.update(this, store, script)
	local m = this.modifier
	local started = nil
	local looping = nil

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	while true do
		
		if not started then
			U.animation_start(this, "start", nil, store.tick_ts)
		elseif not looping then
			U.animation_start(this, "loop", nil, store.tick_ts, true)
			looping = true
		end
		
		if this.finished then
			queue_remove(store, this)
		end
		
		target = store.entities[m.target_id]

		if not target or target.health.dead or m.duration >= 0 and store.tick_ts - m.ts > m.duration or m.last_node and target.nav_path.ni > m.last_node then
			queue_remove(store, this)

			return
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
		
		if not started then
			U.y_animation_wait(this)
			started = true
		end

		coroutine.yield()
	end
end

scripts.mod_deathcoil_stun = {}

function scripts.mod_deathcoil_stun.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or target.health.dead then
		return false
	end

	if target.vis and not U.flags_pass(target.vis, this.modifier) then
		log.paranoid("mod %s cannot be applied to entity %s:%s because of vis flags/bans", this.template_name, target.id, target.template_name)

		return false
	end

	if target and target.unit and this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]
			
			if s.size_scales then
				s.scale = s.size_scales[target.unit.size]
			end

			if m.use_mod_offset and target.unit.mod_offset then
				s.offset.x, s.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
			end
		end
	end

	m.ts = store.tick_ts
	
	if m.level > 1 and not this.duplicate then
		local enemy = U.find_foremost_enemy(store.entities, target.pos, 30, m.range, false, m.vis_flags, m.vis_bans, function(e)
			return e.id ~= target.id and e.health and not e.health.dead
		end)
		if enemy and enemy.health and not enemy.health.dead then
			local m2 = E:clone_entity(this)

			m2.modifier.target_id = enemy.id
			m2.modifier.level = m.level
			m2.duplicate = true

			queue_insert(store, m2)
			
			local ray = E:create_entity(m.ray)

			ray.pos.x, ray.pos.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			ray.bullet.from = V.vclone(ray.pos)
			ray.bullet.to = V.vclone(enemy.pos)
			ray.bullet.target_id = enemy.id
			ray.render.sprites[1].ts = store.tick_ts

			queue_insert(store, ray)
			
			this.ray_id = ray.id
			m2.ray_id = ray.id
			
			if m.level > 2 then
				local bind = E:create_entity(m.bind)

				bind.pos.x, bind.pos.y = target.pos.x, target.pos.y
				bind.bullet.from = V.vclone(bind.pos)
				bind.bullet.to = V.vclone(enemy.pos)
				bind.bullet.target_id = enemy.id
				bind.bullet.source_id = m.source_id
				bind.first_id = target.id
				bind.second_id = enemy.id
				
				if V.dist(target.pos.x, target.pos.y, enemy.pos.x, enemy.pos.y) < m.range / 2 then
					bind.bullet.min_speed = bind.bullet.min_speed / 2
					bind.bullet.max_speed = bind.bullet.max_speed / 2
				end

				queue_insert(store, bind)
				
				this.bind_id = bind.id
			end
		end
	end

	SU.stun_inc(target)
	log.paranoid("mod_stun.insert (%s)-%s for target (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_deathcoil_stun.update(this, store, script)
	local start_ts, target_hidden
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]
	local ray = store.entities[this.ray_id]
	local bind = store.entities[this.bind_id]
	local target2 
	
	if bind then
		target2 = store.entities[bind.second_id]
	end

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos
	start_ts = store.tick_ts

	if m.animation_phases then
		U.animation_start(this, "start", nil, store.tick_ts)

		while not U.animation_finished(this) do
			if not target_hidden and m.hide_target_delay and store.tick_ts - start_ts > m.hide_target_delay then
				target_hidden = true

				if target.ui then
					target.ui.can_click = false
				end

				if target.health_bar then
					target.health_bar.hidden = true
				end

				U.sprites_hide(target, nil, nil, true)
				SU.hide_modifiers(store, target, true, this)
				SU.hide_auras(store, target, true)
			end

			coroutine.yield()
		end
	end

	U.animation_start(this, "loop", nil, store.tick_ts, true)

	while store.tick_ts - m.ts < m.duration and target and not target.health.dead do
		if this.render and m.use_mod_offset and target.unit.mod_offset and not m.custom_offsets then
			for i = 1, #this.render.sprites do
				local s = this.render.sprites[i]

				s.offset.x, s.offset.y = target.unit.mod_offset.x, target.unit.mod_offset.y
			end
		end
		
		if ray and bind then
			if (target2 and target2.health.dead) or (V.dist(target.pos.x, target.pos.y, target2.pos.x, target2.pos.y) > m.range) then
				queue_remove(store, ray)
				queue_remove(store, bind)
			end
		end

		coroutine.yield()
	end

	if m.animation_phases then
		U.animation_start(this, "end", nil, store.tick_ts)

		if target_hidden then
			if target.ui then
				target.ui.can_click = true
			end

			if target.health_bar and not target.health.dead then
				target.health_bar.hidden = nil
			end

			U.sprites_show(target, nil, nil, true)
			SU.show_modifiers(store, target, true, this)
			SU.show_auras(store, target, true)
		end

		while not U.animation_finished(this) do
			coroutine.yield()
		end
	end

	queue_remove(store, this)
end

function scripts.mod_deathcoil_stun.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local ray = store.entities[this.ray_id]
	local bind = store.entities[this.bind_id]
	
	if ray then
		queue_remove(store, ray)
	end
	
	if bind then
		queue_remove(store, bind)
	end

	if target then
		SU.stun_dec(target)
		log.paranoid("mod_stun.remove (%s)-%s for target (%s)-%s", this.id, this.template_name, target.id, target.template_name)
	else
		log.paranoid("mod_stun.remove target is nil for id %s", this.modifier.target_id)
	end

	return true
end
scripts.bolt_deathcoil = {}

function scripts.bolt_deathcoil.update(this, store, script)
	local b = this.bullet
	local s = this.render.sprites[1]
	local mspeed = b.min_speed
	local target, ps
	local new_target = false
	local target_invalid = false

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_75_0::

	if b.store and not b.target_id then
		S:queue(this.sound_events.summon)

		s.z = Z_OBJECTS
		s.sort_y_offset = b.store_sort_y_offset

		U.animation_start(this, "idle", nil, store.tick_ts, true)

		if ps then
			ps.particle_system.emit = false
		end
	else
		S:queue(this.sound_events.travel)

		s.z = Z_BULLETS
		s.sort_y_offset = nil

		U.animation_start(this, "flying", nil, store.tick_ts, s.loop)

		if ps then
			ps.particle_system.emit = true
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		coroutine.yield()

		if not target_invalid then
			target = store.entities[b.target_id]
		end

		if target and not new_target then
			local tpx, tpy = target.pos.x, target.pos.y

			if not b.ignore_hit_offset then
				tpx, tpy = tpx + target.unit.hit_offset.x, tpy + target.unit.hit_offset.y
			end

			local d = math.max(math.abs(tpx - b.to.x), math.abs(tpy - b.to.y))

			if d > b.max_track_distance or band(target.vis.bans, F_RANGED) ~= 0 then
				target_invalid = true
				target = nil
			end
		end

		if target and target.health and not target.health.dead then
			if b.ignore_hit_offset then
				b.to.x, b.to.y = target.pos.x, target.pos.y
			else
				b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
			end

			new_target = false
		end

		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length

		if not b.ignore_rotation then
			s.r = V.angleTo(b.to.x - this.pos.x, b.to.y - this.pos.y)
		end

		if ps then
			ps.particle_system.emit_direction = s.r
		end
	end

	while b.store and not b.target_id do
		coroutine.yield()

		if b.target_id then
			mspeed = b.min_speed
			new_target = true

			goto label_75_0
		end
	end

	this.pos.x, this.pos.y = b.to.x, b.to.y

	if target and not target.health.dead then
		local d = SU.create_bullet_damage(b, target.id, this.id)
		
		local u = UP:get_upgrade("archer_precision")
			
		if u and math.random() < u.chance and b.can_split then
			local u = UP:get_upgrade_info("archer_precision_v")
			local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, u.bounce_range, false, this.vis_flags, this.vis_bans, function(e)
			return e.id ~= b.target_id and e.health and not e.health.dead and not table.contains(b.seen_targets, e.id)
		end)
			if enemy then	
				local b2 = E:create_entity(u.bullet)
				
				b2.bullet.damage_factor = b.damage_factor
				b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
				b2.bullet.from = V.vclone(b2.pos)
				b2.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
				b2.bullet.target_id = enemy.id
				b2.bullet.seen_targets = b.seen_targets
				b2.bullet.damage_min = b.damage_min
				b2.bullet.damage_max = b.damage_max
				
				queue_insert(store, b2)
			end
		end

		queue_damage(store, d)

		if b.mod or b.mods then
			local mods = b.mods or {
				b.mod
			}

			for _, mod_name in pairs(mods) do
				local m = E:create_entity(mod_name)

				m.modifier.target_id = b.target_id
				m.modifier.level = b.level
				m.modifier.source_id = b.source_id

				queue_insert(store, m)
			end
		end

		if b.hit_payload then
			local hp = b.hit_payload

			hp.pos.x, hp.pos.y = this.pos.x, this.pos.y

			queue_insert(store, hp)
		end
	end

	if b.payload then
		local hp = b.payload

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		queue_insert(store, hp)
	end

	if b.hit_fx then
		local sfx = E:create_entity(b.hit_fx)

		sfx.pos.x, sfx.pos.y = b.to.x, b.to.y
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].runs = 0

		if target and sfx.render.sprites[1].size_names then
			sfx.render.sprites[1].name = sfx.render.sprites[1].size_names[target.unit.size]
		end

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end
scripts.deathcoil_bind = {}

function scripts.deathcoil_bind.update(this, store)
	local b = this.bullet
	local mspeed = b.min_speed
	local target, ps
	local bounce_count = 0
	local tower = store.entities[b.source_id]
	b.ts = 0
	outtable = {}
	intable = {}

	b.speed.x, b.speed.y = V.normalize(b.to.x - b.from.x, b.to.y - b.from.y)

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	::label_193_0::

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		target = store.entities[b.target_id]

		if target and target.health and not target.health.dead then
			b.to.x, b.to.y = target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y
		end

		mspeed = mspeed + FPS * math.ceil(mspeed * (1 / FPS) * b.acceleration_factor)
		mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		
		if store.tick_ts - b.ts > b.damage_every then
			b.ts = store.tick_ts
			
			local target_check = store.entities[this.first_id]
			
			if target_check and this.first_id then
				local d = E:create_damage()

				d.damage_type = b.damage_type
				d.source_id = this.id
				d.target_id = this.first_id
				d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

				queue_damage(store, d)
			end
			
			target_check = store.entities[this.second_id]
			
			if target_check and this.second_id then
				local d = E:create_damage()

				d.damage_type = b.damage_type
				d.source_id = this.id
				d.target_id = this.second_id
				d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

				queue_damage(store, d)
			end
			
			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, b.vis_flags, b.vis_bans, function(e)
				return e.id ~= this.first_id and e.id ~= this.second_id and e.health and not e.health.dead
			end)
			if targets and #targets > 0 then
				for _, t in ipairs(targets) do
					if (back == 0 and not table.contains(outtable, t.id)) or (back == 1 and not table.contains(intable, t.id)) then
					
						local d = E:create_damage()

						d.damage_type = b.damage_type
						d.source_id = this.id
						d.target_id = t.id
						d.value = math.random(b.damage_min * tower.tower.damage_factor, b.damage_max * tower.tower.damage_factor)

						queue_damage(store, d)
						
						if back == 0 then
							table.insert(outtable, t.id)
						elseif back == 1 then
							table.insert(intable, t.id)
						end
					end
				end
			end
		end

		coroutine.yield()
	end
	
	if target and not target.health.dead then
		if target.id == this.first_id then
			local newtarget = store.entities[this.second_id]
			outtable = {}
			
			if newtarget then
				b.to.x, b.to.y = newtarget.pos.x + newtarget.unit.hit_offset.x, newtarget.pos.y + newtarget.unit.hit_offset.y
				b.target_id = newtarget.id
				back = 0
				
				goto label_193_0
			else
				queue_remove(store, this)
			end
		elseif target.id == this.second_id then
			local newtarget = store.entities[this.first_id]
			intable = {}
			
			if newtarget then
				b.to.x, b.to.y = newtarget.pos.x + newtarget.unit.hit_offset.x, newtarget.pos.y + newtarget.unit.hit_offset.y
				b.target_id = newtarget.id
				back = 1
				
				goto label_193_0
			else
				queue_remove(store, this)
			end
		end
	end

	queue_remove(store, this)
end
---腐毒菇林
scripts.tower_artillery = {}

function scripts.tower_artillery.insert(this, store, script)
	return true
end

function scripts.tower_artillery.update(this, store, script)
	local a = this.attacks
	local ba = this.attacks.list[1]
	local shooter_sid = this.render.sid_shooter

	ba.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		elseif store.tick_ts - ba.ts < ba.cooldown then
			coroutine.yield()
		else
			local enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ba.node_prediction, ba.vis_flags, ba.vis_bans)

			if enemy then
				ba.ts = store.tick_ts

				local soffset = this.render.sprites[shooter_sid].offset
				local an, af, ai = U.animation_name_facing_point(this, ba.animation, enemy.pos, shooter_sid, soffset)

				U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)

				while store.tick_ts - ba.ts < ba.shoot_time do
					coroutine.yield()
				end

				local trigger_pos = pred_pos

				enemy, _, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ba.node_prediction, ba.vis_flags, ba.vis_bans)

				local b = E:create_entity(ba.bullet)

				b.bullet.damage_factor = this.tower.damage_factor

				local start_offset
				
				if this.render.sprites[3].flip_x == true then
					start_offset = ba.bullet_start_offset[1]
				else
					start_offset = ba.bullet_start_offset[2]
				end
				b.pos.x, b.pos.y = this.pos.x + start_offset.x, this.pos.y + start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = enemy and pred_pos or trigger_pos
				b.bullet.source_id = this.id

				queue_insert(store, b)

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end
				
				local last_target_pos =V.vclone(b.bullet.to)

				local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, ba.bullet_start_offset[1])

				U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
			end
			
			if store.tick_ts - ba.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end

			coroutine.yield()
		end
	end
end

scripts.bomb_v = {}

function scripts.bomb_v.update(this, store, script)
	local b = this.bullet
	local dmin, dmax = b.damage_min, b.damage_max
	local dradius = b.damage_radius
	
	if this.tween then
		this.tween.disabled = false
		this.tween.ts = store.tick_ts
		this.tween.props[1].ts = store.tick_ts
	end

	if b.level and b.level > 0 then
		if b.damage_radius_inc then
			dradius = dradius + b.level * b.damage_radius_inc
		end

		if b.damage_min_inc then
			dmin = dmin + b.level * b.damage_min_inc
		end

		if b.damage_max_inc then
			dmax = dmax + b.level * b.damage_max_inc
		end
	end

	local ps

	if b.particles_name then
		ps = E:create_entity(b.particles_name)
		ps.particle_system.track_id = this.id

		queue_insert(store, ps)
	end

	while store.tick_ts - b.ts + store.tick_length < b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
	end
	
	local u = UP:get_upgrade("engineer_field_logistics")
			
	if u and not this.mini and b.can_do_mini then
		local u = UP:get_upgrade_info("engineer_field_logistics_v")
		for i = 1, u.count do
			local b2 = E:create_entity(this.template_name)
			
			if i == 1 then
				b2.bullet.to = V.v(this.pos.x + 20, this.pos.y + 20)
			elseif i == 2 then
				b2.bullet.to = V.v(this.pos.x - 20, this.pos.y + 20)
			else
				b2.bullet.to = V.v(this.pos.x, this.pos.y - 15)
			end
			b2.bullet.damage_factor = b.damage_factor
			b2.pos.x, b2.pos.y = this.pos.x, this.pos.y
			b2.bullet.from = V.vclone(b2.pos)
			b2.bullet.damage_min = math.ceil(b.damage_min * u.damage_factor)
			b2.bullet.damage_max = math.ceil(b.damage_max * u.damage_factor)
			b2.bullet.damage_radius = b.damage_radius - 20
			b2.bullet.hit_fx = "fx_explosion_tiny"
			b2.render.sprites[1].scale.x = this.render.sprites[1].scale.x * 0.7
			b2.render.sprites[1].scale.y = this.render.sprites[1].scale.y * 0.7
			b2.bullet.pop = nil
			b2.mini = true
			b2.sound_events.insert = nil
			b2.sound_events.hit_args = {
				gain = 0.75
			}
			
			if i ~= 1 then
				b2.sound_events.hit = nil
			end
					
			queue_insert(store, b2)
		end
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_damage()

		d.damage_type = b.damage_type
		d.reduce_armor = b.reduce_armor
		d.reduce_magic_armor = b.reduce_magic_armor

		local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

		d.value = math.floor(dmax - (dmax - dmin) * dist_factor)

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id
		
		u = UP:get_upgrade("engineer_efficiency")
		
		if u and not this.mini then
			u = UP:get_upgrade_info("engineer_efficiency_v")
			local bonus_damage_factor = math.min(1 + (u.bonus * #enemies), u.max_bonus)
			d.value = math.ceil(bonus_damage_factor * d.value)
		end

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = enemy.id
			mod.modifier.source_id = this.id

			queue_insert(store, mod)
		end
	end

	local p = SU.create_bullet_pop(store, this)

	queue_insert(store, p)

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		if not this.mini then
			S:queue(this.sound_events.hit)
		else
			S:queue(this.sound_events.hit, this.sound_events.hit_args)
		end

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end

	if b.hit_payload then
		local hp

		if type(b.hit_payload) == "string" then
			hp = E:create_entity(b.hit_payload)
		else
			hp = b.hit_payload
		end

		hp.pos.x, hp.pos.y = b.to.x, b.to.y

		if hp.aura then
			hp.aura.level = this.bullet.level
		end

		queue_insert(store, hp)
	end

	queue_remove(store, this)
end
scripts.tower_rotshroom = {}

function scripts.tower_rotshroom.remove(this, store) 
	if #this.attacks.list[1].shrooms > 0 then
		for i = 1, #this.attacks.list[1].shrooms do
			queue_remove(store, this.attacks.list[1].shrooms[i])
		end
	end

	return true
end

function scripts.tower_rotshroom.insert(this, store, script)
	return true
end

function scripts.tower_rotshroom.get_info(this)
	local min, max, d_type

	local mine = E:get_template(this.attacks.list[1].mine)

	min = mine.damage_min * 2
	max = mine.damage_max * 2
	d_type = mine.damage_type

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown

	if this.attacks and this.attacks.list[1].cooldown then
		cooldown = this.attacks.list[1].cooldown
	end

	return {
		type = STATS_TYPE_TOWER,
		damage_min = min,
		damage_max = max,
		damage_type = d_type,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_rotshroom.update(this, store, script)
	local a = this.attacks
	local ba = this.attacks.list[1]
	local pa = this.attacks.list[2]
	local pow_p = this.powers.punch
	local pow_r = this.powers.rot
	local shroom_sid = 2
	local face_sid = 3
	local hand_sid_1 = 4
	local hand_sid_2 = 6
	local idle_ts, secondary_idle_ts
	local idle_animations = {}
	local flip = nil
	
	idle_animations = {
		"idle_anim_1",
		"idle_anim_2",
		"idle_anim_3"
	}
	
	secondary_idle_ts = store.tick_ts
	idle_ts = store.tick_ts

	ba.ts = store.tick_ts
	pa.ts = store.tick_ts

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
		
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_p then
						pa.disabled = false
					elseif pow == pow_r then
						if pow_r.level == 1 then
							local e = E:create_entity(this.auras.list[1].name)

							e.pos = V.vclone(this.pos)
							e.aura.level = this.tower.level
							e.aura.source_id = this.id
							e.aura.ts = store.tick_ts

							queue_insert(store, e)
						end
					end
				end
			end
		
			if not pa.disabled and store.tick_ts - pa.ts >= pa.cooldown then
				local target = U.find_foremost_enemy(store.entities, this.pos, 0, a.range, nil, pa.vis_flags, pa.vis_bans)
				
				if target then
					
					local prev_node = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + pa.node_offset)
					
					if target.pos.x > this.pos.x then
						this.render.sprites[4].flip_x = false
						this.render.sprites[4].offset = pow_p.offsets[1]
						this.render.sprites[6].flip_x = false
						this.render.sprites[6].offset = pow_p.offsets[3]
						flip = nil
					else
						this.render.sprites[4].flip_x = true
						this.render.sprites[4].offset = pow_p.offsets[2]
						this.render.sprites[6].flip_x = true
						this.render.sprites[6].offset = pow_p.offsets[4]
						flip = true
					end
					
					pa.ts = store.tick_ts
					
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, hand_sid_1)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, hand_sid_2)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, shroom_sid)
					U.animation_start(this, pa.animation, nil, store.tick_ts, 1, face_sid)
					
					while store.tick_ts - pa.ts < pa.shoot_time do
						coroutine.yield()
					end
					
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.range, pa.vis_flags, pa.vis_bans, function(e)
						return e and e.enemy and e.health and not e.health.dead and ((not flip and e.pos.x >= this.pos.x) or (flip and e.pos.x <= this.pos.x))
					end)
					
					if targets then
					
						S:queue(pa.sound)
						
						for _, t in ipairs(targets) do
							local damage = E:create_damage()
						
							damage.value = math.random((pa.damage_min + pa.damage_inc * pow_p.level) * this.tower.damage_factor, (pa.damage_max + pa.damage_inc * pow_p.level) * this.tower.damage_factor)
							damage.damage_type = pa.damage_type
							if U.predict_damage(t, damage) < t.health.hp then
								local d = E:create_damage()

								d.damage_type = pa.damage_type
								d.source_id = this.ia
								d.target_id = t.id
								d.value = damage.value
								
								queue_damage(store, d)
								
								local m = E:create_entity(pa.mod_throw)
							
								m.pos = t.pos
								m.modifier.target_id = t.id
								m.modifier.source_id = this.id
								m.modifier.node_offset = pa.node_offset

								queue_insert(store, m)
							else
								local m = E:create_entity(pa.mod_kill)
							
								m.pos = t.pos
								m.modifier.target_id = t.id
								m.modifier.source_id = this.id
								m.modifier.node_offset = pa.node_offset

								queue_insert(store, m)
							end
						end
					end
					
					while not U.animation_finished(this, shroom_sid) and not U.animation_finished(this, face_sid) and not U.animation_finished(this, hand_sid_1) and not U.animation_finished(this, hand_sid_2) do
						coroutine.yield()
					end
					
					idle_ts = store.tick_ts
				end
			end
		
			if store.tick_ts - ba.ts >= ba.cooldown then
				if #ba.shrooms < ba.max_count then
					local nodes = U.find_nodes_in_range(this.pos, 0, a.range, true)

					if nodes then
						ba.ts = store.tick_ts

						U.animation_start(this, ba.animation, nil, store.tick_ts, 1, shroom_sid)
						U.animation_start(this, ba.animation, nil, store.tick_ts, 1, face_sid)

						while store.tick_ts - ba.ts < ba.shoot_time do
							coroutine.yield()
						end
						
						for i = 1, ba.count do
							
							if #ba.shrooms < ba.max_count then
								local b = E:create_entity(ba.mine)

								b.damage_factor = this.tower.damage_factor
								
								local id = math.random(1, #nodes)
								local node_pos = nodes[id]
								
								b.pos.x, b.pos.y = node_pos.x + math.random(ba.offset_min, ba.offset_max), node_pos.y + math.random(ba.offset_min, ba.offset_max)
								b.source_id = this.id

								queue_insert(store, b)
								
								table.insert(ba.shrooms, b)
								
								U.y_wait(store, ba.interval)
							else
								break
							end
						end

						while not U.animation_finished(this, shroom_sid) and not U.animation_finished(this, face_sid) do
							coroutine.yield()
						end
						
						idle_ts = store.tick_ts
					end
				end
			end
			
			if store.tick_ts - idle_ts > this.tower.long_idle_cooldown and store.tick_ts - secondary_idle_ts > this.tower.long_idle_cooldown_secondary then
				local rand = math.random(1, 3)
				U.animation_start(this, idle_animations[rand], nil, store.tick_ts, 1, shroom_sid)
				U.animation_start(this, idle_animations[rand], nil, store.tick_ts, 1, face_sid)
				secondary_idle_ts = store.tick_ts
			end
		end
		coroutine.yield()
	end
end

scripts.rotshroom_aura = {}

function scripts.rotshroom_aura.update(this, store, script)
	local last_ts = store.tick_ts

	while true do
		local source = store.entities[this.aura.source_id]

		if not source then
			if #this.mini_shrooms > 0 then
				for i = 1, #this.mini_shrooms do
					queue_remove(store, this.mini_shrooms[i])
				end
			end
			queue_remove(store, this)

			return
		end

		if store.tick_ts - last_ts >= this.aura.cycle_time then
			last_ts = store.tick_ts
			
			local dead_enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.vis and v.health and v.health.dead and band(v.health.last_damage_types, bor(DAMAGE_EAT)) == 0 and band(v.vis.bans, F_SKELETON) == 0 and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - this.aura.cycle_time and U.is_inside_ellipse(v.pos, this.pos, source.attacks.range)
			end)

			dead_enemies = table.slice(dead_enemies, 1)

			for _, dead in pairs(dead_enemies) do
				dead.vis.bans = bor(dead.vis.bans, F_SKELETON)
				dead.health.delete_after = 0

				local e = E:create_entity("decal_rotshroom_mine_mini")

				e.pos = V.vclone(dead.pos)
				e.damage_min = source.powers.rot.damage_min[source.powers.rot.level]
				e.damage_max = source.powers.rot.damage_max[source.powers.rot.level]
				e.damage_factor = source.tower.damage_factor
				e.source_id = this.aura.source_id

				if dead.enemy.necromancer_offset then
					e.pos.x = e.pos.x + dead.enemy.necromancer_offset.x * (dead.render.sprites[1].flip_x and -1 or 1)
					e.pos.y = e.pos.y + dead.enemy.necromancer_offset.y
				end

				queue_insert(store, e)
				
				table.insert(this.mini_shrooms, e)
			end
		end

		coroutine.yield()
	end
end

scripts.mod_rotshroom_throw = {}

function scripts.mod_rotshroom_throw.update(this, store)

	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]
	local ability_active = nil

	if not target or target.health.dead then
		queue_remove(store, this)

		return
	end
	
	
	if target.beer and target.beer.done then
		ability_active = true
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_ALL)
	
	SU.remove_modifiers(store, target, nil, "mod_rotshroom_throw")
	SU.remove_auras(store, target)
	
	queue_remove(store, target)

	target.health.dead = true
	target.main_script.co = nil
	target.main_script.runs = 0

	U.unblock_all(store, target)

	if target.ui then
		target.ui.can_click = false
	end

	if target.count_group then
		target.count_group.in_limbo = true
	end
	
	local prev_node = P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + m.node_offset)
					
	local b = E:create_entity("bullet_rotshroom_throw")

	b.render.sprites[1].prefix = target.render.sprites[1].prefix
	b.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	b.render.sprites[1].scale = target.render.sprites[1].scale
	b.pos.x, b.pos.y = target.pos.x, target.pos.y
	b.bullet.from = V.vclone(b.pos)
	b.bullet.to = V.vclone(prev_node)
	b.bullet.target_id = m.target_id
	b.bullet.source_id = m.source_id
	
	queue_insert(store, b)

	local start_ts = store.tick_ts

	while not b.bullet.arrived do
		coroutine.yield()
	end
		
	local nodes = P:nearest_nodes(b.pos.x, b.pos.y, {
		target.nav_path.pi
	}, nil)

	if #nodes > 0 then
		target.nav_path.ni = nodes[1][3] + 1
	end

	target.pos = V.vclone(b.pos)
	target.main_script.runs = 1
	target.health.dead = false

	if target.ui then
		target.ui.can_click = true
	end

	if target.count_group then
		target.count_group.in_limbo = nil
	end

	target.vis.bans = U.flag_clear(target.vis.bans, F_ALL)
	
	if target.beer and ability_active then
		target.beer.done = true
	end

	queue_insert(store, target)
	
	local m2 = E:create_entity(m.mod)
				
	m2.pos = target.pos
	m2.modifier.target_id = target.id
	m2.modifier.source_id = m.source_id

	queue_insert(store, m2)
	
	queue_remove(store, this)
end

scripts.mod_rotshroom_kill = {}

function scripts.mod_rotshroom_kill.update(this, store)

	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]

	if not target or target.health.dead then
		queue_remove(store, this)

		return
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_ALL)
	
	local prev_node = V.vclone(P:node_pos(target.nav_path.pi, target.nav_path.spi, target.nav_path.ni + m.node_offset))
	
	SU.remove_modifiers(store, target, nil, "mod_rotshroom_kill")
	SU.remove_auras(store, target)
	queue_remove(store, target)

	target.health.dead = true
	target.main_script.co = nil
	target.main_script.runs = 0

	U.unblock_all(store, target)

	if target.ui then
		target.ui.can_click = false
	end

	if target.count_group then
		target.count_group.in_limbo = true
	end
	
	store.player_gold = store.player_gold + target.enemy.gold

	signal.emit("got-enemy-gold", target, target.enemy.gold)
					
	local b = E:create_entity("bullet_rotshroom_kill")

	b.render.sprites[1].prefix = target.render.sprites[1].prefix
	b.render.sprites[1].flip_x = target.render.sprites[1].flip_x
	b.render.sprites[1].scale = target.render.sprites[1].scale
	b.pos.x, b.pos.y = target.pos.x, target.pos.y
	b.bullet.from = V.vclone(b.pos)
	b.bullet.to = V.vclone(prev_node)
	b.bullet.target_id = m.target_id
	b.bullet.source_id = m.source_id
	
	if target.unit.size == UNIT_SIZE_MEDIUM or target.unit.size == UNIT_SIZE_LARGE then
		b.bullet.big = true
	else
		b.bullet.big = nil
	end
	
	queue_insert(store, b)
	
	queue_remove(store, this)
end

scripts.bullet_rotshroom_throw = {}

function scripts.bullet_rotshroom_throw.update(this, store, script)
	local b = this.bullet
	local dradius
	local damage
	
	if b.big then
		dradius = b.damage_radius_big
		damage = b.damage_big
	else
		dradius = b.damage_radius_small
		damage = b.damage_small
	end
	
	U.animation_start(this, "idle", nil, store.tick_ts, 1)

	while store.tick_ts - b.ts + store.tick_length < b.flight_time do
		coroutine.yield()

		b.last_pos.x, b.last_pos.y = this.pos.x, this.pos.y
		this.pos.x, this.pos.y = SU.position_in_parabola(store.tick_ts - b.ts, b.from, b.speed, b.g)

		if b.align_with_trajectory then
			this.render.sprites[1].r = V.angleTo(this.pos.x - b.last_pos.x, this.pos.y - b.last_pos.y)
		elseif b.rotation_speed then
			this.render.sprites[1].r = this.render.sprites[1].r + b.rotation_speed * store.tick_length
		end

		if b.hide_radius then
			this.render.sprites[1].hidden = V.dist(this.pos.x, this.pos.y, b.from.x, b.from.y) < b.hide_radius or V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) < b.hide_radius
		end
	end

	local enemies = table.filter(store.entities, function(k, v)
		return v.enemy and v.vis and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(v.pos, b.to, dradius)
	end)

	for _, enemy in pairs(enemies) do
		local d = E:create_damage()

		d.damage_type = b.damage_type

		local dist_factor = U.dist_factor_inside_ellipse(enemy.pos, b.to, dradius)

		d.value = damage

		d.value = math.ceil(b.damage_factor * d.value)
		d.source_id = this.id
		d.target_id = enemy.id

		queue_damage(store, d)
		log.paranoid("bomb id:%s, radius:%s, enemy id:%s, dist:%s, damage:%s damage_type:%x", this.id, dradius, enemy.id, V.dist(enemy.pos.x, enemy.pos.y, b.to.x, b.to.y), d.value, d.damage_type)
	end

	local cell_type = GR:cell_type(b.to.x, b.to.y)

	if b.hit_fx_water and band(cell_type, TERRAIN_WATER) ~= 0 then
		S:queue(this.sound_events.hit_water)

		local water_fx = E:create_entity(b.hit_fx_water)

		water_fx.pos.x, water_fx.pos.y = b.to.x, b.to.y
		water_fx.render.sprites[1].ts = store.tick_ts
		water_fx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, water_fx)
	elseif b.hit_fx then
		if not this.mini then
			S:queue(this.sound_events.hit)
		else
			S:queue(this.sound_events.hit, this.sound_events.hit_args)
		end

		local sfx = E:create_entity(b.hit_fx)

		sfx.pos = V.vclone(b.to)
		sfx.render.sprites[1].ts = store.tick_ts
		sfx.render.sprites[1].sort_y_offset = b.hit_fx_sort_y_offset

		queue_insert(store, sfx)
	end

	if b.hit_decal and band(cell_type, TERRAIN_WATER) == 0 then
		local decal = E:create_entity(b.hit_decal)

		decal.pos = V.vclone(b.to)
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
	end
	
	b.arrived = true

	queue_remove(store, this)
end

scripts.decal_rotshroom_mine = {}

function scripts.decal_rotshroom_mine.update(this, store)
	local ts = store.tick_ts
	local source = store.entities[this.source_id]
	
	S:queue(this.sound_events.insert)
	
	U.y_animation_play(this, "spawn", nil, store.tick_ts, 1)

	while true do

		local trigger = U.find_enemies_in_range(store.entities, this.pos, 0, this.radius, this.vis_flags, this.vis_bans)
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.damage_radius, this.vis_flags, this.vis_bans2)

		if trigger and #trigger > 0 then
		
			U.y_animation_play(this, "arm", nil, store.tick_ts, 1)
			
			S:queue(this.sound)

			local fx = E:create_entity(this.hit_fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			queue_insert(store, fx)
			
			local damage = math.random(this.damage_min * this.damage_factor, this.damage_max * this.damage_factor)

			for _, t in ipairs(targets) do
				local dvalue
				local d = E:create_damage()

				d.damage_type = this.damage_type
				d.source_id = this.source_id
				d.target_id = t.id
				d.value = damage
				
				u = UP:get_upgrade("engineer_efficiency")
		
				if u then
					u = UP:get_upgrade_info("engineer_efficiency_v")
					local bonus_damage_factor = math.min(1 + (u.bonus * #targets), u.max_bonus)
					d.value = math.ceil(bonus_damage_factor * d.value)
				end
				
				dvalue = d.value

				queue_damage(store, d)
				
				local m = E:create_entity(this.mod)
				
				m.pos = t.pos
				m.modifier.target_id = t.id
				m.modifier.source_id = this.source_id
				m.dps.damage_max = (dvalue * m.dps.damage_every) / m.modifier.duration
				m.dps.damage_min = (dvalue * m.dps.damage_every) / m.modifier.duration

				queue_insert(store, m)
			end

			break
		end

		U.y_wait(store, this.check_interval)
	end
	
	if source.tower then
		table.removeobject(source.attacks.list[1].shrooms, this)
	else
		table.removeobject(source.mini_shrooms, this)
	end

	queue_remove(store, this)
end
---红帽地精
scripts.soldier_redcap = {}

function scripts.soldier_redcap.fn_chance_instakill(this, store, attack, target)
--	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max) / attack.percentage), attack.max_chance))
	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max)), attack.max_chance))
end

function scripts.soldier_redcap.fn_chance_antiboss(this, store, attack, target)
	return math.random() < (math.min((((target.health.hp_max - target.health.hp) / target.health.hp_max) / attack.percentage), attack.max_chance))
end

function scripts.soldier_redcap.update(this, store, script)
	local brk, sta
	local pow_r = this.powers.reap
	local pow_h = this.powers.harvest
	local pow_r_changed = nil
	local pow_h_changed = nil

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
				end
			end
		end
		
		if pow_r.level == 2 and not pow_r_changed then
			pow_r_changed = true
			this.melee.attacks[2].max_chance = 1--0.2
			this.melee.attacks[3].max_chance = 1--0.2
		end
		
		if pow_h.level > 0 and not pow_h_changed then
			pow_h_changed = true
			for i = 1, #this.melee.attacks do
				this.melee.attacks[i].mod_on_kill = pow_h.mod
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

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_39_1
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_39_1
				end
			end

			if SU.soldier_go_back_step(store, this) then
				goto label_39_1
			end

			::label_39_0::

			SU.soldier_idle(store, this)

			SU.soldier_regen(store, this)
		end

		::label_39_1::

		coroutine.yield()
	end
end

scripts.mod_redcap_heal = {}

function scripts.mod_redcap_heal.insert(this, store)
	local target = store.entities[this.modifier.target_id]
	local source = store.entities[this.modifier.source_id]

	this.modifier.target_id = this.modifier.source_id
	
	this.modifier.level = source.powers.harvest.level
	
	if U.has_modifiers(store, source, this.template_name) then
		SU.remove_modifiers(store, source, this.template_name)
	end
	
	return scripts.mod_hps.insert(this, store)
end
---哥布林萨满
scripts.mod_shrine_bolin = {}

function scripts.mod_shrine_bolin.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert mod_shrine_bolin to entity %s - ", target.id, target.template_name)

		return false
	end
	
	for _, s in pairs(this.render.sprites) do
		s.ts = store.tick_ts
	end

	if target.attacks then
		target.tower.damage_factor = target.tower.damage_factor + this.extra_damage
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_shrine_bolin.update(this, store, script)
	local m = this.modifier

	this.modifier.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos then
		queue_remove(store, this)

		return
	end

	if m.pos_offset then
		this.pos = V.v(target.pos.x + m.pos_offset.x, target.pos.y + m.pos_offset.y)
	else
		this.pos = target.pos
	end
	
	if m.use_shooter_pos then
		if target.render.sid_shooter or target.render.sids_shooter then
			local sid = this.sid
			this.render.sprites[1].offset = V.v(target.render.sprites[sid].offset.x, target.render.sprites[sid].offset.y)
		else
			this.render.sprites[1].offset = V.v(0, 20)
		end
	end
		
	while true do
		target = store.entities[m.target_id]

		if not target or m.duration >= 0 and store.tick_ts - m.ts > m.duration then
			queue_remove(store, this)

			return
		end

		coroutine.yield()
	end
end

function scripts.mod_shrine_bolin.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and target.attacks then
		target.tower.damage_factor = target.tower.damage_factor - this.extra_damage
	end

	return true
end

scripts.mod_shrine_denas = {}

function scripts.mod_shrine_denas.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	if target.melee then
		if target.melee.forced_cooldown then
			target.melee.forced_cooldown = target.melee.forced_cooldown * this.factor
		end
		if target.melee.cooldown then
			target.melee.cooldown = target.melee.cooldown * this.factor
		end
		if target.melee.attacks then
			for i = 1, #target.melee.attacks do
				if target.melee.attacks[i].cooldown then
					target.melee.attacks[i].cooldown = target.melee.attacks[i].cooldown * this.factor
				end
			end
		end
	end
	
	if target.motion and target.motion.max_speed then
		target.motion.max_speed = target.motion.max_speed * this.speed_factor
	end
	
	if target.ranged then
		if target.ranged.attacks then
			for i = 1, #target.ranged.attacks do
				if target.ranged.attacks[i].cooldown then
					target.ranged.attacks[i].cooldown = target.ranged.attacks[i].cooldown * this.factor
				end
			end
		end
	end
	
	if target.timed_attacks then
		if target.timed_attacks.list then
			for i = 1, #target.timed_attacks.list do
				if target.timed_attacks.list[i].cooldown then
					target.timed_attacks.list[i].cooldown = target.timed_attacks.list[i].cooldown * this.factor
				end
			end
		end
	end

	return true
end

function scripts.mod_shrine_denas.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		if target.melee then
			if target.melee.forced_cooldown then
				target.melee.forced_cooldown = target.melee.forced_cooldown / this.factor
			end
			if target.melee.cooldown then
				target.melee.cooldown = target.melee.cooldown / this.factor
			end
			if target.melee.attacks then
				for i = 1, #target.melee.attacks do
					if target.melee.attacks[i].cooldown then
						target.melee.attacks[i].cooldown = target.melee.attacks[i].cooldown / this.factor
					end
				end
			end
		end
		
		if target.motion and target.motion.max_speed then
			target.motion.max_speed = target.motion.max_speed / this.speed_factor
		end
		
		if target.ranged then
			if target.ranged.attacks then
				for i = 1, #target.ranged.attacks do
					if target.ranged.attacks[i].cooldown then
						target.ranged.attacks[i].cooldown = target.ranged.attacks[i].cooldown / this.factor
					end
				end
			end
		end
		
		if target.timed_attacks then
			if target.timed_attacks.list then
				for i = 1, #target.timed_attacks.list do
					if target.timed_attacks.list[i].cooldown then
						target.timed_attacks.list[i].cooldown = target.timed_attacks.list[i].cooldown / this.factor
					end
				end
			end
		end
	end

	return true
end

scripts.mod_shrine_denas_tower = {}

function scripts.mod_shrine_denas_tower.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local source = store.entities[m.source_id]

	if not target or not target.tower then
		log.error("error inserting mod_shrine_denas_tower %s", this.id)

		return true
	end

	if this.cooldown_factor then
		if target.attacks then
			if target.attacks.list then
				for i = 1, #target.attacks.list do
					if target.attacks.list[i].cooldown then
						target.attacks.list[i].cooldown = target.attacks.list[i].cooldown * this.cooldown_factor
					end
					if target.attacks.list[i].charge_tick then
						target.attacks.list[i].charge_tick = target.attacks.list[i].charge_tick * this.cooldown_factor
					end
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown * this.cooldown_factor
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown * this.cooldown_factor
			end
		end
	end
	
	if this.boost_factor then
		if target.attacks then
			local primary_attack = target.attacks.list and target.attacks.list[1]

			if primary_attack then
				if primary_attack.cooldown then
					primary_attack.cooldown = primary_attack.cooldown * this.boost_factor[m.level]
				end
				if primary_attack.charge_tick then
					primary_attack.charge_tick = primary_attack.charge_tick * this.boost_factor[m.level]
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown * this.boost_factor[m.level]
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown * this.boost_factor[m.level]
			end
		end
	end

	if this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]

			s.ts = store.tick_ts
		end
	end
	
	if this.tween then
		this.tween.ts = store.tick_ts
		for i = 1, #this.tween.props do
			this.tween.props[i].ts = store.tick_ts
		end
	end

	return true
end

function scripts.mod_shrine_denas_tower.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("error removing mod_shrine_denas_tower %s", this.id)

		return false
	end

	if this.cooldown_factor then
		if target.attacks then
			if target.attacks.list then
				for i = 1, #target.attacks.list do
					if target.attacks.list[i].cooldown then
						target.attacks.list[i].cooldown = target.attacks.list[i].cooldown / this.cooldown_factor
					end
					if target.attacks.list[i].charge_tick then
						target.attacks.list[i].charge_tick = target.attacks.list[i].charge_tick / this.cooldown_factor
					end
				end
			end
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown / this.cooldown_factor
			end
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown / this.cooldown_factor
			end
		end
	end
	
	if this.boost_factor then
		if target.attacks then
			local primary_attack = target.attacks.list and target.attacks.list[1]

			if primary_attack then
				if primary_attack.cooldown then
					primary_attack.cooldown = primary_attack.cooldown / this.boost_factor[m.level]
				end
				if primary_attack.charge_tick then
					primary_attack.charge_tick = primary_attack.charge_tick / this.boost_factor[m.level]
				end
			end
		
			if target.attacks.cooldown then
				target.attacks.cooldown = target.attacks.cooldown / this.boost_factor[m.level]
			end
			
			if target.attacks.min_cooldown then
				target.attacks.min_cooldown = target.attacks.min_cooldown / this.boost_factor[m.level]
			end
		end
	end

	return true
end

scripts.tower_mage_v = {}

function scripts.tower_mage_v.remove(this, store)
	if this.auras then
		for _, e in pairs(this.auras) do
			queue_remove(store, e)
		end
	end

	return true
end

function scripts.tower_mage_v.insert(this, store, script)

	local u = UP:get_upgrade("mage_slow_curse")
	
	if u then
	
	local e = E:create_entity("mage_slow_aura_v")

		e.aura.source_id = this.id
		e.aura.ts = store.tick_ts
		e.aura.radius = this.attacks.range
		e.pos = this.pos
		table.insert(this.auras, e)

		queue_insert(store, e)
	end

	return true
end

function scripts.tower_mage_v.update(this, store, script)
	local tower_sid = this.render.sid_tower
	local shooter_sid = this.render.sid_shooter
	local last_target_pos
	local a = this.attacks
	local aa = this.attacks.list[1]
	local shots = aa.loops or 1

	aa.ts = store.tick_ts

	while true do
		local enemy, enemies

		if this.tower.blocked then
			-- block empty
		elseif store.tick_ts - aa.ts <= aa.cooldown then
			-- block empty
		else
			enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

			if enemy then
				aa.ts = store.tick_ts

				local shooter_offset_y = aa.bullet_start_offset[1].y
				local tx, ty = V.sub(enemy.pos.x, enemy.pos.y, this.pos.x, this.pos.y + shooter_offset_y)
				local t_angle = km.unroll(V.angleTo(tx, ty))
				local shooter = this.render.sprites[shooter_sid]
				local an, _, ai = U.animation_name_for_angle(this, aa.animation, t_angle, shooter_sid)

				local soffset = this.render.sprites[shooter_sid].offset
				local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

				U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
				U.animation_start(this, "shoot", nil, store.tick_ts, 1, tower_sid)

				last_target_pos = V.vclone(enemy.pos)

				while store.tick_ts - aa.ts < aa.shoot_time do
					coroutine.yield()
				end

				for i = 1, shots do
					enemy = enemies[km.zmod(i, #enemies)]

					local in_range = U.is_inside_ellipse(tpos(this), enemy.pos, a.range * 1.1)
					local bullet = E:create_entity(aa.bullet)

					bullet.bullet.shot_index = i
					bullet.bullet.damage_factor = this.tower.damage_factor

					if in_range then
						bullet.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
						bullet.bullet.target_id = enemy.id
					else
						bullet.bullet.to = last_target_pos
						bullet.bullet.target_id = nil
					end

					local start_offset
					
					if this.render.sprites[3].flip_x == true then
						start_offset = aa.bullet_start_offset[1]
					else
						start_offset = aa.bullet_start_offset[2]
					end

					bullet.bullet.from = V.v(this.pos.x + start_offset.x, this.pos.y + start_offset.y)
					bullet.pos = V.vclone(bullet.bullet.from)
					
					local u = UP:get_upgrade("mage_arcane_shatter")

					if u and math.random() < u.chance and enemy.health and enemy.health.magic_armor > 0 then
						local u = UP:get_upgrade_info("mage_arcane_shatter_v")
						bullet.bullet.mod = u.mod
					end
					
					u = UP:get_upgrade("mage_empowered_magic")
					
					if u and math.random() < u.chance then
						u = UP:get_upgrade_info("mage_empowered_magic_v")
						bullet.bullet.damage_factor = bullet.bullet.damage_factor * u.damage_factor
						bullet.bullet.pop = {
							"pop_crit_v"
						}
						bullet.bullet.pop_conds = DR_DAMAGE
						bullet.bullet.pop_chance = 1
					end

					queue_insert(store, bullet)
				end

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end

				U.animation_start(this, "idle", nil, store.tick_ts, -1, tower_sid)

				local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid, aa.bullet_start_offset[1])

				U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end
		end

		coroutine.yield()
	end
end
scripts.aura_totem_shaman = {}

function scripts.aura_totem_shaman.update(this, store)
	local a = this.aura
	local s = this.render.sprites
	local ring_sid = 1
	local ground_sid = 2
	local totem_sid = 3
	local fx_sid = 4

	s[ring_sid].ts = store.tick_ts

	U.y_animation_play(this, "start", nil, store.tick_ts, 1, totem_sid)

	s[fx_sid].hidden = false
	this.aura.ts = store.tick_ts

	while store.tick_ts - this.aura.ts < a.duration[a.level] do
		if this.aura.target_towers then
			local towers = U.find_towers_in_range(store.entities, this.pos, this.aura, function(t)
				return t.tower.can_be_mod and not t.barrack
			end)
			
			if towers then
				for _, tower in pairs(towers) do
					local e = E:create_entity(this.aura.mod)

					e.modifier.target_id = tower.id
					e.modifier.source_id = this.id
					e.modifier.level = this.aura.level

					queue_insert(store, e)
				end
			end
		elseif this.aura.shooter then
			local target = U.find_foremost_enemy(store.entities, this.pos, 0, this.aura.radius, nil, this.aura.vis_flags, this.aura.vis_bans)
			
			if target then
				local b = E:create_entity(a.bullet)
							
				b.pos.x, b.pos.y = this.pos.x + this.bullet_start_offset.x, this.pos.y + this.bullet_start_offset.y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to =  V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
				b.bullet.source_id = this.id
				b.bullet.target_id = target.id
				b.bullet.damage_factor = this.aura.damage_factor
			
				local u = UP:get_upgrade("mage_arcane_shatter")

				if u and math.random() < u.chance and target.health and target.health.magic_armor > 0 then
					local u = UP:get_upgrade_info("mage_arcane_shatter_v")
					b.bullet.mod = u.mod
				end
				
				u = UP:get_upgrade("mage_empowered_magic")
						
				if u and math.random() < u.chance then
					u = UP:get_upgrade_info("mage_empowered_magic_v")
					b.bullet.damage_factor = b.bullet.damage_factor * u.damage_factor
					b.bullet.pop = {
						"pop_crit_v"
					}
					b.bullet.pop_conds = DR_DAMAGE
					b.bullet.pop_chance = 1
				end

				queue_insert(store, b)
			end
		else
			local targets = U.find_targets_in_range(store.entities, this.pos, 0, this.aura.radius, this.aura.vis_flags, this.aura.vis_bans)

			if targets then
				for _, target in pairs(targets) do
					local e = E:create_entity(this.aura.mod)

					e.modifier.target_id = target.id
					e.modifier.source_id = this.id
					e.modifier.level = this.aura.level

					queue_insert(store, e)
				end
			end
		end

		U.y_wait(store, a.cycle_time)
	end

	s[ground_sid].hidden = true
	s[ring_sid].hidden = true
	s[fx_sid].hidden = true

	U.y_animation_play(this, "end", nil, store.tick_ts, 1, totem_sid)
	queue_remove(store, this)
end

scripts.tower_shaman = {}

function scripts.tower_shaman.get_info(this)
	local min, max, d_type
	local b = E:get_template("bolt_shaman_totem")
	local t = E:get_template(this.attacks.list[1].bullet)

	min, max = b.bullet.damage_min, b.bullet.damage_max
	d_type = b.bullet.damage_type

	min, max = math.ceil(min * this.tower.damage_factor), math.ceil(max * this.tower.damage_factor)

	local cooldown = t.aura.cycle_time

	return {
		type = STATS_TYPE_TOWER_MAGE,
		damage_min = min,
		damage_max = max,
		damage_type = d_type,
		range = this.attacks.range,
		cooldown = cooldown
	}
end

function scripts.tower_shaman.update(this, store, script)
	local tower_sid = this.render.sid_tower
	local shooter_sid = this.render.sid_shooter
	local last_target_pos
	local a = this.attacks
	local aa = this.attacks.list[1]
	local ha = this.attacks.list[2]
	local sa = this.attacks.list[3]
	local pow_h = this.powers.healing
	local pow_s = this.powers.speed

	aa.ts = 0
	ha.ts = store.tick_ts
	sa.ts = store.tick_ts

	while true do

		if this.tower.blocked then
			-- block empty
		else
			for k, pow in pairs(this.powers) do
				if pow.changed then
					pow.changed = nil

					if pow == pow_h then
						ha.disabled = false
						if pow_h.level == 1 then
							this.render.sprites[5].hidden = false
							U.animation_start(this, "light", nil, store.tick_ts, false, 5)
						end
					elseif pow == pow_s then
						sa.disabled = false
						if pow_s.level == 1 then
							this.render.sprites[4].hidden = false
							U.animation_start(this, "light", nil, store.tick_ts, false, 4)
						end
					end
				end
			end
			
			if not sa.disabled and pow_s.level > 0 and store.tick_ts - sa.ts > sa.cooldown then
				local towers = U.find_towers_in_range(store.entities, this.pos, sa, function(t)
					return t.tower.can_be_mod and not t.barrack
				end)

				if towers and #towers > 0 then
					sa.ts = store.tick_ts

					local tx, ty = V.sub(towers[1].pos.x, towers[1].pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, sa.animation, t_angle, shooter_sid)
					
					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, sa.animation, towers[1].pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					
					U.animation_start(this, "buff", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = U.find_nodes_in_range(this.pos, 0, a.range)
					if nodes and #nodes > 0 then
						local id = math.random(1, #nodes)
						local node_pos = nodes[id]

						last_target_pos = V.vclone(towers[1].pos)

						while store.tick_ts - sa.ts < sa.shoot_time do
							coroutine.yield()
						end
						
						S:queue("EnemyHealing")

						local in_range = U.is_inside_ellipse(tpos(this), towers[1].pos, a.range * 1.1)
						local bullet = E:create_entity(sa.bullet)
						
						bullet.aura.level = pow_s.level
						bullet.pos = V.vclone(node_pos)

						queue_insert(store, bullet)

						while not U.animation_finished(this, shooter_sid) do
							coroutine.yield()
						end

						local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

						U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
					end
				end
			end
			
			if not ha.disabled and pow_h.level > 0 and store.tick_ts - ha.ts > ha.cooldown then
				local soldiers = U.find_soldiers_in_range(store.entities, tpos(this), 0, a.range, ha.vis_flags, ha.vis_bans, function(e)
					return e and e.soldier and e.health and not e.health.dead and e.health.hp < (e.health.hp_max * ha.threshold)
				end)

				if soldiers and #soldiers > 0 then
					ha.ts = store.tick_ts

					local tx, ty = V.sub(soldiers[1].pos.x, soldiers[1].pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, ha.animation, t_angle, shooter_sid)

					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, ha.animation, soldiers[1].pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					U.animation_start(this, "heal", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = P:nearest_nodes(soldiers[1].pos.x, soldiers[1].pos.y, nil, nil, nil, NF_RALLY)
					if nodes and #nodes > 0 then
						local pi, spi, ni = unpack(nodes[1])
						local e_spi, e_ni = math.random(1, 3), ni
						
						last_target_pos = V.vclone(soldiers[1].pos)

						while store.tick_ts - ha.ts < ha.shoot_time do
							coroutine.yield()
						end
						
						S:queue("EnemyHealing")

						local in_range = U.is_inside_ellipse(tpos(this), soldiers[1].pos, a.range * 1.1)
						local bullet = E:create_entity(ha.bullet)
						
						bullet.aura.level = pow_h.level
						bullet.pos = P:node_pos(pi, 1, e_ni)

						queue_insert(store, bullet)

						while not U.animation_finished(this, shooter_sid) do
							coroutine.yield()
						end

						local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

						U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
					end
				end
			end
			
			if store.tick_ts - aa.ts > aa.cooldown then
				local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

				if enemy then
					aa.ts = store.tick_ts
					
					local tx, ty = V.sub(enemy.pos.x, enemy.pos.y, this.pos.x, this.pos.y)
					local t_angle = km.unroll(V.angleTo(tx, ty))
					local shooter = this.render.sprites[shooter_sid]
					local an, _, ai = U.animation_name_for_angle(this, aa.animation, t_angle, shooter_sid)

					local soffset = this.render.sprites[shooter_sid].offset
					local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

					U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
					U.animation_start(this, "shoot", nil, store.tick_ts, 1, tower_sid)
					
					local nodes = P:nearest_nodes(enemy.pos.x, enemy.pos.y, nil, nil, nil, NF_RALLY)
					local pi, spi, ni = unpack(nodes[1])
					local e_spi, e_ni = math.random(1, 3), ni
					local no = aa.spawn_offset_nodes

					if P:is_node_valid(pi, e_ni + no) then
						e_ni = e_ni + no
					end

					last_target_pos = V.vclone(enemy.pos)

					while store.tick_ts - aa.ts < aa.shoot_time do
						coroutine.yield()
					end
					
					S:queue("EnemyHealing")

					local in_range = U.is_inside_ellipse(tpos(this), enemy.pos, a.range * 1.1)
					local bullet = E:create_entity(aa.bullet)
					
					bullet.aura.damage_factor = this.tower.damage_factor
					bullet.pos = P:node_pos(pi, 1, e_ni)

					queue_insert(store, bullet)

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end

					local an = U.animation_name_facing_point(this, "idle", last_target_pos, shooter_sid)

					U.animation_start(this, an, nil, store.tick_ts, -1, shooter_sid)
				end
			end

			if store.tick_ts - aa.ts > this.tower.long_idle_cooldown then
				local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

				U.animation_start(this, an, af, store.tick_ts, -1, shooter_sid)
			end
		end

		coroutine.yield()
	end
end
scripts.soldier_hammerhold_guard = {}

function scripts.soldier_hammerhold_guard.update(this, store)
	local brk, sta, target
	local tower = store.entities[this.soldier.tower_id]

	if tower then
		local level = this.powers.shrugitoff.level
		this.health.flat_damage_reduction = tower.powers.shrugitoff.armor[level] or 0
	end

	-- Keep every normal and guillotine hit attached to this barrack instance.
	this.combat_stats_source_id = this.soldier.tower_id

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	while true do
		tower = store.entities[this.soldier.tower_id]

		if this.powers then
			for power_name, power in pairs(this.powers) do
				if power.changed then
					power.changed = nil
					SU.soldier_power_upgrade(this, power_name)

					if power_name == "shrugitoff" and tower then
						this.health.flat_damage_reduction = tower.powers.shrugitoff.armor[power.level] or 0
					end
				end
			end
		end

		if U.blocker_rank(store, this) ~= nil then
			if U.is_blocked_valid(store, this) then
				target = store.entities[this.soldier.target_id]
			else
				U.unblock_target(store, this)
				target = nil
			end
		else
			target = nil
		end

		if target and this.powers.intimidation.level > 0 and not U.has_modifiers(store, target, "mod_intimidate") then
			local mod = E:create_entity("mod_intimidate")

			mod.modifier.source_id = this.id
			mod.modifier.target_id = target.id
			queue_insert(store, mod)
		end

		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- Keep processing the active soldier.
		else
			SU.y_soldier_death(store, this)
			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto continue
				end
			end

			if this.powers.guillotine.level > 0 then
				local melee_target = SU.soldier_pick_melee_target(store, this)
				local execute_damage = this.melee.attacks[2].damage_inc * this.powers.guillotine.level

				this.melee.attacks[2].disabled = not (melee_target and melee_target.health.hp / melee_target.health.damage_factor <= execute_damage)
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- The melee helper handled this frame.
			elseif SU.soldier_go_back_step(store, this) then
				-- The soldier is returning to its rally slot.
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::continue::
		coroutine.yield()
	end
end

scripts.tower_sandmystic = {}

function scripts.tower_sandmystic.get_info(this)
	local bullet = E:get_template(this.attacks.list[1].bullet)
	local shockwave = E:get_template(bullet.bullet.payload)
	local damage_min = this.attacks.list[1].damage_min * this.tower.damage_factor
	local damage_max = this.attacks.list[1].damage_max * this.tower.damage_factor

	if UP:get_upgrade("engineer_efficiency") then
		damage_min = damage_max
	end

	return {
		type = STATS_TYPE_TOWER,
		damage_min = damage_min,
		damage_max = damage_max,
		damage_type = shockwave.aura.damage_type,
		range = this.attacks.range,
		cooldown = this.attacks.list[1].cooldown
	}
end

function scripts.tower_sandmystic.update(this, store)
	local shooter_sid = 3
	local aoe_ramp = 0
	local attacks = this.attacks
	local basic = attacks.list[1]
	local polarity = attacks.list[2]
	local attraction = attacks.list[3]
	local polarity_power = this.powers.polarity
	local attraction_power = this.powers.attraction
	local decay_ts = store.tick_ts

	local function get_foremost_armored_enemy()
		local _, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, attacks.range, false, attraction.vis_flags, attraction.vis_bans)

		if not enemies then
			return nil
		end

		for _, enemy in pairs(enemies) do
			if enemy.health.armor > 0 and not U.has_modifiers(store, enemy, "mod_malagar_shield_physical") then
				return enemy
			end
		end

		return nil
	end

	while true do
		if this.tower.blocked then
			coroutine.yield()
		else
			for _, power in pairs(this.powers) do
				if power.changed then
					power.changed = nil

					if power == polarity_power and power.level == 1 then
						polarity.ts = store.tick_ts
					elseif power == attraction_power and power.level == 1 then
						attraction.ts = store.tick_ts
					end
				end
			end

			if store.tick_ts - decay_ts > basic.decay_cooldown and aoe_ramp > 0 then
				decay_ts = store.tick_ts
				aoe_ramp = aoe_ramp - 1
			end

			if attraction_power.level > 0 and store.tick_ts - attraction.ts > attraction.cooldown then
				local target = U.find_foremost_enemy(store.entities, tpos(this), 0, attacks.range, false, attraction.vis_flags, attraction.vis_bans)

				if not target then
					U.y_animation_wait(this, shooter_sid)
					goto idle
				end

				attraction.ts = store.tick_ts
				U.animation_start(this, attraction.animation, nil, store.tick_ts, false, shooter_sid)
				U.y_wait(store, attraction.shoot_time)
				S:queue(attraction.sound)

				local aura = E:create_entity(attraction.aura)
				local original_range = E:get_template(this.template_name).attacks.range
				local scale = attacks.range / original_range

				aura.source_id = this.id
				aura.aura.source_id = this.id
				aura.pos = V.vclone(this.pos)
				aura.aura.radius = attacks.range
				aura.render.sprites[1].scale = v(scale, scale)
				aura.tween.props[2].keys = {
					{0, v(scale * 0.6, scale * 0.6)},
					{0.3, v(scale, scale)}
				}
				queue_insert(store, aura)

				while not U.animation_finished(this, shooter_sid) do
					coroutine.yield()
				end
			end

			if polarity_power.level > 0 and store.tick_ts - polarity.ts > polarity.cooldown then
				local armored_enemy = get_foremost_armored_enemy()

				if armored_enemy then
					polarity.ts = store.tick_ts
					basic.ts = store.tick_ts
					U.animation_start(this, polarity.animation, nil, store.tick_ts, false, shooter_sid)
					U.y_wait(store, polarity.shoot_time)
					armored_enemy = get_foremost_armored_enemy()

					if armored_enemy then
						local armor_value = armored_enemy.health.armor * 100
						local aura = E:create_entity(basic.payload_name)
						local ray = E:create_entity("tower_sandmystic_polarity_ray")

						SU.armor_dec(armored_enemy, armored_enemy.health.armor)
						aura.pos = V.vclone(armored_enemy.pos)
						aura.source_id = this.id
						aura.aura.source_id = this.id
						aura.aura.radius = polarity.radius
						aura.aura.aoe_inc = polarity.aoe_inc
						aura.aura.aoe_level = aoe_ramp
						aura.fx_ramp_size_factor = polarity.fx_ramp_size_factor
						aura.fx = "fx_sandmystic_polarity_ray_explosion"
						aura.aura.damage_type = DAMAGE_EXPLOSION
						aura.aura.damage_min = armor_value * polarity.damage_per_armor_point * polarity_power.level
						aura.aura.damage_max = aura.aura.damage_min
						aura.aura.damage_factor = this.tower.damage_factor
						aura.aura.duration = fts(5)
						queue_insert(store, aura)

						ray.pos = v(this.pos.x + polarity.bullet_start_offset.x, this.pos.y + polarity.bullet_start_offset.y)
						ray.bullet.from = V.vclone(ray.pos)
						ray.bullet.to = V.vclone(armored_enemy.pos)
						ray.bullet.damage_factor = this.tower.damage_factor
						ray.bullet.target_id = armored_enemy.id
						ray.bullet.source_id = this.id
						ray.bullet.mod = nil
						queue_insert(store, ray)
					end

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end
				end
			end

			if store.tick_ts - basic.ts > basic.cooldown then
				local enemy, _, predicted_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, attacks.range, basic.node_prediction, basic.vis_flags, basic.vis_bans)

				if enemy then
					basic.ts = store.tick_ts
					U.animation_start(this, basic.animation, nil, store.tick_ts, false, shooter_sid)
					U.y_wait(store, basic.shoot_time)

					local trigger_pos = predicted_pos
					enemy, _, predicted_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, attacks.range, basic.node_prediction, basic.vis_flags, basic.vis_bans)

					local destination = enemy and predicted_pos or trigger_pos
					local ray = E:create_entity(basic.bullet)
					local aura = E:create_entity(basic.payload_name)

					S:queue(basic.sound_shoot)
					ray.pos = v(this.pos.x + basic.bullet_start_offset.x, this.pos.y + basic.bullet_start_offset.y)
					ray.bullet.from = V.vclone(ray.pos)
					ray.bullet.to = destination
					ray.bullet.source_id = this.id
					aura.source_id = this.id
					aura.aura.source_id = this.id
					aura.aura.aoe_level = aoe_ramp
					aura.aura.damage_min = basic.damage_min
					aura.aura.damage_max = basic.damage_max
					aura.aura.damage_factor = this.tower.damage_factor
					aoe_ramp = math.min(aoe_ramp + 1, basic.max_charge)
					decay_ts = store.tick_ts
					ray.bullet.hit_payload = aura
					queue_insert(store, ray)

					while not U.animation_finished(this, shooter_sid) do
						coroutine.yield()
					end
				end
			end

			::idle::
			U.animation_start(this, "idle", nil, store.tick_ts, true, shooter_sid)
			coroutine.yield()
		end
	end
end

function scripts.tower_sandmystic.remove(this, store)
	for _, aura in pairs(store.entities) do
		if aura.template_name == this.attacks.list[3].aura and aura.source_id == this.id then
			queue_remove(store, aura)
		end
	end

	return true
end

scripts.aura_sandmystic_shockwave = {}

function scripts.aura_sandmystic_shockwave.update(this, store)
	local aura = this.aura
	local effective_radius = aura.radius + aura.aoe_inc * aura.aoe_level
	local fx = E:create_entity(this.fx)
	local scale = 1 + aura.aoe_level / 5 * (this.fx_ramp_size_factor or 1)

	fx.pos = V.vclone(this.pos)
	fx.render.sprites[1].ts = store.tick_ts
	fx.render.sprites[1].scale = V.v(scale, scale)
	queue_insert(store, fx)
	U.y_wait(store, aura.duration)

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, effective_radius, aura.vis_flags, aura.vis_bans)

	if targets then
		for _, enemy in pairs(targets) do
			local damage = E:create_entity("damage")

			damage.damage_type = aura.damage_type
			damage.reduce_armor = aura.reduce_armor
			damage.reduce_magic_armor = aura.reduce_magic_armor

			if UP:get_upgrade("engineer_efficiency") then
				damage.value = aura.damage_max
			else
				local distance_factor = U.dist_factor_inside_ellipse(enemy.pos, this.pos, effective_radius)

				damage.value = math.floor(aura.damage_max - (aura.damage_max - aura.damage_min) * distance_factor)
			end

			damage.value = math.ceil(aura.damage_factor * damage.value)
			damage.source_id = aura.source_id or this.source_id or this.id
			damage.target_id = enemy.id
			queue_damage(store, damage)

			if aura.mod and (not aura.excluded_templates or not table.contains(aura.excluded_templates, enemy.template_name)) then
				local mod = E:create_entity(aura.mod)

				mod.modifier.target_id = enemy.id
				mod.modifier.source_id = aura.source_id or this.source_id or this.id
				queue_insert(store, mod)
			end
		end
	end

	queue_remove(store, this)
end


-- Rebborn 2 heroes and Hammerhold campaign dependencies
scripts.decal_ramses = {}

function scripts.decal_ramses.update(this, store, script)
	local ramses_ts = store.tick_ts

	while true do
		if this.ui.clicked then
			this.ui.clicked = nil

			U.y_animation_play(this, "click", nil, store.tick_ts, false)

			this.render.sprites[1].offset.x = this.render.sprites[1].offset.x - 1
			this.render.sprites[1].offset.y = this.render.sprites[1].offset.y + 25

			U.y_animation_play(this, "slab", nil, store.tick_ts, false)
			U.y_wait(store, 1)

			this.render.sprites[1].offset.x = this.render.sprites[1].offset.x + 3
			this.render.sprites[1].offset.y = this.render.sprites[1].offset.y - 23

			U.y_animation_play(this, "heart", nil, store.tick_ts, false)
			U.y_animation_play(this, "poof", nil, store.tick_ts, false)
			AC:got(this.achievement_id)
			queue_remove(store, this)
		elseif ramses_ts < store.tick_ts - this.idle_cooldown then
			U.animation_start(this, "wave", nil, store.tick_ts, false)

			ramses_ts = store.tick_ts
		end

		coroutine.yield()
	end
end

scripts.decal_shockidy = {}

function scripts.decal_shockidy.update(this, store, script)
	local shockidy_ts = store.tick_ts
	local clicks = 0

	U.animation_start(this, "idle", nil, store.tick_ts, false)

	while true do
		if this.ui.clicked then
			this.ui.clicked = nil
			clicks = clicks + 1

			if clicks < 6 then
				U.y_animation_play(this, "clicked", nil, store.tick_ts, false)
				U.animation_start(this, "idle", nil, store.tick_ts, false)
			elseif clicks == 6 then
				U.y_animation_play(this, "freedom", nil, store.tick_ts, false)
				AC:got("THIS_IS_A_BUCKET")
				U.animation_start(this, "freedom_idle", nil, store.tick_ts, true)
			elseif clicks % 2 == 1 then
				U.y_animation_play(this, "showoff_1", nil, store.tick_ts, false)
				U.animation_start(this, "freedom_idle", nil, store.tick_ts, true)
			else
				U.y_animation_play(this, "showoff_2", nil, store.tick_ts, false)
				U.animation_start(this, "freedom_idle", nil, store.tick_ts, true)
			end
		end

		coroutine.yield()
	end
end

local function rebborn_hero_skill_level(skill, hero_level)
	local skill_level

	for level = 1, hero_level do
		skill_level = skill.xp_level_steps[level] or skill_level
	end

	return skill_level
end

scripts.hero_oberon = {}

function scripts.hero_oberon.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s, sl

	s = this.hero.skills.enchant
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[1]
		local mod = E:get_template("mod_sylvan_enchant")

		a.disabled = false
		a.cooldown = s.cooldown[sl]
		mod.damage_max = s.damage_max[sl]
		mod.damage_min = s.damage_min[sl]
		a.count = s.count[sl]
	end

	s = this.hero.skills.roots
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[2]
		local aura = E:get_template("aura_roots_oberon")
		local slow = E:get_template("mod_oberon_slow")
		local dps = E:get_template("mod_oberon_dps")
		local mod = E:get_template("mod_thorn_oberon")

		a.disabled = false
		a.max_range = s.max_range[sl]
		a.cooldown = s.cooldown[sl]
		aura.aura.duration = s.duration[sl]
		slow.slow.factor = s.slow_factor[sl]
		dps.dps.damage_max = s.damage[sl]
		dps.dps.damage_min = s.damage[sl]
		dps.dps.damage_every = s.damage_every[sl]
		this.transfer.extra_speed = s.speed[sl]
		mod.modifier.duration = s.mod_duration[sl]
		mod.damage_min = s.mod_damage[sl]
		mod.damage_max = s.mod_damage[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_oberon.insert(this, store, script)
	this.hero.fn_level_up(this, store, true)

	this.melee.order = U.attack_order(this.melee.attacks)

	if not this.auras.list[1].disabled then
		local e = E:create_entity(this.auras.list[1].name)

		e.aura.source_id = this.id
		e.render.sprites[1].ts = store.tick_ts
		this.health.on_damage = scripts.aura_oberon_shield.on_damage
		this._shield_aura = e

		queue_insert(store, e)
	end

	return true
end

function scripts.hero_oberon.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta
	local origspeed = this.motion.max_speed

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	local function oberon_melee_block_and_attacks(store, this)
		local target = SU.soldier_pick_melee_target(store, this)

		if not target then
			return false, A_NO_TARGET
		end

		if SU.soldier_move_to_slot_step(store, this, target) then
			return true
		end

		local attack = SU.soldier_pick_melee_attack(store, this, target)

		if not attack then
			return false, A_IN_COOLDOWN
		end

		if attack.xp_from_skill then
			SU.hero_gain_xp_from_skill(this, this.hero.skills[attack.xp_from_skill])
		end

		local attack_done
		local attack_done, enchant = attack_done, this.timed_attacks.list[1].active and this.timed_attacks.list[1].count_active > 0

		if enchant then
			S:queue(this.sound_slash)
		end

		attack_done = SU.y_soldier_do_single_melee_attack(store, this, target, attack)

		if attack_done then
			if enchant then
				this.timed_attacks.list[1].count_active = this.timed_attacks.list[1].count_active - 1
			end

			return false, A_DONE
		else
			return true
		end
	end

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)

			this._shield_aura.render.sprites[1].ts = store.tick_ts
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_354_0
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
			end

			if U.has_modifiers(store, this, "mod_oberon_sled") then
				this.transfer.disabled = nil
				this.transfer.min_distance = 0
			else
				this.transfer.disabled = true
				this.transfer.distance = 1e+99
				this.motion.max_speed = origspeed
			end

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.enchant

			if a.active and a.count_active == 0 then
				a.active = nil
				this.render.sprites[1].prefix = "hero_oberon"
				this.melee.attacks[1].mod = nil
			end

			if not a.disabled and store.tick_ts - a.ts > a.cooldown and not a.active then
				local start_ts = store.tick_ts

				U.y_animation_play(this, a.animation, nil, store.tick_ts, 1)
				S:queue(a.sound)
				U.animation_start(this, "idle", nil, store.tick_ts, false)

				this.render.sprites[1].prefix = "hero_oberon_buff"
				this.melee.attacks[1].mod = "mod_sylvan_enchant"
				a.count_active = a.count
				a.active = true
				a.ts = start_ts

				SU.hero_gain_xp_from_skill(this, skill)
				SU.y_hero_animation_wait(this)

				goto label_354_0
			end

			a = this.timed_attacks.list[2]
			skill = this.hero.skills.roots

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, nil, a.vis_flags, a.vis_bans)

				if not target then
					SU.delay_attack(store, a, 0.13333333333333333)
				else
					local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
					local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)

					if #nodes < 1 then
						SU.delay_attack(store, a, 0.4)
					else
						local s_pi, s_spi, s_ni = unpack(nodes[1])
						local flip = target.pos.x < this.pos.x
						local start_ts = store.tick_ts

						U.animation_start(this, a.animation, flip, store.tick_ts)
						S:queue(a.sound)

						if SU.y_hero_wait(store, this, a.cast_time) then
							goto label_354_0
						end

						a.ts = start_ts

						SU.hero_gain_xp_from_skill(this, skill)

						local delay = 0
						local n_step = ni < s_ni and -a.step or a.step

						ni = s_ni
						ni1 = s_ni
						ni2 = s_ni

						for i = 1, skill.count[skill.level] do
							local b = E:create_entity(a.bullet)

							b.pos = P:node_pos(s_pi, s_spi, ni)
							b.aura.source_id = this.id
							b.render.sprites[1].flip_x = flip
							b.delay = delay

							queue_insert(store, b)

							delay = delay + 0.025

							if math.fmod(i, 2) > 0 then
								ni2 = ni2 - n_step
								ni = ni2
							else
								ni1 = ni1 + n_step
								ni = ni1
							end

							s_spi = km.zmod(s_spi + 1, 3)
						end

						if this.timed_attacks.list[1].active then
							local targets = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans)

							if targets then
								for i = 1, #targets do
									if this.timed_attacks.list[1].count_active > 0 then
										local m = E:create_entity(a.mod)

										m.modifier.target_id = targets[i].id
										m.modifier.source_id = this.id

										queue_insert(store, m)

										this.timed_attacks.list[1].count_active = this.timed_attacks.list[1].count_active - 1
									else
										break
									end
								end
							end
						end

						SU.y_hero_animation_wait(this)

						goto label_354_0
					end
				end
			end

			brk, sta = oberon_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			elseif SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_354_0::

		coroutine.yield()
	end
end

scripts.aura_oberon_shield = {}

function scripts.aura_oberon_shield.on_damage(this, store, damage)
	local aura = this._shield_aura
	local pd = U.predict_damage(this, damage)

	if not aura then
		log.error("aura_oberon_shield.on_damage for enemy %s has no aura pointer", this.id)

		return true
	end

	if this.health.hp - pd > this.hero.level_stats.hp_max[this.hero.level] then
		this.health.hp_max = this.health.hp_max - pd
	end

	if this.health.hp - pd < this.hero.level_stats.hp_max[this.hero.level] then
		this.health.hp_max = this.hero.level_stats.hp_max[this.hero.level]
	end

	aura.added_health = aura.added_health - pd
	aura.hit = true

	return true
end

function scripts.aura_oberon_shield.update(this, store, script)
	local hero = store.entities[this.aura.source_id]

	this.pos = hero.pos

	local enabled = false
	local last_level = hero.hero.level
	local hp = hero.health.hp
	local last_tick = store.tick_ts
	local last_pos = V.vclone(this.pos)
	local s = this.render.sprites[1]
	local level = 0

	local function add_health(value)
		if not enabled then
			if hero.health.hp > hero.hero.level_stats.hp_max[hero.hero.level] then
				hero.health.hp = hero.hero.level_stats.hp_max[hero.hero.level]
				hero.health.hp_max = hero.hero.level_stats.hp_max[hero.hero.level]
			else
				return
			end
		else
			this.added_health = this.added_health + value
			hero.health.hp = hero.health.hp + value

			if hero.health.hp > hero.health.hp_max then
				hero.health.hp_max = hero.health.hp_max + value
			end
		end
	end

	while true do
		local rally_pos = hero.nav_rally.pos

		if enabled then
			level = 1

			if hero.health.dead or V.dist(rally_pos.x, rally_pos.y, hero.pos.x, hero.pos.y) > this.max_distance then
				enabled = false
				level = 0

				add_health(-this.added_health)

				this.added_health = 0
			elseif this.added_health < this.max_hp and store.tick_ts - last_tick > this.tick_time and last_level == hero.hero.level then
				add_health(this.hp_per_tick)

				last_tick = store.tick_ts
			end
		elseif not hero.health.dead and V.dist(rally_pos.x, rally_pos.y, hero.pos.x, hero.pos.y) < this.max_distance then
			enabled = true
			level = 1
			this.added_health = 0
			last_tick = store.tick_ts
		end

		if last_level ~= hero.hero.level and this.added_health == 0 then
			last_level = hero.hero.level
		end

		if last_level ~= hero.hero.level and this.added_health > 0 then
			local prev = this.added_health

			this.added_health = 0

			add_health(prev)

			last_level = hero.hero.level
		end

		if this.hit then
			U.animation_start(this, "hit", nil, store.tick_ts, false)

			while not U.animation_finished(this) do
				coroutine.yield()
			end

			U.animation_start(this, "idle", nil, store.tick_ts, true)

			this.hit = nil
		end

		if this.added_health < 0 then
			this.added_health = 0
		end

		s.hidden = this.added_health == 0
		level = this.added_health < this.max_hp / 2 and 1 or this.added_health >= this.max_hp / 2 and this.added_health < this.max_hp and 2 or 3

		if level == 1 then
			s.prefix = "oberon_shield_1"
			s.offset = v(0, 5)
		elseif level == 2 then
			s.prefix = "oberon_shield_2"
			s.offset = v(0, -5)
		elseif level == 3 then
			s.prefix = "oberon_shield_3"
			s.offset = v(0, -5)
		end

		coroutine.yield()
	end
end

scripts.mod_sylvan_enchant = {}

function scripts.mod_sylvan_enchant.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local hero = store.entities[this.modifier.source_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	local d = E:create_entity("damage")

	d.value = math.random(this.damage_min, this.damage_max)
	d.source_id = this.id
	d.target_id = target.id
	d.damage_type = this.damage_type
	d.xp_gain_factor = this.xp_gain_factor
	d.xp_dest_id = this.modifier.source_id

	queue_damage(store, d)

	return false
end

scripts.aura_roots_oberon = {}

function scripts.aura_roots_oberon.update(this, store)
	local last_hit_ts = 0

	U.sprites_hide(this)

	if this.delay then
		U.y_wait(store, this.delay)
	end

	for _, s in pairs(this.render.sprites) do
		s.ts = store.tick_ts
	end

	U.sprites_show(this)

	last_hit_ts = store.tick_ts - this.aura.cycle_time

	while true do
		if this.interrupt then
			last_hit_ts = 1e+99
		end

		if this.aura.duration >= 0 and store.tick_ts - this.aura.ts > this.aura.duration then
			U.animation_start(this, "end", nil, store.tick_ts, false)

			while not U.animation_finished(this) do
				coroutine.yield()
			end

			queue_remove(store, this)
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			last_hit_ts = store.tick_ts

			local targets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.vis_bans) == 0 and band(v.vis.bans, this.aura.vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
			end)

			for i, target in ipairs(targets) do
				local mods = this.aura.mods or {
					this.aura.mod
				}

				for _, mod_name in pairs(mods) do
					local new_mod = E:create_entity(mod_name)

					new_mod.modifier.level = this.aura.level
					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					queue_insert(store, new_mod)
				end
			end

			local herotargets = table.filter(store.entities, function(k, v)
				return v.unit and v.vis and v.health and not v.health.dead and band(v.vis.flags, this.aura.hero_vis_bans) == 0 and band(v.vis.bans, this.aura.hero_vis_flags) == 0 and U.is_inside_ellipse(v.pos, this.pos, this.aura.radius) and (not this.aura.allowed_templates or table.contains(this.aura.hero_allowed_templates, v.template_name)) and (not this.aura.excluded_templates or not table.contains(this.aura.excluded_templates, v.template_name)) and (not this.aura.filter_source or this.aura.source_id ~= v.id)
			end)

			for i, target in ipairs(herotargets) do
				local mods = this.aura.hero_mods or {
					this.aura.hero_mod
				}

				for _, mod_name in pairs(mods) do
					local new_mod = E:create_entity(mod_name)

					new_mod.modifier.level = this.aura.level
					new_mod.modifier.target_id = target.id
					new_mod.modifier.source_id = this.id

					queue_insert(store, new_mod)
				end
			end
		end

		coroutine.yield()
	end
end

scripts.hero_ember = {}

function scripts.hero_ember.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s, sl

	s = this.hero.skills.crack
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[1]

		a.disabled = false
		a.cooldown = s.cooldown[sl]
		a.damage_max = s.damage_max[sl]
		a.damage_min = s.damage_min[sl]
		a.damage_radius = s.radius[sl]
		a.steps = s.steps[sl]

		local au = E:get_template(a.hit_aura)

		au.aura.damage_max = s.burn_damage[sl]
		au.aura.damage_min = s.burn_damage[sl]
		au.aura.damage_radius = s.burn_radius[sl]
		au.aura.duration = s.duration[sl]
		au.extra_armor = s.extra_armor[sl]
		au.extra_damage = s.extra_damage[sl]
		this.buff_duration = s.buff_duration[sl]
		au = E:get_template("mod_ember_crack")
		au.dps.damage_min = s.burn_damage[sl]
		au.dps.damage_max = s.burn_damage[sl]
		au.dps.damage_every = s.burn_every[sl]
		au = E:get_template("mod_heal_ember")
		au.hps.heal_min = s.burn_damage[sl]
		au.hps.heal_max = s.burn_damage[sl]
		au.hps.heal_every = s.burn_every[sl]
	end

	s = this.hero.skills.volcano
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[2]

		a.disabled = false
		a.cooldown = s.cooldown[sl]
		a.self_damage = s.self_damage[sl]
		a.self_damage_every = s.self_damage_every[sl]

		local v = E:get_template(a.entity)

		v.bullet_attack.cooldown = s.attack_cooldown[sl]
		v.bullet_attack.max_range = a.volcano_range
		v.duration = 9e+99

		local b = E:get_template("bomb_ember_volcano")

		b.bullet.damage_min = s.bomb_damage[sl]
		b.bullet.damage_max = s.bomb_damage[sl]
		b.bullet.damage_radius = s.bullet_radius[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_ember.update(this, store, script)
	this.buff_ts = 0

	local a, skill, brk, sta

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	local h = this.health

	this.timed_attacks.list[1].ts = store.tick_ts
	this.timed_attacks.list[2].ts = store.tick_ts

	while true do
		if this.buffed and store.tick_ts - this.buff_ts > this.buffed.modifier.duration then
			this.buffed = nil

			local hl = this.hero.level
			local ls = this.hero.level_stats

			this.health.armor = ls.armor[hl]
			this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
			this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
		end

		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_364_1
				end
			end

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.crack

			if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
				local target_info = U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, a.vis_flags, a.vis_bans, function(e)
					return e.health.immune_to ~= DAMAGE_ALL or e.health.ignore_damage == false
				end)

				if not target_info or #target_info < a.min_count then
					SU.delay_attack(store, a, 0.2)
					log.debug("2")
				else
					local target = target_info[1]
					local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.radius, a.vis_flags, a.vis_bans, function(e)
						return e.health.immune_to ~= DAMAGE_ALL or e.health.ignore_damage == false
					end)

					U.animation_start(this, "jump_start", nil, store.tick_ts, 1)
					S:queue(a.sound)

					while not U.animation_finished(this) do
						log.debug("preparing to jump")

						if this.nav_rally.new then
							goto label_364_1
						end

						coroutine.yield()
					end

					a.ts = store.tick_ts

					U.animation_start(this, "jump", nil, store.tick_ts, 1)

					while store.tick_ts - a.ts < a.shoot_time do
						coroutine.yield()
					end

					if targets then
						for _, t in ipairs(targets) do
							local d = E:create_entity("damage")

							log.debug("damage entity")

							d.damage_type = a.damage_type
							d.source_id = this.id
							d.target_id = t.id
							d.value = math.random(a.damage_min, a.damage_max)

							queue_damage(store, d)
						end
					end

					SU.hero_gain_xp_from_skill(this, skill)

					local pi, spi, ni = target.nav_path.pi, target.nav_path.spi, target.nav_path.ni
					local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)
					local s_pi, s_spi, s_ni = unpack(nodes[1])
					local delay = 0
					local n_step = ni < s_ni and -a.step or a.step

					ni = s_ni
					ni1 = s_ni
					ni2 = s_ni

					for i = 1, a.steps do
						target = E:create_entity("aura_ember_crack")
						target.owner_id = this.id
						target.sprite_id = math.random(1, 3)
						target.delay = delay
						delay = delay + 0.05
						target.pos = P:node_pos(s_pi, s_spi, ni)

						if i % 2 == 0 then
							ni2 = ni2 - n_step
							ni = ni2
						else
							ni1 = ni1 + n_step
							ni = ni1
						end

						s_spi = km.zmod(s_spi + 1, 3)

						log.debug("posx: %s posy: %s", target.pos.x, target.pos.y)
						queue_insert(store, target)
					end
				end

				while not U.animation_finished(this) do
					coroutine.yield()
				end
			end

			a = this.timed_attacks.list[2]
			skill = this.hero.skills.volcano

			local started = 0

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				if U.get_blocked(store, this) and U.is_blocked_valid(store, this) then
					SU.delay_attack(store, a, 0.3333333333333333)
				else
					local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans, function(e)
						return e.health.immune_to ~= DAMAGE_ALL or e.health.ignore_damage == false
					end)

					if not enemies then
						SU.delay_attack(store, a, fts(10))
					else
						local nearest = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, true)
						local pi, spi, ni = unpack(nearest[1])
						local nni = ni + 3
						local turret_pos = P:node_pos(pi, math.random(1, 2), nni)
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

							S:queue(a.sound)

							local an, af, ai = U.animation_name_facing_point(this, a.animation, turret_pos)

							U.animation_start(this, a.animation, af, store.tick_ts, 1)

							local cast_time = store.tick_ts

							while store.tick_ts - cast_time < a.cast_time do
								log.debug("volcano recharging")
								coroutine.yield()
							end

							last_ts = start_ts

							local e = E:create_entity(a.entity)
							local epos = turret_pos

							e.owner_id = this.id
							e.flip_x = this.render.sprites[1].flip_x
							e.pos = V.vclone(epos)

							queue_insert(store, e)
							S:queue(a.sound_cast, {
								delay = fts(10)
							})

							e.sound_destroy = a.sound_destroy
							a.ts_v = store.tick_ts + a.self_damage_every

							local wait_time = store.tick_ts

							while store.tick_ts - wait_time < a.shoot_time do
								if this.nav_rally.new then
									goto label_364_0
								end

								log.debug("volcanocharging")
								coroutine.yield()
							end

							U.y_animation_wait(this)

							while this.health.hp > a.self_damage and not this.nav_rally.new and not this.unit.is_stunned do
								started = 1

								U.animation_start(this, a.animation_2, nil, store.tick_ts, true)

								if this.nav_rally.new then
									break
								elseif enemies and #enemies > 0 then
									U.y_animation_wait(this)
								end

								if this.health.hp > a.self_damage and store.tick_ts - a.ts_v >= a.self_damage_every then
									a.ts_v = store.tick_ts

									local d = E:create_entity("damage")

									d.source_id = this.id
									d.target_id = this.id
									d.damage_type = DAMAGE_TRUE
									d.value = a.self_damage

									queue_damage(store, d)
									SU.hero_gain_xp_from_skill(this, skill)
								elseif this.health.hp <= a.self_damage then
									e.can_shoot = 0

									break
								end

								if this.buffed and store.tick_ts - this.buff_ts > this.buffed.modifier.duration then
									this.buffed = nil

									local hl = this.hero.level
									local ls = this.hero.level_stats

									this.health.armor = ls.armor[hl]
									this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
									this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]
								end

								coroutine.yield()
							end

							::label_364_0::

							e.can_shoot = 0

							if started == 1 then
								a.ts = start_ts
							end

							SU.hero_gain_xp_from_skill(this, skill)

							goto label_364_1
						end
					end
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
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

		::label_364_1::

		coroutine.yield()
	end
end

scripts.aura_ember_crack = {}

function scripts.aura_ember_crack.update(this, store)
	local target

	U.sprites_hide(this)

	if this.delay then
		log.debug("delay %s duration %s", this.delay, this.aura.duration)
		U.y_wait(store, this.delay)
	end

	U.sprites_show(this)

	local ts = store.tick_ts
	local last_hit_ts = store.tick_ts - this.aura.cycle_time

	this.tween.ts = store.tick_ts
	this.tween.props[1].ts = store.tick_ts

	U.y_animation_play(this, "rise_" .. this.sprite_id, nil, store.tick_ts, 1)

	while true do
		if store.tick_ts - ts > this.aura.duration then
			break
		end

		target = store.entities[this.owner_id]

		if target and U.is_inside_ellipse(this.pos, target.pos, this.aura.damage_radius) then
			if target.buffed then
				if store.tick_ts - target.buff_ts > target.buffed.modifier.duration then
					queue_remove(store, target.buffed)

					local m = E:create_entity("mod_heal_ember")

					m.modifier.target_id = target.id
					m.modifier.source_id = this.id

					queue_insert(store, m)

					target.buffed = m
				end
			else
				target.buff_ts = store.tick_ts
				target.health.armor = target.health.armor + this.extra_armor
				target.melee.attacks[1].damage_max = target.melee.attacks[1].damage_max + this.extra_damage
				target.melee.attacks[1].damage_min = target.melee.attacks[1].damage_min + this.extra_damage

				local m = E:create_entity("mod_heal_ember")

				m.modifier.target_id = target.id
				m.modifier.source_id = this.id

				queue_insert(store, m)

				target.buffed = m
			end
		end

		if store.tick_ts - last_hit_ts >= this.aura.cycle_time then
			last_hit_ts = store.tick_ts
			target = U.find_enemies_in_range(store.entities, this.pos, 0, this.aura.damage_radius, this.aura.vis_flags, this.aura.vis_bans)

			if target then
				for _, e in pairs(target) do
					local m = E:create_entity("mod_ember_crack")

					m.modifier.target_id = e.id
					m.modifier.source_id = this.id

					queue_insert(store, m)
				end
			end
		end

		coroutine.yield()
	end

	log.debug("removed at %s", store.tick_ts - ts)
	queue_remove(store, this)
end

scripts.mod_crack_ember = {}

function scripts.mod_crack_ember.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	target.health.armor = target.health.armor + this.extra_armor
	target.melee.attacks[1].damage_max = target.melee.attacks[1].damage_max + this.extra_damage
	target.melee.attacks[1].damage_min = target.melee.attacks[1].damage_min + this.extra_damage

	return true
end

function scripts.mod_crack_ember.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		target.health.armor = target.health.armor - this.extra_armor
		target.melee.attacks[1].damage_max = target.melee.attacks[1].damage_max - this.extra_damage
		target.melee.attacks[1].damage_min = target.melee.attacks[1].damage_min - this.extra_damage
	end

	return true
end

scripts.aura_ember_fissure = {}

function scripts.aura_ember_fissure.update(this, store)
	local a = this.aura
	local opos

	local function do_attack(pos, last_attack)
		local fx = E:create_entity(a.fx)

		fx.pos.x, fx.pos.y = pos.x, pos.y

		if not last_attack then
			fx.render.sprites[2].scale = V.v(0.8, 0.8)
		end

		fx.render.sprites[2].ts = store.tick_ts
		fx.tween.ts = store.tick_ts

		queue_insert(store, fx)

		local radius = last_attack and a.last_attack_damage_radius or a.damage_radius
		local targets = U.find_enemies_in_range(store.entities, pos, 0, radius, a.vis_flags, a.vis_bans)

		if targets then
			for _, t in pairs(targets) do
				local d = E:create_entity("damage")

				d.value = math.random(a.damage_min, a.damage_max)
				d.damage_type = a.damage_type
				d.source_id = this.id
				d.target_id = t.id

				queue_damage(store, d)
			end

			log.paranoid(">>>> aura_ember_fissure POS:%s,%s  damaged:%s", pos.x, pos.y, table.concat(table.map(targets, function(k, v)
				return v.id
			end), ","))
		end
	end

	local pi, spi, ni, tni, target, origin
	local target_info = U.find_enemies_in_paths(store.entities, this.pos, a.min_nodes, a.max_nodes)

	if not target_info or #target_info < a.min_count then
		log.error("aura_ember_fissure could not find valid enemies in the hero paths")
	else
		target = target_info[1].enemy
		origin = target_info[1].origin
		pi, spi, ni = unpack(origin)
		tni = target.nav_path.ni

		for i = 1, a.steps do
			local nni = ni + i * a.step_nodes * km.sign(tni - ni)
			local oni = ni + i * a.step_nodes * km.sign(tni - ni) * -1

			spi = i == a.steps and 1 or (spi == 2 or spi == 3) and 1 or math.random() < 0.5 and 2 or 3

			U.y_wait(store, a.step_delay)

			local spos = P:node_pos(pi, spi, nni)

			do_attack(spos, i == a.steps)

			if i == 1 then
				opos = P:node_pos(pi, spi, oni)

				do_attack(opos, false)
			end
		end
	end

	queue_remove(store, this)
end

scripts.decal_hero_ember_volcano = {}

function scripts.decal_hero_ember_volcano.update(this, store, script)
	local a = this.bullet_attack

	a.ts = store.tick_ts

	U.y_animation_play(this, "rising", nil, store.tick_ts)

	while true do
		if this.can_shoot == 1 and store.tick_ts - a.ts > a.cooldown then
			a.ts = store.tick_ts

			local target = U.find_foremost_enemy(store.entities, this.pos, 0, a.range, a.node_prediction, a.vis_flags, a.vis_bans)

			if target then
				U.animation_start(this, "attack", nil, store.tick_ts)
				U.y_wait(store, a.shoot_time)
				log.debug("volcanoshoot")

				local b = E:create_entity("bomb_ember_volcano")

				b.bullet.source_id = this.id
				b.bullet.target_id = target.id
				b.bullet.to = V.vclone(target.pos)
				b.pos.x = this.pos.x
				b.pos.y = this.pos.y + this.bullet_start_offset
				b.bullet.from = V.vclone(b.pos)
				b.bullet.xp_dest_id = this.owner_id

				queue_insert(store, b)
			elseif U.animation_finished(this) then
				U.animation_start(this, "idle", nil, store.tick_ts)
			end
		end

		if this.can_shoot == 0 then
			U.y_animation_play(this, "vanish", nil, store.tick_ts)
			queue_remove(store, this)
		end

		coroutine.yield()
	end
end

scripts.hero_penumbra = {}

function scripts.hero_penumbra.get_info(this)
	local b = E:get_template(this.ranged.attacks[1].bullet)
	local minr, maxr = b.bullet.damage_min, b.bullet.damage_max
	local damage_type_ranged = b.bullet.damage_type
	local immune_armor = band(this.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1
	local immune_magic = band(this.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		ranged_damage_min = minr,
		ranged_damage_max = maxr,
		ranged_damage_type = damage_type_ranged,
		ranged_damage_icon = this.info.ranged_damage_icon or this.info.damage_icon,
		-- Keep the Rebborn aliases for any imported code that still reads them.
		damage_min_ranged = minr,
		damage_max_ranged = maxr,
		damage_type_ranged = damage_type_ranged,
		damage_type = b.bullet.damage_type,
		damage_icon_ranged = this.info.damage_icon,
		armor = this.health.armor,
		respawn = this.health.dead_lifetime,
		immune = this.health.immune_to == DAMAGE_ALL_TYPES,
		immune_armor = immune_armor,
		magic_armor = this.health.magic_armor,
		immune_magic = immune_magic,
		no_ranged = false,
		yes_melee = false
	}
end

function scripts.hero_penumbra.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]

	local s, sl, a, e

	s = E:get_template(this.ranged.attacks[1].bullet)
	s.bullet.level = hl
	s.bullet.damage_min = s.bullet.damage_min_levels[hl]
	s.bullet.damage_max = s.bullet.damage_max_levels[hl]
	s = this.hero.skills.flap
	sl = rebborn_hero_skill_level(s, hl)
	a = this.timed_attacks.list[1]

	if sl then
		s.level = sl
		a.disabled = false
		a.count = s.counts[sl]

		local p = E:get_template(E:get_template(a.bullet).bullet.hit_scripted)

		e = E:get_template(p.explosion)
		e.damage = s.explosion_damages[sl]
		e = E:get_template(p.explosion_big)
		e.damage = s.explosion_damages[sl]
	end

	s = this.hero.skills.dive
	sl = rebborn_hero_skill_level(s, hl)
	a = this.timed_attacks.list[2]

	if sl then
		s.level = sl
		a.disabled = false
		a.damage = s.damages[sl]
		a.count = s.counts[sl]
		a.missile_scale = s.missile_scale[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_penumbra.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill

	this.world_eater_factor = this.world_eater_factor_min

	local base_move_speed = this.motion.max_speed
	local base_attack_speed = this.ranged.attacks[1].cooldown

	a = E:create_entity("aura_world_eater")
	a.owner_id = this.id
	this.world_eater_id = a.id

	queue_insert(store, a)

	function this.update_world_eater(e)
		local w = store.entities[e.world_eater_id]

		if w.disabled then
			return
		end

		e.motion.max_speed = base_move_speed * e.world_eater_factor
		e.ranged.attacks[1].cooldown = base_attack_speed / e.world_eater_factor

		if w.hidden then
			return
		end

		local sprite_factor = (e.world_eater_factor - e.world_eater_factor_min) / (e.world_eater_factor_max - e.world_eater_factor_min)

		if tostring(sprite_factor) == "1" then
			w.render.sprites[1].name = "penumbra_glow_effect_0003"
			w.render.sprites[2].prefix = "penumbra_glow_t3"
			w.render.sprites[1].hidden = nil
			w.render.sprites[2].hidden = nil
		elseif sprite_factor >= 0.5 then
			w.render.sprites[1].name = "penumbra_glow_effect_0002"
			w.render.sprites[2].prefix = "penumbra_glow_t2"
			w.render.sprites[1].hidden = nil
			w.render.sprites[2].hidden = nil
		elseif sprite_factor > 0 then
			w.render.sprites[1].name = "penumbra_glow_effect_0001"
			w.render.sprites[2].prefix = "penumbra_glow_t1"
			w.render.sprites[1].hidden = nil
			w.render.sprites[2].hidden = nil
		else
			w.render.sprites[1].hidden = true
			w.render.sprites[2].hidden = true
		end
	end

	U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

	this.health_bar.hidden = false
	this.timed_attacks.list[1].ts = store.tick_ts
	this.timed_attacks.list[2].ts = store.tick_ts

	while true do
		if h.dead then
			local w = store.entities[this.world_eater_id]

			w.disabled = true
			w.render.sprites[1].hidden = true
			w.render.sprites[2].hidden = true
			this.world_eater_factor = this.world_eater_factor_min
			this.motion.max_speed = base_move_speed
			this.ranged.attacks[1].cooldown = base_attack_speed

			SU.y_hero_death_and_respawn(store, this)

			w.disabled = nil
		end

		while this.nav_rally.new do
			SU.y_hero_new_rally(store, this)
		end

		if SU.hero_level_up(store, this) then
			U.y_animation_play(this, "idle", nil, store.tick_ts, 1)
		end

		a = this.timed_attacks.list[2]
		skill = this.hero.skills.dive

		if not a.disabled and store.tick_ts - a.ts >= a.cooldown and U.find_enemies_in_range(store.entities, this.pos, a.min_range, a.max_range, 0, 0, function(e)
			return e.health.immune_to ~= DAMAGE_ALL or e.health.ignore_damage == false
		end) then
			a.ts = store.tick_ts
			this.health_bar.hidden = true
			this.health.ignore_damage = true

			local w = store.entities[this.world_eater_id]

			w.hidden = true
			w.render.sprites[1].hidden = true
			w.render.sprites[2].hidden = true

			S:queue(a.sound)
			U.animation_start(this, "dive", nil, store.tick_ts, 1)
			U.y_wait(store, a.shoot_time)

			local targets = U.find_enemies_in_range(store.entities, this.pos, 0, a.radius, a.vis_flags or 0, a.vis_bans or 0)

			if targets then
				for _, t in ipairs(targets) do
					local d = E:create_entity("damage")

					d.damage_type = a.damage_type
					d.source_id = this.id
					d.target_id = t.id
					d.value = a.damage

					queue_damage(store, d)
				end
			end

			local missile_factor = (this.world_eater_factor - this.world_eater_factor_min) / this.world_eater_factor_inc

			if missile_factor > 0 then
				missile_factor = missile_factor * a.missile_scale

				local center = V.v(this.pos.x + a.offset.x, this.pos.y + a.offset.y)
				local angle = 150 / (a.count - 1)

				for i = 1, a.count do
					local target = U.find_random_enemy(store.entities, this.pos, 0, 1200)
					local b = E:create_entity(a.bullet)

					b.bullet.source_id = this.id
					b.pos = U.point_on_ellipse(center, 25, angle * i)
					b.bullet.from = V.vclone(b.pos)
					b.bullet.to = V.vclone(target and target.pos or this.pos)
					b.bullet.damage_min = missile_factor
					b.bullet.damage_max = missile_factor

					queue_insert(store, b)
				end
			end

			U.y_animation_wait(this)

			this.render.sprites[1].hidden = true

			U.y_wait(store, a.respawn_delay)

			this.render.sprites[1].hidden = nil

			S:queue(a.respawn_sound)
			U.y_animation_play(this, "respawn", nil, store.tick_ts, 1)

			this.health_bar.hidden = false
			this.health.ignore_damage = false
			w.hidden = nil
			this.world_eater_factor = this.world_eater_factor_min

			this:update_world_eater()
			SU.hero_gain_xp_from_skill(this, skill)
		end

		a = this.timed_attacks.list[1]
		skill = this.hero.skills.flap

		if not a.disabled and store.tick_ts - a.ts >= a.cooldown then
			local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans, function(e)
				return e.health.immune_to ~= DAMAGE_ALL or e.health.ignore_damage == false
			end)

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

					S:queue(a.sound)
					U.animation_start(this, "flap", flip, store.tick_ts)
					U.y_wait(store, a.shoot_time)

					local delay = 0
					local n_step = ni < s_ni and -2 or 2

					ni = km.clamp(1, #P:path(s_pi), ni < s_ni and ni + 6 or ni)

					for i = 1, a.count do
						local e = E:create_entity(a.bullet)

						e.pos.x, e.pos.y = this.pos.x + a.bullet_start_offset.x, this.pos.y + a.bullet_start_offset.y
						e.bullet.from = V.vclone(e.pos)
						e.bullet.to = P:node_pos(pi, spi, ni)
						e.bullet.source_id = this.id
						e.bullet.target_id = target.id

						queue_insert(store, e)

						ni = ni + n_step
						spi = km.zmod(spi + math.random(1, 2), 3)
					end

					U.y_animation_wait(this)

					a.ts = store.tick_ts

					SU.hero_gain_xp_from_skill(this, skill)
				end
			end
		end

		a = this.ranged.attacks[1]

		if store.tick_ts - a.ts >= a.cooldown then
			local origin = V.v(this.pos.x, this.pos.y + a.bullet_start_offset[1].y)
			local bullet_t = E:get_template(a.bullet)
			local bullet_speed = bullet_t.bullet.min_speed or 390
			local flight_time = bullet_t.bullet.flight_time or 3
			local target = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, false, a.vis_flags, a.vis_bans, function(v)
				local v_pos = v.pos

				if not v.nav_path then
					return false
				end

				local n_pos = P:node_pos(v.nav_path)

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
						break
					end

					coroutine.yield()
				end

				S:queue(a.sound)

				b = E:create_entity(a.bullet)
				b.bullet.target_id = target.id
				b.bullet.source_id = this.id
				b.pos.x = this.pos.x + (af and -1 or 1) * a.bullet_start_offset[ai].x
				b.pos.y = this.pos.y + a.bullet_start_offset[ai].y
				b.bullet.from = V.vclone(b.pos)
				b.bullet.to = V.v(t_pos.x + target.unit.hit_offset.x, t_pos.y + target.unit.hit_offset.y)

				queue_insert(store, b)

				a.ts = start_ts

				while not U.animation_finished(this) do
					if this.unit.is_stunned or this.health.dead or this.nav_rally and this.nav_rally.new then
						break
					end

					coroutine.yield()
				end
			end
		end

		SU.soldier_idle(store, this, force_idle_ts)
		SU.soldier_regen(store, this)
		coroutine.yield()
	end
end

scripts.world_eater = {}

function scripts.world_eater.update(this, store, script)
	local o = store.entities[this.owner_id]

	this.pos = o.pos

	while true do
		if not this.disabled and o.world_eater_factor < o.world_eater_factor_max then
			local dead_enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.health and v.health.dead and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - o.world_eater_delay and not v.world_eater and U.is_inside_ellipse(v.pos, this.pos, o.world_eater_range)
			end)

			if dead_enemies then
				for i, e in pairs(dead_enemies) do
					if o.world_eater_factor < o.world_eater_factor_max then
						e.world_eater = true

						if not this.hidden then
							local b = E:create_entity(this.decal)

							b.source_id = e.id
							b.target_id = this.owner_id

							queue_insert(store, b)
						end

						o.world_eater_factor = o.world_eater_factor + o.world_eater_factor_inc

						o:update_world_eater()
					else
						break
					end
				end
			end
		end

		coroutine.yield()
	end
end

scripts.decal_world_eater = {}

function scripts.decal_world_eater.update(this, store)
	local sp = this.render.sprites[1]
	local fm = this.force_motion
	local source = store.entities[this.source_id]
	local hero = store.entities[this.target_id]
	local initial_pos, initial_dest
	local initial_h = 0
	local dest_h = hero.unit.hit_offset.y
	local max_dist
	local last_pos = V.v(0, 0)

	local function move_step(dest)
		local dx, dy = V.sub(dest.x, dest.y, this.pos.x, this.pos.y)
		local dist = V.len(dx, dy)

		max_dist = math.max(dist, max_dist)

		local phase = km.clamp(0, 1, 1 - dist / max_dist)
		local df = (not fm.ramp_radius or dist > fm.ramp_radius) and 1 or math.max(dist / fm.ramp_radius, 0.1)

		fm.a.x, fm.a.y = V.add(fm.a.x, fm.a.y, V.trim(fm.max_a, V.mul(fm.a_step * df, dx, dy)))
		fm.v.x, fm.v.y = V.add(fm.v.x, fm.v.y, V.mul(store.tick_length, fm.a.x, fm.a.y))
		fm.v.x, fm.v.y = V.trim(fm.max_v, fm.v.x, fm.v.y)

		local sx, sy = V.mul(store.tick_length, fm.v.x, fm.v.y)

		this.pos.x, this.pos.y = V.add(this.pos.x, this.pos.y, sx, sy)
		fm.a.x, fm.a.y = V.mul(-0.05 / store.tick_length, fm.v.x, fm.v.y)
		sp.offset.y = SU.parabola_y(phase, initial_h, dest_h, fm.max_flight_height)
		sp.r = V.angleTo(this.pos.x - last_pos.x, this.pos.y + sp.offset.y - last_pos.y)
		last_pos.x, last_pos.y = this.pos.x, this.pos.y + sp.offset.y

		return dist < 2 * fm.max_v * store.tick_length
	end

	if not source or not hero then
		log.debug("source or hero entity not found for decal_world_eater")
	else
		sp.hidden = true
		this.pos.x, this.pos.y = source.pos.x, source.pos.y

		if source.unit and source.unit.hit_offset then
			initial_h = source.unit.hit_offset.y
		end

		sp.hidden = nil
		this.dest = hero.pos
		initial_pos = V.vclone(this.pos)
		initial_dest = V.vclone(hero.pos)
		fm.a.x, fm.a.y = 0, 2.5
		last_pos.x, last_pos.y = this.pos.x, this.pos.y + sp.offset.y
		max_dist = V.len(initial_dest.x - initial_pos.x, initial_dest.y - initial_pos.y)

		while not hero.health.dead and not move_step(this.dest) do
			coroutine.yield()
		end
	end

	queue_remove(store, this)
end

scripts.penumbra_blob = {}

scripts.penumbra_bullet = {}

function scripts.penumbra_bullet.remove(this, store)
	local blob = E:create_entity(this.bullet.hit_scripted)

	blob.pos = V.vclone(this.pos)
	blob.owner_id = this.bullet.source_id

	queue_insert(store, blob)

	return true
end

function scripts.penumbra_blob.update(this, store, script)
	U.animation_start(this, "idle", nil, store.tick_ts, 1)
	U.y_wait(store, this.duration)
	queue_remove(store, this)

	local explosion, bonnus = this.explosion
	local e = store.entities[this.owner_id]

	if e and V.dist(this.pos.x, this.pos.y, e.pos.x, e.pos.y) < this.max_range then
		explosion = this.explosion_big
		bonnus = (e.world_eater_factor - e.world_eater_factor_min) / e.world_eater_factor_inc

		if bonnus > 0 then
			e.world_eater_factor = e.world_eater_factor - e.world_eater_factor_inc

			e:update_world_eater()
		end
	end

	e = E:create_entity(explosion)
	e.pos = V.vclone(this.pos)
	e.source_id = this.owner_id
	e.damage_bonnus = bonnus

	queue_insert(store, e)
end

scripts.penumbra_explosion = {}

function scripts.penumbra_explosion.update(this, store, script)
	U.animation_start(this, "idle", nil, store.tick_ts, 1)

	local targets = U.find_enemies_in_range(store.entities, this.pos, 0, this.range, this.vis_flags, 0)

	if targets then
		for _, target in pairs(targets) do
			local d = E:create_entity("damage")

			d.damage_type = this.damage_type
			d.source_id = this.source_id
			d.target_id = target.id
			d.value = this.damage_bonnus and this.damage + this.damage_bonnus or this.damage

			queue_damage(store, d)
		end
	end

	U.y_animation_wait(this)
	queue_remove(store, this)
end

scripts.penumbra_missile = {}

function scripts.penumbra_missile.update(this, store, script)
	local b = this.bullet
	local target = store.entities[b.target_id]
	local mspeed = b.min_speed
	local rot_dir = 1
	local follow = false
	local max_seek_angle = b.max_seek_angle or 0.2
	local ps = E:create_entity(this.bullet.particles_name)

	ps.particle_system.track_id = this.id

	queue_insert(store, ps)

	ps.particle_system.emit = true

	if this.render.sprites[1].animated then
		U.animation_start(this, "flying", nil, store.tick_ts, -1)
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if b.rot_dir_from_long_angle and target then
			rot_dir = target.pos.x < this.pos.x and -1 or 1
		elseif b.speed.x < 0 then
			rot_dir = -1
		end

		coroutine.yield()
	end

	if not target or target.health and target.health.dead then
		local ref_pos = target and target.pos or this.pos

		target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)
	end

	if target then
		b.to.x, b.to.y = target.pos.x, target.pos.y

		if target.unit.hit_offset then
			b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
		end
	end

	while V.dist(this.pos.x, this.pos.y, b.to.x, b.to.y) > mspeed * store.tick_length do
		if not target or target.health and target.health.dead or band(target.vis.bans, b.vis_flags) ~= 0 then
			local ref_pos = target and target.pos or this.pos

			target = U.find_foremost_enemy(store.entities, ref_pos, 0, b.retarget_range, false, b.vis_flags)

			if b.rot_dir_from_long_angle and target then
				rot_dir = target.pos.x < this.pos.x and -1 or 1
			end
		end

		if target then
			b.to.x, b.to.y = target.pos.x, target.pos.y

			if target.unit.hit_offset then
				b.to.x, b.to.y = b.to.x + target.unit.hit_offset.x, b.to.y + target.unit.hit_offset.y
			end
		end

		local d_angle = V.angleTo(b.speed.x, b.speed.y, b.to.x - this.pos.x, b.to.y - this.pos.y)

		if max_seek_angle < math.abs(d_angle) then
			local rot = b.turn_speed * store.tick_length * rot_dir
			local dir = V.angleTo(b.speed.x, b.speed.y)

			if dir > math.pi / 3 and dir < 2 * math.pi / 3 then
				rot = rot * (b.turn_helicoidal_factor or 1.5)
			end

			b.speed.x, b.speed.y = V.rotate(rot, b.speed.x, b.speed.y)
		else
			mspeed = mspeed + 30 * math.ceil(mspeed * 0.03333333333333333 * b.acceleration_factor)
			mspeed = km.clamp(b.min_speed, b.max_speed, mspeed)
			b.speed.x, b.speed.y = V.mul(mspeed, V.normalize(b.to.x - this.pos.x, b.to.y - this.pos.y))
		end

		this.pos.x, this.pos.y = this.pos.x + b.speed.x * store.tick_length, this.pos.y + b.speed.y * store.tick_length
		this.render.sprites[1].r = V.angleTo(b.speed.x, b.speed.y)

		if ps then
			ps.particle_system.emit_direction = this.render.sprites[1].r
		end

		coroutine.yield()
	end

	if b.damage_radius and b.damage_radius > 0 then
		local enemies = table.filter(store.entities, function(k, v)
			return v.enemy and v.vis and v.unit and v.health and not v.health.dead and band(v.vis.flags, b.damage_bans) == 0 and band(v.vis.bans, b.damage_flags) == 0 and U.is_inside_ellipse(V.v(v.pos.x + v.unit.hit_offset.x, v.pos.y + v.unit.hit_offset.y), b.to, b.damage_radius)
		end)

		for _, enemy in pairs(enemies) do
			local enemy_pos = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			local d = E:create_entity("damage")

			d.source_id = this.id
			d.target_id = enemy.id
			d.damage_type = b.damage_type
			d.reduce_armor = b.reduce_armor
			d.reduce_magic_armor = b.reduce_magic_armor
			d.value = math.random(b.damage_min, b.damage_max)

			queue_damage(store, d)

			if b.mod then
				local mod = E:create_entity(b.mod)

				mod.modifier.target_id = enemy.id

				queue_insert(store, mod)
			end
		end
	elseif target then
		local d = SU.create_bullet_damage(b, target.id, this.id)

		queue_damage(store, d)

		if b.mod then
			local mod = E:create_entity(b.mod)

			mod.modifier.target_id = target.id

			queue_insert(store, mod)
		end
	end

	local fx

	if b.hit_fx_air and target and band(target.vis.flags, F_FLYING) ~= 0 then
		fx = b.hit_fx_air

		S:queue(this.sound_events.hit)
	elseif b.hit_fx_water and not target and band(GR:cell_type(b.to.x, b.to.y), TERRAIN_WATER) ~= 0 then
		fx = b.hit_fx_water

		S:queue(this.sound_events.hit_water)
	elseif b.hit_fx then
		fx = b.hit_fx

		S:queue(this.sound_events.hit)
	end

	if fx then
		local is_air = target and band(target.vis.flags, F_FLYING) ~= 0
		local sfx = E:create_entity(fx)

		if b.hit_fx_ignore_hit_offset and target and not is_air then
			sfx.pos.x, sfx.pos.y = target.pos.x, target.pos.y
		else
			sfx.pos.x, sfx.pos.y = this.pos.x, this.pos.y
		end

		sfx.render.sprites[1].ts = store.tick_ts

		queue_insert(store, sfx)
	end

	queue_remove(store, this)
end

scripts.decal_ra = {}

function scripts.decal_ra.update(this, store)
	local did_use = false

	U.animation_start(this, "idle", nil, store.tick_ts, true, 1)

	while true do
		if this.ui.clicked and not did_use then
			did_use = true

			U.animation_start(this, "click", nil, store.tick_ts, false, 1)
			AC:got(this.achievement_id)
		end

		coroutine.yield()
	end
end

scripts.decal_ka_hor = {}

function scripts.decal_ka_hor.update(this, store, script)
	local did_use = false

	while true do
		if this.ui.clicked and not did_use then
			did_use = true
			this.render.sprites[2].alpha = 255

			U.y_animation_play(this, "start", nil, store.tick_ts, false, 2)

			this.render.sprites[3].alpha = 255

			U.y_animation_play(this, "start", nil, store.tick_ts, false, 3)
			U.animation_start(this, "loop", nil, store.tick_ts, true, 3)

			local towers = table.filter(store.entities, function(_, e)
				return e.tower and e.tower.can_be_mod and not table.contains(this.excluded_templates, e.template_name)
			end)

			for i, tower in pairs(towers) do
				local new_mod = E:create_entity("mod_ka_hor")

				new_mod.modifier.level = 1
				new_mod.modifier.target_id = tower.id
				new_mod.modifier.source_id = this.id
				new_mod.pos = tower.pos

				queue_insert(store, new_mod)
			end

			if this.ui.clicked and #towers > 0 then
				AC:got(this.achievement_id)

				this.ui.clicked = nil
			end

			U.y_wait(store, 10)
			U.y_animation_play(this, "end", nil, store.tick_ts, false, 3)

			this.render.sprites[3].alpha = 0

			U.y_animation_play(this, "end", nil, store.tick_ts, false, 2)

			this.render.sprites[2].alpha = 0
		end

		coroutine.yield()
	end
end

scripts.mod_ka_hor = {}

function scripts.mod_ka_hor.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("cannot insert mod_ka_hor to entity %s - ", target.id, target.template_name)

		return false
	end

	if target.attacks or target.template_name == "tower_mech" then
		target.tower.damage_factor = target.tower.damage_factor + this.extra_damage * m.level
	end

	signal.emit("mod-applied", this, target)

	return true
end

function scripts.mod_ka_hor.update(this, store, script)
	this.ts = store.tick_ts

	while store.tick_ts - this.ts < this.duration - 0.5 do
		coroutine.yield()
	end

	U.y_wait(store, 0.5)
	queue_remove(store, this)
end

function scripts.mod_ka_hor.remove(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target and (target.attacks or target.template_name == "tower_mech") then
		target.tower.damage_factor = target.tower.damage_factor - this.extra_damage * m.level
	end

	return true
end

scripts.decal_sphinx = {}

function scripts.decal_sphinx.update(this, store, script)
	local idle_ts = store.tick_ts
	local cooldown_ts = store.tick_ts
	local idle_sid
	local extragold = 0
	local it = 0
	local t = {}
	local e
	local obelisks_silenced = 0
	local wins = 0
	local fresh_start = true

	local function move(e, d)
		local x = d.pos.x

		if x > e.pos.x then
			while x > e.pos.x do
				e.pos.x = e.pos.x + e.motion_max_speed
				e.pos.y = e.pos.y - e.motion_max_speed
				d.pos.x = d.pos.x - e.motion_max_speed
				d.pos.y = d.pos.y + e.motion_max_speed

				coroutine.yield()
			end
		else
			while x < e.pos.x do
				e.pos.x = e.pos.x - e.motion_max_speed
				e.pos.y = e.pos.y + e.motion_max_speed
				d.pos.x = d.pos.x + e.motion_max_speed
				d.pos.y = d.pos.y - e.motion_max_speed

				coroutine.yield()
			end
		end
	end

	local p = this.pos.x - E:get_template("decal_sphinx_item").size_x * this.count / 2

	for i = 1, this.count do
		e = E:create_entity("decal_sphinx_item")
		e.pos = V.v(p + e.size_x * i + e.offset_x, this.pos.y - e.size_y * i + e.offset_y)
		e.og_pos = V.vclone(e.pos)
		e.owner = this.id
		e.num = i

		queue_insert(store, e)
		table.insert(t, e)
	end

	this.times_selected = 0

	U.animation_start(this, "idle", nil, store.tick_ts, 1, 2)

	while true do
		if store.level_mode == GAME_MODE_IRON then
			this.iron_cooldown_ready = store.wave_group_number > 0 and (store.tick_ts - cooldown_ts > this.iron_cooldown or fresh_start)
		end

		if this.selected and (store.level_mode ~= GAME_MODE_IRON or this.iron_cooldown_ready) then
			if it == 0 then
				U.y_animation_play(t[this.selected], "select", nil, store.tick_ts, 1)
			end

			if it < this.draft[this.selected] then
				it = it + 1

				local i, tt = nil, {}

				e, i = table.random(t, this.count)

				for k, v in ipairs(t) do
					if k ~= i then
						table.insert(tt, v)
					end
				end

				move(e, table.random(tt, this.count))

				if it >= this.draft[this.selected] then
					this.submit = nil
				end
			elseif this.submit then
				U.y_animation_play(t[this.submit], "flip_up", nil, store.tick_ts, 1)

				if store.level_mode == GAME_MODE_IRON then
					cooldown_ts = store.tick_ts
					fresh_start = false
				end

				if this.submit == this.selected then
					if this.selected == 3 and store.level_mode == GAME_MODE_HEROIC then
						for i, e in ipairs(E:filter(store.entities, "doset_obelisk")) do
							queue_remove(store, e)
						end

						store.nobelisk = true
						this.heroic_obelisk_ready = false
						obelisks_silenced = store.wave_group_number

						S:queue("TotemSpirits", {
							gain = 0.75,
							delay = fts(64)
						})
						U.y_animation_play(t[this.selected], "win", nil, store.tick_ts, 1)
						U.y_animation_play(this, "win", nil, store.tick_ts, 1, 2)
					else
						S:queue("AssassinGold", {
							gain = 2,
							delay = fts(64)
						})

						if store.level_mode == GAME_MODE_HEROIC then
							extragold = t[this.selected].price * this.heroic_multiplier
						elseif store.level_mode == GAME_MODE_IRON then
							extragold = t[this.selected].price * this.iron_multiplier
						else
							extragold = t[this.selected].price * this.gold_multiplier
						end

						store.player_gold = store.player_gold + extragold

						U.y_animation_play(t[this.selected], "win", nil, store.tick_ts, 1)
						U.y_animation_play(this, "win", nil, store.tick_ts, 1, 2)

						if store.level_mode == GAME_MODE_CAMPAIGN then
							wins = wins + 1
						end
					end
				else
					U.y_wait(store, 1.5)
					U.y_animation_play(t[this.submit], "flip_down", nil, store.tick_ts, 1)
					S:queue("SphinxEHHH", {
						gain = 0.75,
						delay = fts(48)
					})
					U.y_animation_play(t[this.submit], "lose", nil, store.tick_ts, 1)
					U.y_animation_play(this, "lose", nil, store.tick_ts, 1, 2)
				end

				for _, v in ipairs(t) do
					v.pos = V.vclone(v.og_pos)
				end

				this.submit = nil
				this.selected = nil
				it = 0
			end
		elseif store.level_mode == GAME_MODE_HEROIC and store.wave_group_number > 0 and this.heroic_obelisk_ready then
			U.y_animation_play(this, "obelisk", nil, store.tick_ts, 1, 2)
		elseif store.level_mode == GAME_MODE_IRON and store.wave_group_number > 0 and this.iron_cooldown_ready then
			U.y_animation_play(this, "ready", nil, store.tick_ts, 1, 2)
		elseif this.idle_cooldown < store.tick_ts - idle_ts then
			idle_ts = store.tick_ts

			U.animation_start(this, math.random(1, 4) < 4 and "blink" or "brow", nil, store.tick_ts, 1, 2)
		elseif store.level_mode == GAME_MODE_HEROIC and store.wave_group_number > 0 and obelisks_silenced < store.wave_group_number then
			this.heroic_obelisk_ready = true
		elseif U.animation_finished(this) and not this.iron_cooldown_ready and not this.heroic_obelisk_ready then
			U.y_animation_play(this, "idle", nil, store.tick_ts, 1, 2)
		end

		if store.waves_finished and not LU.has_alive_enemies(store) and store.level_mode == GAME_MODE_CAMPAIGN then
			if wins == 15 then
				AC:got(this.achievement_id)
			elseif wins == 0 then
				AC:got(this.achievement_id2)
			end
		end

		coroutine.yield()
	end
end

scripts.decal_sphinx_item = {}

function scripts.decal_sphinx_item.update(this, store, script)
	local e = store.entities[this.owner]
	local cooldown_ts = store.tick_ts
	local price = store.level_mode == GAME_MODE_IRON and this.iron_price or this.price

	while true do
		if this.ui.clicked then
			this.ui.clicked = nil

			if e.selected then
				e.submit = this.num
			elseif store.level_mode == GAME_MODE_IRON and store.wave_group_number > 0 and e.iron_cooldown_ready or fresh_start or store.level_mode ~= GAME_MODE_IRON and store.wave_group_number > e.times_selected and price <= store.player_gold then
				e.times_selected = e.times_selected + 1
				e.selected = this.num
				store.player_gold = store.player_gold - price
			end

			S:queue("GUIButtonCommon")
		end

		coroutine.yield()
	end
end

scripts.enemy_primordial = {}

function scripts.enemy_primordial.insert(this, store, script)
	if not scripts.enemy_basic.insert(this, store, script) then
		return false
	end

	local a = E:create_entity("aura_primordial")

	a.owner_id = this.id

	queue_insert(store, a)

	return true
end

scripts.aura_primordial = {}

function scripts.aura_primordial.update(this, store, script)
	local o = store.entities[this.owner_id]

	this.pos = o.pos

	while true do
		if o.health.dead or not store.entities[this.owner_id] then
			break
		else
			local dead_enemies = table.filter(store.entities, function(k, v)
				return v.enemy and v.health and v.health.dead and store.tick_ts - v.health.death_ts >= v.health.dead_lifetime - this.delay and U.is_inside_ellipse(v.pos, this.pos, this.range) and not v.primordial_immortality and not table.contains(this.excluded_templates, v.template_name)
			end)

			if dead_enemies then
				for i, e in pairs(dead_enemies) do
					e.primordial_immortality = true

					local t

					t = E:create_entity(this.summon_name)
					t.render.sprites[1].name = "raise"
					t.pos = V.vclone(e.pos)
					t.enemy.gold = 0
					t.nav_path.pi = e.nav_path.pi
					t.nav_path.spi = e.nav_path.spi
					t.nav_path.ni = e.nav_path.ni

					queue_insert(store, t)

					local fx = E:create_entity("fx_spawn_fallen")

					fx.pos = V.vclone(e.pos)
					fx.render.sprites[1].ts = store.tick_ts

					queue_insert(store, fx)
				end
			end
		end

		coroutine.yield()
	end

	queue_remove(store, this)
end

scripts.enemy_sand_monk = {}

function scripts.enemy_sand_monk.update(this, store, script)
	local ta = this.timed_attacks.list[1]

	ta.ts = store.tick_ts

	local function ready_to_curse()
		if not this.enemy or not this.enemy.can_do_magic or not (store.tick_ts - ta.ts > ta.cooldown) then
			return false
		end

		local towers = table.filter(store.entities, function(_, e)
			local barrack_tower_exception = not e.barrack or table.contains(ta.allowed_templates, e.template_name)

			return not e.tower_holder and e.tower and barrack_tower_exception and e.tower.can_be_mod and not e.tower.blocked and U.is_inside_ellipse(e.pos, this.pos, ta.range)
		end)

		return #towers > 0
	end

	::label_406_0::

	while true do
		if this.health.dead then
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		elseif ready_to_curse() then
			ta.ts = store.tick_ts

			U.animation_start(this, ta.animation, nil, store.tick_ts, 1)

			while store.tick_ts - ta.ts < ta.shoot_time do
				if this.health.dead then
					goto label_406_0
				end

				if this.unit.is_stunned then
					goto label_406_0
				end

				coroutine.yield()
			end

			local towers = table.filter(store.entities, function(_, e)
				return not e.tower_holder and e.tower and e.tower.can_be_mod and not e.tower.blocked and e.attacks and U.is_inside_ellipse(e.pos, this.pos, ta.range)
			end)

			for e, tower in ipairs(towers) do
				local m = E:create_entity(ta.mod)

				m.modifier.target_id = tower.id
				m.modifier.source_id = this.id
				m.pos = tower.pos

				queue_insert(store, m)
			end

			if #towers > 0 then
				S:queue(ta.sound)
			end

			while not U.animation_finished(this) do
				coroutine.yield()
			end
		end

		if this.enemy then
			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, ready_to_curse, ready_to_curse) then
				-- block empty
			else
				coroutine.yield()
			end
		elseif this.soldier and this.soldier.moving then
			if not SU.y_soldier_mixed_walk_melee_ranged(store, this, false) then
				-- block empty
			else
				coroutine.yield()
			end
		elseif this.soldier and this.soldier.pet then
			while this.nav_rally.new do
				this.nav_grid.waypoints = GR:find_waypoints(this.pos, nil, this.nav_rally.pos, this.nav_grid.valid_terrains)

				if SU.y_hero_new_rally(store, this) then
					goto label_406_1
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_406_1
				end
			end

			if SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
			end
		end

		::label_406_1::

		coroutine.yield()
	end
end

local function scale_attack_value(container, key, factor)
	if not container then
		return
	end

	local value = container[key]

	if type(value) == "number" then
		container[key] = value * factor
	elseif type(value) == "table" then
		for index, item in pairs(value) do
			if type(item) == "number" then
				value[index] = item * factor
			end
		end
	end
end

scripts.mod_sand_monk = {}

function scripts.mod_sand_monk.insert(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("error inserting mod_sand_monk%s", this.id)

		return true
	end

	if this.range_factor and target.attacks then
		local primary_attack = target.attacks.list and target.attacks.list[1]

		scale_attack_value(primary_attack, "range", this.range_factor)
		scale_attack_value(target.attacks, "range", this.range_factor)
	end

	if this.cooldown_factor and target.attacks then
		local primary_attack = target.attacks.list and target.attacks.list[1]

		scale_attack_value(primary_attack, "cooldown", this.cooldown_factor)
		scale_attack_value(primary_attack, "cooldowns", this.cooldown_factor)
		scale_attack_value(target.attacks, "cooldown", this.cooldown_factor)
		scale_attack_value(target.attacks, "min_cooldown", this.cooldown_factor)
	end

	if this.render then
		for i = 1, #this.render.sprites do
			local s = this.render.sprites[i]

			s.ts = store.tick_ts
		end
	end

	return true
end

function scripts.mod_sand_monk.update(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		this.pos = target.pos
	end

	m.ts = store.tick_ts
	this.tween.ts = store.tick_ts

	U.y_animation_play(this, "start", nil, store.tick_ts, 1)
	U.animation_start(this, "idle", nil, store.tick_ts, true)

	while store.tick_ts - m.ts < m.duration - 0.5 do
		coroutine.yield()
	end

	U.animation_start(this, "end", nil, store.tick_ts, 1)

	this.tween.reverse = true
	this.tween.ts = store.tick_ts

	U.y_wait(store, 0.5)
	queue_remove(store, this)
end

function scripts.mod_sand_monk.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if not target or not target.tower then
		log.error("error removing mod_sand_monk%s", this.id)

		return false
	end

	if this.range_factor and target.attacks then
		local primary_attack = target.attacks.list and target.attacks.list[1]

		scale_attack_value(primary_attack, "range", 1 / this.range_factor)
		scale_attack_value(target.attacks, "range", 1 / this.range_factor)
	end

	if this.cooldown_factor and target.attacks then
		local primary_attack = target.attacks.list and target.attacks.list[1]

		scale_attack_value(primary_attack, "cooldown", 1 / this.cooldown_factor)
		scale_attack_value(primary_attack, "cooldowns", 1 / this.cooldown_factor)
		scale_attack_value(target.attacks, "cooldown", 1 / this.cooldown_factor)
		scale_attack_value(target.attacks, "min_cooldown", 1 / this.cooldown_factor)
	end

	return true
end

scripts.enemy_umbral_acolyte = {}

function scripts.enemy_umbral_acolyte.update(this, store, script)
	local ta = this.timed_attacks.list[1]

	ta.ts = store.tick_ts

	local function ready_to_cast()
		if this.enemy and this.enemy.can_do_magic and store.tick_ts - ta.ts > ta.cooldown then
			local target = table.filter(store.entities, function(_, e)
				return not e.pending_removal and e.enemy and e.vis and not table.contains(ta.excluded_templates, e.template_name) and e.nav_path and e.health and not e.health.dead and band(e.vis.flags, ta.vis_bans) == 0 and band(e.vis.bans, ta.vis_flags) == 0 and P:is_node_valid(e.nav_path.pi, e.nav_path.ni) and e.nav_path.ni > P:get_visible_start_node(e.nav_path.pi) + ta.path_margins[1] and e.nav_path.ni < P:get_defend_point_node(e.nav_path.pi) - ta.path_margins[2] and U.is_inside_ellipse(e.pos, this.pos, ta.range)
			end)

			return target[1] and true
		end

		return false
	end

	::label_413_0::

	while true do
		if this.health.dead then
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_cast() then
				ta.ts = store.tick_ts

				local target = table.filter(store.entities, function(_, e)
					return not e.pending_removal and e.enemy and e.vis and not table.contains(ta.excluded_templates, e.template_name) and e.nav_path and e.health and not e.health.dead and band(e.vis.flags, ta.vis_bans) == 0 and band(e.vis.bans, ta.vis_flags) == 0 and P:is_node_valid(e.nav_path.pi, e.nav_path.ni) and e.nav_path.ni > P:get_visible_start_node(e.nav_path.pi) + ta.path_margins[1] and e.nav_path.ni < P:get_defend_point_node(e.nav_path.pi) - ta.path_margins[2] and U.is_inside_ellipse(e.pos, this.pos, ta.range)
				end)[1]

				if not target then
					goto label_413_0
				end

				U.animation_start(this, ta.animation, nil, store.tick_ts, false)
				U.y_wait(store, fts(10))
				S:queue(ta.sound)

				local e = E:create_entity(ta.aura)
				local api, aspi = target.nav_path.pi, 1
				local ani = target.nav_path.ni + ta.nodes_offset

				log.debug("ta.nodes_offset: %s", ta.nodes_offset)

				e.nodes_offset = ta.nodes_offset
				ani = km.clamp(P:get_visible_start_node(api) + ta.path_margins[1], P:get_defend_point_node(api) - ta.path_margins[2], ani)
				e.pos = P:node_pos(api, aspi, ani)

				queue_insert(store, e)
				U.y_animation_wait(this)

				while not U.animation_finished(this) do
					coroutine.yield()
				end
			end

			if this.enemy then
				if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, ready_to_cast, ready_to_cast) then
					-- block empty
				else
					coroutine.yield()
				end
			elseif this.soldier and this.soldier.moving then
				if not SU.y_soldier_mixed_walk_melee_ranged(store, this, false) then
					-- block empty
				else
					coroutine.yield()
				end
			elseif this.soldier and this.soldier.pet then
				while this.nav_rally.new do
					this.nav_grid.waypoints = GR:find_waypoints(this.pos, nil, this.nav_rally.pos, this.nav_grid.valid_terrains)

					if SU.y_hero_new_rally(store, this) then
						goto label_413_1
					end
				end

				if this.melee then
					brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

					if brk or sta ~= A_NO_TARGET then
						goto label_413_1
					end
				end

				if this.ranged and not this.ranged.range_while_blocking then
					brk, sta = SU.y_soldier_ranged_attacks(store, this)

					if brk or sta == A_DONE then
						goto label_413_1
					elseif sta == A_IN_COOLDOWN and not this.ranged.go_back_during_cooldown then
						-- block empty
					end
				end

				if SU.soldier_go_back_step(store, this) then
					-- block empty
				else
					SU.soldier_idle(store, this)
				end
			end
		end

		::label_413_1::

		coroutine.yield()
	end
end

scripts.enemy_umbral_acolyte_teleport_aura = {}

function scripts.enemy_umbral_acolyte_teleport_aura.update(this, store)
	local start_ts = store.tick_ts
	local a = this.aura
	local function level_value(field, default)
		if type(field) == "table" then
			return field[store.level_difficulty] or field[#field] or default
		end

		return field or default
	end

	local duration = level_value(a.duration, 0)
	local radius = level_value(a.radius, 0)

	U.y_animation_play(this, "start", nil, store.tick_ts, 1)
	U.animation_start(this, "loop", nil, store.tick_ts, true)

	while store.tick_ts - start_ts < duration do
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, radius, a.vis_flags, a.vis_bans, function(e)
			return not table.contains(this.excluded_templates, e.template_name)
		end)

		if targets then
			for _, target in pairs(targets) do
				local m = E:create_entity(a.mod)

				log.debug("tping enemy")

				m.modifier.source_id = this.id
				m.modifier.target_id = target.id

				log.debug("m.nodes_offset: %s", m.nodes_offset)
				queue_insert(store, m)
			end
		end

		coroutine.yield()
	end

	U.y_animation_play(this, "end", nil, store.tick_ts, 1)
	queue_remove(store, this)
end

scripts.enemy_set = {}

function scripts.enemy_set.insert(this, store, script)
	if not scripts.enemy_basic.insert(this, store, script) then
		return false
	end

	local a = E:create_entity("aura_set")

	a.owner_id = this.id

	queue_insert(store, a)

	return true
end

function scripts.enemy_set.update(this, store)
	local a = this.timed_attacks.list[1]
	local sa = this.timed_attacks.list[2]
	local glowing_enemies = {}
	local count = 1
	local i = 0

	a.ts = store.tick_ts
	sa.ts = store.tick_ts

	local x_pos = {}
	local y_pos = {}

	local function ready_to_shield()
		return store.tick_ts - a.ts > a.cooldown
	end

	local function ready_to_spawn()
		return store.tick_ts - sa.ts > sa.cooldown
	end

	local function break_fn()
		return ready_to_spawn() or ready_to_shield()
	end

	local function get_shield_targets()
		return U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans, function(e)
			return e and not e.health.dead and table.contains(a.allowed_templates, e.template_name)
		end)
	end

	if this.render.sprites[1].name == "raise" then
		local next_pos

		if this.motion.forced_waypoint then
			next_pos = this.motion.forced_waypoint
		else
			next_pos = P:next_entity_node(this, store.tick_length)
		end

		local an, af = U.animation_name_facing_point(this, "raise", next_pos)

		U.y_animation_play(this, an, af, store.tick_ts, 1)
	end

	::label_420_0::

	while true do
		if this.health.dead then
			S:stop("SetSpellChannel")

			if this.phase == 1 then
				this.ui.can_click = false
				this.health.hp = this.health.hp_max
				this.health.dead = false

				S:stop_group("MUSIC")
				S:queue(this.sound_events.firstdeath)
				LU.kill_all_enemies(store, nil)

				local aura = LU.list_entities(store.entities, "aura_set_fire")[1]

				if aura then
					queue_remove(store, aura)
				end

				local aura2 = LU.list_entities(store.entities, "aura_set")[1]

				if aura2 then
					queue_remove(store, aura2)
				end

				this.health_bar.hidden = true
				this.health.ignore_damage = true

				local vis_bans = this.vis.bans
				local immunities = this.health.immune_to

				this.vis.bans = F_ALL

				SU.remove_modifiers(store, this)

				this.health.immune_to = DAMAGE_ALL

				U.cleanup_blockers(store, this)
				U.y_animation_play(this, "death", nil, store.tick_ts, 1)
				U.y_wait(store, 3)
				S:queue("MusicBossFightReBBBornHammerhold2")
				S:queue(this.sound_events.revive, {
					gain = 0.75,
					delay = fts(28)
				})
				U.y_animation_play(this, "raise", nil, store.tick_ts, 1)

				this.health_bar.hidden = false
				this.health.ignore_damage = false
				this.vis.bans = vis_bans
				this.health.immune_to = immunities

				local e = E:create_entity("aura_set_fire_2")

				e.pos = V.vclone(this.pos)
				e.aura.level = this.unit.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts

				queue_insert(store, e)

				local e2 = E:create_entity("aura_set")

				e2.owner_id = this.id

				queue_insert(store, e2)

				this.melee.attacks[1].damage_max = 240
				this.melee.attacks[1].damage_min = 180
				a.allowed_templates = {
					"enemy_fallen",
					"enemy_fallen",
					"enemy_immortal"
				}
				a.cooldown = 40
				sa.entity = "set_obelisk_2"
				this.phase = 2
				this.ui.can_click = true
			else
				S:stop("SetSpellChannel")
				S:stop_group("MUSIC")
				LU.kill_all_enemies(store, nil)
				SU.y_enemy_death(store, this)

				return
			end
		end

		if this.render.sprites[1].name == "raise" and this.sound_events and this.sound_events.raise then
			S:queue(this.sound_events.raise, this.sound_events.raise_args)
		end

		if this.unit.is_stunned then
			SU.y_enemy_stun(store, this)
		else
			if ready_to_spawn() then
				sa.ts = store.tick_ts

				local loops = sa.loops[km.zmod(count, #sa.loops)]

				i = 1
				count = count + 1
				x_pos = table.clone(sa.x_locations)
				y_pos = table.clone(sa.y_locations)

				while i <= loops do
					local roll = math.random(1, #x_pos)
					local e = E:create_entity(sa.entity)
					local nearest = P:nearest_nodes(x_pos[roll], y_pos[roll], nil, nil, true)
					local pi, spi, ni = unpack(nearest[1])

					e.pos.x = x_pos[roll]
					e.pos.y = y_pos[roll]
					e.spawner.pi = pi
					e.spawner.ni = ni
					e.spawner.duration = sa.duration

					queue_insert(store, e)
					table.remove(x_pos, roll)
					table.remove(y_pos, roll)

					i = i + 1
				end
			end

			if ready_to_shield() then
				local targets = get_shield_targets()

				if not targets then
					SU.delay_attack(store, a, 0.5)
				else
					a.ts = store.tick_ts

					U.animation_start(this, a.animations[1], nil, store.tick_ts, false)

					if SU.y_enemy_wait(store, this, a.cast_time) then
						goto label_420_0
					end

					targets = get_shield_targets()

					if targets then
						for _, target in ipairs(targets) do
							local m = E:create_entity(a.glow_mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
							table.insert(glowing_enemies, target)
						end
					end

					U.animation_start(this, a.animations[2], nil, store.tick_ts, true)
					S:queue(a.sound)

					-- Teleport stuns must leave the channel instead of retrying without yielding.
					if SU.y_enemy_wait(store, this, a.cast_time_2) then
						S:stop(a.sound)
						glowing_enemies = {}

						goto label_420_0
					end

					U.animation_start(this, a.animations[3], nil, store.tick_ts, false)

					if SU.y_enemy_wait(store, this, 0.1) then
						S:stop(a.sound)
						glowing_enemies = {}

						goto label_420_0
					end

					S:stop(a.sound)

					if glowing_enemies then
						for _, target in ipairs(glowing_enemies) do
							if target and not target.health.dead then
								local m = E:create_entity(a.mod)

								m.modifier.source_id = this.id
								m.modifier.target_id = target.id

								queue_insert(store, m)
							end
						end

						S:queue(a.sound2)
					end
				end
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, break_fn, break_fn) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end
end

scripts.set_obelisk = {}

function scripts.set_obelisk.update(this, store)
	local sp = this.spawner
	local start_ts = store.tick_ts
	local spawn_count = 0
	local sid = 1
	local entity

	this.tween.ts = store.tick_ts

	local i = 1

	U.y_animation_play(this, "start", nil, store.tick_ts, 1, sid)
	U.animation_start(this, "loop", nil, store.tick_ts, true, sid)

	while store.tick_ts - start_ts < sp.duration do
		if sp.interrupt then
			break
		end

		spawn_count = spawn_count + 1
		entity = sp.entities[km.zmod(i, #sp.entities)]

		local e = E:create_entity(entity)

		e.nav_path.pi = sp.pi
		e.nav_path.spi = math.random(1, 3)
		e.nav_path.ni = math.random(sp.ni - sp.node_range, sp.ni + sp.node_range)
		e.unit.spawner_id = this.id
		e.pos = P:node_pos(e.nav_path)
		e.render.sprites[1].name = "raise"
		e.enemy.gold = e.enemy.gold

		queue_insert(store, e)

		i = i + 1

		U.y_wait(store, U.frandom(sp.cycle_time_min, sp.cycle_time_max))
	end

	U.animation_start(this, "end", nil, store.tick_ts, false, sid)

	this.tween.ts = store.tick_ts
	this.tween.reverse = true
	this.tween.remove = true
end

scripts.mod_set_polymorph = {}

function scripts.mod_set_polymorph.insert(this, store, script)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local new_health

	if not target then
		return false
	end

	local pm = this.polymorph

	new_health = target.health.hp / target.health.hp_max

	local d = E:create_entity("damage")

	d.damage_type = bor(DAMAGE_EAT, DAMAGE_NO_LIFESTEAL)
	d.source_id = this.id
	d.target_id = target.id
	d.pop = pm.pop

	queue_damage(store, d)

	target.vis.bans = F_ALL

	if pm.hit_fx_sizes then
		local fx = E:create_entity(pm.hit_fx_sizes[target.unit.size])

		fx.pos = V.vclone(target.pos)

		if m.use_mod_offset then
			fx.pos.x, fx.pos.y = fx.pos.x + target.unit.mod_offset.x, fx.pos.y + target.unit.mod_offset.y
		end

		fx.render.sprites[1].ts = store.tick_ts
		fx.render.sprites[1].draw_order = 2

		queue_insert(store, fx)
	end

	local e_name = pm.custom_entity_names[target.template_name] or pm.custom_entity_names.default
	local e = E:create_entity(e_name)

	e.pos = V.vclone(target.pos)
	e.nav_path = table.deepclone(target.nav_path)
	e.health.hp = e.health.hp_max * new_health

	queue_insert(store, e)
	signal.emit("mod-applied", this, target)
	queue_remove(store, this)

	return true
end

scripts.mod_malagar_shield = {}

function scripts.mod_malagar_shield.insert(this, store)
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]
	local modifiers = table.filter(store.entities, function(k, v)
		return v.modifier and v.modifier.target_id == m.target_id and v.template_name == m.remove_on_entry
	end)

	if modifiers then
		queue_remove(store, modifiers[1])
	end

	if not target or not target.health or target.health.dead or target.cant_be_mod then
		return false
	end

	m.ts = store.tick_ts
	target.health.immune_to = m.protected_flags
	this._blood_color = target.unit.blood_color
	target.unit.blood_color = BLOOD_NONE
	target._shield_mod = this
	this.render.sprites[1].scale = this.render.sprites[1].size_scales[target.unit.size]

	return true
end

function scripts.mod_malagar_shield.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		if target.health.immune_to == m.protected_flags then
			target.health.immune_to = 0
		end

		target._shield_mod = nil
		target.unit.blood_color = this._blood_color
	end

	return true
end

scripts.mod_malagar_tower = {}

function scripts.mod_malagar_tower.update(this, store)
	local clicks = 0
	local s_tap = this.render.sprites[2]
	local target = store.entities[this.modifier.target_id]
	local twin_modifier = this.twin

	if not target then
		queue_remove(store, this)

		return
	end

	this.pos.x, this.pos.y = target.pos.x, target.pos.y

	U.y_animation_play(this, "appear", nil, store.tick_ts, 1, 1)

	s_tap.hidden = nil

	U.animation_start(this, "threat", nil, store.tick_ts, true, 1)
	SU.tower_block_inc(target)

	local hold_ts = store.tick_ts

	SU.ui_click_proxy_add(target, this)

	while clicks < this.required_clicks and twin_modifier.freed == false do
		if this.ui.clicked then
			S:queue(this.sound_click)

			this.ui.clicked = nil
			clicks = clicks + 1

			if clicks >= this.required_clicks then
				goto label_431_0
			end
		end

		coroutine.yield()
	end

	s_tap.hidden = true

	S:queue(this.sound_blocked)
	U.animation_start(this, "stun", nil, store.tick_ts, 1, 1)
	U.y_wait(store, this.duration)

	::label_431_0::

	this.freed = true

	SU.ui_click_proxy_remove(target, this)

	s_tap.hidden = true

	S:queue(this.sound_released)
	U.y_animation_play(this, "disappear", nil, store.tick_ts, 1, 1)
	SU.tower_block_dec(target)
	queue_remove(store, this)
end

scripts.eb_malagar = {}

function scripts.eb_malagar.get_info(this)
	return {
		type = STATS_TYPE_ENEMY,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = this.ranged.attacks[1].damage_min * this.unit.damage_factor,
		damage_max = this.ranged.attacks[1].damage_max * this.unit.damage_factor,
		armor = this.health.armor,
		magic_armor = this.health.magic_armor,
		lives = this.enemy.lives_cost
	}
end

function scripts.eb_malagar.on_damage(this, store, damage)
	if this.realshit then
		return false
	end

	if this.phase == "mid_level" then
		local pd = U.predict_damage(this, damage)

		if pd >= this.health.hp then
			this.firsttime = true
			this.phase_signal = true

			return false
		end
	elseif this.phase == "battle" then
		local pd = U.predict_damage(this, damage)

		if pd >= this.health.hp then
			this.phase_signal = true

			return false
		end
	end

	return true
end

function scripts.eb_malagar.update(this, store)
	local ba = this.timed_attacks.list[1]
	local idle_ba_animation = ba.animation
	local sa = this.timed_attacks.list[2]
	local ra = this.ranged.attacks[1]

	ra.ts = store.tick_ts
	sa.ts = store.tick_ts

	local taunt_ts
	local iteration = 1
	local initial_hp = this.health.hp_max
	local loop_count = 1

	local function y_taunt(idx, set)
		U.animation_start(this, "idle", nil, store.tick_ts, true)
		SU.y_show_taunt_set(store, this.taunts, set or this.phase, idx, nil, nil, true)
		U.y_animation_wait(this)
		U.animation_start(this, "idle", nil, store.tick_ts, true)
	end

	local function y_block_towers()
		local towers = table.filter(store.entities, function(_, e)
			return e.tower and e.tower.can_be_mod and not U.has_modifiers(store, e, ba.mod)
		end)

		if not towers or #towers < 2 then
			SU.delay_attack(store, ba, 0.5)

			return
		end

		local start_ts = store.tick_ts

		U.animation_start(this, ba.animation, nil, store.tick_ts)
		U.y_wait(store, ba.hit_time)
		S:queue(ba.sound)

		local random_towers = table.random_order(towers)
		local t = random_towers[1]
		local t2 = random_towers[2]

		if t2 and t then
			local n = E:create_entity(ba.mod)
			local m = E:create_entity(ba.mod)

			m.modifier.target_id = t.id
			m.modifier.source_id = this.id
			n.twin = m
			n.modifier.target_id = t2.id
			n.modifier.source_id = this.id
			m.twin = n

			queue_insert(store, m)
			queue_insert(store, n)
		end

		U.y_animation_wait(this)
		U.y_wait(store, ba.attack_duration - (store.tick_ts - start_ts))

		ba.ts = store.tick_ts

		if this.phase == "rest" then
			this.render.sprites[1].offset = v(0, 0)
			this.render.sprites[1].z = Z_OBJECTS
			this.health_bar.offset = v(0, 43)
			this.ui.click_rect = r(-18, 0, 32, 36)
			this.unit.hit_offset = v(0, 10)
			this.unit.mod_offset = v(0, 10)
			this.vis.flags = bor(F_ENEMY, F_BOSS)
		end
	end

	local function y_shield_allies()
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sa.max_range, sa.vis_flags, sa.vis_bans)

		if not targets then
			SU.delay_attack(store, sa, 0.5)
		else
			sa.ts = store.tick_ts

			U.animation_start(this, sa.animation, nil, store.tick_ts, false)
			S:queue(sa.sound)

			targets = U.find_enemies_in_range(store.entities, this.pos, 0, sa.max_range, sa.vis_flags, sa.vis_bans)

			if targets then
				local healed_count = 0

				for _, target in ipairs(targets) do
					if healed_count >= sa.max_count then
						break
					end

					local m = E:create_entity(sa.entities[km.zmod(iteration, #sa.entities)])

					m.modifier.source_id = this.id
					m.modifier.target_id = target.id

					queue_insert(store, m)

					healed_count = healed_count + 1
				end
			end

			U.y_animation_wait(this)

			iteration = iteration + 1
		end
	end

	local function signal_ready()
		return this.phase_signal
	end

	local function battle_started()
		return store.wave_group_number >= 1
	end

	local function ready_to_block()
		return not ba.disabled and store.tick_ts - ba.ts >= ba.cooldown
	end

	local function ready_to_shield()
		return store.tick_ts - sa.ts >= sa.cooldown
	end

	local function can_break_battle_walk()
		return ready_to_block() or this.phase_signal or ready_to_shield()
	end

	this.render.sprites[1].offset = v(0, 46)
	this.health_bar.offset = v(0, 90)
	this.ui.click_rect = r(-24, 56, 44, 33)
	this.unit.hit_offset = v(0, 69)
	this.unit.mod_offset = v(0, 75)
	this.phase_signal = nil
	this.phase_signal = nil

	while not this.phase_signal do
		coroutine.yield()
	end

	this.phase = "welcome"
	this.vis.flags = bor(F_ENEMY, F_BOSS)

	for i, d in ipairs(this.taunts.sets.welcome.delays) do
		if U.y_wait(store, d, battle_started) then
			break
		end

		y_taunt(i)
	end

	this.phase = "wait"

	local taunt_cooldown = math.random(this.taunts.sets.wait.delay_min, this.taunts.sets.wait.delay_max)

	taunt_ts = store.tick_ts

	while not battle_started() do
		if taunt_cooldown <= store.tick_ts - taunt_ts then
			y_taunt()

			taunt_ts = store.tick_ts
			taunt_cooldown = math.random(this.taunts.sets.wait.delay_min, this.taunts.sets.wait.delay_max)
		end

		coroutine.yield()
	end

	y_taunt(5)

	::label_434_0::

	this.phase = "rest"
	this.health.ignore_damage = true
	this.health.immune_to = DAMAGE_ALL

	if this.firsttime == true then
		S:queue(this.teleport_sound)

		this.render.sprites[1].hidden = true

		U.y_wait(store, fts(12))

		this.render.sprites[1].hidden = false
		this.pos = V.vclone(this.pos_castle)
	end

	log.debug("rest")
	log.debug(store.tick_ts)

	local last_lives = store.lives
	local last_wave

	this.render.sprites[1].offset = v(0, 46)
	ba.ts = store.tick_ts
	sa.ts = store.tick_ts
	taunt_ts = store.tick_ts
	taunt_cooldown = math.random(this.taunts.delay_min, this.taunts.delay_max)

	if this.firsttime == true then
		log.debug("hereeee")
		U.y_animation_play(this, "reappear", nil, store.tick_ts, 1)
	end

	this.health.hp_max = E:get_template("eb_malagar").health.hp_max
	this.health_bar.hidden = true
	this.health.hp = this.health.hp_max
	this.vis.bans = this.vis_bans_rest
	this.phase_signal = nil

	SU.remove_modifiers(store, this)

	ba.animation = idle_ba_animation

	U.y_animation_play(this, "idle", nil, store.tick_ts, 1)

	while not this.phase_signal do
		if store.wave_group_number ~= last_wave and not this.phase_signal then
			local ba_wave_data = ba.data[store.wave_group_number]

			ba.disabled = not ba_wave_data

			if not ba.disabled then
				ba.cooldown = ba_wave_data and ba_wave_data[1] or 0
				ba.count = ba_wave_data and ba_wave_data[2] or 0
			end

			last_wave = store.wave_group_number
		end

		if store.wave_group_number ~= last_wave and not this.phase_signal then
			local ba_wave_data = ba.data[store.wave_group_number]

			ba.disabled = not ba_wave_data

			if not ba.disabled then
				ba.cooldown = ba_wave_data and ba_wave_data[1] or 0
				ba.count = ba_wave_data and ba_wave_data[2] or 0
			end

			last_wave = store.wave_group_number
		end

		if taunt_cooldown <= store.tick_ts - taunt_ts and not this.phase_signal then
			y_taunt(nil, last_lives > store.lives and "damage" or nil)

			last_lives = store.lives
			taunt_ts = store.tick_ts
			taunt_cooldown = math.random(this.taunts.delay_min, this.taunts.delay_max)
		end

		coroutine.yield()
	end

	this.phase = "mid_level"
	this.render.sprites[1].offset = v(0, 46)

	local battle_ts = store.tick_ts

	ra.bullet = this.mid_level.ranged_bullet
	sa.cooldown = this.mid_level.sa_cooldown
	sa.max_count = this.mid_level.sa_max_count
	sa.animation = this.mid_level.sa_animation
	ba.animation = this.mid_level.ba_animation
	ba.cooldown = this.mid_level.ba_cooldown
	ba.disabled = false
	ba.count = this.mid_level.ba_count
	this.health.hp_max = E:get_template("eb_malagar_clone").health.hp_max
	this.health.hp = E:get_template("eb_malagar_clone").health.hp_max
	this.vis.flags = bor(F_ENEMY, F_BOSS, F_FLYING)

	log.debug(this.health.hp)
	U.y_wait(store, fts(24))

	this.nav_path.pi, this.nav_path.spi, this.nav_path.ni = this.mid_level.pi[loop_count], 1, 1

	if store.wave_group_number ~= this.last_wave then
		this.pos = P:node_pos(this.nav_path)
	end

	sa.ts = store.tick_ts
	ba.ts = store.tick_ts

	if store.wave_group_number ~= this.last_wave then
		U.y_animation_play(this, "teleport", nil, store.tick_ts, 1)
		S:queue(this.teleport_sound)

		this.vis.bans = this.vis_bans
		this.health.ignore_damage = false
		this.health_bar.hidden = nil
		this.health.immune_to = 0
		this.phase_signal = nil
		this.auras.list[1].name = "aura_empty_nil"

		U.y_animation_play(this, "cloud_forming", nil, store.tick_ts, 1)
	end

	if store.wave_group_number == this.last_wave then
		this.phase_signal = true
	end

	while not this.phase_signal do
		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_block() and not this.phase_signal then
				y_block_towers()
			end

			if ready_to_shield() and not this.phase_signal then
				y_shield_allies()
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, can_break_battle_walk, can_break_battle_walk) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end

	if this.phase == "mid_level" and store.wave_group_number ~= this.last_wave then
		U.y_animation_play(this, "reappear", nil, store.tick_ts, false)

		loop_count = loop_count + 1
		store.player_gold = store.player_gold + this.enemy.gold

		goto label_434_0
	end

	this.phase = "pre_battle"

	local battle_ts = store.tick_ts

	sa.cooldown = this.battle.sa_cooldown
	sa.max_count = this.battle.sa_max_count
	sa.animation = this.battle.sa_animation
	ba.animation = this.battle.ba_animation
	this.health.hp_max = E:get_template("eb_malagar").health.hp_max
	this.health.hp = this.health.hp_max
	ra.bullet = this.battle.ranged_bullet

	U.y_wait(store, fts(24))
	y_taunt()
	U.y_wait(store, battle_ts + fts(115) - store.tick_ts)
	U.y_wait(store, fts(30))

	this.vis.bans = this.vis_bans
	this.nav_path.pi, this.nav_path.spi, this.nav_path.ni = 8, 2, 1

	log.debug("catt")

	sa.ts = store.tick_ts
	ba.ts = store.tick_ts
	this.health.ignore_damage = false
	this.health.immune_to = 0
	this.health_bar.hidden = nil
	this.phase_signal = nil
	this.phase = "battle"
	this.pos = P:node_pos(this.nav_path)
	this.render.sprites[1].offset = v(0, 46)
	this.health_bar.offset = v(0, 90)
	this.ui.click_rect = r(-24, 56, 44, 33)
	this.unit.hit_offset = v(0, 69)
	this.unit.mod_offset = v(0, 75)

	S:queue("MusicBossFightReBBBornHammerhold")
	S:queue(this.teleport_sound)
	U.y_animation_play(this, "teleport", nil, store.tick_ts, 1)
	U.y_animation_play(this, "cloud_forming", nil, store.tick_ts, 1)

	local spawner_aura = E:create_entity("malagar_spawner_aura")

	spawner_aura.aura.source_id = this.id

	queue_insert(store, spawner_aura)

	while not this.phase_signal do
		if this.unit.is_stunned then
			U.animation_start(this, "idle", nil, store.tick_ts, -1)
			coroutine.yield()
		else
			if ready_to_block() and not this.phase_signal then
				y_block_towers()
			end

			if ready_to_shield() and not this.phase_signal then
				y_shield_allies()
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, can_break_battle_walk, can_break_battle_walk) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end

	this.realshit = true
	this.vis.bans = F_ALL

	SU.remove_modifiers(store, this)
	U.y_animation_play(this, "death", nil, store.tick_ts, 1)

	this.render.sprites[1].hidden = true
	this.health_bar.hidden = true
	this.ui.can_click = false
	this.cant_be_mod = true
	this.phase = "death"

	local music_seek
	local music_sources = S.active_sources and S.active_sources.MUSIC

	if music_sources then
		for _, active_source in ipairs(music_sources) do
			if active_source.source then
				music_seek = active_source.source:tell()

				break
			end
		end
	end

	S:stop_group("MUSIC")
	S:queue("MusicBossFightReBBBornHammerhold2", music_seek and {seek = music_seek} or nil)

	local clones, ts = {}, store.tick_ts

	while #clones < 4 do
		if store.tick_ts - ts >= fts(30) then
			ts = store.tick_ts

			local e = E:create_entity("eb_malagar_clone")

			e.nav_path.pi, e.nav_path.spi, e.nav_path.ni = #clones % 2 == 0 and 7 or 8, 1, #clones * 15 + 25
			e.pos = P:node_pos(e.nav_path)

			queue_insert(store, e)
			table.insert(clones, e)
		end

		coroutine.yield()
	end

	log.debug("STARTED WITH " .. #clones .. " CLONES")

	while #clones > 0 do
		for i = #clones, 1, -1 do
			if clones[i].health.dead then
				table.remove(clones, i)
				log.debug("CLONE DIED, REMAINING: " .. #clones)
			end
		end

		coroutine.yield()
	end

	LU.kill_all_enemies(store, true)

	this.dying = true

	LU.kill_all_enemies(store, true)

	this.health_bar.hidden = true
	this.health.ignore_damage = true
	this.ui.can_click = false
	this.vis.bans = U.flag_set(this.vis.bans, F_ALL)
	this.phase = "death-end"

	S:queue(this.sound_events.death)
	signal.emit("boss-killed", this)
	queue_remove(store, this)
end

scripts.eb_malagar_clone = {}

function scripts.eb_malagar_clone.get_info(this)
	return {
		type = STATS_TYPE_ENEMY,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = this.ranged.attacks[1].damage_min * this.unit.damage_factor,
		damage_max = this.ranged.attacks[1].damage_max * this.unit.damage_factor,
		armor = this.health.armor,
		magic_armor = this.health.magic_armor,
		lives = this.enemy.lives_cost
	}
end

function scripts.eb_malagar_clone.update(this, store)
	local ba = this.timed_attacks.list[1]
	local sa = this.timed_attacks.list[2]
	local ra = this.ranged.attacks[1]

	ra.ts = store.tick_ts
	sa.ts = store.tick_ts

	local taunt_ts
	local iteration = 1
	local initial_hp = this.health.hp_max
	local spawned_yet = false

	if not spawned_yet then
		S:queue(this.sound_events.death)
		U.y_animation_play(this, "raise", nil, store.tick_ts, 1)

		spawned_yet = true
	end

	local function y_block_towers()
		local towers = table.filter(store.entities, function(_, e)
			return e.tower and e.tower.can_be_mod and not U.has_modifiers(store, e, ba.mod)
		end)

		if not towers or #towers < 2 then
			SU.delay_attack(store, ba, 0.5)

			return
		end

		local start_ts = store.tick_ts

		U.animation_start(this, ba.animation, nil, store.tick_ts)
		U.y_wait(store, ba.hit_time)
		S:queue(ba.sound)

		local random_towers = table.random_order(towers)
		local t = random_towers[1]
		local t2 = random_towers[2]

		if t2 and t then
			local n = E:create_entity(ba.mod)
			local m = E:create_entity(ba.mod)

			m.modifier.target_id = t.id
			m.modifier.source_id = this.id
			n.twin = m
			n.modifier.target_id = t2.id
			n.modifier.source_id = this.id
			m.twin = n

			queue_insert(store, m)
			queue_insert(store, n)
		end

		U.y_animation_wait(this)
		U.y_wait(store, ba.attack_duration - (store.tick_ts - start_ts))

		ba.ts = store.tick_ts

		if this.phase == "castle" then
			U.animation_start(this, "idleDown", nil, store.tick_ts, true)
		end
	end

	local function y_shield_allies()
		local targets = U.find_enemies_in_range(store.entities, this.pos, 0, sa.max_range, sa.vis_flags, sa.vis_bans)

		if not targets then
			SU.delay_attack(store, sa, 0.5)
		else
			sa.ts = store.tick_ts

			U.animation_start(this, sa.animation, nil, store.tick_ts, false)
			S:queue(sa.sound)

			targets = U.find_enemies_in_range(store.entities, this.pos, 0, sa.max_range, sa.vis_flags, sa.vis_bans)

			if targets then
				local healed_count = 0

				for _, target in ipairs(targets) do
					if healed_count >= sa.max_count then
						break
					end

					local m = E:create_entity(sa.entities[km.zmod(iteration, #sa.entities)])

					m.modifier.source_id = this.id
					m.modifier.target_id = target.id

					queue_insert(store, m)

					healed_count = healed_count + 1
				end
			end

			U.y_animation_wait(this)

			iteration = iteration + 1
		end
	end

	local function ready_to_block()
		return not ba.disabled and store.tick_ts - ba.ts >= ba.cooldown
	end

	local function ready_to_shield()
		return store.tick_ts - sa.ts >= sa.cooldown
	end

	local function can_break_battle_walk()
		return ready_to_block() or this.phase_signal or ready_to_shield()
	end

	while true do
		if this.health.dead then
			SU.y_enemy_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.y_enemy_stun(store, this)
		else
			if ready_to_shield() then
				y_shield_allies()
			end

			if ready_to_block() then
				y_block_towers()
			end

			if not SU.y_enemy_mixed_walk_melee_ranged(store, this, false, can_break_battle_walk, can_break_battle_walk) then
				-- block empty
			else
				coroutine.yield()
			end
		end
	end
end

scripts.hero_zezitra = {}

function scripts.hero_zezitra.possession_damage(this, store, attack, target)
	attack.cooldown = math.ceil(target.health.hp_max * 0.05)

	return 0
end

function scripts.hero_zezitra.get_info(this)
	local b = E:get_template(this.ranged.attacks[1].bullet)
	local minr, maxr = b.bullet.damage_min, b.bullet.damage_max
	local a = this.melee.attacks[1]
	local min, max = a.damage_min, a.damage_max
	local immune_armor = band(this.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1
	local immune_magic = band(this.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		ranged_damage_min = minr,
		ranged_damage_max = maxr,
		ranged_damage_icon = this.info.ranged_damage_icon or this.info.damage_icon,
		ranged_damage_type = b.bullet.damage_type,
		-- Keep the Rebborn aliases for any imported code that still reads them.
		damage_min_ranged = minr,
		damage_max_ranged = maxr,
		damage_icon_ranged = this.info.damage_icon,
		damage_type_ranged = b.bullet.damage_type,
		damage_icon = this.info.damage_icon,
		armor = this.health.armor,
		damage_type = a.damage_type,
		immune_armor = immune_armor,
		immune_magic = immune_magic,
		magic_armor = this.health.magic_armor,
		respawn = this.health.dead_lifetime,
		no_ranged = false,
		yes_melee = true
	}
end

function scripts.hero_zezitra.insert(this, store)
	this.hero.fn_level_up(this, store, true)

	this.melee.order = U.attack_order(this.melee.attacks)
end

function scripts.hero_zezitra.level_up(this, store, initial)
	local hl = this.hero.level
	local ls = this.hero.level_stats

	this.health.hp_max = ls.hp_max[hl]
	this.regen.health = ls.regen_health[hl]
	this.health.armor = ls.armor[hl]
	this.melee.attacks[1].damage_min = ls.melee_damage_min[hl]
	this.melee.attacks[1].damage_max = ls.melee_damage_max[hl]

	local s, sl, a, e

	s = E:get_template(this.ranged.attacks[1].bullet)
	s.bullet.level = hl
	s.bullet.damage_min = s.bullet.damage_min_levels[hl]
	s.bullet.damage_max = s.bullet.damage_max_levels[hl]
	s = this.hero.skills.wormtongue
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.melee.attacks[2]

		a.disabled = false
		a.level = sl
	end

	s = this.hero.skills.double_shadow
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[1]

		a.disabled = false
		a.cooldown = s.cooldown[sl]
		a.max_count = s.max_count[sl]

		local mod = E:get_template(a.mod)

		mod.shield_ignore_hits = s.shield_ignore_hits[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_zezitra.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		a = this.melee.attacks[2]

		if store.tick_ts - a.ts >= a.cooldown and not a.disabled then
			this.render.sprites[2].hidden = false
		else
			this.render.sprites[2].hidden = true
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_hero_new_rally(store, this) then
					goto label_456_0
				end
			end

			a = this.timed_attacks.list[1]
			skill = this.hero.skills.double_shadow

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local triggers = U.find_soldiers_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans, function(e)
					return not U.has_modifiers(store, e, a.mod)
				end)

				if not triggers or #triggers < a.min_count and not function(e)
					return not U.has_modifiers(store, e, a.mod)
				end then
					SU.delay_attack(store, a, 0.13333333333333333)
				else
					local start_ts = store.tick_ts
					local shielded_count = 0

					S:queue(a.sound)
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if SU.y_hero_wait(store, this, a.shoot_time) then
						-- block empty
					else
						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, a.range, a.vis_flags, a.vis_bans, function(e)
							return not U.has_modifiers(store, e, a.mod)
						end)

						if not targets then
							-- block empty
						else
							a.ts = start_ts

							SU.hero_gain_xp_from_skill(this, skill)

							local mod = E:create_entity(a.mod)

							mod.modifier.target_id = this.id
							mod.modifier.source_id = this.id
							mod.modifier.level = skill.level

							queue_insert(store, mod)

							for _, e in pairs(targets) do
								if shielded_count >= a.max_count then
									break
								end

								shielded_count = shielded_count + 1

								local mod = E:create_entity(a.mod)

								mod.modifier.target_id = e.id
								mod.modifier.source_id = this.id
								mod.modifier.level = skill.level

								queue_insert(store, mod)
							end

							SU.y_hero_animation_wait(this)

							goto label_456_0
						end
					end
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

		::label_456_0::

		coroutine.yield()
	end
end

scripts.mod_possession_pet = {}

function scripts.mod_possession_pet.update(this, store)
	local function add_fx(target, pos)
		local fx = E:create_entity(this.fx)

		if not fx then
			return
		end

		local s = fx.render.sprites[1]

		s.ts = store.tick_ts

		if s.size_scales and target.unit then
			s.scale = s.size_scales[target.unit.size]
		end

		fx.pos = V.vclone(pos)

		if target.unit and target.unit.hit_offset then
			fx.pos.x, fx.pos.y = fx.pos.x + target.unit.hit_offset.x, fx.pos.y + target.unit.hit_offset.y
		end

		queue_insert(store, fx)
	end

	local hero = store.entities[this.modifier.source_id]
	local m = this.modifier
	local target = store.entities[m.target_id]
	local attack = hero and hero.melee and hero.melee.attacks and hero.melee.attacks[2]

	if not attack or not target or not target.health or target.health.dead or not target.vis or not target.enemy or not target.nav_path or band(target.vis.bans, F_RAGGIFY) ~= 0 then
		queue_remove(store, this)

		return
	else
		attack.cooldown = this.cooldown_base + math.ceil(target.health.hp_max * this.cooldown_factor)
	end

	local rally_pos = V.vclone(target.pos)
	local nav = target.nav_path
	local rally_ni = math.max(P:get_start_node(nav.pi), nav.ni - 10)

	if P:is_node_valid(nav.pi, rally_ni) then
		rally_pos = P:node_pos(nav.pi, nav.spi, rally_ni)
	end

	target.vis.bans = U.flag_set(target.vis.bans, F_RAGGIFY)

	add_fx(target, target.pos)
	SU.remove_modifiers(store, target, nil, "mod_possession_pet")
	SU.remove_auras(store, target)
	queue_remove(store, target)

	target.health.dead = true
	target.main_script.co = nil
	target.main_script.runs = 0

	U.unblock_all(store, target)

	if target.ui then
		target.ui.can_click = false
	end

	if target.count_group then
		target.count_group.in_limbo = true
	end

	local e = E:clone_entity(target)

	E:add_comps(e, "soldier", "nav_grid", "nav_rally", "idle_flip")

	if e.timed_attacks then
		for i = 1, #e.timed_attacks.list do
			local target_attack = target.timed_attacks and target.timed_attacks.list[i]

			if e.timed_attacks.list[i] and e.timed_attacks.list[i].generation and target_attack then
				e.timed_attacks.list[i].generation = target_attack.count
			end
		end
	end

	e.pos = V.vclone(target.pos)
	e.nav_rally.pos = V.vclone(rally_pos)
	e.nav_rally.center = V.vclone(rally_pos)
	e.nav_rally.new = true
	e.owner = hero
	e.source_id = this.id
	e.combat_stats_source_id = hero.id
	e.motion.max_speed = 60

	if e.melee and e.melee.attacks then
		e.melee.range = 64

		for i = 1, #e.melee.attacks do
			e.melee.attacks[i].vis_flags = U.flag_set(e.melee.attacks[i].vis_flags, F_BLOCK)

			if not e.melee.attacks[i].sound then
				e.melee.attacks[i].sound = "KRVGenericCombat"
			end

			if U.flag_has(e.melee.attacks[i].vis_bans, F_ENEMY) then
				e.melee.attacks[i].vis_bans = U.flag_clear(e.melee.attacks[i].vis_bans, F_ENEMY)
			end
		end
	end

	e.possessed = true
	e.health.dead = false
	e.main_script.insert = scripts.soldier_possessed_pet.insert
	e.main_script.update = scripts.soldier_possessed_pet.update
	e.main_script.co = nil
	e.main_script.runs = 1

	if e.ui then
		e.ui.can_click = true
	end

	e.vis.flags = U.flag_clear(e.vis.flags, F_ENEMY)
	e.vis.flags = U.flag_set(e.vis.flags, F_FRIEND)
	e.enemy = nil
	e.nav_path = nil
	e.soldier.pet = true
	e.soldier.melee_slot_offset = V.v(5, 0)

	local sid = #e.render.sprites + 1

	e.render.sprites[sid] = E:clone_c("sprite")
	e.render.sprites[sid].animated = true
	e.render.sprites[sid].loop = true
	e.render.sprites[sid].ignore_start = true
	e.render.sprites[sid].ts = store.tick_ts
	e.render.sprites[sid].runs = 0
	e.render.sprites[sid].ignore_flip = true
	e.render.sprites[sid].anchor.y = target.anchor_y or 0.2
	e.render.sprites[sid].name = "idle"
	e.render.sprites[sid].prefix = "spectres_possession_effect"
	e.render.sprites[sid].scale = v(0.7, 0.7)
	e.render.sprites[sid].offset = v(0, 10)
	e.render.sprites[sid].color = {
		255,
		0,
		0,
		50
	}

	if e.unit and (e.unit.size == UNIT_SIZE_MEDIUM or e.unit.size == UNIT_SIZE_LARGE) then
		e.render.sprites[sid].scale = v(1, 1)
		e.render.sprites[sid].offset = v(-3, 20)
	end

	queue_insert(store, e)

	if not e.auras then
		E:add_comps(e, "auras")
	end

	local aid = #e.auras.list + 1

	e.auras.list[aid] = E:clone_c("aura_attack")
	e.auras.list[aid].name = "aura_possessed_pet_degeneration"
	e.auras.list[aid].cooldown = 0

	attack.pets = attack.pets or {}

	for i = #attack.pets, 1, -1 do
		if not attack.pets[i] or not attack.pets[i].nav_rally then
			table.remove(attack.pets, i)
		end
	end

	if #attack.pets >= attack.pets_max and attack.pets[1] then
		attack.pets[1].replaced = true
	end

	table.insert(attack.pets, e)

	while e and not e.health.dead and e.health.hp > 0 and not e.replaced and hero and not hero.health.dead do
		coroutine.yield()
	end

	if e and not e.health.dead and e.health.hp > 0 then
		local nodes = P:nearest_nodes(e.pos.x, e.pos.y)

		if #nodes > 0 then
			target.nav_path.ni = nodes[1][3] + 1
			target.nav_path.pi = nodes[1][1]
		end

		target.pos = V.vclone(e.pos)
		target.main_script.runs = 1
		target.health.dead = false
		target.health.hp = e.health.hp

		if target.ui then
			target.ui.can_click = true
		end

		if target.count_group then
			target.count_group.in_limbo = nil
		end

		if target.timed_attacks then
			for i = 1, #target.timed_attacks.list do
				local pet_attack = e.timed_attacks and e.timed_attacks.list[i]

				if target.timed_attacks.list[i] and target.timed_attacks.list[i].generation and pet_attack then
					target.timed_attacks.list[i].generation = pet_attack.count
				end
			end
		end

		target.vis.bans = U.flag_clear(target.vis.bans, F_RAGGIFY)

		add_fx(target, e.pos)

		local id = table.keyforobject(attack.pets, e)

		if id then
			table.remove(attack.pets, id)
		end

		SU.remove_modifiers(store, e, nil, "mod_possession_pet")
		SU.remove_auras(store, e)
		queue_remove(store, e)

		target.unit.damage_factor = 1

		queue_insert(store, target)
	else
		local bounty = target.enemy and target.enemy.gold or 0

		if bounty > 0 then
			store.player_gold = store.player_gold + bounty
			signal.emit("got-enemy-gold", target, bounty)
		end
	end

	queue_remove(store, this)
end

scripts.aura_possessed_pet_degeneration = {}

function scripts.aura_possessed_pet_degeneration.update(this, store)
	local start_ts = store.tick_ts

	while true do
		local target = store.entities[this.aura.source_id]

		if not target or target.health.dead then
			queue_remove(store, this)

			return
		end

		local regen_cooldown = this.regen.cooldown
		local regen_duration = this.duration
		local regen_health

		if (this.regen.ignore_stun or not target.unit.is_stunned) and (this.regen.ignore_freeze or not U.has_modifier_types(store, target, MOD_TYPE_FREEZE)) and (this.regen.ignore_mods or not U.flag_has(target.vis.bans, F_MOD)) and regen_cooldown <= store.tick_ts - this.aura.ts and target.health.hp >= target.health.hp_max * this.threshold then
			this.aura.ts = store.tick_ts

			if regen_duration <= store.tick_ts - start_ts then
				regen_health = target.health.hp_max * this.factor_end
			else
				regen_health = target.health.hp_max * this.factor_start
			end

			if target.health.hp - regen_health < target.health.hp_max * this.threshold then
				target.health.hp = target.health.hp_max * this.threshold
			else
				target.health.hp = target.health.hp - regen_health
				target.health.hp = km.clamp(0, target.health.hp_max, target.health.hp)
			end
		end

		coroutine.yield()
	end
end

scripts.soldier_possessed_pet = {}

function scripts.soldier_possessed_pet.get_info(this)
	local t = scripts.soldier_reinforcement.get_info(this)

	return t
end

function scripts.soldier_possessed_pet.on_damage(this, store, damage)
	log.debug(" SOLDIER_POSSESSED DAMAGE:%s type:%x", damage.value, damage.damage_type)

	if this.dodge and this.dodge.chance > 0 then
		local ca = this.dodge
		local target = store.entities[this.soldier.target_id]

		if not target or target.health.dead or not this.dodge or this.unit.is_stunned or this.health.dead or math.random() <= ca.chance or band(damage.damage_type, DAMAGE_ALL_TYPES, bnot(bor(DAMAGE_PHYSICAL, DAMAGE_MAGICAL))) ~= 0 or band(damage.damage_type, DAMAGE_NO_DODGE) ~= 0 then
			return true
		end

		log.debug("(%s)soldier_possessed dodged damage %s of type %s", this.id, damage.value, damage.damage_type)

		this.dodge.active = true

		return false
	end

	if this.render.sprites[1].prefix == "enemy_lycan" then
		if this.unit.is_stunned then
			return true
		end

		local h = this.health
		local predicted_damage = U.predict_damage(this, damage)
		local threshold = this.lycan_trigger_factor * h.hp_max

		if not h.dead and band(damage.damage_type, bor(DAMAGE_EAT, DAMAGE_DISINTEGRATE)) == 0 and threshold >= h.hp - predicted_damage then
			local m = E:create_entity("mod_lycanthropy_pos")

			m.modifier.target_id = this.id
			m.modifier.source_id = this.id
			m.spawn_hp = math.max(1, h.hp - predicted_damage) + m.extra_health
			m.spawn_hp_max = h.hp_max + m.extra_health
			m.active = true
			m.moon.transform_name = this.moon.transform_name

			queue_insert(store, m)

			h.on_damage = nil

			return false
		else
			return true
		end
	end

	return true
end

function scripts.soldier_possessed_pet.insert(this, store, script)
	this.melee.order = U.attack_order(this.melee.attacks)
	this.health.hp_max = this.health.hp_max + (this.health.hp_inc or 0) * (this.unit.level or 0)

	if this.auras then
		for _, a in pairs(this.auras.list) do
			if a.cooldown == 0 then
				local e = E:create_entity(a.name)

				e.pos = V.vclone(this.pos)
				e.aura.level = this.unit.level
				e.aura.source_id = this.id
				e.aura.ts = store.tick_ts

				queue_insert(store, e)
			end
		end
	end

	return true
end

function scripts.soldier_possessed_pet.update(this, store)
	local attack = this.melee.attacks[1]
	local target
	local expired = false
	local next_pos = V.vclone(this.pos)
	local brk, sta, star, nearest
	local ta = this.timed_attacks.list[1]
	local tac = this.timed_attacks.list[2]
	local orc = 0
	local spider = 0
	local coward = false
	local coward_ts = 0
	local shield = false
	local cg = store.count_groups[tac.count_group_type]
	local modifier = store.entities[this.source_id]

	if this.render.sprites[1].prefix == "enemy_fallen_knight" or this.render.sprites[1].prefix == "enemy_orc_rider" or this.render.sprites[1].prefix == "enemy_hobgoblin_rider" then
		orc = 1
	end

	if (this.render.sprites[1].prefix == "enemy_spider" or this.render.sprites[1].prefix == "enemy_sarelgaz_small") and store.level_difficulty == 4 then
		spider = 1
	end

	if this.render.sprites[1].prefix == "enemy_cursed_golem" then
		spider = 1
	end

	tac.ts = store.tick_ts
	ta.ts = store.tick_ts

	local function enable_shield()
		if not shield then
			shield = true

			SU.armor_inc(this, 0.7)
		end
	end

	local function disable_shield()
		if shield then
			shield = false

			SU.armor_dec(this, 0.7)
		end
	end

	local function do_death_spawns_orc(store, this)
		if this.death_spawns.fx then
			local fx = E:create_entity(this.death_spawns.fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			if this.death_spawns.fx_flip_to_source and this.render and this.render.sprites[1] then
				fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x
			end

			queue_insert(store, fx)
		end

		for i = 1, this.death_spawns.quantity do
			local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)
			local pi, spi, ni = unpack(nodes[1])
			local no
			local e_spi, e_ni = math.random(1, 3), ni

			no = 0

			if P:is_node_valid(pi, e_ni + no) then
				e_ni = e_ni + no
			end

			local s = E:create_entity(this.death_spawns.name)

			s.pos = V.vclone(this.pos)
			s.nav_rally.center = this.nav_rally.center
			s.nav_rally.pos = V.vclone(s.nav_rally.center)
			s.owner = this

			if this.death_spawns.spawn_animation and s.render then
				s.render.sprites[1].name = this.death_spawns.spawn_animation
			end

			if s.render and s.render.sprites[1] and this.render and this.render.sprites[1] then
				s.render.sprites[1].flip_x = this.render.sprites[1].flip_x
			end

			if this.death_spawns.offset then
				s.pos.x = s.pos.x + this.death_spawns.offset.x
				s.pos.y = s.pos.y + this.death_spawns.offset.y
			end

			queue_insert(store, s)
		end
	end

	local function do_death_spawns_spider(store, this)
		if this.death_spawns.fx then
			local fx = E:create_entity(this.death_spawns.fx)

			fx.pos = V.vclone(this.pos)
			fx.render.sprites[1].ts = store.tick_ts

			if this.death_spawns.fx_flip_to_source and this.render and this.render.sprites[1] then
				fx.render.sprites[1].flip_x = this.render.sprites[1].flip_x
			end

			queue_insert(store, fx)
		end

		local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)
		local pi, spi, ni = unpack(nodes[1])
		local no
		local e_spi, e_ni = math.random(1, 3), ni

		no = 0

		if P:is_node_valid(pi, e_ni + no) then
			e_ni = e_ni + no
		end

		for i = 1, this.death_spawns.quantity do
			local s = E:create_entity(this.death_spawns.name)

			s.pos = V.vclone(this.pos)

			if i == 1 then
				s.nav_rally.center = V.v(this.nav_rally.center.x + 7, this.nav_rally.center.y)
			elseif i == 4 then
				s.nav_rally.center = V.v(this.nav_rally.center.x - 7, this.nav_rally.center.y)
			elseif i == 3 then
				s.nav_rally.center = V.v(this.nav_rally.center.x, this.nav_rally.center.y + 7)
			else
				s.nav_rally.center = V.v(this.nav_rally.center.x, this.nav_rally.center.y - 7)
			end

			s.nav_rally.pos = V.vclone(s.nav_rally.center)
			s.owner = this

			if this.death_spawns.spawn_animation and s.render then
				s.render.sprites[1].name = this.death_spawns.spawn_animation
			end

			if s.render and s.render.sprites[1] and this.render and this.render.sprites[1] then
				s.render.sprites[1].flip_x = this.render.sprites[1].flip_x
			end

			if this.death_spawns.offset then
				s.pos.x = s.pos.x + this.death_spawns.offset.x + i
				s.pos.y = s.pos.y + this.death_spawns.offset.y + i
			end

			queue_insert(store, s)
		end
	end

	local function y_poss_walk_waypoints(store, this, animation)
		local animation = animation or "walk"
		local r = this.nav_rally
		local n = this.nav_grid
		local dest = r.pos

		while not V.veq(this.pos, dest) do
			local w = table.remove(n.waypoints, 1) or dest
			local unsnap = #n.waypoints > 0

			U.set_destination(this, w)

			local an, af = U.animation_name_facing_point(this, animation, this.motion.dest)

			U.animation_start(this, an, af, store.tick_ts, true)

			while not this.motion.arrived do
				if this.health.dead and not this.health.ignore_damage then
					return true
				end

				if r.new then
					return false
				end

				if this.replaced then
					if this.health.hp > 0 then
						this.hp_before_replacement = this.health.hp
					end

					local id = table.keyforobject(this.owner.melee.attacks[2].pets, this)

					if id then
						table.remove(this.owner.melee.attacks[2].pets, id)
					end

					this.health.hp = 0
					if modifier then
						modifier.pos_finished = true
					end

					queue_remove(store, this)

					return
				end

				U.walk(this, store.tick_length, nil, unsnap)
				coroutine.yield()

				this.motion.speed.x, this.motion.speed.y = 0, 0
			end
		end
	end

	local function y_poss_new_rally(store, this)
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

			local out = y_poss_walk_waypoints(store, this)

			U.animation_start(this, "idle", nil, store.tick_ts, true)

			this.vis.bans = vis_bans
			this.health.immune_to = prev_immune

			return out
		end
	end

	local function summon_count_exceeded()
		return cg[tac.count_group_name] and cg[tac.count_group_name] >= tac.count_group_max
	end

	if this.render.sprites[1].prefix == "enemy_demon_legion" then
		tac.count = tac.generation < 2 and tac.generation or 2
	end

	::label_467_0::

	while true do
		if this.health.dead then
			this.health.hp = 0

			local id = table.keyforobject(this.owner.melee.attacks[2].pets, this)

			if id then
				table.remove(this.owner.melee.attacks[2].pets, id)
			end

			local can_spawn = this.death_spawns and band(this.health.last_damage_types, bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS, this.death_spawns.no_spawn_damage_types or 0)) == 0

			if orc == 1 then
				do_death_spawns_orc(store, this)
				coroutine.yield()

				can_spawn = false
			end

			if spider == 1 then
				do_death_spawns_spider(store, this)
				coroutine.yield()

				can_spawn = false
			end

			if orc == 0 and can_spawn and this.death_spawns.concurrent_with_death then
				SU.do_death_spawns(store, this)
				coroutine.yield()

				can_spawn = false
			end

			SU.y_soldier_death(store, this)
			queue_remove(store, this)

			return
		end

		if this.owner.health.dead then
			this.replaced = true
		end

		if this.replaced then
			if this.health.hp > 0 then
				this.hp_before_replacement = this.health.hp
			end

			this.health.hp = 0

			local id = table.keyforobject(this.owner.melee.attacks[2].pets, this)

			if id then
				table.remove(this.owner.melee.attacks[2].pets, id)
			end

			if modifier then
				modifier.pos_finished = true
			end

			queue_remove(store, this)

			return
		end

		if this.unit.is_stunned then
			if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
				disable_shield()
			end

			SU.soldier_idle(store, this)
		else
			if U.get_blocked(store, this) and this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
				disable_shield()
			end

			if this.dodge and this.dodge.active then
				this.dodge.active = false

				if this.dodge.counter_attack and this.powers[this.dodge.counter_attack.power_name].level > 0 then
					this.dodge.counter_attack_pending = true
				elseif this.dodge.animation then
					U.animation_start(this, this.dodge.animation, nil, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end
				end

				signal.emit("soldier-dodge", this)
			end

			while this.nav_rally.new do
				this.nav_grid.waypoints = GR:find_waypoints(this.pos, nil, this.nav_rally.pos, this.nav_grid.valid_terrains)

				if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
					enable_shield()
				end

				if this.replaced then
					if this.health.hp > 0 then
						this.hp_before_replacement = this.health.hp
					end

					local id = table.keyforobject(this.owner.melee.attacks[2].pets, this)

					if id then
						table.remove(this.owner.melee.attacks[2].pets, id)
					end

					this.health.hp = 0
					if modifier then
						modifier.pos_finished = true
					end

					queue_remove(store, this)

					return
				end

				if y_poss_new_rally(store, this) then
					if this.replaced then
						if this.health.hp > 0 then
							this.hp_before_replacement = this.health.hp
						end

						local id = table.keyforobject(this.owner.melee.attacks[2].pets, this)

						if id then
							table.remove(this.owner.melee.attacks[2].pets, id)
						end

						this.health.hp = 0
						if modifier then
							modifier.pos_finished = true
						end

						queue_remove(store, this)

						return
					end

					goto label_467_1
				end
			end

			if (this.render.sprites[1].prefix == "enemy_shaman" or this.render.sprites[1].prefix == "enemy_munra") and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return e.health.hp < e.health.hp_max
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return e.health.hp < e.health.hp_max
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)

							healed_count = healed_count + 1
						end
					end

					U.y_animation_wait(this)
				end
			end

			if this.render.sprites[1].prefix == "enemy_cursed_shaman" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return e.render.sprites[1].prefix ~= "enemy_cursed_shaman"
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return e.render.sprites[1].prefix ~= "enemy_cursed_shaman"
					end)

					if targets then
						local healed_count = 0

						for _, target in ipairs(targets) do
							if healed_count >= ta.max_count then
								break
							end

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)

							healed_count = healed_count + 1

							if not U.has_modifiers(store, target, "mod_cursed_shield") then
								local b = E:create_entity("mod_cursed_shield")

								b.modifier.source_id = this.id
								b.modifier.target_id = target.id

								queue_insert(store, b)
							end
						end
					end

					U.y_animation_wait(this)
				end
			end

			if this.render.sprites[1].prefix == "enemy_demon_mage" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser"
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					U.animation_start(this, ta.animation, nil, store.tick_ts, false)
					S:queue(ta.sound)

					if SU.y_enemy_wait(store, this, ta.cast_time) then
						goto label_467_0
					end

					targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
						return e.render.sprites[1].prefix == "enemy_demon" or e.render.sprites[1].prefix == "enemy_demon_wolf" or e.render.sprites[1].prefix == "enemy_demon_flareon" or e.render.sprites[1].prefix == "enemy_demon_legion" or e.render.sprites[1].prefix == "enemy_demon_gulaemon" or e.render.sprites[1].prefix == "enemy_rotten_lesser"
					end)

					if targets then
						local shielded_count = 0

						for _, target in ipairs(targets) do
							if shielded_count >= ta.max_count then
								break
							end

							shielded_count = shielded_count + 1

							local m = E:create_entity(ta.mod)

							m.modifier.source_id = this.id
							m.modifier.target_id = target.id

							queue_insert(store, m)
						end
					end

					if SU.y_enemy_animation_wait(this) then
						goto label_467_0
					end
				end
			end

			if this.render.sprites[1].prefix == "enemy_demon_legion" and tac.count > 0 and store.tick_ts - tac.ts > tac.cooldown then
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, tac, 0.4)
				else
					U.animation_start(this, tac.animation, nil, store.tick_ts)

					if SU.y_soldier_wait(store, this, tac.spawn_time) then
						goto label_467_0
					end

					local pi, spi, ni = unpack(nodes[1])
					local no_min, no_max = unpack(tac.spawn_offset_nodes)
					local no
					local e = E:create_entity(tac.entity)
					local e_spi, e_ni = math.random(1, 3), ni

					no = math.random(no_min, no_max) * U.random_sign()

					if P:is_node_valid(pi, e_ni + no) then
						e_ni = e_ni + no
					end

					e._summoned = true
					e.health.hp = this.health.hp
					e.render.sprites[1].name = "raise"
					e.timed_attacks.list[1].generation = tac.generation - 1
					e.nav_rally.center = P:node_pos(pi, e_spi, e_ni)
					e.nav_rally.pos = V.vclone(e.nav_rally.center)
					e.pos = V.vclone(e.nav_rally.center)

					queue_insert(store, e)
					SU.y_enemy_animation_wait(this)

					tac.ts = store.tick_ts
					tac.count = tac.count - 1
					tac.cooldown = tac.cooldown_after
				end
			end

			if not U.get_blocked(store, this) and this.render.sprites[1].prefix == "enemy_troll_chieftain" and this.timed_attacks and store.tick_ts - ta.ts > ta.cooldown then
				local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
					return (e.render.sprites[1].prefix == "enemy_troll" or e.render.sprites[1].prefix == "enemy_troll_axe_thrower" or e.render.sprites[1].prefix == "enemy_troll_brute" or e.render.sprites[1].prefix == "enemy_troll_skater") and not U.has_modifier_in_list(store, e, ta.exclude_with_mods) and not U.has_modifier_types(store, e, MOD_TYPE_SLOW)
				end)

				if not targets then
					SU.delay_attack(store, ta, 0.5)
				else
					ta.ts = store.tick_ts

					for i = 1, ta.loops do
						U.animation_start(this, ta.animation, nil, store.tick_ts, false)

						if SU.y_enemy_wait(store, this, ta.cast_time) then
							goto label_467_0
						end

						S:queue(ta.cast_sound)

						local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, ta.max_range, ta.vis_flags, ta.vis_bans, function(e)
							return (e.render.sprites[1].prefix == "enemy_troll" or e.render.sprites[1].prefix == "enemy_troll_axe_thrower" or e.render.sprites[1].prefix == "enemy_troll_brute" or e.render.sprites[1].prefix == "enemy_troll_skater") and not U.has_modifier_in_list(store, e, ta.exclude_with_mods) and not U.has_modifier_types(store, e, MOD_TYPE_SLOW)
						end)

						if targets then
							local raged_count = 0

							for _, target in ipairs(targets) do
								if raged_count >= ta.max_count then
									break
								end

								raged_count = raged_count + 1

								for _, name in pairs(ta.mods) do
									local m = E:create_entity(name)

									m.modifier.source_id = this.id
									m.modifier.target_id = target.id

									queue_insert(store, m)
								end
							end
						end

						U.y_animation_wait(this)
					end
				end
			end

			if not U.get_blocked(store, this) and this.render.sprites[1].prefix == "enemy_necromancer" and this.timed_attacks and store.tick_ts - tac.ts > tac.cooldown and not summon_count_exceeded() then
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, tac, 0.4)
				else
					U.animation_start(this, tac.animation, nil, store.tick_ts, 1)
					S:queue(tac.sound, tac.sound_args)

					if SU.y_enemy_wait(store, this, tac.cast_time) then
						goto label_467_0
					end

					tac.ts = store.tick_ts

					local pi, spi, ni = unpack(nodes[1])
					local no_min, no_max = unpack(tac.nodes_offset)
					local no

					for i = 1, tac.count do
						local e

						if i ~= 1 and summon_count_exceeded() then
							break
						end

						if math.random() < 0.05 then
							e = E:create_entity(tac.entity2)
						else
							e = E:create_entity(tac.entity)
						end

						local e_spi, e_ni = math.random(1, 3), ni

						no = math.random(no_min, no_max) * U.random_sign()

						if P:is_node_valid(pi, e_ni + no) then
							e_ni = e_ni + no
						end

						e.nav_rally.center = P:node_pos(pi, e_spi, e_ni)
						e.nav_rally.pos = V.vclone(e.nav_rally.center)
						e.pos = V.vclone(e.nav_rally.center)
						e.render.sprites[1].name = "raise"
						e.owner = this

						E:add_comps(e, "count_group")

						e.count_group.name = tac.count_group_name
						e.count_group.type = tac.count_group_type

						queue_insert(store, e)
					end

					SU.y_enemy_animation_wait(this)

					goto label_467_0
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
						disable_shield()
					end

					goto label_467_1
				elseif this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
					enable_shield()
				end
			end

			if this.ranged then
				brk, star = SU.y_soldier_ranged_attacks(store, this)

				if brk or star == A_DONE then
					-- block empty
				elseif star == A_IN_COOLDOWN then
					-- block empty
				end
			end

			if SU.soldier_go_back_step(store, this) then
				if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
					enable_shield()
				end
			else
				if this.render.sprites[1].prefix == "enemy_hobgoblin_shield" then
					disable_shield()
				end

				SU.soldier_idle(store, this)
			end
		end

		::label_467_1::

		coroutine.yield()
	end
end

scripts.soldier_demon_legion_pos = {}

function scripts.soldier_demon_legion_pos.update(this, store, script)
	local brk, sta

	if this.vis._bans then
		this.vis.bans = this.vis._bans
		this.vis._bans = nil
	end

	if this.render.sprites[1].name == "raise" then
		this.health_bar.hidden = true

		U.animation_start(this, "raise", nil, store.tick_ts, 1)

		while not U.animation_finished(this) and not this.health.dead do
			coroutine.yield()
		end

		if not this.health.dead then
			this.health_bar.hidden = nil
		end
	end

	local a = this.timed_attacks.list[1]

	local function ready_to_clone()
		return not U.get_blocked(store, this) and a.count > 0 and store.tick_ts - a.ts >= a.cooldown
	end

	a.count = a.generation
	a.ts = store.tick_ts

	while true do
		if not this.health.dead or SU.y_soldier_revive(store, this) then
			-- block empty
		else
			if band(this.health.last_damage_types, bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS, this.death_spawns.no_spawn_damage_types or 0)) == 0 then
				SU.do_death_spawns(store, this)
				coroutine.yield()
			end

			SU.y_soldier_death(store, this)

			return
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				if SU.y_soldier_new_rally(store, this) then
					goto label_483_0
				end
			end

			if ready_to_clone() then
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y, nil, nil, nil, NF_RALLY)

				if #nodes < 1 then
					SU.delay_attack(store, a, 0.4)
				else
					U.animation_start(this, a.animation, nil, store.tick_ts)

					if SU.y_soldier_wait(store, this, a.spawn_time) then
						goto label_483_0
					end

					local pi, spi, ni = unpack(nodes[1])
					local no_min, no_max = unpack(a.spawn_offset_nodes)
					local no
					local e = E:create_entity(a.entity)
					local e_spi, e_ni = math.random(1, 3), ni

					no = math.random(no_min, no_max) * U.random_sign()

					if P:is_node_valid(pi, e_ni + no) then
						e_ni = e_ni + no
					end

					e._summoned = true
					e.health.hp = this.health.hp
					e.render.sprites[1].name = "raise"
					e.timed_attacks.list[1].generation = a.generation - 1
					e.nav_rally.center = P:node_pos(pi, e_spi, e_ni)
					e.nav_rally.pos = V.vclone(e.nav_rally.center)
					e.pos = V.vclone(e.nav_rally.center)

					queue_insert(store, e)
					SU.y_enemy_animation_wait(this)

					a.ts = store.tick_ts
					a.count = a.count - 1
					a.cooldown = a.cooldown_after
				end
			end

			if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

				if brk or sta ~= A_NO_TARGET then
					goto label_483_0
				end
			end

			if SU.soldier_go_back_step(store, this) then
				-- block empty
			else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
			end
		end

		::label_483_0::

		coroutine.yield()
	end
end

scripts.mod_lycanthropy_pos = {}

function scripts.mod_lycanthropy_pos.insert(this, store)
	local source = store.entities[this.modifier.source_id]
	local target = store.entities[this.modifier.target_id]

	if not target or target.health.dead then
		log.debug("TARGET NOT FOUND OR DEAD")

		return false
	end

	if band(this.modifier.vis_flags, target.vis.bans) ~= 0 or band(this.modifier.vis_bans, target.vis.flags) ~= 0 then
		log.debug("VIS BANS OR FLAGS MISMATCH")

		return false
	end

	return true
end

function scripts.mod_lycanthropy_pos.update(this, store)
	while true do
		log.debug("START TRANSFORMATION")

		local target = store.entities[this.modifier.target_id]

		if not target or target.health.dead then
			queue_remove(store, this)

			return
		end

		S:queue(this.sound_events.transform)

		local e = E:create_entity(this.moon.transform_name)

		e.health.hp = this.spawn_hp or e.health.hp
		e.health.hp_max = this.spawn_hp_max or e.health.hp_max
		e.pos = V.vclone(target.pos)
		e.nav_rally.center = V.vclone(target.nav_rally and target.nav_rally.center or target.pos)
		e.nav_rally.pos = V.vclone(target.nav_rally and target.nav_rally.pos or e.nav_rally.center)
		e.owner = target.owner
		e.source_id = target.source_id
		e.combat_stats_source_id = target.owner and target.owner.id or target.combat_stats_source_id
		e.possessed = true
		e.soldier.pet = true
		e.soldier.melee_slot_offset = V.vclone(target.soldier.melee_slot_offset)
		e.unit.level = target.unit.level
		e.main_script.insert = scripts.soldier_possessed_pet.insert
		e.main_script.update = scripts.soldier_possessed_pet.update
		e.render.sprites[1].name = "raise"
		e.render.sprites[1].flip_x = target.render.sprites[1].flip_x

		for i = 2, #target.render.sprites do
			e.render.sprites[i] = table.deepclone(target.render.sprites[i])
		end

		if e.owner and e.owner.melee and e.owner.melee.attacks[2].pets then
			local pet_index = table.keyforobject(e.owner.melee.attacks[2].pets, target)

			if pet_index then
				e.owner.melee.attacks[2].pets[pet_index] = e
			end
		end

		queue_insert(store, e)

		local d = E:create_entity("damage")

		d.damage_type = DAMAGE_EAT
		d.source_id = this.id
		d.target_id = target.id

		queue_damage(store, d)
		queue_remove(store, this)

		return coroutine.yield()
	end
end

scripts.mod_zezitra_shield = {}

function scripts.mod_zezitra_shield.insert(this, store)
	local m = this.modifier
	local target = store.entities[this.modifier.target_id]

	if not target or not target.health or target.health.dead then
		return false
	end

	m.ts = store.tick_ts
	target.health.on_damage = scripts.mod_zezitra_shield.on_damage
	this._hits = 0
	this._hit_sources = {}
	this._blood_color = target.unit.blood_color
	target.unit.blood_color = BLOOD_NONE
	target._shield_mod = this

	return true
end

function scripts.mod_zezitra_shield.remove(this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
		target.health.on_damage = nil
		target._shield_mod = nil
		target.unit.blood_color = this._blood_color
	end

	return true
end

function scripts.mod_zezitra_shield.on_damage(this, store, damage)
	local mod = this._shield_mod

	mod._hits = mod._hits + 1

	if U.flag_has(damage.damage_type, bor(DAMAGE_DISINTEGRATE, DAMAGE_DISINTEGRATE_BOSS, DAMAGE_EAT, DAMAGE_IGNORE_SHIELD)) then
		queue_remove(store, mod)

		return true
	end

	if mod._hits >= mod.shield_ignore_hits then
		queue_remove(store, mod)
	end

	return false
end

scripts.hero_deadeye = {}

function scripts.hero_deadeye.get_info(this)
	local a = this.timed_attacks.list[1]
	local b = E:get_template(a.bullet)
	local min, max = this.melee.attacks[1].damage_min, this.melee.attacks[1].damage_max
	local minr, maxr = b.bullet.damage_min, b.bullet.damage_max
	local damage_type_ranged = b.bullet.damage_type
	local immune_armor = band(this.health.immune_to, DAMAGE_PHYSICAL) ~= 0 and 1
	local immune_magic = band(this.health.immune_to, DAMAGE_MAGICAL) ~= 0 and 1

	return {
		type = STATS_TYPE_SOLDIER,
		hp = this.health.hp,
		hp_max = this.health.hp_max,
		damage_min = min,
		damage_max = max,
		ranged_damage_min = minr,
		ranged_damage_max = maxr,
		ranged_damage_type = damage_type_ranged,
		ranged_damage_icon = this.info.ranged_damage_icon or this.info.damage_icon,
		-- Keep the Rebborn aliases for any imported code that still reads them.
		damage_min_ranged = minr,
		damage_max_ranged = maxr,
		damage_type_ranged = damage_type_ranged,
		damage_type = b.bullet.damage_type,
		damage_icon_ranged = this.info.damage_icon,
		armor = this.health.armor,
		respawn = this.health.dead_lifetime,
		immune = this.health.immune_to == DAMAGE_ALL_TYPES,
		immune_armor = immune_armor,
		magic_armor = this.health.magic_armor,
		immune_magic = immune_magic,
		no_ranged = false,
		yes_melee = true
	}
end

function scripts.hero_deadeye.level_up(this, store)
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

	s = this.hero.skills.shotgun
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[2]

		a.disabled = false

		local b = E:get_template("bullet_deadeye_shotgun")

		b.bullet.damage_min = s.damage_min[sl]
		b.bullet.damage_max = s.damage_max[sl]
		b.bullet.xp_gain_factor = s.xp_gain_factor[sl]
		E:get_template("mod_shotgun_bullets").duration = s.stun_duration[sl]

		-- The hero room calls level_up with an empty preview store. The bullet
		-- magazine is a runtime entity and must only be created in a real level.
		if store and store.entities and not U.has_modifiers(store, this, "mod_shotgun_bullets") then
			local m = E:create_entity("mod_shotgun_bullets")

			m.target_id = this.id
			m.source_id = this.id
			this.test = 1

			queue_insert(store, m)
		end
	end

	s = this.hero.skills.bounty
	sl = rebborn_hero_skill_level(s, hl)

	if sl then
		s.level = sl

		local a = this.timed_attacks.list[3]

		a.disabled = false
		a.max_target = s.max_targets[sl]

		local m = E:get_template("mod_gold_wanted")

		m.modifier.duration = s.duration[sl]
		m.gold_factor = s.gold_factor[sl]
		m.received_damage_factor = s.received_damage_factor[sl]

		local a = E:get_template("aura_deadeye_wanted")

		a.aura.max_count = s.max_targets[sl]
	end

	this.health.hp = this.health.hp_max
end

function scripts.hero_deadeye.update(this, store)
	local h = this.health
	local he = this.hero
	local a, skill, brk, sta, bulletbar, target
	local shoot_count = 0

	U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)

	this.health_bar.hidden = false

	while true do
		if h.dead then
			SU.y_hero_death_and_respawn(store, this)
		end

		a = this.timed_attacks.list[3]

		if store.tick_ts - a.ts >= a.cooldown and not a.disabled then
			this.render.sprites[2].hidden = false
		else
			this.render.sprites[2].hidden = true
		end

		if this.unit.is_stunned then
			SU.soldier_idle(store, this)
		else
			while this.nav_rally.new do
				local r = this.nav_rally
				local hr = this.horseride
				local force_horseride = false

				if force_horseride or V.dist(this.pos.x, this.pos.y, r.pos.x, r.pos.y) > hr.min_distance then
					r.new = false

					U.unblock_target(store, this)

					local vis_bans = this.vis.bans

					this.vis.bans = F_ALL
					this.health.immune_to = F_ALL

					local original_speed = this.motion.max_speed

					this.motion.max_speed = this.motion.max_speed + hr.extra_speed

					local hbo = this.health_bar.offset

					this.health_bar.offset = v(0, 56)

					S:queue(this.sound_events.change_rally_point)
					S:queue(this.sound_events.horse_start)
					SU.hide_modifiers(store, this, true)

					local flip = r.pos.x < this.pos.x

					U.y_animation_play(this, hr.animations[1], flip, store.tick_ts)
					SU.show_modifiers(store, this, false)
					S:queue(this.sound_events.horse_loop)

					local ho = this.unit.hit_offset
					local mo = this.unit.mod_offset

					this.unit.hit_offset = hr.hit_offset
					this.unit.mod_offset = hr.mod_offset

					::label_498_0::

					local dest = r.pos
					local n = this.nav_grid

					while not V.veq(this.pos, dest) do
						local w = table.remove(n.waypoints, 1) or dest

						U.set_destination(this, w)

						local an, af = U.animation_name_facing_point(this, hr.animations[2], this.motion.dest)

						U.animation_start(this, an, af, store.tick_ts, true)

						while not this.motion.arrived do
							if r.new then
								r.new = false

								goto label_498_0
							end

							U.walk(this, store.tick_length)
							coroutine.yield()

							this.motion.speed.x, this.motion.speed.y = 0, 0
						end
					end

					S:stop(this.sound_events.horse_loop)
					S:queue(this.sound_events.horse_end, this.sound_events.horse_end_args)
					SU.hide_modifiers(store, this, false)
					U.y_animation_play(this, hr.animations[3], nil, store.tick_ts)
					SU.show_modifiers(store, this, true)
					U.animation_start(this, "idle", nil, store.tick_ts)

					this.motion.max_speed = original_speed
					this.vis.bans = vis_bans
					this.health.immune_to = 0
					this.health_bar.offset = hbo
					this.unit.hit_offset = ho
					this.unit.mod_offset = mo
				elseif SU.y_hero_new_rally(store, this) then
					goto label_498_1
				end
			end

			if SU.hero_level_up(store, this) then
				U.y_animation_play(this, "levelUp", nil, store.tick_ts, 1)
				U.animation_start(this, "idle", nil, store.tick_ts)
			end

			a = this.timed_attacks.list[3]
			skill = this.hero.skills.bounty

			if not a.disabled and store.tick_ts - a.ts > a.cooldown then
				local triggers = U.find_enemies_in_range(store.entities, this.pos, 0, a.max_range, a.vis_flags, a.vis_bans)

				if not triggers or #triggers < a.min_count then
					SU.delay_attack(store, a, 0.13333333333333333)
				else
					local start_ts = store.tick_ts
					local af = triggers[1].pos.x < this.pos.x

					U.animation_start(this, a.animation, af, store.tick_ts)

					if SU.y_hero_wait(store, this, a.hit_time) then
						goto label_498_1
					end

					S:queue(a.sound)

					a.ts = start_ts

					local target = U.find_foremost_enemy(store.entities, this.pos, 0, a.cast_range, a.hit_time, a.vis_flags, a.vis_bans)

					if not target then
						SU.delay_attack(store, a, 0.13333333333333333)
					else
						S:queue(a.sound)

						local aura = E:create_entity("aura_deadeye_wanted")

						aura.pos.x, aura.pos.y = target.pos.x, target.pos.y
						aura.aura.source_id = this.id
						aura.aura.radius = a.radius

						queue_insert(store, aura)

						goto label_498_1
					end
				end
			end

			brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

			if brk or sta ~= A_NO_TARGET then
				-- block empty
			else
				bulletbar = bulletbar or table.filter(store.entities, function(k, v)
					return v.modifier and v.template_name == "mod_shotgun_bullets" and v.target_id == this.id
				end)[1]

				if bulletbar and bulletbar.bullet_count > 0 then
					a = this.timed_attacks.list[2]

					local _, pred_pos

					target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)
				else
					target = nil
				end

				if target then
					skill = this.hero.skills.shotgun

					local an, af, ai = U.animation_name_facing_point(this, a.aim_animation, target.pos)

					U.y_animation_play(this, an, af, store.tick_ts, 1)
					U.set_destination(this, this.pos)

					for si = 1, bulletbar.bullet_count do
						if not target then
							goto label_498_1
						end

						local _, pred_pos
						local target_dist, _, pred_pos = V.dist(target.pos.x, target.pos.y, this.pos.x, this.pos.y)

						if not target or target.health.dead or target_dist < a.min_range or target_dist > a.max_range then
							target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

							if not target then
								goto label_498_1
							end
						end

						an, af, ai = U.animation_name_facing_point(this, a.shoot_animation, target.pos)

						U.animation_start(this, an, af, store.tick_ts, 1)

						local b = E:create_entity(a.bullet)

						b.pos = V.vclone(this.pos)

						if a.bullet_start_offset then
							local offset = a.bullet_start_offset[ai]

							b.pos.x, b.pos.y = b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y
						end

						b.bullet.from = V.vclone(b.pos)
						b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
						b.bullet.target_id = target.id
						b.bullet.shot_index = si
						b.bullet.source_id = this.id
						b.bullet.xp_dest_id = this.id
						bulletbar.bullet_amount_changed = true
						bulletbar.bullet_count = bulletbar.bullet_count - 1

						queue_insert(store, b)

						a.ts = store.tick_ts

						while not U.animation_finished(this) do
							if SU.hero_interrupted(this) then
								goto label_498_1
							end

							coroutine.yield()
						end

						if U.y_wait(store, a.shoot_times, function()
							return SU.hero_interrupted(this)
						end) then
							goto label_498_1
						end
					end

					U.animation_start(this, "shotgun_reload", nil, store.tick_ts)
				else
					a = this.timed_attacks.list[1]

					if store.tick_ts - a.ts >= a.cooldown then
						local target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

						if not target then
							-- block empty
						else
							local flip = target.pos.x < this.pos.x
							local b, an, af, ai

							an, af, ai = U.animation_name_facing_point(this, a.aim_animation, target.pos)

							U.animation_start(this, an, af, store.tick_ts, 1)
							U.set_destination(this, this.pos)

							while not U.animation_finished(this) do
								if SU.hero_interrupted(this) then
									goto label_498_1
								end

								coroutine.yield()
							end

							for si = 1, a.max_shoots do
								if not target then
									-- block empty
								end

								local target_dist = V.dist(target.pos.x, target.pos.y, this.pos.x, this.pos.y)

								if si > 1 and (not target or target.health.death or not target_dist or not (target_dist >= a.min_range) or target_dist <= a.max_range or true) then
									target, _, pred_pos = U.find_foremost_enemy(store.entities, this.pos, a.min_range, a.max_range, a.node_prediction, a.vis_flags, a.vis_bans, a.filter_fn, F_FLYING)

									if not target then
										break
									end
								end

								an, af, ai = U.animation_name_facing_point(this, a.shoot_animation, target.pos)

								U.animation_start(this, an, af, store.tick_ts, 1)

								b = E:create_entity(a.bullet)
								b.pos = V.vclone(this.pos)

								if a.bullet_start_offset then
									local offset = a.bullet_start_offset[ai]

									b.pos.x, b.pos.y = b.pos.x + (af and -1 or 1) * offset.x, b.pos.y + offset.y
								end

								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
								b.bullet.target_id = target.id
								b.bullet.shot_index = si
								b.bullet.source_id = this.id
								b.bullet.xp_dest_id = this.id

								queue_insert(store, b)

								if U.y_wait(store, a.shoot_times, function()
									return SU.hero_interrupted(this)
								end) then
									goto label_498_1
								end
							end

							a.ts = store.tick_ts

							U.animation_start(this, "reload", nil, store.tick_ts)

							while not U.animation_finished(this) do
								if SU.hero_interrupted(this) then
									goto label_498_1
								end

								coroutine.yield()
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
		end

		::label_498_1::

		coroutine.yield()
	end
end

scripts.mod_gold_wanted = {}

local function gold_wanted_enemy_component(target)
	return target and (target.enemy or target._original_enemy)
end

function scripts.mod_gold_wanted.insert(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local enemy = gold_wanted_enemy_component(target)

	if not target or not target.health or not enemy then
		return false
	end

	local old_gold = enemy.gold or 0

	enemy.gold = old_gold * this.gold_factor
	earnings_stats.adjust_enemy_bonus(target, "hero_deadeye", enemy.gold - old_gold)

	if this.received_damage_factor then
		target.health.damage_factor = target.health.damage_factor * this.received_damage_factor
	end

	this.render.sprites[1].ts = store.tick_ts

	return true
end

function scripts.mod_gold_wanted.update(this, store)
	local m = this.modifier

	m.ts = store.tick_ts

	local target = store.entities[m.target_id]

	if not target or not target.pos or not target.health then
		queue_remove(store, this)

		return
	end

	this.pos = target.pos

	if target.health_bar and target.health_bar.offset then
		this.render.sprites[1].offset.y = target.health_bar.offset.y + 15
	end

	U.animation_start(this, "cash_fadein", nil, store.tick_ts)

	while store.tick_ts - m.ts < m.duration and target and not target.health.dead do
		coroutine.yield()
	end

	U.y_animation_play(this, "cash_fadeout", nil, store.tick_ts)

	local enemy = gold_wanted_enemy_component(target)

	if target and target.health.dead and enemy and enemy.gold > 0 then
		local fx = E:create_entity("fx_coin_jump")

		fx.pos.x, fx.pos.y = target.pos.x, target.pos.y
		fx.render.sprites[1].ts = store.tick_ts

		if target.health_bar then
			fx.render.sprites[1].offset.y = target.health_bar.offset.y
		end

		queue_insert(store, fx)
	end

	queue_remove(store, this)
end

function scripts.mod_gold_wanted.remove(this, store, script)
	local target = store.entities[this.modifier.target_id]
	local enemy = gold_wanted_enemy_component(target)

	if not target or not enemy then
		return true
	end

	local old_gold = enemy.gold or 0

	enemy.gold = old_gold / this.gold_factor
	earnings_stats.adjust_enemy_bonus(target, "hero_deadeye", enemy.gold - old_gold)

	if this.received_damage_factor and target.health then
		target.health.damage_factor = target.health.damage_factor / this.received_damage_factor
	end

	return true
end

scripts.mod_shotgun_bullets = {}

function scripts.mod_shotgun_bullets.update(this, store)
	local owner = store.entities[this.target_id]

	log.debug(owner.template_name)

	this.pos = owner.pos
	this.bullet_amount_changed = true

	local ts = store.tick_ts
	local a = owner.timed_attacks.list[2]

	while true do
		if store.tick_ts - ts >= a.mod_cooldown and this.bullet_count < this.max_bullets then
			ts = store.tick_ts
			this.bullet_count = this.bullet_count + 1

			log.debug("bullet count set to " .. this.bullet_count)

			this.bullet_amount_changed = true
		end

		if this.bullet_amount_changed then
			this.bullet_amount_changed = nil

			for i = 1, this.max_bullets do
				this.render.sprites[i].name = i <= this.bullet_count and "bullet" or "empty"
			end
		end

		if owner.health.dead then
			this.bullet_count = 0

			for i = 1, this.max_bullets do
				this.render.sprites[i].hidden = true
			end
		else
			for i = 1, this.max_bullets do
				this.render.sprites[i].hidden = false
			end
		end

		coroutine.yield()
	end
end

return scripts
