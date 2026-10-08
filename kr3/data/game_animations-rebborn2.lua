-- Rebborn 2 heroes and Hammerhold stages: filtered from the decoded source atlas animations.
local a = {
	hero_deadeye_idle = {
		to = 100,
		prefix = "hero_deadeye",
		from = 100
	},
	hero_deadeye_death = {
		to = 49,
		prefix = "hero_deadeye",
		from = 30
	},
	hero_deadeye_levelUp = {
		to = 112,
		prefix = "hero_deadeye",
		from = 101
	},
	hero_deadeye_attack = {
		to = 29,
		prefix = "hero_deadeye",
		from = 21
	},
	hero_deadeye_running = {
		to = 118,
		prefix = "hero_deadeye",
		from = 113
	},
	hero_deadeye_horse_start = {
		to = 99,
		prefix = "hero_deadeye",
		from = 90
	},
	hero_deadeye_horse_loop = {
		to = 89,
		prefix = "hero_deadeye",
		from = 84
	},
	hero_deadeye_horse_end = {
		to = 75,
		prefix = "hero_deadeye",
		from = 83
	},
	hero_deadeye_respawn = {
		to = 112,
		prefix = "hero_deadeye",
		from = 101
	},
	hero_deadeye_shootAimRightLeft = {
		to = 11,
		prefix = "hero_deadeye",
		from = 3
	},
	hero_deadeye_shootRightLeft = {
		to = 124,
		prefix = "hero_deadeye",
		from = 122,
		post = {
			11
		}
	},
	hero_deadeye_shootAimDown = {
		prefix = "hero_deadeye",
		frames = {
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			1,
			2
		}
	},
	hero_deadeye_shootDown = {
		to = 121,
		prefix = "hero_deadeye",
		from = 119,
		post = {
			2
		}
	},
	hero_deadeye_shootAimUp = {
		to = 20,
		prefix = "hero_deadeye",
		from = 12
	},
	hero_deadeye_shootUp = {
		to = 127,
		prefix = "hero_deadeye",
		from = 125,
		post = {
			20
		}
	},
	hero_deadeye_reload = {
		to = 3,
		prefix = "hero_deadeye",
		from = 8
	},
	hero_deadeye_shotgunShootAimRightLeft = {
		to = 147,
		prefix = "hero_deadeye",
		from = 133
	},
	hero_deadeye_shotgunShootRightLeft = {
		to = 182,
		prefix = "hero_deadeye",
		from = 168,
		post = {
			147
		}
	},
	hero_deadeye_shotgunShootAimDown = {
		prefix = "hero_deadeye",
		frames = {
			133,
			134,
			135,
			136,
			137,
			138,
			139,
			140,
			141,
			142,
			128,
			129,
			130,
			131,
			132
		}
	},
	hero_deadeye_shotgunShootDown = {
		to = 167,
		prefix = "hero_deadeye",
		from = 153
	},
	hero_deadeye_shotgunShootAimUp = {
		prefix = "hero_deadeye",
		frames = {
			133,
			134,
			135,
			136,
			137,
			138,
			139,
			140,
			141,
			142,
			148,
			149,
			150,
			151,
			152
		}
	},
	hero_deadeye_shotgunShootUp = {
		to = 197,
		prefix = "hero_deadeye",
		from = 183
	},
	hero_deadeye_shotgun_reload = {
		to = 133,
		prefix = "hero_deadeye",
		from = 142
	},
	hero_deadeye_most_wanted = {
		prefix = "hero_deadeye",
		frames = {
			50,
			51,
			52,
			53,
			54,
			55,
			56,
			57,
			58,
			59,
			60,
			61,
			62,
			63,
			64,
			64,
			64,
			64,
			65,
			66,
			67,
			68,
			69,
			70,
			71,
			72,
			73,
			74,
			60,
			59,
			58,
			57,
			56,
			55,
			54,
			53,
			52,
			51,
			50
		}
	},
	hero_deadeye_bullet = {
		to = 2,
		prefix = "hero_deadeye_bullet",
		from = 2
	},
	hero_deadeye_empty = {
		to = 1,
		prefix = "hero_deadeye_bullet",
		from = 1
	},
	hero_deadeye_cash = {
		to = 6,
		prefix = "hero_deadeye_cash",
		from = 6
	},
	hero_deadeye_cash_fadein = {
		to = 6,
		prefix = "hero_deadeye_cash",
		from = 1
	},
	hero_deadeye_cash_fadeout = {
		to = 10,
		prefix = "hero_deadeye_cash",
		from = 7
	},
	hero_zezitra_shoot = {
		prefix = "ZEZITRA",
		to = 141,
		from = 113
	},
	hero_zezitra_attack = {
		prefix = "ZEZITRA",
		to = 44,
		from = 23
	},
	hero_zezitra_death = {
		to = 20,
		prefix = "ZEZITRA",
		from = 1
	},
	hero_zezitra_idle = {
		to = 21,
		prefix = "ZEZITRA",
		from = 21
	},
	hero_zezitra_levelUp = {
		prefix = "ZEZITRA",
		to = 155,
		from = 141
	},
	hero_zezitra_respawn = {
		prefix = "ZEZITRA",
		to = 155,
		from = 141
	},
	hero_zezitra_running = {
		to = 64,
		prefix = "ZEZITRA",
		from = 45
	},
	hero_zezitra_skill1 = {
		to = 88,
		prefix = "ZEZITRA",
		from = 65
	},
	hero_zezitra_skill2 = {
		to = 106,
		prefix = "ZEZITRA",
		from = 89,
		post = {
			106, 105, 104, 103, 102, 101, 100, 99, 98,
			97, 96, 95, 94, 93, 92, 91, 90, 89
		}
	},
	hero_zezitra_skill_ready = {
		to = 1,
		prefix = "rage_small",
		from = 1
	},
	hero_zezitra_orb_appear = {
		to = 8,
		prefix = "hero_zezitra_orb_appear",
		from = 1
	},
	hero_zezitra_orb_fade = {
		to = 8,
		prefix = "hero_zezitra_orb_fade",
		from = 1
	},
	hero_zezitra_orb_current = {
		to = 6,
		prefix = "hero_zezitra_orb_current",
		from = 1
	},
	hero_zezitra_shield_fade = {
		prefix = "shield_fade",
		frames = {1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7}
	},
	hero_zezitra_shield_idle = {
		prefix = "shield_idle",
		frames = {1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8}
	},
	sphinx_idle = {
		to = 1,
		prefix = "sphinx",
		from = 1
	},
	sphinx_blink = {
		to = 7,
		prefix = "sphinx",
		from = 2,
		post = {
			1
		}
	},
	sphinx_brow = {
		prefix = "sphinx",
		frames = {
			8,
			8,
			9,
			9,
			10,
			10,
			11,
			11,
			12,
			12,
			13,
			13,
			14,
			14,
			15,
			15,
			15,
			15,
			14,
			14,
			13,
			13,
			12,
			12,
			11,
			11,
			10,
			10,
			9,
			9,
			8,
			8,
			1
		}
	},
	sphinx_win = {
		prefix = "sphinx",
		frames = {
			16,
			16,
			17,
			17,
			18,
			18,
			19,
			19,
			20,
			20,
			21,
			21,
			22,
			22,
			23,
			23,
			23,
			23,
			23,
			23,
			22,
			22,
			21,
			21,
			20,
			20,
			19,
			19,
			18,
			18,
			17,
			17,
			16,
			16
		}
	},
	sphinx_lose = {
		prefix = "sphinx",
		frames = {
			24,
			24,
			25,
			25,
			26,
			26,
			27,
			27,
			28,
			28,
			29,
			29,
			30,
			30,
			31,
			31,
			31,
			31,
			31,
			31,
			30,
			30,
			29,
			29,
			28,
			28,
			27,
			27,
			26,
			26,
			25,
			25,
			24,
			24
		}
	},
	sphinx_ready = {
		prefix = "sphinx",
		frames = {
			23
		}
	},
	sphinx_obelisk = {
		prefix = "sphinx",
		frames = {
			30
		}
	},
	sphinx_bowl_idle = {
		to = 1,
		prefix = "sphinx_bowl",
		from = 1
	},
	sphinx_bowl_select = {
		to = 45,
		prefix = "sphinx_bowl",
		from = 2,
		post = {
			1
		}
	},
	sphinx_bowl_lose = {
		to = 58,
		prefix = "sphinx_bowl",
		from = 46,
		post = {
			1
		}
	},
	sphinx_bowl_win = {
		to = 59,
		prefix = "sphinx_bowl",
		from = 88,
		post = {
			8,
			7,
			6,
			5,
			4,
			3,
			2,
			1
		}
	},
	sphinx_bowl_flip_up = {
		to = 8,
		prefix = "sphinx_bowl",
		from = 1,
		post = {
			8
		}
	},
	sphinx_bowl_flip_down = {
		to = 45,
		prefix = "sphinx_bowl",
		from = 37,
		post = {
			1
		}
	},
	penumbra_explosion_strong_idle = {
		to = 14,
		prefix = "penumbra_explosion_up_strong",
		from = 1
	},
	penumbra_explosion_weak_idle = {
		to = 14,
		prefix = "penumbra_explosion_up_weak",
		from = 1
	},
	penumbra_glow_idle = {
		to = 3,
		prefix = "penumbra_glow_effect",
		from = 1
	},
	penumbra_glow_t1_idle = {
		to = 5,
		prefix = "penumbra_glow_effect_t1",
		from = 1
	},
	penumbra_glow_t2_idle = {
		to = 5,
		prefix = "penumbra_glow_effect_t2",
		from = 1
	},
	penumbra_glow_t3_idle = {
		to = 5,
		prefix = "penumbra_glow_effect_t3",
		from = 1
	},
	penumbra_puddle_idle = {
		to = 6,
		prefix = "penumbra_puddle",
		from = 1
	},
	penumbra_missile_flying = {
		to = 1,
		prefix = "penumbra_missile",
		from = 1
	},
	penumbra_missile_trail_flying = {
		to = 21,
		prefix = "penumbra_missile",
		from = 3
	},
	penumbra_idle = {
		to = 18,
		prefix = "penumbra",
		from = 1
	},
	penumbra_attack = {
		to = 54,
		prefix = "penumbra",
		from = 19
	},
	penumbra_death = {
		to = 82,
		prefix = "penumbra",
		from = 55
	},
	penumbra_respawn = {
		to = 118,
		prefix = "penumbra",
		from = 83
	},
	penumbra_dive = {
		to = 158,
		prefix = "penumbra",
		from = 119
	},
	penumbra_flap = {
		to = 192,
		prefix = "penumbra",
		from = 159
	},
	hero_ember_idle = {
		prefix = "hero_ember_basic_attack",
		to = 18,
		from = 18
	},
	hero_ember_levelUp = {
		prefix = "hero_ember_level_up",
		to = 12,
		from = 1
	},
	hero_ember_attack = {
		prefix = "hero_ember_basic_attack",
		to = 17,
		from = 1,
		post = {17, 17, 18}
	},
	hero_ember_death = {
		prefix = "hero_ember_death",
		to = 19,
		from = 1
	},
	hero_ember_respawn = {
		prefix = "hero_ember_level_up",
		to = 12,
		from = 1
	},
	hero_ember_running = {
		prefix = "hero_ember_running",
		to = 5,
		from = 1
	},
	hero_ember_jump_start = {
		prefix = "hero_ember_ability-1",
		frames = {1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4}
	},
	hero_ember_jump = {
		prefix = "hero_ember_ability-1",
		frames = {5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23}
	},
	hero_ember_magma = {
		prefix = "hero_ember_ability-1_magma",
		to = 8,
		from = 1
	},
	hero_ember_floor_magma = {
		prefix = "hero_ember_ability-1_rocks",
		to = 2,
		from = 1
	},
	hero_ember_volcano = {
		to = 10,
		from = 1,
		prefix = "hero_ember_crouch",
		post = {10}
	},
	hero_ember_ability_2 = {
		prefix = "hero_ember_ability-2",
		to = 32,
		from = 13
	},
	hero_ember_volcano_attack = {
		prefix = "hero_ember_volcano_attack",
		to = 32,
		from = 1
	},
	hero_ember_volcano_idle = {
		prefix = "hero_ember_volcano_idle",
		to = 36,
		from = 1
	},
	hero_ember_volcano_rising = {
		prefix = "hero_ember_volcano_rising",
		frames = {1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61}
	},
	hero_ember_volcano_vanish = {
		prefix = "hero_ember_volcano_vanish",
		to = 17,
		from = 1
	},
	hero_ember_rock_rise_1 = {
		prefix = "hero_ember_rock",
		frames = {
			4,
			4,
			5,
			5,
			6,
			6,
			7,
			7,
			8,
			8,
			9,
			9,
			3,
			3
		}
	},
	hero_ember_rock_rise_2 = {
		prefix = "hero_ember_rock",
		frames = {
			10,
			10,
			11,
			11,
			12,
			12,
			13,
			13,
			14,
			14,
			15,
			15,
			2,
			2
		}
	},
	hero_ember_rock_rise_3 = {
		prefix = "hero_ember_rock",
		frames = {
			16,
			16,
			17,
			17,
			18,
			18,
			19,
			19,
			20,
			20,
			21,
			21,
			1,
			1
		}
	},
	freeze_creep_ground_idle = {
		to = 7,
		prefix = "freeze_creep",
		from = 7
	},
	goblin_walk = {
		to = 22,
		prefix = "goblin",
		from = 1
	},
	rabbit_walk = {
		to = 11,
		prefix = "rabbit",
		from = 1
	},
	soldier_pirate_flamer_idle = {
		to = 1,
		prefix = "soldier_pirate_flamer",
		from = 1
	},
	soldier_pirate_flamer_running = {
		to = 6,
		prefix = "soldier_pirate_flamer",
		from = 2
	},
	soldier_pirate_flamer_attack = {
		prefix = "soldier_pirate_flamer",
		to = 38,
		from = 19,
		post = {
			1
		}
	},
	soldier_pirate_flamer_ranged_attack = {
		prefix = "soldier_pirate_flamer",
		to = 18,
		from = 7,
		post = {
			1
		}
	},
	soldier_pirate_flamer_death = {
		to = 45,
		prefix = "soldier_pirate_flamer",
		from = 39
	},
	tower_infernal_mage_shooter_idleDown = {
		to = 1,
		prefix = "tower_infernal_mage_shooter",
		from = 1
	},
	tower_infernal_mage_shooter_idleUp = {
		to = 1,
		prefix = "tower_infernal_mage_shooter",
		from = 1
	},
	tower_infernal_mage_shooter_shootDown = {
		to = 27,
		prefix = "tower_infernal_mage_shooter",
		from = 1
	},
	tower_infernal_mage_shooter_shootUp = {
		to = 27,
		prefix = "tower_infernal_mage_shooter",
		from = 1
	},
	tower_infernal_mage_shooter_spellDown = {
		to = 56,
		prefix = "tower_infernal_mage_shooter",
		from = 27
	},
	tower_infernal_mage_shooter_spellUp = {
		to = 56,
		prefix = "tower_infernal_mage_shooter",
		from = 27
	},
	mod_ward_start = {
		to = 1,
		prefix = "mage_wild_silence_fx",
		from = 1
	},
	mod_ward_loop = {
		to = 1,
		prefix = "mage_wild_silence_fx",
		from = 1
	},
	steam_troopers_bomb_new = {
		prefix = "steam_troopers_bomb_new",
		frames = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31,
			32,
			33,
			34,
			35,
			36,
			37
		}
	},
	steam_troopers_decal_new = {
		prefix = "steam_troopers_decal_new",
		frames = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			37,
			38,
			39,
			41,
			43,
			45,
			47,
			49,
			51,
			53,
			55,
			57,
			58,
			59,
			60,
			61
		}
	},
	hero_oberon_idle = {
		to = 1,
		prefix = "hero_oberon",
		from = 1
	},
	hero_oberon_running = {
		prefix = "hero_oberon",
		frames = {
			2,
			4,
			6,
			8,
			10
		}
	},
	hero_oberon_attack = {
		to = 26,
		prefix = "hero_oberon",
		from = 12
	},
	hero_oberon_levelUp = {
		to = 46,
		prefix = "hero_oberon",
		from = 27
	},
	hero_oberon_respawn = {
		to = 46,
		prefix = "hero_oberon",
		from = 27
	},
	hero_oberon_buff_levelUp = {
		to = 46,
		prefix = "hero_oberon",
		from = 27
	},
	hero_oberon_buff_respawn = {
		to = 46,
		prefix = "hero_oberon",
		from = 27
	},
	hero_oberon_death = {
		to = 60,
		prefix = "hero_oberon",
		from = 47
	},
	hero_oberon_buff_death = {
		to = 60,
		prefix = "hero_oberon",
		from = 47
	},
	hero_oberon_buff_idle = {
		to = 61,
		prefix = "hero_oberon",
		from = 61
	},
	hero_oberon_buff_running = {
		prefix = "hero_oberon",
		frames = {
			62,
			64,
			66,
			68,
			70
		}
	},
	hero_oberon_buff_attack = {
		to = 86,
		prefix = "hero_oberon",
		from = 72
	},
	hero_oberon_buff = {
		prefix = "hero_oberon",
		frames = {
			87,
			87,
			88,
			89,
			89,
			90,
			91,
			91,
			92,
			93,
			93,
			94,
			95,
			95,
			96,
			97,
			97,
			98,
			61
		}
	},
	hero_oberon_roots = {
		to = 114,
		prefix = "hero_oberon",
		from = 99
	},
	hero_oberon_buff_roots = {
		to = 126,
		prefix = "hero_oberon",
		from = 115
	},
	hero_oberon_surf = {
		to = 132,
		prefix = "hero_oberon",
		from = 127
	},
	hero_oberon_surf_startEnd = {
		to = 127,
		prefix = "hero_oberon",
		from = 127
	},
	hero_oberon_buff_surf = {
		to = 138,
		prefix = "hero_oberon",
		from = 133
	},
	hero_oberon_buff_surf_startEnd = {
		to = 133,
		prefix = "hero_oberon",
		from = 133
	},
	oberon_roots_start = {
		to = 14,
		prefix = "oberon_roots",
		from = 1
	},
	oberon_roots_end = {
		to = 1,
		prefix = "oberon_roots",
		from = 14
	},
	oberon_shield_1_idle = {
		prefix = "oberon_shield_1",
		frames = {
			1,
			1,
			2,
			3,
			3,
			4,
			5,
			5,
			6,
			7,
			7,
			8
		}
	},
	oberon_shield_1_hit = {
		to = 10,
		prefix = "oberon_shield_1",
		from = 9
	},
	oberon_shield_2_idle = {
		prefix = "oberon_shield_2",
		frames = {1, 1, 2, 3, 3, 4, 5, 5, 6, 7, 7, 8}
	},
	oberon_shield_2_hit = {
		to = 10,
		prefix = "oberon_shield_2",
		from = 9
	},
	oberon_shield_3_idle = {
		prefix = "oberon_shield_3",
		frames = {1, 1, 2, 3, 3, 4, 5, 5, 6, 7, 7, 8}
	},
	oberon_shield_3_hit = {
		to = 10,
		prefix = "oberon_shield_3",
		from = 9
	},
	enemy_primordial_attack = {
		to = 94,
		prefix = "enemy_primordial",
		from = 73
	},
	enemy_primordial_death = {
		to = 110,
		prefix = "enemy_primordial",
		from = 95
	},
	enemy_primordial_idle = {
		to = 1,
		prefix = "enemy_primordial",
		from = 1
	},
	enemy_primordial_raise = {
		to = 30,
		prefix = "enemy_primordial_raise",
		from = 1
	},
	enemy_primordial_walkingDown = {
		to = 48,
		prefix = "enemy_primordial",
		from = 25
	},
	enemy_primordial_walkingRightLeft = {
		to = 24,
		prefix = "enemy_primordial",
		from = 1
	},
	enemy_primordial_walk = {
		to = 24,
		prefix = "enemy_primordial",
		from = 1
	},
	enemy_primordial_walkingUp = {
		to = 72,
		prefix = "enemy_primordial",
		from = 49
	},
	enemy_fremen_attack = {
		to = 24,
		prefix = "enemy_fremen_atk",
		from = 1
	},
	enemy_fremen_death = {
		to = 16,
		prefix = "enemy_fremen_dead",
		from = 1
	},
	enemy_fremen_raise = {
		prefix = "enemy_fremen_raise",
		frames = {
			1,
			2,
			3,
			4,
			5,
			6,
			6,
			7,
			7,
			8,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17
		}
	},
	enemy_fremen_idle = {
		to = 1,
		prefix = "enemy_fremen_idle",
		from = 1
	},
	enemy_fremen_walkingDown = {
		to = 22,
		prefix = "enemy_fremen_run_face",
		from = 1
	},
	enemy_fremen_walkingRightLeft = {
		to = 11,
		prefix = "enemy_fremen_run",
		from = 1
	},
	enemy_fremen_running = {
		to = 11,
		prefix = "enemy_fremen_run",
		from = 1
	},
	enemy_fremen_walk = {
		to = 11,
		prefix = "enemy_fremen_run",
		from = 1
	},
	enemy_fremen_walkingUp = {
		to = 22,
		prefix = "enemy_fremen_run_back",
		from = 1
	},
	spectres_possession_effect = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_idle = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_start = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_loop = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_end = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_walk = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_heal = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_special = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_summon = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_walkingRightLeft = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_attack = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_shoot = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	spectres_possession_effect_death = {
		to = 26,
		prefix = "spectres_possession_effect",
		from = 1
	},
	ramses_idle = {
		to = 1,
		prefix = "king_ramses_Idle",
		from = 1
	},
	ramses_wave = {
		to = 27,
		prefix = "king_ramses_Return_the_slab",
		from = 1
	},
	ramses_click = {
		to = 3,
		prefix = "king_ramses_Click",
		from = 1
	},
	ramses_slab = {
		to = 28,
		prefix = "king_ramses_Slab_has_returned",
		from = 1
	},
	ramses_heart = {
		to = 14,
		prefix = "king_ramses_Appreciation",
		from = 1
	},
	ramses_poof = {
		to = 7,
		prefix = "king_ramses_Poof",
		from = 1
	},
	kahor_tomb_glow_start = {
		to = 8,
		prefix = "kahor_tomb_glow",
		from = 1
	},
	kahor_tomb_glow_end = {
		prefix = "kahor_tomb_glow",
		frames = {
			8,
			8,
			2,
			2,
			2,
			1,
			1,
			1
		}
	},
	kahor_guy_start = {
		to = 46,
		prefix = "kahor_guy",
		from = 1
	},
	kahor_guy_loop = {
		to = 53,
		prefix = "kahor_guy",
		from = 47
	},
	kahor_guy_end = {
		to = 65,
		prefix = "kahor_guy",
		from = 54
	},
	flag_hm = {
		to = 15,
		prefix = "Stage01_flag",
		from = 1
	},
	smoke_hm = {
		to = 8,
		prefix = "HammerHold_Smoke",
		from = 1
	},
	shockidy_idle = {
		to = 1,
		prefix = "Sand_Bucket_Buried",
		from = 1
	},
	shockidy_clicked = {
		to = 6,
		prefix = "Sand_Bucket_Buried",
		from = 2
	},
	shockidy_freedom = {
		prefix = "Sand_Bucket_Freedom",
		frames = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			12,
			12,
			12,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25
		}
	},
	shockidy_freedom_idle = {
		to = 26,
		prefix = "Sand_Bucket_Freedom",
		from = 26
	},
	shockidy_showoff_1 = {
		to = 16,
		prefix = "Sand_Bucket_Showoff_1",
		from = 1
	},
	shockidy_showoff_2 = {
		to = 16,
		prefix = "Sand_Bucket_Showoff_2",
		from = 2
	},
	umbra_portal_start = {
		to = 8,
		prefix = "finalBoss_portal",
		from = 1
	},
	umbra_portal_loop = {
		to = 21,
		prefix = "finalBoss_portal",
		from = 9
	},
	umbra_portal_end = {
		to = 47,
		prefix = "finalBoss_portal",
		from = 40
	},
	spectres_proy_decal = {
		to = 11,
		prefix = "spectres_proy_decal",
		from = 1
	}
}

