local function scene_icon(size, trim, quad)
	return {
		a_name = "kr6_gui_common-1.dds",
		size = size,
		trim = trim,
		a_size = {2824, 2820},
		f_quad = quad,
		alias = {}
	}
end

local atlas = {
	quickmenu_main_icon_confirm = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {2461, 1068, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_confirm_disabled = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {2541, 1068, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_crane = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {2621, 1068, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_crane_disabled = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {2701, 1068, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_water = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1261, 1788, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_water_disabled = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1261, 1868, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_water_disabled_turn_off = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1261, 1948, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_water_turn_off = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1261, 2028, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_s8catapult = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1501, 1228, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_s8catapult_disabled = {
		a_name = "kr6_gui_common-1.dds",
		size = {84, 84},
		trim = {5, 5, 5, 5},
		a_size = {2824, 2820},
		f_quad = {1581, 1228, 74, 74},
		alias = {}
	},
	quickmenu_main_icon_s7barrack = scene_icon({84, 84}, {5, 5, 5, 5}, {1341, 1228, 74, 74}),
	quickmenu_main_icon_s7barrack_disabled = scene_icon({84, 84}, {5, 5, 5, 5}, {1421, 1228, 74, 74}),
	quickmenu_main_icon_s11_archers = scene_icon({84, 84}, {5, 5, 5, 5}, {1181, 2508, 74, 74}),
	quickmenu_main_icon_s11_archers_disabled = scene_icon({84, 84}, {5, 5, 5, 5}, {1181, 2588, 74, 74}),
	quickmenu_main_icon_levelup = scene_icon({84, 84}, {5, 5, 5, 5}, {1981, 1148, 74, 74}),
	quickmenu_main_icon_levelup_disabled = scene_icon({84, 84}, {5, 5, 5, 5}, {2061, 1148, 74, 74}),
	quickmenu_main_icon_joust_red = scene_icon({84, 84}, {5, 5, 5, 5}, {1501, 1148, 74, 74}),
	quickmenu_main_icon_joust_red_disabled = scene_icon({84, 84}, {5, 5, 5, 5}, {1581, 1148, 74, 74}),
	quickmenu_main_icon_joust_blue = scene_icon({84, 84}, {5, 5, 5, 5}, {1181, 1148, 74, 74}),
	quickmenu_main_icon_joust_blue_disabled = scene_icon({84, 84}, {5, 5, 5, 5}, {1261, 1148, 74, 74}),
	quickmenu_special_icons_st14_0001 = scene_icon({70, 70}, {0, 0, 0, 0}, {1949, 2203, 70, 70}),
	quickmenu_special_icons_st14_0001_disabled = scene_icon({70, 70}, {0, 0, 0, 0}, {1949, 2279, 70, 70}),
	quickmenu_special_icons_st14_0002 = scene_icon({70, 70}, {0, 0, 0, 0}, {1949, 2507, 70, 70}),
	quickmenu_special_icons_st14_0002_disabled = scene_icon({70, 70}, {0, 0, 0, 0}, {1949, 2583, 70, 70}),
	quickmenu_special_icons_st14_0003 = scene_icon({70, 70}, {0, 0, 0, 0}, {2025, 1975, 70, 70}),
	quickmenu_special_icons_st14_0003_disabled = scene_icon({70, 70}, {0, 0, 0, 0}, {2101, 1975, 70, 70}),
	kr6_scene_special_icons_confirm = scene_icon({70, 70}, {0, 0, 0, 0}, {1493, 2051, 70, 70}),
	kr6_scene_special_icons_confirm_disabled = scene_icon({70, 70}, {0, 0, 0, 0}, {1493, 2127, 70, 70}),
	kr6_scene_rally = scene_icon({107, 107}, {19, 19, 19, 13}, {2405, 2423, 69, 75}),
	kr6_scene_rally_disabled = scene_icon({107, 107}, {19, 19, 19, 13}, {2405, 2504, 69, 75}),
	kr6_scene_rally_hover = scene_icon({141, 141}, {28, 27, 28, 27}, {920, 1691, 85, 87})
}

return atlas
