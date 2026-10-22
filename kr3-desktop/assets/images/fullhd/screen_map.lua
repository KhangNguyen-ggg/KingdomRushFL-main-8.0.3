--screen_map

local z0 = require("assets.images.fullhd." .. "screen_map_5_dlc")
local z1 = require("assets.images.fullhd." .. "screen_map_5")
local z2 = require("assets.images.fullhd." .. "screen_map_123")
local z3 = require("assets.images.fullhd." .. "screen_map_hud")

--local z4 = require("assets.images.fullhd." .. "room_tower")
local z4 = require("assets.images.fullhd." .. "gui_common_5")
local z6 = require("assets.images.fullhd." .. "screen_map_bg")

local z={}
local count = 0
local function merge_source(source)
	for k, v in pairs(source) do
		if z[k] and z[k] ~= v then
			count = count + 1
		end
		z[k] = v
	end

	for _, v in pairs(source) do
		if v.alias then
			for _, alias in ipairs(v.alias) do
				z[alias] = v
			end
		end
	end
end

merge_source(z0)
merge_source(z1)
merge_source(z2)
merge_source(z3)
merge_source(z4)
merge_source(z6)


return z
