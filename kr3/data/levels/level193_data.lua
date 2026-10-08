return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage193",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"zeta_kr4_gold",
		"kr4_frozen_north",
		"kr4_mercenary_troll_hut",
		"kr4_hielo",
		"kr4_sharks",
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
				x = 750,
				y = 70
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 193,
			zeta_source_level = 20,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 115,
			end_ni = 153,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 118,
			end_ni = 196,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4193",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 238,
				y = 458
			},
			["tower.default_rally_pos"] = {
				x = 240,
				y = 551
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 214,
				y = 618
			},
			["tower.default_rally_pos"] = {
				x = 200,
				y = 560
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 328,
				y = 605
			},
			["tower.default_rally_pos"] = {
				x = 340,
				y = 535
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 442,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 422,
				y = 567
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 606,
				y = 489
			},
			["tower.default_rally_pos"] = {
				x = 659,
				y = 444
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 800,
				y = 587
			},
			["tower.default_rally_pos"] = {
				x = 820,
				y = 525
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 930,
				y = 467
			},
			["tower.default_rally_pos"] = {
				x = 930,
				y = 560
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 810,
				y = 395
			},
			["tower.default_rally_pos"] = {
				x = 720,
				y = 460
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 990,
				y = 297
			},
			["tower.default_rally_pos"] = {
				x = 890,
				y = 305
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 855,
				y = 174
			},
			["tower.default_rally_pos"] = {
				x = 740,
				y = 168
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 798,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 888,
				y = 245
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 640,
				y = 93
			},
			["tower.default_rally_pos"] = {
				x = 660,
				y = 185
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 457,
				y = 203
			},
			["tower.default_rally_pos"] = {
				x = 465,
				y = 140
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 190,
				y = 202
			},
			["tower.default_rally_pos"] = {
				x = 210,
				y = 275
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 305,
				y = 330
			},
			["tower.default_rally_pos"] = {
				x = 305,
				y = 259
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 140,
				y = 471
			},
			["tower.default_rally_pos"] = {
				x = 160,
				y = 525
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 300,
				y = 397
			},
			["tower.default_rally_pos"] = {
				x = 345,
				y = 400
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 225,
				y = 342
			},
			["tower.default_rally_pos"] = {
				x = 210,
				y = 285
			},
			["ui.nav_mesh_id"] = "18",
			["tower.holder_id"] = "18"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 316,
				y = 83
			},
			["tower.default_rally_pos"] = {
				x = 315,
				y = 135
			},
			["ui.nav_mesh_id"] = "19",
			["tower.holder_id"] = "19"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 245,
				y = 152
			},
			["tower.default_rally_pos"] = {
				x = 245,
				y = 200
			},
			["ui.nav_mesh_id"] = "20",
			["tower.holder_id"] = "20"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 715,
				y = 357
			},
			["tower.default_rally_pos"] = {
				x = 670,
				y = 400
			},
			["ui.nav_mesh_id"] = "21",
			["tower.holder_id"] = "21"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 800,
				y = 322
			},
			["tower.default_rally_pos"] = {
				x = 840,
				y = 325
			},
			["ui.nav_mesh_id"] = "22",
			["tower.holder_id"] = "22"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 580,
				y = 577
			},
			["tower.default_rally_pos"] = {
				x = 625,
				y = 600
			},
			["ui.nav_mesh_id"] = "23",
			["tower.holder_id"] = "23"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 880,
				y = 607
			},
			["tower.default_rally_pos"] = {
				x = 316,
				y = 96
			},
			["ui.nav_mesh_id"] = "24",
			["tower.holder_id"] = "24"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = -30,
				y = -53
			},
			["tower.default_rally_pos"] = {
				x = 65,
				y = -15
			},
			["ui.nav_mesh_id"] = "25",
			["tower.holder_id"] = "25"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = -35,
				y = -53
			},
			["tower.default_rally_pos"] = {
				x = 65,
				y = -15
			},
			["ui.nav_mesh_id"] = "26",
			["tower.holder_id"] = "26"
		},
		{
			["editor.r"] = 0.32175055,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1140,
				y = 482
			}
		},
		{
			["editor.r"] = 0.16514868,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1140,
				y = 532
			}
		},
		{
			["editor.r"] = 1.8736812,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 670,
				y = 718
			}
		},
		{
			["editor.r"] = 1.57079633,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 620,
				y = 718
			}
		},
		{
			["editor.r"] = -3.11595725,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -116,
				y = 577
			}
		},
		{
			["editor.r"] = -3.1245003,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -116,
				y = 630
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 685,
				y = 60
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 822,
				y = 65
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 1060,
				y = 283
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 1000,
				y = 161
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 40,
				y = 366
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 40,
				y = 241
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 750,
				y = 70
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 1030,
				y = 228
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 40,
				y = 307
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "touch",
			pos = {
				x = 229,
				y = 689
			},
			["render.sprites[1].z"] = Z_DECALS
		}
	},
	invalid_path_ranges = {
		{
			from = 112,
			to = 161,
			path_id = 5,
		},
		{
			from = 114,
			to = 200,
			path_id = 6,
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
			16,
			2,
			17,
			17
		},
		{
			16,
			nil,
			3,
			1
		},
		{
			2,
			nil,
			4,
			4
		},
		{
			3,
			3,
			5,
			17
		},
		{
			4,
			23,
			21,
			21
		},
		{
			5,
			nil,
			24,
			7
		},
		{
			8,
			24,
			9,
			8
		},
		{
			21,
			7,
			7,
			22
		},
		{
			7,
			7,
			nil,
			10
		},
		{
			11,
			11,
			9,
			12
		},
		{
			21,
			22,
			10,
			10
		},
		{
			13,
			11,
			11,
			nil
		},
		{
			19,
			15,
			12,
			19
		},
		{
			25,
			18,
			20,
			20
		},
		{
			18,
			17,
			13,
			14
		},
		{
			nil,
			2,
			1,
			18
		},
		{
			1,
			1,
			4,
			15
		},
		{
			16,
			17,
			15,
			14
		},
		{
			20,
			20,
			13,
			25
		},
		{
			14,
			14,
			19,
			19
		},
		{
			5,
			8,
			22,
			22
		},
		{
			21,
			8,
			10,
			11
		},
		{
			4,
			nil,
			6,
			5
		},
		{
			6,
			nil,
			7,
			7
		},
		{
			26,
			14,
			14,
			nil
		},
		{
			nil,
			14,
			25,
			nil
		}
	}
}
