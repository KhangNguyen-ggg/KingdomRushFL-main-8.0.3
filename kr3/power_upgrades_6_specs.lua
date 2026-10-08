local bit = require("bit")
local V = require("klua.vector")
local balance = require("data/balance/balance_6")

require("constants")

local b_powers = balance.upgrades
local lists_helpers = {
	power_musketeers_soldier_templates = {
		"soldier_musketeers"
	},
	power_musketeers_bullets = {
		"bullet_power_musketeers",
		"bullet_power_musketeers_l4a",
		"bullet_power_musketeers_l5b"
	},
	power_reinforcements_soldiers = {
		"soldier_reinforcement_base",
		"soldier_reinforcement_special"
	},
	power_soaring_shop_bullets = {
		"bullet_power_soaring_shop_attack_1",
		"bullet_power_soaring_shop_attack_2",
		"bullet_power_soaring_shop_attack_3",
		"bullet_power_soaring_shop_special_1",
		"bullet_power_soaring_shop_special_2"
	},
	power_thunder_zapper_auras = {
		"aura_power_thunder_zapper",
		"aura_power_thunder_zapper_summon",
		"aura_power_thunder_zapper_l6"
	}
}

return {
	power_reinforcements_l2a = {
		priority = 2,
		class = "power_reinforcements",
		id = "l2a",
		level = 2,
		patches = {
			{
				operators = "set",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"unit.damage_factor"
				},
				value = b_powers.power_reinforcements.l2b.dmg_factor
			}
		}
	},
	power_reinforcements_l2b = {
		id = "l2b",
		class = "power_reinforcements",
		level = 2,
		patches = {
			{
				operators = "sum",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"reinforcement.duration"
				},
				value = b_powers.power_reinforcements.l2a.duration_extra
			},
			{
				operators = "sum",
				templates = {
					"aura_power_reinforcement_special"
				},
				paths = {
					"aura.duration"
				},
				value = b_powers.power_reinforcements.l2a.duration_extra
			}
		}
	},
	power_reinforcements_l3 = {
		priority = 3,
		class = "power_reinforcements",
		id = "l3",
		level = 3,
		patches = {
			{
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"health.armor"
				},
				value = b_powers.power_reinforcements.l3.armor
			},
			{
				operators = "mul",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"health.hp_max"
				},
				value = b_powers.power_reinforcements.l3.hp_factor
			},
			{
				value = "reinforcements_lvl2_",
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"level"
				}
			}
		}
	},
	power_reinforcements_l4a = {
		id = "l4a",
		class = "power_reinforcements",
		level = 4,
		patches = {
			{
				operators = "mul",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"motion.max_speed"
				},
				value = b_powers.power_reinforcements.l4a.mov_speed_factor
			},
			{
				operators = "sub",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_reinforcements.l4a.cooldown_decrease
			},
			{
				operators = "mul",
				templates = {
					"soldier_reinforcement_special"
				},
				paths = {
					"motion.max_speed"
				},
				value = b_powers.power_reinforcements.l4a.mov_speed_factor
			}
		}
	},
	power_reinforcements_l4b = {
		priority = 4,
		class = "power_reinforcements",
		id = "l4b",
		level = 4,
		patches = {
			{
				operators = "sum",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"health.armor"
				},
				value = b_powers.power_reinforcements.l4b.armor_increase
			}
		}
	},
	power_reinforcements_l5a = {
		priority = 5,
		class = "power_reinforcements",
		id = "l5a",
		level = 5,
		patches = {
			{
				operators = "mul",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"health.hp_max"
				},
				value = b_powers.power_reinforcements.l5a.hp_factor
			},
			{
				operators = "mul",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"unit.damage_factor"
				},
				value = b_powers.power_reinforcements.l5a.dmg_factor
			},
			{
				value = "reinforcements_lvl3_",
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"level"
				}
			},
			{
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"render.sprites[1].scale"
				},
				value = V.v(0.9, 0.9)
			}
		}
	},
	power_reinforcements_l5b = {
		priority = 5,
		class = "power_reinforcements",
		id = "l5b",
		level = 5,
		patches = {
			{
				operators = "set",
				templates = lists_helpers.power_reinforcements_soldiers,
				paths = {
					"health.spiked_armor"
				},
				value = b_powers.power_reinforcements.l5b.spiked_armor
			},
			{
				value = "reinforcements_lvl3_",
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"level"
				}
			},
			{
				operators = "set",
				templates = {
					"soldier_reinforcement_base"
				},
				paths = {
					"render.sprites[1].scale"
				},
				value = V.v(0.9, 0.9)
			}
		}
	},
	power_reinforcements_l6 = {
		id = "l6",
		class = "power_reinforcements",
		level = 6,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"power_reinforcements_control_g6"
				},
				paths = {
					"upgrade_special_unit"
				}
			}
		}
	},
	power_rain_of_fire_l2a = {
		id = "l2a",
		class = "power_rain_of_fire",
		level = 2,
		patches = {
			{
				operators = "sub",
				templates = {
					"power_rain_of_fire_control"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_rain_of_fire.l2a.cd_reduction
			}
		}
	},
	power_rain_of_fire_l2b = {
		id = "l2b",
		class = "power_rain_of_fire",
		level = 2,
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_power_rain_of_fire"
				},
				paths = {
					"bullet.damage_factor"
				},
				value = b_powers.power_rain_of_fire.l2b.damage_factor
			}
		}
	},
	power_rain_of_fire_l3 = {
		id = "l3",
		class = "power_rain_of_fire",
		level = 3,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"bullet_power_rain_of_fire"
				},
				paths = {
					"upgrade_scorching_floor"
				}
			},
			{
				value = "decal_power_rain_of_fire_scorch",
				operators = "set",
				templates = {
					"bullet_power_rain_of_fire"
				},
				paths = {
					"bullet.hit_decal"
				}
			}
		}
	},
	power_rain_of_fire_l4a = {
		id = "l4a",
		class = "power_rain_of_fire",
		level = 4,
		patches = {
			{
				operators = "sum",
				templates = {
					"aura_bullet_power_rain_of_fire_dmg",
					"aura_bullet_power_rain_of_fire_slow"
				},
				paths = {
					"aura.duration"
				},
				value = b_powers.power_rain_of_fire.l4a.duration_inc
			},
			{
				operators = "sum",
				templates = {
					"mod_bullet_power_rain_of_fire_burn"
				},
				paths = {
					"dps.damage_inc"
				},
				value = b_powers.power_rain_of_fire.l4a.damage_inc
			},
			{
				operators = "sum",
				templates = {
					"decal_power_rain_of_fire_scorch"
				},
				paths = {
					"duration"
				},
				value = b_powers.power_rain_of_fire.l4a.duration_inc
			}
		}
	},
	power_rain_of_fire_l4b = {
		id = "l4b",
		class = "power_rain_of_fire",
		level = 4,
		patches = {
			{
				operators = "sum",
				templates = {
					"power_rain_of_fire_control"
				},
				paths = {
					"meteor_count"
				},
				value = b_powers.power_rain_of_fire.l4b.meteor_inc
			}
		}
	},
	power_rain_of_fire_l5a = {
		id = "l5a",
		class = "power_rain_of_fire",
		level = 5,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"bullet_power_rain_of_fire"
				},
				paths = {
					"upgrade_slow_floor"
				}
			}
		}
	},
	power_rain_of_fire_l5b = {
		id = "l5b",
		class = "power_rain_of_fire",
		level = 5,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"bullet_power_rain_of_fire"
				},
				paths = {
					"upgrade_extra_explosion"
				}
			}
		}
	},
	power_rain_of_fire_l6 = {
		id = "l6",
		class = "power_rain_of_fire",
		level = 6,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"power_rain_of_fire_control"
				},
				paths = {
					"upgrade_cataclysm"
				}
			},
			{
				operators = "sub",
				templates = {
					"power_rain_of_fire_control"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_rain_of_fire.l6.cd_reduction
			}
		}
	},
	power_royal_edict_l2a = {
		id = "l2a",
		class = "power_royal_edict",
		level = 2,
		patches = {
			{
				operators = "mul",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"range_factor"
				},
				value = b_powers.power_royal_edict.l2a.range_factor
			}
		}
	},
	power_royal_edict_l2b = {
		id = "l2b",
		class = "power_royal_edict",
		level = 2,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"respawn_barracks"
				}
			}
		}
	},
	power_royal_edict_l3 = {
		id = "l3",
		class = "power_royal_edict",
		level = 3,
		patches = {
			{
				operators = "mul",
				templates = {
					"power_royal_edict_control"
				},
				paths = {
					"range"
				},
				value = b_powers.power_royal_edict.l3.range_factor
			},
			{
				value = 0.1,
				operators = "set",
				templates = {
					"power_royal_edict_control"
				},
				paths = {
					"confetti_cycle_time"
				}
			},
			{
				value = "decal_power_royal_edict_confetti",
				operators = "set",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"confetti"
				}
			}
		}
	},
	power_royal_edict_l4a = {
		id = "l4a",
		class = "power_royal_edict",
		level = 4,
		patches = {
			{
				operators = "sum",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"damage_factor"
				},
				value = b_powers.power_royal_edict.l4a.dmg_factor_inc
			}
		}
	},
	power_royal_edict_l4b = {
		id = "l4b",
		class = "power_royal_edict",
		level = 4,
		patches = {
			{
				value = "mod_power_royal_edict_golddebuff",
				operators = "set",
				templates = {
					"power_royal_edict_control"
				},
				paths = {
					"gold_mod"
				}
			}
		}
	},
	power_royal_edict_l5a = {
		id = "l5a",
		class = "power_royal_edict",
		level = 5,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"reset_skills_cd"
				}
			}
		}
	},
	power_royal_edict_l5b = {
		id = "l5b",
		class = "power_royal_edict",
		level = 5,
		patches = {
			{
				operators = "mul",
				templates = {
					"mod_power_royal_edict_towerbuff"
				},
				paths = {
					"modifier.duration"
				},
				value = b_powers.power_royal_edict.l5b.duration_factor
			}
		}
	},
	power_royal_edict_l6 = {
		id = "l6",
		class = "power_royal_edict",
		level = 6,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"power_royal_edict_control"
				},
				paths = {
					"is_global"
				}
			}
		}
	},
	power_soaring_shop_l2a = {
		id = "l2a",
		class = "power_soaring_shop",
		level = 2,
		patches = {
			{
				operators = "mul",
				templates = lists_helpers.power_soaring_shop_bullets,
				paths = {
					"bullet.damage_radius"
				},
				value = b_powers.power_soaring_shop.l2a.radius_factor
			}
		}
	},
	power_soaring_shop_l2b = {
		id = "l2b",
		class = "power_soaring_shop",
		level = 2,
		patches = {
			{
				operators = "sub",
				templates = {
					"power_soaring_shop_control"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_soaring_shop.l2b.cd_reduction
			}
		}
	},
	power_soaring_shop_l3 = {
		priority = 3,
		class = "power_soaring_shop",
		id = "l3",
		level = 3,
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = "spell_shop_lvl3Def",
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0049",
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"info.portrait"
				}
			}
		}
	},
	power_soaring_shop_l4a = {
		id = "l4a",
		class = "power_soaring_shop",
		level = 4,
		patches = {
			{
				operators = "mul",
				templates = lists_helpers.power_soaring_shop_bullets,
				paths = {
					"bullet.damage_min",
					"bullet.damage_max"
				},
				value = b_powers.power_soaring_shop.l4a.damage_inc
			}
		}
	},
	power_soaring_shop_l4b = {
		id = "l4b",
		class = "power_soaring_shop",
		level = 4,
		patches = {
			{
				operators = "sub",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"timed_attacks.list[1].cooldown"
				},
				value = b_powers.power_soaring_shop.l4b.cd_reduction
			}
		}
	},
	power_soaring_shop_l5a = {
		id = "l5a",
		class = "power_soaring_shop",
		level = 5,
		patches = {
			{
				operators = "sub",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"ranged.attacks[1].cooldown"
				},
				value = b_powers.power_soaring_shop.l5a.cd_reduction
			}
		}
	},
	power_soaring_shop_l5b = {
		id = "l5b",
		class = "power_soaring_shop",
		level = 5,
		patches = {
			{
				operators = "mul",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"duration"
				},
				value = b_powers.power_soaring_shop.l5b.duration_factor
			}
		}
	},
	power_soaring_shop_l6 = {
		priority = 6,
		class = "power_soaring_shop",
		id = "l6",
		level = 6,
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = "spell_shop_lvl6Def",
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0050",
				operators = "set",
				templates = {
					"soldier_soaring_shop"
				},
				paths = {
					"info.portrait"
				}
			}
		}
	},
	power_aspect_of_sol_l2a = {
		id = "l2a",
		class = "power_aspect_of_sol",
		level = 2,
		patches = {
			{
				operators = "mul",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"reinforcement.duration"
				},
				value = b_powers.power_aspect_of_sol.l2a.duration_factor
			}
		}
	},
	power_aspect_of_sol_l2b = {
		id = "l2b",
		class = "power_aspect_of_sol",
		level = 2,
		patches = {
			{
				operators = "mul",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"melee.attacks[1].damage_min",
					"melee.attacks[2].damage_min"
				},
				value = b_powers.power_aspect_of_sol.l2b.damage_inc
			}
		}
	},
	power_aspect_of_sol_l3 = {
		priority = 3,
		class = "power_aspect_of_sol",
		id = "l3",
		level = 3,
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = "aspectofsol_lvl_2",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0046",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"info.portrait"
				}
			}
		}
	},
	power_aspect_of_sol_l4a = {
		id = "l4a",
		class = "power_aspect_of_sol",
		level = 4,
		patches = {
			{
				operators = "mul",
				templates = {
					"mod_power_aspect_of_sol_warcry_dmg_inc"
				},
				paths = {
					"modifier.duration"
				},
				value = b_powers.power_aspect_of_sol.l4a.duration_factor
			}
		}
	},
	power_aspect_of_sol_l4b = {
		id = "l4b",
		class = "power_aspect_of_sol",
		level = 4,
		patches = {
			{
				value = "mod_power_aspect_of_sol_stun",
				operators = "set",
				templates = {
					"aura_power_aspect_of_sol_summon"
				},
				paths = {
					"aura.mod"
				}
			},
			{
				value = "aura_power_aspect_of_sol_summon",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"spawn_aura"
				}
			}
		}
	},
	power_aspect_of_sol_l5a = {
		id = "l5a",
		class = "power_aspect_of_sol",
		level = 5,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"melee.attacks[2].has_upgrade"
				}
			}
		}
	},
	power_aspect_of_sol_l5b = {
		id = "l5b",
		class = "power_aspect_of_sol",
		level = 5,
		patches = {
			{
				value = "mod_power_aspect_of_sol_warcry_slow",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"timed_attacks.list[1].mod_slow"
				}
			},
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"l5b_disabled"
				}
			}
		}
	},
	power_aspect_of_sol_l6 = {
		priority = 6,
		class = "power_aspect_of_sol",
		id = "l6",
		level = 6,
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"spawn_with_beam"
				}
			},
			{
				value = "aspectofsol_lvl_3",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0047",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"info.portrait"
				}
			},
			{
				value = "aura_power_aspect_of_sol_summon",
				operators = "set",
				templates = {
					"soldier_aspect_of_sol"
				},
				paths = {
					"spawn_aura"
				}
			},
			{
				operators = "set",
				templates = {
					"aura_power_aspect_of_sol_summon"
				},
				paths = {
					"aura.vis_bans"
				},
				value = bit.bor(F_FRIEND)
			},
			{
				operators = "set",
				templates = {
					"aura_power_aspect_of_sol_summon"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_powers.power_aspect_of_sol.l6.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_power_aspect_of_sol_summon"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_powers.power_aspect_of_sol.l6.damage_max
			}
		}
	},
	power_teleportation_sigil_l2a = {
		id = "l2a",
		class = "power_teleportation_sigil",
		level = 2,
		patches = {
			{
				operators = "mul",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"modifier.duration"
				},
				value = b_powers.power_teleportation_sigil.l2a.duration_factor
			}
		}
	},
	power_teleportation_sigil_l2b = {
		id = "l2b",
		class = "power_teleportation_sigil",
		level = 2,
		patches = {
			{
				value = "mod_power_teleportation_sigil_slow",
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"mod_slow"
				}
			}
		}
	},
	power_teleportation_sigil_l3 = {
		priority = 3,
		class = "power_teleportation_sigil",
		id = "l3",
		level = 3,
		patches = {
			{
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"second_tp_chance"
				},
				value = b_powers.power_teleportation_sigil.l3.second_tp_chance
			},
			{
				value = "sigil_lvl2Def",
				operators = "set",
				templates = {
					"decal_teleportation_sigil"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				operators = "set",
				templates = {
					"decal_teleportation_sigil"
				},
				paths = {
					"range"
				},
				value = b_powers.power_teleportation_sigil.l3.range
			}
		}
	},
	power_teleportation_sigil_l4a = {
		id = "l4a",
		class = "power_teleportation_sigil",
		level = 4,
		patches = {
			{
				operators = "sub",
				templates = {
					"power_teleportation_sigil_control"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_teleportation_sigil.l4a.s_cd_reduction
			}
		}
	},
	power_teleportation_sigil_l4b = {
		id = "l4b",
		class = "power_teleportation_sigil",
		level = 4,
		patches = {
			{
				operators = "set",
				templates = {
					"decal_teleportation_sigil"
				},
				paths = {
					"max_count"
				},
				value = b_powers.power_teleportation_sigil.l4b.max_tp_count
			}
		}
	},
	power_teleportation_sigil_l5a = {
		id = "l5a",
		class = "power_teleportation_sigil",
		level = 5,
		patches = {
			{
				value = "mod_teleportation_sigil_silence",
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"mod_silence"
				}
			},
			{
				value = "mod_teleportation_sigil_damage_red",
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"mod_damage_red"
				}
			}
		}
	},
	power_teleportation_sigil_l5b = {
		id = "l5b",
		class = "power_teleportation_sigil",
		level = 5,
		patches = {
			{
				value = "mod_teleportation_sigil_stun",
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"mod_stun"
				}
			}
		}
	},
	power_teleportation_sigil_l6 = {
		priority = 6,
		class = "power_teleportation_sigil",
		id = "l6",
		level = 6,
		patches = {
			{
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"instakill_chance"
				},
				value = b_powers.power_teleportation_sigil.l6.instakill_chance
			},
			{
				operators = "set",
				templates = {
					"mod_teleportation_sigil_teleport"
				},
				paths = {
					"instakill_min_hp"
				},
				value = b_powers.power_teleportation_sigil.l6.instakill_min_hp
			},
			{
				value = "sigil_lvl3Def",
				operators = "set",
				templates = {
					"decal_teleportation_sigil"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				operators = "set",
				templates = {
					"decal_teleportation_sigil"
				},
				paths = {
					"range"
				},
				value = b_powers.power_teleportation_sigil.l6.range
			}
		}
	},
	power_thunder_zapper_l5a = {
		id = "l5a",
		class = "power_thunder_zapper",
		level = 1,
		patches = {
			{
				operators = "mul",
				templates = {
					"aura_power_thunder_zapper",
					"aura_power_thunder_zapper_l6"
				},
				paths = {
					"aura.damage_min",
					"aura.damage_max"
				},
				value = b_powers.power_thunder_zapper.l2a.dmg_factor
			}
		}
	},
	power_thunder_zapper_l2b = {
		id = "l2b",
		class = "power_thunder_zapper",
		level = 1,
		patches = {
			{
				operators = "mul",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"duration"
				},
				value = b_powers.power_thunder_zapper.l2b.duration_factor
			}
		}
	},
	power_thunder_zapper_l3 = {
		priority = 3,
		class = "power_thunder_zapper",
		id = "l3",
		level = 2,
		patches = {
			{
				value = "teslaguy_lvl2Def",
				operators = "set",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			}
		}
	},
	power_thunder_zapper_l4a = {
		id = "l4a",
		class = "power_thunder_zapper",
		level = 3,
		patches = {
			{
				operators = "sub",
				templates = {
					"power_thunder_zapper_control"
				},
				paths = {
					"cooldown"
				},
				value = b_powers.power_thunder_zapper.l4a.cd_reduction
			}
		}
	},
	power_thunder_zapper_l4b = {
		id = "l4b",
		class = "power_thunder_zapper",
		level = 3,
		patches = {
			{
				value = "mod_power_thunder_zapper_slow",
				operators = "table_append",
				templates = lists_helpers.power_thunder_zapper_auras,
				paths = {
					"aura.mods"
				}
			}
		}
	},
	power_thunder_zapper_l2a = {
		id = "l2a",
		class = "power_thunder_zapper",
		level = 4,
		patches = {
			{
				operators = "mul",
				templates = lists_helpers.power_thunder_zapper_auras,
				paths = {
					"aura.radius"
				},
				value = b_powers.power_thunder_zapper.l5a.radius_factor
			}
		}
	},
	power_thunder_zapper_l5b = {
		id = "l5b",
		class = "power_thunder_zapper",
		level = 4,
		patches = {
			{
				value = "mod_power_thunder_zapper_stun",
				operators = "table_append",
				templates = {
					"aura_power_thunder_zapper_summon"
				},
				paths = {
					"aura.mods"
				}
			}
		}
	},
	power_thunder_zapper_l6 = {
		priority = 6,
		class = "power_thunder_zapper",
		id = "l6",
		level = 5,
		patches = {
			{
				value = "teslaguy_lvl3Def",
				operators = "set",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				operators = "set",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"unit.hit_offset"
				},
				value = V.v(2, 55)
			},
			{
				value = false,
				operators = "set",
				templates = {
					"soldier_thunder_zapper"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			}
		}
	},
	power_wintersongs_wrath_l2a = {
		id = "l2a",
		class = "power_wintersongs_wrath",
		level = 1,
		patches = {
			{
				operators = "mul",
				templates = {
					"decal_power_wintersongs_wrath_elora"
				},
				paths = {
					"duration"
				},
				value = b_powers.power_wintersongs_wrath.l2a.duration_factor
			}
		}
	},
	power_wintersongs_wrath_l2b = {
		id = "l2b",
		class = "power_wintersongs_wrath",
		level = 1,
		patches = {
			{
				operators = "mul",
				templates = {
					"aura_power_wintersongs_wrath_slow"
				},
				paths = {
					"aura.radius"
				},
				value = b_powers.power_wintersongs_wrath.l2b.radius_factor
			}
		}
	},
	power_wintersongs_wrath_l3 = {
		id = "l3",
		class = "power_wintersongs_wrath",
		level = 2,
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"decal_power_wintersongs_wrath_elora"
				},
				paths = {
					"l3_disabled"
				}
			}
		}
	},
	power_wintersongs_wrath_l4a = {
		id = "l4a",
		class = "power_wintersongs_wrath",
		level = 3,
		patches = {
			{
				operators = "set",
				templates = {
					"decal_power_wintersongs_wrath_elora"
				},
				paths = {
					"spike_count"
				},
				value = b_powers.power_wintersongs_wrath.l4a.spike_count
			}
		}
	},
	power_wintersongs_wrath_l4b = {
		id = "l4b",
		class = "power_wintersongs_wrath",
		level = 3,
		patches = {
			{
				operators = "set",
				templates = {
					"mod_power_wintersongs_wrath_slow"
				},
				paths = {
					"slow.factor"
				},
				value = b_powers.power_wintersongs_wrath.l4b.slow_factor
			}
		}
	},
	power_wintersongs_wrath_l5a = {
		id = "l5a",
		class = "power_wintersongs_wrath",
		level = 4,
		patches = {
			{
				operators = "mul",
				templates = {
					"aura_power_wintersongs_wrath_spike"
				},
				paths = {
					"aura.damage_min",
					"aura.damage_max"
				},
				value = b_powers.power_wintersongs_wrath.l5a.damage_inc
			}
		}
	},
	power_wintersongs_wrath_l5b = {
		id = "l5b",
		class = "power_wintersongs_wrath",
		level = 4,
		patches = {
			{
				value = "mod_power_wintersongs_wrath_freeze",
				operators = "set",
				templates = {
					"aura_power_wintersongs_wrath_spike"
				},
				paths = {
					"aura.mod"
				}
			}
		}
	},
	power_wintersongs_wrath_l6 = {
		id = "l6",
		class = "power_wintersongs_wrath",
		level = 5,
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"decal_power_wintersongs_wrath_elora"
				},
				paths = {
					"l6_disabled"
				}
			}
		}
	},
	musketeers_l2a = {
		id = "l2a",
		class = "power_musketeers",
		patches = {
			{
				operators = "sum",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"reinforcement.duration"
				},
				value = balance.upgrades.power_musketeers.l2a.duration_inc
			}
		}
	},
	musketeers_l2b = {
		id = "l2b",
		class = "power_musketeers",
		patches = {
			{
				operators = "mul",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"ranged.attacks[1].max_range"
				},
				value = balance.upgrades.power_musketeers.l2b.range_inc_factor
			},
			{
				operators = "mul",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"motion.max_speed"
				},
				value = balance.upgrades.power_musketeers.l2b.movement_factor
			}
		}
	},
	musketeers_l3 = {
		id = "l3",
		priority = 3,
		class = "power_musketeers",
		patches = {
			{
				value = "Musketeers_Mosq2",
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0067",
				operators = "set",
				templates = {
					"soldier_musketeers"
				},
				paths = {
					"info.portrait"
				}
			},
			{
				operators = "mul",
				templates = lists_helpers.power_musketeers_bullets,
				paths = {
					"bullet.damage_min",
					"bullet.damage_max"
				},
				value = balance.upgrades.power_musketeers.l3.damage_inc
			},
			{
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"ranged.attacks[1].cooldown"
				},
				value = balance.upgrades.power_musketeers.l3.attack_cooldown
			}
		}
	},
	musketeers_l4a = {
		id = "l4a",
		class = "power_musketeers",
		patches = {
			{
				value = true,
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"l4a_active"
				}
			}
		}
	},
	musketeers_l4b = {
		id = "l4b",
		class = "power_musketeers",
		patches = {
			{
				value = true,
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"l4b_active"
				}
			},
			{
				operators = "sum",
				templates = {
					"bullet_power_musketeers"
				},
				paths = {
					"bullet.reduce_armor"
				},
				value = balance.upgrades.power_musketeers.l4b.reduce_armor_factor
			}
		}
	},
	musketeers_l5a = {
		id = "l5a",
		class = "power_musketeers",
		patches = {
			{
				operators = "sub",
				templates = {
					"power_musketeers_control"
				},
				paths = {
					"cooldown"
				},
				value = balance.upgrades.power_musketeers.l5a.cd_reduction
			},
			{
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"ranged.attacks[1].cooldown"
				},
				value = balance.upgrades.power_musketeers.l5a.attack_cooldown
			}
		}
	},
	musketeers_l5b = {
		id = "l5b",
		class = "power_musketeers",
		patches = {
			{
				value = true,
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"l5b_active"
				}
			}
		}
	},
	musketeers_l6 = {
		id = "l6",
		priority = 6,
		class = "power_musketeers",
		patches = {
			{
				value = "Musketeers_Mosq3",
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"render.sprites[1].prefix"
				}
			},
			{
				value = "gui_bottom_info_image_soldiers_0068",
				operators = "set",
				templates = {
					"soldier_musketeers"
				},
				paths = {
					"info.portrait"
				}
			},
			{
				value = true,
				operators = "set",
				templates = lists_helpers.power_musketeers_soldier_templates,
				paths = {
					"l6_active"
				}
			}
		}
	},
}
