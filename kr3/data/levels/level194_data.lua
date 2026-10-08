return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage194",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"zeta_kr4_gold",
		"kr4_frozen_north",
		"kr4_mercenary_troll_hut",
		"kr4_hielo",
		"kr4_power_reinforcements",
		"go_towers_orc_warriors_den",
	},
	level_terrain_type = 406,
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
				x = 590,
				y = 33
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 194,
			zeta_source_level = 21,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 2,
			start_ni = 149,
			end_ni = 264,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 3,
			end_ni = 37,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 82,
			end_ni = 108,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4194",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 0,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 80,
				y = 520
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = 190,
				y = 532
			},
			["tower.default_rally_pos"] = {
				x = 80,
				y = 530
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 185,
				y = 330
			},
			["tower.default_rally_pos"] = {
				x = 190,
				y = 260
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 179,
				y = 167
			},
			["tower.default_rally_pos"] = {
				x = 89,
				y = 190
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = 266,
				y = 179
			},
			["tower.default_rally_pos"] = {
				x = 260,
				y = 286
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = -15,
				y = 142
			},
			["tower.default_rally_pos"] = {
				x = 80,
				y = 165
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 410,
				y = 302
			},
			["tower.default_rally_pos"] = {
				x = 360,
				y = 390
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 270,
				y = 427
			},
			["tower.default_rally_pos"] = {
				x = 340,
				y = 390
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 580,
				y = 352
			},
			["tower.default_rally_pos"] = {
				x = 545,
				y = 430
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = 665,
				y = 483
			},
			["tower.default_rally_pos"] = {
				x = 640,
				y = 420
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 880,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 890,
				y = 420
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 780,
				y = 331
			},
			["tower.default_rally_pos"] = {
				x = 780,
				y = 420
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 955,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 865,
				y = 270
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 1045,
				y = 385
			},
			["tower.default_rally_pos"] = {
				x = 990,
				y = 460
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = 765,
				y = 173
			},
			["tower.default_rally_pos"] = {
				x = 750,
				y = 110
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 820,
				y = 38
			},
			["tower.default_rally_pos"] = {
				x = 815,
				y = 120
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 630,
				y = 187
			},
			["tower.default_rally_pos"] = {
				x = 570,
				y = 130
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = -8,
				y = 427
			},
			["tower.default_rally_pos"] = {
				x = 2,
				y = 475
			},
			["ui.nav_mesh_id"] = "18",
			["tower.holder_id"] = "18"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 25,
				y = 317
			},
			["tower.default_rally_pos"] = {
				x = 17,
				y = 274
			},
			["ui.nav_mesh_id"] = "19",
			["tower.holder_id"] = "19"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 20,
				y = 67
			},
			["tower.default_rally_pos"] = {
				x = 15,
				y = 28
			},
			["ui.nav_mesh_id"] = "20",
			["tower.holder_id"] = "20"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 390,
				y = 461
			},
			["tower.default_rally_pos"] = {
				x = 250,
				y = 370
			},
			["ui.nav_mesh_id"] = "21",
			["tower.holder_id"] = "21"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 760,
				y = 472
			},
			["tower.default_rally_pos"] = {
				x = 670,
				y = 304
			},
			["ui.nav_mesh_id"] = "22",
			["tower.holder_id"] = "22"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 900,
				y = 642
			},
			["tower.default_rally_pos"] = {
				x = 765,
				y = 291
			},
			["ui.nav_mesh_id"] = "23",
			["tower.holder_id"] = "23"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 960,
				y = 327
			},
			["tower.default_rally_pos"] = {
				x = 580,
				y = 306
			},
			["ui.nav_mesh_id"] = "24",
			["tower.holder_id"] = "24"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 770,
				y = 247
			},
			["tower.default_rally_pos"] = {
				x = 672,
				y = 304
			},
			["ui.nav_mesh_id"] = "25",
			["tower.holder_id"] = "25"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 954,
				y = 151
			},
			["tower.default_rally_pos"] = {
				x = 242,
				y = 465
			},
			["ui.nav_mesh_id"] = "26",
			["tower.holder_id"] = "26"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 720,
				y = 25
			},
			["tower.default_rally_pos"] = {
				x = 613,
				y = 544
			},
			["ui.nav_mesh_id"] = "27",
			["tower.holder_id"] = "27"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 550,
				y = 460
			},
			["tower.default_rally_pos"] = {
				x = 546,
				y = 552
			},
			["ui.nav_mesh_id"] = "28",
			["tower.holder_id"] = "28"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 447,
				y = 432
			},
			["tower.default_rally_pos"] = {
				x = 359,
				y = 421
			},
			["ui.nav_mesh_id"] = "29",
			["tower.holder_id"] = "29"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = 465,
				y = 491
			},
			["tower.default_rally_pos"] = {
				x = 550,
				y = 450
			},
			["ui.nav_mesh_id"] = "30",
			["tower.holder_id"] = "30"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -80,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -150,
				y = -50
			},
			["ui.nav_mesh_id"] = "31",
			["tower.holder_id"] = "31"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -81,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "32",
			["tower.holder_id"] = "32"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -82,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "33",
			["tower.holder_id"] = "33"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -83,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "34",
			["tower.holder_id"] = "34"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -84,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "35",
			["tower.holder_id"] = "35"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -85,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "36",
			["tower.holder_id"] = "36"
		},
		{
			template = "holder_frozen_lands_blocked",
			["tower.terrain_style"] = 39,
			pos = {
				x = -86,
				y = -65
			},
			["tower.default_rally_pos"] = {
				x = -30,
				y = -30
			},
			["ui.nav_mesh_id"] = "37",
			["tower.holder_id"] = "37"
		},
		{
			["editor.r"] = -2.99814039,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -114,
				y = 613
			}
		},
		{
			["editor.r"] = 3.00904112,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -114,
				y = 568
			}
		},
		{
			["editor.r"] = 1.43698535,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 823,
				y = 718
			}
		},
		{
			["editor.r"] = 1.7046073,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 866,
				y = 718
			}
		},
		{
			["editor.r"] = -3.12492753,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -114,
				y = 308
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 522,
				y = 28
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 662,
				y = 28
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 496,
				y = 550
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 632,
				y = 590
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 562,
				y = 585
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 593,
				y = 46
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "the_thing",
			pos = {
				x = 241,
				y = 579
			},
			["render.sprites[1].z"] = Z_DECALS
		}
	},
	invalid_path_ranges = {
		{
			from = 146,
			to = 267,
			path_id = 2,
		},
		{
			from = 2,
			to = 38,
			path_id = 5,
		},
		{
			from = 80,
			to = 110,
			path_id = 5,
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
			nil,
			nil,
			2,
			18
		},
		{
			1,
			nil,
			8,
			8
		},
		{
			19,
			8,
			8,
			4
		},
		{
			20,
			3,
			5,
			20
		},
		{
			4,
			3,
			7,
			20
		},
		{
			nil,
			19,
			20,
			20
		},
		{
			8,
			29,
			9,
			5
		},
		{
			3,
			2,
			21,
			3
		},
		{
			29,
			28,
			10,
			17
		},
		{
			28,
			23,
			22,
			9
		},
		{
			22,
			23,
			24,
			24
		},
		{
			10,
			22,
			24,
			25
		},
		{
			25,
			24,
			14,
			26
		},
		{
			24,
			11,
			nil,
			24
		},
		{
			17,
			25,
			16,
			16
		},
		{
			27,
			15,
			26,
			nil
		},
		{
			7,
			25,
			15,
			27
		},
		{
			nil,
			1,
			3,
			19
		},
		{
			nil,
			18,
			3,
			6
		},
		{
			6,
			6,
			4,
			31
		},
		{
			8,
			30,
			29,
			29
		},
		{
			10,
			23,
			11,
			12
		},
		{
			22,
			nil,
			14,
			11
		},
		{
			11,
			14,
			14,
			13
		},
		{
			17,
			12,
			13,
			15
		},
		{
			16,
			13,
			14,
			16
		},
		{
			17,
			15,
			16,
			nil
		},
		{
			30,
			30,
			10,
			9
		},
		{
			21,
			30,
			28,
			7
		},
		{
			21,
			nil,
			28,
			29
		},
		{
			32,
			20,
			20,
			nil
		},
		{
			33,
			20,
			31,
			nil
		},
		{
			34,
			20,
			32,
			nil
		},
		{
			35,
			20,
			33,
			nil
		},
		{
			36,
			20,
			34,
			nil
		},
		{
			37,
			20,
			35,
			nil
		},
		{
			nil,
			20,
			36,
			nil
		}
	}
}
