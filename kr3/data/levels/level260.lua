-- chunkname: @./kr6/data/levels/level260.lua

local log = require("klua.log"):new("level260")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local V = require("klua.vector")
local P = require("path_db")
local W = require("wave_db")
local SSO = require("klove.sso")
local storage = require("storage")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

function level:update(store)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN or store.level_mode_6 == GAME_MODE_KR1 then
		while store.wave_group_number < 5 do
			coroutine.yield()
		end

		local door = table.filter(game.store.entities, function(k, v)
			return v.template_name == "decal_stage_10_jt_door"
		end)[1]
		local controller_swipe = table.filter(game.store.entities, function(k, v)
			return v.template_name == "controller_stage_10_jt_swipe"
		end)[1]
		local controller_icicles = table.filter(game.store.entities, function(k, v)
			return v.template_name == "controller_stage_10_jt_icicles"
		end)[1]

		S:queue("Stage10BellUnfreeze")
		U.y_animation_play(door, "bell_defrost", nil, store.tick_ts, 1, 1)
		U.animation_start(door, "idle_defrost", nil, store.tick_ts, true, 1)

		controller_swipe.swipe_active = true

		while not store.waves_finished or LU.has_alive_enemies(store) or door.in_use do
			coroutine.yield()
		end

		local jt_spawn = V.v(511.6, 589.5)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
		end

		door.in_use = true
		door.boss_fight = true
		controller_swipe.swipe_active = false
		controller_icicles.icicles_active = false

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			signal.emit("pan-zoom-camera", 1.5, {
				x = jt_spawn.x,
				y = jt_spawn.y + 100
			}, OVm(1, 1.5))
		end

		U.y_wait(store, 1.5)
		S:queue("Stage10DoorOpen")

		if door.ready then
			U.animation_start(door, "out_boss_defrost", nil, store.tick_ts, nil, 1)
		else
			U.animation_start(door, "out_boss", nil, store.tick_ts, nil, 1)
		end

		U.y_wait(store, fts(22))

		local boss = E:create_entity("enemy_boss_stage_10")
		local old_bans = boss.vis.bans

		boss.nav_path.pi = 4
		boss.nav_path.spi = 1
		boss.nav_path.ni = 75
		boss.motion.forced_waypoint = P:node_pos(4, 1, 75)
		boss.pos = jt_spawn
		boss.vis.bans = F_ALL
		boss.cinematic = true
		boss.health.ignore_damage = true

		LU.queue_insert(store, boss)
		coroutine.yield()

		if door.ready then
			U.animation_start(door, "idle_3_defrost", nil, store.tick_ts, true, 1)
		else
			U.animation_start(door, "idle_3", nil, store.tick_ts, true, 1)
		end

		U.y_wait(store, 2.5)

		S:queue("Stage10JTChestTaunt")
		U.y_animation_play(boss, "death", nil, store.tick_ts, 1, 1)

		door.in_use = false
		controller_icicles._target_random = 8
		controller_icicles._target_allies = 0
		controller_icicles._target_enemies = 0
		controller_icicles.spawn_icicles = true

		local shake = E:create_entity("aura_screen_shake")

		shake.aura.amplitude = 1
		shake.aura.duration = fts(11) * 5
		shake.aura.freq_factor = 3

		LU.queue_insert(store, shake)
		S:queue("Stage10JTRoar")
		U.y_animation_play(boss, "death_loop", nil, store.tick_ts, 3, 1)
		U.animation_start(boss, "idle", nil, store.tick_ts, nil, 1)
		U.y_wait(store, fts(10))

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			signal.emit("hide-curtains")
			signal.emit("show-gui")
			signal.emit("end-cinematic")
		end

		W:start_manual_wave("BOSS1")

		boss.health.ignore_damage = false
		boss.cinematic = false

		coroutine.yield()
		signal.emit("boss_fight_start", boss)

		if door.ready then
			U.animation_start(door, "idle_3_defrost", nil, store.tick_ts, true, 1)
		else
			U.animation_start(door, "idle_3", nil, store.tick_ts, true, 1)
		end

		boss.vis.bans = old_bans

		while not boss.health.dead do
			coroutine.yield()
		end

		local l_entities = SSO and SSO:get_p_list("modifiers") or store.entities
		local freeze_mods = table.filter(l_entities, function(k, v)
			return v.template_name == "mod_boss_tower_block"
		end)

		for k, m in pairs(freeze_mods) do
			m.modifier.ts = 0
		end

		signal.emit("boss_fight_end")
		U.y_wait(store, 3)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			store.custom_game_outcome = {
				postpone_unload = true,
				after_victory_screen = true,
				next_item_name = "level_260_end"
			}
		end
	else
		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	log.debug("-- WON")
end

return level

