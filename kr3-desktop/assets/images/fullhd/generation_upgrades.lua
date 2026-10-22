local atlas = {}
local slot = 0

local function add(name)
	local column = slot % 8
	local row = math.floor(slot / 8)

	atlas[name] = {
		a_name = "generation_upgrades.png",
		size = {76, 78},
		trim = {0, 3, 2, 1},
		a_size = {640, 640},
		f_quad = {column * 80 + 3, row * 80 + 3, 74, 74},
		alias = {}
	}
	slot = slot + 1
end

local g4_frames = {6, 7, 8, 9, 10, 11, 12, 13, 22, 23, 24, 25, 26, 27, 28}

for _, frame in ipairs(g4_frames) do
	add(string.format("Generation_G4_%04d", frame))
end
for _, frame in ipairs(g4_frames) do
	add(string.format("Disabled_Generation_G4_%04d", frame))
end
for i = 1, 8 do
	add(string.format("Generation_G5_Reinforcements_%04d", i))
end
for i = 1, 8 do
	add(string.format("Disabled_Generation_G5_Reinforcements_%04d", i))
end
for i = 1, 8 do
	add(string.format("Generation_G5_Towers_%04d", i))
end
for i = 1, 8 do
	add(string.format("Disabled_Generation_G5_Towers_%04d", i))
end

add("Generation_Upgrade_Sell")

return atlas
