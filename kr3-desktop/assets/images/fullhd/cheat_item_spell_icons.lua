local function icon(x, y)
	return {
		a_name = "cheat_item_spell_icons.png",
		size = {88, 88},
		trim = {15, 14, 15, 14},
		a_size = {1024, 512},
		f_quad = {x, y, 58, 60},
		alias = {}
	}
end

local function pointer(x, y)
	return {
		a_name = "cheat_item_spell_icons.png",
		size = {88, 100},
		trim = {5, 3, 7, 3},
		a_size = {1024, 512},
		f_quad = {x, y, 76, 94},
		alias = {}
	}
end

return {
	cheat_item_spell_cluster_bomb = icon(0, 0),
	cheat_item_spell_portable_coil = icon(112, 0),
	cheat_item_spell_scroll_of_spaceshift = icon(224, 0),
	cheat_item_spell_deaths_touch = icon(448, 0),
	cheat_item_spell_medical_kit = icon(0, 112),
	cheat_item_spell_winter_age = icon(112, 112),
	cheat_item_spell_loot_box = icon(224, 112),
	cheat_item_spell_summon_blackburn = icon(336, 112),
	cheat_item_spell_veznan_wrath = icon(448, 112),
	cheat_item_spell_kro_teleport_scroll = icon(560, 0),
	cheat_item_spell_kro_horn_heroism = icon(672, 0),
	cheat_item_spell_kro_gem_timewarp = icon(784, 0),
	cheat_item_spell_kro_rod_dragon_fire = icon(896, 0),
	cheat_item_spell_kro_hand_midas = icon(560, 112),
	cheat_item_spell_kro_wrath_of_elynia = icon(672, 112),
	pointer_cheat_item_spell_cluster_bomb = pointer(0, 256),
	pointer_cheat_item_spell_portable_coil = pointer(88, 256),
	pointer_cheat_item_spell_scroll_of_spaceshift = pointer(176, 256),
	pointer_cheat_item_spell_deaths_touch = pointer(264, 256),
	pointer_cheat_item_spell_medical_kit = pointer(352, 256),
	pointer_cheat_item_spell_winter_age = pointer(440, 256),
	pointer_cheat_item_spell_loot_box = pointer(528, 256),
	pointer_cheat_item_spell_summon_blackburn = pointer(616, 256),
	pointer_cheat_item_spell_veznan_wrath = pointer(704, 256),
	pointer_cheat_item_spell_kro_teleport_scroll = pointer(792, 256),
	pointer_cheat_item_spell_kro_horn_heroism = pointer(0, 356),
	pointer_cheat_item_spell_kro_gem_timewarp = pointer(88, 356),
	pointer_cheat_item_spell_kro_rod_dragon_fire = pointer(176, 356),
	pointer_cheat_item_spell_kro_hand_midas = pointer(264, 356),
	pointer_cheat_item_spell_kro_wrath_of_elynia = pointer(352, 356)
}
