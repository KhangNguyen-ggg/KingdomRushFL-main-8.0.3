-- chunkname: @./kr6/data/levels/level266.lua

local log = require("klua.log"):new("level266")
local signal = require("hump.signal")
local E = require("entity_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local S = require("sound_db")

require("constants")

local CORRUPTIONS = {
	{
		decal = "decal_stage_16_bg_corrupt",
		after_wave = 4,
		rider_interval = 1,
		sound = "Stage16GoldenGroveCorruption1",
		shader_delay = 5,
		camera = {
			x = 820,
			y = 500
		},
		rider_paths = {
			6,
			2
		}
	},
	{
		decal = "decal_stage_16_bg_corrupt_2",
		after_wave = 9,
		rider_interval = 2,
		sound = "Stage16GoldenGroveCorruption2",
		shader_delay = 5,
		camera = {
			x = 270,
			y = 380
		},
		rider_paths = {
			1,
			3
		}
	}
}
local CAM_PAN_TIME = 1.8
local CAM_PAN_EASE = "in-out-sine"
local RIDERS_ENTRY_DELAY = 0
local RIDERS_LAUGH_DELAY = 1.5
local SHADER_SOUND_DELAY = 0

local function y_wait_wave_end(store, n)
	while (not store.next_wave_group_ready or not (n < store.next_wave_group_ready.group_idx)) and not (n < store.wave_group_number) and (not store.waves_finished or not not LU.has_alive_enemies(store)) do
		coroutine.yield()
	end
end

local function y_spawn_death_riders(store, ph)
	S:queue("Stage16DeathRiderLaugh", {
		delay = RIDERS_LAUGH_DELAY
	})

	local riders, emitters = {}, {}

	for i, pi in ipairs(ph.rider_paths or {}) do
		if i > 1 then
			U.y_wait(store, ph.rider_interval or 0)
		end

		local e = E:create_entity("enemy_death_rider")

		e.nav_path.pi = pi
		e.nav_path.spi = 1
		e.nav_path.ni = 1
		e.cinematic_bans = e.vis.bans
		e.vis.bans = F_ALL
		e.health.ignore_damage = true
		e.timed_attacks.list[1].disabled = true

		LU.queue_insert(store, e)

		riders[#riders + 1] = e

		if not U.is_seen(store, "enemy_death_rider") then
			signal.emit("wave-notification", "icon", "enemy_death_rider")
			U.mark_seen(store, "enemy_death_rider")
		end

		local em = E:create_entity("controller_stage_16_rider_fog_emitter")

		em.target_id = e.id

		LU.queue_insert(store, em)

		emitters[#emitters + 1] = em
	end

	return riders, emitters
end

local function find_entity(store, template_name)
	for _, e in pairs(store.entities) do
		if e.template_name == template_name then
			return e
		end
	end

	return nil
end

local function apply_corruption(store, template_name, instant)
	local decal = find_entity(store, template_name)

	if not decal then
		decal = E:create_entity(template_name)

		LU.queue_insert(store, decal)
	end

	decal.skip_anim = instant or false
	decal.triggered = true

	return decal
end

local function y_corruption_cinematic(store, ph)
	signal.emit("show-curtains")
	signal.emit("hide-gui")
	signal.emit("start-cinematic")

	signal.emit("pan-zoom-camera", CAM_PAN_TIME, ph.camera, 1, CAM_PAN_EASE)
	U.y_wait(store, CAM_PAN_TIME + RIDERS_ENTRY_DELAY)

	local riders, emitters = y_spawn_death_riders(store, ph)

	U.y_wait(store, math.max(0, ph.shader_delay or 0.8))
	S:queue(ph.sound, {
		delay = SHADER_SOUND_DELAY
	})

	local decal = apply_corruption(store, ph.decal)

	U.y_wait(store, decal and decal.reveal_time or 3)

	for _, em in ipairs(emitters) do
		em.finished = true
	end

	signal.emit("hide-curtains")
	signal.emit("show-gui")

	for _, r in ipairs(riders) do
		if store.entities[r.id] then
			r.vis.bans = r.cinematic_bans
			r.health.ignore_damage = nil
			r.timed_attacks.list[1].disabled = nil
		end
	end

	signal.emit("end-cinematic")
end

local level = {}

level.skippable_cutscenes = true

function level:update(store)
	coroutine.yield()

	if store.level_mode_6 ~= GAME_MODE_CAMPAIGN and store.level_mode_6 ~= GAME_MODE_BLITZ and store.level_mode_6 ~= GAME_MODE_KR1 then
		for _, ph in ipairs(CORRUPTIONS) do
			local decal = find_entity(store, ph.decal) or E:create_entity(ph.decal)

			decal.apply_final(decal, store)
		end

		return
	end

	if store.level_mode_6 ~= GAME_MODE_BLITZ then
		for _, ph in ipairs(CORRUPTIONS) do
			y_wait_wave_end(store, ph.after_wave)

			if not main.params.skip_cutscenes then
				y_corruption_cinematic(store, ph)
			else
				apply_corruption(store, ph.decal, true)
			end
		end
	end
end

return level

