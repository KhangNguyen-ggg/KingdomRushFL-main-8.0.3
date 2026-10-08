return {
	required_sounds = {
		"branch_campaigns",
		"powers_kr4",
		"tower_grim_cemetery",
		"tower_swamp_monster",
		"zeta_levels"
	},
	required_textures = {},
	required_exoskeletons = {"mecha", "rednuclear_blob"},
	scale_required_textures = {
		"go_stage201",
		"zeta_base_kr4_common_effects",
		"zeta_jw_gui",
		"zeta_base_kr4_item_juggernaut",
		"go_towers_orc_shaman",
		"go_towers_grim_cemetery",
		"go_towers_swamp_monster",
		"zeta_kr4_gold",
		"kr4_dwarven_empire",
		"zeta_kr4_spider_nest_redlarge",
		"zeta_mecha",
		"zeta_jw_rednuclear_tower",
		"zeta_kr3_hero_wilbur",
		"zeta_kr4_item_juggernaut_eva",
		"zeta_kr4_deep_devils_spear",
		"go_hero_asra",
		"zeta_kr4_level87_cave",
		"zeta_kr4_level87_mask",
		"zeta_kr4_level87_statue",
		"kr4_sapos",
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
				x = 410,
				y = 50
			}
		}
	},
	entities_list = {
		{
			template = "kr4_branch_stage_controller",
			level = 201,
			zeta_source_level = 87,
			pos = {
				x = 0,
				y = 0
			}
		},
		{
			template = "controller_teleport_enemies",
			path = 1,
			start_ni = 102,
			end_ni = 123,
			duration = 1,
		},
		{
			template = "controller_teleport_enemies",
			path = 6,
			start_ni = 110,
			end_ni = 130,
			duration = 1,
		},
		{
			template = "controller_teleport_enemies",
			path = 7,
			start_ni = 1,
			end_ni = 11,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 8,
			start_ni = 1,
			end_ni = 11,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 9,
			start_ni = 1,
			end_ni = 11,
			duration = 0.5,
		},
		{
			template = "controller_teleport_enemies",
			path = 10,
			start_ni = 1,
			end_ni = 11,
			duration = 0.5,
		},
		{
			template = "decal_background",
			["render.sprites[1].z"] = 1000,
			["render.sprites[1].name"] = "stage_4201",
			pos = {
				x = 512,
				y = 384
			}
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 319,
				y = 549
			},
			["tower.default_rally_pos"] = {
				x = 292,
				y = 490
			},
			["ui.nav_mesh_id"] = "1",
			["tower.holder_id"] = "1"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 693,
				y = 541
			},
			["tower.default_rally_pos"] = {
				x = 727,
				y = 501
			},
			["ui.nav_mesh_id"] = "2",
			["tower.holder_id"] = "2"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 184,
				y = 429
			},
			["tower.default_rally_pos"] = {
				x = 243,
				y = 507
			},
			["ui.nav_mesh_id"] = "3",
			["tower.holder_id"] = "3"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 260,
				y = 402
			},
			["tower.default_rally_pos"] = {
				x = 259,
				y = 349
			},
			["ui.nav_mesh_id"] = "4",
			["tower.holder_id"] = "4"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 758,
				y = 417
			},
			["tower.default_rally_pos"] = {
				x = 760,
				y = 354
			},
			["ui.nav_mesh_id"] = "5",
			["tower.holder_id"] = "5"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 831,
				y = 443
			},
			["tower.default_rally_pos"] = {
				x = 774,
				y = 513
			},
			["ui.nav_mesh_id"] = "6",
			["tower.holder_id"] = "6"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 225,
				y = 262
			},
			["tower.default_rally_pos"] = {
				x = 222,
				y = 204
			},
			["ui.nav_mesh_id"] = "7",
			["tower.holder_id"] = "7"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 422,
				y = 292
			},
			["tower.default_rally_pos"] = {
				x = 421,
				y = 376
			},
			["ui.nav_mesh_id"] = "8",
			["tower.holder_id"] = "8"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 508,
				y = 257
			},
			["tower.default_rally_pos"] = {
				x = 510,
				y = 201
			},
			["ui.nav_mesh_id"] = "9",
			["tower.holder_id"] = "9"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 596,
				y = 288
			},
			["tower.default_rally_pos"] = {
				x = 591,
				y = 375
			},
			["ui.nav_mesh_id"] = "10",
			["tower.holder_id"] = "10"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 801,
				y = 271
			},
			["tower.default_rally_pos"] = {
				x = 801,
				y = 220
			},
			["ui.nav_mesh_id"] = "11",
			["tower.holder_id"] = "11"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 219,
				y = 122
			},
			["tower.default_rally_pos"] = {
				x = 218,
				y = 202
			},
			["ui.nav_mesh_id"] = "12",
			["tower.holder_id"] = "12"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 315,
				y = 121
			},
			["tower.default_rally_pos"] = {
				x = 375,
				y = 203
			},
			["ui.nav_mesh_id"] = "13",
			["tower.holder_id"] = "13"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 519,
				y = 115
			},
			["tower.default_rally_pos"] = {
				x = 515,
				y = 202
			},
			["ui.nav_mesh_id"] = "14",
			["tower.holder_id"] = "14"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 722,
				y = 130
			},
			["tower.default_rally_pos"] = {
				x = 683,
				y = 220
			},
			["ui.nav_mesh_id"] = "15",
			["tower.holder_id"] = "15"
		},
		{
			template = "tower_holder",
			["tower.terrain_style"] = 38,
			pos = {
				x = 878,
				y = 137
			},
			["tower.default_rally_pos"] = {
				x = 868,
				y = 216
			},
			["ui.nav_mesh_id"] = "16",
			["tower.holder_id"] = "16"
		},
		{
			["editor.r"] = 0.98279372,
			["editor.path_id"] = 1,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 228,
				y = 615
			}
		},
		{
			["editor.r"] = 1.152572,
			["editor.path_id"] = 2,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 231,
				y = 570
			}
		},
		{
			["editor.r"] = 1.24904577,
			["editor.path_id"] = 3,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 268,
				y = 595
			}
		},
		{
			["editor.r"] = 1.89254688,
			["editor.path_id"] = 4,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 710,
				y = 625
			}
		},
		{
			["editor.r"] = 1.98902066,
			["editor.path_id"] = 5,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 747,
				y = 600
			}
		},
		{
			["editor.r"] = 2.15879893,
			["editor.path_id"] = 6,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 750,
				y = 645
			}
		},
		{
			["editor.r"] = 3.14159265,
			["editor.path_id"] = 7,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 120,
				y = 360
			}
		},
		{
			["editor.r"] = 3.14159265,
			["editor.path_id"] = 8,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 120,
				y = 213
			}
		},
		{
			["editor.r"] = 0,
			["editor.path_id"] = 9,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 880,
				y = 361
			}
		},
		{
			["editor.r"] = 0,
			["editor.path_id"] = 10,
			template = "editor_wave_flag",
			["editor.len"] = 200,
			pos = {
				x = 880,
				y = 223
			}
		},
		{
			template = "fx_repeat_forever",
			pos = {
				x = -170,
				y = 152
			},
			["render.sprites[1].name"] = "Stage_87_cave",
			["render.sprites[1].animated"] = false,
			["render.sprites[1].anchor.x"] = 0,
			["render.sprites[1].anchor.y"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 335,
				y = 48
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 485,
				y = 48
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 548,
				y = 48
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defense_flag5",
			pos = {
				x = 698,
				y = 48
			},
			["render.sprites[1].z"] = Z_OBJECTS,
			["editor.flip"] = 0,
			["editor.tag"] = 0
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 410,
				y = 48
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		},
		{
			template = "decal_defend_point5",
			pos = {
				x = 623,
				y = 48
			},
			["editor.flip"] = 0,
			["editor.exit_id"] = 1,
			["editor.alpha"] = 10,
			["editor.orientation"] = 1
		}
	},
	invalid_path_ranges = {
		{
			from = 90,
			to = 135,
			path_id = 1,
		},
		{
			from = 98,
			to = 142,
			path_id = 6,
		},
		{
			from = 1,
			to = 13,
			path_id = 7,
		},
		{
			from = 1,
			to = 13,
			path_id = 8,
		},
		{
			from = 1,
			to = 13,
			path_id = 9,
		},
		{
			from = 1,
			to = 13,
			path_id = 10,
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
			8,
			4
		},
		{
			10,
			nil,
			5,
			5
		},
		{
			nil,
			1,
			4,
			4
		},
		{
			3,
			3,
			1,
			7
		},
		{
			2,
			6,
			6,
			11
		},
		{
			5,
			2,
			nil,
			5
		},
		{
			nil,
			4,
			13,
			12
		},
		{
			4,
			4,
			9,
			9
		},
		{
			8,
			8,
			10,
			14
		},
		{
			9,
			5,
			15,
			9
		},
		{
			15,
			5,
			16,
			16
		},
		{
			nil,
			7,
			13,
			nil
		},
		{
			12,
			7,
			8,
			nil
		},
		{
			8,
			9,
			10,
			nil
		},
		{
			10,
			11,
			16,
			nil
		},
		{
			11,
			11,
			nil,
			nil
		}
	}
}
