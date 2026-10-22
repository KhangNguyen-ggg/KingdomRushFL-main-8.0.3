local atlas = {}
local atlas_size = {960, 800}

local function add(name, slot, trim, width)
	local column = slot % 12
	local row = math.floor(slot / 12)

	atlas[name] = {
		a_name = "legacy_generation_upgrades.png",
		size = {76, 78},
		trim = trim,
		a_size = atlas_size,
		f_quad = {column * 80 + 4, row * 80 + 7, width, 70},
		alias = {}
	}
end

for generation = 1, 2 do
	local base = (generation - 1) * 60
	local trim = generation == 1 and {2, 6, 3, 2} or {2, 6, 4, 2}
	local width = generation == 1 and 71 or 70

	for index = 1, 30 do
		add(string.format("G%d_Upgrades_Icons_%04d", generation, index), base + index - 1, trim, width)
		add(string.format("Disabled_G%d_Upgrades_Icons_%04d", generation, index), base + 30 + index - 1, trim, width)
	end
end

return atlas
