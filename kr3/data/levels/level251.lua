-- chunkname: @./kr6/data/levels/level251.lua

local log = require("klua.log"):new("level251")
local U = require("utils_6")
local LU = require("level_utils_6")
local P = require("path_db")

require("constants")

local level = {}

function level:preprocess(store)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		level.show_comic_idx = 52
	end
end

function level:update(store)
	P:deactivate_path(2)

	if store.level_mode_6 == GAME_MODE_EXTRA_HEROES then
		P:activate_path(2)
	elseif store.level_mode_6 == GAME_MODE_CAMPAIGN then
		store.player_gold = store.player_gold + 70

		local king = table.filter(store.entities, function(_, entity)
			return entity.template_name == "decal_stage_01_king"
		end)[1]

		if king then
			simulation:queue_remove_entity(king)
		end
	end

	while not store.waves_finished or LU.has_alive_enemies(store) do
		coroutine.yield()
	end

	U.y_wait(store, 2)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		store.custom_game_outcome = {
			after_victory_screen = true,
			postpone_unload = true,
			next_item_name = "level_251_end"
		}
	end

	log.debug("-- WON")
end

return level

