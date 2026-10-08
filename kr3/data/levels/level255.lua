-- chunkname: @./kr6/data/levels/level255.lua

local log = require("klua.log"):new("level255")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local V = require("klua.vector")
local P = require("path_db")
local storage = require("storage")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

level.skippable_cutscenes = true

local function wait_for_alleria(store, alleria)
	coroutine.yield()

	local h = alleria.health

	if not h.dead or not h.death_ts or store.tick_ts - h.death_ts <= h.dead_lifetime + 5 then
		return
	end

	log.warning("Alleria respawn stalled on level 255; restarting her entity script")
	alleria.main_script.co = nil
	alleria.main_script.runs = 1
	alleria.ignore_in_animation = true
	alleria.force_respawn = nil
	h.dead = false
	h.hp = h.hp_max
	h.ignore_damage = false
	h.death_finished_ts = nil
	alleria.health_bar.hidden = false
	alleria.ui.can_click = true

	for _, sprite in pairs(alleria.render.sprites) do
		sprite.hidden = false
	end

	U.animation_start(alleria, "idle", nil, store.tick_ts, true)
end

function level:update(store)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		local user_data = storage:load_slot()

		P:deactivate_path(5)

		local upper_path

		for _, v in pairs(store.entities) do
			if v.template_name == "decal_stage_05_upper_path" then
				upper_path = v

				break
			end
		end

		local alleria

		if store.restarted or main.params.skip_cutscenes then
			alleria = E:create_entity("hero_stage_05_alleria")
			alleria.ignore_in_animation = true

			alleria = LU.insert_hero(store, alleria, V.v(620, 270))
			signal.emit("pan-zoom-camera", 0, {
				x = 660,
				y = 390
			}, 1)
		else
			signal.emit("pan-zoom-camera", 0, {
				x = 660,
				y = 480
			}, 2)
			coroutine.yield()
			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
			signal.emit("pan-zoom-camera", 5, {
				x = 660,
				y = 390
			}, 2)
			U.y_wait(store, fts(30))

			local cat = E:create_entity("soldier_alleria_cat")

			cat.pos = V.v(542, 434)
			cat.nav_rally.center = V.v(464, 363)
			cat.nav_rally.pos = cat.nav_rally.center
			cat.nav_rally.new = true

			LU.queue_insert(store, cat)
			U.y_wait(store, fts(10))

			while V.dist2(cat.pos.x, cat.pos.y, cat.nav_rally.center.x, cat.nav_rally.center.y) > 100 do
				coroutine.yield()
			end

			U.y_wait(store, 0.5)

			cat.nav_rally.center = V.v(570, 270)
			cat.nav_rally.pos = V.vclone(cat.nav_rally.center)
			cat.nav_rally.new = true

			while V.dist2(cat.pos.x, cat.pos.y, cat.nav_rally.center.x, cat.nav_rally.center.y) > 100 do
				coroutine.yield()
			end

			U.y_wait(store, 0.5)

			alleria = E:create_entity("hero_stage_05_alleria")
			alleria.in_cinematic = true
			alleria = LU.insert_hero(store, alleria, V.v(620, 270))

			U.y_wait(store, 1.75)

			local balloon_pos = V.v(alleria.pos.x, alleria.pos.y + 50)

			signal.emit("show-balloon_tutorial-pos", "S05_INTRO_01", false, balloon_pos)
			U.y_wait(store, 2)
			signal.emit("show-balloon_tutorial-pos", "S05_INTRO_02", false, balloon_pos)
			U.y_wait(store, 2)

			cat.reinforcement.duration = 0
			alleria.in_cinematic = false

			signal.emit("hide-curtains")
			signal.emit("pan-zoom-camera", 2, {
				x = 512,
				y = 360
			}, OVm(1, 1.3))
			signal.emit("show-gui")
			signal.emit("end-cinematic")
		end

		while store.wave_group_number < 9 do
			wait_for_alleria(store, alleria)
		end

		upper_path.goblin_out = true

		while not store.waves_finished or LU.has_alive_enemies(store) do
			wait_for_alleria(store, alleria)
		end
	elseif store.level_mode_6 == GAME_MODE_KR1 then
		local alleria = E:create_entity("hero_stage_05_alleria")

		alleria.ignore_in_animation = true

		alleria = LU.insert_hero(store, alleria, V.v(620, 270))
		P:deactivate_path(5)

		local upper_path

		for _, v in pairs(store.entities) do
			if v.template_name == "decal_stage_05_upper_path" then
				upper_path = v

				break
			end
		end

		while store.wave_group_number < 9 do
			wait_for_alleria(store, alleria)
		end

		upper_path.goblin_out = true

		while not store.waves_finished or LU.has_alive_enemies(store) do
			wait_for_alleria(store, alleria)
		end
	else
		for k, v in pairs(store.level.ignore_walk_backwards_paths) do
			if v == 5 then
				store.level.ignore_walk_backwards_paths[k] = nil
			end
		end

		P:activate_path(5)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	log.debug("-- WON")
end

return level