local rebborn2_missing_animations = {
	eb_malagar_cloud_forming = {
		to = 25,
		prefix = "malagar_cloud_forming",
		from = 1
	},
	eb_malagar_death = {
		to = 18,
		prefix = "malagar_clone_death",
		from = 1
	},
	eb_malagar_idle = {
		to = 1,
		prefix = "malagar",
		from = 1
	},
	eb_malagar_idle_shield_skill = {
		to = 35,
		prefix = "malagar",
		from = 1
	},
	eb_malagar_idle_tower_skill = {
		to = 75,
		prefix = "malagar",
		from = 36
	},
	eb_malagar_raise = {
		to = 25,
		prefix = "malagar_cloud_forming",
		from = 1
	},
	eb_malagar_ranged_attack = {
		to = 49,
		prefix = "malagar_boss",
		from = 25
	},
	eb_malagar_reappear = {
		to = 7,
		prefix = "malagar_reappear",
		from = 1
	},
	eb_malagar_shield_skill = {
		to = 49,
		prefix = "malagar_boss",
		from = 25
	},
	eb_malagar_teleport = {
		to = 7,
		prefix = "malagar_teleport",
		from = 1
	},
	eb_malagar_tower_skill = {
		to = 97,
		prefix = "malagar_boss",
		from = 74
	},
	eb_malagar_walkingDown = {
		to = 73,
		prefix = "malagar_boss",
		from = 50
	},
	eb_malagar_walkingRightLeft = {
		to = 24,
		prefix = "malagar_boss",
		from = 1
	},
	eb_malagar_walkingUp = {
		to = 24,
		prefix = "malagar_boss",
		from = 1
	},
	enemy_sand_monk_attack = {
		to = 18,
		prefix = "enemy_sand_monk_atk",
		from = 1
	},
	enemy_sand_monk_death = {
		to = 24,
		prefix = "enemy_sand_monk_dead",
		from = 1
	},
	enemy_sand_monk_idle = {
		to = 1,
		prefix = "enemy_sand_monk_idle",
		from = 1
	},
	enemy_sand_monk_mod_end = {
		to = 56,
		prefix = "sand_monk_mod",
		from = 45
	},
	enemy_sand_monk_mod_idle = {
		to = 44,
		prefix = "sand_monk_mod",
		from = 11
	},
	enemy_sand_monk_mod_start = {
		to = 10,
		prefix = "sand_monk_mod",
		from = 1
	},
	enemy_sand_monk_running = {
		to = 24,
		prefix = "enemy_sand_monk_run",
		from = 1
	},
	enemy_sand_monk_skill = {
		to = 20,
		prefix = "enemy_sand_monk_skill",
		from = 1
	},
	enemy_sand_monk_walk = {
		to = 24,
		prefix = "enemy_sand_monk_run",
		from = 1
	},
	enemy_sand_monk_walkingDown = {
		to = 24,
		prefix = "enemy_sand_monk_run_face",
		from = 1
	},
	enemy_sand_monk_walkingRightLeft = {
		to = 24,
		prefix = "enemy_sand_monk_run",
		from = 1
	},
	enemy_sand_monk_walkingUp = {
		to = 24,
		prefix = "enemy_sand_monk_run_back",
		from = 1
	},
	enemy_set_attack = {
		to = 17,
		prefix = "Set_Attack",
		from = 1
	},
	enemy_set_death = {
		to = 65,
		prefix = "Set_Death",
		from = 1
	},
	enemy_set_idle = {
		to = 1,
		prefix = "Set_Idle",
		from = 1
	},
	enemy_set_raise = {
		to = 81,
		prefix = "Set_Revival",
		from = 1
	},
	enemy_set_running = {
		to = 21,
		prefix = "Set_Right Left Walk",
		from = 1
	},
	enemy_set_skill = {
		to = 5,
		prefix = "Set_Skill Loop",
		from = 1
	},
	enemy_set_skill_end = {
		to = 5,
		prefix = "Set_Skill End",
		from = 1
	},
	enemy_set_skill_start = {
		to = 11,
		prefix = "Set_Skill Start",
		from = 1
	},
	enemy_set_walk = {
		to = 21,
		prefix = "Set_Right Left Walk",
		from = 1
	},
	enemy_set_walkingDown = {
		to = 21,
		prefix = "Set_Down Walk",
		from = 1
	},
	enemy_set_walkingRightLeft = {
		to = 21,
		prefix = "Set_Right Left Walk",
		from = 1
	},
	enemy_set_walkingUp = {
		to = 21,
		prefix = "Set_Right Left Walk",
		from = 1
	},
	enemy_shaman_walk = {
		to = 22,
		prefix = "shaman",
		from = 1
	},
	enemy_umbral_acolyte_attack = {
		to = 16,
		prefix = "enemy_umbral_acolyte_atk",
		from = 1
	},
	enemy_umbral_acolyte_death = {
		to = 18,
		prefix = "enemy_umbral_acolyte_dead",
		from = 1
	},
	enemy_umbral_acolyte_idle = {
		to = 1,
		prefix = "enemy_umbral_acolyte_idle",
		from = 1
	},
	enemy_umbral_acolyte_ranged_attack = {
		prefix = "enemy_umbral_acolyte_skill",
		frames = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			46,
			47,
			48,
			49,
			50,
			51,
			52,
			53
		}
	},
	enemy_umbral_acolyte_running = {
		to = 36,
		prefix = "enemy_umbral_acolyte_run",
		from = 1
	},
	enemy_umbral_acolyte_skill = {
		to = 53,
		prefix = "enemy_umbral_acolyte_skill",
		from = 1
	},
	enemy_umbral_acolyte_walk = {
		to = 36,
		prefix = "enemy_umbral_acolyte_run",
		from = 1
	},
	enemy_umbral_acolyte_walkingDown = {
		to = 36,
		prefix = "enemy_umbral_acolyte_run_face",
		from = 1
	},
	enemy_umbral_acolyte_walkingRightLeft = {
		to = 36,
		prefix = "enemy_umbral_acolyte_run",
		from = 1
	},
	enemy_umbral_acolyte_walkingUp = {
		to = 36,
		prefix = "enemy_umbral_acolyte_run_back",
		from = 1
	},
	eye_ra_click = {
		to = 8,
		prefix = "eye_of_ra",
		from = 2
	},
	eye_ra_idle = {
		to = 1,
		prefix = "eye_of_ra",
		from = 1
	},
	fx_xerxes_obelisk = {
		to = 18,
		prefix = "cementery_fx",
		from = 1
	},
	fx_xerxes_teleport_end = {
		to = 11,
		prefix = "finalBoss_minion_teleport",
		from = 1
	},
	fx_xerxes_teleport_start_large = {
		to = 11,
		prefix = "finalBoss_minion_teleport",
		from = 1
	},
	fx_xerxes_teleport_start_small = {
		to = 11,
		prefix = "finalBoss_minion_teleport",
		from = 1
	},
	malagar_shield_magical_idle = {
		prefix = "Shield_Blue",
		frames = {
			8,
			8,
			7,
			7,
			6,
			6,
			5,
			5,
			4,
			4,
			3,
			3,
			2,
			2,
			1,
			1,
			2,
			2,
			3,
			3,
			4,
			4,
			5,
			5,
			6,
			6,
			7,
			7
		}
	},
	malagar_shield_physical_idle = {
		to = 16,
		prefix = "finalBoss_guy_forceShield",
		from = 1
	},
	malagar_tower_hold_appear = {
		to = "31",
		prefix = "Stage1_BossTowerHold",
		from = "1"
	},
	malagar_tower_hold_disappear = {
		to = "65",
		prefix = "Stage1_BossTowerHold",
		from = "56"
	},
	malagar_tower_hold_stun = {
		to = "55",
		prefix = "Stage1_BossTowerHold",
		from = "41"
	},
	malagar_tower_hold_threat = {
		to = "40",
		prefix = "Stage1_BossTowerHold",
		from = "32"
	},
	ray_umbra = {
		to = 14,
		prefix = "finalBoss_eyeRay",
		from = 1
	},
	ray_umbra_explosion = {
		to = 17,
		prefix = "finalBoss_death_explosion",
		from = 1
	},
	ray_umbra_guy = {
		to = 14,
		prefix = "finalBoss_guy_ray",
		from = 1
	},
	ray_umbra_guy_explosion = {
		to = 12,
		prefix = "finalBoss_guy_explosion",
		from = 1
	},
	ray_zezitra_guy = {
		to = 14,
		prefix = "hero_zezitra_ray",
		from = 1
	},
	ray_zezitra_guy_explosion = {
		to = 12,
		prefix = "hero_zezitra_ray_explosion",
		from = 1
	},
	soldier_city_guard_attack = {
		prefix = "city_guard_attack",
		frames = {
			1,
			1,
			1,
			2,
			2,
			3,
			3,
			4,
			4,
			5,
			5,
			6,
			6,
			1
		}
	},
	soldier_city_guard_death = {
		to = 7,
		prefix = "city_guard_death",
		from = 1
	},
	soldier_city_guard_idle = {
		to = 1,
		prefix = "city_guard_idle",
		from = 1
	},
	soldier_city_guard_running = {
		to = 5,
		prefix = "city_guard_walk",
		from = 1
	},
	spectres_proy_flying = {
		to = 1,
		prefix = "spectres_attack_proy",
		from = 1
	},
	spectres_proy_hit = {
		to = 11,
		prefix = "spectres_proy_decal",
		from = 1
	},
	spectres_proy_idle = {
		to = 33,
		prefix = "spectres_attack_proy",
		from = 2
	},
	umbra_minion_spawn = {
		to = 12,
		prefix = "finalBoss_minion_teleport",
		from = 1
	},
	xerxes_obelisk_end = {
		to = 18,
		prefix = "cementery",
		from = 11
	},
	xerxes_obelisk_loop = {
		to = 10,
		prefix = "cementery",
		from = 10
	},
	xerxes_obelisk_start = {
		to = 10,
		prefix = "cementery",
		from = 1
	}
}

