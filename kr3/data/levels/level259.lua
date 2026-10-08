-- chunkname: @./kr6/data/levels/level259.lua

local log = require("klua.log"):new("level259")
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
	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		P:deactivate_path(7)

		while store.wave_group_number < 4 do
			coroutine.yield()
		end

		local cover = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_09_entrance_cover"
		end)[1]

		U.y_animation_play(cover, "run", nil, store.tick_ts, 1)
		P:activate_path(7)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	else
		for _, v in pairs(store.entities) do
			if v.template_name == "decal_stage_09_entrance_cover" then
				simulation:queue_remove_entity(v)

				break
			end
		end

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	log.debug("-- WON")
end

return level

