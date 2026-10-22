local atlas = {}

local names = {
	"spell_selection_icon_reinforcement",
	"spell_selection_icon_fire",
	"spell_selection_icon_thunder",
	"spell_selection_icon_reinforcement_g3",
	"spell_selection_icon_flash"
}

for index, name in ipairs(names) do
	atlas[name] = {
		a_name = "spell_selection_icons.png",
		size = {88, 88},
		trim = {0, 0, 0, 0},
		a_size = {528, 88},
		f_quad = {(index - 1) * 88, 0, 88, 88},
		alias = {}
	}
end

atlas.spell_selection_icon_empty = {
	a_name = "spell_selection_icons.png",
	size = {88, 88},
	trim = {12, 13, 12, 13},
	a_size = {528, 88},
	f_quad = {452, 13, 64, 62},
	alias = {}
}

return atlas