for k, v in pairs(rebborn2_missing_animations) do
	a[k] = v
end

local rebborn2_unreferenced_atlas_animations = {
	["Daniel_J._Darby"] = {
		to = 1,
		prefix = "Daniel_J._Darby",
		from = 1
	},
	FatalAttraction = {
		to = 1,
		prefix = "FatalAttraction",
		from = 1
	},
	Fountain = {
		to = 1,
		prefix = "Fountain",
		from = 1
	},
	Hammerhold = {
		to = 8,
		prefix = "Hammerhold",
		from = 1
	},
	["N,Doul"] = {
		to = 1,
		prefix = "N,Doul",
		from = 1
	},
	Stage1_BossShoutBox = {
		to = 16,
		prefix = "Stage1_BossShoutBox",
		from = 1
	},
	bush = {
		to = 4,
		prefix = "bush",
		from = 1
	},
	encyclopedia_tower_specials = {
		prefix = "encyclopedia_tower_specials",
		frames = {
			950,
			951,
			952,
			953,
			954
		}
	},
	encyclopedia_tower_thumbs = {
		prefix = "encyclopedia_tower_thumbs",
		frames = {
			901,
			902
		}
	},
	encyclopedia_towers = {
		prefix = "encyclopedia_towers",
		frames = {
			901,
			902
		}
	},
	malagar_defeat = {
		to = 54,
		prefix = "malagar_defeat",
		from = 1
	},
	rebborn_main_icons = {
		prefix = "rebborn_main_icons",
		frames = {
			910,
			911
		}
	},
	rebborn_special_icons = {
		prefix = "rebborn_special_icons",
		frames = {
			2041,
			2042,
			2043,
			2059,
			2060
		}
	},
	sandVortex_creepFx_fat = {
		to = 11,
		prefix = "sandVortex_creepFx_fat",
		from = 1
	},
	sandVortex_creepFx_thin = {
		to = 11,
		prefix = "sandVortex_creepFx_thin",
		from = 1
	},
	sandVortex_explosion = {
		to = 22,
		prefix = "sandVortex_explosion",
		from = 1
	},
	tower_hammerhold_guard = {
		to = 1,
		prefix = "tower_hammerhold_guard",
		from = 1
	}
}

for k, v in pairs(rebborn2_unreferenced_atlas_animations) do
	a[k] = v
end

return { animations = a }
