return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"zeta_levels"
	},
	required_textures = {},
	scale_required_textures = {
		"go_stage198",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"kr4_spider_nest",
		"go_stage71",
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
				x = 93,
				y = 88
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 198,
			zeta_source_level = 84,
			pos = {
				x = 0,
				y = 0
			}
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
			path = 5,
			start_ni = 26,
			end_ni = 40,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4198",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 285,
				y = 530
			},
			["tower.default_rally_pos"] = {
				x = 345,
				y = 500
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 175,
				y = 456
			},
			["tower.default_rally_pos"] = {
				x = 233,
				y = 417
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 353,
				y = 364
			},
			["tower.default_rally_pos"] = {
				x = 353,
				y = 300
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 151,
				y = 202
			},
			["tower.default_rally_pos"] = {
				x = 165,
				y = 125
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 254,
				y = 210
			},
			["tower.default_rally_pos"] = {
				x = 254,
				y = 305
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 352,
				y = 203
			},
			["tower.default_rally_pos"] = {
				x = 352,
				y = 130
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 300,
				y = 39
			},
			["tower.default_rally_pos"] = {
				x = 280,
				y = 123
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 514,
				y = 92
			},
			["tower.default_rally_pos"] = {
				x = 420,
				y = 150
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 561,
				y = 155
			},
			["tower.default_rally_pos"] = {
				x = 650,
				y = 150
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 587,
				y = 222
			},
			["tower.default_rally_pos"] = {
				x = 655,
				y = 200
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 626,
				y = 350
			},
			["tower.default_rally_pos"] = {
				x = 635,
				y = 288
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 696,
				y = 380
			},
			["tower.default_rally_pos"] = {
				x = 700,
				y = 320
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 780,
				y = 243
			},
			["tower.default_rally_pos"] = {
				x = 760,
				y = 333
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 37,
			pos = {
				x = 715,
				y = 43
			},
			["tower.default_rally_pos"] = {
				x = 630,
				y = 66
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			["editor.r"] = 3.14159265,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -80,
				y = 220
			}
		},
		{
			["editor.r"] = 3.14159265,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -80,
				y = 260
			}
		},
		{
			["editor.r"] = 2.03444394,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 298,
				y = 694
			}
		},
		{
			["editor.r"] = 2.11507681,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 336,
				y = 714
			}
		},
		{
			["editor.r"] = 1.05165021,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 590,
				y = 460
			}
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 943,
				y = 438
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 943,
				y = 319
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 943,
				y = 383
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 44,
				y = 125
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 143,
				y = 39
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 93,
				y = 88
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 534,
				y = 22
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 682,
				y = 13
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 605,
				y = 20
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 40,
				y = 327
			}
		},
		{
			template = "zeta_demon_crystal",
			pos = {
				x = 832,
				y = 188
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
				x = 593,
				y = 529
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 601,
				y = 550
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 989,
				y = 117
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 995,
				y = 118
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 724,
				y = 577
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 716,
				y = 604
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 725,
				y = 584
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 750,
				y = 570
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 766,
				y = 540
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 758,
				y = 590
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 791,
				y = 612
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1007,
				y = 165
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 0
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1010,
				y = 152
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		},
		{
			template = "zeta_lava_glow",
			pos = {
				x = 1009,
				y = 144
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["render.sprites[1].alpha"] = 255
		}
	},
	invalid_path_ranges = {
		{
			from = 1,
			to = 6,
			path_id = 5,
		},
		{
			from = 23,
			to = 43,
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
			2,
			nil,
			3,
			2
		},
		{
			nil,
			1,
			1,
			3
		},
		{
			1,
			1,
			11,
			6
		},
		{
			nil,
			2,
			5,
			7
		},
		{
			4,
			3,
			6,
			7
		},
		{
			5,
			3,
			8,
			7
		},
		{
			4,
			6,
			8,
			nil
		},
		{
			6,
			9,
			9,
			nil
		},
		{
			8,
			10,
			10,
			8
		},
		{
			9,
			11,
			12,
			9
		},
		{
			3,
			12,
			12,
			10
		},
		{
			11,
			1,
			13,
			11
		},
		{
			12,
			12,
			nil,
			14
		},
		{
			9,
			9,
			nil,
			nil
		}
	}
}
