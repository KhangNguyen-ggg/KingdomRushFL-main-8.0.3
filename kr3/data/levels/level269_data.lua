-- chunkname: @./kr6/data/levels/level269_data.lua

return {
	locked_hero = false,
	level_terrain_type = 5,
	max_upgrade_level = 6,
	custom_spawn_pos = {
		{
			pos = {
				x = 841,
				y = 675
			}
		},
		{
			pos = {
				x = 1112,
				y = 231
			}
		},
		{
			pos = {
				x = 328,
				y = 324
			}
		},
		{
			pos = {
				x = 474,
				y = 306
			}
		}
	},
	custom_start_pos = {
		zoom = 1.3,
		pos = {
			x = 650,
			y = 425
		}
	},
	entities_list = {
		{
			min_delay = 7,
			template = "background_sounds_kr5",
			max_delay = 13,
			only_on_preparation = true,
			sounds = {
				"KR6Terrain1AmbienceSoundBirds",
				"KR6Terrain1AmbienceSoundWind",
				"Terrain1AmbienceSoundCicadas"
			}
		},
		{
			template = "controller_show_buy_available"
		},
		{
			template = "controller_stage_14_community_building_achievement"
		},
		{
			template = "controller_stage_14_houses"
		},
		{
			template = "debug_path_renderer",
			["path_debug.background_color"] = {
				46,
				193,
				142,
				0
			},
			["path_debug.path_color"] = {
				168,
				199,
				169,
				0
			},
			pos = {
				x = -300,
				y = 868
			}
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "Stage14_0001",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 1112,
				y = 231
			}
		},
		{
			["editor.flip"] = 0,
			["editor.orientation"] = 4,
			template = "decal_defend_point5",
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			pos = {
				x = 835,
				y = 681
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 1112,
				y = 187
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 1112,
				y = 281
			}
		},
		{
			["editor.flip"] = 1,
			["editor.tag"] = 0,
			template = "decal_defense_flag5",
			pos = {
				x = 778,
				y = 681
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_defense_flag5",
			pos = {
				x = 894,
				y = 681
			}
		},
		{
			template = "decal_stage_14_armory",
			pos = {
				x = 579,
				y = 448
			}
		},
		{
			template = "decal_stage_14_armory_alert",
			pos = {
				x = 477,
				y = 454
			}
		},
		{
			template = "decal_stage_14_blacksmith",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_blacksmith_alert",
			pos = {
				x = 649,
				y = 271
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat",
			pos = {
				x = 699,
				y = 83
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat",
			pos = {
				x = 182,
				y = 153
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat",
			pos = {
				x = 581,
				y = 191
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat",
			pos = {
				x = 87,
				y = 226
			}
		},
		{
			["editor.flip"] = 0,
			template = "decal_stage_14_goat",
			pos = {
				x = 1028,
				y = 505
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_small",
			pos = {
				x = 622,
				y = 206
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_small",
			pos = {
				x = 122,
				y = 213
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_small",
			pos = {
				x = 1064,
				y = 523
			}
		},
		{
			["editor.flip"] = 1,
			template = "decal_stage_14_goat_small",
			pos = {
				x = 594,
				y = 631
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 119,
				y = 560
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 455,
				y = 640
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 224,
				y = 654
			}
		},
		{
			template = "decal_stage_14_house",
			pos = {
				x = 382,
				y = 655
			}
		},
		{
			template = "decal_stage_14_mask_1_g6",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_10",
			pos = {
				x = 508,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_2_g6",
			pos = {
				x = 512,
				y = 531
			}
		},
		{
			template = "decal_stage_14_mask_3_g6",
			pos = {
				x = 512,
				y = 461
			}
		},
		{
			template = "decal_stage_14_mask_4_g6",
			pos = {
				x = 512,
				y = 429
			}
		},
		{
			template = "decal_stage_14_mask_5",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_6",
			pos = {
				x = 512,
				y = 84
			}
		},
		{
			template = "decal_stage_14_mask_7",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_mask_8",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "decal_stage_14_tavern",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			["editor.r"] = -1.2566370614359,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 463,
				y = 151
			}
		},
		{
			["editor.r"] = -1.2217304763961,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = 509,
				y = 151
			}
		},
		{
			["editor.r"] = 3.1590459461097,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -28,
				y = 436
			}
		},
		{
			["editor.r"] = 3.1660272631177,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 130,
			pos = {
				x = -28,
				y = 481
			}
		},
		{
			["tower.holder_id"] = "6",
			["tower.terrain_style"] = 55,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "6",
			pos = {
				x = 522,
				y = 230
			},
			["tower.default_rally_pos"] = {
				x = 554,
				y = 325
			}
		},
		{
			["tower.holder_id"] = "3",
			["tower.terrain_style"] = 55,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "3",
			pos = {
				x = 484,
				y = 481
			},
			["tower.default_rally_pos"] = {
				x = 436,
				y = 402
			}
		},
		{
			["tower.holder_id"] = "8",
			["tower.terrain_style"] = 55,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "8",
			pos = {
				x = 728,
				y = 486
			},
			["tower.default_rally_pos"] = {
				x = 814,
				y = 446
			}
		},
		{
			["tower.holder_id"] = "2",
			["tower.terrain_style"] = 55,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "2",
			pos = {
				x = 153,
				y = 491
			},
			["tower.default_rally_pos"] = {
				x = 219,
				y = 443
			}
		},
		{
			["tower.holder_id"] = "11",
			["tower.terrain_style"] = 55,
			template = "tower_holder_terrain_3_1",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "11",
			pos = {
				x = 838,
				y = 518
			},
			["tower.default_rally_pos"] = {
				x = 915,
				y = 574
			}
		},
		{
			["tower.holder_id"] = "10",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "10",
			pos = {
				x = 870,
				y = 243
			},
			["tower.default_rally_pos"] = {
				x = 794,
				y = 185
			}
		},
		{
			["tower.holder_id"] = "12",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "12",
			pos = {
				x = 1018,
				y = 290
			},
			["tower.default_rally_pos"] = {
				x = 1010,
				y = 211
			}
		},
		{
			["tower.holder_id"] = "9",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "9",
			pos = {
				x = 801,
				y = 320
			},
			["tower.default_rally_pos"] = {
				x = 722,
				y = 390
			}
		},
		{
			["tower.holder_id"] = "4",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "4",
			pos = {
				x = 376,
				y = 322
			},
			["tower.default_rally_pos"] = {
				x = 458,
				y = 339
			}
		},
		{
			["tower.holder_id"] = "1",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "1",
			pos = {
				x = 139,
				y = 346
			},
			["tower.default_rally_pos"] = {
				x = 102,
				y = 420
			}
		},
		{
			["tower.holder_id"] = "5",
			["tower.terrain_style"] = 56,
			template = "tower_holder_terrain_3_2",
			["editor.game_mode"] = 0,
			["ui.nav_mesh_id"] = "5",
			pos = {
				x = 310,
				y = 384
			},
			["tower.default_rally_pos"] = {
				x = 389,
				y = 448
			}
		},
		{
			["tower.holder_id"] = "42",
			["ui.nav_mesh_id"] = "42",
			template = "tower_stage_14_blacksmith",
			["editor.game_mode"] = 0,
			pos = {
				x = 638,
				y = 200
			},
			["tower.default_rally_pos"] = {
				x = 644,
				y = 109
			}
		},
		{
			["tower.holder_id"] = "46",
			["ui.nav_mesh_id"] = "46",
			template = "tower_stage_14_broken_armory",
			["editor.game_mode"] = 0,
			pos = {
				x = 590,
				y = 418
			},
			["tower.default_rally_pos"] = {
				x = 576,
				y = 332
			}
		}
	},
	invalid_path_ranges = {},
	level_mode_overrides = {
		{
			locked_towers = {}
		},
		{
			max_upgrade_level = 5,
			locked_towers = {
				"tower_royal_archers_lvl4",
				"tower_paladin_covenant_lvl4",
				"tower_arcane_wizard_lvl4",
				"tower_tricannon_lvl4",
				"tower_arborean_emissary_lvl4",
				"tower_demon_pit_lvl4",
				"tower_elven_stargazers_lvl4",
				"tower_rocket_gunners_lvl4",
				"tower_necromancer_lvl4",
				"tower_ballista_lvl4",
				"tower_flamespitter_lvl4",
				"tower_barrel_lvl4",
				"tower_sand_lvl4",
				"tower_ghost_lvl4",
				"tower_ray_lvl4",
				"tower_dark_elf_lvl4",
				"tower_dwarf_lvl4",
				"tower_hermit_toad_lvl4",
				"tower_sparking_geode_lvl4"
			}
		},
		{
			available_towers = {
				"tower_build_wizard",
				"tower_build_catapult"
			},
			locked_towers = {}
		}
	},
	nav_mesh = {
		{
			5,
			2
		},
		{
			3,
			nil,
			nil,
			1
		},
		{
			8,
			nil,
			2,
			4
		},
		{
			6,
			3,
			5,
			6
		},
		{
			3,
			3,
			1,
			4
		},
		{
			7,
			3,
			4
		},
		{
			9,
			8,
			6
		},
		{
			11,
			nil,
			6,
			9
		},
		{
			nil,
			8,
			7,
			10
		},
		{
			12,
			9
		},
		{
			[3] = 8,
			[4] = 9
		},
		{
			nil,
			11,
			10
		},
		[42] = {},
		[44] = {},
		[46] = {}
	},
	required_exoskeletons = {
		"stage14_barracksDef",
		"stage14_barracks_alertDef",
		"stage14_blacksmithDef",
		"stage14_blacksmith_alertDef",
		"stage14_tavernDef",
		"stage14_blacksmithauraDef",
		"stage14_tavernauraDef",
		"stage14_tavernkeeperDef"
	},
	required_sounds = {
		"music_stage269",
		"kr6_enemies_T3",
		"stage_269",
		"kr6_terrain_1_common",
		"kr6_terrain_3_common"
	},
	required_textures = {
		"go_stage269_bg",
		"go_stage269",
		"go_enemies_T3",
		"kr6_gui_common_crane"
	}
}


