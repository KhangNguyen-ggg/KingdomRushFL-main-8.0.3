return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_orc_warriors_den",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage195",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"go_towers_twilight_barrack",
		"zeta_kr4_gold",
		"kr4_frozen_north",
		"kr4_mercenary_troll_hut",
		"kr4_hielo",
		"kr4_spider_nest",
		"zeta_kr4_spider_nest_redlarge",
		"zeta_legacy_enemies",
		"go_towers_orc_warriors_den",
		"kr4_power_reinforcements"
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
				x = 495,
				y = 35
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 195,
			zeta_source_level = 22,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 50,
			end_ni = 133,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4195",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 266,
				y = 607
			},
			["tower.default_rally_pos"] = {
				x = 198,
				y = 545
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 70,
				y = 547
			},
			["tower.default_rally_pos"] = {
				x = 761,
				y = 504
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 358,
				y = 507
			},
			["tower.default_rally_pos"] = {
				x = 290,
				y = 460
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 162,
				y = 482
			},
			["tower.default_rally_pos"] = {
				x = 260,
				y = 460
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 470,
				y = 126
			},
			["tower.default_rally_pos"] = {
				x = 530,
				y = 90
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 527,
				y = 478
			},
			["tower.default_rally_pos"] = {
				x = 540,
				y = 412
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 348,
				y = 370
			},
			["tower.default_rally_pos"] = {
				x = 330,
				y = 310
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 513,
				y = 333
			},
			["tower.default_rally_pos"] = {
				x = 488,
				y = 270
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 690,
				y = 379
			},
			["tower.default_rally_pos"] = {
				x = 592,
				y = 380
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 150,
				y = 329
			},
			["tower.default_rally_pos"] = {
				x = 240,
				y = 310
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 280,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 270,
				y = 320
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 490,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 460,
				y = 287
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 685,
				y = 280
			},
			["tower.default_rally_pos"] = {
				x = 590,
				y = 280
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 870,
				y = 196
			},
			["tower.default_rally_pos"] = {
				x = 903,
				y = 289
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 580,
				y = 161
			},
			["tower.default_rally_pos"] = {
				x = 655,
				y = 165
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 725,
				y = 63
			},
			["tower.default_rally_pos"] = {
				x = 660,
				y = 135
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 745,
				y = 190
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 16
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 85,
				y = 507
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 17
			},
			["ui.nav_mesh_id"] = "18",
			["tower.holder_id"] = "18"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 314,
				y = 546
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 18
			},
			["ui.nav_mesh_id"] = "19",
			["tower.holder_id"] = "19"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 440,
				y = 477
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 19
			},
			["ui.nav_mesh_id"] = "20",
			["tower.holder_id"] = "20"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 450,
				y = 299
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 20
			},
			["ui.nav_mesh_id"] = "21",
			["tower.holder_id"] = "21"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 180,
				y = 387
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 21
			},
			["ui.nav_mesh_id"] = "22",
			["tower.holder_id"] = "22"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 90,
				y = 257
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 22
			},
			["ui.nav_mesh_id"] = "23",
			["tower.holder_id"] = "23"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 880,
				y = 57
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 23
			},
			["ui.nav_mesh_id"] = "24",
			["tower.holder_id"] = "24"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 710,
				y = 326
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 24
			},
			["ui.nav_mesh_id"] = "25",
			["tower.holder_id"] = "25"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 850,
				y = 487
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 25
			},
			["ui.nav_mesh_id"] = "26",
			["tower.holder_id"] = "26"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 750,
				y = 567
			},
			["tower.default_rally_pos"] = {
				x = 0,
				y = 26
			},
			["ui.nav_mesh_id"] = "27",
			["tower.holder_id"] = "27"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = 840,
				y = 207
			},
			["tower.default_rally_pos"] = {
				x = 840,
				y = 135
			},
			["ui.nav_mesh_id"] = "28",
			["tower.holder_id"] = "28"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 39,
			pos = {
				x = -30,
				y = -73
			},
			["tower.default_rally_pos"] = {
				x = -34,
				y = -56
			},
			["ui.nav_mesh_id"] = "29",
			["tower.holder_id"] = "29"
		},
		{
			["editor.r"] = 1.39270339,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 62,
				y = 717
			}
		},
		{
			["editor.r"] = 1.74888927,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 102,
				y = 717
			}
		},
		{
			["editor.r"] = 0.18919902,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 788,
				y = 577
			}
		},
		{
			["editor.r"] = 0.53495507,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 781,
				y = 541
			}
		},
		{
			["editor.r"] = 0.98279372,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 817,
				y = 531
			}
		},
		{
			["editor.r"] = 1.75748566,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 358,
				y = 717
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 100,
				y = 220
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 244,
				y = 180
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 568,
				y = 14
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 421,
				y = 17
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 132,
				y = 93
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 495,
				y = 34
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
	},
	invalid_path_ranges = {
		{
			from = 47,
			to = 136,
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
			4,
			nil,
			19,
			19
		},
		{
			nil,
			nil,
			18,
			18
		},
		{
			19,
			19,
			20,
			20
		},
		{
			18,
			2,
			1,
			22
		},
		{
			11,
			12,
			15,
			29
		},
		{
			20,
			27,
			9,
			8
		},
		{
			11,
			3,
			21,
			21
		},
		{
			21,
			6,
			13,
			21
		},
		{
			8,
			6,
			25,
			25
		},
		{
			23,
			22,
			22,
			23
		},
		{
			10,
			7,
			7,
			5
		},
		{
			21,
			21,
			15,
			5
		},
		{
			15,
			25,
			25,
			17
		},
		{
			28,
			28,
			nil,
			24
		},
		{
			12,
			13,
			13,
			16
		},
		{
			15,
			17,
			24,
			nil
		},
		{
			13,
			13,
			28,
			16
		},
		{
			2,
			2,
			4,
			22
		},
		{
			1,
			1,
			3,
			3
		},
		{
			3,
			3,
			6,
			7
		},
		{
			7,
			8,
			8,
			12
		},
		{
			10,
			4,
			7,
			10
		},
		{
			29,
			10,
			10,
			29
		},
		{
			16,
			14,
			nil,
			nil
		},
		{
			13,
			9,
			28,
			13
		},
		{
			27,
			27,
			nil,
			9
		},
		{
			6,
			nil,
			26,
			26
		},
		{
			17,
			13,
			14,
			14
		},
		{
			nil,
			23,
			23,
			nil
		}
	}
}
