return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_infernal_mage",
		"zeta_levels"
	},
	required_textures = {},
	required_exoskeletons = {"demon_veznan"},
	scale_required_textures = {
		"go_stage200",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"kr4_spider_nest",
		"zeta_base_kr4_item_veznan_wrath",
		"go_stage71",
		"go_towers_infernal_mage",
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
		"kr4_level16_2_pc",
		"zeta_kr4_level86_cave",
		"zeta_kr4_level86_stone",
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
				x = 727,
				y = 55
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 200,
			zeta_source_level = 86,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 2,
			start_ni = 87,
			end_ni = 116,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 5,
			start_ni = 1,
			end_ni = 6,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 1,
			end_ni = 6,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4200",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 705,
				y = 670
			},
			["tower.default_rally_pos"] = {
				x = 682,
				y = 620
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 418,
				y = 595
			},
			["tower.default_rally_pos"] = {
				x = 390,
				y = 528
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 593,
				y = 547
			},
			["tower.default_rally_pos"] = {
				x = 576,
				y = 490
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 750,
				y = 531
			},
			["tower.default_rally_pos"] = {
				x = 750,
				y = 472
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 281,
				y = 468
			},
			["tower.default_rally_pos"] = {
				x = 308,
				y = 560
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 363,
				y = 407
			},
			["tower.default_rally_pos"] = {
				x = 350,
				y = 345
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 564,
				y = 393
			},
			["tower.default_rally_pos"] = {
				x = 660,
				y = 380
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 787,
				y = 379
			},
			["tower.default_rally_pos"] = {
				x = 767,
				y = 305
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 871,
				y = 337
			},
			["tower.default_rally_pos"] = {
				x = 850,
				y = 268
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 265,
				y = 185
			},
			["tower.default_rally_pos"] = {
				x = 250,
				y = 121
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 366,
				y = 209
			},
			["tower.default_rally_pos"] = {
				x = 380,
				y = 140
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 574,
				y = 210
			},
			["tower.default_rally_pos"] = {
				x = 560,
				y = 140
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 733,
				y = 209
			},
			["tower.default_rally_pos"] = {
				x = 770,
				y = 300
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 807,
				y = 149
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 120
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 530,
				y = 51
			},
			["tower.default_rally_pos"] = {
				x = 530,
				y = 140
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			["editor.r"] = 2.08994244,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 499,
				y = 707
			}
		},
		{
			["editor.r"] = 2.18269876,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 535,
				y = 723
			}
		},
		{
			["editor.r"] = 2.75406885,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 208,
				y = 570
			}
		},
		{
			["editor.r"] = 2.90930366,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 223,
				y = 608
			}
		},
		{
			["editor.r"] = -0.14189705,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 900,
				y = 474
			}
		},
		{
			["editor.r"] = 0.14189705,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 900,
				y = 434
			}
		},
		{
			["editor.r"] = 2.67794504,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 225,
				y = 360
			}
		},
		{
			["editor.r"] = 2.88488432,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 240,
				y = 396
			}
		},
		{
			["editor.r"] = 2.9996956,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 50,
				y = 140
			}
		},
		{
			["editor.r"] = -2.9996956,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 50,
				y = 180
			}
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -170,
				y = 0
			},
			["render.sprites[1].name"] = "Stage_86_cave",
			["render.sprites[1].animated"] = false,
			["render.sprites[1].anchor.x"] = 0,
			["render.sprites[1].anchor.y"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 960,
				y = 285
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 980,
				y = 160
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 970,
				y = 230
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 800,
				y = 75
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 654,
				y = 37
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 727,
				y = 56
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
				x = 817,
				y = 528
			}
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 646,
				y = 230
			}
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 977,
				y = 737
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 983,
				y = 731
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1033,
				y = 725
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1021,
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
				x = 1078,
				y = 716
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1119,
				y = 723
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 985,
				y = 687
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 993,
				y = 610
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1001,
				y = 550
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 989,
				y = 500
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 995,
				y = 540
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1024,
				y = 537
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1056,
				y = 474
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1025,
				y = 584
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1050,
				y = 570
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
		}
	},
	invalid_path_ranges = {
		{
			from = 84,
			to = 119,
			path_id = 2,
		},
		{
			from = 1,
			to = 6,
			path_id = 5,
		},
		{
			from = 1,
			to = 6,
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
			3,
			nil,
			9,
			4
		},
		{
			5,
			nil,
			3,
			5
		},
		{
			2,
			1,
			4,
			7
		},
		{
			3,
			1,
			9,
			8
		},
		{
			nil,
			2,
			6,
			6
		},
		{
			5,
			5,
			7,
			11
		},
		{
			6,
			3,
			8,
			12
		},
		{
			7,
			4,
			9,
			9
		},
		{
			8,
			8,
			nil,
			13
		},
		{
			nil,
			6,
			11,
			15
		},
		{
			10,
			6,
			12,
			15
		},
		{
			11,
			7,
			13,
			15
		},
		{
			12,
			8,
			14,
			14
		},
		{
			13,
			13,
			nil,
			15
		},
		{
			11,
			12,
			13,
			nil
		}
	}
}
