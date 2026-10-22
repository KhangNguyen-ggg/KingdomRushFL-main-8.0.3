local frames = {}

for index = 1, 16 do
	local column = (index - 1) % 4
	local row = math.floor((index - 1) / 4)

	frames[string.format("Stage91CrystalAltarDestroy_%04d", index)] = {
		a_name = "go_stage91_crystal_altar_destroy.png",
		size = {362, 320},
		trim = {0, 0, 0, 0},
		a_size = {1448, 1280},
		f_quad = {column * 362, row * 320, 362, 320},
		alias = {},
		textureRotated = false
	}
end

return frames
