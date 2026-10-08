return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_orc_warriors_den",
		"tower_shaolin",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage196",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"kr4_spider_nest",
		"go_stage165",
		"go_towers_orc_warriors_den",
		"go_towers_shaolin",
		"zeta_kr4_gold",
		"kr4_dwarven_empire",
		"zeta_kr4_spider_nest_redlarge",
		"kr4_power_reinforcements"
	},
	level_terrain_type = 400,
	locked_hero = false,
	max_upgrade_level = 5,
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 512,
			y = 384
		}
	},
	custom_spawn_pos = {
		{
			pos = {
				x = 30,
				y = 377
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 196,
			zeta_source_level = 82,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 3,
			start_ni = 103,
			end_ni = 143,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 4,
			start_ni = 127,
			end_ni = 186,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 1,
			end_ni = 5,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 1,
			end_ni = 5,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 7,
			start_ni = 1,
			end_ni = 4,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 8,
			start_ni = 1,
			end_ni = 4,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 9,
			start_ni = 1,
			end_ni = 3,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 9,
			start_ni = 57,
			end_ni = 97,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4196",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 573,
				y = 528
			},
			["tower.default_rally_pos"] = {
				x = 520,
				y = 462
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 760,
				y = 454
			},
			["tower.default_rally_pos"] = {
				x = 760,
				y = 545
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 672,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 580,
				y = 400
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 855,
				y = 469
			},
			["tower.default_rally_pos"] = {
				x = 830,
				y = 555
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 713,
				y = 227
			},
			["tower.default_rally_pos"] = {
				x = 643,
				y = 171
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 820,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 800,
				y = 346
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 898,
				y = 229
			},
			["tower.default_rally_pos"] = {
				x = 922,
				y = 176
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 800,
				y = 82
			},
			["tower.default_rally_pos"] = {
				x = 800,
				y = 166
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 596,
				y = 103
			},
			["tower.default_rally_pos"] = {
				x = 560,
				y = 176
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 516,
				y = 242
			},
			["tower.default_rally_pos"] = {
				x = 520,
				y = 180
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 466,
				y = 398
			},
			["tower.default_rally_pos"] = {
				x = 475,
				y = 340
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 301,
				y = 349
			},
			["tower.default_rally_pos"] = {
				x = 300,
				y = 295
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 238,
				y = 412
			},
			["tower.default_rally_pos"] = {
				x = 140,
				y = 420
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 262,
				y = 515
			},
			["tower.default_rally_pos"] = {
				x = 160,
				y = 510
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 417,
				y = 221
			},
			["tower.default_rally_pos"] = {
				x = 425,
				y = 168
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 255,
				y = 207
			},
			["tower.default_rally_pos"] = {
				x = 255,
				y = 290
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 355,
				y = 491
			},
			["tower.default_rally_pos"] = {
				x = 420,
				y = 520
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = -100,
				y = -56
			},
			["tower.default_rally_pos"] = {
				x = -90,
				y = -35
			},
			["ui.nav_mesh_id"] = "18",
			["tower.holder_id"] = "18"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = -101,
				y = -56
			},
			["tower.default_rally_pos"] = {
				x = -91,
				y = -35
			},
			["ui.nav_mesh_id"] = "19",
			["tower.holder_id"] = "19"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = -102,
				y = -56
			},
			["tower.default_rally_pos"] = {
				x = -92,
				y = -35
			},
			["ui.nav_mesh_id"] = "20",
			["tower.holder_id"] = "20"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 320,
				y = 147
			},
			["tower.default_rally_pos"] = {
				x = 390,
				y = 100
			},
			["ui.nav_mesh_id"] = "21",
			["tower.holder_id"] = "21"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 1040,
				y = 117
			},
			["tower.default_rally_pos"] = {
				x = 940,
				y = 180
			},
			["ui.nav_mesh_id"] = "22",
			["tower.holder_id"] = "22"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 100,
				y = 312
			},
			["tower.default_rally_pos"] = {
				x = 100,
				y = 400
			},
			["ui.nav_mesh_id"] = "23",
			["tower.holder_id"] = "23"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 950,
				y = 287
			},
			["tower.default_rally_pos"] = {
				x = 1030,
				y = 240
			},
			["ui.nav_mesh_id"] = "24",
			["tower.holder_id"] = "24"
		},
		{
			["editor.r"] = 1.10714872,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 420,
				y = 730
			}
		},
		{
			["editor.r"] = 1.29249667,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 420,
				y = 690
			}
		},
		{
			["editor.r"] = 2.03444394,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 460,
				y = 730
			}
		},
		{
			["editor.r"] = 1.84909599,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 460,
				y = 690
			}
		},
		{
			["editor.r"] = 0.09966865,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 850,
				y = 385
			}
		},
		{
			["editor.r"] = 0.27829966,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 865,
				y = 345
			}
		},
		{
			["editor.r"] = 0.47569522,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1067,
				y = 303
			}
		},
		{
			["editor.r"] = 0.86217005,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1100,
				y = 270
			}
		},
		{
			["editor.r"] = 0.86217005,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 911,
				y = 640
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 26,
				y = 424
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 36,
				y = 322
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 334,
				y = 50
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 466,
				y = 50
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 30,
				y = 378
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 400,
				y = 52
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		}
	},
	invalid_path_ranges = {
		{
			from = 101,
			to = 145,
			path_id = 3,
		},
		{
			from = 126,
			to = 187,
			path_id = 4,
		},
		{
			from = 1,
			to = 7,
			path_id = 5,
		},
		{
			from = 1,
			to = 7,
			path_id = 6,
		},
		{
			from = 1,
			to = 5,
			path_id = 7,
		},
		{
			from = 1,
			to = 5,
			path_id = 8,
		},
		{
			from = 1,
			to = 4,
			path_id = 9,
		},
		{
			from = 55,
			to = 99,
			path_id = 9,
		},
	},
	level_mode_overrides = {
		[3] = {
			locked_hero = false,
			locked_towers = {},
			max_upgrade_level = 5
		}
	},
	nav_mesh = {
		{
			11,
			nil,
			3,
			11
		},
		{
			3,
			1,
			4,
			3
		},
		{
			1,
			2,
			2,
			5
		},
		{
			2,
			nil,
			24,
			3
		},
		{
			9,
			6,
			6,
			8
		},
		{
			5,
			3,
			7,
			7
		},
		{
			6,
			24,
			24,
			8
		},
		{
			5,
			5,
			7,
			nil
		},
		{
			10,
			10,
			5,
			nil
		},
		{
			15,
			11,
			9,
			9
		},
		{
			17,
			17,
			1,
			10
		},
		{
			13,
			13,
			17,
			16
		},
		{
			23,
			14,
			12,
			12
		},
		{
			23,
			nil,
			17,
			13
		},
		{
			21,
			12,
			10,
			21
		},
		{
			23,
			12,
			21,
			21
		},
		{
			14,
			nil,
			11,
			13
		},
		{
			19,
			23,
			23,
			nil
		},
		{
			20,
			23,
			18,
			nil
		},
		{
			nil,
			23,
			19,
			nil
		},
		{
			16,
			16,
			15,
			18
		},
		{
			7,
			7,
			nil,
			nil
		},
		{
			18,
			13,
			13,
			16
		},
		{
			7,
			4,
			22,
			7
		}
	}
}
