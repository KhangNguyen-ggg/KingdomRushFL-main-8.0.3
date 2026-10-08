-- chunkname: @./kr6/data/levels/level267.lua

local log = require("klua.log"):new("level267")
local signal = require("hump.signal")
local LU = require("level_utils_6")

require("constants")

local level = {}

function level:update(store)
	while not store.waves_finished or LU.has_alive_enemies(store) do
		coroutine.yield()
	end

	local duel = table.filter(store.entities, function(k, v)
		return v.template_name == "controller_stage_17_duel"
	end)[1]

	if (not duel or not duel.paladin_lost) and store.level_mode_6 == GAME_MODE_CAMPAIGN then
		signal.emit("there-can-only-be-one-stage17")
	end

	log.debug("-- WON")
end

return level

