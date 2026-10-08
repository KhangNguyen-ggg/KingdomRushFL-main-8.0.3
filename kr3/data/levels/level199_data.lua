return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_orc_warriors_den",
		"tower_wicked_sisters",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage199",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"kr4_spider_nest",
		"go_stage71",
		"go_towers_orc_warriors_den",
		"go_towers_wicked_sisters",
		"go_enemies_terrain_2",
		"zeta_kr4_elves_tower_barrack_empty",
		"zeta_kr4_gold",
		"zeta_kr4_spider_nest_redlarge",
		"zeta_kr4_spider_nest_redsmall",
		"zeta_kr1_enemies_torment",
		"zeta_kr1_enemies_wastelands",
		"zeta_kr1_minicerberus",
		"zeta_kr1_stage12",
		"zeta_kr1_stage21",
		"kr4_power_reinforcements",
		"go_towers_melting_furnace",
		"go_hero_oloch",
		"go_hero_murglun"
	},
	level_terrain_type = 14,
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
				x = 514,
				y = 635
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 199,
			zeta_source_level = 85,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 2,
			start_ni = 61,
			end_ni = 93,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 3,
			start_ni = 167,
			end_ni = 199,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 143,
			end_ni = 175,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4199",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 325,
				y = 95
			},
			["tower.default_rally_pos"] = {
				x = 330,
				y = 182
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 512,
				y = 92
			},
			["tower.default_rally_pos"] = {
				x = 510,
				y = 185
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 678,
				y = 51
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 135
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 982,
				y = 74
			},
			["tower.default_rally_pos"] = {
				x = 980,
				y = 167
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 802,
				y = 223
			},
			["tower.default_rally_pos"] = {
				x = 882,
				y = 270
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 586,
				y = 247
			},
			["tower.default_rally_pos"] = {
				x = 586,
				y = 338
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 357,
				y = 261
			},
			["tower.default_rally_pos"] = {
				x = 357,
				y = 358
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 232,
				y = 260
			},
			["tower.default_rally_pos"] = {
				x = 232,
				y = 353
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 74,
				y = 397
			},
			["tower.default_rally_pos"] = {
				x = 168,
				y = 435
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 300,
				y = 418
			},
			["tower.default_rally_pos"] = {
				x = 300,
				y = 361
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 463,
				y = 423
			},
			["tower.default_rally_pos"] = {
				x = 470,
				y = 358
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 575,
				y = 398
			},
			["tower.default_rally_pos"] = {
				x = 600,
				y = 344
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 836,
				y = 605
			},
			["tower.default_rally_pos"] = {
				x = 741,
				y = 585
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 610,
				y = 511
			},
			["tower.default_rally_pos"] = {
				x = 600,
				y = 600
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 483,
				y = 529
			},
			["tower.default_rally_pos"] = {
				x = 575,
				y = 570
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 281,
				y = 518
			},
			["tower.default_rally_pos"] = {
				x = 300,
				y = 611
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 387,
				y = 670
			},
			["tower.default_rally_pos"] = {
				x = 400,
				y = 608
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			template = "zeta_cerberus_holder",
			pos = {
				x = 132,
				y = 177
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = -30,
				y = -83
			},
			["tower.default_rally_pos"] = {
				x = -35,
				y = -70
			},
			["ui.nav_mesh_id"] = "19",
			["tower.holder_id"] = "19"
		},
		{
			["editor.r"] = 0,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 633,
				y = 366
			}
		},
		{
			["editor.r"] = -0.24497866,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1050,
				y = 170
			}
		},
		{
			["editor.r"] = 0.24497866,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 1050,
				y = 130
			}
		},
		{
			["editor.r"] = -1.2722974,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 198,
				y = 65
			}
		},
		{
			["editor.r"] = 2.89661399,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -10,
				y = 300
			}
		},
		{
			["editor.r"] = -2.89661399,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -10,
				y = 340
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 435,
				y = 720
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 593,
				y = 720
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 514,
				y = 725
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 140,
				y = 227
			}
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 840,
				y = 188
			}
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 512,
				y = 474
			}
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 937,
				y = 737
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 933,
				y = 731
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 933,
				y = 725
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 921,
				y = 719
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 987,
				y = 746
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 993,
				y = 739
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 978,
				y = 716
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1019,
				y = 703
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 985,
				y = 627
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 993,
				y = 410
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1001,
				y = 450
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 989,
				y = 400
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 995,
				y = 440
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 924,
				y = 437
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 956,
				y = 404
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 925,
				y = 384
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 950,
				y = 470
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 66,
				y = 740
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = -8,
				y = 690
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 45,
				y = 112
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 0,
				y = 172
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 20,
				y = 42
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 25,
				y = 64
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		}
	},
	invalid_path_ranges = {
		{
			from = 57,
			to = 97,
			path_id = 2,
		},
		{
			from = 163,
			to = 203,
			path_id = 3,
		},
		{
			from = 139,
			to = 179,
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
			8,
			7,
			2,
			19
		},
		{
			1,
			6,
			3,
			nil
		},
		{
			2,
			5,
			5,
			nil
		},
		{
			5,
			5,
			nil,
			nil
		},
		{
			3,
			12,
			4,
			3
		},
		{
			2,
			12,
			3,
			2
		},
		{
			8,
			10,
			11,
			1
		},
		{
			18,
			10,
			7,
			18
		},
		{
			nil,
			16,
			8,
			8
		},
		{
			8,
			16,
			11,
			7
		},
		{
			10,
			15,
			12,
			7
		},
		{
			11,
			14,
			5,
			6
		},
		{
			14,
			nil,
			nil,
			14
		},
		{
			15,
			13,
			13,
			12
		},
		{
			17,
			17,
			14,
			11
		},
		{
			9,
			17,
			17,
			10
		},
		{
			16,
			nil,
			15,
			15
		},
		{
			19,
			8,
			8,
			1
		},
		{
			nil,
			18,
			18,
			nil
		}
	}
}
