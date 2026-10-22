local frames = {
	encyclopedia_creeps_0980 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 247}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {0, 0, 260, 247}, alias = {}
	},
	encyclopedia_creeps_0981 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 247}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {260, 0, 260, 247}, alias = {}
	},
	encyclopedia_creeps_0982 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 247}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {520, 0, 260, 247}, alias = {}
	},
	encyclopedia_creeps_0983 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 247}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {780, 0, 260, 247}, alias = {}
	},
	encyclopedia_creeps_0984 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 250}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {1040, 0, 260, 250}, alias = {}
	},
	encyclopedia_creeps_0985 = {
		a_name = "rebborn_enemy_icons-1.png", size = {260, 250}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {1300, 0, 260, 250}, alias = {}
	},
	alert_creep_notxt_0980 = {
		a_name = "rebborn_enemy_icons-1.png", size = {92, 81}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {0, 260, 92, 81}, alias = {}
	},
	alert_creep_notxt_0981 = {
		a_name = "rebborn_enemy_icons-1.png", size = {92, 81}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {92, 260, 92, 81}, alias = {}
	},
	alert_creep_notxt_0982 = {
		a_name = "rebborn_enemy_icons-1.png", size = {92, 81}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {184, 260, 92, 81}, alias = {}
	},
	alert_creep_notxt_0983 = {
		a_name = "rebborn_enemy_icons-1.png", size = {92, 81}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {276, 260, 92, 81}, alias = {}
	},
	alert_creep_notxt_0984 = {
		a_name = "rebborn_enemy_icons-1.png", size = {92, 81}, trim = {0, 0, 0, 0},
		a_size = {2048, 512}, f_quad = {368, 260, 92, 81}, alias = {}
	},
	encyclopedia_creep_thumbs_0980 = {
		a_name = "rebborn_enemy_icons-1.png", size = {61, 56}, trim = {0, 2, 0, 0},
		a_size = {2048, 512}, f_quad = {0, 350, 61, 56}, alias = {}
	},
	encyclopedia_creep_thumbs_0981 = {
		a_name = "rebborn_enemy_icons-1.png", size = {61, 56}, trim = {0, 2, 0, 0},
		a_size = {2048, 512}, f_quad = {61, 350, 61, 56}, alias = {}
	},
	encyclopedia_creep_thumbs_0982 = {
		a_name = "rebborn_enemy_icons-1.png", size = {61, 56}, trim = {0, 2, 0, 0},
		a_size = {2048, 512}, f_quad = {122, 350, 61, 56}, alias = {}
	},
	encyclopedia_creep_thumbs_0983 = {
		a_name = "rebborn_enemy_icons-1.png", size = {61, 56}, trim = {0, 2, 0, 0},
		a_size = {2048, 512}, f_quad = {183, 350, 61, 56}, alias = {}
	},
	encyclopedia_creep_thumbs_0984 = {
		a_name = "rebborn_enemy_icons-1.png", size = {61, 56}, trim = {0, 4, 0, 0},
		a_size = {2048, 512}, f_quad = {244, 350, 61, 56}, alias = {}
	},
	encyclopedia_creep_thumbs_0985 = {
		a_name = "rebborn_enemy_icons-1.png", size = {64, 62}, trim = {1, 5, 2, 1},
		a_size = {2048, 512}, f_quad = {305, 350, 61, 56}, alias = {}
	}
}

-- Rebborn's Hammerhold enemies are KR2 entries.  Preserve the old 980-985
-- keys because notification data still references them directly.
for i = 0, 5 do
	frames[string.format("encyclopedia_creep_thumbs_%04d", 261 + i)] =
		frames[string.format("encyclopedia_creep_thumbs_%04d", 980 + i)]
	frames[string.format("encyclopedia_creeps_%04d", 261 + i)] =
		frames[string.format("encyclopedia_creeps_%04d", 980 + i)]
end

return frames
