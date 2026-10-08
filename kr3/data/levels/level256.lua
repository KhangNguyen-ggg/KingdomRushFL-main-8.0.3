-- chunkname: @./kr6/data/levels/level256.lua

local log = require("klua.log"):new("level256")
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
	P:add_invalid_range(2, 90, 110)

	for i = 1, 3 do
		P:add_invalid_range(i, P:get_end_node(i) - 4, P:get_end_node(i))
	end

	while not store.waves_finished or LU.has_alive_enemies(store) do
		coroutine.yield()
	end

	log.debug("-- WON")
end

return level

