-- chunkname: @./kr6/data/levels/level252.lua

local log = require("klua.log"):new("level252")
local LU = require("level_utils_6")

require("constants")

local level = {}

function level:update(store)
	while not store.waves_finished or LU.has_alive_enemies(store) do
		coroutine.yield()
	end

	log.debug("-- WON")
end

return level

