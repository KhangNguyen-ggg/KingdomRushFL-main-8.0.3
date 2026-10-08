-- chunkname: @./kr6/data/levels/level254.lua

local log = require("klua.log"):new("level254")
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

function level:update(store)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN or store.level_mode_6 == GAME_MODE_KR1 then
		P:deactivate_path(3)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end

		U.y_wait(store, 3)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			store.custom_game_outcome = {
				after_victory_screen = true,
				postpone_unload = true,
				next_item_name = "level_254_end"
			}
		end
	else
		local f1, f2 = false, false

		for _, v in pairs(store.entities) do
			if v.template_name == "decal_stage_04_wall_explosion" then
				U.animation_start(v, "idle", nil, store.tick_ts, false)

				f1 = true
			end

			if v.template_name == "decal_stage_04_mask_1" then
				v.render.sprites[1].z = Z_OBJECTS_COVERS
				f2 = true
			end

			if f1 and f2 then
				break
			end
		end

		for k, v in pairs(store.level.ignore_walk_backwards_paths) do
			if v == 3 then
				store.level.ignore_walk_backwards_paths[k] = nil
			end
		end

		P:activate_path(3)
		U.y_wait(store, 3)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	log.debug("-- WON")
end

return level

