local frames = {}

for index = 1, 16 do
	local column = (index - 1) % 4
	local row = math.floor((index - 1) / 4)

	frames[string.format("CrystalHorror_%04d", index)] = {
		a_name = "go_stage91_crystal_horror.png",
		size = {332, 297},
		trim = {0, 0, 0, 0},
		a_size = {1328, 1188},
		f_quad = {column * 332, row * 297, 332, 297},
		alias = {},
		textureRotated = false
	}
end

return frames
