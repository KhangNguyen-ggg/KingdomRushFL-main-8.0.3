local balance = require("data/balance/balance_6")
local b_heroes = balance.heroes

return {
	hero_gerald_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_gerald_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_gerald_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_gerald_skill_a"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sa1.duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_gerald_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_gerald_skill_a"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sa2.duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_gerald_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_gerald_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_gerald_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_gerald_skill_b"
				},
				paths = {
					"spiked_armor"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sb1.spiked_armor
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_gerald_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_gerald_skill_b"
				},
				paths = {
					"armor_inc"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sb2.armor_inc
			},
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sb2.cooldown
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_gerald_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_gerald_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_gerald_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sc1.cooldown
			},
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[3].hp_ptg"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sc1.hp_ptg
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_gerald_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sc2.cooldown
			},
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"timed_attacks.list[3].hp_ptg"
				},
				value = b_heroes.hero_gerald.upgrades.upg_sc2.hp_ptg
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_gerald_talent_1 = {
		id = "talent_1",
		class = "hero_gerald_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_gerald_talent_2 = {
		id = "talent_2",
		class = "hero_gerald_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_gerald_ulti = {
		id = "ulti",
		class = "hero_gerald_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_gerald_upg_a = {
		id = "upg_a",
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"melee.attacks[1].xp_gain_factor"
				},
				value = b_heroes.hero_gerald.upgrades.upg_a.xp_inc_factor
			}
		}
	},
	hero_gerald_upg_b = {
		id = "upg_b",
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max"
				},
				value = b_heroes.hero_gerald.upgrades.upg_b.dmg_factor
			}
		}
	},
	hero_gerald_upg_c = {
		id = "upg_c",
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_gerald.upgrades.upg_c.hp_ptg
			}
		}
	},
	hero_gerald_upg_d = {
		id = "upg_d",
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"health.dead_lifetime"
				},
				value = b_heroes.hero_gerald.upgrades.upg_d.dead_lifetime
			}
		}
	},
	hero_gerald_upg_e = {
		id = "upg_e",
		class = "hero_gerald_g6",
		patches = {
			{
				operators = "map_sum",
				templates = {
					"hero_gerald_g6"
				},
				paths = {
					"hero.level_stats.armor"
				},
				value = b_heroes.hero_gerald.upgrades.upg_e.armor_inc
			}
		}
	},
	hero_zefira_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_zefira",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_zefira_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].damage_min"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sa1.min_damage
			},
			{
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].damage_max"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sa1.max_damage
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_zefira_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].damage_min"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sa2.min_damage
			},
			{
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].damage_max"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sa2.max_damage
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_zefira_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_zefira",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_b.disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_zefira_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_zefira",
		patches = {
			{
				value = "mod_zefira_skill_b_slow",
				operators = "set",
				templates = {
					"aura_zefira_skill_b"
				},
				paths = {
					"aura.mod"
				}
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_zefira_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_zefira_skill_b"
				},
				paths = {
					"aura.duration"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sb2.duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_zefira_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_zefira",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"teleport.disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_zefira_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_zefira_skill_c_dmg_buff"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sc1.duration
			},
			{
				operators = "set",
				templates = {
					"mod_zefira_skill_c_dmg_buff"
				},
				paths = {
					"inflicted_damage_factor"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sc1.dmg_factor
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_zefira_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_zefira_skill_c_dmg_buff"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sc2.duration
			},
			{
				operators = "set",
				templates = {
					"mod_zefira_skill_c_dmg_buff"
				},
				paths = {
					"inflicted_damage_factor"
				},
				value = b_heroes.hero_zefira.upgrades.upg_sc2.dmg_factor
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_zefira_talent_1 = {
		id = "talent_1",
		class = "hero_zefira",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_zefira_talent_2 = {
		id = "talent_2",
		class = "hero_zefira",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_zefira_ulti = {
		id = "ulti",
		class = "hero_zefira",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_zefira_upg_a = {
		id = "upg_a",
		class = "hero_zefira",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_zefira"
				},
				paths = {
					"health.dead_lifetime"
				},
				value = b_heroes.hero_zefira.upgrades.upg_a.dead_lifetime
			}
		}
	},
	hero_zefira_upg_b = {
		id = "upg_b",
		class = "hero_zefira",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_zefira"
				},
				paths = {
					"melee.attacks[2].cooldown"
				},
				value = b_heroes.hero_zefira.upgrades.upg_b.skill_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"aura_zefira_skill_b_check"
				},
				paths = {
					"cooldown"
				},
				value = b_heroes.hero_zefira.upgrades.upg_b.skill_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"hero_zefira"
				},
				paths = {
					"timed_attacks.list[1].cooldown"
				},
				value = b_heroes.hero_zefira.upgrades.upg_b.ult_red_factor
			}
		}
	},
	hero_zefira_upg_c = {
		id = "upg_c",
		class = "hero_zefira",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_zefira.upgrades.upg_c.regen_factor
			}
		}
	},
	hero_zefira_upg_d = {
		id = "upg_d",
		class = "hero_zefira",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_zefira.upgrades.upg_d.hp_ptg
			}
		}
	},
	hero_zefira_upg_e = {
		id = "upg_e",
		class = "hero_zefira",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_zefira"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max",
					"hero.level_stats.ranged_damage_min",
					"hero.level_stats.ranged_damage_max"
				},
				value = b_heroes.hero_zefira.upgrades.upg_e.dmg_factor
			}
		}
	},
	hero_bolin_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_bolin_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_bolin_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sa1.min_damage
			},
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sa1.max_damage
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_bolin_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sa2.min_damage
			},
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sa2.max_damage
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_bolin_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_bolin_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_bolin_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[2].max_mines"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb1.max_mines
			},
			{
				operators = "set",
				templates = {
					"aura_bolin_skill_b_trigger"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb1.min_damage
			},
			{
				operators = "set",
				templates = {
					"aura_bolin_skill_b_trigger"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb1.max_damage
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_bolin_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[2].max_mines"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb2.max_mines
			},
			{
				operators = "set",
				templates = {
					"aura_bolin_skill_b_trigger"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb2.min_damage
			},
			{
				operators = "set",
				templates = {
					"aura_bolin_skill_b_trigger"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sb2.max_damage
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_bolin_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_bolin_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_c.disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_bolin_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_bolin_skill_c",
					"bullet_bolin_ultimate_skill_c"
				},
				paths = {
					"hp_pctg"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sc1.hp_percentage
			},
			{
				operators = "set",
				templates = {
					"bullet_bolin_skill_c",
					"bullet_bolin_ultimate_skill_c"
				},
				paths = {
					"boss_hp_pctg"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sc1.boss_hp_percentage
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_bolin_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_bolin_skill_c",
					"bullet_bolin_ultimate_skill_c"
				},
				paths = {
					"hp_pctg"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sc2.hp_percentage
			},
			{
				operators = "set",
				templates = {
					"bullet_bolin_skill_c",
					"bullet_bolin_ultimate_skill_c"
				},
				paths = {
					"boss_hp_pctg"
				},
				value = b_heroes.hero_bolin.upgrades.upg_sc2.boss_hp_percentage
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_bolin_talent_1 = {
		id = "talent_1",
		class = "hero_bolin_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_bolin_talent_2 = {
		id = "talent_2",
		class = "hero_bolin_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_bolin_ulti = {
		id = "ulti",
		class = "hero_bolin_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_bolin_upg_a = {
		id = "upg_a",
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"ranged.attacks[1].cooldown"
				},
				value = b_heroes.hero_bolin.upgrades.upg_a.attack_cooldown
			}
		}
	},
	hero_bolin_upg_b = {
		id = "upg_b",
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"ranged.attacks[1].max_range"
				},
				value = b_heroes.hero_bolin.upgrades.upg_b.range_factor
			}
		}
	},
	hero_bolin_upg_c = {
		id = "upg_c",
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "map_sum",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.level_stats.armor"
				},
				value = b_heroes.hero_bolin.upgrades.upg_c.armor_inc
			}
		}
	},
	hero_bolin_upg_d = {
		id = "upg_d",
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max",
					"hero.level_stats.ranged_damage_min",
					"hero.level_stats.ranged_damage_max"
				},
				value = b_heroes.hero_bolin.upgrades.upg_d.dmg_factor
			}
		}
	},
	hero_bolin_upg_e = {
		id = "upg_e",
		class = "hero_bolin_g6",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_bolin.upgrades.upg_e.skill_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"hero_bolin_g6"
				},
				paths = {
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_bolin.upgrades.upg_e.ult_red_factor
			}
		}
	},
	hero_malik_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_malik_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_malik_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[1].hp_increase_ptg"
				},
				value = b_heroes.hero_malik.upgrades.upg_sa1.hp_increase_ptg
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_malik_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[1].hp_increase_ptg"
				},
				value = b_heroes.hero_malik.upgrades.upg_sa2.hp_increase_ptg
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_malik_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_malik_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_malik_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_malik_skill_b_stun"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_malik.upgrades.upg_sb1.stun_duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_malik_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[2].damage_radius"
				},
				value = b_heroes.hero_malik.upgrades.upg_sb2.damage_radius
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_malik_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_malik_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_malik_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_malik.upgrades.upg_sc1.cooldown
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_malik_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_malik.upgrades.upg_sc2.cooldown
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_malik_talent_1 = {
		id = "talent_1",
		class = "hero_malik_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_malik_talent_2 = {
		id = "talent_2",
		class = "hero_malik_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_malik_ulti = {
		id = "ulti",
		class = "hero_malik_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_malik_upg_a = {
		id = "upg_a",
		class = "hero_malik_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_malik.upgrades.upg_a.regen_factor
			}
		}
	},
	hero_malik_upg_b = {
		id = "upg_b",
		class = "hero_malik_g6",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"motion.max_speed"
				},
				value = b_heroes.hero_malik.upgrades.upg_b.movement_factor
			}
		}
	},
	hero_malik_upg_c = {
		id = "upg_c",
		class = "hero_malik_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"damage_based_on_health_upgrade_active"
				}
			}
		}
	},
	hero_malik_upg_d = {
		id = "upg_d",
		class = "hero_malik_g6",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_malik.upgrades.upg_d.hp_ptg
			}
		}
	},
	hero_malik_upg_e = {
		id = "upg_e",
		class = "hero_malik_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"chance_to_revive"
				},
				value = b_heroes.hero_malik.upgrades.upg_e.chance
			},
			{
				operators = "set",
				templates = {
					"hero_malik_g6"
				},
				paths = {
					"hp_ptg_on_revive"
				},
				value = b_heroes.hero_malik.upgrades.upg_e.hp_ptg
			}
		}
	},
	hero_ashbite_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_ashbite",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ashbite_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_a"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_a"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sa1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ashbite_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_a"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_a"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sa2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ashbite_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_ashbite",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ashbite_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_ashbite_skill_b_stun"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sb1.stun_duration
			},
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_b"
				},
				paths = {
					"aura.duration"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sb1.embers_duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ashbite_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_ashbite_skill_b_stun"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sb2.stun_duration
			},
			{
				operators = "set",
				templates = {
					"aura_ashbite_skill_b"
				},
				paths = {
					"aura.duration"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sb2.embers_duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ashbite_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_ashbite",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ashbite_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[3].heal_ptg"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sc1.heal_ptg
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ashbite_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_ashbite",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[3].heal_ptg"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_sc2.heal_ptg
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ashbite_talent_1 = {
		id = "talent_1",
		class = "hero_ashbite",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_ashbite_talent_2 = {
		id = "talent_2",
		class = "hero_ashbite",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_ashbite_ulti = {
		id = "ulti",
		class = "hero_ashbite",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_ashbite_upg_a = {
		id = "upg_a",
		class = "hero_ashbite",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_a.hp_ptg
			}
		}
	},
	hero_ashbite_upg_b = {
		id = "upg_b",
		class = "hero_ashbite",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"ranged.attacks[1].max_range"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_b.range_factor
			}
		}
	},
	hero_ashbite_upg_c = {
		id = "upg_c",
		class = "hero_ashbite",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_c.skill_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"timed_attacks.list[4].cooldown"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_c.ult_red_factor
			}
		}
	},
	hero_ashbite_upg_d = {
		id = "upg_d",
		class = "hero_ashbite",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_d.regen_factor
			}
		}
	},
	hero_ashbite_upg_e = {
		id = "upg_e",
		class = "hero_ashbite",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_ashbite"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max",
					"hero.level_stats.ranged_damage_min",
					"hero.level_stats.ranged_damage_max"
				},
				value = b_heroes.hero_ashbite.upgrades.upg_e.dmg_factor
			}
		}
	},
	hero_rhodes_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_rhodes",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_rhodes_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[1].cooldown"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa1.cooldown
			},
			{
				operators = "set",
				templates = {
					"bullet_rhodes_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_rhodes_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_rhodes_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[1].cooldown"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa2.cooldown
			},
			{
				operators = "set",
				templates = {
					"bullet_rhodes_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_rhodes_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sa2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_rhodes_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_rhodes",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_rhodes_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].hp_heal_ptg"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb1.hp_heal_ptg
			},
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].armor_inc"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb1.armor_inc
			},
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].trigger_hp_ptg"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb1.trigger_hp_ptg
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_rhodes_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].hp_heal_ptg"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb2.hp_heal_ptg
			},
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].armor_inc"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb2.armor_inc
			},
			{
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[2].trigger_hp_ptg"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sb2.trigger_hp_ptg
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_rhodes_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_rhodes",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_rhodes_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_rhodes_skill_c_slow"
				},
				paths = {
					"slow.factor"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sc1.slow_factor
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_rhodes_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_rhodes",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_rhodes_skill_c"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_rhodes_skill_c"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_sc2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_rhodes_talent_1 = {
		id = "talent_1",
		class = "hero_rhodes",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_rhodes_talent_2 = {
		id = "talent_2",
		class = "hero_rhodes",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_rhodes_ulti = {
		id = "ulti",
		class = "hero_rhodes",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_rhodes_upg_a = {
		id = "upg_a",
		class = "hero_rhodes",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_a.regen_factor
			}
		}
	},
	hero_rhodes_upg_b = {
		id = "upg_b",
		class = "hero_rhodes",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_b.hp_ptg
			}
		}
	},
	hero_rhodes_upg_c = {
		id = "upg_c",
		class = "hero_rhodes",
		patches = {
			{
				operators = "map_sum",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.level_stats.armor"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_c.armor_inc
			}
		}
	},
	hero_rhodes_upg_d = {
		id = "upg_d",
		class = "hero_rhodes",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_d.dmg_factor
			}
		}
	},
	hero_rhodes_upg_e = {
		id = "upg_e",
		priority = 4,
		class = "hero_rhodes",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_rhodes"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_rhodes.upgrades.upg_e.skills_cd_red_factor
			}
		}
	},
	hero_drakkan_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_drakkan",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_drakkan_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_a"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_a"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa1.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_drakkan_skill_a_silence"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa1.silence_duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_drakkan_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_a"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_a"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa2.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_drakkan_skill_a_silence"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sa2.silence_duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_drakkan_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_drakkan",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_drakkan_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_b"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sb1.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_b"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sb1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_drakkan_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_b"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sb2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_drakkan_skill_b"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sb2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_drakkan_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_drakkan",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_drakkan_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"soldier_drakkan_clone"
				},
				paths = {
					"reinforcement.duration"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sc1.duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_drakkan_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"soldier_drakkan_clone"
				},
				paths = {
					"reinforcement.duration"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_sc2.duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_drakkan_talent_1 = {
		id = "talent_1",
		class = "hero_drakkan",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_drakkan_talent_2 = {
		id = "talent_2",
		class = "hero_drakkan",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_drakkan_ulti = {
		id = "ulti",
		class = "hero_drakkan",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_drakkan_upg_a = {
		id = "upg_a",
		class = "hero_drakkan",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"health.magic_armor"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_a.magic_res
			}
		}
	},
	hero_drakkan_upg_b = {
		id = "upg_b",
		class = "hero_drakkan",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_b.regen_factor
			}
		}
	},
	hero_drakkan_upg_c = {
		id = "upg_c",
		priority = 4,
		class = "hero_drakkan",
		patches = {
			{
				operators = {"mul", "ceil"},
				templates = {
					"aura_drakkan_skill_a",
					"aura_drakkan_skill_b"
				},
				paths = {
					"aura.damage_min",
					"aura.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_c.skill_dmg_factor
			},
			{
				operators = {"mul", "ceil"},
				templates = {
					"bullet_drakkan_clone"
				},
				paths = {
					"bullet.damage_min",
					"bullet.damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_c.skill_dmg_factor
			}
		}
	},
	hero_drakkan_upg_d = {
		id = "upg_d",
		class = "hero_drakkan",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_drakkan"
				},
				paths = {
					"hero.level_stats.ranged_damage_min",
					"hero.level_stats.ranged_damage_max"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_d.dmg_factor
			}
		}
	},
	hero_drakkan_upg_e = {
		id = "upg_e",
		class = "hero_drakkan",
		patches = {
			{
				operators = "mul",
				templates = {
					"bullet_drakkan"
				},
				paths = {
					"bullet.damage_radius"
				},
				value = b_heroes.hero_drakkan.upgrades.upg_e.range_factor
			}
		}
	},
	hero_myriath_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_myriath",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_myriath_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_myriath_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sa1.min_damage
			},
			{
				operators = "set",
				templates = {
					"bullet_myriath_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sa1.max_damage
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_myriath_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_myriath_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sa2.min_damage
			},
			{
				operators = "set",
				templates = {
					"bullet_myriath_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sa2.max_damage
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_myriath_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_myriath",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_myriath_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sb1.cooldown
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_myriath_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sb2.cooldown
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_myriath_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_myriath",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_myriath_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[3].damage_min"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sc1.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[3].damage_max"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sc1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_myriath_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[3].damage_min"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[3].damage_max"
				},
				value = b_heroes.hero_myriath.upgrades.upg_sc2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_myriath_talent_1 = {
		id = "talent_1",
		class = "hero_myriath",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_myriath_talent_2 = {
		id = "talent_2",
		class = "hero_myriath",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_myriath_ulti = {
		id = "ulti",
		class = "hero_myriath",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_myriath_upg_a = {
		id = "upg_a",
		class = "hero_myriath",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_myriath"
				},
				paths = {
					"motion.max_speed"
				},
				value = b_heroes.hero_myriath.upgrades.upg_a.movement_factor
			}
		}
	},
	hero_myriath_upg_b = {
		id = "upg_b",
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"unit.damage_factor"
				},
				value = b_heroes.hero_myriath.upgrades.upg_b.damage_factor
			}
		}
	},
	hero_myriath_upg_c = {
		id = "upg_c",
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"melee.attacks[1].cooldown",
					"melee.attacks[2].cooldown"
				},
				value = b_heroes.hero_myriath.upgrades.upg_c.attack_cooldown
			}
		}
	},
	hero_myriath_upg_d = {
		id = "upg_d",
		class = "hero_myriath",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_myriath"
				},
				paths = {
					"dodge.upg_d_chance"
				},
				value = b_heroes.hero_myriath.upgrades.upg_d.dodge_chance
			}
		}
	},
	hero_myriath_upg_e = {
		id = "upg_e",
		priority = 4,
		class = "hero_myriath",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_myriath.upgrades.upg_e.skill_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"hero_myriath"
				},
				paths = {
					"timed_attacks.list[4].cooldown"
				},
				value = b_heroes.hero_myriath.upgrades.upg_e.ult_red_factor
			}
		}
	},
	hero_connor_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_connor",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_connor_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa1.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_connor_skill_a_bleed"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa1.bleed_duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_connor_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa2.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_connor_skill_a_bleed"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_connor.upgrades.upg_sa2.bleed_duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_connor_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_connor",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_connor_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb1.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb1.damage_max
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb1.cooldown
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_connor_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb2.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb2.damage_max
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[2].cooldown"
				},
				value = b_heroes.hero_connor.upgrades.upg_sb2.cooldown
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_connor_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_connor",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_connor_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_connor_skill_c"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc1.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_connor_skill_c"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc1.damage_max
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[3].aoe_count"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc1.amount_of_aoes
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_connor_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_connor_skill_c"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_connor_skill_c"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc2.damage_max
			},
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[3].aoe_count"
				},
				value = b_heroes.hero_connor.upgrades.upg_sc2.amount_of_aoes
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_connor_talent_1 = {
		id = "talent_1",
		class = "hero_connor",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_connor_talent_2 = {
		id = "talent_2",
		class = "hero_connor",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_connor_ulti = {
		id = "ulti",
		class = "hero_connor",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_connor_upg_a = {
		id = "upg_a",
		class = "hero_connor",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_a.hp_ptg
			}
		}
	},
	hero_connor_upg_b = {
		id = "upg_b",
		class = "hero_connor",
		patches = {
			{
				operators = "map_sum",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.level_stats.armor"
				},
				value = b_heroes.hero_connor.upgrades.upg_b.armor_inc
			}
		}
	},
	hero_connor_upg_c = {
		id = "upg_c",
		class = "hero_connor",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_connor.upgrades.upg_c.skills_cd_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"hero_connor"
				},
				paths = {
					"timed_attacks.list[4].cooldown"
				},
				value = b_heroes.hero_connor.upgrades.upg_c.ult_cd_red_factor
			}
		}
	},
	hero_connor_upg_d = {
		id = "upg_d",
		class = "hero_connor",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_connor"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max"
				},
				value = b_heroes.hero_connor.upgrades.upg_d.dmg_factor
			}
		}
	},
	hero_connor_upg_e = {
		id = "upg_e",
		class = "hero_connor",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_connor"
				},
				paths = {
					"melee.cooldown"
				},
				value = b_heroes.hero_connor.upgrades.upg_e.attack_cooldown
			}
		}
	},
	hero_ignus_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ignus_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_ignus_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_ignus_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sa1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ignus_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_ignus_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_ignus_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sa2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_ignus_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ignus_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_ignus_skill_b"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sb1.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_ignus_skill_b"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sb1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ignus_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"aura_ignus_skill_b"
				},
				paths = {
					"aura.damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sb2.damage_min
			},
			{
				operators = "set",
				templates = {
					"aura_ignus_skill_b"
				},
				paths = {
					"aura.damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sb2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_ignus_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ignus_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_ignus_hit_skill_c"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sc1.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_ignus_hit_skill_c"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sc1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ignus_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_ignus_hit_skill_c"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_ignus_hit_skill_c"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_sc2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_ignus_talent_1 = {
		id = "talent_1",
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_ignus_talent_2 = {
		id = "talent_2",
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_ignus_ulti = {
		id = "ulti",
		class = "hero_ignus_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_ignus_upg_a = {
		id = "upg_a",
		class = "hero_ignus_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"flywalk.disabled"
				}
			},
			{
				operators = "set",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"teleport"
				},
				value = {
					min_distance = b_heroes.hero_ignus.upgrades.upg_a.min_distance
				}
			}
		}
	},
	hero_ignus_upg_b = {
		id = "upg_b",
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_b.dmg_factor
			}
		}
	},
	hero_ignus_upg_c = {
		id = "upg_c",
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown",
					"timed_attacks.list[4].cooldown"
				},
				value = b_heroes.hero_ignus.upgrades.upg_c.skills_cd_red_factor
			}
		}
	},
	hero_ignus_upg_d = {
		id = "upg_d",
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.level_stats.regen_health"
				},
				value = b_heroes.hero_ignus.upgrades.upg_d.regen_factor
			}
		}
	},
	hero_ignus_upg_e = {
		id = "upg_e",
		class = "hero_ignus_g6",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_ignus_g6"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_ignus.upgrades.upg_e.hp_ptg
			}
		}
	},
	hero_oni_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_oni_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_oni_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"melee.attacks[3].damage_min"
				},
				value = b_heroes.hero_oni.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"melee.attacks[3].damage_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_sa1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_oni_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"melee.attacks[3].damage_min"
				},
				value = b_heroes.hero_oni.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"melee.attacks[3].damage_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_sa2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_oni_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_oni_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_oni_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[2].heal_ptg"
				},
				value = b_heroes.hero_oni.upgrades.upg_sb1.heal_ptg
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_oni_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[2].heal_ptg"
				},
				value = b_heroes.hero_oni.upgrades.upg_sb2.heal_ptg
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_oni_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_oni_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[3].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_oni_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_oni_hit_skill_c"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc1.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_oni_hit_skill_c"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc1.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_oni_skill_c_armor_sunder"
				},
				paths = {
					"modifier.armor_red_factor"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc1.armor_red
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_oni_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_oni_hit_skill_c"
				},
				paths = {
					"damage_min"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_oni_hit_skill_c"
				},
				paths = {
					"damage_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc2.damage_max
			},
			{
				operators = "set",
				templates = {
					"mod_oni_skill_c_armor_sunder"
				},
				paths = {
					"modifier.armor_red_factor"
				},
				value = b_heroes.hero_oni.upgrades.upg_sc2.armor_red
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_oni_talent_1 = {
		id = "talent_1",
		class = "hero_oni_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			}
		}
	},
	hero_oni_talent_2 = {
		id = "talent_2",
		class = "hero_oni_g6",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_oni_ulti = {
		id = "ulti",
		class = "hero_oni_g6",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_oni_upg_a = {
		id = "upg_a",
		class = "hero_oni_g6",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"timed_attacks.list[1].cooldown",
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown",
					"timed_attacks.list[4].cooldown"
				},
				value = b_heroes.hero_oni.upgrades.upg_a.skills_cd_red_factor
			}
		}
	},
	hero_oni_upg_b = {
		id = "upg_b",
		class = "hero_oni_g6",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_b.hp_ptg
			}
		}
	},
	hero_oni_upg_c = {
		id = "upg_c",
		class = "hero_oni_g6",
		patches = {
			{
				operators = "map_sum",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.level_stats.armor"
				},
				value = b_heroes.hero_oni.upgrades.upg_c.armor_inc
			}
		}
	},
	hero_oni_upg_d = {
		id = "upg_d",
		class = "hero_oni_g6",
		patches = {
			{
				operators = "set",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"melee.attacks[1].cooldown"
				},
				value = b_heroes.hero_oni.upgrades.upg_d.attack_cooldown
			}
		}
	},
	hero_oni_upg_e = {
		id = "upg_e",
		class = "hero_oni_g6",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_oni_g6"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max"
				},
				value = b_heroes.hero_oni.upgrades.upg_e.damage_factor
			}
		}
	},
	hero_illiana_skill_a = {
		id = "skill_a",
		priority = 1,
		class = "hero_illiana",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = false,
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"ranged.attacks[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_illiana_upg_sa1 = {
		id = "upg_sa1",
		priority = 2,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_illiana_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sa1.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_illiana_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sa1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_illiana_upg_sa2 = {
		id = "upg_sa2",
		priority = 3,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"bullet_illiana_skill_a"
				},
				paths = {
					"bullet.damage_min"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sa2.damage_min
			},
			{
				operators = "set",
				templates = {
					"bullet_illiana_skill_a"
				},
				paths = {
					"bullet.damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sa2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_a.level"
				}
			}
		}
	},
	hero_illiana_skill_b = {
		id = "skill_b",
		priority = 1,
		class = "hero_illiana",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"timed_attacks.list[2].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_illiana_upg_sb1 = {
		id = "upg_sb1",
		priority = 2,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_illiana_skill_b_stun"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sb1.stun_duration
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_illiana_upg_sb2 = {
		id = "upg_sb2",
		priority = 3,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"mod_illiana_skill_b_stun"
				},
				paths = {
					"modifier.duration"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sb2.stun_duration
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_b.level"
				}
			}
		}
	},
	hero_illiana_skill_c = {
		id = "skill_c",
		priority = 1,
		class = "hero_illiana",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"timed_attacks.list[1].disabled"
				}
			},
			{
				value = 1,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_illiana_upg_sc1 = {
		id = "upg_sc1",
		priority = 2,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sc1.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sc1.damage_max
			},
			{
				value = 2,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_illiana_upg_sc2 = {
		id = "upg_sc2",
		priority = 3,
		class = "hero_illiana",
		patches = {
			{
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"timed_attacks.list[1].damage_min"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sc2.damage_min
			},
			{
				operators = "set",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"timed_attacks.list[1].damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_sc2.damage_max
			},
			{
				value = 3,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.skill_c.level"
				}
			}
		}
	},
	hero_illiana_talent_1 = {
		id = "talent_1",
		class = "hero_illiana",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.talent_1.disabled"
				}
			},
			{
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"dodge.chance"
				},
				value = b_heroes.hero_illiana.talent_1.dodge_chance
			}
		}
	},
	hero_illiana_talent_2 = {
		id = "talent_2",
		class = "hero_illiana",
		patches = {
			{
				value = false,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.talent_2.disabled"
				}
			}
		}
	},
	hero_illiana_ulti = {
		id = "ulti",
		class = "hero_illiana",
		patches = {
			{
				value = true,
				operators = "set",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.skills.ultimate.active"
				}
			}
		}
	},
	hero_illiana_upg_a = {
		id = "upg_a",
		class = "hero_illiana",
		patches = {
			{
				operators = "mul",
				templates = {
					"hero_illiana"
				},
				paths = {
					"ranged.attacks[1].min_range"
				},
				value = b_heroes.hero_illiana.upgrades.upg_a.range_inc_factor
			},
			{
				operators = "mul",
				templates = {
					"hero_illiana"
				},
				paths = {
					"ranged.attacks[1].max_range"
				},
				value = b_heroes.hero_illiana.upgrades.upg_a.range_inc_factor
			},
			{
				operators = "mul",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"ranged.attacks[1].max_range"
				},
				value = b_heroes.hero_illiana.upgrades.upg_a.range_inc_factor
			}
		}
	},
	hero_illiana_upg_b = {
		id = "upg_b",
		class = "hero_illiana",
		patches = {
			{
				operators = "map_mul_sum",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.level_stats.hp_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_b.hp_ptg
			}
		}
	},
	hero_illiana_upg_c = {
		id = "upg_c",
		class = "hero_illiana",
		patches = {
			{
				operators = "mul_sub",
				templates = {
					"hero_illiana"
				},
				paths = {
					"timed_attacks.list[2].cooldown",
					"timed_attacks.list[3].cooldown"
				},
				value = b_heroes.hero_illiana.upgrades.upg_c.skills_cd_red_factor
			},
			{
				operators = "mul_sub",
				templates = {
					"decal_illiana_dragon"
				},
				paths = {
					"ranged.attacks[2].cooldown",
					"timed_attacks.list[1].cooldown"
				},
				value = b_heroes.hero_illiana.upgrades.upg_c.skills_cd_red_factor
			}
		}
	},
	hero_illiana_upg_d = {
		id = "upg_d",
		class = "hero_illiana",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_illiana"
				},
				paths = {
					"hero.level_stats.melee_damage_min",
					"hero.level_stats.melee_damage_max",
					"hero.level_stats.ranged_damage_min",
					"hero.level_stats.ranged_damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_d.dmg_factor
			}
		}
	},
	hero_illiana_upg_e = {
		id = "upg_e",
		class = "hero_illiana",
		patches = {
			{
				operators = "map_mul",
				templates = {
					"hero_illiana"
				},
				paths = {
					"dragon_ranged_damage_min",
					"dragon_ranged_damage_max"
				},
				value = b_heroes.hero_illiana.upgrades.upg_e.dmg_factor
			}
		}
	},
	hero_silent_skill_a = {id = "skill_a", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.skill_a.level"}}}},
	hero_silent_upg_sa1 = {id = "upg_sa1", class = "hero_silent", patches = {{operators = "set", value = 2, templates = {"hero_silent"}, paths = {"hero.skills.skill_a.level"}}}},
	hero_silent_upg_sa2 = {id = "upg_sa2", class = "hero_silent", patches = {{operators = "set", value = 3, templates = {"hero_silent"}, paths = {"hero.skills.skill_a.level"}}}},
	hero_silent_skill_b = {id = "skill_b", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.skill_b.level"}}}},
	hero_silent_upg_sb1 = {id = "upg_sb1", class = "hero_silent", patches = {{operators = "set", value = 2, templates = {"hero_silent"}, paths = {"hero.skills.skill_b.level"}}}},
	hero_silent_upg_sb2 = {id = "upg_sb2", class = "hero_silent", patches = {{operators = "set", value = 3, templates = {"hero_silent"}, paths = {"hero.skills.skill_b.level"}}}},
	hero_silent_skill_c = {id = "skill_c", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.skill_c.level"}}}},
	hero_silent_upg_sc1 = {id = "upg_sc1", class = "hero_silent", patches = {{operators = "set", value = 2, templates = {"hero_silent"}, paths = {"hero.skills.skill_c.level"}}}},
	hero_silent_upg_sc2 = {id = "upg_sc2", class = "hero_silent", patches = {{operators = "set", value = 3, templates = {"hero_silent"}, paths = {"hero.skills.skill_c.level"}}}},
	hero_silent_talent_1 = {id = "talent_1", class = "hero_silent", patches = {
		{operators = "set", value = false, templates = {"hero_silent"}, paths = {"hero.skills.talent_1.disabled"}},
		{operators = "map_sum", value = -150, templates = {"hero_silent"}, paths = {"hero.level_stats.hp_max"}}
	}},
	hero_silent_talent_2 = {id = "talent_2", class = "hero_silent", patches = {{operators = "set", value = false, templates = {"hero_silent"}, paths = {"hero.skills.talent_2.disabled"}}}},
	hero_silent_ulti = {id = "ulti", class = "hero_silent", patches = {{operators = "set", value = true, templates = {"hero_silent"}, paths = {"hero.skills.ultimate.active"}}}},
	hero_silent_upg_a = {id = "upg_a", class = "hero_silent", patches = {
		{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.upg_a.level"}},
		{operators = "set", value = 100, templates = {"hero_silent"}, paths = {"teleport.min_distance"}}
	}},
	hero_silent_upg_b = {id = "upg_b", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.upg_b.level"}}}},
	hero_silent_upg_c = {id = "upg_c", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.upg_c.level"}}}},
	hero_silent_upg_d = {id = "upg_d", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.upg_d.level"}}}},
	hero_silent_upg_e = {id = "upg_e", class = "hero_silent", patches = {{operators = "set", value = 1, templates = {"hero_silent"}, paths = {"hero.skills.upg_e.level"}}}}
}
