return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_melting_furnace",
		"tower_orc_warriors_den",
		"tower_wicked_sisters",
		"zeta_levels"
	},
	required_textures = {},
	required_exoskeletons = {"mecha", "rednuclear_blob"},
	scale_required_textures = {
		"go_stage197",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"go_towers_orc_shaman",
		"go_towers_melting_furnace",
		"go_towers_orc_warriors_den",
		"go_towers_wicked_sisters",
		"zeta_kr4_gold",
		"zeta_kr4_buff_choice",
		"kr4_dwarven_empire",
		"zeta_kr4_spider_nest_redlarge",
		"zeta_mecha",
		"zeta_jw_rednuclear_tower",
		"zeta_kr4_level83_magnet",
		"zeta_kr4_level83_cave",
		"zeta_kr4_level83_stone",
		"zeta_kr4_level86_stone",
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
				x = 582,
				y = 60
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 197,
			zeta_source_level = 83,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 110,
			end_ni = 228,
			duration = 4,
		},
		{
			template = "controller_teleport_enemies",
			path = 7,
			start_ni = 1,
			end_ni = 9,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 8,
			start_ni = 1,
			end_ni = 9,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 9,
			start_ni = 1,
			end_ni = 9,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4197",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 572,
				y = 644
			},
			["tower.default_rally_pos"] = {
				x = 630,
				y = 600
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 311,
				y = 424
			},
			["tower.default_rally_pos"] = {
				x = 320,
				y = 368
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 385,
				y = 479
			},
			["tower.default_rally_pos"] = {
				x = 481,
				y = 504
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 585,
				y = 491
			},
			["tower.default_rally_pos"] = {
				x = 481,
				y = 504
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 695,
				y = 472
			},
			["tower.default_rally_pos"] = {
				x = 694,
				y = 408
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 185,
				y = 266
			},
			["tower.default_rally_pos"] = {
				x = 150,
				y = 360
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 285,
				y = 231
			},
			["tower.default_rally_pos"] = {
				x = 287,
				y = 178
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 392,
				y = 281
			},
			["tower.default_rally_pos"] = {
				x = 415,
				y = 224
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 555,
				y = 265
			},
			["tower.default_rally_pos"] = {
				x = 523,
				y = 210
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 615,
				y = 326
			},
			["tower.default_rally_pos"] = {
				x = 703,
				y = 340
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 808,
				y = 312
			},
			["tower.default_rally_pos"] = {
				x = 808,
				y = 249
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 90,
				y = 100
			},
			["tower.default_rally_pos"] = {
				x = 142,
				y = 182
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 480,
				y = 119
			},
			["tower.default_rally_pos"] = {
				x = 512,
				y = 206
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 690,
				y = 118
			},
			["tower.default_rally_pos"] = {
				x = 587,
				y = 138
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 797,
				y = 157
			},
			["tower.default_rally_pos"] = {
				x = 803,
				y = 249
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "dummy_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 664,
				y = 187
			},
			["tower.default_rally_pos"] = {
				x = 527,
				y = 206
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = -30,
				y = -83
			},
			["tower.default_rally_pos"] = {
				x = -35,
				y = -70
			},
			["ui.nav_mesh_id"] = "17",
			["tower.holder_id"] = "17"
		},
		{
			["editor.r"] = 2.94419709,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -46,
				y = 245
			}
		},
		{
			["editor.r"] = 3.14159265,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -4,
				y = 268
			}
		},
		{
			["editor.r"] = -2.94419709,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = -46,
				y = 291
			}
		},
		{
			["editor.r"] = 1.89254688,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 635,
				y = 695
			}
		},
		{
			["editor.r"] = 1.98902066,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 672,
				y = 670
			}
		},
		{
			["editor.r"] = 2.15879893,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 675,
				y = 715
			}
		},
		{
			["editor.r"] = 0.39479112,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 796,
				y = 463
			}
		},
		{
			["editor.r"] = 0.52807445,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 826,
				y = 427
			}
		},
		{
			["editor.r"] = 2.72469458,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 333,
				y = 594
			}
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -170,
				y = 384
			},
			["render.sprites[1].name"] = "Stage_83_cave",
			["render.sprites[1].animated"] = false,
			["render.sprites[1].anchor.x"] = 0,
			["render.sprites[1].anchor.y"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 508,
				y = 60
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 652,
				y = 60
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 920,
				y = 218
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 920,
				y = 338
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 582,
				y = 60
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 920,
				y = 288
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		}
	},
	invalid_path_ranges = {
		{
			from = 100,
			to = 238,
			path_id = 6,
		},
		{
			from = 1,
			to = 11,
			path_id = 7,
		},
		{
			from = 1,
			to = 11,
			path_id = 8,
		},
		{
			from = 1,
			to = 11,
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
			3,
			nil,
			5,
			4
		},
		{
			6,
			3,
			3,
			8
		},
		{
			2,
			1,
			4,
			2
		},
		{
			3,
			1,
			5,
			10
		},
		{
			4,
			1,
			11,
			10
		},
		{
			12,
			2,
			7,
			7
		},
		{
			6,
			6,
			8,
			13
		},
		{
			7,
			2,
			9,
			7
		},
		{
			8,
			10,
			10,
			16
		},
		{
			9,
			5,
			16,
			9
		},
		{
			16,
			5,
			nil,
			15
		},
		{
			17,
			6,
			6,
			17
		},
		{
			8,
			9,
			9,
			17
		},
		{
			16,
			16,
			15,
			nil
		},
		{
			14,
			11,
			nil,
			14
		},
		{
			9,
			9,
			14,
			14
		},
		{
			nil,
			12,
			12,
			nil
		}
	}
}
