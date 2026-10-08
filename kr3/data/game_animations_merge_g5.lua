-- chunkname: @./kr3/data/game_animations_merge_g5.lua
-- AUTO-GENERATED: merged from kr3/data/animations by file LastWriteTime.
-- Group: LastWriteTime < 2026-06-01 00:00:00
-- File count: 189

local out = { animations = {} }

local function __merge_animations(d)
	if d == nil then
		return
	end

	if d.animations ~= nil then
		out = table.deepmerge(out, d)
	else
		out = table.deepmerge(out, { animations = d })
	end
end

-- BEGIN kr3/data/animations/amalgam.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/amalgam.lua

local a = {
	Amalgam_Death_Decal_decal = {
		prefix = "Amalgam_Death_Decal",
		to = 1,
		from = 1
	},
	Amalgam_Attack1_run = {
		prefix = "Amalgam_Attack1",
		to = 27,
		from = 1
	},
	Amalgam_Attack2_run = {
		prefix = "Amalgam_Attack2",
		to = 28,
		from = 1
	},
	Amalgam_dude_idle = {
		prefix = "Amalgam_dude",
		to = 1,
		from = 1
	},
	Amalgam_dude_walk = {
		prefix = "Amalgam_dude",
		to = 33,
		from = 2
	},
	Amalgam_dude_state_1 = {
		prefix = "Amalgam_dude",
		to = 66,
		from = 34
	},
	Amalgam_dude_state_1_loop = {
		prefix = "Amalgam_dude",
		to = 91,
		from = 67
	},
	Amalgam_dude_state_2 = {
		prefix = "Amalgam_dude",
		to = 105,
		from = 92
	},
	Amalgam_dude_state_2_loop = {
		prefix = "Amalgam_dude",
		to = 130,
		from = 106
	},
	Amalgam_dude_spawn = {
		prefix = "Amalgam_dude",
		to = 204,
		from = 131
	},
	Amalgam_dude_walk_down = {
		prefix = "Amalgam_dude",
		to = 236,
		from = 205
	},
	Amalgam_dude_walk_up = {
		prefix = "Amalgam_dude",
		to = 268,
		from = 237
	},
	Amalgam_dude_attack = {
		prefix = "Amalgam_dude",
		to = 312,
		from = 269
	},
	Amalgam_dude_death = {
		prefix = "Amalgam_dude",
		to = 352,
		from = 313
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/amalgam.lua

-- BEGIN kr3/data/animations/animated_armor.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/animated_armor.lua

local a = {
	armor_idle = {
		prefix = "armor",
		to = 20,
		from = 1
	},
	armor_death = {
		prefix = "armor",
		to = 54,
		from = 21
	},
	armor_revive = {
		prefix = "armor",
		to = 88,
		from = 55
	},
	armor_deadidle = {
		prefix = "armor",
		to = 98,
		from = 89
	},
	armor_fadeout = {
		prefix = "armor",
		to = 112,
		from = 99
	},
	armor_fadeoutidle = {
		prefix = "armor",
		to = 113,
		from = 113
	},
	armor_attack = {
		prefix = "armor",
		to = 160,
		from = 114
	},
	armor_walk = {
		prefix = "armor",
		to = 184,
		from = 161
	},
	armor_walk_down = {
		prefix = "armor",
		to = 208,
		from = 185
	},
	armor_walk_up = {
		prefix = "armor",
		to = 232,
		from = 209
	},
	armor_spawn = {
		prefix = "armor",
		to = 266,
		from = 233
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/animated_armor.lua

-- BEGIN kr3/data/animations/arcane_arborean_emissary.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/arcane_arborean_emissary.lua

local a = {
	arborean_emissary_lvl4_tower_layerX_idle = {
		layer_to = 1,
		from = 1,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arborean_emissary_lvl4_tower_layerX_idle_2 = {
		layer_to = 1,
		from = 2,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	arborean_emissary_lvl4_tower_layerX_idle_3 = {
		layer_to = 1,
		from = 50,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 77,
		layer_from = 1
	},
	arborean_emissary_lvl4_tower_layerX_attack = {
		layer_to = 1,
		from = 78,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 129,
		layer_from = 1
	},
	arborean_emissary_lvl4_tower_layerX_gift_of_nature = {
		layer_to = 1,
		from = 130,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 187,
		layer_from = 1
	},
	arborean_emissary_lvl4_tower_layerX_thorny_garden = {
		layer_to = 1,
		from = 188,
		layer_prefix = "arborean_emissary_lvl4_tower_layer%i",
		to = 252,
		layer_from = 1
	},
	arborean_emissary_lvl3_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "arborean_emissary_lvl3_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arborean_emissary_lvl3_tower_layerX_idle_2 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "arborean_emissary_lvl3_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	arborean_emissary_lvl3_tower_layerX_attack = {
		layer_to = 3,
		from = 50,
		layer_prefix = "arborean_emissary_lvl3_tower_layer%i",
		to = 100,
		layer_from = 1
	},
	arborean_emissary_lvl2_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "arborean_emissary_lvl2_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arborean_emissary_lvl2_tower_layerX_idle_2 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "arborean_emissary_lvl2_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	arborean_emissary_lvl2_tower_layerX_attack = {
		layer_to = 3,
		from = 50,
		layer_prefix = "arborean_emissary_lvl2_tower_layer%i",
		to = 100,
		layer_from = 1
	},
	arborean_emissary_lvl1_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "arborean_emissary_lvl1_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arborean_emissary_lvl1_tower_layerX_idle_2 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "arborean_emissary_lvl1_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	arborean_emissary_lvl1_tower_layerX_attack = {
		layer_to = 3,
		from = 50,
		layer_prefix = "arborean_emissary_lvl1_tower_layer%i",
		to = 100,
		layer_from = 1
	},
	arborean_emissary_build = {
		prefix = "arborean_emissary_build",
		to = 1,
		from = 1
	},
	arborean_emissary_basic_attack_modifier = {
		prefix = "arborean_emissary_basic_attack_modifier",
		to = 44,
		from = 1
	},
	arborean_emissary_basic_attack_modifier_decal = {
		prefix = "arborean_emissary_basic_attack_modifier_decal",
		to = 1,
		from = 1
	},
	arborean_emissary_basic_attack_modifier_big = {
		prefix = "arborean_emissary_basic_attack_modifier_big",
		to = 44,
		from = 1
	},
	arborean_emissary_basic_attack_modifier_decal_big = {
		prefix = "arborean_emissary_basic_attack_modifier_decal_big",
		to = 1,
		from = 1
	},
	arborean_emissary_thorny_garden_thorns_floor_in = {
		prefix = "arborean_emissary_thorny_garden_thorns_floor",
		to = 16,
		from = 1
	},
	arborean_emissary_thorny_garden_thorns_floor_out = {
		prefix = "arborean_emissary_thorny_garden_thorns_floor",
		to = 21,
		from = 17
	},
	arborean_emissary_gift_of_nature_heal = {
		prefix = "arborean_emissary_gift_of_nature_heal",
		to = 16,
		from = 1
	},
	arborean_emissary_gift_of_nature_heal_glow = {
		prefix = "arborean_emissary_gift_of_nature_heal_glow",
		to = 1,
		from = 1
	},
	arborean_emissary_gift_of_nature_pollen = {
		prefix = "arborean_emissary_gift_of_nature_pollen",
		to = 30,
		from = 1
	},
	arborean_emissary_gift_of_nature_wisp = {
		prefix = "arborean_emissary_gift_of_nature_wisp",
		to = 29,
		from = 1
	},
	arborean_emissary_hit = {
		prefix = "arborean_emissary_hit",
		to = 19,
		from = 1
	},
	arborean_emissary_projectile_flying = {
		prefix = "arborean_emissary_projectile",
		to = 12,
		from = 1
	},
	arborean_emissary_particle = {
		prefix = "arborean_emissary_particle",
		to = 15,
		from = 1
	},
	arborean_emissary_thorny_garden_thorns_big_run = {
		prefix = "arborean_emissary_thorny_garden_thorns_big",
		to = 12,
		from = 1
	},
	arborean_emissary_thorny_garden_thorns_big_idle = {
		prefix = "arborean_emissary_thorny_garden_thorns_big",
		to = 13,
		from = 13
	},
	arborean_emissary_thorny_garden_thorns_big_out = {
		prefix = "arborean_emissary_thorny_garden_thorns_big",
		to = 26,
		from = 14
	},
	arborean_emissary_thorny_garden_thorns_small_run = {
		prefix = "arborean_emissary_thorny_garden_thorns_small",
		to = 12,
		from = 1
	},
	arborean_emissary_thorny_garden_thorns_small_idle = {
		prefix = "arborean_emissary_thorny_garden_thorns_small",
		to = 13,
		from = 13
	},
	arborean_emissary_thorny_garden_thorns_small_out = {
		prefix = "arborean_emissary_thorny_garden_thorns_small",
		to = 26,
		from = 14
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/arcane_arborean_emissary.lua

-- BEGIN kr3/data/animations/arcane_wizard_tower.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/arcane_wizard_tower.lua

local a = {
	arcane_wizard_tower_empowerment_indicator = {
		prefix = "arcane_wizard_tower_empowerment_indicator",
		to = 1,
		from = 1
	},
	arcane_wizard_tower_empowerment_particles_idle = {
		prefix = "arcane_wizard_tower_empowerment_particles",
		to = 30,
		from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_idle = {
		layer_to = 8,
		from = 1,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_idle_back = {
		layer_to = 8,
		from = 2,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 2,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_attack = {
		layer_to = 8,
		from = 3,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 44,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_attack_back = {
		layer_to = 8,
		from = 45,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 86,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_skill1 = {
		layer_to = 8,
		from = 87,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 139,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_skill1_back = {
		layer_to = 8,
		from = 140,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 192,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_skill2 = {
		layer_to = 8,
		from = 193,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 241,
		layer_from = 1
	},
	arcane_wizard_tower_lvl4_tower_layerX_skill2_back = {
		layer_to = 8,
		from = 242,
		layer_prefix = "arcane_wizard_tower_lvl4_tower_layer%i",
		to = 290,
		layer_from = 1
	},
	arcane_wizard_tower_lvl3_tower_layerX_idle = {
		layer_to = 6,
		from = 1,
		layer_prefix = "arcane_wizard_tower_lvl3_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arcane_wizard_tower_lvl3_tower_layerX_idle_back = {
		layer_to = 6,
		from = 2,
		layer_prefix = "arcane_wizard_tower_lvl3_tower_layer%i",
		to = 2,
		layer_from = 1
	},
	arcane_wizard_tower_lvl3_tower_layerX_attack = {
		layer_to = 6,
		from = 3,
		layer_prefix = "arcane_wizard_tower_lvl3_tower_layer%i",
		to = 44,
		layer_from = 1
	},
	arcane_wizard_tower_lvl3_tower_layerX_attack_back = {
		layer_to = 6,
		from = 45,
		layer_prefix = "arcane_wizard_tower_lvl3_tower_layer%i",
		to = 86,
		layer_from = 1
	},
	arcane_wizard_tower_lvl2_tower_layerX_idle = {
		layer_to = 10,
		from = 1,
		layer_prefix = "arcane_wizard_tower_lvl2_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arcane_wizard_tower_lvl2_tower_layerX_idle_back = {
		layer_to = 10,
		from = 2,
		layer_prefix = "arcane_wizard_tower_lvl2_tower_layer%i",
		to = 2,
		layer_from = 1
	},
	arcane_wizard_tower_lvl2_tower_layerX_attack = {
		layer_to = 10,
		from = 3,
		layer_prefix = "arcane_wizard_tower_lvl2_tower_layer%i",
		to = 44,
		layer_from = 1
	},
	arcane_wizard_tower_lvl2_tower_layerX_attack_back = {
		layer_to = 10,
		from = 45,
		layer_prefix = "arcane_wizard_tower_lvl2_tower_layer%i",
		to = 86,
		layer_from = 1
	},
	arcane_wizard_tower_lvl1_tower_layerX_idle = {
		layer_to = 5,
		from = 1,
		layer_prefix = "arcane_wizard_tower_lvl1_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	arcane_wizard_tower_lvl1_tower_layerX_idle_back = {
		layer_to = 5,
		from = 2,
		layer_prefix = "arcane_wizard_tower_lvl1_tower_layer%i",
		to = 2,
		layer_from = 1
	},
	arcane_wizard_tower_lvl1_tower_layerX_attack = {
		layer_to = 5,
		from = 3,
		layer_prefix = "arcane_wizard_tower_lvl1_tower_layer%i",
		to = 44,
		layer_from = 1
	},
	arcane_wizard_tower_lvl1_tower_layerX_attack_back = {
		layer_to = 5,
		from = 45,
		layer_prefix = "arcane_wizard_tower_lvl1_tower_layer%i",
		to = 86,
		layer_from = 1
	},
	arcane_wizard_tower_build = {
		prefix = "arcane_wizard_tower_build",
		to = 1,
		from = 1
	},
	arcane_wizard_tower_preview = {
		prefix = "arcane_wizard_tower_preview",
		to = 1,
		from = 1
	},
	arcane_wizard_tower_lvl4_disintegration_ray_charge_origin = {
		prefix = "arcane_wizard_tower_lvl4_disintegration_ray_charge_origin",
		to = 39,
		from = 1
	},
	arcane_wizard_tower_lvl4_disintegration_dirt_big_idle = {
		prefix = "arcane_wizard_tower_lvl4_disintegration_dirt_big",
		to = 13,
		from = 1
	},
	arcane_wizard_tower_lvl4_disintegration_dirt_small_idle = {
		prefix = "arcane_wizard_tower_lvl4_disintegration_dirt_small",
		to = 13,
		from = 1
	},
	arcane_wizard_tower_lvl4_disintegration_hit_idle = {
		prefix = "arcane_wizard_tower_lvl4_disintegration_hit",
		to = 17,
		from = 1
	},
	arcane_wizard_tower_lvl4_disintegration_ray_idle = {
		prefix = "arcane_wizard_tower_lvl4_disintegration_ray",
		to = 19,
		from = 1
	},
	arcane_wizard_tower_ray_start_idle = {
		prefix = "arcane_wizard_tower_ray_start",
		to = 9,
		from = 1
	},
	arcane_wizard_tower_ray_end_idle = {
		prefix = "arcane_wizard_tower_ray_end",
		to = 9,
		from = 1
	},
	arcane_wizard_tower_lvl4_ray_idle = {
		prefix = "arcane_wizard_tower_lvl4_ray",
		to = 22,
		from = 1
	},
	arcane_wizard_tower_empowerment_decal = {
		prefix = "arcane_wizard_tower_empowerment_decal",
		to = 1,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/arcane_wizard_tower.lua

-- BEGIN kr3/data/animations/armored_nightmare.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/armored_nightmare.lua

local a = {
	armored_nightmare_explosion_idle = {
		prefix = "armored_nightmare_explosion",
		to = 20,
		from = 1
	},
	armored_nightmare_fx_idle = {
		prefix = "armored_nightmare_fx",
		to = 6,
		from = 1
	},
	armored_nightmare_enemy_walkingRightLeft = {
		prefix = "armored_nightmare_enemy",
		to = 24,
		from = 2
	},
	armored_nightmare_enemy_walkingDown = {
		prefix = "armored_nightmare_enemy",
		to = 48,
		from = 25
	},
	armored_nightmare_enemy_walk_back = {
		prefix = "armored_nightmare_enemy",
		to = 72,
		from = 49
	},
	armored_nightmare_enemy_attk_1 = {
		prefix = "armored_nightmare_enemy",
		to = 99,
		from = 73
	},
	armored_nightmare_enemy_attk_2 = {
		prefix = "armored_nightmare_enemy",
		to = 129,
		from = 100
	},
	armored_nightmare_enemy_attk_3 = {
		prefix = "armored_nightmare_enemy",
		to = 155,
		from = 130
	},
	armored_nightmare_enemy_death = {
		prefix = "armored_nightmare_enemy",
		to = 185,
		from = 156
	},
	armored_nightmare_enemy_idle = {
		prefix = "armored_nightmare_enemy",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/armored_nightmare.lua

-- BEGIN kr3/data/animations/ash_spirit.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/ash_spirit.lua

local a = {
	ashspirit_fx_heal_behind_run = {
		prefix = "ashspirit_fx_heal_behind",
		to = 16,
		from = 1
	},
	ashspirit_fx_heal_croses_run = {
		prefix = "ashspirit_fx_heal_croses",
		to = 30,
		from = 1
	},
	ashspirit_fx_floor_decal_run = {
		prefix = "ashspirit_fx_floor_decal",
		to = 1,
		from = 1
	},
	ashspirit_fx_vfx_explosion_attack_1 = {
		prefix = "ashspirit_fx_vfx_explosion",
		to = 25,
		from = 1
	},
	ashspirit_fx_floor_decal_small_decal = {
		prefix = "ashspirit_fx_floor_decal_small",
		to = 71,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/ash_spirit.lua

-- BEGIN kr3/data/animations/bane_wolf.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/bane_wolf.lua

local a = {
	bane_wolf_creep_idle = {
		prefix = "bane_wolf_creep",
		to = 1,
		from = 1
	},
	bane_wolf_creep_walk = {
		prefix = "bane_wolf_creep",
		to = 15,
		from = 2
	},
	bane_wolf_creep_walk_front = {
		prefix = "bane_wolf_creep",
		to = 29,
		from = 16
	},
	bane_wolf_creep_walk_back = {
		prefix = "bane_wolf_creep",
		to = 43,
		from = 30
	},
	bane_wolf_creep_attack = {
		prefix = "bane_wolf_creep",
		to = 69,
		from = 44
	},
	bane_wolf_creep_death = {
		prefix = "bane_wolf_creep",
		to = 89,
		from = 70
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/bane_wolf.lua

-- BEGIN kr3/data/animations/big_terracota.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/big_terracota.lua

local a = {
	big_terracota_idle = {
		prefix = "terracota_grande",
		to = 1,
		from = 1
	},
	big_terracota_raise = {
		prefix = "terracota_grande",
		to = 1,
		from = 1
	},
	big_terracota_walk = {
		prefix = "terracota_grande",
		to = 39,
		from = 2
	},
	big_terracota_walkdown = {
		prefix = "terracota_grande",
		to = 77,
		from = 40
	},
	big_terracota_walkup = {
		prefix = "terracota_grande",
		to = 115,
		from = 78
	},
	big_terracota_attack = {
		prefix = "terracota_grande",
		to = 149,
		from = 116
	},
	big_terracota_death = {
		prefix = "terracota_grande",
		to = 204,
		from = 150
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/big_terracota.lua

-- BEGIN kr3/data/animations/blaze_raider.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/blaze_raider.lua

local a = {
	blaze_rider_hit_run = {
		prefix = "blaze_rider_hit",
		to = 10,
		from = 1
	},
	blaze_rider_idle = {
		prefix = "blaze_rider",
		to = 1,
		from = 1
	},
	blaze_rider_walk = {
		prefix = "blaze_rider",
		to = 25,
		from = 2
	},
	blaze_rider_walk_down = {
		prefix = "blaze_rider",
		to = 49,
		from = 26
	},
	blaze_rider_walk_up = {
		prefix = "blaze_rider",
		to = 73,
		from = 50
	},
	blaze_rider_attk_1 = {
		prefix = "blaze_rider",
		to = 116,
		from = 74
	},
	blaze_rider_attk_2 = {
		prefix = "blaze_rider",
		to = 144,
		from = 117
	},
	blaze_rider_attk_3 = {
		prefix = "blaze_rider",
		to = 180,
		from = 145
	},
	blaze_rider_death = {
		prefix = "blaze_rider",
		to = 228,
		from = 181
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/blaze_raider.lua

-- BEGIN kr3/data/animations/blinker.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/blinker.lua

local a = {
	blinker_creep_idle = {
		prefix = "blinker_creep",
		to = 16,
		from = 1
	},
	blinker_creep_walk = {
		prefix = "blinker_creep",
		to = 32,
		from = 17
	},
	blinker_creep_blink = {
		prefix = "blinker_creep",
		to = 48,
		from = 33
	},
	blinker_creep_walk_front = {
		prefix = "blinker_creep",
		to = 64,
		from = 49
	},
	blinker_creep_blink_front = {
		prefix = "blinker_creep",
		to = 80,
		from = 65
	},
	blinker_creep_walk_back = {
		prefix = "blinker_creep",
		to = 96,
		from = 81
	},
	blinker_creep_stun = {
		prefix = "blinker_creep",
		to = 112,
		from = 97
	},
	blinker_creep_death = {
		prefix = "blinker_creep",
		to = 127,
		from = 113
	},
	blinker_glare_decal_Idle = {
		prefix = "blinker_glare_decal",
		to = 18,
		from = 1
	},
	blinker_glare_fx_Idle = {
		prefix = "blinker_glare_fx",
		to = 29,
		from = 1
	},
	blinker_stun_fx_Idle = {
		prefix = "blinker_stun_fx",
		to = 36,
		from = 1
	},
	blinker_stun_decal_Idle = {
		prefix = "blinker_stun_decal",
		to = 33,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/blinker.lua

-- BEGIN kr3/data/animations/boss_spider_queen.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/boss_spider_queen.lua

local a = {
	boss_effects_circle_drain_loop = {
		prefix = "spider_queen_boss_effects_circle_drain",
		to = 30,
		from = 1
	},
	boss_effects_circle_drain_out = {
		prefix = "spider_queen_boss_effects_circle_drain",
		to = 44,
		from = 31
	},
	boss_effects_poison_idle = {
		prefix = "spider_queen_boss_effects_poison",
		to = 14,
		from = 1
	},
	boss_effects_egg_effect_run = {
		prefix = "spider_queen_boss_effects_egg_effect",
		to = 20,
		from = 1
	},
	boss_effects_egg_in = {
		prefix = "spider_queen_boss_effects_egg",
		to = 6,
		from = 1
	},
	boss_effects_egg_idle = {
		prefix = "spider_queen_boss_effects_egg",
		to = 8,
		from = 7
	},
	boss_effects_egg_out = {
		prefix = "spider_queen_boss_effects_egg",
		to = 21,
		from = 9
	},
	boss_effects_decal_front_run = {
		prefix = "spider_queen_boss_effects_decal_front",
		to = 13,
		from = 1
	},
	boss_effects_decal_back = {
		prefix = "spider_queen_boss_effects_decal_back",
		to = 13,
		from = 1
	},
	boss_effects_hit_drain_run = {
		prefix = "spider_queen_boss_effects_hit_drain",
		to = 12,
		from = 1
	},
	boss_effects_healing = {
		prefix = "spider_queen_boss_effects_healing",
		to = 22,
		from = 1
	},
	boss_effects_trail2 = {
		prefix = "spider_queen_boss_effects_trail2",
		to = 12,
		from = 1
	},
	boss_effects_trail = {
		prefix = "spider_queen_boss_effects_trail",
		to = 12,
		from = 1
	},
	boss_effects_bolt_magic_idle = {
		prefix = "spider_queen_boss_effects_bolt_magic",
		to = 20,
		from = 1
	},
	boss_effects_hit_run = {
		prefix = "spider_queen_boss_effects_hit",
		to = 10,
		from = 1
	},
	boss_effects_bolt_run = {
		prefix = "spider_queen_boss_effects_bolt",
		to = 2,
		from = 1
	},
	boss_effects_bolt_trail = {
		prefix = "spider_queen_boss_effects_bolt_trail",
		to = 10,
		from = 1
	},
	boss_effects_bolt_magic_flying = {
		prefix = "spider_queen_boss_effects_bolt_magic",
		to = 20,
		from = 1
	},
	boss_effects_bolt_flying = {
		prefix = "spider_queen_boss_effects_bolt",
		to = 2,
		from = 1
	},
	spider_queen_tap = {
		prefix = "spider_queen_tap",
		to = 7,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/boss_spider_queen.lua

-- BEGIN kr3/data/animations/brute_welder.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/brute_welder.lua

local a = {
	brute_welder_creep_idle = {
		prefix = "brute_welder_creep",
		to = 4,
		from = 1
	},
	brute_welder_creep_walk = {
		prefix = "brute_welder_creep",
		to = 30,
		from = 5
	},
	brute_welder_creep_walk_front = {
		prefix = "brute_welder_creep",
		to = 56,
		from = 31
	},
	brute_welder_creep_walk_back = {
		prefix = "brute_welder_creep",
		to = 82,
		from = 57
	},
	brute_welder_creep_attack = {
		prefix = "brute_welder_creep",
		to = 136,
		from = 83
	},
	brute_welder_creep_death = {
		prefix = "brute_welder_creep",
		to = 182,
		from = 137
	},
	brute_welder_attack_mod_loop = {
		prefix = "brute_welder_attack_mod",
		to = 10,
		from = 1
	},
	brute_welder_tank_particle = {
		prefix = "brute_welder_tank_particle",
		to = 23,
		from = 1
	},
	brute_welder_tank_projectile = {
		prefix = "brute_welder_tank_projectile",
		to = 1,
		from = 1
	},
	brute_welder_tower_hit_fx_idle = {
		prefix = "brute_welder_tower_hit_fx",
		to = 23,
		from = 1
	},
	brute_welder_tower_mod_loop = {
		prefix = "brute_welder_tower_mod",
		to = 14,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/brute_welder.lua

-- BEGIN kr3/data/animations/burning_treant.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/burning_treant.lua

local a = {
	burning_treant_idle = {
		prefix = "burning_treant",
		to = 24,
		from = 1
	},
	burning_treant_walk = {
		prefix = "burning_treant",
		to = 48,
		from = 25
	},
	burning_treant_walk_front = {
		prefix = "burning_treant",
		to = 72,
		from = 49
	},
	burning_treant_walk_back = {
		prefix = "burning_treant",
		to = 96,
		from = 73
	},
	burning_treant_melee = {
		prefix = "burning_treant",
		to = 137,
		from = 97
	},
	burning_treant_area_attack = {
		prefix = "burning_treant",
		to = 210,
		from = 138
	},
	burning_treant_death = {
		prefix = "burning_treant",
		to = 262,
		from = 211
	},
	burning_treant_area_attk_in = {
		prefix = "burning_treant_area_attk",
		to = 4,
		from = 1
	},
	burning_treant_area_attk_idle = {
		prefix = "burning_treant_area_attk",
		to = 18,
		from = 5
	},
	burning_treant_area_attk_out = {
		prefix = "burning_treant_area_attk",
		to = 32,
		from = 19
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/burning_treant.lua

-- BEGIN kr3/data/animations/common_clone.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/common_clone.lua

local a = {
	common_clone_creep_idle = {
		prefix = "common_clone_creep",
		to = 1,
		from = 1
	},
	common_clone_creep_walk = {
		prefix = "common_clone_creep",
		to = 21,
		from = 2
	},
	common_clone_creep_walk_front = {
		prefix = "common_clone_creep",
		to = 41,
		from = 22
	},
	common_clone_creep_walk_back = {
		prefix = "common_clone_creep",
		to = 61,
		from = 42
	},
	common_clone_creep_attack = {
		prefix = "common_clone_creep",
		to = 87,
		from = 62
	},
	common_clone_creep_death = {
		prefix = "common_clone_creep",
		to = 101,
		from = 88
	},
	common_clone_creep_boss_fall = {
		prefix = "common_clone_creep",
		to = 115,
		from = 102
	},
	common_clone_hit_fx_idle = {
		prefix = "common_clone_hit_fx",
		to = 6,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/common_clone.lua

-- BEGIN kr3/data/animations/corrupted_elf.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/corrupted_elf.lua

local a = {
	corrupted_ranger_creep_idle = {
		prefix = "corrupted_ranger_creep",
		to = 1,
		from = 1
	},
	corrupted_ranger_creep_walk = {
		prefix = "corrupted_ranger_creep",
		to = 23,
		from = 2
	},
	corrupted_ranger_creep_walk_front = {
		prefix = "corrupted_ranger_creep",
		to = 43,
		from = 24
	},
	corrupted_ranger_creep_walk_back = {
		prefix = "corrupted_ranger_creep",
		to = 63,
		from = 44
	},
	corrupted_ranger_creep_attack_1 = {
		prefix = "corrupted_ranger_creep",
		to = 91,
		from = 64
	},
	corrupted_ranger_creep_attack_2_in = {
		prefix = "corrupted_ranger_creep",
		to = 100,
		from = 92
	},
	corrupted_ranger_creep_attack_2 = {
		prefix = "corrupted_ranger_creep",
		to = 120,
		from = 101
	},
	corrupted_ranger_creep_attack_2_out = {
		prefix = "corrupted_ranger_creep",
		to = 130,
		from = 121
	},
	corrupted_ranger_creep_death = {
		prefix = "corrupted_ranger_creep",
		to = 152,
		from = 131
	},
	corrupted_ranger_arrow_miss = {
		prefix = "corrupted_ranger_arrow_miss",
		to = 1,
		from = 1
	},
	corrupted_ranger_arrow = {
		prefix = "corrupted_ranger_arrow",
		to = 1,
		from = 1
	},
	corrupted_ranger_arrow_particle = {
		prefix = "corrupted_ranger_arrow_particle",
		to = 13,
		from = 1
	},
	corrupted_ranger_creep_attack_1_in = {
		prefix = "corrupted_ranger_creep",
		to = 64,
		from = 64
	},
	corrupted_ranger_creep_attack_1_out = {
		prefix = "corrupted_ranger_creep",
		to = 92,
		from = 92
	},
	corrupted_ranger_creep_idle = {
		prefix = "corrupted_ranger_creep",
		to = 101,
		from = 101
	},
	corrupted_ranger_creep_idle2 = {
		prefix = "corrupted_ranger_creep",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/corrupted_elf.lua

-- BEGIN kr3/data/animations/corrupted_stalker.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/corrupted_stalker.lua

local a = {
	corrupted_stalker_creep_idle = {
		prefix = "corrupted_stalker_creep",
		to = 32,
		from = 1
	},
	corrupted_stalker_creep_walk = {
		prefix = "corrupted_stalker_creep",
		to = 64,
		from = 33
	},
	corrupted_stalker_creep_walk_front = {
		prefix = "corrupted_stalker_creep",
		to = 96,
		from = 65
	},
	corrupted_stalker_creep_walk_back = {
		prefix = "corrupted_stalker_creep",
		to = 128,
		from = 97
	},
	corrupted_stalker_creep_death = {
		prefix = "corrupted_stalker_creep",
		to = 143,
		from = 129
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/corrupted_stalker.lua

-- BEGIN kr3/data/animations/crystal_golem.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/crystal_golem.lua

local a = {
	crystal_golem_creep_idle = {
		prefix = "crystal_golem_creep",
		to = 12,
		from = 1
	},
	crystal_golem_creep_walkingRightLeft = {
		prefix = "crystal_golem_creep",
		to = 44,
		from = 13
	},
	crystal_golem_creep_walkingDown = {
		prefix = "crystal_golem_creep",
		to = 76,
		from = 45
	},
	crystal_golem_creep_walkingUp = {
		prefix = "crystal_golem_creep",
		to = 108,
		from = 77
	},
	crystal_golem_creep_attack = {
		prefix = "crystal_golem_creep",
		to = 143,
		from = 109
	},
	crystal_golem_creep_death = {
		prefix = "crystal_golem_creep",
		to = 191,
		from = 144
	},
	crystal_golem_creep_holder = {
		prefix = "crystal_golem_creep",
		to = 192,
		from = 192
	},
	crystal_golem_creep_holder_spawn = {
		prefix = "crystal_golem_creep",
		to = 291,
		from = 193
	},
	crystal_golem_decal_idle = {
		prefix = "crystal_golem_decal",
		to = 31,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/crystal_golem.lua

-- BEGIN kr3/data/animations/dark_army_soldier_knight.lua
do
	local __chunk = (function()
return {
    darkarmy_soldier_lvl4_layer1_idle = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 1,
		from = 1
	},
    darkarmy_soldier_lvl4_layer2_idle = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 1,
		from = 1
	},
    darkarmy_soldier_lvl4_layer3_idle = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 1,
		from = 1
	},
    darkarmy_soldier_lvl4_layer1_walk = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 22,
		from = 2
	},
    darkarmy_soldier_lvl4_layer2_walk = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 22,
		from = 2
	},
    darkarmy_soldier_lvl4_layer3_walk = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 22,
		from = 2
	},
    darkarmy_soldier_lvl4_layer1_attack = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 42,
		from = 23
	},
    darkarmy_soldier_lvl4_layer2_attack = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 42,
		from = 23
	},
    darkarmy_soldier_lvl4_layer3_attack = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 42,
		from = 23
	},
    darkarmy_soldier_lvl4_layer1_death = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 60,
		from = 43
	},
    darkarmy_soldier_lvl4_layer2_death = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 60,
		from = 43
	},
    darkarmy_soldier_lvl4_layer3_death = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 60,
		from = 43
	},
    darkarmy_soldier_lvl4_layer1_imperviousIntro = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 113,
		from = 61
	},
    darkarmy_soldier_lvl4_layer2_imperviousIntro = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 113,
		from = 61
	},
    darkarmy_soldier_lvl4_layer3_imperviousIntro = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 113,
		from = 61
	},
    darkarmy_soldier_lvl4_layer1_imperviousStop = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 114,
		from = 114
	},
    darkarmy_soldier_lvl4_layer2_imperviousStop = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 114,
		from = 114
	},
    darkarmy_soldier_lvl4_layer3_imperviousStop = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 114,
		from = 114
	},
    darkarmy_soldier_lvl4_layer1_imperviousOut = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 132,
		from = 115
	},
    darkarmy_soldier_lvl4_layer2_imperviousOut = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 132,
		from = 115
	},
    darkarmy_soldier_lvl4_layer3_imperviousOut = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 132,
		from = 115
	},
    darkarmy_soldier_lvl4_layer1_merciless = {
		prefix = "darkarmy_soldier_lvl4_layer1",
		to = 195,
		from = 133
	},
    darkarmy_soldier_lvl4_layer2_merciless = {
		prefix = "darkarmy_soldier_lvl4_layer2",
		to = 195,
		from = 133
	},
    darkarmy_soldier_lvl4_layer3_merciless = {
		prefix = "darkarmy_soldier_lvl4_layer3",
		to = 195,
		from = 133
	},
    dark_army_soldier_knight_lvl3_idle = {
        prefix = "darkarmy_soldier_lvl3",
		to = 1,
		from = 1
    },
    dark_army_soldier_knight_lvl3_walk = {
        prefix = "darkarmy_soldier_lvl3",
		to = 8,
		from = 2
    },
    dark_army_soldier_knight_lvl3_attack = {
        prefix = "darkarmy_soldier_lvl3",
		to = 25,
		from = 9
    },
    dark_army_soldier_knight_lvl3_death = {
        prefix = "darkarmy_soldier_lvl3",
		to = 38,
		from = 26
    },
    dark_army_soldier_knight_lvl2_idle = {
        prefix = "darkarmy_soldier_lvl2",
		to = 1,
		from = 1
    },
    dark_army_soldier_knight_lvl2_walk = {
        prefix = "darkarmy_soldier_lvl2",
		to = 7,
		from = 2
    },
    dark_army_soldier_knight_lvl2_attack = {
        prefix = "darkarmy_soldier_lvl2",
		to = 24,
		from = 8
    },
    dark_army_soldier_knight_lvl2_death = {
        prefix = "darkarmy_soldier_lvl2",
		to = 35,
		from = 25
    },
    dark_army_soldier_knight_lvl1_idle = {
        prefix = "darkarmy_soldier_lvl1",
		to = 1,
		from = 1
    },
    dark_army_soldier_knight_lvl1_walk = {
        prefix = "darkarmy_soldier_lvl1",
		to = 7,
		from = 2
    },
    dark_army_soldier_knight_lvl1_attack = {
        prefix = "darkarmy_soldier_lvl1",
		to = 24,
		from = 8
    },
    dark_army_soldier_knight_lvl1_death = {
        prefix = "darkarmy_soldier_lvl1",
		to = 35,
		from = 25
    }
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/dark_army_soldier_knight.lua

-- BEGIN kr3/data/animations/darksteel_anvil.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_anvil.lua

local a = {
	darksteel_anvil_creep_idle = {
		prefix = "darksteel_anvil_creep",
		to = 1,
		from = 1
	},
	darksteel_anvil_creep_walk = {
		prefix = "darksteel_anvil_creep",
		to = 27,
		from = 2
	},
	darksteel_anvil_creep_walk_front = {
		prefix = "darksteel_anvil_creep",
		to = 53,
		from = 28
	},
	darksteel_anvil_creep_walk_back = {
		prefix = "darksteel_anvil_creep",
		to = 79,
		from = 54
	},
	darksteel_anvil_creep_attack = {
		prefix = "darksteel_anvil_creep",
		to = 119,
		from = 80
	},
	darksteel_anvil_creep_attack_2 = {
		prefix = "darksteel_anvil_creep",
		to = 151,
		from = 120
	},
	darksteel_anvil_creep_skill_in = {
		prefix = "darksteel_anvil_creep",
		to = 182,
		from = 152
	},
	darksteel_anvil_creep_skill_loop = {
		prefix = "darksteel_anvil_creep",
		to = 204,
		from = 183
	},
	darksteel_anvil_creep_skill_out = {
		prefix = "darksteel_anvil_creep",
		to = 236,
		from = 205
	},
	darksteel_anvil_creep_death = {
		prefix = "darksteel_anvil_creep",
		to = 256,
		from = 237
	},
	darksteel_anvil_attack_projectile = {
		prefix = "darksteel_anvil_attack_projectile",
		to = 6,
		from = 1
	},
	darksteel_anvil_attack_hit_idle = {
		prefix = "darksteel_anvil_attack_hit",
		to = 6,
		from = 1
	},
	darksteel_anvil_skill_FX_loop = {
		prefix = "darksteel_anvil_skill_FX",
		to = 22,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_anvil.lua

-- BEGIN kr3/data/animations/darksteel_fist.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_fist.lua

local a = {
	darksteel_fist_stun_explosion = {
		prefix = "darksteel_fist_stun_explosion",
		to = 18,
		from = 1
	},
	darksteel_fist_stun_stones = {
		prefix = "darksteel_fist_stun_stones",
		to = 27,
		from = 1
	},
	darksteel_fist_stun_floor_decal = {
		prefix = "darksteel_fist_stun_floor_decal",
		to = 1,
		from = 1
	},
	darksteel_fist_creep_idle = {
		prefix = "darksteel_fist_creep",
		to = 1,
		from = 1
	},
	darksteel_fist_creep_walk = {
		prefix = "darksteel_fist_creep",
		to = 21,
		from = 2
	},
	darksteel_fist_creep_walk_front = {
		prefix = "darksteel_fist_creep",
		to = 41,
		from = 22
	},
	darksteel_fist_creep_walk_back = {
		prefix = "darksteel_fist_creep",
		to = 61,
		from = 42
	},
	darksteel_fist_creep_attack_in = {
		prefix = "darksteel_fist_creep",
		to = 66,
		from = 62
	},
	darksteel_fist_creep_attack = {
		prefix = "darksteel_fist_creep",
		to = 83,
		from = 67
	},
	darksteel_fist_creep_attck_out = {
		prefix = "darksteel_fist_creep",
		to = 90,
		from = 84
	},
	darksteel_fist_creep_death = {
		prefix = "darksteel_fist_creep",
		to = 133,
		from = 91
	},
	darksteel_fist_creep_stun = {
		prefix = "darksteel_fist_creep",
		to = 171,
		from = 134
	},
	darksteel_fist_hit_fx_idle = {
		prefix = "darksteel_fist_hit_fx",
		to = 7,
		from = 1
	},
	darksteel_fist_decal_stun = {
		prefix = "darksteel_fist_decal_stun",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_fist.lua

-- BEGIN kr3/data/animations/darksteel_guardian.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_guardian.lua

local a = {
	darksteel_guardian_stage_rock_idle = {
		prefix = "darksteel_guardian_stage_rock",
		to = 1,
		from = 1
	},
	darksteel_guardian_stage_rock_hit_1 = {
		prefix = "darksteel_guardian_stage_rock",
		to = 19,
		from = 2
	},
	darksteel_guardian_stage_rock_hit_2 = {
		prefix = "darksteel_guardian_stage_rock",
		to = 36,
		from = 20
	},
	darksteel_guardian_attack_2_hit_idle = {
		prefix = "darksteel_guardian_attack_2_hit",
		to = 12,
		from = 1
	},
	darksteel_guardian_attack_1_hit_idle = {
		prefix = "darksteel_guardian_attack_1_hit",
		to = 9,
		from = 1
	},
	darksteel_guardian_dwatf_particle_idle = {
		prefix = "darksteel_guardian_dwatf_particle",
		to = 8,
		from = 1
	},
	darksteel_guardian_dwarf_projectile = {
		prefix = "darksteel_guardian_dwarf_projectile",
		to = 1,
		from = 1
	},
	darksteel_guardian_creep_idle_1 = {
		prefix = "darksteel_guardian_creep",
		to = 1,
		from = 1
	},
	darksteel_guardian_creep_wake_up = {
		prefix = "darksteel_guardian_creep",
		to = 61,
		from = 2
	},
	darksteel_guardian_creep_idle_2 = {
		prefix = "darksteel_guardian_creep",
		to = 62,
		from = 62
	},
	darksteel_guardian_creep_walk_1 = {
		prefix = "darksteel_guardian_creep",
		to = 94,
		from = 63
	},
	darksteel_guardian_creep_walk_front_1 = {
		prefix = "darksteel_guardian_creep",
		to = 126,
		from = 95
	},
	darksteel_guardian_creep_attack = {
		prefix = "darksteel_guardian_creep",
		to = 174,
		from = 127
	},
	darksteel_guardian_creep_hammer_out = {
		prefix = "darksteel_guardian_creep",
		to = 208,
		from = 175
	},
	darksteel_guardian_creep_idle_3 = {
		prefix = "darksteel_guardian_creep",
		to = 228,
		from = 209
	},
	darksteel_guardian_creep_walk_2 = {
		prefix = "darksteel_guardian_creep",
		to = 260,
		from = 229
	},
	darksteel_guardian_creep_walk_front_2 = {
		prefix = "darksteel_guardian_creep",
		to = 292,
		from = 261
	},
	darksteel_guardian_creep_attack_2 = {
		prefix = "darksteel_guardian_creep",
		to = 336,
		from = 293
	},
	darksteel_guardian_creep_death = {
		prefix = "darksteel_guardian_creep",
		to = 390,
		from = 337
	},
	darksteel_guardian_creep_grave_loop = {
		prefix = "darksteel_guardian_creep",
		to = 414,
		from = 391
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_guardian.lua

-- BEGIN kr3/data/animations/darksteel_hammerer.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_hammerer.lua

local a = {
	darksteel_hammerer_creep_idle = {
		prefix = "darksteel_hammerer_creep",
		to = 1,
		from = 1
	},
	darksteel_hammerer_creep_walk = {
		prefix = "darksteel_hammerer_creep",
		to = 21,
		from = 2
	},
	darksteel_hammerer_creep_walk_front = {
		prefix = "darksteel_hammerer_creep",
		to = 41,
		from = 22
	},
	darksteel_hammerer_creep_walk_back = {
		prefix = "darksteel_hammerer_creep",
		to = 61,
		from = 42
	},
	darksteel_hammerer_creep_attack = {
		prefix = "darksteel_hammerer_creep",
		to = 97,
		from = 62
	},
	darksteel_hammerer_creep_death = {
		prefix = "darksteel_hammerer_creep",
		to = 117,
		from = 98
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_hammerer.lua

-- BEGIN kr3/data/animations/darksteel_hulk.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_hulk.lua

local a = {
	darksteel_hulk_creep_idle = {
		prefix = "darksteel_hulk_creep",
		to = 1,
		from = 1
	},
	darksteel_hulk_creep_walk = {
		prefix = "darksteel_hulk_creep",
		to = 33,
		from = 2
	},
	darksteel_hulk_creep_walk_front = {
		prefix = "darksteel_hulk_creep",
		to = 65,
		from = 34
	},
	darksteel_hulk_creep_walk_back = {
		prefix = "darksteel_hulk_creep",
		to = 97,
		from = 66
	},
	darksteel_hulk_creep_attack = {
		prefix = "darksteel_hulk_creep",
		to = 131,
		from = 98
	},
	darksteel_hulk_creep_charge_side = {
		prefix = "darksteel_hulk_creep",
		to = 141,
		from = 132
	},
	darksteel_hulk_creep_charge_front = {
		prefix = "darksteel_hulk_creep",
		to = 161,
		from = 142
	},
	darksteel_hulk_creep_charge_back = {
		prefix = "darksteel_hulk_creep",
		to = 181,
		from = 162
	},
	darksteel_hulk_creep_death = {
		prefix = "darksteel_hulk_creep",
		to = 214,
		from = 182
	},
	darksteel_hulk_attack_hit_idle = {
		prefix = "darksteel_hulk_hit",
		to = 7,
		from = 1
	},
	darksteel_hulk_run_particle_a = {
		prefix = "darksteel_hulk_run_particle_1",
		to = 14,
		from = 1
	},
	darksteel_hulk_run_particle_b = {
		prefix = "darksteel_hulk_run_particle_2",
		to = 35,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_hulk.lua

-- BEGIN kr3/data/animations/darksteel_shielder.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/darksteel_shielder.lua

local a = {
	darksteel_shielder_creep_idle = {
		prefix = "darksteel_shielder_creep",
		to = 1,
		from = 1
	},
	darksteel_shielder_creep_walk = {
		prefix = "darksteel_shielder_creep",
		to = 27,
		from = 2
	},
	darksteel_shielder_creep_walk_front = {
		prefix = "darksteel_shielder_creep",
		to = 53,
		from = 28
	},
	darksteel_shielder_creep_walk_back = {
		prefix = "darksteel_shielder_creep",
		to = 79,
		from = 54
	},
	darksteel_shielder_creep_attack = {
		prefix = "darksteel_shielder_creep",
		to = 109,
		from = 80
	},
	darksteel_shielder_creep_death = {
		prefix = "darksteel_shielder_creep",
		to = 156,
		from = 110
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/darksteel_shielder.lua

-- BEGIN kr3/data/animations/deathwood.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/deathwood.lua

local a = {
	deathwood_spirit_ball_idle = {
		prefix = "deathwood_spirit_ball",
		to = 16,
		from = 1
	},
	deathwood_spirit_ball_hit = {
		prefix = "deathwood_spirit_ball",
		to = 32,
		from = 17
	},
	deathwood_ball_fx_run = {
		prefix = "deathwood_ball_fx",
		to = 12,
		from = 1
	},
	deathwood_fx_idle = {
		prefix = "deathwood_fx",
		to = 6,
		from = 1
	},
	deathwood_creep_idle = {
		prefix = "deathwood_creep",
		to = 40,
		from = 1
	},
	deathwood_creep_walk = {
		prefix = "deathwood_creep",
		to = 64,
		from = 41
	},
	deathwood_creep_walk_front = {
		prefix = "deathwood_creep",
		to = 88,
		from = 65
	},
	deathwood_creep_walk_back = {
		prefix = "deathwood_creep",
		to = 112,
		from = 89
	},
	deathwood_creep_melee = {
		prefix = "deathwood_creep",
		to = 153,
		from = 113
	},
	deathwood_creep_throw_attack = {
		prefix = "deathwood_creep",
		to = 194,
		from = 154
	},
	deathwood_creep_death = {
		prefix = "deathwood_creep",
		to = 246,
		from = 195
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/deathwood.lua

-- BEGIN kr3/data/animations/deformed_grymbeard_clone.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/deformed_grymbeard_clone.lua

local a = {
	clone_boss_creep_idle = {
		prefix = "clone_boss_creep",
		to = 16,
		from = 1
	},
	clone_boss_creep_walk = {
		prefix = "clone_boss_creep",
		to = 32,
		from = 17
	},
	clone_boss_creep_walk_front = {
		prefix = "clone_boss_creep",
		to = 48,
		from = 33
	},
	clone_boss_creep_death = {
		prefix = "clone_boss_creep",
		to = 67,
		from = 49
	},
	clone_boss_shield_idle = {
		prefix = "clone_boss_shield",
		to = 16,
		from = 1
	},
	clone_boss_shield_out = {
		prefix = "clone_boss_shield",
		to = 32,
		from = 17
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/deformed_grymbeard_clone.lua

-- BEGIN kr3/data/animations/doom_slayer.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/doom_slayer.lua

local a = {
	doom_bringer_stun_explotion_run = {
		prefix = "doom_bringer_stun_explotion",
		to = 34,
		from = 1
	},
	doom_bringer_tower_stun_tower_block_loop = {
		prefix = "doom_bringer_tower_stun",
		to = 46,
		from = 1
	},
	doom_bringer_creep_idle = {
		prefix = "doom_bringer_creep",
		to = 20,
		from = 1
	},
	doom_bringer_creep_raise = {
		prefix = "doom_bringer_creep",
		to = 1,
		from = 1
	},
	doom_bringer_creep_walk = {
		prefix = "doom_bringer_creep",
		to = 48,
		from = 21
	},
	doom_bringer_creep_walk_down = {
		prefix = "doom_bringer_creep",
		to = 76,
		from = 49
	},
	doom_bringer_creep_walk_up = {
		prefix = "doom_bringer_creep",
		to = 104,
		from = 77
	},
	doom_bringer_creep_melee = {
		prefix = "doom_bringer_creep",
		to = 142,
		from = 105
	},
	doom_bringer_creep_skill_1 = {
		prefix = "doom_bringer_creep",
		to = 198,
		from = 143
	},
	doom_bringer_creep_death = {
		prefix = "doom_bringer_creep",
		to = 266,
		from = 199
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/doom_slayer.lua

-- BEGIN kr3/data/animations/dust_cryptid.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/dust_cryptid.lua

local a = {
	dust_cryptid_dust_fx_loop = {
		prefix = "dust_cryptid_dust_fx",
		to = 42,
		from = 1
	},
	dust_cryptid_creep_idle = {
		prefix = "dust_cryptid_creep",
		to = 14,
		from = 1
	},
	dust_cryptid_creep_walk = {
		prefix = "dust_cryptid_creep",
		to = 28,
		from = 15
	},
	dust_cryptid_creep_walk_front = {
		prefix = "dust_cryptid_creep",
		to = 42,
		from = 29
	},
	dust_cryptid_creep_walk_back = {
		prefix = "dust_cryptid_creep",
		to = 56,
		from = 43
	},
	dust_cryptid_creep_death = {
		prefix = "dust_cryptid_creep",
		to = 78,
		from = 57
	},
	dust_cryptid_modifier_idle = {
		prefix = "dust_cryptid_modifier",
		to = 22,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/dust_cryptid.lua

-- BEGIN kr3/data/animations/enemy_balooning_spider.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_balooning_spider.lua

local a = {
	balooning_spider_exo_creep_air_walk = {
		prefix = "balooning_spider_exo_creep",
		to = 32,
		from = 1
	},
	balooning_spider_exo_creep_death = {
		prefix = "balooning_spider_exo_creep",
		to = 46,
		from = 33
	},
	balooning_spider_exo_creep_air_death = {
		prefix = "balooning_spider_exo_creep",
		to = 60,
		from = 47
	},
	balooning_spider_exo_creep_air_walk_down = {
		prefix = "balooning_spider_exo_creep",
		to = 92,
		from = 61
	},
	balooning_spider_exo_creep_air_walk_up = {
		prefix = "balooning_spider_exo_creep",
		to = 124,
		from = 93
	},
	balooning_spider_exo_creep_walk = {
		prefix = "balooning_spider_exo_creep",
		to = 134,
		from = 125
	},
	balooning_spider_exo_creep_walk_down = {
		prefix = "balooning_spider_exo_creep",
		to = 144,
		from = 135
	},
	balooning_spider_exo_creep_walk_up = {
		prefix = "balooning_spider_exo_creep",
		to = 154,
		from = 145
	},
	balooning_spider_exo_creep_takeoff = {
		prefix = "balooning_spider_exo_creep",
		to = 168,
		from = 155
	},
	balooning_spider_exo_creep_takeoff_up = {
		prefix = "balooning_spider_exo_creep",
		to = 182,
		from = 169
	},
	balooning_spider_exo_creep_takeoff_down = {
		prefix = "balooning_spider_exo_creep",
		to = 196,
		from = 183
	},
	balooning_spider_exo_creep_idle = {
		prefix = "balooning_spider_exo_creep",
		to = 125,
		from = 125
	},
	balooning_spider_exo_creep_air_idle = {
		prefix = "balooning_spider_exo_creep",
		to = 32,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_balooning_spider.lua

-- BEGIN kr3/data/animations/enemy_basic_croc.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_basic_croc.lua

local a = {
	gator_creep_idle = {
		prefix = "gator_creep",
		to = 1,
		from = 1
	},
	gator_creep_walk = {
		prefix = "gator_creep",
		to = 25,
		from = 2
	},
	gator_creep_walk_front = {
		prefix = "gator_creep",
		to = 49,
		from = 26
	},
	gator_creep_walk_back = {
		prefix = "gator_creep",
		to = 73,
		from = 50
	},
	gator_creep_attack = {
		prefix = "gator_creep",
		to = 97,
		from = 74
	},
	gator_creep_death = {
		prefix = "gator_creep",
		to = 131,
		from = 98
	},
	gator_creep_transform = {
		prefix = "gator_creep",
		to = 194,
		from = 132
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_basic_croc.lua

-- BEGIN kr3/data/animations/enemy_citizen.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/enemy_citizen.lua

local a = {
	stage33_pueblerino1_raise = {
		prefix = "stage33_pueblerino1_creep",
		to = 1,
		from = 1
	},
	stage33_pueblerino1_idle = {
		prefix = "stage33_pueblerino1_creep",
		to = 1,
		from = 1
	},
	stage33_pueblerino1_walk = {
		prefix = "stage33_pueblerino1_creep",
		to = 21,
		from = 2
	},
	stage33_pueblerino1_walkDown = {
		prefix = "stage33_pueblerino1_creep",
		to = 41,
		from = 22
	},
	stage33_pueblerino1_walkUp = {
		prefix = "stage33_pueblerino1_creep",
		to = 61,
		from = 42
	},
	stage33_pueblerino1_attack = {
		prefix = "stage33_pueblerino1_creep",
		to = 85,
		from = 62
	},
	stage33_pueblerino1_death = {
		prefix = "stage33_pueblerino1_creep",
		to = 115,
		from = 86
	},
	stage33_pueblerino2_raise = {
		prefix = "pueblerino2",
		to = 1,
		from = 1
	},
	stage33_pueblerino2_idle = {
		prefix = "pueblerino2",
		to = 1,
		from = 1
	},
	stage33_pueblerino2_walk = {
		prefix = "pueblerino2",
		to = 25,
		from = 2
	},
	stage33_pueblerino2_walkDown = {
		prefix = "pueblerino2",
		to = 49,
		from = 26
	},
	stage33_pueblerino2_walkUp = {
		prefix = "pueblerino2",
		to = 73,
		from = 50
	},
	stage33_pueblerino2_attack = {
		prefix = "pueblerino2",
		to = 105,
		from = 74
	},
	stage33_pueblerino2_death = {
		prefix = "pueblerino2",
		to = 139,
		from = 106
	},
	pueblerino_3_hit_1_run = {
		prefix = "pueblerino_3_hit_1",
		to = 20,
		from = 1
	},
	pueblerino_3_creep_raise = {
		prefix = "pueblerino_3_creep",
		to = 1,
		from = 1
	},
	pueblerino_3_creep_idle = {
		prefix = "pueblerino_3_creep",
		to = 16,
		from = 1
	},
	pueblerino_3_creep_walk = {
		prefix = "pueblerino_3_creep",
		to = 36,
		from = 17
	},
	pueblerino_3_creep_walk_down = {
		prefix = "pueblerino_3_creep",
		to = 56,
		from = 37
	},
	pueblerino_3_creep_walk_up = {
		prefix = "pueblerino_3_creep",
		to = 76,
		from = 57
	},
	pueblerino_3_creep_atack_2 = {
		prefix = "pueblerino_3_creep",
		to = 120,
		from = 77
	},
	pueblerino_3_creep_death = {
		prefix = "pueblerino_3_creep",
		to = 146,
		from = 121
	},
	pueblerino_4_hit_1_run = {
		prefix = "pueblerino_4_hit_1",
		to = 22,
		from = 1
	},
	pueblerino_4_creep_raise = {
		prefix = "pueblerino_4_creep",
		to = 1,
		from = 1
	},
	pueblerino_4_creep_idle = {
		prefix = "pueblerino_4_creep",
		to = 16,
		from = 1
	},
	pueblerino_4_creep_walk = {
		prefix = "pueblerino_4_creep",
		to = 36,
		from = 17
	},
	pueblerino_4_creep_walk_down = {
		prefix = "pueblerino_4_creep",
		to = 56,
		from = 37
	},
	pueblerino_4_creep_walk_up = {
		prefix = "pueblerino_4_creep",
		to = 76,
		from = 57
	},
	pueblerino_4_creep_atack_1 = {
		prefix = "pueblerino_4_creep",
		to = 122,
		from = 77
	},
	pueblerino_4_creep_death = {
		prefix = "pueblerino_4_creep",
		to = 148,
		from = 123
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_citizen.lua

-- BEGIN kr3/data/animations/enemy_croc_boss.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_croc_boss.lua

local a = {
	crokinder_mom_creep_eat_tower_start = {
		prefix = "crokinder_mom_creep",
		to = 104,
		from = 98
	},
	crokinder_mom_creep_eat_tower_loop = {
		prefix = "crokinder_mom_creep",
		to = 110,
		from = 105
	},
	crokinder_mom_creep_eat_tower_end = {
		prefix = "crokinder_mom_creep",
		to = 123,
		from = 111
	},
	crokinder_mom_creep_rain_start = {
		prefix = "crokinder_mom_creep",
		to = 126,
		from = 124
	},
	crokinder_mom_creep_rain_loop = {
		prefix = "crokinder_mom_creep",
		to = 135,
		from = 127
	},
	crokinder_mom_creep_rain_end = {
		prefix = "crokinder_mom_creep",
		to = 144,
		from = 136
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_croc_boss.lua

-- BEGIN kr3/data/animations/enemy_croc_egg_carrier.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_croc_egg_carrier.lua

local a = {
	crokinder_carrier_trail_run = {
		prefix = "crokinder_carrier_trail",
		to = 10,
		from = 1
	},
	crokinder_carrier_attack_projectile_run = {
		prefix = "crokinder_carrier_attack_projectile",
		to = 16,
		from = 1
	},
	crokinder_mom_hit = {
		prefix = "crokinder_mom_hit",
		to = 13,
		from = 1
	},
	crokinder_mom_creep_idle = {
		prefix = "crokinder_mom_creep",
		to = 1,
		from = 1
	},
	crokinder_mom_creep_walk_side = {
		prefix = "crokinder_mom_creep",
		to = 33,
		from = 2
	},
	crokinder_mom_creep_walk_down = {
		prefix = "crokinder_mom_creep",
		to = 65,
		from = 34
	},
	crokinder_mom_creep_walk_up = {
		prefix = "crokinder_mom_creep",
		to = 97,
		from = 66
	},
	crokinder_mom_creep_attack = {
		prefix = "crokinder_mom_creep",
		to = 123,
		from = 98
	},
	crokinder_mom_creep_spawn = {
		prefix = "crokinder_mom_creep",
		to = 144,
		from = 124
	},
	crokinder_mom_creep_dead = {
		prefix = "crokinder_mom_creep",
		to = 185,
		from = 145
	},
	crokinder_mom_creep_death = {
		prefix = "crokinder_mom_creep",
		to = 185,
		from = 145
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_croc_egg_carrier.lua

-- BEGIN kr3/data/animations/enemy_croc_hydra.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_croc_hydra.lua

local a = {
	hydra_projectile_trail = {
		prefix = "hydra_trail",
		to = 10,
		from = 1
	},
	hydra_fx_hit = {
		prefix = "hydra_hit",
		to = 13,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_croc_hydra.lua

-- BEGIN kr3/data/animations/enemy_croc_shaman.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_croc_shaman.lua

local a = {
	shaman_buff = {
		prefix = "shaman_buff",
		to = 30,
		from = 1
	},
	shaman_bolt = {
		prefix = "shaman_bolt",
		to = 8,
		from = 1
	},
	shaman_bolt_2 = {
		prefix = "shaman_bolt_2",
		to = 8,
		from = 1
	},
	shaman_creep_idle = {
		prefix = "shaman_creep",
		to = 1,
		from = 1
	},
	shaman_creep_walk_side = {
		prefix = "shaman_creep",
		to = 27,
		from = 2
	},
	shaman_creep_walk_down = {
		prefix = "shaman_creep",
		to = 53,
		from = 28
	},
	shaman_creep_walk_up = {
		prefix = "shaman_creep",
		to = 79,
		from = 54
	},
	shaman_creep_attack_melee = {
		prefix = "shaman_creep",
		to = 104,
		from = 80
	},
	shaman_creep_attack_range = {
		prefix = "shaman_creep",
		to = 125,
		from = 105
	},
	shaman_creep_attack_block = {
		prefix = "shaman_creep",
		to = 161,
		from = 126
	},
	shaman_creep_heal = {
		prefix = "shaman_creep",
		to = 207,
		from = 162
	},
	shaman_creep_dead = {
		prefix = "shaman_creep",
		to = 263,
		from = 208
	},
	shaman_hit_run = {
		prefix = "shaman_hit",
		to = 10,
		from = 1
	},
	shaman_creep_death = {
		prefix = "shaman_creep",
		to = 263,
		from = 208
	},
	shaman_bolt_flying = {
		prefix = "shaman_bolt",
		to = 8,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_croc_shaman.lua

-- BEGIN kr3/data/animations/enemy_crokinder.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_crokinder.lua

local a = {
	crokinder_creep_idle = {
		prefix = "crokinder_creep",
		to = 1,
		from = 1
	},
	crokinder_creep_walk = {
		prefix = "crokinder_creep",
		to = 21,
		from = 2
	},
	crokinder_creep_walk_front = {
		prefix = "crokinder_creep",
		to = 41,
		from = 22
	},
	crokinder_creep_walk_back = {
		prefix = "crokinder_creep",
		to = 61,
		from = 42
	},
	crokinder_creep_death = {
		prefix = "crokinder_creep",
		to = 87,
		from = 62
	},
	crokinder_creep_transform = {
		prefix = "crokinder_creep",
		to = 138,
		from = 88
	},
	crokinder_creep_spawn = {
		prefix = "crokinder_creep",
		to = 158,
		from = 139
	},
	crokinder_creep_raise = {
		prefix = "crokinder_creep",
		to = 158,
		from = 139
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_crokinder.lua

-- BEGIN kr3/data/animations/enemy_cultbrood.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_cultbrood.lua

local a = {
	cultbrood_hit_run = {
		prefix = "cultbrood_hit",
		to = 15,
		from = 1
	},
	cultbrood_modifier_idle = {
		prefix = "cultbrood_modifier",
		to = 14,
		from = 1
	},
	cultbrood_unit_idle = {
		prefix = "cultbrood_unit",
		to = 1,
		from = 1
	},
	cultbrood_unit_walk = {
		prefix = "cultbrood_unit",
		to = 10,
		from = 2
	},
	cultbrood_unit_walk_front = {
		prefix = "cultbrood_unit",
		to = 19,
		from = 11
	},
	cultbrood_unit_walk_back = {
		prefix = "cultbrood_unit",
		to = 28,
		from = 20
	},
	cultbrood_unit_attack1 = {
		prefix = "cultbrood_unit",
		to = 60,
		from = 29
	},
	cultbrood_unit_attack2 = {
		prefix = "cultbrood_unit",
		to = 92,
		from = 61
	},
	cultbrood_unit_raise_in = {
		prefix = "cultbrood_unit",
		to = 115,
		from = 93
	},
	cultbrood_unit_raise = {
		prefix = "cultbrood_unit",
		to = 161,
		from = 116
	},
	cultbrood_unit_raise_out = {
		prefix = "cultbrood_unit",
		to = 184,
		from = 162
	},
	cultbrood_unit_death = {
		prefix = "cultbrood_unit",
		to = 214,
		from = 185
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_cultbrood.lua

-- BEGIN kr3/data/animations/enemy_demon_minotaur.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/enemy_demon_minotaur.lua

local a = {
	demon_minotaur_smoke_hit_run = {
		prefix = "demon_minotaur_smoke_hit",
		to = 7,
		from = 1
	},
	demon_minotaur_charge_dust_a = {
		prefix = "demon_minotaur_charge_dust_a",
		to = 14,
		from = 1
	},
	demon_minotaur_charge_dust_b = {
		prefix = "demon_minotaur_charge_dust_b",
		to = 20,
		from = 1
	},
	demon_minotaur_hit_run = {
		prefix = "demon_minotaur_hit",
		to = 10,
		from = 1
	},
	demon_minotaur_rebote_fx_run = {
		prefix = "demon_minotaur_rebote_fx",
		to = 39,
		from = 1
	},
	demon_minotaur_unit_idle = {
		prefix = "demon_minotaur_unit",
		to = 2,
		from = 1
	},
	demon_minotaur_unit_walk = {
		prefix = "demon_minotaur_unit",
		to = 34,
		from = 3
	},
	demon_minotaur_unit_walk_down = {
		prefix = "demon_minotaur_unit",
		to = 66,
		from = 35
	},
	demon_minotaur_unit_walk_up = {
		prefix = "demon_minotaur_unit",
		to = 98,
		from = 67
	},
	demon_minotaur_unit_mele_1 = {
		prefix = "demon_minotaur_unit",
		to = 156,
		from = 99
	},
	demon_minotaur_unit_melee_2 = {
		prefix = "demon_minotaur_unit",
		to = 216,
		from = 157
	},
	demon_minotaur_unit_charge = {
		prefix = "demon_minotaur_unit",
		to = 226,
		from = 217
	},
	demon_minotaur_unit_charge_down = {
		prefix = "demon_minotaur_unit",
		to = 246,
		from = 227
	},
	demon_minotaur_unit_charge_up = {
		prefix = "demon_minotaur_unit",
		to = 266,
		from = 247
	},
	demon_minotaur_unit_charge_attack_in = {
		prefix = "demon_minotaur_unit",
		to = 290,
		from = 267
	},
	demon_minotaur_unit_rebote = {
		prefix = "demon_minotaur_unit",
		to = 320,
		from = 291
	},
	demon_minotaur_unit_rebote_frente = {
		prefix = "demon_minotaur_unit",
		to = 348,
		from = 321
	},
	demon_minotaur_unit_death = {
		prefix = "demon_minotaur_unit",
		to = 386,
		from = 349
	},
	demon_minotaur_unit_charge_down_attack_in = {
		prefix = "demon_minotaur_unit",
		to = 410,
		from = 387
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_demon_minotaur.lua

-- BEGIN kr3/data/animations/enemy_drainbrood.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_drainbrood.lua

local a = {
	drainblood_cucoon_in = {
		prefix = "drainblood_cucoon",
		to = 19,
		from = 1
	},
	drainblood_cucoon_idle = {
		prefix = "drainblood_cucoon",
		to = 23,
		from = 20
	},
	drainblood_cucoon_death = {
		prefix = "drainblood_cucoon",
		to = 47,
		from = 24
	},
	drainblood_enemy_idle = {
		prefix = "drainblood_enemy",
		to = 1,
		from = 1
	},
	drainblood_enemy_walk = {
		prefix = "drainblood_enemy",
		to = 23,
		from = 2
	},
	drainblood_enemy_walk_front = {
		prefix = "drainblood_enemy",
		to = 43,
		from = 24
	},
	drainblood_enemy_walk_back = {
		prefix = "drainblood_enemy",
		to = 63,
		from = 44
	},
	drainblood_enemy_attack = {
		prefix = "drainblood_enemy",
		to = 93,
		from = 64
	},
	drainblood_enemy_attack_spit = {
		prefix = "drainblood_enemy",
		to = 149,
		from = 94
	},
	drainblood_enemy_death = {
		prefix = "drainblood_enemy",
		to = 170,
		from = 150
	},
	spider_web_enemy_idle = {
		prefix = "spider_web_enemy",
		to = 1,
		from = 1
	},
	spider_web_enemy_walk = {
		prefix = "spider_web_enemy",
		to = 23,
		from = 2
	},
	spider_web_enemy_walk_front = {
		prefix = "spider_web_enemy",
		to = 43,
		from = 24
	},
	spider_web_enemy_walk_back = {
		prefix = "spider_web_enemy",
		to = 63,
		from = 44
	},
	spider_web_enemy_attack = {
		prefix = "spider_web_enemy",
		to = 93,
		from = 64
	},
	spider_web_enemy_death = {
		prefix = "spider_web_enemy",
		to = 108,
		from = 94
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_drainbrood.lua

-- BEGIN kr3/data/animations/enemy_flying_croc.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_flying_croc.lua

local a = {
	winged_crock_creep_walk = {
		prefix = "winged_crock_creep",
		to = 16,
		from = 1
	},
	winged_crock_creep_walk_front = {
		prefix = "winged_crock_creep",
		to = 32,
		from = 17
	},
	winged_crock_creep_walk_back = {
		prefix = "winged_crock_creep",
		to = 48,
		from = 33
	},
	winged_crock_creep_death = {
		prefix = "winged_crock_creep",
		to = 64,
		from = 49
	},
	winged_crock_creep_idle = {
		prefix = "winged_crock_creep",
		to = 16,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_flying_croc.lua

-- BEGIN kr3/data/animations/enemy_glarebrood_crystal.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_glarebrood_crystal.lua

local a = {
	glarebrood_crystal_enemy_in = {
		prefix = "glarebrood_crystal_enemy",
		to = 16,
		from = 1
	},
	glarebrood_crystal_enemy_idle = {
		prefix = "glarebrood_crystal_enemy",
		to = 50,
		from = 17
	},
	glarebrood_crystal_enemy_glarebrood_in = {
		prefix = "glarebrood_crystal_enemy",
		to = 67,
		from = 51
	},
	glarebrood_crystal_enemy_degradacion_1 = {
		prefix = "glarebrood_crystal_enemy",
		to = 101,
		from = 68
	},
	glarebrood_crystal_enemy_degradacion_2 = {
		prefix = "glarebrood_crystal_enemy",
		to = 135,
		from = 102
	},
	glarebrood_crystal_enemy_death = {
		prefix = "glarebrood_crystal_enemy",
		to = 164,
		from = 136
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_glarebrood_crystal.lua

-- BEGIN kr3/data/animations/enemy_glarenwarden.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_glarenwarden.lua

local a = {
	glarenwarden_creep_glarenwarden_idle_side = {
		prefix = "glarenwarden_creep",
		to = 1,
		from = 1
	},
	glarenwarden_creep_walk = {
		prefix = "glarenwarden_creep",
		to = 25,
		from = 2
	},
	glarenwarden_creep_walk_down = {
		prefix = "glarenwarden_creep",
		to = 49,
		from = 26
	},
	glarenwarden_creep_walk_up = {
		prefix = "glarenwarden_creep",
		to = 73,
		from = 50
	},
	glarenwarden_creep_attack = {
		prefix = "glarenwarden_creep",
		to = 111,
		from = 74
	},
	glarenwarden_creep_death = {
		prefix = "glarenwarden_creep",
		to = 157,
		from = 112
	},
	glarenwarden_creep_descending_loop = {
		prefix = "glarenwarden_creep",
		to = 167,
		from = 158
	},
	glarenwarden_creep_descending_out = {
		prefix = "glarenwarden_creep",
		to = 181,
		from = 168
	},
	glarenwarden_creep_hidden_idle = {
		prefix = "glarenwarden_creep",
		to = 182,
		from = 182
	},
	glarenwarden_creep_hidden_out = {
		prefix = "glarenwarden_creep",
		to = 263,
		from = 183
	},
	glarenwarden_hole = {
		prefix = "glarenwarden_hole",
		to = 1,
		from = 1
	},
	glarewarden_web_spiderweb_idle1 = {
		prefix = "glarewarden_web_spiderweb",
		to = 1,
		from = 1
	},
	glarewarden_web_spiderweb_idle2 = {
		prefix = "glarewarden_web_spiderweb",
		to = 2,
		from = 2
	},
	glarewarden_web_spiderweb_idle3 = {
		prefix = "glarewarden_web_spiderweb",
		to = 3,
		from = 3
	},
	glarewarden_web_spiderweb_idle4 = {
		prefix = "glarewarden_web_spiderweb",
		to = 4,
		from = 4
	},
	glarewarden_web_spiderweb_dissolve = {
		prefix = "glarewarden_web_spiderweb",
		to = 14,
		from = 5
	},
	glarenwarden_creep_idle = {
		prefix = "glarenwarden_creep",
		to = 1,
		from = 1
	},
	glarenwarden_healing_run = {
		prefix = "glarenwarden_healing",
		to = 22,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_glarenwarden.lua

-- BEGIN kr3/data/animations/enemy_golden_eyed.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/enemy_golden_eyed.lua

local a = {
	goldeneye_beast_hit_run = {
		prefix = "goldeneye_beast_hit",
		to = 6,
		from = 1
	},
	goldeneye_beast_shadow_run = {
		prefix = "goldeneye_beast_shadow",
		to = 1,
		from = 1
	},
	goldeneye_beast_creep_idle = {
		prefix = "goldeneye_beast_creep",
		to = 28,
		from = 1
	},
	goldeneye_beast_creep_spawn_up = {
		prefix = "goldeneye_beast_creep",
		to = 30,
		from = 29
	},
	goldeneye_beast_creep_spawn_down = {
		prefix = "goldeneye_beast_creep",
		to = 32,
		from = 31
	},
	goldeneye_beast_creep_spawn_in = {
		prefix = "goldeneye_beast_creep",
		to = 38,
		from = 33
	},
	goldeneye_beast_creep_walk = {
		prefix = "goldeneye_beast_creep",
		to = 62,
		from = 39
	},
	goldeneye_beast_creep_walk_down = {
		prefix = "goldeneye_beast_creep",
		to = 86,
		from = 63
	},
	goldeneye_beast_creep_walk_up = {
		prefix = "goldeneye_beast_creep",
		to = 110,
		from = 87
	},
	goldeneye_beast_creep_attack = {
		prefix = "goldeneye_beast_creep",
		to = 162,
		from = 111
	},
	goldeneye_beast_creep_skill1 = {
		prefix = "goldeneye_beast_creep",
		to = 212,
		from = 163
	},
	goldeneye_beast_creep_death = {
		prefix = "goldeneye_beast_creep",
		to = 248,
		from = 213
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_golden_eyed.lua

-- BEGIN kr3/data/animations/enemy_killertile.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_killertile.lua

local a = {
	killertile_creep_idle = {
		prefix = "killertile_creep",
		to = 1,
		from = 1
	},
	killertile_creep_walk = {
		prefix = "killertile_creep",
		to = 33,
		from = 2
	},
	killertile_creep_walk_front = {
		prefix = "killertile_creep",
		to = 65,
		from = 34
	},
	killertile_creep_walk_back = {
		prefix = "killertile_creep",
		to = 97,
		from = 66
	},
	killertile_creep_attack = {
		prefix = "killertile_creep",
		to = 127,
		from = 98
	},
	killertile_creep_death = {
		prefix = "killertile_creep",
		to = 161,
		from = 128
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_killertile.lua

-- BEGIN kr3/data/animations/enemy_quickfeet_gator.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_quickfeet_gator.lua

local a = {
	quickfeet_gator_hit_projectile_run = {
		prefix = "quickfeet_gator_hit_projectile",
		to = 14,
		from = 1
	},
	quickfeet_gator_attack_projectile_bone_run = {
		prefix = "quickfeet_gator_attack_projectile_bone",
		to = 10,
		from = 1
	},
	quickfeet_gator_attack_projectile_run = {
		prefix = "quickfeet_gator_attack_projectile",
		to = 16,
		from = 1
	},
	quickfeet_gator_attack_hit_run = {
		prefix = "quickfeet_gator_attack_hit",
		to = 6,
		from = 1
	},
	quickfeet_gator_creep_idle = {
		prefix = "quickfeet_gator_creep",
		to = 1,
		from = 1
	},
	quickfeet_gator_creep_walk = {
		prefix = "quickfeet_gator_creep",
		to = 21,
		from = 2
	},
	quickfeet_gator_creep_walk_front = {
		prefix = "quickfeet_gator_creep",
		to = 41,
		from = 22
	},
	quickfeet_gator_creep_walk_back = {
		prefix = "quickfeet_gator_creep",
		to = 61,
		from = 42
	},
	quickfeet_gator_creep_attack = {
		prefix = "quickfeet_gator_creep",
		to = 89,
		from = 62
	},
	quickfeet_gator_creep_death = {
		prefix = "quickfeet_gator_creep",
		to = 123,
		from = 90
	},
	quickfeet_gator_creep_ability = {
		prefix = "quickfeet_gator_creep",
		to = 174,
		from = 124
	},
	quickfeet_gator_creep_idle_b = {
		prefix = "quickfeet_gator_creep",
		to = 175,
		from = 175
	},
	quickfeet_gator_creep_walk_b = {
		prefix = "quickfeet_gator_creep",
		to = 195,
		from = 176
	},
	quickfeet_gator_creep_walk_front_b = {
		prefix = "quickfeet_gator_creep",
		to = 215,
		from = 196
	},
	quickfeet_gator_creep_walk_back_b = {
		prefix = "quickfeet_gator_creep",
		to = 235,
		from = 216
	},
	quickfeet_gator_creep_attack_b = {
		prefix = "quickfeet_gator_creep",
		to = 270,
		from = 236
	},
	quickfeet_gator_creep_death_b = {
		prefix = "quickfeet_gator_creep",
		to = 302,
		from = 271
	},
	quickfeet_gator_creep_ability_b = {
		prefix = "quickfeet_gator_creep",
		to = 357,
		from = 303
	},
	quickfeet_gator_creep_no_chicken_idle = {
		prefix = "quickfeet_gator_creep",
		to = 175,
		from = 175
	},
	quickfeet_gator_creep_no_chicken_walk = {
		prefix = "quickfeet_gator_creep",
		to = 195,
		from = 176
	},
	quickfeet_gator_creep_no_chicken_walk_front = {
		prefix = "quickfeet_gator_creep",
		to = 215,
		from = 196
	},
	quickfeet_gator_creep_no_chicken_walk_back = {
		prefix = "quickfeet_gator_creep",
		to = 235,
		from = 216
	},
	quickfeet_gator_creep_no_chicken_attack = {
		prefix = "quickfeet_gator_creep",
		to = 270,
		from = 236
	},
	quickfeet_gator_creep_no_chicken_death = {
		prefix = "quickfeet_gator_creep",
		to = 302,
		from = 271
	},
	quickfeet_gator_creep_no_chicken_ability = {
		prefix = "quickfeet_gator_creep",
		to = 357,
		from = 303
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_quickfeet_gator.lua

-- BEGIN kr3/data/animations/enemy_ranged_croc.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_ranged_croc.lua

local a = {
	ranged_croc_proyectile = {
		prefix = "ranged_croc_proyectile",
		to = 1,
		from = 1
	},
	ranged_croc_hit = {
		prefix = "ranged_croc_hit",
		to = 15,
		from = 1
	},
	ranged_croc_creep_idle = {
		prefix = "ranged_croc_creep",
		to = 1,
		from = 1
	},
	ranged_croc_creep_walk = {
		prefix = "ranged_croc_creep",
		to = 9,
		from = 2
	},
	ranged_croc_creep_walk_front = {
		prefix = "ranged_croc_creep",
		to = 25,
		from = 10
	},
	ranged_croc_creep_walk_back = {
		prefix = "ranged_croc_creep",
		to = 41,
		from = 26
	},
	ranged_croc_creep_attack_01 = {
		prefix = "ranged_croc_creep",
		to = 63,
		from = 42
	},
	ranged_croc_creep_attack_02 = {
		prefix = "ranged_croc_creep",
		to = 83,
		from = 64
	},
	ranged_croc_creep_death = {
		prefix = "ranged_croc_creep",
		to = 119,
		from = 84
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_ranged_croc.lua

-- BEGIN kr3/data/animations/enemy_spider_priest.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_spider_priest.lua

local a = {
	cultist_spider_creep_idle = {
		prefix = "cultist_spider_creep",
		to = 1,
		from = 1
	},
	cultist_spider_creep_side_walking = {
		prefix = "cultist_spider_creep",
		to = 25,
		from = 2
	},
	cultist_spider_creep_death = {
		prefix = "cultist_spider_creep",
		to = 61,
		from = 26
	},
	cultist_spider_creep_spell = {
		prefix = "cultist_spider_creep",
		to = 117,
		from = 62
	},
	cultist_spider_creep_hit = {
		prefix = "cultist_spider_creep",
		to = 147,
		from = 118
	},
	cultist_spider_creep_iddle_front = {
		prefix = "cultist_spider_creep",
		to = 148,
		from = 148
	},
	cultist_spider_creep_idlle_back = {
		prefix = "cultist_spider_creep",
		to = 149,
		from = 149
	},
	cultist_spider_creep_walk_front = {
		prefix = "cultist_spider_creep",
		to = 173,
		from = 150
	},
	cultist_spider_creep_walk_back = {
		prefix = "cultist_spider_creep",
		to = 198,
		from = 174
	},
	cultist_spider_creep_transform_start = {
		prefix = "cultist_spider_creep",
		to = 214,
		from = 199
	},
	cultist_spider_creep_transform_loop = {
		prefix = "cultist_spider_creep",
		to = 232,
		from = 215
	},
	cultist_spider_creep_transformation = {
		prefix = "cultist_spider_creep",
		to = 363,
		from = 233
	},
	cultist_spider_spell_hit = {
		prefix = "cultist_spider_spell_hit",
		to = 9,
		from = 1
	},
	cultist_spider_projectile = {
		prefix = "cultist_spider_projectile",
		to = 10,
		from = 1
	},
	cultist_spider_projectile_trail = {
		prefix = "cultist_spider_projectile_trail",
		to = 9,
		from = 1
	},
	cultist_spider_projectile_run = {
		prefix = "cultist_spider_projectile",
		to = 10,
		from = 1
	},
	cultist_spider_projectile_flying = {
		prefix = "cultist_spider_projectile",
		to = 10,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_spider_priest.lua

-- BEGIN kr3/data/animations/enemy_spider_sister.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_spider_sister.lua

local a = {
	spider_sister_fx_attack_1_projectile = {
		prefix = "spider_sister_fx",
		to = 12,
		from = 1
	},
	spider_sister_fx_attack_1_projectile_trail = {
		prefix = "spider_sister_fx",
		to = 18,
		from = 13
	},
	spider_sister_fx_attack_1_hit = {
		prefix = "spider_sister_fx",
		to = 25,
		from = 19
	},
	spider_sister_enemy_idle = {
		prefix = "spider_sister_enemy",
		to = 1,
		from = 1
	},
	spider_sister_enemy_walk = {
		prefix = "spider_sister_enemy",
		to = 25,
		from = 2
	},
	spider_sister_enemy_walk_front = {
		prefix = "spider_sister_enemy",
		to = 49,
		from = 26
	},
	spider_sister_enemy_walk_back = {
		prefix = "spider_sister_enemy",
		to = 73,
		from = 50
	},
	spider_sister_enemy_attack_1 = {
		prefix = "spider_sister_enemy",
		to = 109,
		from = 74
	},
	spider_sister_enemy_ability_1 = {
		prefix = "spider_sister_enemy",
		to = 149,
		from = 110
	},
	spider_sister_enemy_death = {
		prefix = "spider_sister_enemy",
		to = 222,
		from = 150
	},
	spider_sister_fx_attack_1_projectile_run = {
		prefix = "spider_sister_fx",
		to = 12,
		from = 1
	},
	spider_sister_fx_attack_1_projectile_flying = {
		prefix = "spider_sister_fx",
		to = 12,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_spider_sister.lua

-- BEGIN kr3/data/animations/enemy_tank_croc.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/enemy_tank_croc.lua

local a = {
	tank_trail_trail = {
		prefix = "tank_trail",
		to = 22,
		from = 1
	},
	tank_hitspin = {
		prefix = "tank_hitspin",
		to = 8,
		from = 1
	},
	tank_hit_idle = {
		prefix = "tank_hit",
		to = 13,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/enemy_tank_croc.lua

-- BEGIN kr3/data/animations/evolving_scourge.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/evolving_scourge.lua

local a = {
	evolving_scourge_fase3_idle = {
		prefix = "evolving_scourge_fase3",
		to = 16,
		from = 1
	},
	evolving_scourge_fase3_walk = {
		prefix = "evolving_scourge_fase3",
		to = 32,
		from = 17
	},
	evolving_scourge_fase3_walk_front = {
		prefix = "evolving_scourge_fase3",
		to = 48,
		from = 33
	},
	evolving_scourge_fase3_walk_back = {
		prefix = "evolving_scourge_fase3",
		to = 64,
		from = 49
	},
	evolving_scourge_fase3_mutation = {
		prefix = "evolving_scourge_fase3",
		to = 79,
		from = 65
	},
	evolving_scourge_fase3_death = {
		prefix = "evolving_scourge_fase3",
		to = 92,
		from = 80
	},
	evolving_scourge_fase2_idle = {
		prefix = "evolving_scourge_fase2",
		to = 1,
		from = 1
	},
	evolving_scourge_fase2_walk = {
		prefix = "evolving_scourge_fase2",
		to = 25,
		from = 2
	},
	evolving_scourge_fase2_walk_front = {
		prefix = "evolving_scourge_fase2",
		to = 49,
		from = 26
	},
	evolving_scourge_fase2_walk_back = {
		prefix = "evolving_scourge_fase2",
		to = 73,
		from = 50
	},
	evolving_scourge_fase2_attack = {
		prefix = "evolving_scourge_fase2",
		to = 103,
		from = 74
	},
	evolving_scourge_fase2_attack_2 = {
		prefix = "evolving_scourge_fase2",
		to = 143,
		from = 104
	},
	evolving_scourge_fase2_mutation = {
		prefix = "evolving_scourge_fase2",
		to = 172,
		from = 144
	},
	evolving_scourge_fase2_death = {
		prefix = "evolving_scourge_fase2",
		to = 194,
		from = 173
	},
	evolving_scourge_fase1_idle = {
		prefix = "evolving_scourge_fase1",
		to = 1,
		from = 1
	},
	evolving_scourge_fase1_walk = {
		prefix = "evolving_scourge_fase1",
		to = 21,
		from = 2
	},
	evolving_scourge_fase1_walk_front = {
		prefix = "evolving_scourge_fase1",
		to = 41,
		from = 22
	},
	evolving_scourge_fase1_walk_back = {
		prefix = "evolving_scourge_fase1",
		to = 61,
		from = 42
	},
	evolving_scourge_fase1_attack = {
		prefix = "evolving_scourge_fase1",
		to = 89,
		from = 62
	},
	evolving_scourge_fase1_attack_2 = {
		prefix = "evolving_scourge_fase1",
		to = 129,
		from = 90
	},
	evolving_scourge_fase1_mutation = {
		prefix = "evolving_scourge_fase1",
		to = 167,
		from = 130
	},
	evolving_scourge_fase1_mutation2 = {
		prefix = "evolving_scourge_fase1",
		to = 198,
		from = 168
	},
	evolving_scourge_fase1_death = {
		prefix = "evolving_scourge_fase1",
		to = 220,
		from = 199
	},
	evolving_scourge_eat_FX = {
		prefix = "evolving_scourge_eat_FX",
		to = 11,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/evolving_scourge.lua

-- BEGIN kr3/data/animations/fan_guard.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/fan_guard.lua

local a = {
	fan_guard_idle = {
		prefix = "fan_guard",
		to = 2,
		from = 1
	},
	fan_guard_idle_2 = {
		prefix = "fan_guard",
		to = 2,
		from = 1
	},
	fan_guard_idle_in = {
		prefix = "fan_guard",
		to = 6,
		from = 3
	},
	fan_guard_idle_loop = {
		prefix = "fan_guard",
		to = 8,
		from = 7
	},
	fan_guard_idleout = {
		prefix = "fan_guard",
		to = 12,
		from = 9
	},
	fan_guard_walk = {
		prefix = "fan_guard",
		to = 28,
		from = 13
	},
	fan_guard_walk_down = {
		prefix = "fan_guard",
		to = 44,
		from = 29
	},
	fan_guard_walk_up = {
		prefix = "fan_guard",
		to = 59,
		from = 45
	},
	fan_guard_melee_1 = {
		prefix = "fan_guard",
		to = 106,
		from = 60
	},
	fan_guard_melee_2 = {
		prefix = "fan_guard",
		to = 150,
		from = 107
	},
	fan_guard_melee_3 = {
		prefix = "fan_guard",
		to = 214,
		from = 151
	},
	fan_guard_death = {
		prefix = "fan_guard",
		to = 270,
		from = 215
	},
	fan_guard_hit_run = {
		prefix = "fan_guard_hit",
		to = 6,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/fan_guard.lua

-- BEGIN kr3/data/animations/fire_fox.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/fire_fox.lua

local a = {
	firefox_creep_idle = {
		prefix = "firefox_creep",
		to = 2,
		from = 1
	},
	firefox_creep_walk = {
		prefix = "firefox_creep",
		to = 18,
		from = 3
	},
	firefox_creep_walkdown = {
		prefix = "firefox_creep",
		to = 34,
		from = 19
	},
	firefox_creep_walkup = {
		prefix = "firefox_creep",
		to = 50,
		from = 35
	},
	firefox_creep_melee = {
		prefix = "firefox_creep",
		to = 77,
		from = 51
	},
	firefox_creep_death = {
		prefix = "firefox_creep",
		to = 107,
		from = 78
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/fire_fox.lua

-- BEGIN kr3/data/animations/fire_phoenix.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/fire_phoenix.lua

local a = {
	fire_phoenix_zhu_que_explosionfuego = {
		prefix = "fire_phoenix_zhu_que_explosionfuego",
		to = 18,
		from = 1
	},
	fire_phoenix_zhu_que_fuego_camino_in = {
		prefix = "fire_phoenix_zhu_que_fuego_camino",
		to = 4,
		from = 1
	},
	fire_phoenix_zhu_que_fuego_camino_idle = {
		prefix = "fire_phoenix_zhu_que_fuego_camino",
		to = 18,
		from = 5
	},
	fire_phoenix_zhu_que_fuego_camino_out = {
		prefix = "fire_phoenix_zhu_que_fuego_camino",
		to = 32,
		from = 19
	},
	fire_phoenix_zhu_que_fuego_camino_small_in = {
		prefix = "fire_phoenix_zhu_que_fuego_camino_small",
		to = 4,
		from = 1
	},
	fire_phoenix_zhu_que_fuego_camino_small_idle = {
		prefix = "fire_phoenix_zhu_que_fuego_camino_small",
		to = 18,
		from = 5
	},
	fire_phoenix_zhu_que_fuego_camino_small_out = {
		prefix = "fire_phoenix_zhu_que_fuego_camino_small",
		to = 32,
		from = 19
	},
	fire_phoenix_zhu_que_firephoenixzhuque_idle = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 14,
		from = 1
	},
	fire_phoenix_zhu_que_firephoenixzhuque_walk = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 28,
		from = 15
	},
	fire_phoenix_zhu_que_firephoenixzhuque_walk_front = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 42,
		from = 29
	},
	fire_phoenix_zhu_que_firephoenixzhuque_walk_back = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 56,
		from = 43
	},
	fire_phoenix_zhu_que_firephoenixzhuque_bomb_death = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 78,
		from = 57
	},
	fire_phoenix_zhu_que_firephoenixzhuque_caida = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 92,
		from = 79
	},
	fire_phoenix_zhu_que_firephoenixzhuque_normal_death = {
		prefix = "fire_phoenix_zhu_que_firephoenixzhuque",
		to = 114,
		from = 93
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/fire_phoenix.lua

-- BEGIN kr3/data/animations/flame_guard.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/flame_guard.lua

local a = {
	flame_guard_idle = {
		prefix = "flame_guard_creep",
		to = 1,
		from = 1
	},
	flame_guard_walk = {
		prefix = "flame_guard_creep",
		to = 21,
		from = 2
	},
	flame_guard_walkdown = {
		prefix = "flame_guard_creep",
		to = 41,
		from = 22
	},
	flame_guard_walkup = {
		prefix = "flame_guard_creep",
		to = 61,
		from = 42
	},
	flame_guard_attack_01 = {
		prefix = "flame_guard_creep",
		to = 104,
		from = 62
	},
	flame_guard_attack_02 = {
		prefix = "flame_guard_creep",
		to = 147,
		from = 105
	},
	flame_guard_death = {
		prefix = "flame_guard_creep",
		to = 197,
		from = 148
	},
	flame_guard_raise = {
		prefix = "flame_guard_creep",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/flame_guard.lua

-- BEGIN kr3/data/animations/gale_warrior.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/gale_warrior.lua

local a = {
	gale_warrior_raise = {
		prefix = "gale_warrior",
		to = 1,
		from = 1
	},
	gale_warrior_idle = {
		prefix = "gale_warrior",
		to = 21,
		from = 1
	},
	gale_warrior_walk = {
		prefix = "gale_warrior",
		to = 53,
		from = 22
	},
	gale_warrior_walk_down = {
		prefix = "gale_warrior",
		to = 85,
		from = 54
	},
	gale_warrior_walk_up = {
		prefix = "gale_warrior",
		to = 117,
		from = 86
	},
	gale_warrior_attack = {
		prefix = "gale_warrior",
		to = 145,
		from = 118
	},
	gale_warrior_special_attack = {
		prefix = "gale_warrior",
		to = 172,
		from = 146
	},
	gale_warrior_death = {
		prefix = "gale_warrior",
		to = 216,
		from = 173
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/gale_warrior.lua

-- BEGIN kr3/data/animations/glareling.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/glareling.lua

local a = {
	glearling_trail_trail = {
		prefix = "glearling_trail",
		to = 10,
		from = 1
	},
	glearling_flying_flying = {
		prefix = "glearling_flying",
		to = 1,
		from = 1
	},
	glearling_character_idle = {
		prefix = "glearling_character",
		to = 1,
		from = 1
	},
	glearling_character_walk = {
		prefix = "glearling_character",
		to = 11,
		from = 2
	},
	glearling_character_walkUp = {
		prefix = "glearling_character",
		to = 21,
		from = 12
	},
	glearling_character_walkDown = {
		prefix = "glearling_character",
		to = 31,
		from = 22
	},
	glearling_character_attack = {
		prefix = "glearling_character",
		to = 64,
		from = 32
	},
	glearling_character_spawn = {
		prefix = "glearling_character",
		to = 98,
		from = 65
	},
	glearling_character_jump = {
		prefix = "glearling_character",
		to = 147,
		from = 99
	},
	glearling_character_death = {
		prefix = "glearling_character",
		to = 176,
		from = 148
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/glareling.lua

-- BEGIN kr3/data/animations/hardened_horror.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hardened_horror.lua

local a = {
	hardened_horror_hit_vfx_attack_1_hit = {
		prefix = "hardened_horror_hit_vfx",
		to = 6,
		from = 1
	},
	hardened_horror_creep_idle = {
		prefix = "hardened_horror_creep",
		to = 24,
		from = 1
	},
	hardened_horror_creep_walk = {
		prefix = "hardened_horror_creep",
		to = 48,
		from = 25
	},
	hardened_horror_creep_walk_front = {
		prefix = "hardened_horror_creep",
		to = 72,
		from = 49
	},
	hardened_horror_creep_walk_back = {
		prefix = "hardened_horror_creep",
		to = 96,
		from = 73
	},
	hardened_horror_creep_attack = {
		prefix = "hardened_horror_creep",
		to = 133,
		from = 97
	},
	hardened_horror_creep_roll_in = {
		prefix = "hardened_horror_creep",
		to = 157,
		from = 134
	},
	hardened_horror_creep_roll_loop = {
		prefix = "hardened_horror_creep",
		to = 173,
		from = 158
	},
	hardened_horror_creep_roll_out = {
		prefix = "hardened_horror_creep",
		to = 189,
		from = 174
	},
	hardened_horror_creep_roll_down = {
		prefix = "hardened_horror_creep",
		to = 205,
		from = 190
	},
	hardened_horror_creep_roll_up = {
		prefix = "hardened_horror_creep",
		to = 221,
		from = 206
	},
	hardened_horror_creep_death = {
		prefix = "hardened_horror_creep",
		to = 249,
		from = 222
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hardened_horror.lua

-- BEGIN kr3/data/animations/hellfire_warlock.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/hellfire_warlock.lua

local a = {
	hellfire_warlock_summon_decal_start = {
		prefix = "hellfire_warlock_summon_decal",
		to = 12,
		from = 1
	},
	hellfire_warlock_summon_decal_loop = {
		prefix = "hellfire_warlock_summon_decal",
		to = 32,
		from = 13
	},
	hellfire_warlock_summon_decal_end = {
		prefix = "hellfire_warlock_summon_decal",
		to = 43,
		from = 33
	},
	hellfire_warlock_fireball_trail = {
		prefix = "hellfire_warlock_fireball_trail",
		to = 15,
		from = 1
	},
	hellfire_warlock_fireball_run = {
		prefix = "hellfire_warlock_fireball",
		to = 12,
		from = 1
	},
	hellfire_warlock_firedecal_run = {
		prefix = "hellfire_warlock_firedecal",
		to = 14,
		from = 1
	},
	hellfire_warlock_hit_run = {
		prefix = "hellfire_warlock_hit",
		to = 6,
		from = 1
	},
	hellfire_warlock_hit_fireball = {
		prefix = "hellfire_warlock_hit_fireball",
		to = 25,
		from = 1
	},
	hellfire_warlock_summon_stafx_run = {
		prefix = "hellfire_warlock_summon_stafx",
		to = 30,
		from = 1
	},
	hellfire_warlock_creep_idle = {
		prefix = "hellfire_warlock_creep",
		to = 1,
		from = 1
	},
	hellfire_warlock_creep_walk = {
		prefix = "hellfire_warlock_creep",
		to = 39,
		from = 2
	},
	hellfire_warlock_creep_walk_down = {
		prefix = "hellfire_warlock_creep",
		to = 77,
		from = 40
	},
	hellfire_warlock_creep_walk_up = {
		prefix = "hellfire_warlock_creep",
		to = 115,
		from = 78
	},
	hellfire_warlock_creep_mele_2 = {
		prefix = "hellfire_warlock_creep",
		to = 139,
		from = 116
	},
	hellfire_warlock_creep_ranged = {
		prefix = "hellfire_warlock_creep",
		to = 171,
		from = 140
	},
	hellfire_warlock_creep_summon_in = {
		prefix = "hellfire_warlock_creep",
		to = 177,
		from = 172
	},
	hellfire_warlock_creep_summon_loop = {
		prefix = "hellfire_warlock_creep",
		to = 207,
		from = 178
	},
	hellfire_warlock_creep_summon_casted = {
		prefix = "hellfire_warlock_creep",
		to = 237,
		from = 208
	},
	hellfire_warlock_creep_summon_canceled = {
		prefix = "hellfire_warlock_creep",
		to = 277,
		from = 238
	},
	hellfire_warlock_creep_death = {
		prefix = "hellfire_warlock_creep",
		to = 359,
		from = 278
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hellfire_warlock.lua

-- BEGIN kr3/data/animations/hero_bird.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_bird.lua

local a = {
	gryph_slow_mod_run = {
		prefix = "gryph_slow_mod",
		to = 10,
		from = 1
	},
	gryph_child_hit_run = {
		prefix = "gryph_child_hit",
		to = 8,
		from = 1
	},
	gryph_bulletskill_decal_run = {
		prefix = "gryph_bulletskill_decal",
		to = 27,
		from = 1
	},
	gryph_skillshot_part_trail_run = {
		prefix = "gryph_skillshot_part_trail",
		to = 14,
		from = 1
	},
	gryph_character_fly = {
		prefix = "gryph_character",
		to = 16,
		from = 1
	},
	gryph_character_skillthrowclusterbomb = {
		prefix = "gryph_character",
		to = 76,
		from = 17
	},
	gryph_character_attack = {
		prefix = "gryph_character",
		to = 106,
		from = 77
	},
	gryph_character_stun = {
		prefix = "gryph_character",
		to = 148,
		from = 107
	},
	gryph_character_instakill = {
		prefix = "gryph_character",
		to = 187,
		from = 149
	},
	gryph_character_shootskill = {
		prefix = "gryph_character",
		to = 205,
		from = 188
	},
	gryph_character_shootskillloop = {
		prefix = "gryph_character",
		to = 221,
		from = 206
	},
	gryph_character_shootskillend = {
		prefix = "gryph_character",
		to = 237,
		from = 222
	},
	gryph_character_shootskillback = {
		prefix = "gryph_character",
		to = 253,
		from = 238
	},
	gryph_character_shootskillloopback = {
		prefix = "gryph_character",
		to = 269,
		from = 254
	},
	gryph_character_shootskillendback = {
		prefix = "gryph_character",
		to = 285,
		from = 270
	},
	gryph_character_levelup = {
		prefix = "gryph_character",
		to = 305,
		from = 286
	},
	gryph_character_death = {
		prefix = "gryph_character",
		to = 350,
		from = 306
	},
	gryph_skillshot_run = {
		prefix = "gryph_skillshot",
		to = 5,
		from = 1
	},
	gryph_skillproy_part_explosion_run = {
		prefix = "gryph_skillproy_part_explosion",
		to = 27,
		from = 1
	},
	gryph_skillproy_explosion_run = {
		prefix = "gryph_skillproy_explosion",
		to = 17,
		from = 1
	},
	gryph_skillproy_fire_run = {
		prefix = "gryph_skillproy_fire",
		to = 28,
		from = 1
	},
	gryph_skillproy_fireparticles_run = {
		prefix = "gryph_skillproy_fireparticles",
		to = 28,
		from = 1
	},
	gryph_skillproy_part_decal = {
		prefix = "gryph_skillproy_part",
		to = 1,
		from = 1
	},
	gryph_skillproy_decl = {
		prefix = "gryph_skillproy",
		to = 14,
		from = 1
	},
	gryph_skillproy_trail_run = {
		prefix = "gryph_skillproy_trail",
		to = 13,
		from = 1
	},
	gryph_deaththing_death = {
		prefix = "gryph_deaththing",
		to = 18,
		from = 1
	},
	gryph_proy_decal_decal = {
		prefix = "gryph_proy_decal",
		to = 1,
		from = 1
	},
	gryph_proy_explosion_run = {
		prefix = "gryph_proy_explosion",
		to = 17,
		from = 1
	},
	gryph_child_idle = {
		prefix = "gryph_child",
		to = 20,
		from = 1
	},
	gryph_child_attack_in = {
		prefix = "gryph_child",
		to = 30,
		from = 21
	},
	gryph_child_projectile = {
		prefix = "gryph_child",
		to = 32,
		from = 31
	},
	gryph_child_attack_out = {
		prefix = "gryph_child",
		to = 38,
		from = 33
	},
	gryph_child_in = {
		prefix = "gryph_child",
		to = 56,
		from = 39
	},
	gryph_stunskill_decal_run = {
		prefix = "gryph_stunskill_decal",
		to = 23,
		from = 1
	},
	gryph_bulletskill_enemyhitfx_run = {
		prefix = "gryph_bulletskill_enemyhitfx",
		to = 16,
		from = 1
	},
	gryph_proy_decal = {
		prefix = "gryph_proy",
		to = 1,
		from = 1
	},
	gryph_character_idle = {
		prefix = "gryph_character",
		to = 16,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_bird.lua

-- BEGIN kr3/data/animations/hero_builder.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_builder.lua

local a = {
	hero_obdul_hero_idle = {
		prefix = "hero_obdul_hero",
		to = 40,
		from = 1
	},
	hero_obdul_hero_walk = {
		prefix = "hero_obdul_hero",
		to = 64,
		from = 41
	},
	hero_obdul_hero_attack = {
		prefix = "hero_obdul_hero",
		to = 100,
		from = 65
	},
	hero_obdul_hero_skill_1 = {
		prefix = "hero_obdul_hero",
		to = 146,
		from = 101
	},
	hero_obdul_hero_skill_2 = {
		prefix = "hero_obdul_hero",
		to = 206,
		from = 147
	},
	hero_obdul_hero_skill_3_start = {
		prefix = "hero_obdul_hero",
		to = 222,
		from = 207
	},
	hero_obdul_hero_skill_3_loop = {
		prefix = "hero_obdul_hero",
		to = 228,
		from = 223
	},
	hero_obdul_hero_skill_3_end = {
		prefix = "hero_obdul_hero",
		to = 250,
		from = 229
	},
	hero_obdul_hero_skill_4 = {
		prefix = "hero_obdul_hero",
		to = 324,
		from = 251
	},
	hero_obdul_hero_skill_5 = {
		prefix = "hero_obdul_hero",
		to = 360,
		from = 325
	},
	hero_obdul_hero_levelup = {
		prefix = "hero_obdul_hero",
		to = 388,
		from = 361
	},
	hero_obdul_hero_respawn = {
		prefix = "hero_obdul_hero",
		to = 422,
		from = 389
	},
	hero_obdul_hero_death = {
		prefix = "hero_obdul_hero",
		to = 474,
		from = 423
	},
	hero_obdul_hero_grave = {
		prefix = "hero_obdul_hero",
		to = 475,
		from = 475
	},
	hero_obdul_basic_attack_hit = {
		prefix = "hero_obdul_basic_attack_hit",
		to = 7,
		from = 1
	},
	hero_obdul_woody_idle = {
		prefix = "hero_obdul_woody",
		to = 1,
		from = 1
	},
	hero_obdul_woody_death = {
		prefix = "hero_obdul_woody",
		to = 21,
		from = 2
	},
	hero_obdul_ultimate_projectile = {
		prefix = "hero_obdul_ultimate_projectile",
		to = 1,
		from = 1
	},
	hero_obdul_ultimate_dust_cloud = {
		prefix = "hero_obdul_ultimate_dust_cloud",
		to = 24,
		from = 1
	},
	hero_obdul_ultimate_dust_over_ball_run = {
		prefix = "hero_obdul_ultimate_dust_over_ball",
		to = 13,
		from = 1
	},
	hero_obdul_ultimate_rock_03_in = {
		prefix = "hero_obdul_ultimate_rock_03",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_rock_02_in = {
		prefix = "hero_obdul_ultimate_rock_02",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_rock_01_in = {
		prefix = "hero_obdul_ultimate_rock_01",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_rock_04_in = {
		prefix = "hero_obdul_ultimate_rock_04",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_ball = {
		prefix = "hero_obdul_ultimate_ball",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_in = {
		prefix = "hero_obdul_ultimate",
		to = 17,
		from = 1
	},
	hero_obdul_ultimate_idle = {
		prefix = "hero_obdul_ultimate",
		to = 18,
		from = 18
	},
	hero_obdul_ultimate_decal = {
		prefix = "hero_obdul_ultimate_decal",
		to = 1,
		from = 1
	},
	hero_obdul_ultimate_decal_enemy = {
		prefix = "hero_obdul_ultimate_decal_enemy",
		to = 16,
		from = 1
	},
	hero_obdul_skill_3_hit = {
		prefix = "hero_obdul_skill_3_hit",
		to = 7,
		from = 1
	},
	hero_obdul_skill_4_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "hero_obdul_skill_4_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	hero_obdul_skill_4_tower_layerX_spawn = {
		layer_to = 3,
		from = 2,
		layer_prefix = "hero_obdul_skill_4_tower_layer%i",
		to = 53,
		layer_from = 1
	},
	hero_obdul_skill_4_tower_layerX_attack = {
		layer_to = 3,
		from = 54,
		layer_prefix = "hero_obdul_skill_4_tower_layer%i",
		to = 73,
		layer_from = 1
	},
	hero_obdul_skill_4_tower_layerX_death = {
		layer_to = 3,
		from = 74,
		layer_prefix = "hero_obdul_skill_4_tower_layer%i",
		to = 101,
		layer_from = 1
	},
	hero_obdul_skill_4_tower_hit = {
		prefix = "hero_obdul_skill_4_tower_hit",
		to = 7,
		from = 1
	},
	hero_obdul_skill_4_tower_projectile = {
		prefix = "hero_obdul_skill_4_tower_projectile",
		to = 1,
		from = 1
	},
	hero_obdul_skill_5_soldier_idle = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 1,
		from = 1
	},
	hero_obdul_skill_5_soldier_running = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 21,
		from = 2
	},
	hero_obdul_skill_5_soldier_walkDown = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 41,
		from = 22
	},
	hero_obdul_skill_5_soldier_walkUp = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 61,
		from = 42
	},
	hero_obdul_skill_5_soldier_attack = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 81,
		from = 62
	},
	hero_obdul_skill_5_soldier_death = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 101,
		from = 82
	},
	hero_obdul_skill_5_soldier_raise = {
		prefix = "hero_obdul_skill_5_soldier",
		to = 107,
		from = 102
	},
	hero_obdul_skill_5_soldier_spawn_decal = {
		prefix = "hero_obdul_skill_5_soldier_spawn",
		to = 13,
		from = 1
	},
	hero_obdul_skill_3_fx_start = {
		prefix = "hero_obdul_skill_3_fx",
		to = 16,
		from = 1
	},
	hero_obdul_skill_3_fx_loop = {
		prefix = "hero_obdul_skill_3_fx",
		to = 22,
		from = 17
	},
	hero_obdul_skill_3_fx_end = {
		prefix = "hero_obdul_skill_3_fx",
		to = 44,
		from = 23
	},
	hero_builder_worker_idle = {
		prefix = "hero_builder_worker",
		to = 1,
		from = 1
	},
	hero_builder_worker_running = {
		prefix = "hero_builder_worker",
		to = 21,
		from = 2
	},
	hero_builder_worker_attack = {
		prefix = "hero_builder_worker",
		to = 81,
		from = 62
	},
	hero_builder_worker_death = {
		prefix = "hero_builder_worker",
		to = 101,
		from = 82
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_builder.lua

-- BEGIN kr3/data/animations/hero_dragon.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_dragon.lua

local a = {
	hero_lumenir_hero_walk = {
		prefix = "hero_lumenir_hero",
		to = 20,
		from = 1
	},
	hero_lumenir_hero_idle = {
		prefix = "hero_lumenir_hero",
		to = 20,
		from = 1
	},
	hero_lumenir_hero_attack = {
		prefix = "hero_lumenir_hero",
		to = 54,
		from = 21
	},
	hero_lumenir_hero_radiant_wave = {
		prefix = "hero_lumenir_hero",
		to = 90,
		from = 55
	},
	hero_lumenir_hero_blessing_of_retribution = {
		prefix = "hero_lumenir_hero",
		to = 134,
		from = 91
	},
	hero_lumenir_hero_celestial_judgement = {
		prefix = "hero_lumenir_hero",
		to = 178,
		from = 135
	},
	hero_lumenir_hero_death = {
		prefix = "hero_lumenir_hero",
		to = 228,
		from = 179
	},
	hero_lumenir_hero_respawn = {
		prefix = "hero_lumenir_hero",
		to = 276,
		from = 229
	},
	hero_lumenir_hero_lvlup = {
		prefix = "hero_lumenir_hero",
		to = 292,
		from = 277
	},
	hero_lumenir_blessing_of_retribution_shield_big = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_big",
		to = 15,
		from = 1
	},
	hero_lumenir_blessing_of_retribution_shield_decal_big = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_decal_big",
		to = 1,
		from = 1
	},
	hero_lumenir_blessing_of_retribution_shield_mid = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_mid",
		to = 15,
		from = 1
	},
	hero_lumenir_blessing_of_retribution_shield_decal_mid = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_decal_mid",
		to = 1,
		from = 1
	},
	hero_lumenir_blessing_of_retribution_shield_small = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_small",
		to = 15,
		from = 1
	},
	hero_lumenir_blessing_of_retribution_shield_decal_small = {
		prefix = "hero_lumenir_blessing_of_retribution_shield_decal_small",
		to = 1,
		from = 1
	},
	hero_lumenir_celestial_judgement_fx_idle = {
		prefix = "hero_lumenir_celestial_judgement_fx",
		to = 39,
		from = 1
	},
	hero_lumenir_celestial_judgement_fx_decal = {
		prefix = "hero_lumenir_celestial_judgement_fx_decal",
		to = 1,
		from = 1
	},
	hero_lumenir_hero_shadow = {
		prefix = "hero_lumenir_hero_shadow",
		to = 1,
		from = 1
	},
	hero_lumenir_attack_projectile_idle = {
		prefix = "hero_lumenir_attack_projectile",
		to = 10,
		from = 1
	},
	hero_lumenir_attack_projectile_trail_idle = {
		prefix = "hero_lumenir_attack_projectile_trail",
		to = 12,
		from = 1
	},
	hero_lumenir_attack_hit_fx_idle = {
		prefix = "hero_lumenir_attack_hit_fx",
		to = 20,
		from = 1
	},
	hero_lumenir_attack_hit_fx_air = {
		prefix = "hero_lumenir_attack_hit_fx_air",
		to = 18,
		from = 1
	},
	hero_lumenir_radiant_wave_projectile_idle = {
		prefix = "hero_lumenir_radiant_wave_projectile",
		to = 20,
		from = 1
	},
	hero_lumenir_radiant_wave_trail_idle = {
		prefix = "hero_lumenir_radiant_wave_trail",
		to = 16,
		from = 1
	},
	hero_lumenir_call_of_triumph_spawn_fx_idle = {
		prefix = "hero_lumenir_call_of_triumph_spawn_fx",
		to = 24,
		from = 1
	},
	hero_lumenir_call_of_triumph_idle = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 2,
		from = 1
	},
	hero_lumenir_call_of_triumph_attack = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 32,
		from = 3
	},
	hero_lumenir_call_of_triumph_attack2 = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 32,
		from = 3
	},
	hero_lumenir_call_of_triumph_attack3 = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 32,
		from = 3
	},
	hero_lumenir_call_of_triumph_attack4 = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 32,
		from = 3
	},
	hero_lumenir_call_of_triumph_out = {
		prefix = "hero_lumenir_call_of_triumph",
		to = 65,
		from = 33
	},
	hero_lumenir_call_of_triumph_decal = {
		prefix = "hero_lumenir_call_of_triumph_decal",
		to = 1,
		from = 1
	},
	hero_lumenir_light_companion_attack_projectile_trail_idle = {
		prefix = "hero_lumenir_light_companion_attack_projectile_trail",
		to = 14,
		from = 1
	},
	hero_lumenir_light_companion_attack_projectile_idle = {
		prefix = "hero_lumenir_light_companion_attack_projectile",
		to = 20,
		from = 1
	},
	hero_lumenir_light_companion_attack_projectile_trail_particle_idle = {
		prefix = "hero_lumenir_light_companion_attack_projectile_trail_particle",
		to = 6,
		from = 1
	},
	hero_lumenir_light_companion_attack_fx_idle = {
		prefix = "hero_lumenir_light_companion_attack_fx",
		to = 8,
		from = 1
	},
	hero_lumenir_light_companion_walk = {
		prefix = "hero_lumenir_light_companion",
		to = 18,
		from = 1
	},
	hero_lumenir_light_companion_attack = {
		prefix = "hero_lumenir_light_companion",
		to = 55,
		from = 19
	},
	hero_lumenir_light_companion_spawn = {
		prefix = "hero_lumenir_light_companion",
		to = 81,
		from = 56
	},
	hero_lumenir_light_companion_shadow = {
		prefix = "hero_lumenir_light_companion_shadow",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_dragon.lua

-- BEGIN kr3/data/animations/hero_dragon_arb.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_dragon_arb.lua

local a = {
	hero_dragon_arborean_powered_hit_fx_idle = {
		prefix = "hero_dragon_arborean_powered_hit_fx",
		to = 12,
		from = 1
	},
	hero_dragon_arborean_arborean_powered_fx_front_spawn = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_front",
		to = 12,
		from = 1
	},
	hero_dragon_arborean_arborean_powered_fx_front_idle = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_front",
		to = 22,
		from = 13
	},
	hero_dragon_arborean_arborean_powered_fx_front_walk = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_front",
		to = 58,
		from = 23
	},
	hero_dragon_arborean_arborean_powered_fx_front_attack = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_front",
		to = 84,
		from = 59
	},
	hero_dragon_arborean_arborean_spawn = {
		prefix = "hero_dragon_arborean_arborean",
		to = 46,
		from = 1
	},
	hero_dragon_arborean_arborean_idle = {
		prefix = "hero_dragon_arborean_arborean",
		to = 47,
		from = 47
	},
	hero_dragon_arborean_arborean_walk = {
		prefix = "hero_dragon_arborean_arborean",
		to = 83,
		from = 48
	},
	hero_dragon_arborean_arborean_attack = {
		prefix = "hero_dragon_arborean_arborean",
		to = 109,
		from = 84
	},
	hero_dragon_arborean_arborean_powered_fx_back_idle = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_back",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_passive_start = {
		prefix = "hero_dragon_arborean_passive",
		to = 22,
		from = 1
	},
	hero_dragon_arborean_passive_idle = {
		prefix = "hero_dragon_arborean_passive",
		to = 23,
		from = 23
	},
	hero_dragon_arborean_passive_end = {
		prefix = "hero_dragon_arborean_passive",
		to = 45,
		from = 24
	},
	hero_dragon_arborean_heal_front_b_idle = {
		prefix = "hero_dragon_arborean_heal_front_b",
		to = 42,
		from = 1
	},
	hero_dragon_arborean_heal_front_a_idle = {
		prefix = "hero_dragon_arborean_heal_front_a",
		to = 44,
		from = 1
	},
	hero_dragon_arborean_heal_back_idle = {
		prefix = "hero_dragon_arborean_heal_back",
		to = 44,
		from = 1
	},
	hero_dragon_arborean_flower_projectile_hit_fx_idle = {
		prefix = "hero_dragon_arborean_flower_projectile_hit_fx",
		to = 8,
		from = 1
	},
	hero_dragon_arborean_flower_projectile_trail = {
		prefix = "hero_dragon_arborean_flower_projectile_trail",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_flower_projectile = {
		prefix = "hero_dragon_arborean_flower_projectile",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_flower_spawn = {
		prefix = "hero_dragon_arborean_flower",
		to = 26,
		from = 1
	},
	hero_dragon_arborean_flower_idle = {
		prefix = "hero_dragon_arborean_flower",
		to = 27,
		from = 27
	},
	hero_dragon_arborean_flower_attack = {
		prefix = "hero_dragon_arborean_flower",
		to = 45,
		from = 28
	},
	hero_dragon_arborean_flower_end = {
		prefix = "hero_dragon_arborean_flower",
		to = 71,
		from = 46
	},
	hero_dragon_arborean_mushroom_spawn = {
		prefix = "hero_dragon_arborean_mushroom",
		to = 22,
		from = 1
	},
	hero_dragon_arborean_mushroom_idle = {
		prefix = "hero_dragon_arborean_mushroom",
		to = 23,
		from = 23
	},
	hero_dragon_arborean_mushroom_attack = {
		prefix = "hero_dragon_arborean_mushroom",
		to = 75,
		from = 24
	},
	hero_dragon_arborean_mushroom_end = {
		prefix = "hero_dragon_arborean_mushroom",
		to = 97,
		from = 76
	},
	hero_dragon_arborean_water_hit_fx_idle = {
		prefix = "hero_dragon_arborean_water_hit_fx",
		to = 10,
		from = 1
	},
	hero_dragon_arborean_water_ground_fx_idle = {
		prefix = "hero_dragon_arborean_water_ground_fx",
		to = 18,
		from = 1
	},
	hero_dragon_arborean_water_projectile_trail_idle = {
		prefix = "hero_dragon_arborean_water_projectile_trail",
		to = 9,
		from = 1
	},
	hero_dragon_arborean_water_projectile_run = {
		prefix = "hero_dragon_arborean_water_projectile",
		to = 8,
		from = 1
	},
	hero_dragon_arborean_spikes_mouth_fx_idle = {
		prefix = "hero_dragon_arborean_spikes_mouth_fx",
		to = 8,
		from = 1
	},
	hero_dragon_arborean_spikes_projectile_trail_idle = {
		prefix = "hero_dragon_arborean_spikes_projectile_trail",
		to = 10,
		from = 1
	},
	hero_dragon_arborean_spikes_projectile_hit_fx_idle = {
		prefix = "hero_dragon_arborean_spikes_projectile_hit_fx",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_spikes_projectile = {
		prefix = "hero_dragon_arborean_spikes_projectile",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_tower_fx_b_start = {
		prefix = "hero_dragon_arborean_tower_fx_b",
		to = 6,
		from = 1
	},
	hero_dragon_arborean_tower_fx_b_idle = {
		prefix = "hero_dragon_arborean_tower_fx_b",
		to = 72,
		from = 7
	},
	hero_dragon_arborean_tower_fx_b_end = {
		prefix = "hero_dragon_arborean_tower_fx_b",
		to = 102,
		from = 73
	},
	hero_dragon_arborean_tower_fx_a_start = {
		prefix = "hero_dragon_arborean_tower_fx_a",
		to = 6,
		from = 1
	},
	hero_dragon_arborean_tower_fx_a_idle = {
		prefix = "hero_dragon_arborean_tower_fx_a",
		to = 7,
		from = 7
	},
	hero_dragon_arborean_tower_fx_a_end = {
		prefix = "hero_dragon_arborean_tower_fx_a",
		to = 37,
		from = 8
	},
	hero_dragon_arborean_rune_projectile = {
		prefix = "hero_dragon_arborean_rune_projectile",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_leaf_projectile_spawn_fx_idle = {
		prefix = "hero_dragon_arborean_leaf_projectile_spawn_fx",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_leaf_projectile = {
		prefix = "hero_dragon_arborean_leaf_projectile",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_hit_fx_run = {
		prefix = "hero_dragon_arborean_hit_fx",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_splinter_projectile = {
		prefix = "hero_dragon_arborean_splinter_projectile",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_splinter_decal = {
		prefix = "hero_dragon_arborean_splinter_decal",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_splinter_ground_a_idle = {
		prefix = "hero_dragon_arborean_splinter_ground_a",
		to = 35,
		from = 1
	},
	hero_dragon_arborean_splinter_ground_b_idle = {
		prefix = "hero_dragon_arborean_splinter_ground_b",
		to = 33,
		from = 1
	},
	hero_dragon_arborean_breath_idle = {
		prefix = "hero_dragon_arborean_breath",
		to = 30,
		from = 1
	},
	hero_dragon_arborean_transformation_fx_idle = {
		prefix = "hero_dragon_arborean_transformation_fx",
		to = 21,
		from = 1
	},
	hero_dragon_arborean_transformation_overlay_walk = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_transformation_overlay_attack = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 52,
		from = 21
	},
	hero_dragon_arborean_transformation_overlay_power_1 = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 94,
		from = 53
	},
	hero_dragon_arborean_transformation_overlay_power_2 = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 140,
		from = 95
	},
	hero_dragon_arborean_transformation_overlay_power_3 = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 172,
		from = 141
	},
	hero_dragon_arborean_transformation_overlay_power_4 = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 218,
		from = 173
	},
	hero_dragon_arborean_transformation_overlay_lvlup = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 238,
		from = 219
	},
	hero_dragon_arborean_hero_walk = {
		prefix = "hero_dragon_arborean_hero",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_hero_attack = {
		prefix = "hero_dragon_arborean_hero",
		to = 52,
		from = 21
	},
	hero_dragon_arborean_hero_power_1 = {
		prefix = "hero_dragon_arborean_hero",
		to = 94,
		from = 53
	},
	hero_dragon_arborean_hero_power_2 = {
		prefix = "hero_dragon_arborean_hero",
		to = 140,
		from = 95
	},
	hero_dragon_arborean_hero_power_3 = {
		prefix = "hero_dragon_arborean_hero",
		to = 172,
		from = 141
	},
	hero_dragon_arborean_hero_power_4 = {
		prefix = "hero_dragon_arborean_hero",
		to = 218,
		from = 173
	},
	hero_dragon_arborean_hero_lvlup = {
		prefix = "hero_dragon_arborean_hero",
		to = 238,
		from = 219
	},
	hero_dragon_arborean_hero_death = {
		prefix = "hero_dragon_arborean_hero",
		to = 274,
		from = 239
	},
	hero_dragon_arborean_hero_respawn = {
		prefix = "hero_dragon_arborean_hero",
		to = 323,
		from = 275
	},
	hero_dragon_arborean_shadow = {
		prefix = "hero_dragon_arborean_shadow",
		to = 1,
		from = 1
	},
	hero_dragon_arborean_passive_root1_start = {
		prefix = "hero_dragon_arborean_passive_root1",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_passive_root1_loop = {
		prefix = "hero_dragon_arborean_passive_root1",
		to = 28,
		from = 21
	},
	hero_dragon_arborean_passive_root1_end = {
		prefix = "hero_dragon_arborean_passive_root1",
		to = 37,
		from = 29
	},
	hero_dragon_arborean_passive_root2_start = {
		prefix = "hero_dragon_arborean_passive_root2",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_passive_root2_loop = {
		prefix = "hero_dragon_arborean_passive_root2",
		to = 28,
		from = 21
	},
	hero_dragon_arborean_passive_root2_end = {
		prefix = "hero_dragon_arborean_passive_root2",
		to = 37,
		from = 29
	},
	hero_dragon_arborean_passive_root3_start = {
		prefix = "hero_dragon_arborean_passive_root3",
		to = 17,
		from = 1
	},
	hero_dragon_arborean_passive_root3_loop = {
		prefix = "hero_dragon_arborean_passive_root3",
		to = 22,
		from = 18
	},
	hero_dragon_arborean_passive_root3_end = {
		prefix = "hero_dragon_arborean_passive_root3",
		to = 38,
		from = 23
	},
	hero_dragon_arborean_transformation_overlay_idle = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_hero_idle = {
		prefix = "hero_dragon_arborean_hero",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_transformation_overlay_death = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_transformation_overlay_respawn = {
		prefix = "hero_dragon_arborean_transformation_overlay",
		to = 20,
		from = 1
	},
	hero_dragon_arborean_arborean_death = {
		prefix = "hero_dragon_arborean_arborean",
		to = 83,
		from = 48
	},
	hero_dragon_arborean_arborean_powered_fx_front_death = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_front",
		to = 58,
		from = 23
	},
	hero_dragon_arborean_arborean_powered_fx_back_idle_spawn = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_back",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_arborean_powered_fx_back_idle_idle = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_back",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_arborean_powered_fx_back_idle_walk = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_back",
		to = 16,
		from = 1
	},
	hero_dragon_arborean_arborean_powered_fx_back_idle_attack = {
		prefix = "hero_dragon_arborean_arborean_powered_fx_back",
		to = 16,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_dragon_arb.lua

-- BEGIN kr3/data/animations/hero_dragon_bone.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_dragon_bone.lua

local a = {
	hero_dragon_bone_hero_walk = {
		prefix = "hero_dragon_bone_hero",
		to = 20,
		from = 1
	},
	hero_dragon_bone_hero_attack = {
		prefix = "hero_dragon_bone_hero",
		to = 54,
		from = 21
	},
	hero_dragon_bone_hero_breath = {
		prefix = "hero_dragon_bone_hero",
		to = 94,
		from = 55
	},
	hero_dragon_bone_hero_nova = {
		prefix = "hero_dragon_bone_hero",
		to = 130,
		from = 95
	},
	hero_dragon_bone_hero_bone_rain = {
		prefix = "hero_dragon_bone_hero",
		to = 170,
		from = 131
	},
	hero_dragon_bone_hero_burst = {
		prefix = "hero_dragon_bone_hero",
		to = 250,
		from = 171
	},
	hero_dragon_bone_hero_death = {
		prefix = "hero_dragon_bone_hero",
		to = 288,
		from = 251
	},
	hero_dragon_bone_hero_respawn = {
		prefix = "hero_dragon_bone_hero",
		to = 326,
		from = 289
	},
	hero_dragon_bone_hero_lvlup = {
		prefix = "hero_dragon_bone_hero",
		to = 346,
		from = 327
	},
	hero_dragon_bone_shadow = {
		prefix = "hero_dragon_bone_shadow",
		to = 1,
		from = 1
	},
	hero_dragon_bone_projectile_trail_idle = {
		prefix = "hero_dragon_bone_projectile_trail",
		to = 8,
		from = 1
	},
	hero_dragon_bone_projectile_idle = {
		prefix = "hero_dragon_bone_projectile",
		to = 10,
		from = 1
	},
	hero_dragon_bone_hit_idle = {
		prefix = "hero_dragon_bone_hit",
		to = 22,
		from = 1
	},
	hero_dragon_bone_hit_air_idle = {
		prefix = "hero_dragon_bone_hit_air",
		to = 18,
		from = 1
	},
	hero_dragon_bone_plague_fx_idle = {
		prefix = "hero_dragon_bone_plague_fx",
		to = 26,
		from = 1
	},
	hero_dragon_bone_plague_explosion_idle = {
		prefix = "hero_dragon_bone_plague_explosion",
		to = 18,
		from = 1
	},
	hero_dragon_bone_breath_idle = {
		prefix = "hero_dragon_bone_breath",
		to = 42,
		from = 1
	},
	hero_dragon_bone_cloud_idle = {
		prefix = "hero_dragon_bone_cloud",
		to = 48,
		from = 1
	},
	hero_dragon_bone_cloud_b_bubbles_idle = {
		prefix = "hero_dragon_bone_cloud_b_bubbles",
		to = 60,
		from = 1
	},
	hero_dragon_bone_cloud_b = {
		prefix = "hero_dragon_bone_cloud_b",
		to = 1,
		from = 1
	},
	hero_dragon_bone_cloud_decal_idle = {
		prefix = "hero_dragon_bone_cloud_decal",
		to = 60,
		from = 1
	},
	hero_dragon_bone_bones_decal = {
		prefix = "hero_dragon_bone_bones_decal",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_fx_idle = {
		prefix = "hero_dragon_bone_bones_fx",
		to = 18,
		from = 1
	},
	hero_dragon_bone_bones_despawn_fx_idle = {
		prefix = "hero_dragon_bone_bones_despawn_fx",
		to = 18,
		from = 1
	},
	hero_dragon_bone_bones_a_green_air = {
		prefix = "hero_dragon_bone_bones_a_green_air",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_a_green_ground = {
		prefix = "hero_dragon_bone_bones_a_green_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_a_ground = {
		prefix = "hero_dragon_bone_bones_a_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_b_green_air = {
		prefix = "hero_dragon_bone_bones_b_green_air",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_b_green_ground = {
		prefix = "hero_dragon_bone_bones_b_green_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_b_ground = {
		prefix = "hero_dragon_bone_bones_b_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_c_green_air = {
		prefix = "hero_dragon_bone_bones_c_green_air",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_c_green_ground = {
		prefix = "hero_dragon_bone_bones_c_green_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_bones_c_ground = {
		prefix = "hero_dragon_bone_bones_c_ground",
		to = 1,
		from = 1
	},
	hero_dragon_bone_burst_projectile_idle = {
		prefix = "hero_dragon_bone_burst_projectile",
		to = 6,
		from = 1
	},
	hero_dragon_bone_burst_projectile_trail_idle = {
		prefix = "hero_dragon_bone_burst_projectile_trail",
		to = 14,
		from = 1
	},
	hero_dragon_bone_drake_idle = {
		prefix = "hero_dragon_bone_drake",
		to = 1,
		from = 1
	},
	hero_dragon_bone_drake_walk = {
		prefix = "hero_dragon_bone_drake",
		to = 11,
		from = 2
	},
	hero_dragon_bone_drake_attack = {
		prefix = "hero_dragon_bone_drake",
		to = 37,
		from = 12
	},
	hero_dragon_bone_drake_death = {
		prefix = "hero_dragon_bone_drake",
		to = 71,
		from = 38
	},
	hero_dragon_bone_drake_spawn_fx_idle = {
		prefix = "hero_dragon_bone_drake_spawn_fx",
		to = 24,
		from = 1
	},
	hero_dragon_bone_drake_hit_fx_idle = {
		prefix = "hero_dragon_bone_drake_hit_fx",
		to = 10,
		from = 1
	},
	hero_dragon_bone_hero_idle = {
		prefix = "hero_dragon_bone_hero",
		to = 20,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_dragon_bone.lua

-- BEGIN kr3/data/animations/hero_dragon_gem.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_dragon_gem.lua

local a = {
	hero_evil_dragon_hero_walk = {
		prefix = "hero_evil_dragon_hero",
		to = 20,
		from = 1
	},
	hero_evil_dragon_hero_attack = {
		prefix = "hero_evil_dragon_hero",
		to = 54,
		from = 21
	},
	hero_evil_dragon_hero_breath = {
		prefix = "hero_evil_dragon_hero",
		to = 94,
		from = 55
	},
	hero_evil_dragon_hero_red_death = {
		prefix = "hero_evil_dragon_hero",
		to = 146,
		from = 95
	},
	hero_evil_dragon_hero_conduit = {
		prefix = "hero_evil_dragon_hero",
		to = 184,
		from = 147
	},
	hero_evil_dragon_hero_shards = {
		prefix = "hero_evil_dragon_hero",
		to = 228,
		from = 185
	},
	hero_evil_dragon_hero_death_dragon = {
		prefix = "hero_evil_dragon_hero",
		to = 281,
		from = 229
	},
	hero_evil_dragon_hero_death_crystals = {
		prefix = "hero_evil_dragon_hero",
		to = 340,
		from = 282
	},
	hero_evil_dragon_hero_respawn_dragon = {
		prefix = "hero_evil_dragon_hero",
		to = 391,
		from = 341
	},
	hero_evil_dragon_hero_respawn_crystals = {
		prefix = "hero_evil_dragon_hero",
		to = 441,
		from = 392
	},
	hero_evil_dragon_hero_lvlup = {
		prefix = "hero_evil_dragon_hero",
		to = 461,
		from = 442
	},
	hero_evil_dragon_ultimate_crystal_a_idle = {
		prefix = "hero_evil_dragon_ultimate_crystal_a",
		to = 20,
		from = 1
	},
	hero_evil_dragon_ultimate_crystal_b = {
		prefix = "hero_evil_dragon_ultimate_crystal_b",
		to = 1,
		from = 1
	},
	hero_evil_dragon_ultimate_projectile = {
		prefix = "hero_evil_dragon_ultimate_projectile",
		to = 1,
		from = 1
	},
	hero_evil_dragon_ultimate_fx_a_idle = {
		prefix = "hero_evil_dragon_ultimate_fx_a",
		to = 10,
		from = 1
	},
	hero_evil_dragon_ultimate_fx_b_idle = {
		prefix = "hero_evil_dragon_ultimate_fx_b",
		to = 16,
		from = 1
	},
	hero_evil_dragon_shards_idle = {
		prefix = "hero_evil_dragon_shards",
		to = 20,
		from = 1
	},
	hero_evil_dragon_conduit_idle_fx_loop = {
		prefix = "hero_evil_dragon_conduit_idle_fx",
		to = 32,
		from = 1
	},
	hero_evil_dragon_conduit_spawn = {
		prefix = "hero_evil_dragon_conduit",
		to = 14,
		from = 1
	},
	hero_evil_dragon_conduit_idle = {
		prefix = "hero_evil_dragon_conduit",
		to = 15,
		from = 15
	},
	hero_evil_dragon_conduit_shock = {
		prefix = "hero_evil_dragon_conduit",
		to = 27,
		from = 16
	},
	hero_evil_dragon_conduit_floor_fx_idle = {
		prefix = "hero_evil_dragon_conduit_floor_fx",
		to = 1,
		from = 1
	},
	hero_evil_dragon_conduit_projectile_idle = {
		prefix = "hero_evil_dragon_conduit_projectile",
		to = 12,
		from = 1
	},
	hero_evil_dragon_red_death_crystal_start = {
		prefix = "hero_evil_dragon_red_death_crystal",
		to = 20,
		from = 1
	},
	hero_evil_dragon_red_death_crystal_idle = {
		prefix = "hero_evil_dragon_red_death_crystal",
		to = 21,
		from = 21
	},
	hero_evil_dragon_red_death_crystal_explosion = {
		prefix = "hero_evil_dragon_red_death_crystal",
		to = 71,
		from = 22
	},
	hero_evil_dragon_breath_cloud_idle = {
		prefix = "hero_evil_dragon_breath_cloud",
		to = 52,
		from = 1
	},
	hero_evil_dragon_breath_idle = {
		prefix = "hero_evil_dragon_breath",
		to = 42,
		from = 1
	},
	hero_evil_dragon_breath_crystal_big_start = {
		prefix = "hero_evil_dragon_breath_crystal_big",
		to = 18,
		from = 1
	},
	hero_evil_dragon_breath_crystal_big_idle = {
		prefix = "hero_evil_dragon_breath_crystal_big",
		to = 19,
		from = 19
	},
	hero_evil_dragon_breath_crystal_big_end = {
		prefix = "hero_evil_dragon_breath_crystal_big",
		to = 29,
		from = 20
	},
	hero_evil_dragon_breath_crystal_small_start = {
		prefix = "hero_evil_dragon_breath_crystal_small",
		to = 18,
		from = 1
	},
	hero_evil_dragon_breath_crystal_small_idle = {
		prefix = "hero_evil_dragon_breath_crystal_small",
		to = 19,
		from = 19
	},
	hero_evil_dragon_breath_crystal_small_end = {
		prefix = "hero_evil_dragon_breath_crystal_small",
		to = 29,
		from = 20
	},
	hero_evil_dragon_breath_crystal_medium_start = {
		prefix = "hero_evil_dragon_breath_crystal_medium",
		to = 18,
		from = 1
	},
	hero_evil_dragon_breath_crystal_medium_idle = {
		prefix = "hero_evil_dragon_breath_crystal_medium",
		to = 19,
		from = 19
	},
	hero_evil_dragon_breath_crystal_medium_end = {
		prefix = "hero_evil_dragon_breath_crystal_medium",
		to = 29,
		from = 20
	},
	hero_evil_dragon_passive_loop = {
		prefix = "hero_evil_dragon_passive",
		to = 30,
		from = 1
	},
	hero_evil_dragon_decal = {
		prefix = "hero_evil_dragon_decal",
		to = 1,
		from = 1
	},
	hero_evil_dragon_attack_fx_idle = {
		prefix = "hero_evil_dragon_attack_fx",
		to = 21,
		from = 1
	},
	hero_evil_dragon_area_damage_fx_idle = {
		prefix = "hero_evil_dragon_area_damage_fx",
		to = 1,
		from = 1
	},
	hero_evil_dragon_attack_projectile_trail_idle = {
		prefix = "hero_evil_dragon_attack_projectile_trail",
		to = 14,
		from = 1
	},
	hero_evil_dragon_attack_projectile_idle = {
		prefix = "hero_evil_dragon_attack_projectile",
		to = 10,
		from = 1
	},
	hero_evil_dragon_attack_fx_air_idle = {
		prefix = "hero_evil_dragon_attack_fx_air",
		to = 18,
		from = 1
	},
	hero_evil_dragon_hero_idle = {
		prefix = "hero_evil_dragon_hero",
		to = 20,
		from = 1
	},
	hero_dragon_gem_shadow = {
		prefix = "hero_dragon_gem_shadow",
		to = 1,
		from = 1
	},
	hero_evil_dragon_attack_projectile_flying = {
		prefix = "hero_evil_dragon_attack_projectile",
		to = 10,
		from = 1
	},
	hero_evil_dragon_breath_crystal_big_loop = {
		prefix = "hero_evil_dragon_breath_crystal_big",
		to = 19,
		from = 19
	},
	hero_evil_dragon_breath_crystal_small_loop = {
		prefix = "hero_evil_dragon_breath_crystal_small",
		to = 19,
		from = 19
	},
	hero_evil_dragon_breath_crystal_medium_loop = {
		prefix = "hero_evil_dragon_breath_crystal_medium",
		to = 19,
		from = 19
	},
	hero_evil_dragon_shards_start = {
		prefix = "hero_evil_dragon_shards",
		to = 10,
		from = 1
	},
	hero_evil_dragon_shards_idle = {
		prefix = "hero_evil_dragon_shards",
		to = 11,
		from = 11
	},
	hero_evil_dragon_shards_end = {
		prefix = "hero_evil_dragon_shards",
		to = 20,
		from = 12
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_dragon_gem.lua

-- BEGIN kr3/data/animations/hero_hunter.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_hunter.lua

local a = {
	dante_Idle = {
		prefix = "dante",
		to = 22,
		from = 1
	},
	dante_summon = {
		prefix = "dante",
		to = 44,
		from = 23
	},
	dante_shoot = {
		prefix = "dante",
		to = 74,
		from = 45
	},
	dante_shoot_diagonal = {
		prefix = "dante",
		to = 104,
		from = 75
	},
	dante_shoot_diagonal_back = {
		prefix = "dante",
		to = 136,
		from = 105
	},
	dante_leave = {
		prefix = "dante",
		to = 162,
		from = 137
	},
	dante_decal_Idle = {
		prefix = "dante_decal",
		to = 42,
		from = 1
	},
	argent_storm_decal_run = {
		prefix = "argent_storm_decal",
		to = 16,
		from = 1
	},
	mist_run_trail_run = {
		prefix = "mist_run_trail",
		to = 14,
		from = 1
	},
	anya_idle = {
		prefix = "anya",
		to = 25,
		from = 1
	},
	anya_run = {
		prefix = "anya",
		to = 43,
		from = 26
	},
	anya_aim_start = {
		prefix = "anya",
		to = 56,
		from = 44
	},
	anya_aim_side = {
		prefix = "anya",
		to = 70,
		from = 57
	},
	anya_aim_diagonal = {
		prefix = "anya",
		to = 84,
		from = 71
	},
	anya_aim_down = {
		prefix = "anya",
		to = 98,
		from = 85
	},
	anya_aim_diagonal_up = {
		prefix = "anya",
		to = 112,
		from = 99
	},
	anya_aim_up = {
		prefix = "anya",
		to = 126,
		from = 113
	},
	anya_shoot_side = {
		prefix = "anya",
		to = 145,
		from = 127
	},
	anya_shoot_diagonal = {
		prefix = "anya",
		to = 164,
		from = 146
	},
	anya_shoot_down = {
		prefix = "anya",
		to = 183,
		from = 165
	},
	anya_shoot_diagonal_up = {
		prefix = "anya",
		to = 202,
		from = 184
	},
	anya_shoot_up = {
		prefix = "anya",
		to = 221,
		from = 203
	},
	anya_shoot_backtoidle = {
		prefix = "anya",
		to = 237,
		from = 222
	},
	anya_melee_loop = {
		prefix = "anya",
		to = 260,
		from = 238
	},
	anya_skill1 = {
		prefix = "anya",
		to = 299,
		from = 261
	},
	anya_mist_run_in = {
		prefix = "anya",
		to = 317,
		from = 300
	},
	anya_mist_run_loop = {
		prefix = "anya",
		to = 327,
		from = 318
	},
	anya_mist_run_end = {
		prefix = "anya",
		to = 347,
		from = 328
	},
	anya_miststep_in = {
		prefix = "anya",
		to = 365,
		from = 348
	},
	anya_miststep_loop = {
		prefix = "anya",
		to = 374,
		from = 366
	},
	anya_miststep_end = {
		prefix = "anya",
		to = 384,
		from = 375
	},
	anya_argent_storm_in = {
		prefix = "anya",
		to = 405,
		from = 385
	},
	anya_argent_storm_loop = {
		prefix = "anya",
		to = 425,
		from = 406
	},
	anya_argent_storm_out = {
		prefix = "anya",
		to = 465,
		from = 426
	},
	anya_lvl_up = {
		prefix = "anya",
		to = 487,
		from = 466
	},
	anya_death = {
		prefix = "anya",
		to = 525,
		from = 488
	},
	anya_death_reviveme = {
		prefix = "anya",
		to = 551,
		from = 526
	},
	anya_dusk_beasts = {
		prefix = "anya",
		to = 573,
		from = 552
	},
	duskbeast_coin_run = {
		prefix = "duskbeast_coin",
		to = 20,
		from = 1
	},
	duskbeast_spawn = {
		prefix = "duskbeast",
		to = 16,
		from = 1
	},
	duskbeast_fly = {
		prefix = "duskbeast",
		to = 24,
		from = 17
	},
	duskbeast_attack = {
		prefix = "duskbeast",
		to = 44,
		from = 25
	},
	duskbeast_leave = {
		prefix = "duskbeast",
		to = 52,
		from = 45
	},
	hit_dante_run = {
		prefix = "hit_dante",
		to = 27,
		from = 1
	},
	shothit_run = {
		prefix = "shothit",
		to = 10,
		from = 1
	},
	mistystep_hit_run = {
		prefix = "mistystep_hit",
		to = 10,
		from = 1
	},
	mistystep_trailbetweenclones_run = {
		prefix = "mistystep_trailbetweenclones",
		to = 12,
		from = 1
	},
	mistystep_clone3_run = {
		prefix = "mistystep_clone3",
		to = 12,
		from = 1
	},
	mistystep_clone2_run = {
		prefix = "mistystep_clone2",
		to = 12,
		from = 1
	},
	mistystep_clone1_run = {
		prefix = "mistystep_clone1",
		to = 12,
		from = 1
	},
	anya_respawn = {
		prefix = "anya",
		to = 487,
		from = 466
	},
	anya_death = {
		prefix = "anya",
		to = 551,
		from = 488
	},
	dante_idle = {
		prefix = "dante",
		to = 22,
		from = 1
	},
	dante_running = {
		prefix = "dante",
		to = 22,
		from = 1
	},
	dante_death = {
		prefix = "dante",
		to = 162,
		from = 137
	},
	hit_dante_run = {
		prefix = "hit_dante",
		to = 22,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_hunter.lua

-- BEGIN kr3/data/animations/hero_lava.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_lava.lua

local a = {
	hero_lava_hero_idle = {
		prefix = "hero_lava_hero",
		to = 28,
		from = 1
	},
	hero_lava_hero_walk = {
		prefix = "hero_lava_hero",
		to = 52,
		from = 29
	},
	hero_lava_hero_melee_attack = {
		prefix = "hero_lava_hero",
		to = 92,
		from = 53
	},
	hero_lava_hero_skill_1 = {
		prefix = "hero_lava_hero",
		to = 156,
		from = 93
	},
	hero_lava_hero_skill_2 = {
		prefix = "hero_lava_hero",
		to = 196,
		from = 168
	},
	hero_lava_hero_skill_3 = {
		prefix = "hero_lava_hero",
		to = 246,
		from = 197
	},
	hero_lava_hero_skill_4_in = {
		prefix = "hero_lava_hero",
		to = 266,
		from = 247
	},
	hero_lava_hero_skill_4_loop = {
		prefix = "hero_lava_hero",
		to = 278,
		from = 267
	},
	hero_lava_hero_skill_4_out = {
		prefix = "hero_lava_hero",
		to = 304,
		from = 279
	},
	hero_lava_hero_ultimate = {
		prefix = "hero_lava_hero",
		to = 342,
		from = 305
	},
	hero_lava_hero_level_up = {
		prefix = "hero_lava_hero",
		to = 372,
		from = 343
	},
	hero_lava_hero_death = {
		prefix = "hero_lava_hero",
		to = 410,
		from = 373
	},
	hero_lava_hero_death_idle = {
		prefix = "hero_lava_hero",
		to = 424,
		from = 411
	},
	hero_lava_hero_death_walk = {
		prefix = "hero_lava_hero",
		to = 436,
		from = 425
	},
	hero_lava_hero_respawn = {
		prefix = "hero_lava_hero",
		to = 460,
		from = 439
	},
	hero_lava_respawn_tower_FX_in = {
		prefix = "hero_lava_respawn_tower_FX",
		to = 23,
		from = 1
	},
	hero_lava_respawn_tower_FX_idle = {
		prefix = "hero_lava_respawn_tower_FX",
		to = 52,
		from = 24
	},
	hero_lava_respawn_tower_FX_out = {
		prefix = "hero_lava_respawn_tower_FX",
		to = 66,
		from = 53
	},
	hero_lava_ultimate_particle = {
		prefix = "hero_lava_ultimate_particle",
		to = 10,
		from = 1
	},
	hero_lava_ultimate_projectile_idle = {
		prefix = "hero_lava_ultimate_projectile",
		to = 8,
		from = 1
	},
	hero_lava_ultimate_decal = {
		prefix = "hero_lava_ultimate_decal",
		to = 1,
		from = 1
	},
	hero_lava_ultimate_hit = {
		prefix = "hero_lava_ultimate_hit",
		to = 27,
		from = 1
	},
	hero_lava_skill_4_hit = {
		prefix = "hero_lava_skill_4_hit",
		to = 11,
		from = 1
	},
	hero_lava_skill_3_double_idle = {
		prefix = "hero_lava_skill_3_double",
		to = 14,
		from = 1
	},
	hero_lava_skill_3_double_spawn = {
		prefix = "hero_lava_skill_3_double",
		to = 37,
		from = 15
	},
	hero_lava_skill_3_double_walk = {
		prefix = "hero_lava_skill_3_double",
		to = 51,
		from = 38
	},
	hero_lava_skill_3_double_attack = {
		prefix = "hero_lava_skill_3_double",
		to = 87,
		from = 52
	},
	hero_lava_skill_3_double_death = {
		prefix = "hero_lava_skill_3_double",
		to = 113,
		from = 88
	},
	hero_lava_skill_3_particle_idle = {
		prefix = "hero_lava_skill_3_particle",
		to = 10,
		from = 1
	},
	hero_lava_skill_3_projectile_idle = {
		prefix = "hero_lava_skill_3_projectile",
		to = 8,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_lava.lua

-- BEGIN kr3/data/animations/hero_mecha.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_mecha.lua

local a = {
	hero_onagro_ultimate_layerX_idle = {
		layer_to = 5,
		from = 1,
		layer_prefix = "hero_onagro_ultimate_layer%i",
		to = 8,
		layer_from = 1
	},
	hero_onagro_ultimate_layerX_attack = {
		layer_to = 5,
		from = 9,
		layer_prefix = "hero_onagro_ultimate_layer%i",
		to = 24,
		layer_from = 1
	},
	hero_onagro_ultimate_projectile = {
		prefix = "hero_onagro_ultimate_projectile",
		to = 1,
		from = 1
	},
	hero_onagro_ultimate_hit_idle = {
		prefix = "hero_onagro_ultimate_hit",
		to = 21,
		from = 1
	},
	hero_onagro_attack_projectile_idle = {
		prefix = "hero_onagro_attack_projectile",
		to = 3,
		from = 1
	},
	hero_onagro_attack_1_cannon_particle_idle = {
		prefix = "hero_onagro_attack_1_cannon_particle",
		to = 21,
		from = 1
	},
	hero_onagro_attack_2_cannon_particle_idle = {
		prefix = "hero_onagro_attack_2_cannon_particle",
		to = 21,
		from = 1
	},
	hero_onagro_attack_particle_idle = {
		prefix = "hero_onagro_attack_particle",
		to = 9,
		from = 1
	},
	hero_onagro_attack_1_hit_idle = {
		prefix = "hero_onagro_attack_1_hit",
		to = 18,
		from = 1
	},
	hero_onagro_attack_2_hit_idle = {
		prefix = "hero_onagro_attack_2_hit",
		to = 6,
		from = 1
	},
	hero_onagro_skill_1_drone_idle = {
		prefix = "hero_onagro_skill_1_drone",
		to = 12,
		from = 1
	},
	hero_onagro_skill_1_drone_attack = {
		prefix = "hero_onagro_skill_1_drone",
		to = 24,
		from = 13
	},
	hero_onagro_skill_1_drone_hit_fx_idle = {
		prefix = "hero_onagro_skill_1_drone_hit_fx",
		to = 9,
		from = 1
	},
	hero_onagro_skill_2_projectile = {
		prefix = "hero_onagro_skill_2_projectile",
		to = 8,
		from = 1
	},
	hero_onagro_skill_2_hit = {
		prefix = "hero_onagro_skill_2_hit",
		to = 10,
		from = 1
	},
	hero_onagro_skill_2_decal = {
		prefix = "hero_onagro_skill_2_decal",
		to = 4,
		from = 1
	},
	hero_onagro_skill_4_mine_in = {
		prefix = "hero_onagro_skill_4_mine",
		to = 10,
		from = 1
	},
	hero_onagro_skill_4_mine_idle = {
		prefix = "hero_onagro_skill_4_mine",
		to = 38,
		from = 11
	},
	hero_onagro_skill_4_mine_on = {
		prefix = "hero_onagro_skill_4_mine",
		to = 60,
		from = 39
	},
	hero_onagro_skill_4_mine_projectile = {
		prefix = "hero_onagro_skill_4_mine_projectile",
		to = 1,
		from = 1
	},
	hero_onagro_skill_4_mine_explosion_idle = {
		prefix = "hero_onagro_skill_4_mine_explosion",
		to = 21,
		from = 1
	},
	hero_onagro_back_smoke_particle_idle = {
		prefix = "hero_onagro_back_smoke_particle",
		to = 35,
		from = 1
	},
	hero_onagro_fire_particle_idle = {
		prefix = "asst_flame",
		to = 31,
		from = 8
	},
	hero_onagro_hero_idle = {
		prefix = "hero_onagro_hero",
		to = 10,
		from = 1
	},
	hero_onagro_hero_walk = {
		prefix = "hero_onagro_hero",
		to = 42,
		from = 11
	},
	hero_onagro_hero_attack_1 = {
		prefix = "hero_onagro_hero",
		to = 61,
		from = 43
	},
	hero_onagro_hero_attack_2 = {
		prefix = "hero_onagro_hero",
		to = 80,
		from = 62
	},
	hero_onagro_hero_skill_1 = {
		prefix = "hero_onagro_hero",
		to = 130,
		from = 81
	},
	hero_onagro_hero_skill_2 = {
		prefix = "hero_onagro_hero",
		to = 180,
		from = 131
	},
	hero_onagro_hero_skill_3 = {
		prefix = "hero_onagro_hero",
		to = 245,
		from = 181
	},
	hero_onagro_hero_skill_4 = {
		prefix = "hero_onagro_hero",
		to = 295,
		from = 246
	},
	hero_onagro_hero_respawn = {
		prefix = "hero_onagro_hero",
		to = 319,
		from = 296
	},
	hero_onagro_hero_death = {
		prefix = "hero_onagro_hero",
		to = 380,
		from = 320
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_mecha.lua

-- BEGIN kr3/data/animations/hero_murglun.lua
do
	local __chunk = (function()
return {
	hero_murglun_idle = {
		prefix = "hero_murglun",
		to = 19,
		from = 1
	},
	hero_murglun_attack = {
		prefix = "hero_murglun",
		to = 46,
		from = 20
	},
	hero_murglun_heatWave = {
		prefix = "hero_murglun",
		to = 98,
		from = 47
	},
	hero_murglun_geiser = {
		prefix = "hero_murglun",
		to = 133,
		from = 99
	},
	hero_murglun_levelUp = {
		prefix = "hero_murglun",
		to = 173,
		from = 134
	},
	hero_murglun_death = {
		prefix = "hero_murglun",
		to = 213,
		from = 174
	},
	hero_murglun_respawn = {
		prefix = "hero_murglun",
		to = 264,
		from = 214
	},
	hero_murglun_attack_explotion_run = {
		prefix = "hero_murglun_attack_explotion",
		to = 18,
		from = 1
	},
	hero_murglun_attack_explotion_basic_run = {
		prefix = "hero_murglun_attack_explotion_basic",
		to = 19,
		from = 1
	},
	hero_murglun_attack_particle_run = {
		prefix = "hero_murglun_attack_particle",
		to = 10,
		from = 1
	},
	hero_murglun_death_smoke_run = {
		prefix = "hero_murglun_death_smoke",
		to = 32,
		from = 1
	},
	hero_murglun_geiser_run = {
		prefix = "hero_murglun_geiser",
		to = 34,
		from = 1
	},
	hero_murglun_geiser_death_run = {
		prefix = "hero_murglun_geiser_death",
		to = 28,
		from = 1
	},
	hero_murglun_geiser_full_run = {
		prefix = "hero_murglun_geiser_full",
		to = 34,
		from = 1
	},
	hero_murglun_heat_wave_fx1_run = {
		prefix = "hero_murglun_heat_wave_fx1",
		to = 28,
		from = 1
	},
	hero_murglun_heat_wave_fx2_in = {
		prefix = "hero_murglun_heat_wave_fx2",
		to = 27,
		from = 1
	},
	hero_murglun_heat_wave_fx2_run = {
		prefix = "hero_murglun_heat_wave_fx2",
		to = 60,
		from = 28
	},
	hero_murglun_lava_blood_explotion_run = {
		prefix = "hero_murglun_lava_blood_explotion",
		to = 10,
		from = 1
	},
	hero_murglun_tower_fx_run = {
		prefix = "hero_murglun_tower_fx",
		to = 16,
		from = 1
	},
	hero_murglun_ultimate_explotion_run = {
		prefix = "hero_murglun_ultimate_explotion",
		to = 24,
		from = 1
	},
	hero_murglun_ultimate_particle2_run = {
		prefix = "hero_murglun_ultimate_particle2",
		to = 23,
		from = 1
	},
	hero_murglun_ultimate_particle_run = {
		prefix = "hero_murglun_ultimate_particle",
		to = 23,
		from = 1
	},
	hero_murglun_ultimate_rocks_run = {
		prefix = "hero_murglun_ultimate_rocks",
		to = 33,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_murglun.lua

-- BEGIN kr3/data/animations/hero_muyrn.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_muyrn.lua

local a = {
	hero_nyru_muyrn_idle = {
		prefix = "hero_nyru_muyrn",
		to = 21,
		from = 1
	},
	hero_nyru_muyrn_running = {
		prefix = "hero_nyru_muyrn",
		to = 41,
		from = 22
	},
	hero_nyru_muyrn_walk_2_start = {
		prefix = "hero_nyru_muyrn",
		to = 51,
		from = 42
	},
	hero_nyru_muyrn_treewalk = {
		prefix = "hero_nyru_muyrn",
		to = 61,
		from = 52
	},
	hero_nyru_muyrn_treewalk_end = {
		prefix = "hero_nyru_muyrn",
		to = 71,
		from = 62
	},
	hero_nyru_muyrn_ranged_attack = {
		prefix = "hero_nyru_muyrn",
		to = 103,
		from = 72
	},
	hero_nyru_muyrn_melee_attack = {
		prefix = "hero_nyru_muyrn",
		to = 129,
		from = 104
	},
	hero_nyru_muyrn_sentinel_wisps = {
		prefix = "hero_nyru_muyrn",
		to = 167,
		from = 130
	},
	hero_nyru_muyrn_verdant_blast = {
		prefix = "hero_nyru_muyrn",
		to = 230,
		from = 168
	},
	hero_nyru_muyrn_root_defender = {
		prefix = "hero_nyru_muyrn",
		to = 262,
		from = 231
	},
	hero_nyru_muyrn_fairy_dust = {
		prefix = "hero_nyru_muyrn",
		to = 302,
		from = 263
	},
	hero_nyru_muyrn_levelup = {
		prefix = "hero_nyru_muyrn",
		to = 326,
		from = 303
	},
	hero_nyru_muyrn_respawn = {
		prefix = "hero_nyru_muyrn",
		to = 362,
		from = 327
	},
	hero_nyru_muyrn_death = {
		prefix = "hero_nyru_muyrn",
		to = 400,
		from = 363
	},
	hero_nyru_muyrn_grave = {
		prefix = "hero_nyru_muyrn",
		to = 401,
		from = 401
	},
	hero_nyru_faery_dust_nyru_decal = {
		prefix = "hero_nyru_faery_dust_nyru_decal",
		to = 19,
		from = 1
	},
	hero_nyru_fairy_dust_modifier = {
		prefix = "hero_nyru_fairy_dust_modifier",
		to = 19,
		from = 1
	},
	hero_nyru_fairy_dust_FX = {
		prefix = "hero_nyru_fairy_dust_FX",
		to = 26,
		from = 1
	},
	hero_nyru_fairy_dust_decal = {
		prefix = "hero_nyru_fairy_dust_decal",
		to = 29,
		from = 1
	},
	hero_nyru_walk2_roots_particle = {
		prefix = "hero_nyru_walk2_roots_particle",
		to = 11,
		from = 1
	},
	hero_nyru_ranged_attack_hit = {
		prefix = "hero_nyru_ranged_attack_hit",
		to = 15,
		from = 1
	},
	hero_nyru_ranged_attack_projectile_flying = {
		prefix = "hero_nyru_ranged_attack_projectile",
		to = 1,
		from = 1
	},
	hero_nyru_ranged_attack_particle = {
		prefix = "hero_nyru_ranged_attack_particle",
		to = 15,
		from = 1
	},
	hero_nyru_root_defender_root1_start = {
		prefix = "hero_nyru_root_defender_root1",
		to = 14,
		from = 1
	},
	hero_nyru_root_defender_root1_loop = {
		prefix = "hero_nyru_root_defender_root1",
		to = 22,
		from = 15
	},
	hero_nyru_root_defender_root1_end = {
		prefix = "hero_nyru_root_defender_root1",
		to = 31,
		from = 23
	},
	hero_nyru_root_defender_root2_start = {
		prefix = "hero_nyru_root_defender_root2",
		to = 16,
		from = 1
	},
	hero_nyru_root_defender_root2_loop = {
		prefix = "hero_nyru_root_defender_root2",
		to = 24,
		from = 17
	},
	hero_nyru_root_defender_root2_end = {
		prefix = "hero_nyru_root_defender_root2",
		to = 33,
		from = 25
	},
	hero_nyru_root_defender_root_3_start = {
		prefix = "hero_nyru_root_defender_root_3",
		to = 17,
		from = 1
	},
	hero_nyru_root_defender_root_3_loop = {
		prefix = "hero_nyru_root_defender_root_3",
		to = 22,
		from = 18
	},
	hero_nyru_root_defender_root_3_end = {
		prefix = "hero_nyru_root_defender_root_3",
		to = 38,
		from = 23
	},
	hero_nyru_verdant_blast_explosion_air = {
		prefix = "hero_nyru_verdant_blast_explosion_air",
		to = 19,
		from = 1
	},
	hero_nyru_verdant_blast_explosion_decal = {
		prefix = "hero_nyru_verdant_blast_explosion_decal",
		to = 19,
		from = 1
	},
	hero_nyru_verdant_blast_projectile_flying = {
		prefix = "hero_nyru_verdant_blast_projectile",
		to = 12,
		from = 1
	},
	hero_nyru_verdant_blast_particle = {
		prefix = "hero_nyru_verdant_blast_particle",
		to = 10,
		from = 1
	},
	hero_nyru_leaf_whirlwind_hit = {
		prefix = "hero_nyru_leaf_whirlwind_hit",
		to = 20,
		from = 1
	},
	hero_nyru_leaf_whirlwind_start = {
		prefix = "hero_nyru_leaf_whirlwind",
		to = 5,
		from = 1
	},
	hero_nyru_leaf_whirlwind_loop = {
		prefix = "hero_nyru_leaf_whirlwind",
		to = 25,
		from = 6
	},
	hero_nyru_leaf_whirlwind_end = {
		prefix = "hero_nyru_leaf_whirlwind",
		to = 56,
		from = 26
	},
	hero_nyru_sentinel_wisps_hit = {
		prefix = "hero_nyru_sentinel_wisps_hit",
		to = 7,
		from = 1
	},
	hero_nyru_sentinel_wisps_ray = {
		prefix = "hero_nyru_sentinel_wisps_ray",
		to = 11,
		from = 1
	},
	hero_nyru_sentinel_wisps_wisp_spawn = {
		prefix = "hero_nyru_sentinel_wisps_wisp",
		to = 9,
		from = 1
	},
	hero_nyru_sentinel_wisps_wisp_idle = {
		prefix = "hero_nyru_sentinel_wisps_wisp",
		to = 13,
		from = 10
	},
	hero_nyru_sentinel_wisps_wisp_attack = {
		prefix = "hero_nyru_sentinel_wisps_wisp",
		to = 25,
		from = 14
	},
	hero_nyru_sentinel_wisps_wisp_death = {
		prefix = "hero_nyru_sentinel_wisps_wisp",
		to = 38,
		from = 26
	},
	hero_nyru_sentinel_wisps_attack_attack = {
		prefix = "hero_nyru_sentinel_wisps_attack",
		to = 10,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_muyrn.lua

-- BEGIN kr3/data/animations/hero_raelyn_command_orders.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_raelyn_command_orders.lua

local a = {
	hero_raelyn_command_orders_dark_knight_idle = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 8,
		from = 1
	},
	hero_raelyn_command_orders_dark_knight_walk = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 38,
		from = 9
	},
	hero_raelyn_command_orders_dark_knight_attack_1 = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 60,
		from = 39
	},
	hero_raelyn_command_orders_dark_knight_attack_2 = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 78,
		from = 61
	},
	hero_raelyn_command_orders_dark_knight_attack_1_return_to_Idle = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 86,
		from = 79
	},
	hero_raelyn_command_orders_dark_knight_death = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 132,
		from = 87
	},
	hero_raelyn_command_orders_spawn_fx_Idle1_1 = {
		prefix = "hero_raelyn_command_orders_spawn_fx",
		to = 21,
		from = 1
	},
	hero_raelyn_command_orders_hit_fx_Idle1_1 = {
		prefix = "hero_raelyn_command_orders_hit_fx",
		to = 8,
		from = 1
	},
	hero_raelyn_command_orders_dark_knight_running = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 38,
		from = 9
	},
	hero_raelyn_command_orders_dark_knight_attack_1 = {
		prefix = "hero_raelyn_command_orders_dark_knight",
		to = 78,
		from = 39
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_raelyn_command_orders.lua

-- BEGIN kr3/data/animations/hero_robot.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_robot.lua

local a = {
	Blaze_tren = {
		prefix = "Blaze_tren",
		to = 70,
		from = 1
	},
	Blaze_trendecal_run = {
		prefix = "Blaze_trendecal",
		to = 8,
		from = 1
	},
	Blaze_skill3status_run = {
		prefix = "Blaze_skill3status",
		to = 10,
		from = 1
	},
	Blaze_skill3decal_decal = {
		prefix = "Blaze_skill3decal",
		to = 1,
		from = 1
	},
	Blaze_skill1y3decal_run = {
		prefix = "Blaze_skill1y3decal",
		to = 8,
		from = 1
	},
	Blaze_skill1humito_run = {
		prefix = "Blaze_skill1humito",
		to = 22,
		from = 1
	},
	Blaze_skill2proyectil_proyectile = {
		prefix = "Blaze_skill2proyectil",
		to = 1,
		from = 1
	},
	Blaze_skill2humostatus_loop = {
		prefix = "Blaze_skill2humostatus",
		to = 40,
		from = 1
	},
	Blaze_skill2humo_start = {
		prefix = "Blaze_skill2humo",
		to = 31,
		from = 1
	},
	Blaze_skill2humo_loop = {
		prefix = "Blaze_skill2humo",
		to = 85,
		from = 32
	},
	Blaze_skill2humo_run = {
		prefix = "Blaze_skill2humo",
		to = 89,
		from = 86
	},
	Blaze_skill2explosion_run = {
		prefix = "Blaze_skill2explosion",
		to = 20,
		from = 1
	},
	Blaze_humitodeatras_run = {
		prefix = "Blaze_humitodeatras",
		to = 15,
		from = 1
	},
	Blaze_pibe_idle = {
		prefix = "Blaze_pibe",
		to = 12,
		from = 1
	},
	Blaze_pibe_attack = {
		prefix = "Blaze_pibe",
		to = 43,
		from = 13
	},
	Blaze_pibe_walk = {
		prefix = "Blaze_pibe",
		to = 67,
		from = 44
	},
	Blaze_pibe_skill1start = {
		prefix = "Blaze_pibe",
		to = 74,
		from = 68
	},
	Blaze_pibe_skill1 = {
		prefix = "Blaze_pibe",
		to = 109,
		from = 75
	},
	Blaze_pibe_skill2 = {
		prefix = "Blaze_pibe",
		to = 161,
		from = 110
	},
	Blaze_pibe_skill3 = {
		prefix = "Blaze_pibe",
		to = 204,
		from = 162
	},
	Blaze_pibe_skill4 = {
		prefix = "Blaze_pibe",
		to = 258,
		from = 205
	},
	Blaze_pibe_death = {
		prefix = "Blaze_pibe",
		to = 334,
		from = 259
	},
	Blaze_pibe_respawn = {
		prefix = "Blaze_pibe",
		to = 357,
		from = 335
	},
	Blaze_pibe_passivestart = {
		prefix = "Blaze_pibe",
		to = 361,
		from = 358
	},
	Blaze_pibe_passivein = {
		prefix = "Blaze_pibe",
		to = 383,
		from = 362
	},
	Blaze_pibe_passiveloop = {
		prefix = "Blaze_pibe",
		to = 391,
		from = 384
	},
	Blaze_pibe_passiveout = {
		prefix = "Blaze_pibe",
		to = 401,
		from = 392
	},
	Blaze_pibe_flystart = {
		prefix = "Blaze_pibe",
		to = 383,
		from = 358
	},
	Blaze_skill3decal = {
		prefix = "Blaze_skill3decal",
		to = 1,
		from = 1
	},
	Blaze_skill2proyectil = {
		prefix = "Blaze_skill2proyectil",
		to = 1,
		from = 1
	},
	Blaze_tren_down = {
		prefix = "Blaze_tren",
		to = 8,
		from = 1
	},
	Blaze_tren_downright = {
		prefix = "Blaze_tren",
		to = 16,
		from = 9
	},
	Blaze_tren_right = {
		prefix = "Blaze_tren",
		to = 24,
		from = 17
	},
	Blaze_tren_upright = {
		prefix = "Blaze_tren",
		to = 32,
		from = 25
	},
	Blaze_tren_up = {
		prefix = "Blaze_tren",
		to = 40,
		from = 33
	},
	Blaze_tren_box = {
		prefix = "Blaze_tren",
		to = 70,
		from = 41
	},
	Blaze_trendecal_run = {
		prefix = "Blaze_trendecal",
		to = 7,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_robot.lua

-- BEGIN kr3/data/animations/hero_space_elf.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_space_elf.lua

local a = {
	hero_therien_therien_idle = {
		prefix = "hero_therien_therien",
		to = 24,
		from = 1
	},
	hero_therien_therien_to_walk = {
		prefix = "hero_therien_therien",
		to = 38,
		from = 25
	},
	hero_therien_therien_walk = {
		prefix = "hero_therien_therien",
		to = 62,
		from = 39
	},
	hero_therien_therien_to_idle = {
		prefix = "hero_therien_therien",
		to = 74,
		from = 63
	},
	hero_therien_therien_ability1 = {
		prefix = "hero_therien_therien",
		to = 104,
		from = 75
	},
	hero_therien_therien_ability2 = {
		prefix = "hero_therien_therien",
		to = 133,
		from = 105
	},
	hero_therien_therien_lvlup = {
		prefix = "hero_therien_therien",
		to = 167,
		from = 134
	},
	hero_therien_therien_ability3 = {
		prefix = "hero_therien_therien",
		to = 200,
		from = 168
	},
	hero_therien_therien_out = {
		prefix = "hero_therien_therien",
		to = 216,
		from = 201
	},
	hero_therien_therien_in = {
		prefix = "hero_therien_therien",
		to = 235,
		from = 217
	},
	hero_therien_therien_ability4 = {
		prefix = "hero_therien_therien",
		to = 268,
		from = 236
	},
	hero_therien_therien_ability5 = {
		prefix = "hero_therien_therien",
		to = 298,
		from = 269
	},
	hero_therien_therien_ability6 = {
		prefix = "hero_therien_therien",
		to = 348,
		from = 299
	},
	hero_therien_therien_death = {
		prefix = "hero_therien_therien",
		to = 424,
		from = 349
	},
	hero_therien_rift_fx_decalbrillo = {
		prefix = "hero_therien_rift_fx_decalbrillo",
		to = 69,
		from = 1
	},
	hero_therien_rift_fx_decal2 = {
		prefix = "hero_therien_rift_fx_decal2",
		to = 69,
		from = 1
	},
	hero_therien_rift_fx_decal = {
		prefix = "hero_therien_rift_fx_decal",
		to = 69,
		from = 1
	},
	hero_therien_void_prison_fx_small_in = {
		prefix = "hero_therien_void_prison_fx_small",
		to = 26,
		from = 1
	},
	hero_therien_void_prison_fx_small_idle = {
		prefix = "hero_therien_void_prison_fx_small",
		to = 52,
		from = 27
	},
	hero_therien_void_prison_fx_small_out = {
		prefix = "hero_therien_void_prison_fx_small",
		to = 89,
		from = 53
	},
	hero_therien_void_prison_fx_big_in = {
		prefix = "hero_therien_void_prison_fx_big",
		to = 26,
		from = 1
	},
	hero_therien_void_prison_fx_big_idle = {
		prefix = "hero_therien_void_prison_fx_big",
		to = 52,
		from = 27
	},
	hero_therien_void_prison_fx_big_out = {
		prefix = "hero_therien_void_prison_fx_big",
		to = 89,
		from = 53
	},
	hero_therien_void_prison_floor_fx_idle = {
		prefix = "hero_therien_void_prison_floor_fx",
		to = 20,
		from = 1
	},
	hero_therien_rift_therien_fx_idle = {
		prefix = "hero_therien_rift_therien_fx",
		to = 24,
		from = 1
	},
	hero_therien_space_warp_idle = {
		prefix = "hero_therien_space_warp",
		to = 16,
		from = 1
	},
	hero_therien_black_aegis_hit = {
		prefix = "hero_therien_black_aegis_hit",
		to = 7,
		from = 1
	},
	hero_therien_black_aegis_bottom_big_idle = {
		prefix = "hero_therien_black_aegis_bottom_big",
		to = 1,
		from = 1
	},
	hero_therien_black_aegis_top_big_idle = {
		prefix = "hero_therien_black_aegis_top_big",
		to = 34,
		from = 1
	},
	hero_therien_black_aegis_bottom_small_idle = {
		prefix = "hero_therien_black_aegis_bottom_small",
		to = 1,
		from = 1
	},
	hero_therien_black_aegis_top_small_idle = {
		prefix = "hero_therien_black_aegis_top_small",
		to = 34,
		from = 1
	},
	hero_therien_melee_hit_idle = {
		prefix = "hero_therien_melee_hit",
		to = 7,
		from = 1
	},
	hero_therien_ranged_hit_idle = {
		prefix = "hero_therien_ranged_hit",
		to = 15,
		from = 1
	},
	hero_therien_reflection_ranged_particle = {
		prefix = "hero_therien_reflection_ranged_particle",
		to = 15,
		from = 1
	},
	hero_therien_reflection_ranged_proyectile = {
		prefix = "hero_therien_reflection_ranged_proyectile",
		to = 12,
		from = 1
	},
	hero_therien_ranged_proyectile_idle = {
		prefix = "hero_therien_ranged_proyectile",
		to = 12,
		from = 1
	},
	hero_therien_ranged_particle_idle = {
		prefix = "hero_therien_ranged_particle",
		to = 15,
		from = 1
	},
	hero_therien_reflection_spawn_fx_idle = {
		prefix = "hero_therien_reflection_spawn_fx",
		to = 32,
		from = 1
	},
	hero_therien_reflection_idle = {
		prefix = "hero_therien_reflection",
		to = 1,
		from = 1
	},
	hero_therien_reflection_ability1 = {
		prefix = "hero_therien_reflection",
		to = 18,
		from = 2
	},
	hero_therien_reflection_ability2 = {
		prefix = "hero_therien_reflection",
		to = 46,
		from = 19
	},
	hero_therien_reflection_ability3 = {
		prefix = "hero_therien_reflection",
		to = 61,
		from = 47
	},
	hero_therien_reflection_ability4 = {
		prefix = "hero_therien_reflection",
		to = 79,
		from = 62
	},
	hero_therien_reflection_ability5 = {
		prefix = "hero_therien_reflection",
		to = 92,
		from = 80
	},
	hero_therien_reflection_death = {
		prefix = "hero_therien_reflection",
		to = 111,
		from = 93
	},
	hero_therien_ranged_proyectile_flying = {
		prefix = "hero_therien_ranged_proyectile",
		to = 12,
		from = 1
	},
	hero_therien_black_aegis_top_big_in = {
		prefix = "hero_therien_black_aegis_top_big",
		to = 12,
		from = 1
	},
	hero_therien_black_aegis_top_big_idle = {
		prefix = "hero_therien_black_aegis_top_big",
		to = 28,
		from = 13
	},
	hero_therien_black_aegis_top_big_out = {
		prefix = "hero_therien_black_aegis_top_big",
		to = 41,
		from = 29
	},
	hero_therien_black_aegis_top_small_in = {
		prefix = "hero_therien_black_aegis_top_small",
		to = 12,
		from = 1
	},
	hero_therien_black_aegis_top_small_idle = {
		prefix = "hero_therien_black_aegis_top_small",
		to = 28,
		from = 13
	},
	hero_therien_black_aegis_top_small_out = {
		prefix = "hero_therien_black_aegis_top_small",
		to = 41,
		from = 29
	},
	hero_therien_therien_respawn = {
		prefix = "hero_therien_therien",
		to = 167,
		from = 134
	},
	hero_therien_rift_fx_decalbrillo_in = {
		prefix = "hero_therien_rift_fx_decalbrillo",
		to = 27,
		from = 1
	},
	hero_therien_rift_fx_decalbrillo_idle = {
		prefix = "hero_therien_rift_fx_decalbrillo",
		to = 61,
		from = 28
	},
	hero_therien_rift_fx_decalbrillo_out = {
		prefix = "hero_therien_rift_fx_decalbrillo",
		to = 69,
		from = 62
	},
	hero_therien_rift_fx_decal2_in = {
		prefix = "hero_therien_rift_fx_decal2",
		to = 27,
		from = 1
	},
	hero_therien_rift_fx_decal2_idle = {
		prefix = "hero_therien_rift_fx_decal2",
		to = 61,
		from = 28
	},
	hero_therien_rift_fx_decal2_out = {
		prefix = "hero_therien_rift_fx_decal2",
		to = 69,
		from = 62
	},
	hero_therien_rift_fx_decal_in = {
		prefix = "hero_therien_rift_fx_decal",
		to = 27,
		from = 1
	},
	hero_therien_rift_fx_decal_idle = {
		prefix = "hero_therien_rift_fx_decal",
		to = 61,
		from = 28
	},
	hero_therien_rift_fx_decal_out = {
		prefix = "hero_therien_rift_fx_decal",
		to = 69,
		from = 62
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_space_elf.lua

-- BEGIN kr3/data/animations/hero_spider.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_spider.lua

local a = {
	hero_spider_05_modifier_run = {
		prefix = "hero_spider_07_modifier",
		to = 27,
		from = 1
	},
	hero_spider_05_projectile_flying = {
		prefix = "hero_spider_05_projectile",
		to = 9,
		from = 1
	},
	hero_spider_05_dirt_explosion_teleport = {
		prefix = "hero_spider_05_dirt_explosion",
		to = 24,
		from = 1
	},
	hero_spider_05_dirt_explosion_spawn = {
		prefix = "hero_spider_05_dirt_explosion",
		to = 59,
		from = 25
	},
	hero_spider_05_spider_in_in = {
		prefix = "hero_spider_06_spider_in",
		to = 8,
		from = 1
	},
	hero_spider_05_spider_in_loop = {
		prefix = "hero_spider_06_spider_in",
		to = 9,
		from = 9
	},
	hero_spider_05_spider_in_out = {
		prefix = "hero_spider_06_spider_in",
		to = 17,
		from = 10
	},
	hero_spider_05_spider_idle = {
		prefix = "hero_spider_05_spider",
		to = 1,
		from = 1
	},
	hero_spider_05_spider_walk = {
		prefix = "hero_spider_05_spider",
		to = 10,
		from = 2
	},
	hero_spider_05_spider_attack = {
		prefix = "hero_spider_05_spider",
		to = 25,
		from = 11
	},
	hero_spider_05_spider_death = {
		prefix = "hero_spider_05_spider",
		to = 37,
		from = 26
	},
	hero_spider_05_hitfx_run = {
		prefix = "hero_spider_05_hitfx",
		to = 23,
		from = 1
	},
	hero_spider_05_trail_run = {
		prefix = "hero_spider_05_trail",
		to = 18,
		from = 1
	},
	hero_spider_05_stomp_run = {
		prefix = "hero_spider_05_stomp",
		to = 13,
		from = 1
	},
	hero_spider_05_instakill_run = {
		prefix = "hero_spider_05_instakill",
		to = 18,
		from = 1
	},
	hero_spider_05_mancha_spider = {
		prefix = "hero_spider_07_mancha_spider_in",
		to = 16,
		from = 1
	},
	hero_spider_05_hero_idle = {
		prefix = "hero_spider_07_hero",
		to = 36,
		from = 1
	},
	hero_spider_05_hero_walk = {
		prefix = "hero_spider_07_hero",
		to = 56,
		from = 37
	},
	hero_spider_05_hero_spell = {
		prefix = "hero_spider_07_hero",
		to = 96,
		from = 57
	},
	hero_spider_05_hero_ability1 = {
		prefix = "hero_spider_07_hero",
		to = 162,
		from = 97
	},
	hero_spider_05_hero_teleport_in = {
		prefix = "hero_spider_07_hero",
		to = 185,
		from = 163
	},
	hero_spider_05_hero_teleport_out = {
		prefix = "hero_spider_07_hero",
		to = 218,
		from = 186
	},
	hero_spider_05_hero_attack = {
		prefix = "hero_spider_07_hero",
		to = 255,
		from = 219
	},
	hero_spider_05_hero_hunter_in = {
		prefix = "hero_spider_07_hero",
		to = 292,
		from = 256
	},
	hero_spider_05_hero_hunter = {
		prefix = "hero_spider_07_hero",
		to = 315,
		from = 293
	},
	hero_spider_05_hero_hunter_out = {
		prefix = "hero_spider_07_hero",
		to = 342,
		from = 316
	},
	hero_spider_05_hero_level_up = {
		prefix = "hero_spider_07_hero",
		to = 376,
		from = 343
	},
	hero_spider_05_hero_respawn = {
		prefix = "hero_spider_07_hero",
		to = 399,
		from = 377
	},
	hero_spider_05_hero_death = {
		prefix = "hero_spider_07_hero",
		to = 477,
		from = 400
	},
	hero_spider_05_hero_ataqueB = {
		prefix = "hero_spider_07_hero",
		to = 523,
		from = 478
	},
	hero_spider_05_hero_kill = {
		prefix = "hero_spider_07_hero",
		to = 559,
		from = 524
	},
	hero_spider_05_hole_in = {
		prefix = "hero_spider_06_hole",
		to = 13,
		from = 1
	},
	hero_spider_05_hole_loop = {
		prefix = "hero_spider_06_hole",
		to = 58,
		from = 14
	},
	hero_spider_05_hole_run = {
		prefix = "hero_spider_06_hole",
		to = 104,
		from = 59
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_spider.lua

-- BEGIN kr3/data/animations/hero_venom.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_venom.lua

local a = {
	hero_venom_hero_idle = {
		prefix = "hero_venom_hero",
		to = 40,
		from = 1
	},
	hero_venom_hero_walk = {
		prefix = "hero_venom_hero",
		to = 58,
		from = 41
	},
	hero_venom_hero_run_in = {
		prefix = "hero_venom_hero",
		to = 64,
		from = 59
	},
	hero_venom_hero_run = {
		prefix = "hero_venom_hero",
		to = 76,
		from = 65
	},
	hero_venom_hero_run_out = {
		prefix = "hero_venom_hero",
		to = 82,
		from = 77
	},
	hero_venom_hero_attack_1 = {
		prefix = "hero_venom_hero",
		to = 118,
		from = 83
	},
	hero_venom_hero_attack_2 = {
		prefix = "hero_venom_hero",
		to = 154,
		from = 119
	},
	hero_venom_hero_respawn = {
		prefix = "hero_venom_hero",
		to = 180,
		from = 155
	},
	hero_venom_hero_death = {
		prefix = "hero_venom_hero",
		to = 209,
		from = 181
	},
	hero_venom_hero_ranged_skill = {
		prefix = "hero_venom_hero",
		to = 237,
		from = 210
	},
	hero_venom_hero_beast_in = {
		prefix = "hero_venom_hero",
		to = 275,
		from = 238
	},
	hero_venom_hero_beast_idle = {
		prefix = "hero_venom_hero",
		to = 276,
		from = 276
	},
	hero_venom_hero_beast_out = {
		prefix = "hero_venom_hero",
		to = 304,
		from = 277
	},
	hero_venom_hero_beast_walk = {
		prefix = "hero_venom_hero",
		to = 324,
		from = 305
	},
	hero_venom_hero_beast_attack_1 = {
		prefix = "hero_venom_hero",
		to = 344,
		from = 325
	},
	hero_venom_hero_beast_attack_2 = {
		prefix = "hero_venom_hero",
		to = 362,
		from = 345
	},
	hero_venom_hero_beast_attack_3 = {
		prefix = "hero_venom_hero",
		to = 392,
		from = 363
	},
	hero_venom_hero_spikes_in = {
		prefix = "hero_venom_hero",
		to = 421,
		from = 393
	},
	hero_venom_hero_spikes_idle = {
		prefix = "hero_venom_hero",
		to = 422,
		from = 422
	},
	hero_venom_hero_spikes_out = {
		prefix = "hero_venom_hero",
		to = 438,
		from = 423
	},
	hero_venom_hero_instakill = {
		prefix = "hero_venom_hero",
		to = 490,
		from = 439
	},
	hero_venom_lvlup_fx_idle = {
		prefix = "hero_venom_lvlup_fx",
		to = 14,
		from = 1
	},
	hero_venom_run_particle_idle = {
		prefix = "hero_venom_run_particle",
		to = 10,
		from = 1
	},
	hero_venom_hit_fx_idle = {
		prefix = "hero_venom_hit_fx",
		to = 10,
		from = 1
	},
	hero_venom_eat_fx = {
		prefix = "hero_venom_eat_fx",
		to = 11,
		from = 1
	},
	hero_venom_ranged_skill_tentacle_idle = {
		prefix = "hero_venom_ranged_skill_tentacle",
		to = 20,
		from = 1
	},
	hero_venom_spike_a_in = {
		prefix = "hero_venom_spike_a",
		to = 14,
		from = 1
	},
	hero_venom_spike_a_idle = {
		prefix = "hero_venom_spike_a",
		to = 15,
		from = 15
	},
	hero_venom_spike_a_out = {
		prefix = "hero_venom_spike_a",
		to = 21,
		from = 16
	},
	hero_venom_spike_b_in = {
		prefix = "hero_venom_spike_b",
		to = 12,
		from = 1
	},
	hero_venom_spike_b_idle = {
		prefix = "hero_venom_spike_b",
		to = 13,
		from = 13
	},
	hero_venom_spike_b_out = {
		prefix = "hero_venom_spike_b",
		to = 19,
		from = 14
	},
	hero_venom_ultimate_in = {
		prefix = "hero_venom_ultimate",
		to = 38,
		from = 1
	},
	hero_venom_ultimate_idle = {
		prefix = "hero_venom_ultimate",
		to = 39,
		from = 39
	},
	hero_venom_ultimate_attack = {
		prefix = "hero_venom_ultimate",
		to = 83,
		from = 40
	},
	hero_venom_heal_fx_front_idle = {
		prefix = "hero_venom_heal_fx_front",
		to = 44,
		from = 1
	},
	hero_venom_heal_fx_back_idle = {
		prefix = "hero_venom_heal_fx_back",
		to = 44,
		from = 1
	},
	hero_venom_death_decal_idle = {
		prefix = "hero_venom_death_decal",
		to = 4,
		from = 1
	},
	hero_venom_hero_levelup = {
		prefix = "hero_venom_hero",
		to = 180,
		from = 155
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_venom.lua

-- BEGIN kr3/data/animations/hero_witch.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hero_witch.lua

local a = {
	hero_witch_hero_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 22,
		layer_from = 1
	},
	hero_witch_hero_layerX_walk = {
		layer_to = 3,
		from = 23,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 40,
		layer_from = 1
	},
	hero_witch_hero_layerX_range_attack = {
		layer_to = 3,
		from = 41,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 76,
		layer_from = 1
	},
	hero_witch_hero_layerX_melee_attack = {
		layer_to = 3,
		from = 77,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 110,
		layer_from = 1
	},
	hero_witch_hero_layerX_skill_1 = {
		layer_to = 3,
		from = 111,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 162,
		layer_from = 1
	},
	hero_witch_hero_layerX_skill_2 = {
		layer_to = 3,
		from = 163,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 190,
		layer_from = 1
	},
	hero_witch_hero_layerX_skill_3 = {
		layer_to = 3,
		from = 191,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 238,
		layer_from = 1
	},
	hero_witch_hero_layerX_skill_4 = {
		layer_to = 3,
		from = 239,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 292,
		layer_from = 1
	},
	hero_witch_hero_layerX_level_up = {
		layer_to = 3,
		from = 293,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 328,
		layer_from = 1
	},
	hero_witch_hero_layerX_respawn = {
		layer_to = 3,
		from = 329,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 366,
		layer_from = 1
	},
	hero_witch_hero_layerX_death = {
		layer_to = 3,
		from = 367,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 419,
		layer_from = 1
	},
	hero_witch_hero_layerX_grave = {
		layer_to = 3,
		from = 420,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 420,
		layer_from = 1
	},
	hero_witch_walk_particle = {
		prefix = "hero_witch_walk_particle",
		to = 10,
		from = 1
	},
	hero_witch_ranged_attack_projectile_loop = {
		prefix = "hero_witch_ranged_attack_projectile",
		to = 10,
		from = 1
	},
	hero_witch_ranged_attack_particle = {
		prefix = "hero_witch_ranged_attack_particle",
		to = 7,
		from = 1
	},
	hero_witch_ranged_attack_hit = {
		prefix = "hero_witch_ranged_attack_hit",
		to = 9,
		from = 1
	},
	hero_witch_skill_1_particle_idle = {
		prefix = "hero_witch_skill_1_particle",
		to = 9,
		from = 1
	},
	hero_witch_skill_1_hit_run = {
		prefix = "hero_witch_skill_1_hit",
		to = 19,
		from = 1
	},
	hero_witch_pumpkling_flying_idle = {
		prefix = "hero_witch_pumpkling_flying",
		to = 16,
		from = 1
	},
	hero_witch_pumpkling_flying_walk = {
		prefix = "hero_witch_pumpkling_flying",
		to = 32,
		from = 17
	},
	hero_witch_pumpkling_flying_walk_front = {
		prefix = "hero_witch_pumpkling_flying",
		to = 48,
		from = 33
	},
	hero_witch_pumpkling_flying_walk_back = {
		prefix = "hero_witch_pumpkling_flying",
		to = 64,
		from = 49
	},
	hero_witch_pumpkling_flying_death = {
		prefix = "hero_witch_pumpkling_flying",
		to = 77,
		from = 65
	},
	hero_witch_pumpkling_idle = {
		prefix = "hero_witch_pumpkling",
		to = 1,
		from = 1
	},
	hero_witch_pumpkling_walk = {
		prefix = "hero_witch_pumpkling",
		to = 15,
		from = 2
	},
	hero_witch_pumpkling_walk_front = {
		prefix = "hero_witch_pumpkling",
		to = 29,
		from = 16
	},
	hero_witch_pumpkling_walk_back = {
		prefix = "hero_witch_pumpkling",
		to = 43,
		from = 30
	},
	hero_witch_pumpkling_death = {
		prefix = "hero_witch_pumpkling",
		to = 65,
		from = 44
	},
	hero_witch_decoy_idle = {
		prefix = "hero_witch_decoy",
		to = 1,
		from = 1
	},
	hero_witch_decoy_in = {
		prefix = "hero_witch_decoy",
		to = 20,
		from = 2
	},
	hero_witch_decoy_walk = {
		prefix = "hero_witch_decoy",
		to = 36,
		from = 21
	},
	hero_witch_decoy_attack = {
		prefix = "hero_witch_decoy",
		to = 64,
		from = 37
	},
	hero_witch_decoy_death = {
		prefix = "hero_witch_decoy",
		to = 89,
		from = 65
	},
	hero_witch_skill_2_stun_mod_loop = {
		prefix = "hero_witch_skill_2_stun_mod",
		to = 28,
		from = 1
	},
	hero_witch_skill_2_stun_decal_death = {
		prefix = "hero_witch_skill_2_stun_decal",
		to = 25,
		from = 1
	},
	hero_witch_skill_2_stun_fx_death = {
		prefix = "hero_witch_skill_2_stun_fx",
		to = 25,
		from = 1
	},
	hero_witch_cat_idle = {
		prefix = "hero_witch_cat",
		to = 1,
		from = 1
	},
	hero_witch_cat_in = {
		prefix = "hero_witch_cat",
		to = 18,
		from = 2
	},
	hero_witch_cat_walk = {
		prefix = "hero_witch_cat",
		to = 32,
		from = 19
	},
	hero_witch_cat_attack = {
		prefix = "hero_witch_cat",
		to = 60,
		from = 33
	},
	hero_witch_cat_out = {
		prefix = "hero_witch_cat",
		to = 77,
		from = 61
	},
	hero_witch_skill_4_potion_decal_2 = {
		prefix = "hero_witch_skill_4_potion_decal_2",
		to = 1,
		from = 1
	},
	hero_witch_skill_4_potion_decal_1 = {
		prefix = "hero_witch_skill_4_potion_decal_1",
		to = 1,
		from = 1
	},
	hero_witch_skill_4_potion_in_in = {
		prefix = "hero_witch_skill_4_potion_in",
		to = 52,
		from = 15
	},
	hero_witch_skill_4_potion_in_layerX_in = {
		layer_to = 2,
		from = 1,
		layer_prefix = "hero_witch_skill_4_potion_in_layer%i",
		to = 41,
		layer_from = 1
	},
	hero_witch_ultimate_teleport_fx = {
		prefix = "hero_witch_ultimate_teleport_fx",
		to = 16,
		from = 1
	},
	hero_witch_ultimate_teleport_decal = {
		prefix = "hero_witch_ultimate_teleport_decal",
		to = 21,
		from = 1
	},
	hero_witch_ultimate_sleep_fx_loop = {
		prefix = "hero_witch_ultimate_sleep_fx",
		to = 42,
		from = 1
	},
	hero_witch_ultimate_sleep_particles_loop = {
		prefix = "hero_witch_ultimate_sleep_particles",
		to = 21,
		from = 1
	},
	hero_witch_ranged_attack_projectile_flying = {
		prefix = "hero_witch_ranged_attack_projectile",
		to = 10,
		from = 1
	},
	hero_witch_skill_1_hit_run_flying = {
		prefix = "hero_witch_skill_1_hit",
		to = 19,
		from = 1
	},
	hero_witch_skill_4_potion_in_custom = {
		prefix = "hero_witch_skill_4_potion_in",
		to = 39,
		from = 1
	},
	hero_witch_skill_1_particle_idle_flying = {
		prefix = "hero_witch_skill_1_particle",
		to = 9,
		from = 1
	},
	hero_witch_skill_1_hit_run = {
		prefix = "hero_witch_skill_1_hit",
		to = 16,
		from = 1
	},
	hero_witch_hero_layerX_disengage_disappear = {
		layer_to = 3,
		from = 163,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 173,
		layer_from = 1
	},
	hero_witch_hero_layerX_disengage_appear = {
		layer_to = 3,
		from = 174,
		layer_prefix = "hero_witch_hero_layer%i",
		to = 190,
		layer_from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_witch.lua

-- BEGIN kr3/data/animations/hero_wukong.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/hero_wukong.lua

local a = {
	hero_wukong_hit_wukong_run = {
		prefix = "hero_wukong_hit_wukong",
		to = 6,
		from = 1
	},
	hero_wukong_hit_run = {
		prefix = "hero_wukong_hit",
		to = 6,
		from = 1
	},
	hero_wukong_trail_nube_run = {
		prefix = "hero_wukong_trail_nube",
		to = 10,
		from = 1
	},
	hero_wukong_attack_range_projectile = {
		prefix = "hero_wukong_attack_range_projectile",
		to = 21,
		from = 1
	},
	hero_wukong_wukong_idle = {
		prefix = "hero_wukong_wukong",
		to = 16,
		from = 1
	},
	hero_wukong_wukong_idle_1 = {
		prefix = "hero_wukong_wukong",
		to = 16,
		from = 1
	},
	hero_wukong_wukong_walk = {
		prefix = "hero_wukong_wukong",
		to = 36,
		from = 17
	},
	hero_wukong_wukong_in_idle_2 = {
		prefix = "hero_wukong_wukong",
		to = 48,
		from = 37
	},
	hero_wukong_wukong_idle_2 = {
		prefix = "hero_wukong_wukong",
		to = 65,
		from = 49
	},
	hero_wukong_wukong_out_idle_2 = {
		prefix = "hero_wukong_wukong",
		to = 73,
		from = 66
	},
	hero_wukong_wukong_attack_1 = {
		prefix = "hero_wukong_wukong",
		to = 98,
		from = 74
	},
	hero_wukong_wukong_attack_2 = {
		prefix = "hero_wukong_wukong",
		to = 123,
		from = 99
	},
	hero_wukong_wukong_attack_3 = {
		prefix = "hero_wukong_wukong",
		to = 148,
		from = 124
	},
	hero_wukong_wukong_attack_4 = {
		prefix = "hero_wukong_wukong",
		to = 173,
		from = 149
	},
	hero_wukong_wukong_death = {
		prefix = "hero_wukong_wukong",
		to = 233,
		from = 174
	},
	hero_wukong_wukong_respawn = {
		prefix = "hero_wukong_wukong",
		to = 272,
		from = 234
	},
	hero_wukong_wukong_cloud_in = {
		prefix = "hero_wukong_wukong",
		to = 284,
		from = 273
	},
	hero_wukong_wukong_cloud_loop = {
		prefix = "hero_wukong_wukong",
		to = 296,
		from = 285
	},
	hero_wukong_wukong_cloud_out = {
		prefix = "hero_wukong_wukong",
		to = 312,
		from = 297
	},
	hero_wukong_wukong_clones = {
		prefix = "hero_wukong_wukong",
		to = 356,
		from = 313
	},
	hero_wukong_wukong_area_attack = {
		prefix = "hero_wukong_wukong",
		to = 462,
		from = 357
	},
	hero_wukong_wukong_lvl_up = {
		prefix = "hero_wukong_wukong",
		to = 499,
		from = 463
	},
	hero_wukong_wukong_attack_ranged = {
		prefix = "hero_wukong_wukong",
		to = 543,
		from = 500
	},
	hero_wukong_clone_1_raise = {
		prefix = "hero_wukong_clone_1",
		to = 13,
		from = 1
	},
	hero_wukong_clone_1_spawn = {
		prefix = "hero_wukong_clone_1",
		to = 13,
		from = 1
	},
	hero_wukong_clone_1_idle = {
		prefix = "hero_wukong_clone_1",
		to = 14,
		from = 14
	},
	hero_wukong_clone_1_walk = {
		prefix = "hero_wukong_clone_1",
		to = 34,
		from = 15
	},
	hero_wukong_clone_1_attack_melee = {
		prefix = "hero_wukong_clone_1",
		to = 64,
		from = 35
	},
	hero_wukong_clone_1_death = {
		prefix = "hero_wukong_clone_1",
		to = 89,
		from = 65
	},
	hero_wukong_clone_2_raise = {
		prefix = "hero_wukong_clone_2",
		to = 13,
		from = 1
	},
	hero_wukong_clone_2_spawn = {
		prefix = "hero_wukong_clone_2",
		to = 13,
		from = 1
	},
	hero_wukong_clone_2_idle = {
		prefix = "hero_wukong_clone_2",
		to = 14,
		from = 14
	},
	hero_wukong_clone_2_walk = {
		prefix = "hero_wukong_clone_2",
		to = 34,
		from = 15
	},
	hero_wukong_clone_2_attack_melee = {
		prefix = "hero_wukong_clone_2",
		to = 65,
		from = 35
	},
	hero_wukong_clone_2_death = {
		prefix = "hero_wukong_clone_2",
		to = 90,
		from = 66
	},
	hero_wukong_woolong_decal_idle = {
		prefix = "hero_wukong_woolong_decal",
		to = 1,
		from = 1
	},
	hero_wukong_baston_crack_idle = {
		prefix = "hero_wukong_baston_crack",
		to = 1,
		from = 1
	},
	hero_wukong_woolong_spawn_FX_spawn = {
		prefix = "hero_wukong_woolong_spawn_FX",
		to = 22,
		from = 1
	},
	hero_wukong_woolong_idle = {
		prefix = "hero_wukong_woolong",
		to = 2,
		from = 1
	},
	hero_wukong_woolong_walk = {
		prefix = "hero_wukong_woolong",
		to = 22,
		from = 3
	},
	hero_wukong_woolong_attack_melee = {
		prefix = "hero_wukong_woolong",
		to = 44,
		from = 23
	},
	hero_wukong_woolong_attack_area = {
		prefix = "hero_wukong_woolong",
		to = 138,
		from = 45
	},
	hero_wukong_woolong_death = {
		prefix = "hero_wukong_woolong",
		to = 161,
		from = 139
	},
	hero_wukong_weapon_decal_decal = {
		prefix = "hero_wukong_weapon_decal",
		to = 11,
		from = 1
	},
	hero_wukong_weapon_in = {
		prefix = "hero_wukong_weapon",
		to = 56,
		from = 1
	},
	hero_wukong_dust_up_in = {
		prefix = "hero_wukong_dust_up",
		to = 22,
		from = 1
	},
	hero_wukong_smoke_in = {
		prefix = "hero_wukong_smoke",
		to = 20,
		from = 1
	},
	hero_wukong_back_dust_in = {
		prefix = "hero_wukong_back_dust",
		to = 13,
		from = 1
	},
	hero_wukong_dragon_ultimate_dragon = {
		prefix = "hero_wukong_dragon_ultimate_dragon",
		to = 70,
		from = 1
	},
	hero_wukong_dragon_ultimate_cracks_floor = {
		prefix = "hero_wukong_dragon_ultimate_cracks_floor",
		to = 15,
		from = 1
	},
	hero_wukong_dragon_ultimate_fire_explosion = {
		prefix = "hero_wukong_dragon_ultimate_water_explosion",
		to = 37,
		from = 1
	},
	hero_wukong_dragon_ultimate_vfx_decal_in = {
		prefix = "hero_wukong_dragon_ultimate_vfx_decal",
		to = 6,
		from = 1
	},
	hero_wukong_dragon_ultimate_vfx_decal_loop = {
		prefix = "hero_wukong_dragon_ultimate_vfx_decal",
		to = 34,
		from = 7
	},
	hero_wukong_dragon_ultimate_vfx_decal_out = {
		prefix = "hero_wukong_dragon_ultimate_vfx_decal",
		to = 40,
		from = 36
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hero_wukong.lua

-- BEGIN kr3/data/animations/hog_invader.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/hog_invader.lua

local a = {
	hog_invader_raise = {
		prefix = "hog_invader",
		to = 2,
		from = 2
	},
	hog_invader_idle = {
		prefix = "hog_invader",
		to = 1,
		from = 1
	},
	hog_invader_walkingRightLeft = {
		prefix = "hog_invader",
		to = 21,
		from = 2
	},
	hog_invader_walkingDown = {
		prefix = "hog_invader",
		to = 41,
		from = 22
	},
	hog_invader_walkingUp = {
		prefix = "hog_invader",
		to = 61,
		from = 42
	},
	hog_invader_attack = {
		prefix = "hog_invader",
		to = 85,
		from = 62
	},
	hog_invader_death = {
		prefix = "hog_invader",
		to = 104,
		from = 86
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/hog_invader.lua

-- BEGIN kr3/data/animations/kr4_enemies.lua
do
	local __chunk = (function()
return{
	bone_carrier_idle = {
		prefix = "bone_carrier",
		to = 30,
		from = 1
	},
	bone_carrier_walk = {
		prefix = "bone_carrier",
		to = 60,
		from = 31
	},
	bone_carrier_walkDown = {
		prefix = "bone_carrier",
		to = 94,
		from = 61
	},
	bone_carrier_walkUp = {
		prefix = "bone_carrier",
		to = 128,
		from = 95
	},
	bone_carrier_attack = {
		prefix = "bone_carrier",
		to = 160,
		from = 129
	},
	bone_carrier_death = {
		prefix = "bone_carrier",
		to = 230,
		from = 161
	},
	bone_carrier_modifier_init = {
		prefix = "bone_carrier_modifier",
		to = 9,
		from = 1
	},
	bone_carrier_modifier_loop = {
		prefix = "bone_carrier_modifier",
		to = 10,
		from = 10
	},
	corrosive_soul_idle = {
		prefix = "corrosive_soul",
		to = 1,
		from = 1
	},
	corrosive_soul_walk = {
		prefix = "corrosive_soul",
		to = 19,
		from = 2
	},
	corrosive_soul_walkDown = {
		prefix = "corrosive_soul",
		to = 37,
		from = 20
	},
	corrosive_soul_walkUp = {
		prefix = "corrosive_soul",
		to = 55,
		from = 38
	},
	corrosive_soul_attack = {
		prefix = "corrosive_soul",
		to = 84,
		from = 56
	},
	corrosive_soul_death = {
		prefix = "corrosive_soul",
		to = 119,
		from = 85
	},
	corrosive_soul_fx_run = {
		prefix = "corrosive_soul_fx",
		to = 14,
		from = 1
	},
	ghost_idle = {
		prefix = "ghost",
		to = 1,
		from = 1
	},
	ghost_walk = {
		prefix = "ghost",
		to = 30,
		from = 1
	},
	ghost_walkUp = {
		prefix = "ghost",
		to = 60,
		from = 31
	},
	ghost_walkDown = {
		prefix = "ghost",
		to = 90,
		from = 61
	},
	ghost_death = {
		prefix = "ghost",
		to = 118,
		from = 91
	},
	ghost_raise = {
		prefix = "ghost",
		to = 91,
		from = 115
	},
	haunted_skeleton_idle = {
		prefix = "haunted_skeleton",
		to = 14,
		from = 1
	},
	haunted_skeleton_walk = {
		prefix = "haunted_skeleton",
		to = 38,
		from = 15
	},
	haunted_skeleton_walkDown = {
		prefix = "haunted_skeleton",
		to = 62,
		from = 39
	},
	haunted_skeleton_walkUp = {
		prefix = "haunted_skeleton",
		to = 86,
		from = 63
	},
	haunted_skeleton_attack = {
		prefix = "haunted_skeleton",
		to = 108,
		from = 87
	},
	haunted_skeleton_death = {
		prefix = "haunted_skeleton",
		to = 131,
		from = 109
	},
	haunted_skeleton_raise = {
		prefix = "haunted_skeleton",
		to = 157,
		from = 132
	},
	haunted_skeleton_modifier_damage_fx_run = {
		prefix = "haunted_skeleton_modifier_damage_fx",
		to = 24,
		from = 1
	},
	lich_idle = {
		prefix = "lich",
		to = 24,
		from = 1
	},
	lich_walk = {
		prefix = "lich",
		to = 24,
		from = 1
	},
	lich_walkDown = {
		prefix = "lich",
		to = 50,
		from = 25
	},
	lich_walkUp = {
		prefix = "lich",
		to = 75,
		from = 51
	},
	lich_attack = {
		prefix = "lich",
		to = 103,
		from = 76
	},
	lich_shoot = {
		prefix = "lich",
		to = 139,
		from = 104
	},
	lich_special = {
		prefix = "lich",
		to = 177,
		from = 140
	},
	lich_death = {
		prefix = "lich",
		to = 214,
		from = 178
	},
	lich_ray_travel = {
		prefix = "lich_ray",
		to = 14,
		from = 1
	},
	lich_ray_hit_fx_run = {
		prefix = "lich_ray_hit_fx",
		to = 6,
		from = 1
	},
	roots_holder_front_idle = {
		prefix = "roots_holder_front",
		to = 24,
		from = 1
	},
	roots_holder_front_in = {
		prefix = "roots_holder_front",
		to = 49,
		from = 25
	},
	roots_holder_front_out = {
		prefix = "roots_holder_front",
		to = 72,
		from = 50
	},
	roots_holder_back_idle = {
		prefix = "roots_holder_back",
		to = 1,
		from = 1
	},
	roots_holder_back_in = {
		prefix = "roots_holder_back",
		to = 26,
		from = 2
	},
	roots_holder_back_out = {
		prefix = "roots_holder_back",
		to = 49,
		from = 27
	},
	roots_tower_front_idle = {
		prefix = "roots_tower_front",
		to = 1,
		from = 1
	},
	roots_tower_front_in = {
		prefix = "roots_tower_front",
		to = 26,
		from = 2
	},
	roots_tower_front_out = {
		prefix = "roots_tower_front",
		to = 48,
		from = 27
	},
	roots_tower_back_idle = {
		prefix = "roots_tower_back",
		to = 1,
		from = 1
	},
	roots_tower_back_in = {
		prefix = "roots_tower_back",
		to = 26,
		from = 2
	},
	roots_tower_back_out = {
		prefix = "roots_tower_back",
		to = 49,
		from = 27
	},
	roots_fog_tower_run = {
		prefix = "roots_fog_tower",
		to = 32,
		from = 1
	},
	roots_cloud_tower_run = {
		prefix = "roots_cloud_tower",
		to = 42,
		from = 1
	},
	swamp_bubble_run = {
		prefix = "Stage_26_swamp_bubble",
		to = 33,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_enemies.lua

-- BEGIN kr3/data/animations/kr4_enemy_dwarves.lua
do
	local __chunk = (function()
return {
--矮人王boss
	boss_dwarf_idle = {
		prefix = "boss_dwarf",
		to = 1,
		from = 1
	},
	boss_dwarf_angry = {
		prefix = "boss_dwarf",
		to = 41,
		from = 2
	},
	boss_dwarf_up = {
		prefix = "boss_dwarf",
		to = 63,
		from = 42
	},
	boss_dwarf_fail = {
		prefix = "boss_dwarf",
		to = 173,
		from = 64
	},
	boss_dwarf_correct = {
		prefix = "boss_dwarf",
		to = 199,
		from = 174
	},
	boss_dwarf_back = {
		prefix = "boss_dwarf",
		to = 227,
		from = 200
	},
	boss_dwarf_jump = {
		prefix = "boss_dwarf",
		to = 234,
		from = 228
	},
	boss_dwarf_jumpOn = {
		prefix = "boss_dwarf",
		to = 238,
		from = 235
	},
	boss_dwarf_steal = {
		prefix = "boss_dwarf",
		to = 246,
		from = 239
	},
	boss_dwarf_down = {
		prefix = "boss_dwarf",
		to = 249,
		from = 247
	},
	boss_dwarf_downOut = {
		prefix = "boss_dwarf",
		to = 259,
		from = 250
	},
	boss_dwarf_down2 = {
		prefix = "boss_dwarf",
		to = 262,
		from = 260
	},
	boss_dwarf_downOut2 = {
		prefix = "boss_dwarf",
		to = 271,
		from = 263
	},
	boss_dwarf_fall = {
		prefix = "boss_dwarf",
		to = 173,
		from = 83
	},
	boss_dwarf_splash = {
		prefix = "boss_dwarf_splash",
		to = 29,
		from = 1
	},
	boss_dwarf_coins_run = {
		prefix = "boss_dwarf_coins",
		to = 10,
		from = 1
	},
	boss_dwarf_mecha_up = {
		prefix = "boss_dwarf_mecha",
		to = 44,
		from = 1
	},
	boss_dwarf_mecha_idle = {
		prefix = "boss_dwarf_mecha",
		to = 45,
		from = 45
	},
	boss_dwarf_mecha_walkingRightLeft = {
		prefix = "boss_dwarf_mecha",
		to = 71,
		from = 46
	},
	boss_dwarf_mecha_walkingUp = {
		prefix = "boss_dwarf_mecha",
		to = 71,
		from = 46
	},
	boss_dwarf_mecha_walkingDown = {
		prefix = "boss_dwarf_mecha",
		to = 71,
		from = 46
	},
	boss_dwarf_mecha_attack = {
		prefix = "boss_dwarf_mecha",
		to = 125,
		from = 72
	},
	boss_dwarf_mecha_missil = {
		prefix = "boss_dwarf_mecha",
		to = 199,
		from = 126
	},
	boss_dwarf_mecha_death = {
		prefix = "boss_dwarf_mecha",
		to = 256,
		from = 200
	},
	boss_dwarf_mecha_travel = {
		prefix = "boss_dwarf_mecha_proyectile",
		to = 3,
		from = 1
	},
	boss_dwarf_smoke_particle_run = {
		prefix = "boss_dwarf_mecha_proyectile_smoke",
		to = 8,
		from = 1
	},
	boss_dwarf_throne_run = {
		prefix = "boss_dwarf_throne",
		to = 1,
		from = 1
	},
--bruiser
	bruiser_idle = {
		prefix = "bruiser",
		to = 1,
		from = 1
	},
	bruiser_walkingRightLeft = {
		prefix = "bruiser",
		to = 21,
		from = 2
	},
	bruiser_walkingDown = {
		prefix = "bruiser",
		to = 41,
		from = 22
	},
	bruiser_walkingUp = {
		prefix = "bruiser",
		to = 61,
		from = 42
	},
	bruiser_attack = {
		prefix = "bruiser",
		to = 79,
		from = 62
	},
	bruiser_death = {
		prefix = "bruiser",
		to = 93,
		from = 80
	},
--chompbot
	chompbot_idle = {
		prefix = "chompbot",
		to = 1,
		from = 1
	},
	chompbot_walkingRightLeft = {
		prefix = "chompbot",
		to = 21,
		from = 2
	},
	chompbot_walkingUp = {
		prefix = "chompbot",
		to = 43,
		from = 22
	},
	chompbot_walkingDown = {
		prefix = "chompbot",
		to = 65,
		from = 44
	},
	chompbot_attack = {
		prefix = "chompbot",
		to = 85,
		from = 66
	},
	chompbot_overheatStart = {
		prefix = "chompbot",
		to = 95,
		from = 86
	},
	chompbot_overheatLoop = {
		prefix = "chompbot",
		to = 119,
		from = 96
	},
	chompbot_death = {
		prefix = "chompbot",
		to = 142,
		from = 120
	},
--clockwork_spider
	clockwork_spider_idle = {
		prefix = "clockwork_spider",
		to = 1,
		from = 1
	},
	clockwork_spider_walkingRightLeft = {
		prefix = "clockwork_spider",
		to = 10,
		from = 2
	},
	clockwork_spider_walkingDown = {
		prefix = "clockwork_spider",
		to = 19,
		from = 11
	},
	clockwork_spider_walkingUp = {
		prefix = "clockwork_spider",
		to = 28,
		from = 20
	},
	clockwork_spider_attack = {
		prefix = "clockwork_spider",
		to = 47,
		from = 29
	},
	clockwork_spider_death = {
		prefix = "clockwork_spider",
		to = 65,
		from = 48
	},
--dwarf_flyer
	dwarf_flyer_idle = {
		prefix = "dwarf_flyer",
		to = 25,
		from = 2
	},
	dwarf_flyer_walkingRightLeft = {
		prefix = "dwarf_flyer",
		to = 25,
		from = 2
	},
	dwarf_flyer_walkingDown = {
		prefix = "dwarf_flyer",
		to = 50,
		from = 26
	},
	dwarf_flyer_walkingUp = {
		prefix = "dwarf_flyer",
		to = 74,
		from = 51
	},
	dwarf_flyer_death = {
		prefix = "dwarf_flyer",
		to = 95,
		from = 75
	},
--mechadwarf
	mechadwarf_idle = {
		prefix = "mechadwarf",
		to = 1,
		from = 1
	},
	mechadwarf_walkingRightLeft = {
		prefix = "mechadwarf",
		to = 32,
		from = 2
	},
	mechadwarf_walkingUp = {
		prefix = "mechadwarf",
		to = 66,
		from = 33
	},
	mechadwarf_walkingDown = {
		prefix = "mechadwarf",
		to = 96,
		from = 67
	},
	mechadwarf_attack = {
		prefix = "mechadwarf",
		to = 129,
		from = 97
	},
	mechadwarf_broken = {
		prefix = "mechadwarf",
		to = 153,
		from = 130
	},
	mechadwarf_specialAttack = {
		prefix = "mechadwarf",
		to = 199,
		from = 154
	},
	mechadwarf_death = {
		prefix = "mechadwarf",
		to = 235,
		from = 200
	},
	mechadwarf_decal_run = {
		prefix = "mechadwarf_decal",
		to = 11,
		from = 1
	},
	mechadwarf_explosion_run = {
		prefix = "mechadwarf_explosion",
		to = 11,
		from = 1
	},
--quarry_worker
	quarry_worker_idle = {
		prefix = "quarry_worker",
		to = 1,
		from = 1
	},
	quarry_worker_walkingRightLeft = {
		prefix = "quarry_worker",
		to = 23,
		from = 2
	},
	quarry_worker_walkingUp = {
		prefix = "quarry_worker",
		to = 45,
		from = 24
	},
	quarry_worker_walkingDown = {
		prefix = "quarry_worker",
		to = 67,
		from = 46
	},
	quarry_worker_attack = {
		prefix = "quarry_worker",
		to = 88,
		from = 68
	},
	quarry_worker_buriedIn = {
		prefix = "quarry_worker",
		to = 132,
		from = 89
	},
	quarry_worker_buriedOut = {
		prefix = "quarry_worker",
		to = 147,
		from = 133
	},
	quarry_worker_buriedWalk = {
		prefix = "quarry_worker",
		to = 161,
		from = 148
	},
	quarry_worker_buriedWalkUp = {
		prefix = "quarry_worker",
		to = 175,
		from = 162
	},
	quarry_worker_buriedWalkDown = {
		prefix = "quarry_worker",
		to = 189,
		from = 176
	},
	quarry_worker_death = {
		prefix = "quarry_worker",
		to = 210,
		from = 190
	},
--smokebeard_engineer
	smokebeard_engineer_walkingRightLeft = {
		prefix = "smokebeard_engineer",
		to = 22,
		from = 1
	},
	smokebeard_engineer_walkingUp = {
		prefix = "smokebeard_engineer",
		to = 44,
		from = 23
	},
	smokebeard_engineer_walkingDown = {
		prefix = "smokebeard_engineer",
		to = 66,
		from = 45
	},
	smokebeard_engineer_idle = {
		prefix = "smokebeard_engineer",
		to = 67,
		from = 67
	},
	smokebeard_engineer_attack = {
		prefix = "smokebeard_engineer",
		to = 92,
		from = 68
	},
	smokebeard_engineer_repair = {
		prefix = "smokebeard_engineer",
		to = 99,
		from = 93
	},
	smokebeard_engineer_repairLoop = {
		prefix = "smokebeard_engineer",
		to = 113,
		from = 100
	},
	smokebeard_engineer_repairEnd = {
		prefix = "smokebeard_engineer",
		to = 119,
		from = 114
	},
	smokebeard_engineer_death = {
		prefix = "smokebeard_engineer",
		to = 133,
		from = 120
	},
	smokebeard_engineer_ray_travel = {
		prefix = "smokebeard_engineer_ray",
		to = 10,
		from = 1
	},
	smokebeard_engineer_ray_hit_run = {
		prefix = "smokebeard_engineer_ray_hit",
		to = 14,
		from = 1
	},
--stonebeard_geomancer
	stonebeard_geomancer_idle = {
		prefix = "stonebeard_geomancer",
		to = 1,
		from = 1
	},
	stonebeard_geomancer_walkingRightLeft = {
		prefix = "stonebeard_geomancer",
		to = 25,
		from = 2
	},
	stonebeard_geomancer_walkingDown = {
		prefix = "stonebeard_geomancer",
		to = 49,
		from = 26
	},
	stonebeard_geomancer_walkingUp = {
		prefix = "stonebeard_geomancer",
		to = 72,
		from = 50
	},
	stonebeard_geomancer_toStone = {
		prefix = "stonebeard_geomancer",
		to = 96,
		from = 73
	},
	stonebeard_geomancer_idleBlock = {
		prefix = "stonebeard_geomancer",
		to = 97,
		from = 97
	},
	stonebeard_geomancer_attack = {
		prefix = "stonebeard_geomancer",
		to = 122,
		from = 98
	},
	stonebeard_geomancer_toDwarf = {
		prefix = "stonebeard_geomancer",
		to = 138,
		from = 123
	},
	stonebeard_geomancer_death = {
		prefix = "stonebeard_geomancer",
		to = 166,
		from = 139
	},
--sulfur_alchemist
	sulfur_alchemist_idle = {
		prefix = "sulfur_alchemist",
		to = 1,
		from = 1
	},
	sulfur_alchemist_walkingRightLeft = {
		prefix = "sulfur_alchemist",
		to = 23,
		from = 2
	},
	sulfur_alchemist_walkingUp = {
		prefix = "sulfur_alchemist",
		to = 45,
		from = 24
	},
	sulfur_alchemist_walkingDown = {
		prefix = "sulfur_alchemist",
		to = 67,
		from = 46
	},
	sulfur_alchemist_attack = {
		prefix = "sulfur_alchemist",
		to = 96,
		from = 68
	},
	sulfur_alchemist_shoot = {
		prefix = "sulfur_alchemist",
		to = 126,
		from = 97
	},
	sulfur_alchemist_shootPoison = {
		prefix = "sulfur_alchemist",
		to = 156,
		from = 127
	},
	sulfur_alchemist_death = {
		prefix = "sulfur_alchemist",
		to = 198,
		from = 157
	},
	sulfur_alchemist_decal_run = {
		prefix = "sulfur_alchemist_poison_explotion_decal",
		to = 1,
		from = 1
	},
	sulfur_alchemist_heal_fx_run = {
		prefix = "sulfur_alchemist_heal_fx",
		to = 25,
		from = 1
	},
	sulfur_alchemist_projectile_heal_hit_run = {
		prefix = "sulfur_alchemist_projectile_heal_hit",
		to = 24,
		from = 1
	},
	sulfur_alchemist_projectile_hit_run = {
		prefix = "sulfur_alchemist_projectile_hit",
		to = 10,
		from = 1
	},
--tinbeard_gunman
	tinbeard_gunman_idle = {
		prefix = "tinbeard_gunman",
		to = 1,
		from = 1
	},
	tinbeard_gunman_walkingRightLeft = {
		prefix = "tinbeard_gunman",
		to = 23,
		from = 2
	},
	tinbeard_gunman_walkingUp = {
		prefix = "tinbeard_gunman",
		to = 45,
		from = 24
	},
	tinbeard_gunman_walkingDown = {
		prefix = "tinbeard_gunman",
		to = 67,
		from = 46
	},
	tinbeard_gunman_attack = {
		prefix = "tinbeard_gunman",
		to = 82,
		from = 68
	},
	tinbeard_gunman_shoot = {
		prefix = "tinbeard_gunman",
		to = 122,
		from = 83
	},
	tinbeard_gunman_shootUp = {
		prefix = "tinbeard_gunman",
		to = 161,
		from = 123
	},
	tinbeard_gunman_shootDown = {
		prefix = "tinbeard_gunman",
		to = 200,
		from = 162
	},
	tinbeard_gunman_death = {
		prefix = "tinbeard_gunman",
		to = 220,
		from = 201
	},
	tinbeard_gunman_proyectile_travel = {
		prefix = "tinbeard_gunman_proyectile",
		to = 1,
		from = 1
	},
	tinbeard_gunman_proyectile_hit = {
		prefix = "tinbeard_gunman_proyectile",
		to = 18,
		from = 2
	},
	tinbeard_gunman_proyectile_particle1_run = {
		prefix = "tinbeard_gunman_proyectile_particle1",
		to = 12,
		from = 1
	},
	tinbeard_gunman_proyectile_particle2_run = {
		prefix = "tinbeard_gunman_proyectile_particle2",
		to = 12,
		from = 1
	},
--warhammer_guard
	warhammer_guard_idle = {
		prefix = "warhammer_guard",
		to = 1,
		from = 1
	},
	warhammer_guard_walkingRightLeft = {
		prefix = "warhammer_guard",
		to = 23,
		from = 2
	},
	warhammer_guard_walkingUp = {
		prefix = "warhammer_guard",
		to = 45,
		from = 24
	},
	warhammer_guard_walkingDown = {
		prefix = "warhammer_guard",
		to = 67,
		from = 46
	},
	warhammer_guard_attack = {
		prefix = "warhammer_guard",
		to = 90,
		from = 68
	},
	warhammer_guard_death = {
		prefix = "warhammer_guard",
		to = 104,
		from = 91
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_enemy_dwarves.lua

-- BEGIN kr3/data/animations/kr4_enemy_human.lua
do
	local __chunk = (function()
return {
	human_woodcutter_idle = {
		prefix = "human_woodcutter",
		to = 1,
		from = 1
	},
	human_woodcutter_walkingRightLeft = {
		prefix = "human_woodcutter",
		to = 21,
		from = 2
	},
	human_woodcutter_walkingDown = {
		prefix = "human_woodcutter",
		to = 41,
		from = 22
	},
	human_woodcutter_walkingUp = {
		prefix = "human_woodcutter",
		to = 61,
		from = 42
	},
	human_woodcutter_attack = {
		prefix = "human_woodcutter",
		to = 79,
		from = 62
	},
	human_woodcutter_death = {
		prefix = "human_woodcutter",
		to = 99,
		from = 80
	},
	human_worker_idle = {
		prefix = "human_worker",
		to = 1,
		from = 1
	},
	human_worker_walkingRightLeft = {
		prefix = "human_worker",
		to = 21,
		from = 2
	},
	human_worker_walkingDown = {
		prefix = "human_worker",
		to = 41,
		from = 22
	},
	human_worker_walkingUp = {
		prefix = "human_worker",
		to = 61,
		from = 42
	},
	human_worker_attack = {
		prefix = "human_worker",
		to = 81,
		from = 62
	},
	human_worker_death = {
		prefix = "human_worker",
		to = 101,
		from = 82
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_enemy_human.lua

-- BEGIN kr3/data/animations/kr4_hero_asra.lua
do
	local __chunk = (function()
return {
	hero_asra_idle = {
		prefix = "hero_asra",
		to = 14,
		from = 1
	},
	hero_asra_walk = {
		prefix = "hero_asra",
		to = 32,
		from = 15
	},
	hero_asra_running = {
		prefix = "hero_asra",
		to = 32,
		from = 15
	},
	hero_asra_shoot = {
		prefix = "hero_asra",
		to = 59,
		from = 33
	},
	hero_asra_shootDown = {
		prefix = "hero_asra",
		to = 86,
		from = 60
	},
	hero_asra_shootUp = {
		prefix = "hero_asra",
		to = 112,
		from = 87
	},
	hero_asra_multishotIn = {
		prefix = "hero_asra",
		to = 122,
		from = 113
	},
	hero_asra_multishotLoop = {
		prefix = "hero_asra",
		to = 130,
		from = 123
	},
	hero_asra_multishotOut = {
		prefix = "hero_asra",
		to = 138,
		from = 131
	},
	hero_asra_multishotDownIn = {
		prefix = "hero_asra",
		to = 148,
		from = 139
	},
	hero_asra_multishotDownLoop = {
		prefix = "hero_asra",
		to = 156,
		from = 149
	},
	hero_asra_multishotDownOut = {
		prefix = "hero_asra",
		to = 164,
		from = 157
	},
	hero_asra_multishotUpIn = {
		prefix = "hero_asra",
		to = 174,
		from = 165
	},
	hero_asra_multishotUpLoop = {
		prefix = "hero_asra",
		to = 182,
		from = 175
	},
	hero_asra_multishotUpOut = {
		prefix = "hero_asra",
		to = 190,
		from = 183
	},
	hero_asra_death = {
		prefix = "hero_asra",
		to = 222,
		from = 191
	},
	hero_asra_levelup = {
		prefix = "hero_asra",
		to = 240,
		from = 223
	},
	hero_asra_respawn = {
		prefix = "hero_asra",
		to = 240,
		from = 223
	},
	hero_asra_level2Walk = {
		prefix = "hero_asra",
		to = 253,
		from = 241
	},
	hero_asra_level3Walk = {
		prefix = "hero_asra",
		to = 265,
		from = 254
	},
	hero_asra_teleportOut = {
		prefix = "hero_asra",
		to = 276,
		from = 266
	},
	hero_asra_teleportIn = {
		prefix = "hero_asra",
		to = 294,
		from = 277
	},
	hero_asra_meleeInit = {
		prefix = "hero_asra",
		to = 312,
		from = 295
	},
	hero_asra_idleBlock = {
		prefix = "hero_asra",
		to = 326,
		from = 313
	},
	hero_asra_melee = {
		prefix = "hero_asra",
		to = 344,
		from = 327
	},
	hero_asra_meleePoison = {
		prefix = "hero_asra",
		to = 383,
		from = 345
	},
	hero_asra_meleeEnd = {
		prefix = "hero_asra",
		to = 403,
		from = 384
	},
	hero_asra_special = {
		prefix = "hero_asra",
		to = 433,
		from = 404
	},
	hero_asra_damage_multiplier_decal_run = {
		prefix = "hero_asra_damage_multiplier_decal",
		to = 54,
		from = 1
	},
	hero_asra_multishot_arrow_hit_run = {
		prefix = "hero_asra_multishot_arrow_hit",
		to = 5,
		from = 1
	},
	hero_asra_poison_modifier_explotion = {
		prefix = "hero_asra_poison_modifier",
		to = 9,
		from = 1
	},
	hero_asra_poison_modifier_run = {
		prefix = "hero_asra_poison_modifier",
		to = 21,
		from = 10
	},
	hero_asra_shield_start = {
		prefix = "hero_asra_shield",
		to = 6,
		from = 1
	},
	hero_asra_shield_end = {
		prefix = "hero_asra_shield",
		to = 36,
		from = 31
	},
	hero_asra_shield_idle = {
		prefix = "hero_asra_shield",
		to = 36,
		from = 1
	},
	hero_asra_special_poison_explosion_run = {
		prefix = "hero_asra_special_poison_explosion",
		to = 18,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_asra.lua

-- BEGIN kr3/data/animations/kr4_hero_beresad.lua
do
	local __chunk = (function()
return {
	hero_beresad_idle = {
		prefix = "hero_beresad",
		to = 18,
		from = 1
	},
	hero_beresad_walk = {
		prefix = "hero_beresad",
		to = 18,
		from = 1
	},
	hero_beresad_fear = {
		prefix = "hero_beresad",
		to = 66,
		from = 19
	},
	hero_beresad_attack = {
		prefix = "hero_beresad",
		to = 84,
		from = 67
	},
	hero_beresad_remove = {
		prefix = "hero_beresad",
		to = 114,
		from = 85
	},
	hero_beresad_conflagration = {
		prefix = "hero_beresad",
		to = 154,
		from = 115
	},
	hero_beresad_earthshake = {
		prefix = "hero_beresad",
		to = 179,
		from = 155
	},
	hero_beresad_death = {
		prefix = "hero_beresad",
		to = 234,
		from = 180
	},
	hero_beresad_respawn = {
		prefix = "hero_beresad",
		to = 280,
		from = 235
	},
	hero_beresad_levelup = {
		prefix = "hero_beresad",
		to = 304,
		from = 281
	},
	--普攻
	hero_beresad_attack_explosion_air_run = {
		prefix = "hero_beresad_attack_explosion_air",
		to = 18,
		from = 1
	},
	hero_beresad_attack_explosion_run = {
		prefix = "hero_beresad_attack_explosion",
		to = 22,
		from = 1
	},
	hero_beresad_attack_proyectile_travel = {
		prefix = "hero_beresad_attack_proyectile",
		to = 10,
		from = 1
	},
	hero_beresad_attack_proyectile_particle_run = {
		prefix = "hero_beresad_attack_proyectile_particle",
		to = 14,
		from = 1
	},
	--1技能
	hero_beresad_conflagration_fire_idle = {
		prefix = "hero_beresad_conflagration_fire",
		to = 24,
		from = 1
	},
	hero_beresad_conflagration_modifier_run = {
		prefix = "hero_beresad_conflagration_modifier",
		to = 20,
		from = 1
	},
	hero_beresad_conflagration_particle_travel = {
		prefix = "hero_beresad_conflagration_particle",
		to = 6,
		from = 1
	},
	--3技能及傀儡
	hero_beresad_golemspawn_explosion_run = {
		prefix = "hero_beresad_golemspawn_explosion",
		to = 18,
		from = 1
	},
	hero_beresad_golemspawn_hit_run = {
		prefix = "hero_beresad_golemspawn_hit",
		to = 6,
		from = 1
	},
	hero_beresad_golemspawn_particle_run = {
		prefix = "hero_beresad_golemspawn_particle",
		to = 19,
		from = 1
	},
	hero_beresad_golem_spawn = {
		prefix = "hero_beresad_golem",
		to = 41,
		from = 1
	},
	hero_beresad_golem_idle = {
		prefix = "hero_beresad_golem",
		to = 53,
		from = 42
	},
	hero_beresad_golem_walk = {
		prefix = "hero_beresad_golem",
		to = 78,
		from = 54
	},
	hero_beresad_golem_running = {
		prefix = "hero_beresad_golem",
		to = 78,
		from = 54
	},
	hero_beresad_golem_attack = {
		prefix = "hero_beresad_golem",
		to = 98,
		from = 79
	},
	hero_beresad_golem_fighting2 = {
		prefix = "hero_beresad_golem",
		to = 119,
		from = 99
	},
	hero_beresad_golem_death = {
		prefix = "hero_beresad_golem",
		to = 134,
		from = 120
	},
	--2技能效果，仅需要第1个即可
	hero_beresad_modifier_fear_run = {
		prefix = "hero_beresad_modifier_fear",
		to = 4,
		from = 1
	},
	hero_mortemis_projectile_travel = {
		prefix = "hero_mortemis_projectile",
		to = 12,
		from = 1
	},
	hero_mortemis_projectile_hit = {
		prefix = "hero_mortemis_projectile",
		to = 20,
		from = 13
	},
	--4技能
	hero_beresad_remove_explosion_run = {
		prefix = "hero_beresad_remove_explosion",
		to = 18,
		from = 1
	},
	hero_beresad_remove_explosion_decal_run = {
		prefix = "hero_beresad_remove_explosion_decal",
		to = 19,
		from = 1
	},
	hero_beresad_remove_ray_run = {
		prefix = "hero_beresad_remove_ray",
		to = 8,
		from = 1
	},
	--大招
	hero_beresad_ultimate_hit_run = {
		prefix = "hero_beresad_ultimate_hit",
		to = 11,
		from = 1
	},
	hero_beresad_ultimate_modifier_in = {
		prefix = "hero_beresad_ultimate_modifier",
		to = 14,
		from = 1
	},
	hero_beresad_ultimate_modifier_run = {
		prefix = "hero_beresad_ultimate_modifier",
		to = 24,
		from = 15
	},
	hero_beresad_ultimate_modifier_out = {
		prefix = "hero_beresad_ultimate_modifier",
		to = 33,
		from = 25
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_beresad.lua

-- BEGIN kr3/data/animations/kr4_hero_dianyun.lua
do
	local __chunk = (function()
local a = {
    kr4_heal_loop = {
        prefix = "healing_big",
        to = 24,
        from = 1
    },
    kr4_stun_loop = {
        prefix = "stun_effect",
        to = 10,
        from = 1
    },
    hero_storm_dragon_cloud_l1_idle = {
        to = 59,
        from = 1,
        prefix = "hero_storm_dragon_cloud_layer1"
    },
    hero_storm_dragon_cloud_l2_idle = {
        to = 59,
        from = 1,
        prefix = "hero_storm_dragon_cloud_layer2"
    },
    hero_storm_dragon_cloud_l3_idle = {
        to = 59,
        from = 1,
        prefix = "hero_storm_dragon_cloud_layer3"
    },
    hero_storm_dragon_supreme_wave = {
        prefix = "hero_storm_dragon_supreme_wave",
        to = 71,
        from = 1
    },
    hero_storm_dragon_lightning_ricochet_fx_l1 = {
        to = 100,
        from = 1,
        prefix = "hero_storm_dragon_lightning_ricochet_fx_layer1"
    },
    hero_storm_dragon_lightning_ricochet_fx_l2 = {
        to = 100,
        from = 1,
        prefix = "hero_storm_dragon_lightning_ricochet_fx_layer2"
    },
    hero_storm_dragon_lightning_ricochet_fx_l3 = {
        to = 100,
        from = 1,
        prefix = "hero_storm_dragon_lightning_ricochet_fx_layer3"
    },
    hero_storm_dragon_lightning_ricochet_cloud = {
        prefix = "hero_storm_dragon_lightning_ricochet_cloud",
        to = 18,
        from = 1
    },
    hero_storm_ray_modifier_loop = {
        prefix = "hero_storm_ray_modifier",
        to = 6,
        from = 1
    },
    hero_storm_dragon_lightning_ricochet_hit = {
        prefix = "hero_storm_dragon_lightning_ricochet_hit",
        to = 10,
        from = 1
    },
    hero_storm_dragon_lightning_ricochet = {
        prefix = "hero_storm_dragon_lightning_ricochet",
        to = 15,
        from = 1
    },
    hero_storm_dragon_lightning = {
        prefix = "hero_storm_dragon_lightning",
        to = 18,
        from = 1
    },
    hero_storm_dragon_lightning_modifier_loop = {
        prefix = "hero_storm_dragon_lightning_modifier",
        to = 6,
        from = 1
    },
    hero_storm_dragon_lightning_hit = {
        prefix = "hero_storm_dragon_lightning_hit",
        to = 10,
        from = 1
    },
    hero_storm_dragon_lantern = {
        prefix = "hero_storm_dragon_lantern",
        to = 50,
        from = 1
    },
    hero_storm_dragon_electric_son_spawn = {
        prefix = "hero_storm_dragon_electric_son",
        to = 25,
        from = 1
    },
    hero_storm_dragon_electric_son_idle = {
        prefix = "hero_storm_dragon_electric_son",
        to = 53,
        from = 26
    },
    hero_storm_dragon_electric_son_attack = {
        prefix = "hero_storm_dragon_electric_son",
        to = 81,
        from = 54
    },
    hero_storm_dragon_electric_son_death = {
        prefix = "hero_storm_dragon_electric_son",
        to = 100,
        from = 82
    }
}
return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_dianyun.lua

-- BEGIN kr3/data/animations/kr4_hero_eiskalt.lua
do
	local __chunk = (function()
local a = {
--英雄本体
    hero_eiskalt_idle = {
        prefix = "hero_eiskalt",
        from = 1,
        to = 20
    },
    hero_eiskalt_range_attack = {
        prefix = "hero_eiskalt",
        from = 21,
        to = 44
    },
    hero_eiskalt_icePeaks = {
        prefix = "hero_eiskalt",
        from = 45,
        to = 84
    },
    hero_eiskalt_coldFury = {
        prefix = "hero_eiskalt",
        from = 85,
        to = 127
    },
    hero_eiskalt_frosty = {
        prefix = "hero_eiskalt",
        from = 128,
        to = 164
    },
    hero_eiskalt_death = {
        prefix = "hero_eiskalt",
        from = 165,
        to = 194
    },
    hero_eiskalt_respawn = {
        prefix = "hero_eiskalt",
        from = 195,
        to = 235
    },
    hero_eiskalt_levelup = {
        prefix = "hero_eiskalt",
        from = 236,
        to = 263
    },
--冻土
    hero_eiskalt_cold_fury_particle_travel = {
        prefix = "hero_eiskalt_cold_fury_particle",
        from = 1,
        to = 6
    },
    hero_eiskalt_cold_fury_smoke_run = {
        prefix = "hero_eiskalt_cold_fury_smoke",
        from = 1,
        to = 40
    },
--爆炸
    hero_eiskalt_explosion_run = {
        prefix = "hero_eiskalt_explosion",
        from = 1,
        to = 21
    },
    hero_eiskalt_explosion_air_run = {
        prefix = "hero_eiskalt_explosion_air",
        from = 1,
        to = 21
    },
--冰球
    hero_eiskalt_frosty_spawn = {
        prefix = "hero_eiskalt_frosty_explosion",
        from = 1,
        to = 22
    },
    hero_eiskalt_frosty_spawn2 = {
        prefix = "hero_eiskalt_frosty",
        from = 1,
        to = 1
    },
    hero_eiskalt_frosty_idle = {
        prefix = "hero_eiskalt_frosty",
        from = 1,
        to = 1
    },
    hero_eiskalt_frosty_walkDown = {
        prefix = "hero_eiskalt_frosty",
        from = 1,
        to = 21
    },
    hero_eiskalt_frosty_walkUp = {
        prefix = "hero_eiskalt_frosty",
        from = 22,
        to = 42
    },
    hero_eiskalt_frosty_walk = {
        prefix = "hero_eiskalt_frosty",
        from = 43,
        to = 63
    },
    hero_eiskalt_frosty_death = {
        prefix = "hero_eiskalt_frosty",
        from = 64,
        to = 97
    },
--冰刺
    hero_eiskalt_ice_peaks_in = {
        prefix = "hero_eiskalt_ice_peaks",
        from = 1,
        to = 7
    },
    hero_eiskalt_ice_peaks_run = {
        prefix = "hero_eiskalt_ice_peaks",
        from = 8,
        to = 13
    },
    hero_eiskalt_ice_peaks_out = {
        prefix = "hero_eiskalt_ice_peaks",
        from = 14,
        to = 21
    },
--轨迹
    hero_eiskalt_particle_run = {
        prefix = "hero_eiskalt_particle",
        from = 1,
        to = 11
    },
    hero_eiskalt_proyectile_travel = {
        prefix = "hero_eiskalt_proyectile",
        from = 1,
        to = 10
    },


}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_eiskalt.lua

-- BEGIN kr3/data/animations/kr4_hero_jack_o_lantern.lua
do
	local __chunk = (function()
-- hero_jack_o_lantern
return{
	hero_jack_o_lantern_idle = {
		prefix = "hero_jack_o_lantern",
		to = 12,
		from = 1
	},
	hero_jack_o_lantern_walk = {
		prefix = "hero_jack_o_lantern",
		to = 22,
		from = 13
	},
	hero_jack_o_lantern_attack = {
		prefix = "hero_jack_o_lantern",
		to = 43,
		from = 23
	},
	hero_jack_o_lantern_hauntedBlade = {
		prefix = "hero_jack_o_lantern",
		to = 74,
		from = 44
	},
	hero_jack_o_lantern_spawnGhouls = {
		prefix = "hero_jack_o_lantern",
		to = 104,
		from = 75
	},
	hero_jack_o_lantern_explosiveHead = {
		prefix = "hero_jack_o_lantern",
		to = 140,
		from = 105
	},
	hero_jack_o_lantern_teleportIn = {
		prefix = "hero_jack_o_lantern",
		to = 163,
		from = 141
	},
	hero_jack_o_lantern_teleportOut = {
		prefix = "hero_jack_o_lantern",
		to = 177,
		from = 164
	},
	hero_jack_o_lantern_levelUp = {
		prefix = "hero_jack_o_lantern",
		to = 214,
		from = 178
	},
	hero_jack_o_lantern_respawn = {
		prefix = "hero_jack_o_lantern",
		to = 249,
		from = 215
	},
	hero_jack_o_lantern_death = {
		prefix = "hero_jack_o_lantern",
		to = 328,
		from = 250
	},
	hero_jack_o_lantern_idleDeath = {
		prefix = "hero_jack_o_lantern",
		to = 359,
		from = 329
	},
	hero_jack_o_lantern_idleBlock = {
		prefix = "hero_jack_o_lantern",
		to = 360,
		from = 360
	},
	hero_jack_o_lantern_explotion_run = {
		prefix = "hero_jack_o_lantern_explotion",
		to = 18,
		from = 1
	},
	hero_jack_o_lantern_spawner_hit_run = {
		prefix = "hero_jack_o_lantern_spawner_hit",
		to = 56,
		from = 1
	},
	hero_jack_o_lantern_spawner_seed_travel = {
		prefix = "hero_jack_o_lantern_spawner_seed",
		to = 12,
		from = 1
	},
	hero_jack_o_lantern_spawner_seed_decal_run = {
		prefix = "hero_jack_o_lantern_spawner_seed_decal",
		to = 10,
		from = 1
	},
	hero_jack_o_lantern_teleportfx_run = {
		prefix = "hero_jack_o_lantern_teleportfx",
		to = 31,
		from = 1
	},
	hero_jack_o_lantern_ultimate_fear_modifier_run = {
		prefix = "hero_jack_o_lantern_ultimate_fear_modifier",
		to = 4,
		from = 1
	},
	hero_jack_o_lantern_ultimate_particle_run = {
		prefix = "hero_jack_o_lantern_ultimate_particle",
		to = 10,
		from = 1
	},
	hero_jack_o_lantern_ultimate_smoke_run = {
		prefix = "hero_jack_o_lantern_ultimate_smoke",
		to = 23,
		from = 1
	},
	hero_jack_o_lantern_ghoul_idle = {
		prefix = "hero_jack_o_lantern_ghoul",
		to = 1,
		from = 1
	},
	hero_jack_o_lantern_ghoul_walk = {
		prefix = "hero_jack_o_lantern_ghoul",
		to = 11,
		from = 2
	},
	hero_jack_o_lantern_ghoul_attack = {
		prefix = "hero_jack_o_lantern_ghoul",
		to = 30,
		from = 12
	},
	hero_jack_o_lantern_ghoul_death = {
		prefix = "hero_jack_o_lantern_ghoul",
		to = 78,
		from = 31
	},
	hero_jack_o_lantern_ultimate_horse_idle = {
		prefix = "hero_jack_o_lantern_ultimate_horse",
		to = 1,
		from = 1
	},
	hero_jack_o_lantern_ultimate_horse_walk = {
		prefix = "hero_jack_o_lantern_ultimate_horse",
		to = 12,
		from = 2
	},
	hero_jack_o_lantern_ultimate_horse_walkUp = {
		prefix = "hero_jack_o_lantern_ultimate_horse",
		to = 24,
		from = 13
	},
	hero_jack_o_lantern_ultimate_horse_walkDown = {
		prefix = "hero_jack_o_lantern_ultimate_horse",
		to = 36,
		from = 25
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_jack_o_lantern.lua

-- BEGIN kr3/data/animations/kr4_hero_lucerna.lua
do
	local __chunk = (function()
return {
	--下船恐惧
	Lucerna_run = {
		prefix = "Lucerna",
		to = 56,
		from = 1
	},
	--普攻爆炸
	Lucerna_explosion_run = {
		prefix = "Lucerna_explosion",
		to = 22,
		from = 1
	},
	--恐惧伤害效果
	Lucerna_fearDecal_run = {
		prefix = "Lucerna_fearDecal",
		to = 28,
		from = 1
	},
	--恐惧效果
	Lucerna_fearModifier_run = {
		prefix = "Lucerna_fearModifier",
		to = 4,
		from = 1
	},
	--策反效果
	Lucerna_possession_decal_start = {
		prefix = "Lucerna_possession_decal",
		to = 21,
		from = 1
	},
	Lucerna_possession_decal_loop = {
		prefix = "Lucerna_possession_decal",
		to = 49,
		from = 22
	},
	Lucerna_possession_decal_end = {
		prefix = "Lucerna_possession_decal",
		to = 74,
		from = 50
	},
	--策反弹
	Lucerna_possession_projectile_spawn = {
		prefix = "Lucerna_possession_projectile",
		to = 15,
		from = 1
	},
	Lucerna_possession_projectile_travel = {
		prefix = "Lucerna_possession_projectile",
		to = 27,
		from = 16
	},
	Lucerna_possession_projectile_hit = {
		prefix = "Lucerna_possession_projectile",
		to = 37,
		from = 28
	},
	--导弹的尾焰
	Lucerna_projectileTrail_run = {
		prefix = "Lucerna_projectileTrail",
		to = 16,
		from = 1
	},
	--导弹本体
	Lucerna_projectile_flying = {
		prefix = "Lucerna_projectile",
		to = 12,
		from = 1
	},
	--2技能 弹幕轰炸
	Lucerna_Ship_ability_run = {
		prefix = "Lucerna_Ship_ability",
		to = 28,
		from = 1
	},
	--静止
	Lucerna_Ship_layerX_idle = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 28,
		from = 1
	},
	--普攻
	Lucerna_Ship_layerX_attack = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 56,
		from = 29
	},
	--2技能
	Lucerna_Ship_layerX_ability = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 84,
		from = 57
	},
	--传送动画
	Lucerna_Ship_layerX_teleportOut = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 112,
		from = 85
	},
	Lucerna_Ship_layerX_teleportIn = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 140,
		from = 113
	},
	--阵亡动画
	Lucerna_Ship_layerX_death = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 190,
		from = 141
	},
	--阵亡期间的效果，不是普通的墓碑，有额外的动画。
	Lucerna_Ship_layerX_deathloop = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 225,
		from = 191
	},
	--复活/开局召唤效果
	Lucerna_Ship_layerX_respawn = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 252,
		from = 226
	},
	Lucerna_Ship_layerX_lvlup = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 279,
		from = 253
	},
	--3技能
	Lucerna_Ship_layerX_summon = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 307,
		from = 280
	},
	--1技能
	Lucerna_Ship_layerX_fear = {
		layer_prefix = "Lucerna_Ship_layer%i",
		layer_from = 1,
		layer_to = 6,
		to = 363,
		from = 308
	},
	--叠加动画-升级
	Lucerna_Ship_lvlup_run = {
		prefix = "Lucerna_Ship_lvlup",
		to = 27,
		from = 1
	},
	--叠加动画-旗帜
	Lucerna_Ship_flag_run = {
		prefix = "Lucerna_Ship_flag",
		to = 50,
		from = 1
	},
	--叠加动画-船桨1
	Lucerna_Ship_remosBack_run = {
		prefix = "Lucerna_Ship_remosBack",
		to = 28,
		from = 1
	},
	--叠加动画-船桨2
	Lucerna_Ship_remos_run = {
		prefix = "Lucerna_Ship_remos",
		to = 28,
		from = 1
	},
	--叠加动画-传送出
	Lucerna_Ship_teleport_teleportOut = {
		prefix = "Lucerna_Ship_teleport",
		to = 28,
		from = 1
	},
	--叠加动画-传送进
	Lucerna_Ship_teleport_teleportIn = {
		prefix = "Lucerna_Ship_teleport",
		to = 56,
		from = 29
	},
	--图腾环绕效果
	Lucerna_totemDecal_idle = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totemDecal_run = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totemDecal_death = {
		prefix = "Lucerna_totemDecal",
		to = 38,
		from = 1
	},
	Lucerna_totem_spawn = {
		prefix = "Lucerna_totem",
		to = 15,
		from = 1
	},
	Lucerna_totem_idle = {
		prefix = "Lucerna_totem",
		to = 43,
		from = 16
	},
	Lucerna_totem_summon = {
		prefix = "Lucerna_totem",
		to = 63,
		from = 44
	},
	Lucerna_totem_death = {
		prefix = "Lucerna_totem",
		to = 81,
		from = 64
	},
	--召唤物
	lucerna_unitghosts_walk = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_idle = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_running = {
		prefix = "lucerna_unitghosts",
		to = 28,
		from = 1
	},
	lucerna_unitghosts_attack = {
		prefix = "lucerna_unitghosts",
		to = 54,
		from = 29
	},
	lucerna_unitghosts_death = {
		prefix = "lucerna_unitghosts",
		to = 75,
		from = 55
	},
	lucerna_unitghosts_spawn = {
		prefix = "lucerna_unitghost_vfxs",
		to = 28,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_lucerna.lua

-- BEGIN kr3/data/animations/kr4_hero_murglun.lua
do
	local __chunk = (function()
return {
	--龙本体
	hero_murglun_idle = {
		prefix = "hero_murglun",
		to = 19,
		from = 1
	},
	hero_murglun_attack = {
		prefix = "hero_murglun",
		to = 46,
		from = 20
	},
	hero_murglun_heatWave = {
		prefix = "hero_murglun",
		to = 98,
		from = 47
	},
	hero_murglun_geiser = {
		prefix = "hero_murglun",
		to = 133,
		from = 99
	},
	hero_murglun_levelup = {
		prefix = "hero_murglun",
		to = 173,
		from = 134
	},
	hero_murglun_death = {
		prefix = "hero_murglun",
		to = 213,
		from = 174
	},
	hero_murglun_respawn = {
		prefix = "hero_murglun",
		to = 264,
		from = 214
	},
	hero_murglun_attack_decals = {
		prefix = "hero_murglun_attack_decals",
		from = 1,
		to = 3
	},
	hero_murglun_attack_explotion_run = {
		prefix = "hero_murglun_attack_explotion",
		to = 18,
		from = 1
	},
	hero_murglun_attack_explotion_basic_run = {
		prefix = "hero_murglun_attack_explotion_basic",
		to = 19,
		from = 1
	},
	hero_murglun_attack_particle_run = {
		prefix = "hero_murglun_attack_particle",
		to = 10,
		from = 1
	},
	hero_murglun_death_smoke_run = {
		prefix = "hero_murglun_death_smoke",
		to = 32,
		from = 1
	},
	hero_murglun_geiser_run = {
		prefix = "hero_murglun_geiser",
		to = 34,
		from = 1
	},
	hero_murglun_geiser_death_run = {
		prefix = "hero_murglun_geiser_death",
		to = 28,
		from = 1
	},
	hero_murglun_geiser_full_run = {
		prefix = "hero_murglun_geiser_full",
		to = 34,
		from = 1
	},
	hero_murglun_heat_wave_decal_idle = {
		prefix = "hero_murglun_heat_wave_decal",
		from = 1,
		to = 36
	},
	hero_murglun_heat_wave_fx1_idle = {
		prefix = "hero_murglun_heat_wave_fx1",
		to = 28,
		from = 1
	},
	hero_murglun_heat_wave_fx2_in = {
		prefix = "hero_murglun_heat_wave_fx2",
		to = 27,
		from = 1
	},
	hero_murglun_heat_wave_fx2_idle = {
		prefix = "hero_murglun_heat_wave_fx2",
		to = 60,
		from = 28
	},
	hero_murglun_lava_blood_explotion_run = {
		prefix = "hero_murglun_lava_blood_explotion",
		to = 10,
		from = 1
	},
	hero_murglun_tower_fx_run = {
		prefix = "hero_murglun_tower_fx",
		to = 16,
		from = 1
	},
	hero_murglun_ultimate_explotion_run = {
		prefix = "hero_murglun_ultimate_explotion",
		to = 24,
		from = 1
	},
	hero_murglun_ultimate_particle2_run = {
		prefix = "hero_murglun_ultimate_particle2",
		to = 23,
		from = 1
	},
	hero_murglun_ultimate_particle_run = {
		prefix = "hero_murglun_ultimate_particle",
		to = 23,
		from = 1
	},
	hero_murglun_ultimate_rocks_run = {
		prefix = "hero_murglun_ultimate_rocks",
		to = 33,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_murglun.lua

-- BEGIN kr3/data/animations/kr4_hero_oloch.lua
do
	local __chunk = (function()
return {
	hero_oloch_idle = {
		prefix = "hero_oloch",
		to = 15,
		from = 2
	},
	hero_oloch_walk = {
		prefix = "hero_oloch",
		to = 33,
		from = 16
	},
	hero_oloch_melee = {
		prefix = "hero_oloch",
		to = 51,
		from = 34
	},
	hero_oloch_shoot = {
		prefix = "hero_oloch",
		to = 88,
		from = 52
	},
	hero_oloch_death = {
		prefix = "hero_oloch",
		to = 141,
		from = 89
	},
	hero_oloch_levelup = {
		prefix = "hero_oloch",
		to = 179,
		from = 142
	},
	hero_oloch_respawn = {
		prefix = "hero_oloch",
		to = 179,
		from = 142
	},
	hero_oloch_duplication = {
		prefix = "hero_oloch",
		to = 204,
		from = 180
	},
	hero_oloch_magmaEruption = {
		prefix = "hero_oloch",
		to = 244,
		from = 205
	},
	hero_oloch_hellishInfusion = {
		prefix = "hero_oloch",
		to = 297,
		from = 245
	},
	hero_oloch_megaBolt = {
		prefix = "hero_oloch",
		to = 356,
		from = 298
	},
	hero_oloch_bolt_travel = {
		prefix = "hero_oloch_bolt",
		to = 10,
		from = 1
	},
	--普攻命中
	hero_oloch_bolt_hit = {
		prefix = "hero_oloch_bolt",
		to = 22,
		from = 11
	},
	hero_oloch_bolt_particle_run = {
		prefix = "hero_oloch_bolt_particle",
		to = 10,
		from = 1
	},
	--亡语爆炸
	hero_oloch_death_floor_ring_run = {
		prefix = "hero_oloch_death_floor_ring",
		to = 17,
		from = 1
	},
	--分身
	hero_oloch_duplication_idle = {
		prefix = "hero_oloch_duplication",
		to = 15,
		from = 1
	},
	hero_oloch_duplication_walk = {
		prefix = "hero_oloch_duplication",
		to = 33,
		from = 16
	},
	hero_oloch_duplication_running = {
		prefix = "hero_oloch_duplication",
		to = 33,
		from = 16
	},
	hero_oloch_duplication_melee = {
		prefix = "hero_oloch_duplication",
		to = 51,
		from = 34
	},
	hero_oloch_duplication_attack = {
		prefix = "hero_oloch_duplication",
		to = 51,
		from = 34
	},
	hero_oloch_duplication_shoot = {
		prefix = "hero_oloch_duplication",
		to = 88,
		from = 52
	},
	hero_oloch_duplication_death = {
		prefix = "hero_oloch_duplication",
		to = 1,
		from = 1
	},
	--死亡爆炸效果？
	hero_oloch_eternal_bidding_in_run = {
		prefix = "hero_oloch_eternal_bidding_in",
		to = 19,
		from = 1
	},
	hero_oloch_eternal_bidding_out_run = {
		prefix = "hero_oloch_eternal_bidding_out",
		to = 23,
		from = 1
	},
	--3技能
	hero_oloch_hellish_infusion_run = {
		prefix = "hero_oloch_hellish_infusion",
		to = 24,
		from = 1
	},
	--2技能
	hero_oloch_magma_eruption_decal_start = {
		prefix = "hero_oloch_magma_eruption_decal",
		to = 31,
		from = 1
	},
	hero_oloch_magma_eruption_decal_run = {
		prefix = "hero_oloch_magma_eruption_decal",
		to = 113,
		from = 32
	},
	hero_oloch_magma_eruption_explotion_run = {
		prefix = "hero_oloch_magma_eruption_explotion",
		to = 29,
		from = 1
	},
	--4技能
	hero_oloch_mega_bolt_travel = {
		prefix = "hero_oloch_mega_bolt",
		to = 10,
		from = 1
	},
	hero_oloch_mega_bolt_hit = {
		prefix = "hero_oloch_mega_bolt_hit",
		to = 24,
		from = 1
	},
	hero_oloch_mega_bolt_particle2_run = {
		prefix = "hero_oloch_mega_bolt_particle2",
		to = 8,
		from = 1
	},
	hero_oloch_mega_bolt_particle_run = {
		prefix = "hero_oloch_mega_bolt_particle",
		to = 8,
		from = 1
	},
	--大招
	hero_oloch_teleport_decal_run = {
		prefix = "hero_oloch_teleport_decal",
		to = 43,
		from = 1
	},
	hero_oloch_teleport_modifier_run = {
		prefix = "hero_oloch_teleport_modifier",
		to = 13,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_oloch.lua

-- BEGIN kr3/data/animations/kr4_hero_orc.lua
do
	local __chunk = (function()
return {
	--维鲁克本体
	hero_orc_idle = {
		prefix = "hero_orc",
		to = 1,
		from = 1
	},
	hero_orc_walk = {
		prefix = "hero_orc",
		to = 16,
		from = 2
	},
	hero_orc_melee = {
		prefix = "hero_orc",
		to = 36,
		from = 17
	},
	hero_orc_attack = {
		prefix = "hero_orc",
		to = 36,
		from = 17
	},
	hero_orc_melee2 = {
		prefix = "hero_orc",
		to = 65,
		from = 37
	},
	hero_orc_special = {
		prefix = "hero_orc",
		to = 111,
		from = 66
	},
	hero_orc_levelup = {
		prefix = "hero_orc",
		to = 128,
		from = 112
	},
	hero_orc_respawn = {
		prefix = "hero_orc",
		to = 128,
		from = 112
	},
	hero_orc_death = {
		prefix = "hero_orc",
		to = 163,
		from = 129
	},
	hero_orc_stun = {
		prefix = "hero_orc",
		to = 203,
		from = 164
	},
	hero_orc_call = {
		prefix = "hero_orc",
		to = 239,
		from = 204
	},
	hero_orc_decal_run = {
		prefix = "hero_orc_decal",
		to = 24,
		from = 1
	},
	hero_orc_leader_decal_run = {
		prefix = "hero_orc_leader_decal",
		to = 24,
		from = 1
	},
	hero_orc_spear_goblin_idle = {
		prefix = "hero_orc_spear_goblin",
		to = 1,
		from = 1
	},
	hero_orc_spear_goblin_in = {
		prefix = "hero_orc_spear_goblin",
		to = 9,
		from = 2
	},
	hero_orc_spear_goblin_walk = {
		prefix = "hero_orc_spear_goblin",
		to = 21,
		from = 10
	},
	hero_orc_spear_goblin_running = {
		prefix = "hero_orc_spear_goblin",
		to = 21,
		from = 10
	},
	hero_orc_spear_goblin_attack = {
		prefix = "hero_orc_spear_goblin",
		to = 45,
		from = 22
	},
	hero_orc_spear_goblin_melee = {
		prefix = "hero_orc_spear_goblin",
		to = 45,
		from = 22
	},
	hero_orc_spear_goblin_shoot = {
		prefix = "hero_orc_spear_goblin",
		to = 66,
		from = 46
	},
	hero_orc_spear_goblin_death = {
		prefix = "hero_orc_spear_goblin",
		to = 87,
		from = 67
	},
	hero_orc_spear_goblin_fx_run = {
		prefix = "hero_orc_spear_goblin_fx",
		to = 14,
		from = 1
	},
	hero_orc_spear_goblin_proyectile_decal_run = {
		prefix = "hero_orc_spear_goblin_proyectile_decal",
		to = 7,
		from = 1
	},
	hero_orc_stun_decal_run = {
		prefix = "hero_orc_stun_decal",
		to = 17,
		from = 1
	},
	reinforcement_goblin_idle = {
		prefix = "reinforcement_goblin",
		to = 1,
		from = 1
	},
	reinforcement_goblin_walk = {
		prefix = "reinforcement_goblin",
		to = 2,
		from = 9
	},
	reinforcement_goblin_running = {
		prefix = "reinforcement_goblin",
		to = 2,
		from = 9
	},
	reinforcement_goblin_melee = {
		prefix = "reinforcement_goblin",
		to = 10,
		from = 23
	},
	reinforcement_goblin_attack = {
		prefix = "reinforcement_goblin",
		to = 10,
		from = 23
	},
	reinforcement_goblin_death = {
		prefix = "reinforcement_goblin",
		to = 24,
		from = 36
	},
	reinforcement_goblin_spawn = {
		prefix = "reinforcement_goblin",
		to = 37,
		from = 56
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_orc.lua

-- BEGIN kr3/data/animations/kr4_hero_tank.lua
do
	local __chunk = (function()
return {
	hero_tank_idle = {
		prefix = "hero_tank",
		to = 1,
		from = 1
	},
	hero_tank_walkDown = {
		prefix = "hero_tank",
		to = 7,
		from = 2
	},
	hero_tank_moreDownWalk = {
		prefix = "hero_tank",
		to = 13,
		from = 8
	},
	hero_tank_downWalk = {
		prefix = "hero_tank",
		to = 19,
		from = 14
	},
	--实际用的时候用这个走路动画就行了
	hero_tank_walk = {
		prefix = "hero_tank",
		to = 25,
		from = 20
	},
	hero_tank_running = {
		prefix = "hero_tank",
		to = 25,
		from = 20
	},
	hero_tank_upWalk = {
		prefix = "hero_tank",
		to = 31,
		from = 26
	},
	hero_tank_moreUpWalk = {
		prefix = "hero_tank",
		to = 37,
		from = 32
	},
	hero_tank_walkUp = {
		prefix = "hero_tank",
		to = 43,
		from = 38
	},
	--普攻
	hero_tank_shoot = {
		prefix = "hero_tank",
		to = 92,
		from = 44
	},
	--2技能捶地
	hero_tank_GroundSlam = {
		prefix = "hero_tank",
		to = 148,
		from = 93
	},
	--1技能发射导弹
	hero_tank_HeatMissilesIn = {
		prefix = "hero_tank",
		to = 186,
		from = 149
	},
	hero_tank_HeatMissilesLoop = {
		prefix = "hero_tank",
		to = 191,
		from = 187
	},
	hero_tank_HeatMissilesLastLoop = {
		prefix = "hero_tank",
		to = 204,
		from = 192
	},
	hero_tank_HeatMissilesOut = {
		prefix = "hero_tank",
		to = 227,
		from = 205
	},
	--4技能喷火
	hero_tank_scorchingCannonIn = {
		prefix = "hero_tank",
		to = 243,
		from = 228
	},
	hero_tank_scorchingCannonLoop = {
		prefix = "hero_tank",
		to = 279,
		from = 244
	},
	hero_tank_scorchingCannonOut = {
		prefix = "hero_tank",
		to = 297,
		from = 280
	},
	--召唤援军。
	--说明：参考兵营塔。
	hero_tank_theExpendablesIn = {
		prefix = "hero_tank",
		to = 317,
		from = 298
	},
	hero_tank_theExpendablesSpawn = {
		prefix = "hero_tank",
		to = 341,
		from = 318
	},
	hero_tank_theExpendablesOut = {
		prefix = "hero_tank",
		to = 349,
		from = 342
	},
	--阵亡、重生与升级
	hero_tank_death = {
		prefix = "hero_tank",
		to = 473,
		from = 350
	},
	hero_tank_deathloop = {
		prefix = "hero_tank",
		to = 475,
		from = 474
	},
	hero_tank_respawn = {
		prefix = "hero_tank",
		to = 500,
		from = 476
	},
	hero_tank_levelup = {
		prefix = "hero_tank",
		to = 551,
		from = 501
	},
	--idle，也许可以替换
	hero_tank_boredIn = {
		prefix = "hero_tank",
		to = 569,
		from = 552
	},
	hero_tank_boredLoop = {
		prefix = "hero_tank",
		to = 577,
		from = 570
	},
	hero_tank_boredOut = {
		prefix = "hero_tank",
		to = 605,
		from = 578
	},
	--尾焰系统，计入本体的pryoectile
	hero_tank_dust_run = {
		prefix = "hero_tank_dust",
		to = 22,
		from = 1
	},
	hero_tank_dust_out = {
		prefix = "hero_tank_dust",
		to = 33,
		from = 23
	},
	hero_tank_smoke_run = {
		prefix = "hero_tank_smoke",
		to = 22,
		from = 1
	},
	--近战兵
	hero_tank_expendable1_idle = {
		prefix = "hero_tank_expendable1",
		to = 1,
		from = 1
	},
	hero_tank_expendable1_spawn = {
		prefix = "hero_tank_expendable1",
		to = 14,
		from = 2
	},
	hero_tank_expendable1_walk = {
		prefix = "hero_tank_expendable1",
		to = 28,
		from = 15
	},
	hero_tank_expendable1_running = {
		prefix = "hero_tank_expendable1",
		to = 28,
		from = 15
	},
	hero_tank_expendable1_melee = {
		prefix = "hero_tank_expendable1",
		to = 47,
		from = 29
	},
	hero_tank_expendable1_death = {
		prefix = "hero_tank_expendable1",
		to = 63,
		from = 48
	},
	--远程兵
	hero_tank_expendable2_idle = {
		prefix = "hero_tank_expendable2",
		to = 1,
		from = 1
	},
	hero_tank_expendable2_spawn = {
		prefix = "hero_tank_expendable2",
		to = 14,
		from = 2
	},
	hero_tank_expendable2_walk = {
		prefix = "hero_tank_expendable2",
		to = 28,
		from = 15
	},
	hero_tank_expendable2_running = {
		prefix = "hero_tank_expendable2",
		to = 28,
		from = 15
	},
	hero_tank_expendable2_melee = {
		prefix = "hero_tank_expendable2",
		to = 47,
		from = 29
	},
	hero_tank_expendable2_rangedSide = {
		prefix = "hero_tank_expendable2",
		to = 79,
		from = 48
	},
	hero_tank_expendable2_rangedDown = {
		prefix = "hero_tank_expendable2",
		to = 111,
		from = 80
	},
	hero_tank_expendable2_rangedUp = {
		prefix = "hero_tank_expendable2",
		to = 143,
		from = 112
	},
	hero_tank_expendable2_shoot = {
		prefix = "hero_tank_expendable2",
		to = 143,
		from = 112
	},
	hero_tank_expendable2_death = {
		prefix = "hero_tank_expendable2",
		to = 159,
		from = 144
	},
	--4技能火焰buff和地面效果
	hero_tank_fire_run = {
		prefix = "hero_tank_fire",
		to = 20,
		from = 1
	},
	hero_tank_fire_loop_in = {
		prefix = "hero_tank_fire_loop",
		to = 19,
		from = 1
	},
	hero_tank_fire_loop_run = {
		prefix = "hero_tank_fire_loop",
		to = 47,
		from = 20
	},
	hero_tank_fire_loop_out = {
		prefix = "hero_tank_fire_loop",
		to = 71,
		from = 48
	},
	--2技能捶地效果
	hero_tank_GroundSlam_decal_run = {
		prefix = "hero_tank_GroundSlam_decal",
		to = 19,
		from = 1
	},
	hero_tank_GroundSlam_effect_run = {
		prefix = "hero_tank_GroundSlam_effect",
		to = 2,
		from = 1
	},
	--普攻/导弹的对地/对空爆炸效果。
	hero_tank_hit_air_run = {
		prefix = "hero_tank_hit",
		to = 18,
		from = 1
	},
	hero_tank_hit_run = {
		prefix = "hero_tank_hit",
		to = 18,
		from = 1
	},
	--导弹的尾焰
	hero_tank_missile_particle_run = {
		prefix = "hero_tank_missile_particle",
		to = 6,
		from = 1
	},
	--大招的燃烧效果
	hero_tank_ultimate_fire_in = {
		prefix = "hero_tank_ultimate_fire",
		to = 24,
		from = 1
	},
	hero_tank_ultimate_fire_run = {
		prefix = "hero_tank_ultimate_fire",
		to = 49,
		from = 25
	},
	hero_tank_ultimate_fire_out = {
		prefix = "hero_tank_ultimate_fire",
		to = 67,
		from = 50
	},
	--大招的debuff效果
	hero_tank_ultimate_fire_modifier_in = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 8,
		from = 1
	},
	hero_tank_ultimate_fire_modifier_run = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 21,
		from = 9
	},
	hero_tank_ultimate_fire_modifier_out = {
		prefix = "hero_tank_ultimate_fire_modifier",
		to = 36,
		from = 22
	},
	--大招的飞机
	hero_tank_ultimate_plane_fly_idle = {
		prefix = "hero_tank_ultimate_plane",
		to = 4,
		from = 1
	},
	--大招爆炸效果
	hero_tank_ultimate_proyectile_explosion_run = {
		prefix = "hero_tank_ultimate_proyectile_explosion",
		to = 13,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_hero_tank.lua

-- BEGIN kr3/data/animations/kr4_stage1.lua
do
	local __chunk = (function()
return {
	fade_loop = {
		prefix = "Stage_106_lights_glow",
		to = 4,
		from = 1
	},
}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_stage1.lua

-- BEGIN kr3/data/animations/kr4_tower_balloon.lua
do
	local __chunk = (function()
local a = {
--tower2
    warmongers_baloon_tower_base_lvl4_light_run = {
        prefix = "warmongers_baloon_tower_base_lvl4_light",
        from = 1,
        to = 40
    },
    warmongers_baloon_tower_base_flag_run = {
        prefix = "warmongers_baloon_tower_base_flag",
        from = 1,
        to = 14
    },
--lookout
    warmongers_baloon_tower_lookout_lvl4_idle = {
        prefix = "warmongers_baloon_tower_lvl4_lookout",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_lookout_lvl4_spyglass = {
        prefix = "warmongers_baloon_tower_lvl4_lookout",
        from = 2,
        to = 57
    },
    warmongers_baloon_tower_lookout_lvl4_splash = {
        prefix = "warmongers_baloon_tower_lvl4_lookout",
        from = 58,
        to = 125
    },
--zapper
    warmongers_baloon_tower_lvl4_zapper_idle = {
        prefix = "warmongers_baloon_tower_lvl4_zapper",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_lvl4_zapper_running = {
        prefix = "warmongers_baloon_tower_lvl4_zapper",
        from = 2,
        to = 9
    },
    warmongers_baloon_tower_lvl4_zapper_attack = {
        prefix = "warmongers_baloon_tower_lvl4_zapper",
        from = 10,
        to = 38
    },
    warmongers_baloon_tower_lvl4_zapper_shoot = {
        prefix = "warmongers_baloon_tower_lvl4_zapper",
        from = 39,
        to = 54
    },
    warmongers_baloon_tower_lvl4_zapper_death = {
        prefix = "warmongers_baloon_tower_lvl4_zapper",
        from = 55,
        to = 67
    },
--run
    baloon_tower_splash_run = {
        prefix = "warmongers_baloon_tower_lvl4_splash",
        from = 1,
        to = 16
    },
    baloon_tower_pitch_run = {
        prefix = "warmongers_baloon_tower_lvl4_pitch",
        from = 1,
        to = 26
    },
    baloon_tower_paratrooper_run = {
        prefix = "warmongers_baloon_tower_lvl4_paratrooper",
        from = 1,
        to = 4
    },
--buff
    baloon_tower_buff_aura_run = {
        prefix = "warmongers_baloon_tower_lvl4_tower_buff_aura",
        from = 1,
        to = 30
    },
    baloon_tower_buff_run = {
        prefix = "warmongers_baloon_tower_lvl4_tower_buff",
        from = 1,
        to = 30
    },
--射手
    warmongers_baloon_tower_shooter_lvl1_idle = {
        prefix = "warmongers_baloon_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_shooter_lvl1_shoot = {
        prefix = "warmongers_baloon_tower_shooter_lvl1",
        from = 2,
        to = 40
    },
    warmongers_baloon_tower_shooter_lvl2_idle = {
        prefix = "warmongers_baloon_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_shooter_lvl2_shoot = {
        prefix = "warmongers_baloon_tower_shooter_lvl2",
        from = 2,
        to = 40
    },
    warmongers_baloon_tower_shooter_lvl3_idle = {
        prefix = "warmongers_baloon_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_shooter_lvl3_shoot = {
        prefix = "warmongers_baloon_tower_shooter_lvl3",
        from = 2,
        to = 40
    },
    warmongers_baloon_tower_shooter_lvl4_idle = {
        prefix = "warmongers_baloon_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_shooter_lvl4_shoot = {
        prefix = "warmongers_baloon_tower_shooter_lvl4",
        from = 2,
        to = 40
    },
--1级塔
    warmongers_baloon_tower_base_lvl1_layerX_idle = {
        layer_prefix = "warmongers_baloon_tower_base_lvl1_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_base_lvl1_layerX_flags = {
        layer_prefix = "warmongers_baloon_tower_base_lvl1_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 2,
        to = 60
    },
    warmongers_baloon_tower_base_lvl1_layerX_build = {
        layer_prefix = "warmongers_baloon_tower_base_lvl1_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 61,
        to = 61
    },
    GoblinBalloon_Lvl1_idle = {
        prefix = "warmongers_baloon_tower_lvl1",
        from = 1,
        to = 1,
    },
    GoblinBalloon_Lvl1_walk = {
        prefix = "warmongers_baloon_tower_lvl1",
        from = 1,
        to = 1,
    },
--2级塔
    warmongers_baloon_tower_base_lvl2_layerX_idle = {
        layer_prefix = "warmongers_baloon_tower_base_lvl2_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_base_lvl2_layerX_flags = {
        layer_prefix = "warmongers_baloon_tower_base_lvl2_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 2,
        to = 60
    },
    GoblinBalloon_Lvl2_idle = {
        prefix = "warmongers_baloon_tower_lvl2",
        from = 1,
        to = 1,
    },
    GoblinBalloon_Lvl2_walk = {
        prefix = "warmongers_baloon_tower_lvl2",
        from = 1,
        to = 1,
    },
--3级塔
    warmongers_baloon_tower_base_lvl3_layerX_idle = {
        layer_prefix = "warmongers_baloon_tower_base_lvl3_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_base_lvl3_layerX_flags = {
        layer_prefix = "warmongers_baloon_tower_base_lvl3_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 2,
        to = 60
    },
    GoblinBalloon_Lvl3_idle = {
        prefix = "warmongers_baloon_tower_lvl3",
        from = 1,
        to = 1,
    },
    GoblinBalloon_Lvl3_walk = {
        prefix = "warmongers_baloon_tower_lvl3",
        from = 1,
        to = 1,
    },
--4级塔
    warmongers_baloon_tower_base_lvl4_idle = {
        prefix = "warmongers_baloon_tower_base_lvl1_layer1",
        from = 1,
        to = 1,
    },
    warmongers_baloon_tower_base_lvl4_layerX_idle = {
        layer_prefix = "warmongers_baloon_tower_base_lvl4_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 1,
        to = 1
    },
    warmongers_baloon_tower_base_lvl4_layerX_flags = {
        layer_prefix = "warmongers_baloon_tower_base_lvl4_layer%i",
        layer_from = 1,
        layer_to = 2,
        from = 2,
        to = 68
    },
    warmongers_baloon_tower_lvl4_layerX_idle = {
        layer_prefix = "warmongers_baloon_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 1,
        to = 24
    },
    warmongers_baloon_tower_lvl4_layerX_walk = {
        layer_prefix = "warmongers_baloon_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 25,
        to = 49
    },
    warmongers_baloon_tower_lvl4_layerX_paratrooper = {
        layer_prefix = "warmongers_baloon_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 64,
        to = 104
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_balloon.lua

-- BEGIN kr3/data/animations/kr4_tower_blazing_watcher.lua
do
	local __chunk = (function()
local a = {
    --秒杀
    blazing_watcher_charged_blast_explotion_air_run = {
        prefix = "blazing_watcher_charged_blast_explotion_air",
        from = 1,
        to = 20
    },
    blazing_watcher_charged_blast_explotion_run = {
        prefix = "blazing_watcher_charged_blast_explotion",
        from = 1,
        to = 18
    },
    --爆炸
    blazing_watcher_explotion_run = {
        prefix = "blazing_watcher_explotion",
        from = 1,
        to = 21
    },
    blazing_watcher_explotion_level4Run = {
        prefix = "blazing_watcher_explotion",
        from = 22,
        to = 40
    },
    --宝石
    blazing_watcher_gem_idle = {
        prefix = "blazing_watcher_gem",
        from = 1,
        to = 1
    },
    blazing_watcher_gem_in = {
        prefix = "blazing_watcher_gem",
        from = 2,
        to = 18
    },
    blazing_watcher_gem_loop = {
        prefix = "blazing_watcher_gem",
        from = 19,
        to = 26
    },
    blazing_watcher_gem_out = {
        prefix = "blazing_watcher_gem",
        from = 27,
        to = 32
    },
    blazing_watcher_gem_level4In = {
        prefix = "blazing_watcher_gem",
        from = 33,
        to = 39
    },
    blazing_watcher_gem_level4Loop = {
        prefix = "blazing_watcher_gem",
        from = 40,
        to = 48
    },
    blazing_watcher_gem_level4Out = {
        prefix = "blazing_watcher_gem",
        from = 49,
        to = 54
    },
    blazing_watcher_gem_chargedBlast = {
        prefix = "blazing_watcher_gem",
        from = 55,
        to = 110
    },--这一条是秒杀

    --打击效果。前面2条是爆炸效果。
    blazing_watcher_gem_sparkles_run = {
        prefix = "blazing_watcher_gem_sparkles",
        from = 1,
        to = 12
    },
    blazing_watcher_gem_sparkles_level4Run = {
        prefix = "blazing_watcher_gem_sparkles",
        from = 13,
        to = 24
    },
    blazing_watcher_hit_run = {
        prefix = "blazing_watcher_hit",
        from = 1,
        to = 12
    },
    blazing_watcher_hit_level4Run = {
        prefix = "blazing_watcher_hit",
        from = 13,
        to = 24
    },
    --人物
    blazing_watcher_mage_1_idle = {
        prefix = "blazing_watcher_mage_1",
        from = 1,
        to = 1
    },
    blazing_watcher_mage_1_in = {
        prefix = "blazing_watcher_mage_1",
        from = 2,
        to = 13
    },
    blazing_watcher_mage_1_loop = {
        prefix = "blazing_watcher_mage_1",
        from = 14,
        to = 23
    },
    blazing_watcher_mage_1_out = {
        prefix = "blazing_watcher_mage_1",
        from = 24,
        to = 29
    },
    blazing_watcher_mage_2_idle = {
        prefix = "blazing_watcher_mage_2",
        from = 1,
        to = 1
    },
    blazing_watcher_mage_2_in = {
        prefix = "blazing_watcher_mage_2",
        from = 2,
        to = 13
    },
    blazing_watcher_mage_2_loop = {
        prefix = "blazing_watcher_mage_2",
        from = 14,
        to = 23
    },
    blazing_watcher_mage_2_out = {
        prefix = "blazing_watcher_mage_2",
        from = 24,
        to = 29
    },
    blazing_watcher_mage_3_idle = {
        prefix = "blazing_watcher_mage_3",
        from = 1,
        to = 1
    },
    blazing_watcher_mage_3_in = {
        prefix = "blazing_watcher_mage_3",
        from = 2,
        to = 13
    },
    blazing_watcher_mage_3_loop = {
        prefix = "blazing_watcher_mage_3",
        from = 14,
        to = 23
    },
    blazing_watcher_mage_3_out = {
        prefix = "blazing_watcher_mage_3",
        from = 24,
        to = 29
    },
    blazing_watcher_mage_4_idle = {
        prefix = "blazing_watcher_mage_4",
        from = 1,
        to = 1
    },
    blazing_watcher_mage_4_in = {
        prefix = "blazing_watcher_mage_4",
        from = 2,
        to = 13
    },
    blazing_watcher_mage_4_loop = {
        prefix = "blazing_watcher_mage_4",
        from = 14,
        to = 23
    },
    blazing_watcher_mage_4_out = {
        prefix = "blazing_watcher_mage_4",
        from = 24,
        to = 29
    },
    blazing_watcher_mage_5_idle = {
        prefix = "blazing_watcher_mage_5",
        from = 1,
        to = 1
    },
    blazing_watcher_mage_5_in = {
        prefix = "blazing_watcher_mage_5",
        from = 2,
        to = 13
    },
    blazing_watcher_mage_5_loop = {
        prefix = "blazing_watcher_mage_5",
        from = 14,
        to = 23
    },
    blazing_watcher_mage_5_out = {
        prefix = "blazing_watcher_mage_5",
        from = 24,
        to = 29
    },
--射线
    blazing_watcher_ray_in = {
        prefix = "blazing_watcher_ray",
        from = 1,
        to = 4
    },
    blazing_watcher_ray_loop = {
        prefix = "blazing_watcher_ray",
        from = 5,
        to = 12
    },
    blazing_watcher_ray_loop2 = {
        prefix = "blazing_watcher_ray",
        from = 13,
        to = 20
    },
    blazing_watcher_ray_loop3 = {
        prefix = "blazing_watcher_ray",
        from = 21,
        to = 36
    },
    blazing_watcher_ray_loop4 = {
        prefix = "blazing_watcher_ray",
        from = 37,
        to = 52
    },
    blazing_watcher_ray_out = {
        prefix = "blazing_watcher_ray",
        from = 53,
        to = 62
    },
    blazing_watcher_ray_level4Out = {
        prefix = "blazing_watcher_ray",
        from = 63,
        to = 72
    },
    blazing_watcher_ray_chargedBlast = {
        prefix = "blazing_watcher_ray",
        from = 73,
        to = 90
    },
    --防御塔
    darkarmy_blazing_watcher_tower_lvl1_build = {
        prefix = "blazing_watcher_tower_lvl1",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl1_idle = {
        prefix = "blazing_watcher_tower_lvl1",
        from = 2,
        to = 2
    },
    darkarmy_blazing_watcher_tower_lvl1_shoot = {
        prefix = "blazing_watcher_tower_lvl1",
        from = 2,
        to = 2
    },
    darkarmy_blazing_watcher_tower_lvl2_idle = {
        prefix = "blazing_watcher_tower_lvl2",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl2_shoot = {
        prefix = "blazing_watcher_tower_lvl2",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl3_idle = {
        prefix = "blazing_watcher_tower_lvl3",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl3_shoot = {
        prefix = "blazing_watcher_tower_lvl3",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl4_idle = {
        prefix = "blazing_watcher_tower_lvl4",
        from = 1,
        to = 1
    },
    darkarmy_blazing_watcher_tower_lvl4_shoot = {
        prefix = "blazing_watcher_tower_lvl4",
        from = 1,
        to = 1
    }
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_blazing_watcher.lua

-- BEGIN kr3/data/animations/kr4_tower_bone_flingers.lua
do
	local __chunk = (function()
local a = {
--防御塔
    fallen_ones_archer_towers_lvl1_build = {
        prefix = "boneflingers_tower_lvl1",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl1_idle = {
        prefix = "boneflingers_tower_lvl1",
        from = 2,
        to = 2
    },
    fallen_ones_archer_towers_lvl1_shoot = {
        prefix = "boneflingers_tower_lvl1",
        from = 2,
        to = 2
    },
    fallen_ones_archer_towers_lvl2_idle = {
        prefix = "boneflingers_tower_lvl2",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl2_shoot = {
        prefix = "boneflingers_tower_lvl2",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl3_idle = {
        prefix = "boneflingers_tower_lvl3",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl3_shoot = {
        prefix = "boneflingers_tower_lvl3",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl4_idle = {
        prefix = "boneflingers_tower_lvl4",
        from = 1,
        to = 1
    },
    fallen_ones_archer_towers_lvl4_shoot = {
        prefix = "boneflingers_tower_lvl4",
        from = 1,
        to = 1
    },
--塔上射手
    boneflingers_shooter_idleDown = {
        prefix = "boneflingers_shooter",
        from = 1,
        to = 1
    },
    boneflingers_shooter_shootingDown = {
        prefix = "boneflingers_shooter",
        from = 2,
        to = 16
    },
    boneflingers_shooter_idleUp = {
        prefix = "boneflingers_shooter",
        from = 17,
        to = 17
    },
    boneflingers_shooter_shootingUp = {
        prefix = "boneflingers_shooter",
        from = 18,
        to = 32
    },
--大骷髅
    boneflingers_tower_lvl4_golem_idle = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 1,
        to = 1
    },
    boneflingers_tower_lvl4_golem_running = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 2,
        to = 25
    },
    boneflingers_tower_lvl4_golem_attack = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 26,
        to = 58
    },
    boneflingers_tower_lvl4_golem_shoot = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 59,
        to = 71
    },
    boneflingers_tower_lvl4_golem_death = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 72,
        to = 111
    },
    boneflingers_tower_lvl4_golem_respawn = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 112,
        to = 144
    },
    boneflingers_tower_lvl4_golem_raise = {
        prefix = "boneflingers_tower_lvl4_golem",
        from = 145,
        to = 229
    },
--骷髅战士1级
    boneflingers_tower_lvl4_skeleton_raise = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 1,
        to = 62
    },
    boneflingers_tower_lvl4_skeleton_idle = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 63,
        to = 63
    },
    boneflingers_tower_lvl4_skeleton_running = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 64,
        to = 87
    },
    boneflingers_tower_lvl4_skeleton_walk = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 64,
        to = 87
    },
    boneflingers_tower_lvl4_skeleton_attack = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 88,
        to = 106
    },
    boneflingers_tower_lvl4_skeleton_death = {
        prefix = "boneflingers_tower_lvl4_skeleton",
        from = 107,
        to = 128
    },
--骷髅战士2级
    boneflingers_tower_lvl4_skeletonwarrior_raise = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 1,
        to = 62
    },
    boneflingers_tower_lvl4_skeletonwarrior_idle = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 63,
        to = 63
    },
    boneflingers_tower_lvl4_skeletonwarrior_running = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 64,
        to = 87
    },
    boneflingers_tower_lvl4_skeletonwarrior_walk = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 64,
        to = 87
    },
    boneflingers_tower_lvl4_skeletonwarrior_attack = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 88,
        to = 106
    },
    boneflingers_tower_lvl4_skeletonwarrior_death = {
        prefix = "boneflingers_tower_lvl4_skeletonwarrior",
        from = 107,
        to = 128
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_bone_flingers.lua

-- BEGIN kr3/data/animations/kr4_tower_dark_knight.lua
do
	local __chunk = (function()
local a = {
--兵1级
    dark_army_soldier_knight_lvl1_idle = {
        prefix = "darkarmy_soldier_lvl1",
        from = 1,
        to = 1,
    },
    dark_army_soldier_knight_lvl1_running = {
        prefix = "darkarmy_soldier_lvl1",
        from = 2,
        to = 7,
    },
    dark_army_soldier_knight_lvl1_attack = {
        prefix = "darkarmy_soldier_lvl1",
        from = 8,
        to = 24,
    },
    dark_army_soldier_knight_lvl1_death = {
        prefix = "darkarmy_soldier_lvl1",
        from = 25,
        to = 35,
    },
--兵2级
    dark_army_soldier_knight_lvl2_idle = {
        prefix = "darkarmy_soldier_lvl2",
        from = 1,
        to = 1,
    },
    dark_army_soldier_knight_lvl2_running = {
        prefix = "darkarmy_soldier_lvl2",
        from = 2,
        to = 7,
    },
    dark_army_soldier_knight_lvl2_attack = {
        prefix = "darkarmy_soldier_lvl2",
        from = 8,
        to = 24,
    },
    dark_army_soldier_knight_lvl2_death = {
        prefix = "darkarmy_soldier_lvl2",
        from = 25,
        to = 35,
    },
--兵3级
    dark_army_soldier_knight_lvl3_idle = {
        prefix = "darkarmy_soldier_lvl3",
        from = 1,
        to = 1,
    },
    dark_army_soldier_knight_lvl3_running = {
        prefix = "darkarmy_soldier_lvl3",
        from = 2,
        to = 8,
    },
    dark_army_soldier_knight_lvl3_attack = {
        prefix = "darkarmy_soldier_lvl3",
        from = 9,
        to = 25,
    },
    dark_army_soldier_knight_lvl3_death = {
        prefix = "darkarmy_soldier_lvl3",
        from = 26,
        to = 38,
    },
--兵4级，层次动画
    darkarmy_soldier_lvl4_layer1_idle = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 1,
        to = 1,
    },
    darkarmy_soldier_lvl4_layer1_running = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 2,
        to = 22,
    },
    darkarmy_soldier_lvl4_layer1_attack = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 23,
        to = 42,
    },
    darkarmy_soldier_lvl4_layer1_death = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 43,
        to = 60,
    },
    darkarmy_soldier_lvl4_layer1_imperviousIntro = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 61,
        to = 113,
    },
    darkarmy_soldier_lvl4_layer1_imperviousStop = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 114,
        to = 114,
    },
    darkarmy_soldier_lvl4_layer1_imperviousOut = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 115,
        to = 132,
    },
    darkarmy_soldier_lvl4_layer1_merciless = {
        prefix = "darkarmy_soldier_lvl4_layer1",
        from = 133,
        to = 195,
    },
    darkarmy_soldier_lvl4_layer3_idle = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 1,
        to = 1,
    },
    darkarmy_soldier_lvl4_layer3_running = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 2,
        to = 22,
    },
    darkarmy_soldier_lvl4_layer3_attack = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 23,
        to = 42,
    },
    darkarmy_soldier_lvl4_layer3_death = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 43,
        to = 60,
    },
    darkarmy_soldier_lvl4_layer3_imperviousIntro = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 61,
        to = 113,
    },
    darkarmy_soldier_lvl4_layer3_imperviousStop = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 114,
        to = 114,
    },
    darkarmy_soldier_lvl4_layer3_imperviousOut = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 115,
        to = 132,
    },
    darkarmy_soldier_lvl4_layer3_merciless = {
        prefix = "darkarmy_soldier_lvl4_layer3",
        from = 133,
        to = 195,
    },
    darkarmy_soldier_lvl4_layer2_idle = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 1,
        to = 1,
    },
    darkarmy_soldier_lvl4_layer2_running = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 2,
        to = 22,
    },
    darkarmy_soldier_lvl4_layer2_attack = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 23,
        to = 42,
    },
    darkarmy_soldier_lvl4_layer2_death = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 43,
        to = 60,
    },
    darkarmy_soldier_lvl4_layer2_imperviousIntro = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 61,
        to = 113,
    },
    darkarmy_soldier_lvl4_layer2_imperviousStop = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 114,
        to = 114,
    },
    darkarmy_soldier_lvl4_layer2_imperviousOut = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 115,
        to = 132,
    },
    darkarmy_soldier_lvl4_layer2_merciless = {
        prefix = "darkarmy_soldier_lvl4_layer2",
        from = 133,
        to = 195,
    },
--防御塔1级
    darkarmy_barrack_towers_lvl1_layer1_build = {
        prefix = "darkarmy_barrack_tower_lvl1_layer1",
        from = 1,
        to = 1,
    },
    darkarmy_barrack_towers_lvl1_layer1_idle = {
        prefix = "darkarmy_barrack_tower_lvl1_layer1",
        from = 3,
        to = 3,
    },
    darkarmy_barrack_towers_lvl1_layer1_open = {
        prefix = "darkarmy_barrack_tower_lvl1_layer1",
        from = 3,
        to = 18,
    },
    darkarmy_barrack_towers_lvl1_layer1_close = {
        prefix = "darkarmy_barrack_tower_lvl1_layer1",
        from = 19,
        to = 32,
    },
    darkarmy_barrack_towers_lvl1_layer1_openclose = {
        prefix = "darkarmy_barrack_tower_lvl1_layer1",
        from = 3,
        to = 32,
    },
    darkarmy_barrack_towers_lvl1_layer2_idle = {
        prefix = "darkarmy_barrack_tower_lvl1_layer2",
        from = 2,
        to = 2,
    },
    
    darkarmy_barrack_towers_lvl1_layer2_open = {
        prefix = "darkarmy_barrack_tower_lvl1_layer2",
        from = 3,
        to = 18,
    },
    darkarmy_barrack_towers_lvl1_layer2_close = {
        prefix = "darkarmy_barrack_tower_lvl1_layer2",
        from = 19,
        to = 32,
    },
    darkarmy_barrack_towers_lvl1_layer2_openclose = {
        prefix = "darkarmy_barrack_tower_lvl1_layer2",
        from = 3,
        to = 32,
    },
--防御塔2级
    darkarmy_barrack_towers_lvl2_layer1_idle = {
        prefix = "darkarmy_barrack_tower_lvl2_layer1",
        from = 2,
        to = 2,
    },
    darkarmy_barrack_towers_lvl2_layer1_open = {
        prefix = "darkarmy_barrack_tower_lvl2_layer1",
        from = 2,
        to = 17,
    },
    darkarmy_barrack_towers_lvl2_layer1_close = {
        prefix = "darkarmy_barrack_tower_lvl2_layer1",
        from = 18,
        to = 31,
    },
    darkarmy_barrack_towers_lvl2_layer2_idle = {
        prefix = "darkarmy_barrack_tower_lvl2_layer2",
        from = 1,
        to = 1,
    },
    darkarmy_barrack_towers_lvl2_layer2_open = {
        prefix = "darkarmy_barrack_tower_lvl2_layer2",
        from = 2,
        to = 17,
    },
    darkarmy_barrack_towers_lvl2_layer2_close = {
        prefix = "darkarmy_barrack_tower_lvl2_layer2",
        from = 18,
        to = 31,
    },
--防御塔3级
    darkarmy_barrack_towers_lvl3_layer1_idle = {
        prefix = "darkarmy_barrack_tower_lvl3_layer1",
        from = 2,
        to = 2,
    },
    darkarmy_barrack_towers_lvl3_layer1_open = {
        prefix = "darkarmy_barrack_tower_lvl3_layer1",
        from = 2,
        to = 17,
    },
    darkarmy_barrack_towers_lvl3_layer1_close = {
        prefix = "darkarmy_barrack_tower_lvl3_layer1",
        from = 18,
        to = 31,
    },
    darkarmy_barrack_towers_lvl3_layer2_idle = {
        prefix = "darkarmy_barrack_tower_lvl3_layer2",
        from = 1,
        to = 1,
    },
    darkarmy_barrack_towers_lvl3_layer2_open = {
        prefix = "darkarmy_barrack_tower_lvl3_layer2",
        from = 2,
        to = 17,
    },
    darkarmy_barrack_towers_lvl3_layer2_close = {
        prefix = "darkarmy_barrack_tower_lvl3_layer2",
        from = 18,
        to = 31,
    },
--防御塔4级
    darkarmy_barrack_towers_lvl4_layer1_idle = {
        prefix = "darkarmy_barrack_tower_lvl4_layer1",
        from = 2,
        to = 2,
    },
    darkarmy_barrack_towers_lvl4_layer1_open = {
        prefix = "darkarmy_barrack_tower_lvl4_layer1",
        from = 2,
        to = 15,
    },
    darkarmy_barrack_towers_lvl4_layer1_close = {
        prefix = "darkarmy_barrack_tower_lvl4_layer1",
        from = 16,
        to = 29,
    },
    darkarmy_barrack_towers_lvl4_layer2_idle = {
        prefix = "darkarmy_barrack_tower_lvl4_layer2",
        from = 1,
        to = 1,
    },
    darkarmy_barrack_towers_lvl4_layer2_open = {
        prefix = "darkarmy_barrack_tower_lvl4_layer2",
        from = 2,
        to = 15,
    },
    darkarmy_barrack_towers_lvl4_layer2_close = {
        prefix = "darkarmy_barrack_tower_lvl4_layer2",
        from = 16,
        to = 29,
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_dark_knight.lua

-- BEGIN kr3/data/animations/kr4_tower_deep_devils.lua
do
	local __chunk = (function()
local a = {
--塔
    deep_devils_reef_towers_lvl1_idle = {
        prefix = "deep_devils_reef_towers_lvl1_layer2",
        from = 2,
        to = 2,
    },
    deep_devils_reef_towers_lvl1_open = {
        prefix = "deep_devils_reef_towers_lvl1_layer2",
        from = 3,
        to = 7,
    },
    deep_devils_reef_towers_lvl1_close = {
        prefix = "deep_devils_reef_towers_lvl1_layer2",
        from = 8,
        to = 12,
    },
    deep_devils_reef_towers_lvl2_idle = {
        prefix = "deep_devils_reef_towers_lvl2_layer2",
        from = 1,
        to = 1
    },
    deep_devils_reef_towers_lvl2_open = {
        prefix = "deep_devils_reef_towers_lvl2_layer2",
        from = 2,
        to = 6,
    },
    deep_devils_reef_towers_lvl2_close = {
        prefix = "deep_devils_reef_towers_lvl2_layer2",
        from = 7,
        to = 11,
    },
    deep_devils_reef_towers_lvl3_idle = {
        prefix = "deep_devils_reef_towers_lvl3_layer2",
        from = 1,
        to = 1
    },
    deep_devils_reef_towers_lvl3_open = {
        prefix = "deep_devils_reef_towers_lvl3_layer2",
        from = 2,
        to = 6,
    },
    deep_devils_reef_towers_lvl3_close = {
        prefix = "deep_devils_reef_towers_lvl3_layer2",
        from = 7,
        to = 11,
    },
    deep_devils_reef_towers_lvl4_open = {
        prefix = "deep_devils_reef_towers_lvl3_layer2",
        from = 6,
        to = 6,
    },
    deep_devils_reef_towers_lvl4_close = {
        prefix = "deep_devils_reef_towers_lvl3_layer2",
        from = 7,
        to = 7,
    },
--鱼人矛
    deep_devils_reef_tower_greenfin_spear_decal_lvl1_run = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl1",
        from = 1,
        to = 8,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl1_idle = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl1",
        from = 9,
        to = 9,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl2_run = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl2",
        from = 1,
        to = 8,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl2_idle = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl2",
        from = 9,
        to = 9,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl3_run = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl3",
        from = 1,
        to = 8,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl3_idle = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl3",
        from = 9,
        to = 9,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl4_run = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl4",
        from = 1,
        to = 8,
    },
    deep_devils_reef_tower_greenfin_spear_decal_lvl4_idle = {
        prefix = "deep_devils_reef_tower_greenfin_spear_decal_lvl4",
        from = 9,
        to = 9,
    },
--鱼人
    deep_devils_reef_tower_greenfin_lvl3_idle = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_greenfin_lvl3_walk = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl3_running = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl3_attack = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 10,
        to = 29
    },
    deep_devils_reef_tower_greenfin_lvl3_shoot = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 30,
        to = 65
    },
    deep_devils_reef_tower_greenfin_lvl3_death = {
        prefix = "deep_devils_reef_tower_greenfin_lvl3",
        from = 66,
        to = 93
    },
    deep_devils_reef_tower_greenfin_lvl2_idle = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_greenfin_lvl2_walk = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl2_running = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl2_attack = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 10,
        to = 29
    },
    deep_devils_reef_tower_greenfin_lvl2_shoot = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 30,
        to = 65
    },
    deep_devils_reef_tower_greenfin_lvl2_death = {
        prefix = "deep_devils_reef_tower_greenfin_lvl2",
        from = 66,
        to = 93
    },
    deep_devils_reef_tower_greenfin_lvl1_idle = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_greenfin_lvl1_walk = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl1_running = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 2,
        to = 9
    },
    deep_devils_reef_tower_greenfin_lvl1_attack = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 10,
        to = 29
    },
    deep_devils_reef_tower_greenfin_lvl1_shoot = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 30,
        to = 65
    },
    deep_devils_reef_tower_greenfin_lvl1_death = {
        prefix = "deep_devils_reef_tower_greenfin_lvl1",
        from = 66,
        to = 93
    },
--4级鱼人
    deep_devils_reef_tower_redspine_lvl4_layerX_idle = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_walk = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 2,
        to = 13
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_running = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 2,
        to = 13
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_attack = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 14,
        to = 33
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_shoot = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 34,
        to = 58
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_death = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 59,
        to = 89
    },
    deep_devils_reef_tower_redspine_lvl4_layerX_net = {
        layer_prefix = "deep_devils_reef_tower_redspine_lv4_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 90,
        to = 109
    },
--投网
    deep_devils_reef_tower_redspine_skill_net_active_in = {
        prefix = "deep_devils_reef_tower_redspine_skill_net_active",
        from = 1,
        to = 6
    },
    deep_devils_reef_tower_redspine_skill_net_active_loop = {
        prefix = "deep_devils_reef_tower_redspine_skill_net_active",
        from = 7,
        to = 47
    },
    deep_devils_reef_tower_redspine_skill_net_active_out = {
        prefix = "deep_devils_reef_tower_redspine_skill_net_active",
        from = 48,
        to = 62
    },
    deep_devils_reef_tower_redspine_skill_net_decal_run = {
        prefix = "deep_devils_reef_tower_redspine_skill_net_decal",
        from = 1,
        to = 10
    },
--雷暴
    deep_devils_reef_tower_storm_bolt_travel = {
        prefix = "deep_devils_reef_tower_storm_bolt",
        from = 1,
        to = 19
    },
    --deep_devils_reef_tower_storm_cloud_small = {
    --    prefix = "deep_devils_reef_tower_storm_cloud",
    --    from = 1,
    --    to = 32
    --},
    deep_devils_reef_tower_storm_cloud_small = {
		prefix = "mage_highElven_balls",
		to = 1,
		from = 1
	},
    deep_devils_reef_tower_storm_cloud_big = {
        prefix = "deep_devils_reef_tower_storm_cloud",
        from = 1,
        to = 32
    },
    deep_devils_reef_tower_storm_cloud_shoot = {
        prefix = "deep_devils_reef_tower_storm_cloud",
        from = 33,
        to = 64
    },
    deep_devils_reef_tower_storm_bolt_hit_small_loop = {
        prefix = "deep_devils_reef_tower_storm_bolt_hit",
        from = 1,
        to = 14
    },
--射手
    deep_devils_reef_tower_shooter_hit = {
        prefix = "deep_devils_reef_tower_shooter_hit",
        from = 1,
        to = 9
    },
    deep_devils_reef_tower_shooter_lvl1_idle = {
        prefix = "deep_devils_reef_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_shooter_lvl1_shootDown = {
        prefix = "deep_devils_reef_tower_shooter_lvl1",
        from = 2,
        to = 30
    },
    deep_devils_reef_tower_shooter_lvl1_idleUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl1",
        from = 31,
        to = 31
    },
    deep_devils_reef_tower_shooter_lvl1_shootUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl1",
        from = 32,
        to = 60
    },
    deep_devils_reef_tower_shooter_lvl2_idle = {
        prefix = "deep_devils_reef_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_shooter_lvl2_shootDown = {
        prefix = "deep_devils_reef_tower_shooter_lvl2",
        from = 2,
        to = 30
    },
    deep_devils_reef_tower_shooter_lvl2_idleUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl2",
        from = 31,
        to = 31
    },
    deep_devils_reef_tower_shooter_lvl2_shootUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl2",
        from = 32,
        to = 60
    },
    deep_devils_reef_tower_shooter_lvl3_idle = {
        prefix = "deep_devils_reef_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_shooter_lvl3_shootDown = {
        prefix = "deep_devils_reef_tower_shooter_lvl3",
        from = 2,
        to = 30
    },
    deep_devils_reef_tower_shooter_lvl3_idleUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl3",
        from = 31,
        to = 31
    },
    deep_devils_reef_tower_shooter_lvl3_shootUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl3",
        from = 32,
        to = 60
    },
    deep_devils_reef_tower_shooter_lvl4_idle = {
        prefix = "deep_devils_reef_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    deep_devils_reef_tower_shooter_lvl4_shootDown = {
        prefix = "deep_devils_reef_tower_shooter_lvl4",
        from = 2,
        to = 30
    },
    deep_devils_reef_tower_shooter_lvl4_idleUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl4",
        from = 31,
        to = 31
    },
    deep_devils_reef_tower_shooter_lvl4_shootUp = {
        prefix = "deep_devils_reef_tower_shooter_lvl4",
        from = 32,
        to = 60
    },

}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_deep_devils.lua

-- BEGIN kr3/data/animations/kr4_tower_goblirang.lua
do
	local __chunk = (function()
local a = {
--spear_throwers
    warmongers_archer_tower_lvl4_honda_front_run = {
        prefix = "warmongers_archer_tower_lvl4_honda_front",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_lvl4_honda_front_start = {
        prefix = "warmongers_archer_tower_lvl4_honda_front",
        from = 2,
        to = 35
    },
    warmongers_archer_tower_lvl4_honda_back_run = {
        prefix = "warmongers_archer_tower_lvl4_honda_back",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_lvl4_honda_back_start = {
        prefix = "warmongers_archer_tower_lvl4_honda_back",
        from = 2,
        to = 35
    },
--proyectile_hit
    warmongers_archer_tower_proyectile_hit_run = {
        prefix = "warmongers_archer_tower_hit",
        from = 1,
        to = 7
    },
    warmongers_archer_tower_proyectile_special_hit_run = {
        prefix = "warmongers_archer_tower_lvl4_special_hit",
        from = 1,
        to = 8
    },
    warmongers_archer_tower_proyectile_spineffect_run = {
        prefix = "warmongers_archer_tower_proyectile_spineffect",
        from = 1,
        to = 6
    },
--honey
    particle_honey_run = {
        prefix = "warmongers_archer_tower_lvl4_honey_particle",
        from = 1,
        to = 22
    },
    explosion_honey_start = {
        prefix = "warmongers_archer_tower_lvl4_honey_explosion",
        from = 1,
        to = 10
    },
    explosion_honey_run = {
        prefix = "warmongers_archer_tower_lvl4_honey_cloud",
        from = 1,
        to = 18
    },
--投弹手lvl1
    warmongers_archer_tower_shooter_lvl1_idle = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_shooter_lvl1_shootDownIn = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 2,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl1_shootDownIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 18,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl1_shootDownOut = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 19,
        to = 24
    },
    warmongers_archer_tower_shooter_lvl1_idleUp = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 25,
        to = 25
    },
    warmongers_archer_tower_shooter_lvl1_shootUpIn = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 26,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl1_shootUpIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 42,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl1_shootUpOut = {
        prefix = "warmongers_archer_tower_shooter_lvl1",
        from = 43,
        to = 48
    },
--投弹手lvl2
    warmongers_archer_tower_shooter_lvl2_idle = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_shooter_lvl2_shootDownIn = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 2,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl2_shootDownIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 18,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl2_shootDownOut = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 19,
        to = 24
    },
    warmongers_archer_tower_shooter_lvl2_idleUp = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 25,
        to = 25
    },
    warmongers_archer_tower_shooter_lvl2_shootUpIn = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 26,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl2_shootUpIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 42,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl2_shootUpOut = {
        prefix = "warmongers_archer_tower_shooter_lvl2",
        from = 43,
        to = 48
    },
--投弹手lvl3
    warmongers_archer_tower_shooter_lvl3_idle = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_shooter_lvl3_shootDownIn = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 2,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl3_shootDownIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 18,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl3_shootDownOut = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 19,
        to = 24
    },
    warmongers_archer_tower_shooter_lvl3_idleUp = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 25,
        to = 25
    },
    warmongers_archer_tower_shooter_lvl3_shootUpIn = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 26,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl3_shootUpIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 42,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl3_shootUpOut = {
        prefix = "warmongers_archer_tower_shooter_lvl3",
        from = 43,
        to = 48
    },
--投弹手lvl4
    warmongers_archer_tower_shooter_lvl4_idle = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    warmongers_archer_tower_shooter_lvl4_shootDownIn = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 2,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl4_shootDownIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 18,
        to = 18
    },
    warmongers_archer_tower_shooter_lvl4_shootDownOut = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 19,
        to = 24
    },
    warmongers_archer_tower_shooter_lvl4_idleUp = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 25,
        to = 25
    },
    warmongers_archer_tower_shooter_lvl4_shootUpIn = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 26,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl4_shootUpIdle = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 42,
        to = 42
    },
    warmongers_archer_tower_shooter_lvl4_shootUpOut = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 43,
        to = 48
    },
--投弹手扔大号回旋镖
    warmongers_archer_tower_shooter_lvl4_megaShootDownIn1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 49,
        to = 74
    },
    warmongers_archer_tower_shooter_lvl4_megaShootDownIdle1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 75,
        to = 75
    },
    warmongers_archer_tower_shooter_lvl4_megaShootDownOut1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 76,
        to = 89
    },
    warmongers_archer_tower_shooter_lvl4_megaShootDownIn2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 90,
        to = 115
    },
    warmongers_archer_tower_shooter_lvl4_megaShootDownIdle2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 116,
        to = 116
    },
    warmongers_archer_tower_shooter_lvl4_megaShootDownOut2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 117,
        to = 130
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpIn1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 131,
        to = 156
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpIdle1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 157,
        to = 157
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpOut1 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 158,
        to = 171
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpIn2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 172,
        to = 197
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpIdle2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 198,
        to = 198
    },
    warmongers_archer_tower_shooter_lvl4_megaShootUpOut2 = {
        prefix = "warmongers_archer_tower_shooter_lvl4",
        from = 199,
        to = 212
    },
--投弹手扔蜂窝
    warmongers_archer_tower_shooter_lvl4_shootHoneyDown = {
        prefix = "warmongers_archerhoney_tower_shooter_lvl4",
        from = 2,
        to = 17
    },
    warmongers_archer_tower_shooter_lvl4_shootHoneyUp = {
        prefix = "warmongers_archerhoney_tower_shooter_lvl4",
        from = 19,
        to = 34
    },
--防御塔
    archer_towers_lvl1_build = {
        prefix = "warmongers_archer_tower_lvl1",
        from = 2,
        to = 2
    },
    archer_towers_lvl1_idle = {
        prefix = "warmongers_archer_tower_lvl1",
        from = 1,
        to = 1
    },
    archer_towers_lvl1_shoot = {
        prefix = "warmongers_archer_tower_lvl1",
        from = 1,
        to = 1
    },
    archer_towers_lvl2_idle = {
        prefix = "warmongers_archer_tower_lvl2",
        from = 1,
        to = 1
    },
    archer_towers_lvl2_shoot = {
        prefix = "warmongers_archer_tower_lvl2",
        from = 1,
        to = 1
    },
    archer_towers_lvl3_idle = {
        prefix = "warmongers_archer_tower_lvl3",
        from = 1,
        to = 1
    },
    archer_towers_lvl3_shoot = {
        prefix = "warmongers_archer_tower_lvl3",
        from = 1,
        to = 1
    },
    archer_towers_lvl4_idle = {
        prefix = "warmongers_archer_tower_lvl4",
        from = 1,
        to = 1
    },
    archer_towers_lvl4_shoot = {
        prefix = "warmongers_archer_tower_lvl4",
        from = 1,
        to = 1
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_goblirang.lua

-- BEGIN kr3/data/animations/kr4_tower_grim_cemetery.lua
do
	local __chunk = (function()
local a = {
--塔
    fallen_ones_grim_cemetery_tower_lvl1_build = {
        prefix = "fallen_ones_grim_cemetery_tower_lvl1",
        from = 1,
        to = 1,
    },
    fallen_ones_grim_cemetery_tower_lvl1_idle = {
        prefix = "fallen_ones_grim_cemetery_tower_lvl1",
        from = 2,
        to = 2,
    },
    fallen_ones_grim_cemetery_tower_lvl2_idle = {
        prefix = "fallen_ones_grim_cemetery_tower_lvl2",
        from = 1,
        to = 1,
    },
    fallen_ones_grim_cemetery_tower_lvl3_idle = {
        prefix = "fallen_ones_grim_cemetery_tower_lvl3",
        from = 1,
        to = 1,
    },
    fallen_ones_grim_cemetery_tower_lvl4_idle = {
        prefix = "fallen_ones_grim_cemetery_tower_lvl4",
        from = 1,
        to = 1,
    },
--普通僵尸
    grim_cemetery_zombie_idle = {
        prefix = "grim_cemetery_zombie",
        from = 1,
        to = 35
    },
    grim_cemetery_zombie_running = {
        prefix = "grim_cemetery_zombie",
        from = 36,
        to = 59
    },
    grim_cemetery_zombie_attack = {
        prefix = "grim_cemetery_zombie",
        from = 60,
        to = 94
    },
    grim_cemetery_zombie_raise = {
        prefix = "grim_cemetery_zombie",
        from = 95,
        to = 147
    },
    grim_cemetery_zombie_death = {
        prefix = "grim_cemetery_zombie",
        from = 148,
        to = 187
    },
    grim_cemetery_zombie_bloatedDeath = {
        prefix = "grim_cemetery_zombie",
        from = 188,
        to = 237
    },
--强化僵尸
    grim_cemetery_zombie_medium_idle = {
        prefix = "grim_cemetery_zombie_medium",
        from = 1,
        to = 35
    },
    grim_cemetery_zombie_medium_running = {
        prefix = "grim_cemetery_zombie_medium",
        from = 36,
        to = 59
    },
    grim_cemetery_zombie_medium_attack = {
        prefix = "grim_cemetery_zombie_medium",
        from = 60,
        to = 94
    },
    grim_cemetery_zombie_medium_raise = {
        prefix = "grim_cemetery_zombie_medium",
        from = 95,
        to = 147
    },
    grim_cemetery_zombie_medium_death = {
        prefix = "grim_cemetery_zombie_medium",
        from = 148,
        to = 187
    },
    grim_cemetery_zombie_medium_bloatedDeath = {
        prefix = "grim_cemetery_zombie_medium",
        from = 188,
        to = 237
    },
--肌酸僵尸
    grim_cemetery_zombie_better_idle = {
        prefix = "grim_cemetery_zombie_better",
        from = 1,
        to = 31
    },
    grim_cemetery_zombie_better_running = {
        prefix = "grim_cemetery_zombie_better",
        from = 32,
        to = 55
    },
    grim_cemetery_zombie_better_attack = {
        prefix = "grim_cemetery_zombie_better",
        from = 56,
        to = 90
    },
    grim_cemetery_zombie_better_raise = {
        prefix = "grim_cemetery_zombie_better",
        from = 91,
        to = 144
    },
    grim_cemetery_zombie_better_death = {
        prefix = "grim_cemetery_zombie_better",
        from = 145,
        to = 183
    },
    grim_cemetery_zombie_better_bloatedDeath = {
        prefix = "grim_cemetery_zombie_better",
        from = 184,
        to = 233
    },
--爆炸效果
    grim_cemetery_zombie_pestilence_idle = {
        prefix = "grim_cemetery_zombie_pestilence",
        from = 1,
        to = 26
    },
    grim_cemetery_zombie_pestilence_raise = {
        prefix = "grim_cemetery_zombie_pestilence",
        from = 1,
        to = 26
    },
    grim_cemetery_zombie_pestilence_attack = {
        prefix = "grim_cemetery_zombie_pestilence",
        from = 1,
        to = 26
    },
    grim_cemetery_zombie_pestilence_death = {
        prefix = "grim_cemetery_zombie_pestilence",
        from = 1,
        to = 26
    },
    grim_cemetery_zombie_pestilence_running = {
        prefix = "grim_cemetery_zombie_pestilence",
        from = 1,
        to = 26
    },
--抓手
    fallen_ones_grim_cemetery_hand1_in = {
        prefix = "fallen_ones_grim_cemetery_hand1",
        from = 1,
        to = 14
    },
    fallen_ones_grim_cemetery_hand1_run = {
        prefix = "fallen_ones_grim_cemetery_hand1",
        from = 15,
        to = 55
    },
    fallen_ones_grim_cemetery_hand1_out = {
        prefix = "fallen_ones_grim_cemetery_hand1",
        from = 56,
        to = 69
    },
    fallen_ones_grim_cemetery_hand2_in = {
        prefix = "fallen_ones_grim_cemetery_hand2",
        from = 1,
        to = 14
    },
    fallen_ones_grim_cemetery_hand2_run = {
        prefix = "fallen_ones_grim_cemetery_hand2",
        from = 15,
        to = 55
    },
    fallen_ones_grim_cemetery_hand2_out = {
        prefix = "fallen_ones_grim_cemetery_hand2",
        from = 56,
        to = 69
    },
--雾
    fallen_ones_grim_cemetery_fog_run = {
        prefix = "fallen_ones_grim_cemetery_fog",
        from = 1,
        to = 48
    },
    fallen_ones_grim_cemetery_fog1_run = {
        prefix = "fallen_ones_grim_cemetery_fly_1",
        from = 1,
        to = 48
    },
    fallen_ones_grim_cemetery_fog2_run = {
        prefix = "fallen_ones_grim_cemetery_fly_2",
        from = 1,
        to = 48
    },
    fallen_ones_grim_cemetery_fog3_run = {
        prefix = "fallen_ones_grim_cemetery_fly_3",
        from = 1,
        to = 48
    },


}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_grim_cemetery.lua

-- BEGIN kr3/data/animations/kr4_tower_ignis_altar.lua
do
	local __chunk = (function()
local a = {
    
    --炸弹进火山
    ignis_altar_lava_bubble_in = {
        prefix = "asst_torre_volcan_decal_bubbles",
        from = 1,
        to = 9
    },
    --普攻发射动画（火山口）
    ignis_altar_lava_bubble_shoot = {
        prefix = "asst_torre_volcan_decal_bubbles",
        from = 1,
        to = 9
    },
    --普攻炸弹
    ignis_altar_base_bullet = {
        prefix = "asst_torre_volcan_proyectl_bola",
        from = 1,
        to = 1
    },
    --普攻尾焰
    ignis_altar_bullet_smoke = {
        prefix = "asst_particle_f",
        from = 1,
        to = 6
    },
    --普攻爆炸效果
    ignis_altar_base_explosion = {
        prefix = "asst_lavaboomb",
        from = 1,
        to = 14
    },
    --弹坑
    ignis_altar_base_crater = {
        prefix = "asst_torre_volcan_decal_grietas",
        from = 1,
        to = 1
    },
    
    --1技能傀儡 暂时使用土元素代替
    --2技能业火轮
    ignis_altar_taunt2_bullet_flying = {
        prefix = "asst_extra_magic",
        from = 1,
        to = 1
    },
    ignis_altar_taunt2_debuff = {
        prefix = "asst_lavadebuffb",
        from = 1,
        to = 9
    },

    --3技能迟滞真炎
    ignis_altar_taunt3_loop = {
        prefix = "asst_torre_volcan_decal",
        from = 1,
        to = 1
    },
    ignis_altar_taunt3_fade = {
        prefix = "asst_torre_volcan_decal",
        from = 1,
        to = 5
    },

    --防御塔贴图
    ignis_altar_tower_lvl1_build = {
        prefix = "asst_tower_volcan_building",
        from = 1,
        to = 1
    },
    ignis_altar_tower_lvl1_idle = {
        prefix = "asst_tower_volcan",
        from = 1,
        to = 1
    },
    ignis_altar_tower_lvl1_shoot = {
        prefix = "asst_tower_volcan",
        from = 1,
        to = 1
    },
    ignis_altar_tower_lvl2_idle = {
        prefix = "asst_tower_volcan",
        from = 5,
        to = 5
    },
    ignis_altar_tower_lvl2_shoot = {
        prefix = "asst_tower_volcan",
        from = 5,
        to = 5
    },
    ignis_altar_tower_lvl3_idle = {
        prefix = "asst_tower_volcan",
        from = 8,
        to = 8
    },
    ignis_altar_tower_lvl3_shoot = {
        prefix = "asst_tower_volcan",
        from = 8,
        to = 8
    },
    ignis_altar_tower_lvl4_idle = {
        prefix = "asst_tower_volcan",
        from = 10,
        to = 10
    },
    ignis_altar_tower_lvl4_shoot = {
        prefix = "asst_tower_volcan",
        from = 10,
        to = 10
    },
    ignis_altar_tower_lvl4_lavabase = {
        prefix = "asst_tower_volcan_4_lavabase",
        from = 1,
        to = 1
    },
    asst_torre_volcan_leaf1 = {
        prefix = "asst_torre_volcan_leaf",
        from = 1,
        to = 1
    },
    asst_torre_volcan_leaf2 = {
        prefix = "asst_torre_volcan_leaf",
        from = 2,
        to = 2
    },
    asst_torre_volcan_eggs = {
        prefix = "asst_torre_volcan_eggs",
        from = 1,
        to = 1
    }

}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_ignis_altar.lua

-- BEGIN kr3/data/animations/kr4_tower_infernal_mage.lua
do
	local __chunk = (function()
local a = {
--lava
    --[[
    ember_lords_mage_tower_lavas_run = {
        prefix = "ember_lords_mage_tower_lavas",
        from = 1,
        to = 39
    },
    ]]--
--施法者123级
    ember_lords_mage_tower_shooter_lvl1_idle = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 1,
        to = 8
    },
    ember_lords_mage_tower_shooter_lvl1_shootDownLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 9,
        to = 30
    },
    ember_lords_mage_tower_shooter_lvl1_shootDownRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 31,
        to = 52
    },
    ember_lords_mage_tower_shooter_lvl1_idleUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 53,
        to = 60
    },
    ember_lords_mage_tower_shooter_lvl1_shootUpLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 61,
        to = 82
    },
    ember_lords_mage_tower_shooter_lvl1_shootUpRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl1",
        from = 83,
        to = 104
    },
    ember_lords_mage_tower_shooter_lvl2_idle = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 1,
        to = 8
    },
    ember_lords_mage_tower_shooter_lvl2_shootDownLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 9,
        to = 30
    },
    ember_lords_mage_tower_shooter_lvl2_shootDownRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 31,
        to = 52
    },
    ember_lords_mage_tower_shooter_lvl2_idleUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 53,
        to = 60
    },
    ember_lords_mage_tower_shooter_lvl2_shootUpLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 61,
        to = 82
    },
    ember_lords_mage_tower_shooter_lvl2_shootUpRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl2",
        from = 83,
        to = 104
    },
    ember_lords_mage_tower_shooter_lvl3_idle = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 1,
        to = 8
    },
    ember_lords_mage_tower_shooter_lvl3_shootDownLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 9,
        to = 30
    },
    ember_lords_mage_tower_shooter_lvl3_shootDownRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 31,
        to = 52
    },
    ember_lords_mage_tower_shooter_lvl3_idleUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 53,
        to = 60
    },
    ember_lords_mage_tower_shooter_lvl3_shootUpLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 61,
        to = 82
    },
    ember_lords_mage_tower_shooter_lvl3_shootUpRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl3",
        from = 83,
        to = 104
    },
--施法者4级
    ember_lords_mage_tower_shooter_lvl4_idle = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_shooter_lvl4_shootDownLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 2,
        to = 23
    },
    ember_lords_mage_tower_shooter_lvl4_shootDownRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 24,
        to = 45
    },
    ember_lords_mage_tower_shooter_lvl4_idleUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 46,
        to = 46
    },
    ember_lords_mage_tower_shooter_lvl4_shootUpLeft = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 47,
        to = 70
    },
    ember_lords_mage_tower_shooter_lvl4_shootUpRight = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 71,
        to = 94
    },
    ember_lords_mage_tower_shooter_lvl4_afflictionDown = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 95,
        to = 125
    },
    ember_lords_mage_tower_shooter_lvl4_afflictionUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 126,
        to = 156
    },
    ember_lords_mage_tower_shooter_lvl4_overchargeDown = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 157,
        to = 226
    },
    ember_lords_mage_tower_shooter_lvl4_overchargeUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 227,
        to = 296
    },
    ember_lords_mage_tower_shooter_lvl4_teleportDown = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 297,
        to = 328
    },
    ember_lords_mage_tower_shooter_lvl4_teleportUp = {
        prefix = "ember_lords_mage_tower_shooter_lvl4",
        from = 329,
        to = 360
    },
--affliction
    ember_lords_mage_tower_shooter_lvl4_affliction_floor_sign_run = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_affliction_floor_sign",
        from = 1,
        to = 28
    },
    ember_lords_mage_tower_shooter_lvl4_affliction_modifier_run = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_affliction_modifier",
        from = 1,
        to = 26
    },
--overcharge
    ember_lords_mage_tower_shooter_lvl4_overcharge_decal_1 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_decal_1",
        from = 1,
        to = 57
    },
    ember_lords_mage_tower_shooter_lvl4_overcharge_decal_2 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_decal_2",
        from = 1,
        to = 57
    },
    ember_lords_mage_tower_shooter_lvl4_overcharge_decal_3 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_decal_3",
        from = 1,
        to = 57
    },
    --[[
    ember_lords_mage_tower_shooter_lvl4_overcharge_explotion_run = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_explotion",
        from = 1,
        to = 48
    },]]--
    ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_1 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_1",
        from = 1,
        to = 20
    },
    ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_2 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_2",
        from = 1,
        to = 20
    },
    ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_3 = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_overcharge_meteor_3",
        from = 1,
        to = 20
    },
--proyectile普攻魔法弹、尾焰、打击效果
    ember_lords_mage_tower_shooter_proyectile_flying = {
        prefix = "ember_lords_mage_tower_bolt",
        from = 1,
        to = 10
    },
    ember_lords_mage_tower_shooter_proyectile_hit = {
        prefix = "ember_lords_mage_tower_bolt",
        from = 11,
        to = 22
    },
    ember_lords_mage_tower_bolt_particle_run = {
        prefix = "ember_lords_mage_tower_bolt_particle",
        from = 1,
        to = 10
    },
    ember_lords_mage_tower_shooter_lvl4_proyectile_flying = {
        prefix = "ember_lords_mage_tower_bolt_lvl4",
        from = 1,
        to = 10
    },
    ember_lords_mage_tower_shooter_lvl4_proyectile_hit = {
        prefix = "ember_lords_mage_tower_bolt_lvl4",
        from = 11,
        to = 22
    },
    ember_lords_mage_tower_lvl4_bolt_particle_run = {
        prefix = "ember_lords_mage_tower_bolt_particle_lvl4",
        from = 1,
        to = 10
    },
--teleport
    ember_lords_mage_tower_shooter_lvl4_teleport_effect_in = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_teleport_effect",
        from = 1,
        to = 10
    },
    ember_lords_mage_tower_shooter_lvl4_teleport_effect_out = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_teleport_effect",
        from = 1,
        to = 10
    },
    ember_lords_mage_tower_shooter_lvl4_teleport_decal_run = {
        prefix = "ember_lords_mage_tower_shooter_lvl4_teleport_decal",
        from = 1,
        to = 28
    },
--防御塔建造/123级
    darkarmy_mage_tower_lvl1_build = {
        prefix = "ember_lords_mage_tower",
        from = 1,
        to = 1
    },
    darkarmy_mage_tower_lvl1_idle = {
        prefix = "ember_lords_mage_tower",
        from = 2,
        to = 2
    },
    darkarmy_mage_tower_lvl2_idle = {
        prefix = "ember_lords_mage_tower",
        from = 3,
        to = 3
    },
    darkarmy_mage_tower_lvl3_idle = {
        prefix = "ember_lords_mage_tower",
        from = 4,
        to = 4
    },
--防御塔4级
    ember_lords_mage_tower_lvl4_layer1_idle = {
        prefix = "ember_lords_mage_tower_lvl4_layer1",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer1_shoot = {
        prefix = "ember_lords_mage_tower_lvl4_layer1",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer1_teleport = {
        prefix = "ember_lords_mage_tower_lvl4_layer1",
        from = 2,
        to = 27
    },
    ember_lords_mage_tower_lvl4_layer1_affliction = {
        prefix = "ember_lords_mage_tower_lvl4_layer1",
        from = 28,
        to = 52
    },
    ember_lords_mage_tower_lvl4_layer1_overcharge = {
        prefix = "ember_lords_mage_tower_lvl4_layer1",
        from = 28,
        to = 52
    },
    ember_lords_mage_tower_lvl4_layer2_idle = {
        prefix = "ember_lords_mage_tower_lvl4_layer2",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer2_shoot = {
        prefix = "ember_lords_mage_tower_lvl4_layer2",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer2_teleport = {
        prefix = "ember_lords_mage_tower_lvl4_layer2",
        from = 2,
        to = 27
    },
    ember_lords_mage_tower_lvl4_layer2_affliction = {
        prefix = "ember_lords_mage_tower_lvl4_layer2",
        from = 28,
        to = 52
    },
    ember_lords_mage_tower_lvl4_layer2_overcharge = {
        prefix = "ember_lords_mage_tower_lvl4_layer2",
        from = 28,
        to = 52
    },
    ember_lords_mage_tower_lvl4_layer3_idle = {
        prefix = "ember_lords_mage_tower_lvl4_layer3",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer3_shoot = {
        prefix = "ember_lords_mage_tower_lvl4_layer3",
        from = 1,
        to = 1
    },
    ember_lords_mage_tower_lvl4_layer3_teleport = {
        prefix = "ember_lords_mage_tower_lvl4_layer3",
        from = 2,
        to = 27
    },
    ember_lords_mage_tower_lvl4_layer3_affliction = {
        prefix = "ember_lords_mage_tower_lvl4_layer3",
        from = 28,
        to = 52
    },
    ember_lords_mage_tower_lvl4_layer3_overcharge = {
        prefix = "ember_lords_mage_tower_lvl4_layer3",
        from = 28,
        to = 52
    },
}
--阴森墓地、深渊环礁、腐朽森林、少林寺、女巫姐妹花、沙虫巢穴、食人魔沉船、沼泽巨人、战争飞艇、死灵墓
--1、死灵墓；2、战争飞艇；3、少林寺；4、食人魔沉船；5、女巫姐妹花；
--6、腐朽森林；7、沼泽巨人；8、阴森墓地、9、深渊环礁；10、沙虫巢穴；
local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_infernal_mage.lua

-- BEGIN kr3/data/animations/kr4_tower_melting_furnace.lua
do
	local __chunk = (function()
local a = {
--攻击动画
    --buff
    darkarmy_melting_furnace_tower_swords_run = {
        prefix = "darkarmy_melting_furnace_tower_swords",
        from = 1,
        to = 24
    },
    --攻击烟雾
    darkarmy_melting_furnace_smoke_run = {
        prefix = "darkarmy_melting_furnace_smoke",
        from = 1,
        to = 14
    },
    --煤块
    darkarmy_melting_furnace_decal_fissure = {
        prefix = "darkarmy_melting_furnace_decal_fissure",
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl4_fissure_hit_start = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_fissure_hit",
        from = 1,
        to = 13
    },
    darkarmy_melting_furnace_tower_lvl4_fissure_hit_run = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_fissure_hit",
        from = 14,
        to = 21
    },
    --加速攻击
    darkarmy_melting_furnace_tower_lvl4_flames_fadeIn = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 1,
        to = 4
    },
    darkarmy_melting_furnace_tower_lvl4_flames_loop = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 5,
        to = 19
    },
    darkarmy_melting_furnace_tower_lvl4_flames_fadeOut = {
        prefix = "darkarmy_melting_furnace_tower_lvl4_flames",
        from = 20,
        to = 27
    },
--防御塔建造/1级
    darkarmy_melting_furnace_tower_lvl1_layerX_build = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl1_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 2,
        to = 2
    },
    darkarmy_melting_furnace_tower_lvl1_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 3,
        to = 75
    },
--防御塔2级
    darkarmy_melting_furnace_tower_lvl2_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl2_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 2,
        to = 75
    },
--防御塔3级
    darkarmy_melting_furnace_tower_lvl3_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 1
    },
    darkarmy_melting_furnace_tower_lvl3_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 2,
        to = 75
    },
--防御塔4级
    darkarmy_melting_furnace_tower_lvl4_layerX_shoot = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 1,
        to = 74
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_idle = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 75,
        to = 75
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfIntro = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 76,
        to = 115
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfLoop = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 116,
        to = 120
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_bfHit = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 121,
        to = 149
    },
    darkarmy_melting_furnace_tower_lvl4_layerX_shootFissure = {
        layer_prefix = "darkarmy_melting_furnace_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 8,
        from = 150,
        to = 223
    }
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_melting_furnace.lua

-- BEGIN kr3/data/animations/kr4_tower_ogre_shipwreck.lua
do
	local __chunk = (function()
local a = {
--skill_goblin
    skill_goblin_idle = {
        prefix = "skill_goblin",
        from = 1,
        to = 1
    },
    skill_goblin_running = {
        prefix = "skill_goblin",
        from = 2,
        to = 9
    },
    skill_goblin_attack = {
        prefix = "skill_goblin",
        from = 10,
        to = 23
    },
    skill_goblin_death = {
        prefix = "skill_goblin",
        from = 24,
        to = 36
    },
--cook_ogre
    cook_ogre_idle = {
        prefix = "cook_ogre",
        from = 1,
        to = 1
    },
    cook_ogre_walk = {
        prefix = "cook_ogre",
        from = 2,
        to = 35
    },
    cook_ogre_attack = {
        prefix = "cook_ogre",
        from = 36,
        to = 66
    },
    cook_ogre_death = {
        prefix = "cook_ogre",
        from = 67,
        to = 93
    },
    cook_ogre_spawn = {
        prefix = "cook_ogre",
        from = 94,
        to = 109
    },
    cook_ogre_decal_idle = {
        prefix = "cook_ogre_decal",
        from = 1,
        to = 19
    },
    cook_ogre_smoke_idle = {
        prefix = "cook_ogre_smoke",
        from = 1,
        to = 17
    },
--deckhand_goblin
    deckhand_goblin_idle = {
        prefix = "deckhand_goblin",
        from = 1,
        to = 1
    },
    deckhand_goblin_walk = {
        prefix = "deckhand_goblin",
        from = 2,
        to = 9
    },
    deckhand_goblin_attack = {
        prefix = "deckhand_goblin",
        from = 10,
        to = 23
    },
    deckhand_goblin_death = {
        prefix = "deckhand_goblin",
        from = 24,
        to = 36
    },
--bomber
    goblin_bomber_trail_trail = {
        prefix = "goblin_bomber_trail",
        from = 1,
        to = 9
    },
    goblin_bomber_idle = {
        prefix = "goblin_bomber",
        from = 1,
        to = 1
    },
    goblin_bomber_shoot = {
        prefix = "goblin_bomber",
        from = 2,
        to = 40
    },
    goblin_bomber_skill = {
        prefix = "goblin_bomber",
        from = 41,
        to = 80
    },
    goblin_bomber_idleGoblin = {
        prefix = "goblin_bomber",
        from = 81,
        to = 81
    },
    goblin_bomber_shootGoblin = {
        prefix = "goblin_bomber",
        from = 82,
        to = 120
    },
    goblin_bomber_skillGoblin = {
        prefix = "goblin_bomber",
        from = 121,
        to = 160
    },
    goblin_bomber_burst_burst = {
        prefix = "goblin_bomber_burst",
        from = 1,
        to = 20
    },
    ogre_shipwreck_bomber_proyectile_travel = {
        prefix = "goblin_bomber_projectil",
        from = 1,
        to = 14
    },
--musket
    musket_hit_hit = {
        prefix = "musket_hit",
        from = 1,
        to = 7
    },
    musketer_tower_shooter_idle = {
        prefix = "musket_tower",
        from = 1,
        to = 1
    },
    musketer_tower_shooter_shootDown = {
        prefix = "musket_tower",
        from = 2,
        to = 21
    },
    musketer_tower_shooter_idleUp = {
        prefix = "musket_tower",
        from = 22,
        to = 22
    },
    musketer_tower_shooter_shootUp = {
        prefix = "musket_tower",
        from = 23,
        to = 44
    },
    musketer_tower_shooter_skillDownIn = {
        prefix = "musket_tower",
        from = 45,
        to = 50
    },
    musketer_tower_shooter_skillDownLoop = {
        prefix = "musket_tower",
        from = 51,
        to = 56
    },
    musketer_tower_shooter_skillDownEnd = {
        prefix = "musket_tower",
        from = 57,
        to = 70
    },
    musketer_tower_shooter_skillUpIn = {
        prefix = "musket_tower",
        from = 71,
        to = 76
    },
    musketer_tower_shooter_skillUpLoop = {
        prefix = "musket_tower",
        from = 77,
        to = 82
    },
    musketer_tower_shooter_skillUpEnd = {
        prefix = "musket_tower",
        from = 83,
        to = 96
    },
--1级防御塔
    ogre_shipwreck_tower_lvl1_layer1_build = {
		prefix = "ogre_shipwreck_tower_lvl1_layer1",
		from = 1,
		to = 1
	},
    ogre_shipwreck_tower_lvl1_layer1_idle = {
		prefix = "ogre_shipwreck_tower_lvl1_layer1",
		from = 3,
		to = 3
	},
    ogre_shipwreck_tower_lvl1_layer1_open = {
		prefix = "ogre_shipwreck_tower_lvl1_layer1",
		from = 3,
		to = 18
	},
    ogre_shipwreck_tower_lvl1_layer1_close = {
		prefix = "ogre_shipwreck_tower_lvl1_layer1",
		from = 19,
		to = 34
	},
    ogre_shipwreck_tower_lvl1_layer2_build = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		from = 1,
		to = 1
	},
    ogre_shipwreck_tower_lvl1_layer2_idle = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		from = 3,
		to = 3
	},
    ogre_shipwreck_tower_lvl1_layer2_open = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		from = 3,
		to = 18
	},
    ogre_shipwreck_tower_lvl1_layer2_close = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		from = 19,
		to = 34
	},
--2级防御塔
    ogre_shipwreck_tower_lvl2_layer1_idle = {
		prefix = "ogre_shipwreck_tower_lvl2_layer1",
		from = 2,
		to = 2
	},
    ogre_shipwreck_tower_lvl2_layer1_open = {
		prefix = "ogre_shipwreck_tower_lvl2_layer1",
		from = 2,
		to = 17
	},
    ogre_shipwreck_tower_lvl2_layer1_close = {
		prefix = "ogre_shipwreck_tower_lvl2_layer1",
		from = 18,
		to = 34
	},
    ogre_shipwreck_tower_lvl2_layer2_idle = {
		prefix = "ogre_shipwreck_tower_lvl2_layer2",
		from = 2,
		to = 2
	},
    ogre_shipwreck_tower_lvl2_layer2_open = {
		prefix = "ogre_shipwreck_tower_lvl2_layer2",
		from = 2,
		to = 17
	},
    ogre_shipwreck_tower_lvl2_layer2_close = {
		prefix = "ogre_shipwreck_tower_lvl2_layer2",
		from = 18,
		to = 34
	},
--3级防御塔
    ogre_shipwreck_tower_lvl3_layer1_idle = {
        prefix = "ogre_shipwreck_tower_lvl3_layer1",
        from = 2,
        to = 2
    },
    ogre_shipwreck_tower_lvl3_layer1_open = {
        prefix = "ogre_shipwreck_tower_lvl3_layer1",
        from = 2,
        to = 17
    },
    ogre_shipwreck_tower_lvl3_layer1_close = {
        prefix = "ogre_shipwreck_tower_lvl3_layer1",
        from = 18,
        to = 34
    },
    ogre_shipwreck_tower_lvl3_layer2_idle = {
        prefix = "ogre_shipwreck_tower_lvl3_layer2",
        from = 2,
        to = 2
    },
    ogre_shipwreck_tower_lvl3_layer2_open = {
        prefix = "ogre_shipwreck_tower_lvl3_layer2",
        from = 2,
        to = 17
    },
    ogre_shipwreck_tower_lvl3_layer2_close = {
        prefix = "ogre_shipwreck_tower_lvl3_layer2",
        from = 18,
        to = 34
    },
--4级防御塔
    ogre_shipwreck_tower_lvl4_layer1_idle = {
        prefix = "ogre_shipwreck_tower_lvl4_layer1",
        from = 2,
        to = 2
    },
    ogre_shipwreck_tower_lvl4_layer1_open = {
        prefix = "ogre_shipwreck_tower_lvl4_layer1",
        from = 2,
        to = 17
    },
    ogre_shipwreck_tower_lvl4_layer1_close = {
        prefix = "ogre_shipwreck_tower_lvl4_layer1",
        from = 18,
        to = 34
    },
    ogre_shipwreck_tower_lvl4_layer2_idle = {
        prefix = "ogre_shipwreck_tower_lvl4_layer2",
        from = 2,
        to = 2
    },
    ogre_shipwreck_tower_lvl4_layer2_open = {
        prefix = "ogre_shipwreck_tower_lvl4_layer2",
        from = 2,
        to = 17
    },
    ogre_shipwreck_tower_lvl4_layer2_close = {
        prefix = "ogre_shipwreck_tower_lvl4_layer2",
        from = 18,
        to = 34
    },
    ogre_shipwreck_tower_lvl4_flags_run = {
        prefix = "ogre_shipwreck_tower_lvl4_flags",
        from = 1,
        to = 20
    },
--end
}


local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_ogre_shipwreck.lua

-- BEGIN kr3/data/animations/kr4_tower_orc_shaman.lua
do
	local __chunk = (function()
local a = {
--1级
    warmongers_mage_towers_lvl1_layer1_idle = {
        prefix = "warmongers_mage_tower_lvl1_layer1",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl1_layer2_idle = {
        prefix = "warmongers_mage_tower_lvl1_layer2",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl1_layer1_shoot = {
        prefix = "warmongers_mage_tower_lvl1_layer1",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl1_layer2_shoot = {
        prefix = "warmongers_mage_tower_lvl1_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl1_layer2_shootUp = {
        prefix = "warmongers_mage_tower_lvl1_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl1_layer2_shootDown = {
        prefix = "warmongers_mage_tower_lvl1_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl1_layer1_build = {
        prefix = "warmongers_mage_tower_lvl1_layer1",
        from = 32,
        to = 32
    },
    warmongers_mage_towers_lvl1_layer2_build = {
        prefix = "warmongers_mage_tower_lvl1_layer2",
        from = 32,
        to = 32
    },
--2级
    warmongers_mage_towers_lvl2_layer1_idle = {
        prefix = "warmongers_mage_tower_lvl2_layer1",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl2_layer2_idle = {
        prefix = "warmongers_mage_tower_lvl2_layer2",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl2_layer1_shoot = {
        prefix = "warmongers_mage_tower_lvl2_layer1",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl2_layer2_shoot = {
        prefix = "warmongers_mage_tower_lvl2_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl2_layer2_shootUp = {
        prefix = "warmongers_mage_tower_lvl2_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl2_layer2_shootDown = {
        prefix = "warmongers_mage_tower_lvl2_layer2",
        from = 2,
        to = 31
    },
--3级
    warmongers_mage_towers_lvl3_layer1_idle = {
        prefix = "warmongers_mage_tower_lvl3_layer1",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl3_layer2_idle = {
        prefix = "warmongers_mage_tower_lvl3_layer2",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl3_layer1_shoot = {
        prefix = "warmongers_mage_tower_lvl3_layer1",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl3_layer2_shoot = {
        prefix = "warmongers_mage_tower_lvl3_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl3_layer2_shootUp = {
        prefix = "warmongers_mage_tower_lvl3_layer2",
        from = 2,
        to = 31
    },
    warmongers_mage_towers_lvl3_layer2_shootDown = {
        prefix = "warmongers_mage_tower_lvl3_layer2",
        from = 2,
        to = 31
    },
--4级
    warmongers_mage_towers_lvl4_layer1_idle = {
        prefix = "warmongers_mage_tower_lvl4_layer1",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl4_layer2_idle = {
        prefix = "warmongers_mage_tower_lvl4_layer2",
        from = 1,
        to = 1
    },
    warmongers_mage_towers_lvl4_layer1_shoot = {
        prefix = "warmongers_mage_tower_lvl4_layer1",
        from = 2,
        to = 42
    },
    warmongers_mage_towers_lvl4_layer2_shoot = {
        prefix = "warmongers_mage_tower_lvl4_layer2",
        from = 2,
        to = 42
    },
    warmongers_mage_towers_lvl4_layer2_shootDown = {
        prefix = "warmongers_mage_tower_lvl4_layer2",
        from = 2,
        to = 42
    },
    warmongers_mage_towers_lvl4_layer2_shootUp = {
        prefix = "warmongers_mage_tower_lvl4_layer2",
        from = 2,
        to = 42
    },
--塔上火焰
    mageFire_idle = {
        prefix = "warmongers_mage_towers_fire",
        from = 1,
        to = 12
    },

--射手1级
    warmongers_mage_tower_shooter_lvl1_idleDown = {
        prefix = "warmongers_mage_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl1_idle = {
        prefix = "warmongers_mage_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl1_shootDown = {
        prefix = "warmongers_mage_tower_shooter_lvl1",
        from = 2,
        to = 39
    },
    warmongers_mage_tower_shooter_lvl1_idleUp = {
        prefix = "warmongers_mage_tower_shooter_lvl1",
        from = 40,
        to = 40
    },
    warmongers_mage_tower_shooter_lvl1_shootUp = {
        prefix = "warmongers_mage_tower_shooter_lvl1",
        from = 41,
        to = 71
    },
--射手2级
    warmongers_mage_tower_shooter_lvl2_idleDown = {
        prefix = "warmongers_mage_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl2_idle = {
        prefix = "warmongers_mage_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl2_shootDown = {
        prefix = "warmongers_mage_tower_shooter_lvl2",
        from = 2,
        to = 39
    },
    warmongers_mage_tower_shooter_lvl2_idleUp = {
        prefix = "warmongers_mage_tower_shooter_lvl2",
        from = 40,
        to = 40
    },
    warmongers_mage_tower_shooter_lvl2_shootUp = {
        prefix = "warmongers_mage_tower_shooter_lvl2",
        from = 41,
        to = 71
    },
--射手3级
    warmongers_mage_tower_shooter_lvl3_idleDown = {
        prefix = "warmongers_mage_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl3_idle = {
        prefix = "warmongers_mage_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl3_shootDown = {
        prefix = "warmongers_mage_tower_shooter_lvl3",
        from = 2,
        to = 39
    },
    warmongers_mage_tower_shooter_lvl3_idleUp = {
        prefix = "warmongers_mage_tower_shooter_lvl3",
        from = 40,
        to = 40
    },
    warmongers_mage_tower_shooter_lvl3_shootUp = {
        prefix = "warmongers_mage_tower_shooter_lvl3",
        from = 41,
        to = 71
    },
--射手4级
    warmongers_mage_tower_shooter_lvl4_idleDown = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl4_idle = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    warmongers_mage_tower_shooter_lvl4_shootDown = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 2,
        to = 29
    },
    warmongers_mage_tower_shooter_lvl4_idleUp = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 30,
        to = 30
    },
    warmongers_mage_tower_shooter_lvl4_shootUp = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 31,
        to = 58
    },
    warmongers_mage_tower_shooter_lvl4_meteoritesDown = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 59,
        to = 88
    },
    warmongers_mage_tower_shooter_lvl4_meteoritesUp = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 89,
        to = 118
    },
    warmongers_mage_tower_shooter_lvl4_healingRootsDown = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 119,
        to = 160
    },
    warmongers_mage_tower_shooter_lvl4_healingRootsUp = {
        prefix = "warmongers_mage_tower_shooter_lvl4",
        from = 161,
        to = 201
    },
--治愈草根
    warmongers_mage_tower_shooter_healingRoots_in = {
        prefix = "warmongers_mage_tower_shooter_healingRoots",
        from = 1,
        to = 20
    },
    warmongers_mage_tower_shooter_healingRoots_run = {
        prefix = "warmongers_mage_tower_shooter_healingRoots",
        from = 21,
        to = 21
    },
    warmongers_mage_tower_shooter_healingRoots_out = {
        prefix = "warmongers_mage_tower_shooter_healingRoots",
        from = 22,
        to = 47
    },
    healGreen_run = {
        prefix = "warmongers_mage_tower_shooter_healingRoots_healeffect",
        from = 1,
        to = 26
    },
    warmongers_mage_tower_shooter_healingRoots_particles_run = {
        prefix = "warmongers_mage_tower_shooter_healingRoots_particles",
        from = 1,
        to = 25
    },
--普攻、3技能与效果
    warmongers_mage_tower_ray_travel = {
        prefix = "warmongers_mage_tower_ray",
        from = 1,
        to = 19
    },
    warmongers_mage_tower_electroshock_hit = {
        prefix = "warmongers_mage_tower_electroshock",
        from = 1,
        to = 25
    },
    mageHit_run = {
        prefix = "warmongers_mage_tower_shooter_proyectile_hit",
        from = 1,
        to = 9
    },
    warmongers_mage_tower_ray_hit_run = {
        prefix = "warmongers_mage_tower_ray_hit",
        from = 1,
        to = 10
    },
    warmongers_mage_tower_ray_modifier_run_loop = {
        prefix = "warmongers_mage_tower_ray_modifier",
        from = 1,
        to = 6
    },
--陨石与效果
    blood_altar_decal_run = {
        prefix = "warmongers_mage_tower_projectile_decal",
        from = 1,
        to = 24
    },
    meteorite_start = {
        prefix = "warmongers_mage_tower_meteorite_lvl4",
        from = 1,
        to = 10
    },
    warmongers_mage_tower_lvl4_explotion_run_run = {
        prefix = "warmongers_mage_tower_lvl4_explotion",
        from = 1,
        to = 19
    },
    blood_altar_run = {
        prefix = "warmongers_mage_tower_projectile_explosion",
        from = 1,
        to = 15
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_orc_shaman.lua

-- BEGIN kr3/data/animations/kr4_tower_orc_warriors_den.lua
do
	local __chunk = (function()
local a = {
--1级
    warmongers_barrack_towers_lvl1_layer1_idle = {
        prefix = "warmongers_barrack_towers_lvl1_layer1",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl1_layer2_idle = {
        prefix = "warmongers_barrack_towers_lvl1_layer2",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl1_layer1_build = {
        prefix = "warmongers_barrack_towers_lvl1_layer1",
        from = 8,
        to = 8
    },
    warmongers_barrack_towers_lvl1_layer2_build = {
        prefix = "warmongers_barrack_towers_lvl1_layer2",
        from = 8,
        to = 8
    },
    warmongers_barrack_towers_lvl1_layer1_open = {
        prefix = "warmongers_barrack_towers_lvl1_layer1",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl1_layer2_open = {
        prefix = "warmongers_barrack_towers_lvl1_layer2",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl1_layer1_close = {
        prefix = "warmongers_barrack_towers_lvl1_layer1",
        from = 5,
        to = 7
    },
    warmongers_barrack_towers_lvl1_layer2_close = {
        prefix = "warmongers_barrack_towers_lvl1_layer2",
        from = 5,
        to = 7
    },
--2级
    warmongers_barrack_towers_lvl2_layer1_idle = {
        prefix = "warmongers_barrack_towers_lvl2_layer1",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl2_layer2_idle = {
        prefix = "warmongers_barrack_towers_lvl2_layer2",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl2_layer1_open = {
        prefix = "warmongers_barrack_towers_lvl2_layer1",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl2_layer2_open = {
        prefix = "warmongers_barrack_towers_lvl2_layer2",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl2_layer1_close = {
        prefix = "warmongers_barrack_towers_lvl2_layer1",
        from = 5,
        to = 7
    },
    warmongers_barrack_towers_lvl2_layer2_close = {
        prefix = "warmongers_barrack_towers_lvl2_layer2",
        from = 5,
        to = 7
    },
--3级
    warmongers_barrack_towers_lvl3_layer1_idle = {
        prefix = "warmongers_barrack_towers_lvl3_layer1",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl3_layer2_idle = {
        prefix = "warmongers_barrack_towers_lvl3_layer2",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl3_layer1_open = {
        prefix = "warmongers_barrack_towers_lvl3_layer1",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl3_layer2_open = {
        prefix = "warmongers_barrack_towers_lvl3_layer2",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl3_layer1_close = {
        prefix = "warmongers_barrack_towers_lvl3_layer1",
        from = 5,
        to = 7
    },
    warmongers_barrack_towers_lvl3_layer2_close = {
        prefix = "warmongers_barrack_towers_lvl3_layer2",
        from = 5,
        to = 7
    },
--4级
    warmongers_barrack_towers_lvl4_layer1_idle = {
        prefix = "warmongers_barrack_towers_lvl4_layer1",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl4_layer2_idle = {
        prefix = "warmongers_barrack_towers_lvl4_layer2",
        from = 1,
        to = 1
    },
    warmongers_barrack_towers_lvl4_layer1_open = {
        prefix = "warmongers_barrack_towers_lvl4_layer1",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl4_layer2_open = {
        prefix = "warmongers_barrack_towers_lvl4_layer2",
        from = 2,
        to = 4
    },
    warmongers_barrack_towers_lvl4_layer1_close = {
        prefix = "warmongers_barrack_towers_lvl4_layer1",
        from = 5,
        to = 7
    },
    warmongers_barrack_towers_lvl4_layer2_close = {
        prefix = "warmongers_barrack_towers_lvl4_layer2",
        from = 5,
        to = 7
    },
--士兵1
    warmongers_soldier_orc_lvl1_idle = {
        prefix = "warmongers_soldier_orc_lvl1",
        from = 1,
        to = 1
    },
    warmongers_soldier_orc_lvl1_running = {
        prefix = "warmongers_soldier_orc_lvl1",
        from = 2,
        to = 17
    },
    warmongers_soldier_orc_lvl1_attack = {
        prefix = "warmongers_soldier_orc_lvl1",
        from = 18,
        to = 39
    },
    warmongers_soldier_orc_lvl1_death = {
        prefix = "warmongers_soldier_orc_lvl1",
        from = 40,
        to = 55
    },
--士兵2
    warmongers_soldier_orc_lvl2_idle = {
        prefix = "warmongers_soldier_orc_lvl2",
        from = 1,
        to = 1
    },
    warmongers_soldier_orc_lvl2_running = {
        prefix = "warmongers_soldier_orc_lvl2",
        from = 2,
        to = 17
    },
    warmongers_soldier_orc_lvl2_attack = {
        prefix = "warmongers_soldier_orc_lvl2",
        from = 18,
        to = 39
    },
    warmongers_soldier_orc_lvl2_death = {
        prefix = "warmongers_soldier_orc_lvl2",
        from = 40,
        to = 55
    },
--士兵3
    warmongers_soldier_orc_lvl3_idle = {
        prefix = "warmongers_soldier_orc_lvl3",
        from = 1,
        to = 1
    },
    warmongers_soldier_orc_lvl3_running = {
        prefix = "warmongers_soldier_orc_lvl3",
        from = 2,
        to = 17
    },
    warmongers_soldier_orc_lvl3_attack = {
        prefix = "warmongers_soldier_orc_lvl3",
        from = 18,
        to = 39
    },
    warmongers_soldier_orc_lvl3_death = {
        prefix = "warmongers_soldier_orc_lvl3",
        from = 40,
        to = 55
    },
--士兵4
    warmongers_soldier_orc_lvl4_idle = {
        prefix = "warmongers_soldier_orc_lvl4",
        from = 1,
        to = 1
    },
    warmongers_soldier_orc_lvl4_running = {
        prefix = "warmongers_soldier_orc_lvl4",
        from = 2,
        to = 17
    },
    warmongers_soldier_orc_lvl4_attack = {
        prefix = "warmongers_soldier_orc_lvl4",
        from = 18,
        to = 39
    },
    warmongers_soldier_orc_lvl4_death = {
        prefix = "warmongers_soldier_orc_lvl4",
        from = 40,
        to = 55
    },
--队长
    warmongers_soldier_orc_captain_idle = {
        prefix = "warmongers_soldier_orc_captain",
        from = 1,
        to = 1
    },
    warmongers_soldier_orc_captain_running = {
        prefix = "warmongers_soldier_orc_captain",
        from = 2,
        to = 17
    },
    warmongers_soldier_orc_captain_attack = {
        prefix = "warmongers_soldier_orc_captain",
        from = 18,
        to = 39
    },
    warmongers_soldier_orc_captain_death = {
        prefix = "warmongers_soldier_orc_captain",
        from = 40,
        to = 54
    },
    warmongers_soldier_orc_captain_spawn = {
        prefix = "warmongers_soldier_orc_captain",
        from = 55,
        to = 88
    },
--弱化/愤怒？
    warmongers_soldier_orc_captain_weakness_small_run = {
        prefix = "warmongers_soldier_orc_captain_weakness_big",
        from = 1,
        to = 9
    },
    warmongers_soldier_orc_captain_rage_run = {
        prefix = "warmongers_soldier_orc_captain_rage",
        from = 1,
        to = 16
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_orc_warriors_den.lua

-- BEGIN kr3/data/animations/kr4_tower_rocket_riders.lua
do
	local __chunk = (function()
local a = {
--1级塔
    warmongers_rocket_towers_lvl1_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl1_layerX_build = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 64,
        to = 64
    },
    warmongers_rocket_towers_lvl1_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl1_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 1,
        to = 62
    },
--2级塔
    warmongers_rocket_towers_lvl2_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl2_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl2_layer%i",
        layer_from = 1,
        layer_to = 4,
        from = 1,
        to = 62
    },
--3级塔
    warmongers_rocket_towers_lvl3_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl3_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl3_layer%i",
        layer_from = 1,
        layer_to = 6,
        from = 1,
        to = 62
    },
--4级塔
    warmongers_rocket_towers_lvl4_layerX_idle = {
        layer_prefix = "warmongers_rocket_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 63,
        to = 63
    },
    warmongers_rocket_towers_lvl4_layerX_shoot = {
        layer_prefix = "warmongers_rocket_tower_lvl4_layer%i",
        layer_from = 1,
        layer_to = 5,
        from = 1,
        to = 62
    },
--炸弹
    warmongers_rocket_missile_lvl1_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl1",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl2_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl2",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl3_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl3",
        from = 1,
        to = 10
    },
    warmongers_rocket_missile_lvl4_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4",
        from = 1,
        to = 5
    },
    warmongers_rocket_missile_lvl4_special_travel = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4_special",
        from = 1,
        to = 5
    },
--4级普攻/强化普攻的尾焰
    warmongers_rocket_missile_lvl4_particle_special_run = {
        prefix = "warmongers_rocket_shooter_proyectile_lvl4_special_particle",
        from = 1,
        to = 11
    },
    warmongers_rocket_missile_lvl4_particle1_run = {
        prefix = "warmongers_rocket_shooter_proyectile_particle1_lvl4",
        from = 1,
        to = 11
    },
    warmongers_rocket_missile_lvl4_particle2_run = {
        prefix = "warmongers_rocket_shooter_proyectile_particle2_lvl4",
        from = 1,
        to = 11
    },
--蓝色爆炸特效
    warmongers_rocket_tower_lvl4_blue_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_blue_explosion",
        from = 1,
        to = 18
    },
--炸弹盒子
    warmongers_rocket_tower_lvl4_box_goblin_mine_floor_out = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor",
        from = 1,
        to = 7
    },
    warmongers_rocket_tower_lvl4_box_goblin_mine_floor_loop = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_mine_floor",
        from = 8,
        to = 30
    },
    warmongers_rocket_tower_lvl4_box_goblin_idle = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_right",
        from = 1,
        to = 1
    },
    warmongers_rocket_tower_lvl4_box_goblin_shootRight = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_right",
        from = 1,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_goblin_shootLeft = {
        prefix = "warmongers_rocket_tower_lvl4_box_goblin_left",
        from = 1,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_idle = {
        prefix = "warmongers_rocket_tower_lvl4_box",
        from = 79,
        to = 79
    },
    warmongers_rocket_tower_lvl4_box_shootLeft = {
        prefix = "warmongers_rocket_tower_lvl4_box",
        from = 1,
        to = 78
    },
--群簇轰炸
    warmongers_rocket_tower_lvl4_cluster_blue_air_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_cluster_blue_air_explosion",
        from = 1,
        to = 31
    },
    warmongers_rocket_tower_lvl4_air_explosion_run = {
        prefix = "warmongers_rocket_tower_lvl4_cluster_air_explosion",
        from = 1,
        to = 31
    },



}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_rocket_riders.lua

-- BEGIN kr3/data/animations/kr4_tower_rotten_forest.lua
do
	local __chunk = (function()
local a = {
--普攻及地面雾气
    rotten_forest_tower_decal_floor_intro = {
        prefix = "rotten_forest_tower_decal_floor",
        from = 1,
        to = 11
    },
    rotten_forest_tower_decal_floor_idle = {
        prefix = "rotten_forest_tower_decal_floor",
        from = 12,
        to = 12
    },
    rotten_forest_tower_decal_intro = {
        prefix = "rotten_forest_tower_decal",
        from = 1,
        to = 6
    },
    rotten_forest_tower_decal_idle = {
        prefix = "rotten_forest_tower_decal",
        from = 7,
        to = 7
    },
    rotten_forest_tower_decal_introLoop = {
        prefix = "rotten_forest_tower_decal",
        from = 8,
        to = 19
    },
    rotten_forest_tower_decal_loop = {
        prefix = "rotten_forest_tower_decal",
        from = 20,
        to = 40
    },
    rotten_forest_tower_decal_out = {
        prefix = "rotten_forest_tower_decal",
        from = 41,
        to = 47
    },
    rotten_forest_tower_fog_run = {
        prefix = "rotten_forest_towers_fog_of_dispair",
        from = 1,
        to = 64
    },
--防御塔
    rotten_forest_tower_lvl1_build = {
        prefix = "rotten_forest_tower_lvl1",
        from = 1,
        to = 1
    },
    rotten_forest_tower_lvl1_idle = {
        prefix = "rotten_forest_tower_lvl1",
        from = 2,
        to = 31
    },
    rotten_forest_tower_lvl2_idle = {
        prefix = "rotten_forest_tower_lvl2",
        from = 1,
        to = 30
    },
    rotten_forest_tower_lvl3_idle = {
        prefix = "rotten_forest_tower_lvl3",
        from = 1,
        to = 30
    },
    rotten_forest_tower_lvl4_idle = {
        prefix = "rotten_forest_tower_lvl4",
        from = 1,
        to = 30
    },
    rotten_forest_tower_mist_run = {
        prefix = "rotten_forest_tower_mist",
        from = 1,
        to = 110
    },
    rotten_forest_tower_mist_lvl4_run = {
        prefix = "rotten_forest_tower_mist_lvl4",
        from = 1,
        to = 110
    },
--缠绕
    rotten_forest_towers_root_start = {
        prefix = "rotten_forest_towers_root_of_evil",
        from = 1,
        to = 14
    },
    rotten_forest_towers_root_loop = {
        prefix = "rotten_forest_towers_root_of_evil",
        from = 15,
        to = 16
    },
    rotten_forest_towers_root_end = {
        prefix = "rotten_forest_towers_root_of_evil",
        from = 17,
        to = 21
    },
--召唤物
    rotten_forest_towers_spawn_idle = {
        prefix = "rotten_forest_towers_spawn",
        from = 1,
        to = 1
    },
    rotten_forest_towers_spawn_running = {
        prefix = "rotten_forest_towers_spawn",
        from = 2,
        to = 25
    },
    rotten_forest_towers_spawn_attack = {
        prefix = "rotten_forest_towers_spawn",
        from = 26,
        to = 55
    },
    rotten_forest_towers_spawn_death = {
        prefix = "rotten_forest_towers_spawn",
        from = 56,
        to = 90
    },
    rotten_forest_towers_spawn_spawn = {
        prefix = "rotten_forest_towers_spawn",
        from = 91,
        to = 136
    },
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_rotten_forest.lua

-- BEGIN kr3/data/animations/kr4_tower_shadow_archer.lua
do
	local __chunk = (function()
local a = {
    --弓箭手lvl1
    tower_shadow_archer_shooter_lvl1_idle = {
        prefix = "darkarmy_archer_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    tower_shadow_archer_shooter_lvl1_shootDown = {
        prefix = "darkarmy_archer_tower_shooter_lvl1",
        from = 2,
        to = 22
    },
    tower_shadow_archer_shooter_lvl1_idleUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl1",
        from = 23,
        to = 23
    },
    tower_shadow_archer_shooter_lvl1_shootUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl1",
        from = 24,
        to = 43
    },
    --弓箭手lvl2
    tower_shadow_archer_shooter_lvl2_idle = {
        prefix = "darkarmy_archer_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    tower_shadow_archer_shooter_lvl2_shootDown = {
        prefix = "darkarmy_archer_tower_shooter_lvl2",
        from = 2,
        to = 22
    },
    tower_shadow_archer_shooter_lvl2_idleUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl2",
        from = 23,
        to = 23
    },
    tower_shadow_archer_shooter_lvl2_shootUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl2",
        from = 24,
        to = 43
    },
    --弓箭手lvl3
    tower_shadow_archer_shooter_lvl3_idle = {
        prefix = "darkarmy_archer_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    tower_shadow_archer_shooter_lvl3_shootDown = {
        prefix = "darkarmy_archer_tower_shooter_lvl3",
        from = 2,
        to = 22
    },
    tower_shadow_archer_shooter_lvl3_idleUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl3",
        from = 23,
        to = 23
    },
    tower_shadow_archer_shooter_lvl3_shootUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl3",
        from = 24,
        to = 43
    },
    --弓箭手lvl4
    tower_shadow_archer_shooter_lvl4_idle = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 1,
        to = 1
    },
    tower_shadow_archer_shooter_lvl4_shootDown = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 2,
        to = 22
    },
    tower_shadow_archer_shooter_lvl4_idleUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 23,
        to = 23
    },
    tower_shadow_archer_shooter_lvl4_shootUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 24,
        to = 44
    },
    tower_shadow_archer_shooter_lvl4_teleportOut = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 45,
        to = 65
    },
    tower_shadow_archer_shooter_lvl4_teleportIn = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 66,
        to = 86
    },
    tower_shadow_archer_shooter_lvl4_teleportInAttack = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 87,
        to = 115
    },
    tower_shadow_archer_shooter_lvl4_teleportOutAttack = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 116,
        to = 130
    },
    tower_shadow_archer_shooter_lvl4_shootSpecialDown = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 131,
        to = 151
    },
    tower_shadow_archer_shooter_lvl4_shootSpecialUp = {
        prefix = "darkarmy_archer_tower_shooter_lvl4",
        from = 152,
        to = 172
    },
    tower_shadow_archer_shooter_lvl4_shadow_modifier_run = {
        prefix = "darkarmy_archer_tower_shooter_lvl4_shadow_modifier",
        from = 1,
        to = 24
    },
    --乌鸦
    darkarmy_archer_tower_crow_lvl4_bloodRed = {
        prefix = "darkarmy_archer_tower_crow_lvl4_bloodRed",
        from = 1,
        to = 16
    },
    darkarmy_archer_tower_crow_lvl4_respawn = {
        prefix = "darkarmy_archer_tower_crow_lvl4",
        from = 1,
        to = 18
    },
    darkarmy_archer_tower_crow_lvl4_idle = {
        prefix = "darkarmy_archer_tower_crow_lvl4",
        from = 19,
        to = 30
    },
    darkarmy_archer_tower_crow_lvl4_fly = {
        prefix = "darkarmy_archer_tower_crow_lvl4",
        from = 19,
        to = 30
    },
    darkarmy_archer_tower_crow_lvl4_carry = {
        prefix = "darkarmy_archer_tower_crow_lvl4",
        from = 31,
        to = 44
    },
    --箭
    darkarmy_archer_arrow_travel = {
        prefix = "darkarmy_archer_arrow",
        from = 1,
        to = 4
    },
    darkarmy_archer_arrow_lvl4_travel = {
        prefix = "darkarmy_archer_arrow_lvl4",
        from = 1,
        to = 4
    },
    darkarmy_archer_arrow_special_travel = {
        prefix = "darkarmy_archer_arrow_special",
        from = 1,
        to = 1
    }, 
    darkarmy_archer_arrow_special_hit = {
        prefix = "darkarmy_archer_arrow_special",
        from = 2,
        to = 8
    }, 
    --箭尾焰
    darkarmy_archer_arrow_smoke_run = {
        prefix = "darkarmy_archer_arrow_smoke",
        from = 1,
        to = 4
    },
    --流血效果
    darkarmy_archer_tower_arrow_lvl4_blood_red = {
        prefix = "darkarmy_archer_tower_crow_lvl4_bloodRed",
        from = 1,
        to = 11
    },
    --防御塔本体
    darkarmy_archer_towers_lvl1_build = {
        prefix = "darkarmy_archer_towers",
        from = 1,
        to = 1
    },
    darkarmy_archer_towers_lvl1_idle = {
        prefix = "darkarmy_archer_towers",
        from = 2,
        to = 2
    },
    darkarmy_archer_towers_lvl2_idle = {
        prefix = "darkarmy_archer_towers",
        from = 3,
        to = 3
    },
    darkarmy_archer_towers_lvl3_idle = {
        prefix = "darkarmy_archer_towers",
        from = 4,
        to = 4
    },
    darkarmy_archer_towers_lvl4_idle = {
        prefix = "darkarmy_archer_towers_layer1",
        from = 5,
        to = 5
    },
    darkarmy_archer_towers_layer2_0005 = {
        prefix = "darkarmy_archer_towers_layer2",
        from = 5,
        to = 5
    },

}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_shadow_archer.lua

-- BEGIN kr3/data/animations/kr4_tower_shaolin.lua
do
	local __chunk = (function()
local a = {
--防御塔
    shaolin_temple_lvl1_build = {
        prefix = "shaolin_temple_lvl1",
        from = 1,
        to = 1
    },
    shaolin_temple_lvl1_idle = {
        prefix = "shaolin_temple_lvl1",
        from = 2,
        to = 2
    },
    shaolin_temple_lvl2_idle = {
        prefix = "shaolin_temple_lvl2",
        from = 1,
        to = 1
    },
    shaolin_temple_lvl3_idle = {
        prefix = "shaolin_temple_lvl3",
        from = 1,
        to = 1
    },
    shaolin_temple_lvl4_idle = {
        prefix = "shaolin_temple_lvl4",
        from = 1,
        to = 1
    },
    shaolin_temple_lvl4_lion_run = {
        prefix = "shaolin_temple_lvl4_lion",
        from = 1,
        to = 24
    },
--金币特效
    shaolin_abundance_coin_run = {
        prefix = "shaolin_abundance_coin",
        from = 1,
        to = 36
    },
--战士
    shaolin_dragon_warrior_idle = {
        prefix = "shaolin_dragon_warrior",
        from = 1,
        to = 1
    },
    shaolin_dragon_warrior_running = {
        prefix = "shaolin_dragon_warrior",
        from = 2,
        to = 25
    },
    shaolin_dragon_warrior_attack = {
        prefix = "shaolin_dragon_warrior",
        from = 26,
        to = 55
    },
    shaolin_dragon_warrior_death = {
        prefix = "shaolin_dragon_warrior",
        from = 56,
        to = 95
    },
    shaolin_dragon_warrior_raise = {
        prefix = "shaolin_dragon_warrior",
        from = 96,
        to = 115
    },
--1级攻击动作
    shaolin_monk_lvl1_idle = {
        prefix = "shaolin_monk_lvl1",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl1_punchIn = {
        prefix = "shaolin_monk_lvl1",
        from = 1,
        to = 9
    },
    shaolin_monk_lvl1_punchOut = {
        prefix = "shaolin_monk_lvl1",
        from = 10,
        to = 17
    },
    shaolin_monk_lvl1_kickIn = {
        prefix = "shaolin_monk_lvl1",
        from = 18,
        to = 26
    },
    shaolin_monk_lvl1_kickOut = {
        prefix = "shaolin_monk_lvl1",
        from = 27,
        to = 34
    },
    shaolin_monk_lvl1_dragonPunchUp = {
        prefix = "shaolin_monk_lvl1",
        from = 35,
        to = 36
    },
    shaolin_monk_lvl1_dragonPunchDown = {
        prefix = "shaolin_monk_lvl1",
        from = 37,
        to = 37
    },
    shaolin_monk_lvl1_dragonPunchOut = {
        prefix = "shaolin_monk_lvl1",
        from = 38,
        to = 44
    },
--2级攻击动作
    shaolin_monk_lvl2_idle = {
        prefix = "shaolin_monk_lvl2",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl2_punchIn = {
        prefix = "shaolin_monk_lvl2",
        from = 1,
        to = 9
    },
    shaolin_monk_lvl2_punchOut = {
        prefix = "shaolin_monk_lvl2",
        from = 10,
        to = 17
    },
    shaolin_monk_lvl2_kickIn = {
        prefix = "shaolin_monk_lvl2",
        from = 18,
        to = 26
    },
    shaolin_monk_lvl2_kickOut = {
        prefix = "shaolin_monk_lvl2",
        from = 27,
        to = 34
    },
    shaolin_monk_lvl2_dragonPunchUp = {
        prefix = "shaolin_monk_lvl2",
        from = 35,
        to = 36
    },
    shaolin_monk_lvl2_dragonPunchDown = {
        prefix = "shaolin_monk_lvl2",
        from = 37,
        to = 37
    },
    shaolin_monk_lvl2_dragonPunchOut = {
        prefix = "shaolin_monk_lvl2",
        from = 38,
        to = 44
    },
--3级攻击动作
    shaolin_monk_lvl3_idle = {
        prefix = "shaolin_monk_lvl3",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl3_punchIn = {
        prefix = "shaolin_monk_lvl3",
        from = 1,
        to = 9
    },
    shaolin_monk_lvl3_punchOut = {
        prefix = "shaolin_monk_lvl3",
        from = 10,
        to = 17
    },
    shaolin_monk_lvl3_kickIn = {
        prefix = "shaolin_monk_lvl3",
        from = 18,
        to = 26
    },
    shaolin_monk_lvl3_kickOut = {
        prefix = "shaolin_monk_lvl3",
        from = 27,
        to = 34
    },
    shaolin_monk_lvl3_dragonPunchUp = {
        prefix = "shaolin_monk_lvl3",
        from = 35,
        to = 36
    },
    shaolin_monk_lvl3_dragonPunchDown = {
        prefix = "shaolin_monk_lvl3",
        from = 37,
        to = 37
    },
    shaolin_monk_lvl3_dragonPunchOut = {
        prefix = "shaolin_monk_lvl3",
        from = 38,
        to = 44
    },
--4级攻击动作
    shaolin_monk_lvl4_idle = {
        prefix = "shaolin_monk_lvl4",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl4_punchIn = {
        prefix = "shaolin_monk_lvl4",
        from = 1,
        to = 9
    },
    shaolin_monk_lvl4_punchOut = {
        prefix = "shaolin_monk_lvl4",
        from = 10,
        to = 17
    },
    shaolin_monk_lvl4_kickIn = {
        prefix = "shaolin_monk_lvl4",
        from = 18,
        to = 26
    },
    shaolin_monk_lvl4_kickOut = {
        prefix = "shaolin_monk_lvl4",
        from = 27,
        to = 34
    },
    shaolin_monk_lvl4_dragonPunchUp = {
        prefix = "shaolin_monk_lvl4",
        from = 35,
        to = 36
    },
    shaolin_monk_lvl4_dragonPunchDown = {
        prefix = "shaolin_monk_lvl4",
        from = 37,
        to = 37
    },
    shaolin_monk_lvl4_dragonPunchOut = {
        prefix = "shaolin_monk_lvl4",
        from = 37,
        to = 44
    },
--人从塔离开/返回的动作
    shaolin_monk_lvl1_deco_idle = {
        prefix = "shaolin_monk_lvl1_deco",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl1_deco_out = {
        prefix = "shaolin_monk_lvl1_deco",
        from = 2,
        to = 6
    },
    shaolin_monk_lvl1_deco_in = {
        prefix = "shaolin_monk_lvl1_deco",
        from = 6,
        to = 20
    },
    shaolin_monk_lvl2_deco_idle = {
        prefix = "shaolin_monk_lvl2_deco",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl2_deco_out = {
        prefix = "shaolin_monk_lvl2_deco",
        from = 2,
        to = 6
    },
    shaolin_monk_lvl2_deco_in = {
        prefix = "shaolin_monk_lvl2_deco",
        from = 6,
        to = 20
    },
    shaolin_monk_lvl3_deco_idle = {
        prefix = "shaolin_monk_lvl3_deco",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl3_deco_out = {
        prefix = "shaolin_monk_lvl3_deco",
        from = 2,
        to = 6
    },
    shaolin_monk_lvl3_deco_in = {
        prefix = "shaolin_monk_lvl3_deco",
        from = 6,
        to = 20
    },
    shaolin_monk_lvl4_deco_idle = {
        prefix = "shaolin_monk_lvl4_deco",
        from = 1,
        to = 1
    },
    shaolin_monk_lvl4_deco_out = {
        prefix = "shaolin_monk_lvl4_deco",
        from = 2,
        to = 6
    },
    shaolin_monk_lvl4_deco_in = {
        prefix = "shaolin_monk_lvl4_deco",
        from = 6,
        to = 20
    },
--攻击效果
    shaolin_monk_lvl1_hit_effect_run = {
        prefix = "shaolin_monk_lvl1_hit_effect",
        from = 1,
        to = 11
    },
    shaolin_monk_lvl4_hit_effect_run = {
        prefix = "shaolin_monk_lvl4_hit_effect",
        from = 1,
        to = 11
    },

}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_shaolin.lua

-- BEGIN kr3/data/animations/kr4_tower_spirit_mausoleum.lua
do
	local __chunk = (function()
-- tower_spirit_mausoleum
local a = {
    spirit_mausoleum_bolt_hit = {
        prefix = "spirit_mausoleum_bolt",
        to = 10,
        from = 2
    },
    spirit_mausoleum_lvl1_layer1_idle = {
        prefix = "spirit_mausoleum_lvl1_layer1",
        to = 2,
        from = 2
    },
    spirit_mausoleum_lvl1_layer2_idle = {
        prefix = "spirit_mausoleum_lvl1_layer2",
        to = 2,
        from = 2
    },
    spirit_mausoleum_lvl1_layer3_idle = {
        prefix = "spirit_mausoleum_lvl1_layer3",
        to = 2,
        from = 2
    },
    spirit_mausoleum_lvl1_layer1_shoot = {
        prefix = "spirit_mausoleum_lvl1_layer1",
        to = 30,
        from = 3
    },
    spirit_mausoleum_lvl1_layer2_shoot = {
        prefix = "spirit_mausoleum_lvl1_layer2",
        to = 30,
        from = 3
    },
    spirit_mausoleum_lvl1_layer3_shoot = {
        prefix = "spirit_mausoleum_lvl1_layer3",
        to = 30,
        from = 3
    },
    spirit_mausoleum_lvl1_layer1_shootEmpty = {
        prefix = "spirit_mausoleum_lvl1_layer1",
        to = 58,
        from = 31
    },
    spirit_mausoleum_lvl1_layer2_shootEmpty = {
        prefix = "spirit_mausoleum_lvl1_layer2",
        to = 58,
        from = 31
    },
    spirit_mausoleum_lvl1_layer3_shootEmpty = {
        prefix = "spirit_mausoleum_lvl1_layer3",
        to = 58,
        from = 31
    },
    spirit_mausoleum_lvl2_layer1_idle = {
        prefix = "spirit_mausoleum_lvl2_layer1",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl2_layer2_idle = {
        prefix = "spirit_mausoleum_lvl2_layer2",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl2_layer3_idle = {
        prefix = "spirit_mausoleum_lvl2_layer3",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl2_layer1_shoot = {
        prefix = "spirit_mausoleum_lvl2_layer1",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl2_layer2_shoot = {
        prefix = "spirit_mausoleum_lvl2_layer2",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl2_layer3_shoot = {
        prefix = "spirit_mausoleum_lvl2_layer3",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl2_layer1_shootEmpty = {
        prefix = "spirit_mausoleum_lvl2_layer1",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl2_layer2_shootEmpty = {
        prefix = "spirit_mausoleum_lvl2_layer2",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl2_layer3_shootEmpty = {
        prefix = "spirit_mausoleum_lvl2_layer3",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl3_layer1_idle = {
        prefix = "spirit_mausoleum_lvl3_layer1",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl3_layer2_idle = {
        prefix = "spirit_mausoleum_lvl3_layer2",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl3_layer3_idle = {
        prefix = "spirit_mausoleum_lvl3_layer3",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl3_layer1_shoot = {
        prefix = "spirit_mausoleum_lvl3_layer1",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl3_layer2_shoot = {
        prefix = "spirit_mausoleum_lvl3_layer2",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl3_layer3_shoot = {
        prefix = "spirit_mausoleum_lvl3_layer3",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl3_layer1_shootEmpty = {
        prefix = "spirit_mausoleum_lvl3_layer1",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl3_layer2_shootEmpty = {
        prefix = "spirit_mausoleum_lvl3_layer2",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl3_layer3_shootEmpty = {
        prefix = "spirit_mausoleum_lvl3_layer3",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl4_layer1_idle = {
        prefix = "spirit_mausoleum_lvl4_layer1",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl4_layer2_idle = {
        prefix = "spirit_mausoleum_lvl4_layer2",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl4_layer3_idle = {
        prefix = "spirit_mausoleum_lvl4_layer3",
        to = 1,
        from = 1
    },
    spirit_mausoleum_lvl4_layer1_shoot = {
        prefix = "spirit_mausoleum_lvl4_layer1",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl4_layer2_shoot = {
        prefix = "spirit_mausoleum_lvl4_layer2",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl4_layer3_shoot = {
        prefix = "spirit_mausoleum_lvl4_layer3",
        to = 29,
        from = 2
    },
    spirit_mausoleum_lvl4_layer1_shootEmpty = {
        prefix = "spirit_mausoleum_lvl4_layer1",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl4_layer2_shootEmpty = {
        prefix = "spirit_mausoleum_lvl4_layer2",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl4_layer3_shootEmpty = {
        prefix = "spirit_mausoleum_lvl4_layer3",
        to = 57,
        from = 30
    },
    spirit_mausoleum_lvl4_layer1_cast = {
        prefix = "spirit_mausoleum_lvl4_layer1",
        to = 77,
        from = 58
    },
    spirit_mausoleum_lvl4_layer2_cast = {
        prefix = "spirit_mausoleum_lvl4_layer2",
        to = 77,
        from = 58
    },
    spirit_mausoleum_lvl4_layer3_cast = {
        prefix = "spirit_mausoleum_lvl4_layer3",
        to = 77,
        from = 58
    },
    spirit_mausoleum_lvl4_possession_spawn_run = {
        prefix = "spirit_mausoleum_lvl4_possession_spawn",
        to = 20,
        from = 1
    },
    spirit_mausoleum_lvl4_possession_proyectile_travel = {
        prefix = "spirit_mausoleum_lvl4_possession_proyectile",
        to = 12,
        from = 1
    },
    spirit_mausoleum_lvl4_possession_proyectile_hit = {
        prefix = "spirit_mausoleum_lvl4_possession_proyectile",
        to = 22,
        from = 13
    },
    spirit_mausoleum_lvl4_possession_decal_start = {
        prefix = "spirit_mausoleum_lvl4_possession_decal",
        to = 21,
        from = 1
    },
    spirit_mausoleum_lvl4_possession_decal_loop = {
        prefix = "spirit_mausoleum_lvl4_possession_decal",
        to = 49,
        from = 22
    },
    spirit_mausoleum_lvl4_possession_decal_end = {
        prefix = "spirit_mausoleum_lvl4_possession_decal",
        to = 74,
        from = 50
    },
    spirit_mausoleum_lvl4_gargoyle_idle = {
        prefix = "spirit_mausoleum_lvl4_gargoyle",
        to = 10,
        from = 1
    },
    spirit_mausoleum_lvl4_gargoyle_walk = {
        prefix = "spirit_mausoleum_lvl4_gargoyle",
        to = 10,
        from = 1
    },
    spirit_mausoleum_lvl4_gargoyle_attack = {
        prefix = "spirit_mausoleum_lvl4_gargoyle",
        to = 26,
        from = 11
    },
    spirit_mausoleum_lvl4_gargoyle_death = {
        prefix = "spirit_mausoleum_lvl4_gargoyle",
        to = 59,
        from = 27
    },
    spirit_mausoleum_lvl4_gargoyle_raise = {
        prefix = "spirit_mausoleum_lvl4_gargoyle",
        to = 81,
        from = 60
    },
    spirit_mausoleum_lvl4_gargoyle_spawn_run = {
        prefix = "spirit_mausoleum_lvl4_gargoyle_spawn",
        to = 35,
        from = 1
    },
    --[[
    draugr_idle = {
        prefix = "draugr",
        to = 1,
        from = 1
    },
    draugr_walk = {
        prefix = "draugr",
        to = 11,
        from = 2
    },
    draugr_walkUp = {
        prefix = "draugr",
        to = 31,
        from = 12
    },
    draugr_walkDown = {
        prefix = "draugr",
        to = 51,
        from = 32
    },
    draugr_attack = {
        prefix = "draugr",
        to = 73,
        from = 52
    },
    draugr_raise = {
        prefix = "draugr",
        to = 103,
        from = 74
    },
    draugr_death = {
        prefix = "draugr",
        to = 135,
        from = 104
    },
    ]]--
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_spirit_mausoleum.lua

-- BEGIN kr3/data/animations/kr4_tower_swamp_monster.lua
do
	local __chunk = (function()
local a = {
--泡泡
    swamp_monster_tower_bubble_run = {
        prefix = "swamp_monster_tower_bubble",
        from = 1,
        to = 35
    },
--爆炸
    swamp_monster_tower_explosion_run = {
        prefix = "swamp_monster_tower_explosion",
        from = 1,
        to = 18
    },
--防御塔上的烟雾
    swamp_monster_tower_smoke_run = {
        prefix = "swamp_monster_tower_smoke",
        from = 1,
        to = 20
    },
--spark
    swamp_monster_tower_sparks_run = {
        prefix = "swamp_monster_tower_sparks",
        from = 1,
        to = 35
    },
--spawn_explosion
    swamp_monster_tower_spawn_explosion_run = {
        prefix = "swamp_monster_tower_spawn_explosion",
        from = 1,
        to = 19
    },
--防御塔
    swamp_monster_towers_lvl1_build = {
        prefix = "swamp_monster_towers_lvl1",
        from = 1,
        to = 1
    },
    swamp_monster_towers_lvl1_idle = {
        prefix = "swamp_monster_towers_lvl1",
        from = 2,
        to = 2
    },
    swamp_monster_towers_lvl2_idle = {
        prefix = "swamp_monster_towers_lvl2",
        from = 1,
        to = 1
    },
    swamp_monster_towers_lvl3_idle = {
        prefix = "swamp_monster_towers_lvl3",
        from = 1,
        to = 1
    },
    swamp_monster_towers_lvl4_idle = {
        prefix = "swamp_monster_towers_lvl4",
        from = 1,
        to = 1
    },
--1级兵
    swamp_monster_unit_lvl1_idle = {
        prefix = "swamp_monster_unit_lvl1",
        from = 1,
        to = 1
    },
    swamp_monster_unit_lvl1_running = {
        prefix = "swamp_monster_unit_lvl1",
        from = 2,
        to = 33
    },
    swamp_monster_unit_lvl1_attack = {
        prefix = "swamp_monster_unit_lvl1",
        from = 34,
        to = 65
    },
    swamp_monster_unit_lvl1_death = {
        prefix = "swamp_monster_unit_lvl1",
        from = 66,
        to = 109
    },
    swamp_monster_unit_lvl1_raise = {
        prefix = "swamp_monster_unit_lvl1",
        from = 110,
        to = 131
    },
    swamp_monster_unit_lvl1_out = {
        prefix = "swamp_monster_unit_lvl1",
        from = 132,
        to = 145
    },
--2级兵
    swamp_monster_unit_lvl2_idle = {
        prefix = "swamp_monster_unit_lvl2",
        from = 1,
        to = 1
    },
    swamp_monster_unit_lvl2_running = {
        prefix = "swamp_monster_unit_lvl2",
        from = 2,
        to = 33
    },
    swamp_monster_unit_lvl2_attack = {
        prefix = "swamp_monster_unit_lvl2",
        from = 34,
        to = 65
    },
    swamp_monster_unit_lvl2_death = {
        prefix = "swamp_monster_unit_lvl2",
        from = 66,
        to = 105
    },
    swamp_monster_unit_lvl2_raise = {
        prefix = "swamp_monster_unit_lvl2",
        from = 106,
        to = 127
    },
    swamp_monster_unit_lvl2_out = {
        prefix = "swamp_monster_unit_lvl2",
        from = 128,
        to = 141
    },
--3级兵
    swamp_monster_unit_lvl3_idle = {
        prefix = "swamp_monster_unit_lvl3",
        from = 1,
        to = 1
    },
    swamp_monster_unit_lvl3_running = {
        prefix = "swamp_monster_unit_lvl3",
        from = 2,
        to = 33
    },
    swamp_monster_unit_lvl3_attack = {
        prefix = "swamp_monster_unit_lvl3",
        from = 34,
        to = 65
    },
    swamp_monster_unit_lvl3_death = {
        prefix = "swamp_monster_unit_lvl3",
        from = 66,
        to = 104
    },
    swamp_monster_unit_lvl3_raise = {
        prefix = "swamp_monster_unit_lvl3",
        from = 105,
        to = 126
    },
    swamp_monster_unit_lvl3_out = {
        prefix = "swamp_monster_unit_lvl3",
        from = 127,
        to = 140
    },
--4级兵
    swamp_monster_unit_lvl4_idle = {
        prefix = "swamp_monster_unit_lvl4",
        from = 1,
        to = 1
    },
    swamp_monster_unit_lvl4_running = {
        prefix = "swamp_monster_unit_lvl4",
        from = 2,
        to = 33
    },
    swamp_monster_unit_lvl4_attack = {
        prefix = "swamp_monster_unit_lvl4",
        from = 34,
        to = 65
    },
    swamp_monster_unit_lvl4_death = {
        prefix = "swamp_monster_unit_lvl4",
        from = 66,
        to = 104
    },
    swamp_monster_unit_lvl4_raise = {
        prefix = "swamp_monster_unit_lvl4",
        from = 105,
        to = 122
    },
    swamp_monster_unit_lvl4_instakill = {
        prefix = "swamp_monster_unit_lvl4",
        from = 123,
        to = 158
    },
    swamp_monster_unit_lvl4_stun = {
        prefix = "swamp_monster_unit_lvl4",
        from = 159,
        to = 191
    },
    swamp_monster_unit_lvl4_out = {
        prefix = "swamp_monster_unit_lvl4",
        from = 192,
        to = 205
    },
--1级射手
    swamp_monster_tower_shooter_lvl1_idle = {
        prefix = "swamp_monster_tower_shooter_lvl1",
        from = 1,
        to = 1
    },
    swamp_monster_tower_shooter_lvl1_shootDown = {
        prefix = "swamp_monster_tower_shooter_lvl1",
        from = 2,
        to = 33
    },
    swamp_monster_tower_shooter_lvl1_shootUp = {
        prefix = "swamp_monster_tower_shooter_lvl1",
        from = 34,
        to = 60
    },
    swamp_monster_tower_shooter_lvl1_idleUp = {
        prefix = "swamp_monster_tower_shooter_lvl1",
        from = 61,
        to = 61
    },
--2级射手
    swamp_monster_tower_shooter_lvl2_idle = {
        prefix = "swamp_monster_tower_shooter_lvl2",
        from = 1,
        to = 1
    },
    swamp_monster_tower_shooter_lvl2_shootDown = {
        prefix = "swamp_monster_tower_shooter_lvl2",
        from = 2,
        to = 33
    },
    swamp_monster_tower_shooter_lvl2_shootUp = {
        prefix = "swamp_monster_tower_shooter_lvl2",
        from = 34,
        to = 60
    },
    swamp_monster_tower_shooter_lvl2_idleUp = {
        prefix = "swamp_monster_tower_shooter_lvl2",
        from = 61,
        to = 61
    },
--3级射手
    swamp_monster_tower_shooter_lvl3_idle = {
        prefix = "swamp_monster_tower_shooter_lvl3",
        from = 1,
        to = 1
    },
    swamp_monster_tower_shooter_lvl3_shootDown = {
        prefix = "swamp_monster_tower_shooter_lvl3",
        from = 2,
        to = 33
    },
    swamp_monster_tower_shooter_lvl3_shootUp = {
        prefix = "swamp_monster_tower_shooter_lvl3",
        from = 34,
        to = 60
    },
    swamp_monster_tower_shooter_lvl3_idleUp = {
        prefix = "swamp_monster_tower_shooter_lvl3",
        from = 61,
        to = 61
    },
--4级射手
    swamp_monster_tower_shooter_lvl4_layerX_idle = {
        layer_prefix = "swamp_monster_tower_shooter_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 1,
        to = 1
    },
    swamp_monster_tower_shooter_lvl4_layerX_shootDown = {
        layer_prefix = "swamp_monster_tower_shooter_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 2,
        to = 33
    },
    swamp_monster_tower_shooter_lvl4_layerX_shootUp = {
        layer_prefix = "swamp_monster_tower_shooter_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 34,
        to = 60
    },
    swamp_monster_tower_shooter_lvl4_layerX_idleUp = {
        layer_prefix = "swamp_monster_tower_shooter_lvl4_layer%i",
        layer_from = 1,
        layer_to = 3,
        from = 61,
        to = 61
    },




}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_swamp_monster.lua

-- BEGIN kr3/data/animations/kr4_tower_wicked_sisters.lua
do
	local __chunk = (function()
local a = {
--切换形态
    wicked_sisters_cauldron_toViolet = {
        prefix = "wicked_sisters_cauldron",
        from = 1,
        to = 30
    },
    wicked_sisters_cauldron_Violet = {
        prefix = "wicked_sisters_cauldron",
        from = 30,
        to = 30
    },
    wicked_sisters_cauldron_toGreen = {
        prefix = "wicked_sisters_cauldron",
        from = 31,
        to = 53
    },
    wicked_sisters_cauldron_Green = {
        prefix = "wicked_sisters_cauldron",
        from = 53,
        to = 53
    },
--锅炉火
    wicked_sisters_cauldron_fire_run = {
        prefix = "wicked_sisters_cauldron_fire",
        from = 1,
        to = 12
    },
--锅炉烟雾
    wicked_sisters_cauldron_smoke_green = {
        prefix = "wicked_sisters_cauldron_smoke",
        from = 1,
        to = 28
    },
    wicked_sisters_cauldron_smoke_violet = {
        prefix = "wicked_sisters_cauldron_smoke",
        from = 29,
        to = 56
    },
--青蛙
    wicked_sisters_frog_idle = {
        prefix = "wicked_sisters_frog",
        from = 1,
        to = 1
    },
    wicked_sisters_frog_talk = {
        prefix = "wicked_sisters_frog",
        from = 2,
        to = 19
    },
    wicked_sisters_frog_walk = {
        prefix = "wicked_sisters_frog",
        from = 20,
        to = 33
    },
    wicked_sisters_frog_walkingRightLeft = {
        prefix = "wicked_sisters_frog",
        from = 20,
        to = 33
    },
    wicked_sisters_frog_walkingDown = {
        prefix = "wicked_sisters_frog",
        from = 34,
        to = 47
    },
    wicked_sisters_frog_walkingUp = {
        prefix = "wicked_sisters_frog",
        from = 48,
        to = 61
    },
    wicked_sisters_frog_death = {
        prefix = "wicked_sisters_frog",
        from = 48,
        to = 61
    },
--变蛙攻击
    wicked_sisters_froggification_hit_run = {
        prefix = "wicked_sisters_froggification_hit",
        from = 1,
        to = 8
    },
    wicked_sisters_froggification_ray_travel = {
        prefix = "wicked_sisters_froggification_ray",
        from = 1,
        to = 13
    },
    wicked_sisters_froggification_smoke_run = {
        prefix = "wicked_sisters_froggification_smoke",
        from = 1,
        to = 18
    },
--烟囱
    wicked_sisters_lvl4_chimney_loop = {
        prefix = "wicked_sisters_lvl4_chimney",
        from = 1,
        to = 27
    },
    wicked_sisters_lvl4_chimney_run = {
        prefix = "wicked_sisters_lvl4_chimney",
        from = 28,
        to = 85
    },
--小孩
    wicked_sisters_lvl4_kid_run = {
        prefix = "wicked_sisters_lvl4_kid",
        from = 1,
        to = 100--50
    },
    wicked_sisters_lvl4_kid_loop = {
        prefix = "wicked_sisters_lvl4_kid",
        from = 51,
        to = 51
    },
--图腾
    wicked_sisters_lvl4_totem_start = {
        prefix = "wicked_sisters_lvl4_totem",
        from = 1,
        to = 21
    },
    wicked_sisters_lvl4_totem_run = {
        prefix = "wicked_sisters_lvl4_totem",
        from = 22,
        to = 22
    },
    wicked_sisters_lvl4_totem_end = {
        prefix = "wicked_sisters_lvl4_totem",
        from = 23,
        to = 56
    },
--图腾效果
    wicked_sisters_lvl4_totem_modifier_run = {
        prefix = "wicked_sisters_lvl4_totem_modifier",
        from = 1,
        to = 16
    },
--防御塔
    wicked_sisters_tower_lvl1_build = {
        prefix = "wicked_sisters",
        from = 1,
        to = 1
    },
    wicked_sisters_tower_lvl1_idle = {
        prefix = "wicked_sisters",
        from = 2,
        to = 2
    },
    wicked_sisters_tower_lvl2_idle = {
        prefix = "wicked_sisters",
        from = 3,
        to = 3
    },
    wicked_sisters_tower_lvl3_idle = {
        prefix = "wicked_sisters",
        from = 4,
        to = 4
    },
    wicked_sisters_tower_lvl4_idle = {
        prefix = "wicked_sisters",
        from = 5,
        to = 5
    },
--法台女巫
    wicked_sisters_witch_idle = {
        prefix = "wicked_sisters_witch",
        from = 1,
        to = 1
    },
    wicked_sisters_witch_toGreen = {
        prefix = "wicked_sisters_witch",
        from = 2,
        to = 91
    },
    wicked_sisters_witch_toViolet = {
        prefix = "wicked_sisters_witch",
        from = 91,
        to = 178
    },
    wicked_sisters_witch_stir = {
        prefix = "wicked_sisters_witch",
        from = 178,
        to = 309--254
    },
--飞行女巫
    wicked_witch_walk = {
        prefix = "wicked_witch_layer1",
        from = 1,
        to = 18
    },
    wicked_witch_idle = {
        prefix = "wicked_witch_layer1",
        from = 1,
        to = 18
    },
    wicked_witch_shoot = {
        prefix = "wicked_witch_layer1",
        from = 19,
        to = 54
    },
    wicked_witch_shootGreen = {
        prefix = "wicked_witch_layer1",
        from = 55,
        to = 90
    },
    wicked_witch_shootPower = {--1技能和2技能都是这个动画
        prefix = "wicked_witch_layer1",
        from = 91,
        to = 146
    },
    wicked_witch_spawn = {--出现
        prefix = "wicked_witch_layer1",
        from = 147,
        to = 172
    },

--子弹
    wicked_sisters_proyectile_travel = {
        prefix = "wicked_sisters_proy_green",
        from = 1,
        to = 7
    },
    wicked_sisters_proyectile_hit_run = {
        prefix = "wicked_sisters_proy_green",
        from = 8,
        to = 15
    },
    wicked_sisters_proyectile_violet_travel = {
        prefix = "wicked_sisters_proy_pink",
        from = 1,
        to = 7
    },
    wicked_sisters_proyectile_hit_violet_run = {
        prefix = "wicked_sisters_proy_pink",
        from = 8,
        to = 15
    },
    wicked_sisters_proyectile_particle_run = {
        prefix = "wicked_sisters_proy_green_particle",
        from = 1,
        to = 20
    },

}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_wicked_sisters.lua

-- BEGIN kr3/data/animations/kr4_tower_wormnest.lua
do
	local __chunk = (function()
local a = {
--塔
    worm_nest_level1_build = {
        prefix = "worm_nest_level1",
        from = 1,
        to = 29
    },
    worm_nest_level1_idle = {
        prefix = "worm_nest_level1",
        from = 30,
        to = 106
    },
    worm_nest_level1_shoot = {
        prefix = "worm_nest_level1",
        from = 107,
        to = 154
    },
    worm_nest_level2_idle = {
        prefix = "worm_nest_level2",
        from = 1,
        to = 76
    },
    worm_nest_level2_shoot = {
        prefix = "worm_nest_level2",
        from = 77,
        to = 124
    },
    worm_nest_level3_idle = {
        prefix = "worm_nest_level3",
        from = 1,
        to = 76
    },
    worm_nest_level3_shoot = {
        prefix = "worm_nest_level3",
        from = 77,
        to = 124
    },
    worm_nest_level4_idle = {
        prefix = "worm_nest_level4",
        from = 1,
        to = 76
    },
    worm_nest_level4_shoot = {
        prefix = "worm_nest_level4",
        from = 77,
        to = 124
    },
    worm_nest_level4_spit = {
        prefix = "worm_nest_level4",
        from = 125,
        to = 166
    },
    worm_nest_level4_instakill = {
        prefix = "worm_nest_level4",
        from = 167,
        to = 296
    },
--秒杀
    worm_nest_level4_instakill_run = {
        prefix = "worm_nest_level4_instakill",
        from = 1,
        to = 51
    },
    worm_nest_level4_instakill_decal_run = {
        prefix = "worm_nest_level4_instakill_decal",
        from = 1,
        to = 14
    },
    worm_nest_level4_instakill_dust_run = {
        prefix = "worm_nest_level4_instakill_dust",
        from = 1,
        to = 11
    },
--普攻
    worm_nest_attack_in = {
        prefix = "worm_nest_attack",
        from = 1,
        to = 26
    },
    worm_nest_attack_run = {
        prefix = "worm_nest_attack",
        from = 27,
        to = 77
    },
    worm_nest_attack_out = {
        prefix = "worm_nest_attack",
        from = 78,
        to = 103
    },
--召唤物
     worm_nest_level4_tremor_idle = {
        prefix = "worm_nest_level4_tremor",
        from = 43,
        to = 43
    },
    worm_nest_level4_tremor_in = {
        prefix = "worm_nest_level4_tremor",
        from = 64,
        to = 79
    },
    worm_nest_level4_tremor_running = {
        prefix = "worm_nest_level4_tremor",
        from = 1,
        to = 14
    },
    worm_nest_level4_tremor_walk = {
        prefix = "worm_nest_level4_tremor",
        from = 1,
        to = 14
    },
    worm_nest_level4_tremor_walkUp = {
        prefix = "worm_nest_level4_tremor",
        from = 15,
        to = 28
    },
    worm_nest_level4_tremor_walkDown = {
        prefix = "worm_nest_level4_tremor",
        from = 29,
        to = 42
    },
    worm_nest_level4_tremor_death = {
        prefix = "worm_nest_level4_tremor",
        from = 80,
        to = 98
    },
    worm_nest_level4_tremor_attack = {
        prefix = "worm_nest_level4_tremor",
        from = 43,
        to = 63
    },
    worm_nest_level4_tremor_raise = {
        prefix = "worm_nest_level4_tremor",
        from = 99,
        to = 109
    },
--粘液
    worm_nest_level4_spit_decal_in = {
        prefix = "worm_nest_level4_spit_decal",
        from = 1,
        to = 18
    },
    worm_nest_level4_spit_decal_run = {
        prefix = "worm_nest_level4_spit_decal",
        from = 19,
        to = 19
    },
    worm_nest_level4_spit_hit_run = {
        prefix = "worm_nest_level4_spit_hit",
        from = 1,
        to = 7
    },
    worm_nest_level4_spit_trail_run = {
        prefix = "worm_nest_level4_spit_trail",
        from = 1,
        to = 11
    },
    
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_tower_wormnest.lua

-- BEGIN kr3/data/animations/kr4_towers_and_soldiers.lua
do
	local __chunk = (function()
return {
	-- tower_twilight_elves_barrack
	elves_soldier_harasser_lvl2_idle = {
		prefix = "elves_soldier_harasser_lvl2",
		to = 1,
		from = 1
	},
	elves_soldier_harasser_lvl2_walk = {
		prefix = "elves_soldier_harasser_lvl2",
		to = 7,
		from = 2
	},
	elves_soldier_harasser_lvl2_attack = {
		prefix = "elves_soldier_harasser_lvl2",
		to = 31,
		from = 8
	},
	elves_soldier_harasser_lvl2_attack2 = {
		prefix = "elves_soldier_harasser_lvl2",
		to = 55,
		from = 32
	},
	elves_soldier_harasser_lvl2_shoot = {
		to = 77,
		from = 56,
		prefix = "elves_soldier_harasser_lvl2"
	},
	elves_soldier_harasser_lvl2_dodge = {
		to = 95,
		from = 78,
		prefix = "elves_soldier_harasser_lvl2"
	},
	elves_soldier_harasser_lvl2_death = {
		prefix = "elves_soldier_harasser_lvl2",
		to = 111,
		from = 96
	},
	twilight_elves_barrack_tower_lvl2_open = {
		prefix = "twilight_elves_barrack_tower_lvl2_layer2",
		to = 12,
		from = 1
	},
	twilight_elves_barrack_tower_lvl2_close = {
		prefix = "twilight_elves_barrack_tower_lvl2_layer2",
		to = 23,
		from = 13
	},
	elves_soldier_harasser_lvl3_idle = {
		prefix = "elves_soldier_harasser_lvl3",
		to = 1,
		from = 1
	},
	elves_soldier_harasser_lvl3_walk = {
		prefix = "elves_soldier_harasser_lvl3",
		to = 7,
		from = 2
	},
	elves_soldier_harasser_lvl3_attack = {
		prefix = "elves_soldier_harasser_lvl3",
		to = 29,
		from = 8
	},
	elves_soldier_harasser_lvl3_attack2 = {
		prefix = "elves_soldier_harasser_lvl3",
		to = 53,
		from = 30
	},
	elves_soldier_harasser_lvl3_shoot = {
		to = 77,
		from = 54,
		prefix = "elves_soldier_harasser_lvl3"
	},
	elves_soldier_harasser_lvl3_dodge = {
		to = 92,
		from = 78,
		prefix = "elves_soldier_harasser_lvl3"
	},
	elves_soldier_harasser_lvl3_death = {
		prefix = "elves_soldier_harasser_lvl3",
		to = 109,
		from = 93
	},
	twilight_elves_barrack_tower_lvl3_open = {
		prefix = "twilight_elves_barrack_tower_lvl3_layer2",
		to = 12,
		from = 1
	},
	twilight_elves_barrack_tower_lvl3_close = {
		prefix = "twilight_elves_barrack_tower_lvl3_layer2",
		to = 23,
		from = 13
	},
	elves_soldier_harasser_lvl4_idle = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 1,
		from = 1
	},
	elves_soldier_harasser_lvl4_walk = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 17,
		from = 2
	},
	elves_soldier_harasser_lvl4_attack = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 35,
		from = 18
	},
	elves_soldier_harasser_lvl4_attack2 = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 69,
		from = 36
	},
	elves_soldier_harasser_lvl4_shoot = {
		to = 93,
		from = 70,
		prefix = "elves_soldier_harasser_lvl4"
	},
	elves_soldier_harasser_lvl4_inshoot = {
		to = 101,
		from = 94,
		prefix = "elves_soldier_harasser_lvl4"
	},
	elves_soldier_harasser_lvl4_multishoot = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 106,
		from = 102
	},
	elves_soldier_harasser_lvl4_outshoot = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 119,
		from = 107
	},
	elves_soldier_harasser_lvl4_backstabHit = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 135,
		from = 120
	},
	elves_soldier_harasser_lvl4_backstab = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 155,
		from = 136
	},
	elves_soldier_harasser_lvl4_death = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 171,
		from = 156
	},
	elves_soldier_harasser_lvl4_transform = {
		prefix = "elves_soldier_harasser_lvl4",
		to = 245,
		from = 172
	},
	twilight_elves_barrack_tower_lvl4_open = {
		prefix = "twilight_elves_barrack_tower_lvl4_layer2",
		to = 9,
		from = 1
	},
	twilight_elves_barrack_tower_lvl4_close = {
		prefix = "twilight_elves_barrack_tower_lvl4_layer2",
		to = 20,
		from = 10
	},
	elves_soldier_espectral_harasser_run_effect_run = {
		prefix = "elves_soldier_espectral_harasser_run_effect",
		to = 4,
		from = 1
	},
	elves_soldier_espectral_harasser_idle = {
		prefix = "elves_soldier_espectral_harasser",
		to = 10,
		from = 1
	},
	elves_soldier_espectral_harasser_walk = {
		prefix = "elves_soldier_espectral_harasser",
		to = 26,
		from = 11
	},
	elves_soldier_espectral_harasser_attack = {
		prefix = "elves_soldier_espectral_harasser",
		to = 51,
		from = 27
	},
	elves_soldier_espectral_harasser_death = {
		prefix = "elves_soldier_espectral_harasser",
		to = 95,
		from = 52
	},
	elves_soldier_espectral_harasser_raise = {
		prefix = "elves_soldier_espectral_harasser",
		to = 158,
		from = 96
	},
	-- tower_spirit_mausoleum
	spirit_mausoleum_bolt_hit = {
		prefix = "spirit_mausoleum_bolt",
		to = 10,
		from = 2
	},
	spirit_mausoleum_lvl2_layer1_idle = {
		prefix = "spirit_mausoleum_lvl2_layer1",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl2_layer2_idle = {
		prefix = "spirit_mausoleum_lvl2_layer2",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl2_layer3_idle = {
		prefix = "spirit_mausoleum_lvl2_layer3",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl2_layer1_shoot = {
		prefix = "spirit_mausoleum_lvl2_layer1",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl2_layer2_shoot = {
		prefix = "spirit_mausoleum_lvl2_layer2",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl2_layer3_shoot = {
		prefix = "spirit_mausoleum_lvl2_layer3",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl2_layer1_shootEmpty = {
		prefix = "spirit_mausoleum_lvl2_layer1",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl2_layer2_shootEmpty = {
		prefix = "spirit_mausoleum_lvl2_layer2",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl2_layer3_shootEmpty = {
		prefix = "spirit_mausoleum_lvl2_layer3",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl3_layer1_idle = {
		prefix = "spirit_mausoleum_lvl3_layer1",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl3_layer2_idle = {
		prefix = "spirit_mausoleum_lvl3_layer2",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl3_layer3_idle = {
		prefix = "spirit_mausoleum_lvl3_layer3",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl3_layer1_shoot = {
		prefix = "spirit_mausoleum_lvl3_layer1",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl3_layer2_shoot = {
		prefix = "spirit_mausoleum_lvl3_layer2",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl3_layer3_shoot = {
		prefix = "spirit_mausoleum_lvl3_layer3",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl3_layer1_shootEmpty = {
		prefix = "spirit_mausoleum_lvl3_layer1",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl3_layer2_shootEmpty = {
		prefix = "spirit_mausoleum_lvl3_layer2",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl3_layer3_shootEmpty = {
		prefix = "spirit_mausoleum_lvl3_layer3",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl4_layer1_idle = {
		prefix = "spirit_mausoleum_lvl4_layer1",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl4_layer2_idle = {
		prefix = "spirit_mausoleum_lvl4_layer2",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl4_layer3_idle = {
		prefix = "spirit_mausoleum_lvl4_layer3",
		to = 1,
		from = 1
	},
	spirit_mausoleum_lvl4_layer1_shoot = {
		prefix = "spirit_mausoleum_lvl4_layer1",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl4_layer2_shoot = {
		prefix = "spirit_mausoleum_lvl4_layer2",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl4_layer3_shoot = {
		prefix = "spirit_mausoleum_lvl4_layer3",
		to = 29,
		from = 2
	},
	spirit_mausoleum_lvl4_layer1_shootEmpty = {
		prefix = "spirit_mausoleum_lvl4_layer1",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl4_layer2_shootEmpty = {
		prefix = "spirit_mausoleum_lvl4_layer2",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl4_layer3_shootEmpty = {
		prefix = "spirit_mausoleum_lvl4_layer3",
		to = 57,
		from = 30
	},
	spirit_mausoleum_lvl4_layer1_cast = {
		prefix = "spirit_mausoleum_lvl4_layer1",
		to = 77,
		from = 58
	},
	spirit_mausoleum_lvl4_layer2_cast = {
		prefix = "spirit_mausoleum_lvl4_layer2",
		to = 77,
		from = 58
	},
	spirit_mausoleum_lvl4_layer3_cast = {
		prefix = "spirit_mausoleum_lvl4_layer3",
		to = 77,
		from = 58
	},
	spirit_mausoleum_lvl4_possession_spawn_run = {
		prefix = "spirit_mausoleum_lvl4_possession_spawn",
		to = 20,
		from = 1
	},
	spirit_mausoleum_lvl4_possession_proyectile_travel = {
		prefix = "spirit_mausoleum_lvl4_possession_proyectile",
		to = 12,
		from = 1
	},
	spirit_mausoleum_lvl4_possession_proyectile_hit = {
		prefix = "spirit_mausoleum_lvl4_possession_proyectile",
		to = 22,
		from = 13
	},
	spirit_mausoleum_lvl4_possession_decal_start = {
		prefix = "spirit_mausoleum_lvl4_possession_decal",
		to = 21,
		from = 1
	},
	spirit_mausoleum_lvl4_possession_decal_loop = {
		prefix = "spirit_mausoleum_lvl4_possession_decal",
		to = 49,
		from = 22
	},
	spirit_mausoleum_lvl4_possession_decal_end = {
		prefix = "spirit_mausoleum_lvl4_possession_decal",
		to = 74,
		from = 50
	},
	spirit_mausoleum_lvl4_gargoyle_idle = {
		prefix = "spirit_mausoleum_lvl4_gargoyle",
		to = 10,
		from = 1
	},
	spirit_mausoleum_lvl4_gargoyle_walk = {
		prefix = "spirit_mausoleum_lvl4_gargoyle",
		to = 10,
		from = 1
	},
	spirit_mausoleum_lvl4_gargoyle_attack = {
		prefix = "spirit_mausoleum_lvl4_gargoyle",
		to = 26,
		from = 11
	},
	spirit_mausoleum_lvl4_gargoyle_death = {
		prefix = "spirit_mausoleum_lvl4_gargoyle",
		to = 59,
		from = 27
	},
	spirit_mausoleum_lvl4_gargoyle_raise = {
		prefix = "spirit_mausoleum_lvl4_gargoyle",
		to = 81,
		from = 60
	},
	spirit_mausoleum_lvl4_gargoyle_spawn_run = {
		prefix = "spirit_mausoleum_lvl4_gargoyle_spawn",
		to = 35,
		from = 1
	},
	draugr_idle = {
		prefix = "draugr",
		to = 1,
		from = 1
	},
	draugr_walk = {
		prefix = "draugr",
		to = 11,
		from = 2
	},
	draugr_walkUp = {
		prefix = "draugr",
		to = 31,
		from = 12
	},
	draugr_walkDown = {
		prefix = "draugr",
		to = 51,
		from = 32
	},
	draugr_attack = {
		prefix = "draugr",
		to = 73,
		from = 52
	},
	draugr_raise = {
		prefix = "draugr",
		to = 103,
		from = 74
	},
	draugr_death = {
		prefix = "draugr",
		to = 135,
		from = 104
	},
	-- tower_warmongers_barrack
	warmongers_soldier_orc_lvl1_idle = {
		prefix = "warmongers_soldier_orc_lvl1",
		to = 1,
		from = 1
	},
	warmongers_soldier_orc_lvl1_walk = {
		prefix = "warmongers_soldier_orc_lvl1",
		to = 17,
		from = 2
	},
	warmongers_soldier_orc_lvl1_attack = {
		prefix = "warmongers_soldier_orc_lvl1",
		to = 39,
		from = 18
	},
	warmongers_soldier_orc_lvl1_death = {
		prefix = "warmongers_soldier_orc_lvl1",
		to = 55,
		from = 40
	},
	warmongers_soldier_orc_lvl2_idle = {
		prefix = "warmongers_soldier_orc_lvl2",
		to = 1,
		from = 1
	},
	warmongers_soldier_orc_lvl2_walk = {
		prefix = "warmongers_soldier_orc_lvl2",
		to = 17,
		from = 2
	},
	warmongers_soldier_orc_lvl2_attack = {
		prefix = "warmongers_soldier_orc_lvl2",
		to = 39,
		from = 18
	},
	warmongers_soldier_orc_lvl2_death = {
		prefix = "warmongers_soldier_orc_lvl2",
		to = 55,
		from = 40
	},
	warmongers_soldier_orc_lvl3_idle = {
		prefix = "warmongers_soldier_orc_lvl3",
		to = 1,
		from = 1
	},
	warmongers_soldier_orc_lvl3_walk = {
		prefix = "warmongers_soldier_orc_lvl3",
		to = 17,
		from = 2
	},
	warmongers_soldier_orc_lvl3_attack = {
		prefix = "warmongers_soldier_orc_lvl3",
		to = 39,
		from = 18
	},
	warmongers_soldier_orc_lvl3_death = {
		prefix = "warmongers_soldier_orc_lvl3",
		to = 55,
		from = 40
	},
	warmongers_soldier_orc_lvl4_idle = {
		prefix = "warmongers_soldier_orc_lvl4",
		to = 1,
		from = 1
	},
	warmongers_soldier_orc_lvl4_walk = {
		prefix = "warmongers_soldier_orc_lvl4",
		to = 17,
		from = 2
	},
	warmongers_soldier_orc_lvl4_attack = {
		prefix = "warmongers_soldier_orc_lvl4",
		to = 39,
		from = 18
	},
	warmongers_soldier_orc_lvl4_death = {
		prefix = "warmongers_soldier_orc_lvl4",
		to = 55,
		from = 40
	},
	warmongers_soldier_orc_captain_idle = {
		prefix = "warmongers_soldier_orc_captain",
		to = 1,
		from = 1
	},
	warmongers_soldier_orc_captain_walk = {
		prefix = "warmongers_soldier_orc_captain",
		to = 17,
		from = 2
	},
	warmongers_soldier_orc_captain_attack = {
		prefix = "warmongers_soldier_orc_captain",
		to = 39,
		from = 18
	},
	warmongers_soldier_orc_captain_death = {
		prefix = "warmongers_soldier_orc_captain",
		to = 54,
		from = 40
	},
	warmongers_soldier_orc_captain_raise = {
		prefix = "warmongers_soldier_orc_captain",
		to = 88,
		from = 55
	},
	warmongers_soldier_orc_captain_rage = {
		prefix = "warmongers_soldier_orc_captain_rage",
		to = 16,
		from = 1
	},
	warmongers_soldier_orc_captain_weakness_small = {
		prefix = "warmongers_soldier_orc_captain_weakness_small",
		to = 9,
		from = 1
	},
	warmongers_soldier_orc_captain_weakness_big = {
		prefix = "warmongers_soldier_orc_captain_weakness_big",
		to = 9,
		from = 1
	},
	warmongers_barrack_towers_lvl1_open = {
		prefix = "warmongers_barrack_towers_lvl1_layer2",
		to = 4,
		from = 2
	},
	warmongers_barrack_towers_lvl1_close = {
		prefix = "warmongers_barrack_towers_lvl1_layer2",
		to = 7,
		from = 5
	},
	warmongers_barrack_towers_lvl2_open = {
		prefix = "warmongers_barrack_towers_lvl2_layer2",
		to = 4,
		from = 2
	},
	warmongers_barrack_towers_lvl2_close = {
		prefix = "warmongers_barrack_towers_lvl2_layer2",
		to = 7,
		from = 5
	},
	warmongers_barrack_towers_lvl3_open = {
		prefix = "warmongers_barrack_towers_lvl3_layer2",
		to = 4,
		from = 2
	},
	warmongers_barrack_towers_lvl3_close = {
		prefix = "warmongers_barrack_towers_lvl3_layer2",
		to = 7,
		from = 5
	},
	warmongers_barrack_towers_lvl4_open = {
		prefix = "warmongers_barrack_towers_lvl4_layer2",
		to = 4,
		from = 2
	},
	warmongers_barrack_towers_lvl4_close = {
		prefix = "warmongers_barrack_towers_lvl4_layer2",
		to = 7,
		from = 5
	},
	-- tower_hammerhold_archer
	hammerhold_archer_arrow = {
		prefix = "hammerhold_archer_arrow",
		to = 4,
		from = 1
	},
	hammerhold_archer_tower_shooter_idle = {
		prefix = "hammerhold_archer_tower_shooter",
		to = 1,
		from = 1
	},
	hammerhold_archer_tower_shooter_idleUp = {
		prefix = "hammerhold_archer_tower_shooter",
		to = 23,
		from = 23
	},
	hammerhold_archer_tower_shooter_shootDown = {
		prefix = "hammerhold_archer_tower_shooter",
		to = 22,
		from = 2
	},
	hammerhold_archer_tower_shooter_shootUp = {
		prefix = "hammerhold_archer_tower_shooter",
		to = 43,
		from = 24
	},
	legion_archer_idle = {
		prefix = "legion_archer",
		to = 1,
		from = 1
	},
	legion_archer_walk = {
		prefix = "legion_archer",
		to = 21,
		from = 2
	},
	legion_archer_walkDown = {
		prefix = "legion_archer",
		to = 41,
		from = 22
	},
	legion_archer_walkUp = {
		prefix = "legion_archer",
		to = 61,
		from = 42
	},
	legion_archer_attack = {
		prefix = "legion_archer",
		to = 80,
		from = 62
	},
	legion_archer_range = {
		prefix = "legion_archer",
		to = 103,
		from = 81
	},
	legion_archer_death = {
		prefix = "legion_archer",
		to = 121,
		from = 104
	},
	war_elephant_drummer_idle = {
		prefix = "war_elephant_drummer",
		to = 72,
		from = 72
	},
	war_elephant_drummer_raise = {
		prefix = "war_elephant_drummer",
		to = 35,
		from = 46
	},
	war_elephant_drummer_afterRaising = {
		prefix = "war_elephant_drummer",
		post = {
			1,
			2,
			3,
			4,
			72
		}
	},
	war_elephant_drummer_walk = {
		prefix = "war_elephant_drummer",
		to = 34,
		from = 1
	},
	war_elephant_drummer_death = {
		prefix = "war_elephant_drummer",
		to = 71,
		from = 35
	},
	war_elephant_drummer_buff_unit = {
		prefix = "war_elephant_drummer_buff_unit",
		to = 20,
		from = 1
	},
	war_elephant_drummer_decal = {
		prefix = "war_elephant_drummer_decal",
		to = 20,
		from = 1
	},
	war_elephant_drummer_only_idle = {
		prefix = "war_elephant_drummer_only_layer1",
		to = 25,
		from = 1
	},
	war_elephant_drummer_only_playIn = {
		prefix = "war_elephant_drummer_only_layer1",
		to = 33,
		from = 26
	},
	war_elephant_drummer_only_playLoop = {
		prefix = "war_elephant_drummer_only_layer1",
		to = 61,
		from = 34
	},
	war_elephant_drummer_only_playOut = {
		prefix = "war_elephant_drummer_only_layer1",
		to = 71,
		from = 62
	},
	war_elephant_archers_idle = {
		prefix = "war_elephant_archers",
		to = 72,
		from = 72
	},
	war_elephant_archers_raise = {
		prefix = "war_elephant_archers",
		to = 35,
		from = 46
	},
	war_elephant_archers_afterRaising = {
		prefix = "war_elephant_archers",
		post = {
			1,
			2,
			3,
			4,
			72
		}
	},
	war_elephant_archers_walk = {
		prefix = "war_elephant_archers",
		to = 34,
		from = 1
	},
	war_elephant_archers_death = {
		prefix = "war_elephant_archers",
		to = 71,
		from = 35
	},
	war_elephant_archer_unit_idle = {
		prefix = "war_elephant_archer_unit_layer1",
		to = 1,
		from = 1
	},
	war_elephant_archer_unit_range = {
		prefix = "war_elephant_archer_unit_layer1",
		to = 24,
		from = 2
	},
	-- pirates
	corsair_idle = {
		prefix = "corsair",
		to = 1,
		from = 1
	},
	corsair_walk = {
		prefix = "corsair",
		to = 25,
		from = 2
	},
	corsair_walkDown = {
		prefix = "corsair",
		to = 49,
		from = 26
	},
	corsair_walkUp = {
		prefix = "corsair",
		to = 72,
		from = 50
	},
	corsair_attack = {
		prefix = "corsair",
		to = 95,
		from = 73
	},
	corsair_heal = {
		prefix = "corsair",
		to = 127,
		from = 96
	},
	corsair_death = {
		prefix = "corsair",
		to = 145,
		from = 128
	},
	bucaneer_modifier = {
		prefix = "bucaneer_modifier",
		to = 20,
		from = 1
	},
	bucaneer_hit = {
		prefix = "bucaneer_hit",
		to = 23,
		from = 1
	},
	bucaneer_travel = {
		prefix = "bucaneer_proy",
		to = 5,
		from = 1
	},
	bucaneer_idle = {
		prefix = "bucaneer",
		to = 1,
		from = 1
	},
	bucaneer_walk = {
		prefix = "bucaneer",
		to = 21,
		from = 2
	},
	bucaneer_walkDown = {
		prefix = "bucaneer",
		to = 41,
		from = 22
	},
	bucaneer_walkUp = {
		prefix = "bucaneer",
		to = 61,
		from = 42
	},
	bucaneer_attack = {
		prefix = "bucaneer",
		to = 88,
		from = 62
	},
	bucaneer_attackArea = {
		prefix = "bucaneer",
		to = 112,
		from = 89
	},
	bucaneer_death = {
		prefix = "bucaneer",
		to = 134,
		from = 113
	},
	boatswain_idle = {
		prefix = "boatswain",
		to = 1,
		from = 1
	},
	boatswain_walk = {
		prefix = "boatswain",
		to = 29,
		from = 2
	},
	boatswain_walkDown = {
		prefix = "boatswain",
		to = 57,
		from = 30
	},
	boatswain_walkUp = {
		prefix = "boatswain",
		to = 83,
		from = 58
	},
	boatswain_attack = {
		prefix = "boatswain",
		to = 110,
		from = 84
	},
	boatswain_death = {
		prefix = "boatswain",
		to = 133,
		from = 111
	},
	decal_one_boatswain = {
		prefix = "decal_one_boatswain",
		to = 12,
		from = 1
	},
	decal_two_boatswain = {
		prefix = "decal_two_boatswain",
		to = 32,
		from = 1
	},
	-- tower_paladin
	soldier_paladin_idle = {
		prefix = "paladin",
		to = 1,
		from = 1
	},
	soldier_paladin_walk = {
		prefix = "paladin",
		to = 24,
		from = 2
	},
	soldier_paladin_walkDown = {
		prefix = "paladin",
		to = 48,
		from = 25
	},
	soldier_paladin_walkUp = {
		prefix = "paladin",
		to = 72,
		from = 49
	},
	soldier_paladin_attack = {
		prefix = "paladin",
		to = 95,
		from = 73
	},
	soldier_paladin_attack2 = {
		prefix = "paladin",
		to = 119,
		from = 96
	},
	soldier_paladin_death = {
		prefix = "paladin",
		to = 217,
		from = 198
	},
	soldier_paladin_holystrike = {
		prefix = "paladin",
		to = 197,
		from = 162
	},
	soldier_paladin_healing = {
		prefix = "paladin",
		to = 161,
		from = 120
	},
	paladin_ground_attack_decal = {
		prefix = "paladin_ground_attack_decal",
		to = 18,
		from = 1
	},
	paladin_modifier_effect = {
		prefix = "paladin_modifier_effect",
		to = 20,
		from = 1
	},
	paladin_modifier_decal = {
		prefix = "paladin_modifier_decal",
		to = 20,
		from = 1
	},
	-- tower_barbarian
	soldier_barbarian_idle = {
		prefix = "northern_berserker",
		to = 1,
		from = 1
	},
	soldier_barbarian_walkingRightLeft = {
		prefix = "northern_berserker",
		to = 23,
		from = 2
	},
	soldier_barbarian_walkingDown = {
		prefix = "northern_berserker",
		to = 67,
		from = 46
	},
	soldier_barbarian_walkingUp = {
		prefix = "northern_berserker",
		to = 45,
		from = 24
	},
	soldier_barbarian_attack = {
		prefix = "northern_berserker",
		to = 133,
		from = 118
	},
	soldier_barbarian_shoot = {
		prefix = "northern_berserker",
		to = 150,
		from = 134
	},
	soldier_barbarian_twister = {
		to = 97,
		from = 68,
		prefix = "northern_berserker"
	},
	soldier_barbarian_death = {
		prefix = "northern_berserker",
		to = 117,
		from = 98
	},
	-- tower_wildling
	ogre_shipwreck_tower_lvl1_open = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		to = 18,
		from = 2
	},
	ogre_shipwreck_tower_lvl1_close = {
		prefix = "ogre_shipwreck_tower_lvl1_layer2",
		to = 34,
		from = 19
	},
	northern_wildling_idle = {
		prefix = "northern_wildling",
		to = 1,
		from = 1
	},
	northern_wildling_walkingRightLeft = {
		prefix = "northern_wildling",
		to = 23,
		from = 2
	},
	northern_wildling_walkingDown = {
		prefix = "northern_wildling",
		to = 67,
		from = 46
	},
	northern_wildling_walkingUp = {
		prefix = "northern_wildling",
		to = 45,
		from = 24
	},
	northern_wildling_attack = {
		prefix = "northern_wildling",
		to = 88,
		from = 68
	},
	northern_wildling_death = {
		prefix = "northern_wildling",
		to = 102,
		from = 89
	},
	-- kr4_elven_warrior
	kr4_elven_warrior_idle = {
		prefix = "kr4_elven_warrior",
		to = 18,
		from = 1
	},
	kr4_elven_warrior_walkingRightLeft = {
		prefix = "kr4_elven_warrior",
		to = 36,
		from = 19
	},
	kr4_elven_warrior_walkingUp = {
		prefix = "kr4_elven_warrior",
		to = 245,
		from = 224
	},
	kr4_elven_warrior_walkingDown = {
		prefix = "kr4_elven_warrior",
		to = 223,
		from = 202
	},
	kr4_elven_warrior_hit1 = {
		to = 117,
		from = 86,
		prefix = "kr4_elven_warrior"
	},
	kr4_elven_warrior_hit2 = {
		to = 149,
		from = 118,
		prefix = "kr4_elven_warrior"
	},
	kr4_elven_warrior_death = {
		prefix = "kr4_elven_warrior",
		to = 168,
		from = 150
	},
	kr4_elven_warrior_raise = {
		prefix = "kr4_elven_warrior",
		to = 201,
		from = 169
	},
	kr4_elven_warrior_shootPrep = {
		prefix = "kr4_elven_warrior",
		to = 55,
		from = 37
	},
	kr4_elven_warrior_multiShoot = {
		prefix = "kr4_elven_warrior",
		to = 73,
		from = 56
	},
	kr4_elven_warrior_shootEnd = {
		prefix = "kr4_elven_warrior",
		to = 85,
		from = 74
	},
	-- tower_assassin
	soldierassassin_idle = {
		prefix = "assasin",
		to = 1,
		from = 1
	},
	soldierassassin_walkingRightLeft = {
		prefix = "assasin",
		to = 107,
		from = 92
	},
	soldierassassin_walkingUp = {
		prefix = "assasin",
		to = 139,
		from = 124
	},
	soldierassassin_walkingDown = {
		prefix = "assasin",
		to = 123,
		from = 108
	},
	soldierassassin_attack = {
		to = 29,
		from = 2,
		prefix = "assasin",
		post = {
			1
		}
	},
	soldierassassin_death = {
		prefix = "assasin",
		to = 91,
		from = 77
	},
	soldierassassin_sneak = {
		prefix = "assasin",
		to = 61,
		from = 30
	},
	soldierassassin_dodge = {
		prefix = "assasin",
		to = 76,
		from = 62
	},
	soldierassassin_counter = {
		prefix = "assasin",
		to = 180,
		from = 140
	},
	-- chompbot
	chompbot_idle = {
		prefix = "chompbot",
		to = 1,
		from = 1
	},
	chompbot_walkingRightLeft = {
		prefix = "chompbot",
		to = 21,
		from = 2
	},
	chompbot_walkingUp = {
		prefix = "chompbot",
		to = 43,
		from = 22
	},
	chompbot_walkingDown = {
		prefix = "chompbot",
		to = 65,
		from = 44
	},
	chompbot_attack = {
		to = 85,
		from = 66,
		prefix = "chompbot",
		post = {
			1
		}
	},
	chompbot_death = {
		prefix = "chompbot",
		to = 142,
		from = 86
	},
	chompbot_raise = {
		prefix = "chompbot",
		to = 173,
		from = 143
	},
	smokebeard_engineer_ray = {
		prefix = "smokebeard_engineer_ray",
		to = 10,
		from = 1
	},
	smokebeard_engineer_ray_hit = {
		prefix = "smokebeard_engineer_ray_hit",
		to = 14,
		from = 1
	},
	-- veznan_crystal
	veznan_crystal_layerX_ready = {
		layer_to = 11,
		from = 1,
		layer_prefix = "veznan_crystal_layer%i",
		to = 1,
		layer_from = 1,
	},
	veznan_crystal_layerX_cooldown = {
		layer_to = 11,
		from = 2,
		layer_prefix = "veznan_crystal_layer%i",
		to = 61,
		layer_from = 1,
	},
	veznan_crystal_layerX_shoot = {
		layer_to = 11,
		from = 62,
		layer_prefix = "veznan_crystal_layer%i",
		to = 65,
		layer_from = 1,
	},
	veznan_crystal_ray_in = {
		prefix = "veznan_crystal_ray",
		to = 3,
		from = 1
	},
	veznan_crystal_ray_travel = {
		prefix = "veznan_crystal_ray",
		to = 10,
		from = 4
	},
	veznan_crystal_ray_out = {
		prefix = "veznan_crystal_ray",
		to = 19,
		from = 11
	},
	veznan_crystal_hit_start_run = {
		prefix = "veznan_crystal_hit_start",
		to = 8,
		from = 1
	},
	veznan_crystal_hit_end_run = {
		prefix = "veznan_crystal_hit_end",
		to = 8,
		from = 1
	},

}
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/kr4_towers_and_soldiers.lua

-- BEGIN kr3/data/animations/krdove_enemy_shaman_gravity.lua
do
	local __chunk = (function()
local a = {
    krdove_enemy_shaman_gravity_idle = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 1,
        from = 1
    },
    krdove_enemy_shaman_gravity_walkingRightLeft = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 105,
        from = 81
    },
    krdove_enemy_shaman_gravity_walkingDown = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 80,
        from = 56
    },
    krdove_enemy_shaman_gravity_walkingUp = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 46,
        from = 22
    },
    krdove_enemy_shaman_gravity_attack = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 21,
        from = 1
    },
    krdove_enemy_shaman_gravity_death = {
        prefix = "krdove_enemy_shaman_gravity",
        to = 55,
        from = 47
    }
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/krdove_enemy_shaman_gravity.lua

-- BEGIN kr3/data/animations/mad_tinkerer.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/mad_tinkerer.lua

local a = {
	mad_tinkerer_idle = {
		prefix = "mad_tinkerer_creep",
		to = 1,
		from = 1
	},
	mad_tinkerer_walk = {
		prefix = "mad_tinkerer_creep",
		to = 21,
		from = 2
	},
	mad_tinkerer_walk_front = {
		prefix = "mad_tinkerer_creep",
		to = 41,
		from = 22
	},
	mad_tinkerer_walk_back = {
		prefix = "mad_tinkerer_creep",
		to = 61,
		from = 42
	},
	mad_tinkerer_attack = {
		prefix = "mad_tinkerer_creep",
		to = 93,
		from = 62
	},
	mad_tinkerer_skill_start = {
		prefix = "mad_tinkerer_creep",
		to = 102,
		from = 94
	},
	mad_tinkerer_skill_loop = {
		prefix = "mad_tinkerer_creep",
		to = 113,
		from = 103
	},
	mad_tinkerer_skill_grab_metal = {
		prefix = "mad_tinkerer_creep",
		to = 171,
		from = 121
	},
	mad_tinkerer_death = {
		prefix = "mad_tinkerer_creep",
		to = 211,
		from = 172
	},
	mad_tinkerer_hit = {
		prefix = "mad_tinkerer_hit",
		to = 6,
		from = 1
	},
	scrap_drone_creep_idle = {
		prefix = "scrap_drone_creep",
		to = 12,
		from = 1
	},
	scrap_drone_creep_walk = {
		prefix = "scrap_drone_creep",
		to = 25,
		from = 13
	},
	scrap_drone_creep_walk_front = {
		prefix = "scrap_drone_creep",
		to = 38,
		from = 26
	},
	scrap_drone_creep_walk_back = {
		prefix = "scrap_drone_creep",
		to = 51,
		from = 39
	},
	scrap_drone_creep_spawn = {
		prefix = "scrap_drone_creep",
		to = 77,
		from = 52
	},
	scrap_drone_creep_death = {
		prefix = "scrap_drone_creep",
		to = 96,
		from = 78
	},
	mad_tinkerer_skill_ray_idle = {
		prefix = "mad_tinkerer_skill_ray",
		to = 25,
		from = 1
	},
	scrap_drone_creep_raise = {
		prefix = "scrap_drone_creep",
		to = 77,
		from = 52
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/mad_tinkerer.lua

-- BEGIN kr3/data/animations/mindless_husk.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/mindless_husk.lua

local a = {
	mindless_husk_creep_idle = {
		prefix = "mindless_husk_creep",
		to = 1,
		from = 1
	},
	mindless_husk_creep_walk = {
		prefix = "mindless_husk_creep",
		to = 23,
		from = 2
	},
	mindless_husk_creep_walk_front = {
		prefix = "mindless_husk_creep",
		to = 45,
		from = 24
	},
	mindless_husk_creep_walk_back = {
		prefix = "mindless_husk_creep",
		to = 67,
		from = 46
	},
	mindless_husk_creep_attack = {
		prefix = "mindless_husk_creep",
		to = 95,
		from = 68
	},
	mindless_husk_creep_death = {
		prefix = "mindless_husk_creep",
		to = 129,
		from = 96
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/mindless_husk.lua

-- BEGIN kr3/data/animations/nine_tailed_fox.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/nine_tailed_fox.lua

local a = {
	ninetailedfox_summon = {
		prefix = "ninetailedfox_summon",
		to = 66,
		from = 1
	},
	ninetailedfox_teleport_smoke_particle_run = {
		prefix = "ninetailedfox_teleport_smoke_particle",
		to = 24,
		from = 1
	},
	ninetailedfox_hit_hit = {
		prefix = "ninetailedfox_hit",
		to = 5,
		from = 1
	},
	ninetailedfox_stun_run = {
		prefix = "ninetailedfox_stun",
		to = 47,
		from = 1
	},
	ninetailedfox_creep_idle = {
		prefix = "ninetailedfox_creep",
		to = 30,
		from = 1
	},
	ninetailedfox_creep_walk = {
		prefix = "ninetailedfox_creep",
		to = 58,
		from = 31
	},
	ninetailedfox_creep_walk_down = {
		prefix = "ninetailedfox_creep",
		to = 86,
		from = 59
	},
	ninetailedfox_creep_walk_up = {
		prefix = "ninetailedfox_creep",
		to = 114,
		from = 87
	},
	ninetailedfox_creep_attack_1 = {
		prefix = "ninetailedfox_creep",
		to = 134,
		from = 115
	},
	ninetailedfox_creep_attack_2 = {
		prefix = "ninetailedfox_creep",
		to = 162,
		from = 135
	},
	ninetailedfox_creep_stun = {
		prefix = "ninetailedfox_creep",
		to = 190,
		from = 163
	},
	ninetailedfox_creep_tp_in = {
		prefix = "ninetailedfox_creep",
		to = 239,
		from = 191
	},
	ninetailedfox_creep_tp_out = {
		prefix = "ninetailedfox_creep",
		to = 285,
		from = 240
	},
	ninetailedfox_creep_death = {
		prefix = "ninetailedfox_creep",
		to = 349,
		from = 286
	},
	ninetailedfox_creep_summon = {
		prefix = "ninetailedfox_creep",
		to = 379,
		from = 350
	},
	ninetailedfox_stun_decal_run = {
		prefix = "ninetailedfox_stun_decal",
		to = 60,
		from = 1
	},
	ninetailedfox_stunearea_explosion1_run = {
		prefix = "ninetailedfox_stunearea_explosion_01",
		to = 22,
		from = 1
	},
	ninetailedfox_stunearea_explosion2_run = {
		prefix = "ninetailedfox_stunearea_explosion02",
		to = 19,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/nine_tailed_fox.lua

-- BEGIN kr3/data/animations/noxious_horror.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/noxious_horror.lua

local a = {
	noxious_horror_glare_aura_on = {
		prefix = "noxious_horror_glare_aura",
		to = 24,
		from = 1
	},
	noxious_horror_hit_fx_idle = {
		prefix = "noxious_horror_hit_fx",
		to = 6,
		from = 1
	},
	noxious_horror_projectile_vfx_idle = {
		prefix = "noxious_horror_projectile_vfx",
		to = 8,
		from = 1
	},
	noxious_horror_ranged_attack_hit_idle = {
		prefix = "noxious_horror_ranged_attack_hit",
		to = 11,
		from = 1
	},
	noxious_horror_ranged_attack_modifier_idle = {
		prefix = "noxious_horror_ranged_attack_modifier",
		to = 24,
		from = 1
	},
	noxious_horror_projectile_idle = {
		prefix = "noxious_horror_projectile",
		to = 8,
		from = 1
	},
	noxious_horror_projectile_splash = {
		prefix = "noxious_horror_projectile_splash",
		to = 21,
		from = 1
	},
	noxious_horror_projectile_splash_flying = {
		prefix = "noxious_horror_projectile_splash_flying",
		to = 17,
		from = 1
	},
	noxious_horror_creep_idle = {
		prefix = "noxious_horror_creep",
		to = 1,
		from = 1
	},
	noxious_horror_creep_walk = {
		prefix = "noxious_horror_creep",
		to = 17,
		from = 2
	},
	noxious_horror_creep_walk_front = {
		prefix = "noxious_horror_creep",
		to = 33,
		from = 18
	},
	noxious_horror_creep_walk_back = {
		prefix = "noxious_horror_creep",
		to = 49,
		from = 34
	},
	noxious_horror_creep_attack_melee = {
		prefix = "noxious_horror_creep",
		to = 84,
		from = 50
	},
	noxious_horror_creep_attack_range = {
		prefix = "noxious_horror_creep",
		to = 115,
		from = 85
	},
	noxious_horror_creep_death = {
		prefix = "noxious_horror_creep",
		to = 146,
		from = 116
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/noxious_horror.lua

-- BEGIN kr3/data/animations/palace_guard.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/palace_guard.lua

local a = {
	palace_guard_idle = {
		prefix = "palace_guard_creep",
		to = 1,
		from = 1
	},
	palace_guard_walk = {
		prefix = "palace_guard_creep",
		to = 21,
		from = 2
	},
	palace_guard_walkdown = {
		prefix = "palace_guard_creep",
		to = 41,
		from = 22
	},
	palace_guard_walkup = {
		prefix = "palace_guard_creep",
		to = 61,
		from = 42
	},
	palace_guard_attack_01 = {
		prefix = "palace_guard_creep",
		to = 91,
		from = 62
	},
	palace_guard_attack_02 = {
		prefix = "palace_guard_creep",
		to = 125,
		from = 92
	},
	palace_guard_death = {
		prefix = "palace_guard_creep",
		to = 181,
		from = 126
	},
	palace_guard_raise = {
		prefix = "palace_guard_creep",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/palace_guard.lua

-- BEGIN kr3/data/animations/paladin_soldiers_lvl4.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/paladin_soldiers_lvl4.lua

local a = {
	paladin_soldier_lvl4_idle = {
		prefix = "paladin_soldiers_lvl4",
		to = 1,
		from = 1
	},
	paladin_soldier_lvl4_idle2 = {
		prefix = "paladin_soldiers_lvl4",
		to = 2,
		from = 2
	},
	paladin_soldier_lvl4_walk = {
		prefix = "paladin_soldiers_lvl4",
		to = 23,
		from = 3
	},
	paladin_soldier_lvl4_attack01 = {
		prefix = "paladin_soldiers_lvl4",
		to = 42,
		from = 24
	},
	paladin_soldier_lvl4_attack02 = {
		prefix = "paladin_soldiers_lvl4",
		to = 60,
		from = 43
	},
	paladin_soldier_lvl4_healing_start = {
		prefix = "paladin_soldiers_lvl4",
		to = 87,
		from = 61
	},
	paladin_soldier_lvl4_healing_loop = {
		prefix = "paladin_soldiers_lvl4",
		to = 88,
		from = 88
	},
	paladin_soldier_lvl4_healing_end = {
		prefix = "paladin_soldiers_lvl4",
		to = 100,
		from = 89
	},
	paladin_soldier_lvl4_death = {
		prefix = "paladin_soldiers_lvl4",
		to = 119,
		from = 101
	},
	paladin_soldiers_lvl4_healing_plusSymbol = {
		prefix = "paladin_soldier_lvl4_healing_plusSymbol",
		to = 30,
		from = 1
	}
}

local o = {}

o.animations = a

return o
--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/paladin_soldiers_lvl4.lua

-- BEGIN kr3/data/animations/qiongqi.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/qiongqi.lua

local a = {
	qiongqi_fx_fly = {
		prefix = "qiongqi_fx_fly",
		to = 30,
		from = 1
	},
	qiongqi_attack = {
		prefix = "qiongqi_attack",
		to = 10,
		from = 1
	},
	qiongqi_fx_death_in = {
		prefix = "qiongqi_fx_death",
		to = 46,
		from = 1
	},
	qiongqi_creep_idle = {
		prefix = "qiongqi_creep",
		to = 30,
		from = 1
	},
	qiongqi_creep_walk = {
		prefix = "qiongqi_creep",
		to = 60,
		from = 31
	},
	qiongqi_creep_walk_front = {
		prefix = "qiongqi_creep",
		to = 90,
		from = 61
	},
	qiongqi_creep_walk_down = {
		prefix = "qiongqi_creep",
		to = 120,
		from = 91
	},
	qiongqi_creep_attack = {
		prefix = "qiongqi_creep",
		to = 161,
		from = 121
	},
	qiongqi_creep_death = {
		prefix = "qiongqi_creep",
		to = 206,
		from = 162
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/qiongqi.lua

-- BEGIN kr3/data/animations/revenant_harvester.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/revenant_harvester.lua

local a = {
	harvester_harvester_idle = {
		prefix = "harvester_harvester",
		to = 24,
		from = 1
	},
	harvester_harvester_walkingRightLeft = {
		prefix = "harvester_harvester",
		to = 48,
		from = 25
	},
	harvester_harvester_walkingUp = {
		prefix = "harvester_harvester",
		to = 72,
		from = 49
	},
	harvester_harvester_walkingDown = {
		prefix = "harvester_harvester",
		to = 96,
		from = 73
	},
	harvester_harvester_attack = {
		prefix = "harvester_harvester",
		to = 128,
		from = 97
	},
	harvester_harvester_cloning = {
		prefix = "harvester_harvester",
		to = 170,
		from = 129
	},
	harvester_harvester_death = {
		prefix = "harvester_harvester",
		to = 204,
		from = 171
	},
	harvester_harvester_spawn = {
		prefix = "harvester_harvester",
		to = 238,
		from = 205
	},
	harvester_hit_fx_idle = {
		prefix = "harvester_hit_fx",
		to = 6,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/revenant_harvester.lua

-- BEGIN kr3/data/animations/revenant_soulcaller.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/revenant_soulcaller.lua

local a = {
	revenant_soulcaller_unit_idle = {
		prefix = "revenant_soulcaller_unit",
		to = 20,
		from = 1
	},
	revenant_soulcaller_unit_summon = {
		prefix = "revenant_soulcaller_unit",
		to = 70,
		from = 21
	},
	revenant_soulcaller_unit_melee = {
		prefix = "revenant_soulcaller_unit",
		to = 107,
		from = 71
	},
	revenant_soulcaller_unit_stun = {
		prefix = "revenant_soulcaller_unit",
		to = 152,
		from = 108
	},
	revenant_soulcaller_unit_death = {
		prefix = "revenant_soulcaller_unit",
		to = 222,
		from = 153
	},
	revenant_soulcaller_unit_walk = {
		prefix = "revenant_soulcaller_unit",
		to = 246,
		from = 223
	},
	revenant_soulcaller_unit_walk_down = {
		prefix = "revenant_soulcaller_unit",
		to = 270,
		from = 247
	},
	revenant_soulcaller_unit_walk_up = {
		prefix = "revenant_soulcaller_unit",
		to = 294,
		from = 271
	},
	revenant_soulcaller_proy_copy_trail = {
		prefix = "revenant_soulcaller_proy_copy",
		to = 6,
		from = 1
	},
	revenant_soulcaller_transform_idle = {
		prefix = "revenant_soulcaller_transform",
		to = 15,
		from = 1
	},
	revenant_soulcaller_stuntower_in = {
		prefix = "revenant_soulcaller_stuntower",
		to = 23,
		from = 1
	},
	revenant_soulcaller_stuntower_idle = {
		prefix = "revenant_soulcaller_stuntower",
		to = 24,
		from = 24
	},
	revenant_soulcaller_stuntower_out = {
		prefix = "revenant_soulcaller_stuntower",
		to = 55,
		from = 25
	},
	revenant_soulcaller_proy_loop = {
		prefix = "revenant_soulcaller_proy",
		to = 20,
		from = 1
	},
	revenant_soulcaller_proy_hit = {
		prefix = "revenant_soulcaller_proy",
		to = 38,
		from = 21
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/revenant_soulcaller.lua

-- BEGIN kr3/data/animations/rhino.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/rhino.lua

local a = {
	razing_rhino_razing_rhino_charge_hit_fx = {
		prefix = "razing_rhino_razing_rhino_charge_hit_fx",
		to = 7,
		from = 1
	},
	razing_rhino_razing_rhino_charge_dust_a = {
		prefix = "razing_rhino_razing_rhino_charge_dust_a",
		to = 14,
		from = 1
	},
	razing_rhino_razing_rhino_charge_dust_b = {
		prefix = "razing_rhino_razing_rhino_charge_dust_b",
		to = 44,
		from = 1
	},
	razing_rhino_razing_rhino_hit_fx_Idle1_1 = {
		prefix = "razing_rhino_razing_rhino_hit_fx",
		to = 6,
		from = 1
	},
	razing_rhino_razign_rhino_instakill_fx = {
		prefix = "razing_rhino_razign_rhino_instakill_fx",
		to = 11,
		from = 1
	},
	razing_rhino_razing_rhino_idle = {
		prefix = "razing_rhino_razing_rhino",
		to = 1,
		from = 1
	},
	razing_rhino_razing_rhino_walkingRightLeft = {
		prefix = "razing_rhino_razing_rhino",
		to = 33,
		from = 2
	},
	razing_rhino_razing_rhino_walkingDown = {
		prefix = "razing_rhino_razing_rhino",
		to = 65,
		from = 34
	},
	razing_rhino_razing_rhino_walkingUp = {
		prefix = "razing_rhino_razing_rhino",
		to = 97,
		from = 66
	},
	razing_rhino_razing_rhino_attack = {
		prefix = "razing_rhino_razing_rhino",
		to = 145,
		from = 98
	},
	razing_rhino_razing_rhino_death = {
		prefix = "razing_rhino_razing_rhino",
		to = 191,
		from = 146
	},
	razing_rhino_razing_rhino_charge_side = {
		prefix = "razing_rhino_razing_rhino",
		to = 201,
		from = 192
	},
	razing_rhino_razing_rhino_charge_front = {
		prefix = "razing_rhino_razing_rhino",
		to = 221,
		from = 202
	},
	razing_rhino_razing_rhino_charge_back = {
		prefix = "razing_rhino_razing_rhino",
		to = 241,
		from = 222
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/rhino.lua

-- BEGIN kr3/data/animations/rolling_sentry.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/rolling_sentry.lua

a = {
	rolling_sentry_creep_idle = {
		prefix = "rolling_sentry_creep",
		to = 1,
		from = 1
	},
	rolling_sentry_creep_walk_in = {
		prefix = "rolling_sentry_creep",
		to = 19,
		from = 2
	},
	rolling_sentry_creep_walk_loop = {
		prefix = "rolling_sentry_creep",
		to = 35,
		from = 20
	},
	rolling_sentry_creep_walk_out = {
		prefix = "rolling_sentry_creep",
		to = 51,
		from = 36
	},
	rolling_sentry_creep_walk_loop_front = {
		prefix = "rolling_sentry_creep",
		to = 67,
		from = 52
	},
	rolling_sentry_creep_walk_loop_back = {
		prefix = "rolling_sentry_creep",
		to = 83,
		from = 68
	},
	rolling_sentry_creep_attack_loop_side = {
		prefix = "rolling_sentry_creep",
		to = 95,
		from = 84
	},
	rolling_sentry_creep_attack_loop_front = {
		prefix = "rolling_sentry_creep",
		to = 107,
		from = 96
	},
	rolling_sentry_creep_attack_loop_back = {
		prefix = "rolling_sentry_creep",
		to = 119,
		from = 108
	},
	rolling_sentry_creep_death = {
		prefix = "rolling_sentry_creep",
		to = 147,
		from = 120
	},
	rolling_sentry_creep_spawn = {
		prefix = "rolling_sentry_creep",
		to = 153,
		from = 148
	},
	rolling_sentry_hit_fx_idle = {
		prefix = "rolling_sentry_hit_FX",
		to = 9,
		from = 1
	},
	rolling_sentry_creep_flying_idle = {
		prefix = "rolling_sentry_creep_flying",
		to = 12,
		from = 1
	},
	rolling_sentry_creep_flying_walk = {
		prefix = "rolling_sentry_creep_flying",
		to = 24,
		from = 13
	},
	rolling_sentry_creep_flying_walk_front = {
		prefix = "rolling_sentry_creep_flying",
		to = 36,
		from = 25
	},
	rolling_sentry_creep_flying_walk_back = {
		prefix = "rolling_sentry_creep_flying",
		to = 48,
		from = 37
	},
	rolling_sentry_creep_flying_death = {
		prefix = "rolling_sentry_creep_flying",
		to = 69,
		from = 49
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/rolling_sentry.lua

-- BEGIN kr3/data/animations/scrap.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/scrap.lua

local a = {
	scrap_pile_in = {
		prefix = "scrap_pile",
		to = 12,
		from = 1
	},
	scrap_pile_idle_loop = {
		prefix = "scrap_pile",
		to = 36,
		from = 13
	},
	scrap_pile_out = {
		prefix = "scrap_pile",
		to = 56,
		from = 37
	},
	scrap_pile_out_exit = {
		prefix = "scrap_pile",
		to = 65,
		from = 57
	},
	scrap_pile_death = {
		prefix = "scrap_pile",
		to = 77,
		from = 66
	},
	scrap_pile_grave = {
		prefix = "scrap_pile",
		to = 78,
		from = 78
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/scrap.lua

-- BEGIN kr3/data/animations/scrap_speedster.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/scrap_speedster.lua

local a = {
	scrap_speedster_trail = {
		prefix = "scrap_speedster_trail",
		to = 10,
		from = 1
	},
	scrap_speedster_creep_idle = {
		prefix = "scrap_speedster_creep",
		to = 12,
		from = 1
	},
	scrap_speedster_creep_walk = {
		prefix = "scrap_speedster_creep",
		to = 24,
		from = 13
	},
	scrap_speedster_creep_walk_front = {
		prefix = "scrap_speedster_creep",
		to = 36,
		from = 25
	},
	scrap_speedster_creep_walk_back = {
		prefix = "scrap_speedster_creep",
		to = 48,
		from = 37
	},
	scrap_speedster_creep_attack = {
		prefix = "scrap_speedster_creep",
		to = 78,
		from = 49
	},
	scrap_speedster_creep_death = {
		prefix = "scrap_speedster_creep",
		to = 109,
		from = 79
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/scrap_speedster.lua

-- BEGIN kr3/data/animations/small_stalker.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/small_stalker.lua

local a = {
	small_stalker_creep_idle = {
		prefix = "small_stalker_creep",
		to = 32,
		from = 1
	},
	small_stalker_creep_walk = {
		prefix = "small_stalker_creep",
		to = 64,
		from = 33
	},
	small_stalker_creep_walk_front = {
		prefix = "small_stalker_creep",
		to = 96,
		from = 65
	},
	small_stalker_creep_walk_back = {
		prefix = "small_stalker_creep",
		to = 128,
		from = 97
	},
	small_stalker_creep_teleport_in = {
		prefix = "small_stalker_creep",
		to = 143,
		from = 129
	},
	small_stalker_creep_teleport_out = {
		prefix = "small_stalker_creep",
		to = 162,
		from = 144
	},
	small_stalker_creep_death = {
		prefix = "small_stalker_creep",
		to = 175,
		from = 163
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/small_stalker.lua

-- BEGIN kr3/data/animations/specter.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/specter.lua

local a = {
	spectre_trail_idle = {
		prefix = "spectre_trail",
		to = 12,
		from = 1
	},
	spectre_fx_idle = {
		prefix = "spectre_fx",
		to = 6,
		from = 1
	},
	spectre_specter_idle = {
		prefix = "spectre_specter",
		to = 20,
		from = 1
	},
	spectre_specter_walk = {
		prefix = "spectre_specter",
		to = 40,
		from = 21
	},
	spectre_specter_walk_front = {
		prefix = "spectre_specter",
		to = 60,
		from = 41
	},
	spectre_specter_walk_back = {
		prefix = "spectre_specter",
		to = 80,
		from = 61
	},
	spectre_specter_walk_fast = {
		prefix = "spectre_specter",
		to = 94,
		from = 81
	},
	spectre_specter_crash = {
		prefix = "spectre_specter",
		to = 106,
		from = 95
	},
	spectre_specter_attack_1 = {
		prefix = "spectre_specter",
		to = 142,
		from = 107
	},
	spectre_specter_raise = {
		prefix = "spectre_specter",
		to = 176,
		from = 143
	},
	spectre_specter_death = {
		prefix = "spectre_specter",
		to = 192,
		from = 177
	},
	spectre_specter_approach_in = {
		prefix = "spectre_specter",
		to = 206,
		from = 193
	},
	spectre_specter_approach_idle = {
		prefix = "spectre_specter",
		to = 220,
		from = 207
	},
	spectre_specter_rush_explosion_rush_explosion = {
		prefix = "spectre_specter_rush_explosion",
		to = 15,
		from = 1
	},
	spectre_specter_rush_particle_rush_particle = {
		prefix = "spectre_specter_rush_particle",
		to = 29,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/specter.lua

-- BEGIN kr3/data/animations/spiderling.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/spiderling.lua

local a = {
	spider_idle = {
		prefix = "spider",
		to = 1,
		from = 1
	},
	spider_walkingRightLeft = {
		prefix = "spider",
		to = 10,
		from = 2
	},
	spider_walkingDown = {
		prefix = "spider",
		to = 19,
		from = 11
	},
	spider_walkingUp = {
		prefix = "spider",
		to = 28,
		from = 20
	},
	spider_cliff_walkingUp = {
		prefix = "spider",
		to = 37,
		from = 29
	},
	spider_cliff_walkingDown = {
		prefix = "spider",
		to = 46,
		from = 38
	},
	spider_attack = {
		prefix = "spider",
		to = 61,
		from = 47
	},
	spider_death = {
		prefix = "spider",
		to = 73,
		from = 62
	},
	spider_cliff_fall = {
		prefix = "spider",
		to = 38,
		from = 38
	},
	spider_cliff_death = {
		prefix = "spider",
		to = 73,
		from = 62
	},
	spider_cliff_idle = {
		prefix = "spider",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/spiderling.lua

-- BEGIN kr3/data/animations/stage10_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage10_decos.lua

local a = {
	stage10_obelisk_stunfx_volador = {
		prefix = "stage10_obelisk_stunfx_volador",
		to = 31,
		from = 1
	},
	stage10_obelisk_stunfx_normal = {
		prefix = "stage10_obelisk_stunfx_normal",
		to = 31,
		from = 1
	},
	stage10_obelisk_stunfx_big = {
		prefix = "stage10_obelisk_stunfx_big",
		to = 31,
		from = 1
	},
	stage10_obelisk_hit = {
		prefix = "stage10_obelisk_hit",
		to = 19,
		from = 1
	},
	stage10_obelisk_projectile = {
		prefix = "stage10_obelisk_projectile",
		to = 26,
		from = 1
	},
	stage10_obelisk_particle = {
		prefix = "stage10_obelisk_particle",
		to = 15,
		from = 1
	},
	stage10_obelisk_changestate_fx_change_in = {
		prefix = "stage10_obelisk_changestate_fx",
		to = 2,
		from = 1
	},
	stage10_obelisk_changestate_fx_change_loop = {
		prefix = "stage10_obelisk_changestate_fx",
		to = 54,
		from = 3
	},
	stage10_obelisk_changestate_fx_change_out = {
		prefix = "stage10_obelisk_changestate_fx",
		to = 56,
		from = 55
	},
	stage10_obelisk_priests_idle = {
		prefix = "stage10_obelisk_priests",
		to = 36,
		from = 1
	},
	stage10_obelisk_priests_change_in = {
		prefix = "stage10_obelisk_priests",
		to = 46,
		from = 37
	},
	stage10_obelisk_priests_change_loop = {
		prefix = "stage10_obelisk_priests",
		to = 78,
		from = 47
	},
	stage10_obelisk_priests_change_out = {
		prefix = "stage10_obelisk_priests",
		to = 92,
		from = 79
	},
	stage10_obelisk_priests_telegraph_in = {
		prefix = "stage10_obelisk_priests",
		to = 115,
		from = 93
	},
	stage10_obelisk_priests_telegraph_loop = {
		prefix = "stage10_obelisk_priests",
		to = 134,
		from = 117
	},
	stage10_obelisk_priests_telegraph_out = {
		prefix = "stage10_obelisk_priests",
		to = 140,
		from = 135
	},
	stage10_obelisk_priests_idle_off = {
		prefix = "stage10_obelisk_priests",
		to = 141,
		from = 141
	},
	stage10_obelisk_priests_back_online = {
		prefix = "stage10_obelisk_priests",
		to = 173,
		from = 142
	},
	stage10_obelisk_priests_sacrifice_in = {
		prefix = "stage10_obelisk_priests",
		to = 183,
		from = 174
	},
	stage10_obelisk_priests_sacrifice_loop = {
		prefix = "stage10_obelisk_priests",
		to = 218,
		from = 184
	},
	stage10_obelisk_priests_sacrifice_out = {
		prefix = "stage10_obelisk_priests",
		to = 244,
		from = 219
	},
	stage10_obelisk_priests_death = {
		prefix = "stage10_obelisk_priests",
		to = 272,
		from = 245
	},
	stage10_obelisk_base_cristalitos_idle = {
		prefix = "stage10_obelisk_base_cristalitos",
		to = 1,
		from = 1
	},
	stage10_obelisk_base_cristalitos_heal_in = {
		prefix = "stage10_obelisk_base_cristalitos",
		to = 10,
		from = 2
	},
	stage10_obelisk_base_cristalitos_heal_loop = {
		prefix = "stage10_obelisk_base_cristalitos",
		to = 34,
		from = 11
	},
	stage10_obelisk_base_cristalitos_heal_out = {
		prefix = "stage10_obelisk_base_cristalitos",
		to = 43,
		from = 35
	},
	stage10_obelisk_base = {
		prefix = "stage10_obelisk_base",
		to = 1,
		from = 1
	},
	stage10_obelisk_crystal_idle1 = {
		prefix = "stage10_obelisk_crystal",
		to = 1,
		from = 1
	},
	stage10_obelisk_crystal_idle2 = {
		prefix = "stage10_obelisk_crystal",
		to = 2,
		from = 2
	},
	stage10_obelisk_crystal_idle3 = {
		prefix = "stage10_obelisk_crystal",
		to = 3,
		from = 3
	},
	stage10_obelisk_crystal_change_in = {
		prefix = "stage10_obelisk_crystal",
		to = 5,
		from = 4
	},
	stage10_obelisk_crystal_change_loop = {
		prefix = "stage10_obelisk_crystal",
		to = 57,
		from = 6
	},
	stage10_obelisk_crystal_to_idle1 = {
		prefix = "stage10_obelisk_crystal",
		to = 72,
		from = 58
	},
	stage10_obelisk_crystal_to_idle2 = {
		prefix = "stage10_obelisk_crystal",
		to = 87,
		from = 73
	},
	stage10_obelisk_crystal_to_idle3 = {
		prefix = "stage10_obelisk_crystal",
		to = 102,
		from = 88
	},
	stage10_obelisk_crystal_to_idle4 = {
		prefix = "stage10_obelisk_crystal",
		to = 113,
		from = 103
	},
	stage10_obelisk_crystal_idle_off = {
		prefix = "stage10_obelisk_crystal",
		to = 114,
		from = 114
	},
	stage10_obelisk_crystal_back_online = {
		prefix = "stage10_obelisk_crystal",
		to = 143,
		from = 115
	},
	stage10_obelisk_crystal_sacrifice_in = {
		prefix = "stage10_obelisk_crystal",
		to = 153,
		from = 144
	},
	stage10_obelisk_crystal_sacrifice_loop = {
		prefix = "stage10_obelisk_crystal",
		to = 154,
		from = 154
	},
	stage10_obelisk_crystal_sacrifice_out = {
		prefix = "stage10_obelisk_crystal",
		to = 167,
		from = 155
	},
	stage10_obelisk_crystal_telegraph_1 = {
		prefix = "stage10_obelisk_crystal",
		to = 187,
		from = 168
	},
	stage10_obelisk_crystal_telegraph_2 = {
		prefix = "stage10_obelisk_crystal",
		to = 207,
		from = 188
	},
	stage10_obelisk_crystal_telegraph_3 = {
		prefix = "stage10_obelisk_crystal",
		to = 227,
		from = 208
	},
	stage10_obelisk_base_back = {
		prefix = "stage10_obelisk_base_back",
		to = 1,
		from = 1
	},
	stage10_obelisk_base_cristalitos_back_idle = {
		prefix = "stage10_obelisk_base_cristalitos_back",
		to = 1,
		from = 1
	},
	stage10_obelisk_base_cristalitos_back_heal_in = {
		prefix = "stage10_obelisk_base_cristalitos_back",
		to = 10,
		from = 2
	},
	stage10_obelisk_base_cristalitos_back_heal_loop = {
		prefix = "stage10_obelisk_base_cristalitos_back",
		to = 34,
		from = 11
	},
	stage10_obelisk_base_cristalitos_back_heal_out = {
		prefix = "stage10_obelisk_base_cristalitos_back",
		to = 43,
		from = 35
	},
	stage10_obelisk_teleport_fx_teleport_in = {
		prefix = "stage10_obelisk_teleport_fx",
		to = 12,
		from = 1
	},
	stage10_obelisk_teleport_fx_teleport_loop = {
		prefix = "stage10_obelisk_teleport_fx",
		to = 13,
		from = 13
	},
	stage10_obelisk_teleport_fx_teleport_out = {
		prefix = "stage10_obelisk_teleport_fx",
		to = 24,
		from = 14
	},
	ymca_spawn_fx_layer_4_idle = {
		prefix = "ymca_spawn_fx_layer_4",
		to = 28,
		from = 1
	},
	ymca_spawn_fx_layer_3_idle = {
		prefix = "ymca_spawn_fx_layer_3",
		to = 28,
		from = 1
	},
	ymca_statue_dust_idle = {
		prefix = "ymca_statue_dust",
		to = 18,
		from = 1
	},
	ymca_statue_y = {
		prefix = "ymca_statue",
		to = 1,
		from = 1
	},
	ymca_statue_y_light = {
		prefix = "ymca_statue",
		to = 2,
		from = 2
	},
	ymca_statue_m = {
		prefix = "ymca_statue",
		to = 3,
		from = 3
	},
	ymca_statue_m_light = {
		prefix = "ymca_statue",
		to = 4,
		from = 4
	},
	ymca_statue_c = {
		prefix = "ymca_statue",
		to = 5,
		from = 5
	},
	ymca_statue_c_light = {
		prefix = "ymca_statue",
		to = 6,
		from = 6
	},
	ymca_statue_a = {
		prefix = "ymca_statue",
		to = 7,
		from = 7
	},
	ymca_statue_a_light = {
		prefix = "ymca_statue",
		to = 8,
		from = 8
	},
	ymca_statue_dance_loop = {
		prefix = "ymca_statue",
		to = 116,
		from = 9
	},
	ymca_ymca_constructor_idle = {
		prefix = "ymca_ymca_constructor",
		to = 1,
		from = 1
	},
	ymca_ymca_constructor_walk = {
		prefix = "ymca_ymca_constructor",
		to = 21,
		from = 2
	},
	ymca_ymca_constructor_attack = {
		prefix = "ymca_ymca_constructor",
		to = 41,
		from = 22
	},
	ymca_ymca_indio_idle = {
		prefix = "ymca_ymca_indio",
		to = 1,
		from = 1
	},
	ymca_ymca_indio_walk = {
		prefix = "ymca_ymca_indio",
		to = 17,
		from = 2
	},
	ymca_ymca_indio_attack = {
		prefix = "ymca_ymca_indio",
		to = 39,
		from = 18
	},
	ymca_ymca_biker_idle = {
		prefix = "ymca_ymca_biker",
		to = 1,
		from = 1
	},
	ymca_ymca_biker_walk = {
		prefix = "ymca_ymca_biker",
		to = 17,
		from = 2
	},
	ymca_ymca_biker_attack = {
		prefix = "ymca_ymca_biker",
		to = 39,
		from = 18
	},
	ymca_ymca_policia_idle = {
		prefix = "ymca_ymca_policia",
		to = 1,
		from = 1
	},
	ymca_ymca_policia_walk = {
		prefix = "ymca_ymca_policia",
		to = 17,
		from = 2
	},
	ymca_ymca_policia_attack = {
		prefix = "ymca_ymca_policia",
		to = 39,
		from = 18
	},
	stage10_obelisk_projectile_flying = {
		prefix = "stage10_obelisk_projectile",
		to = 26,
		from = 1
	},
	stage10_obelisk_particle_Idle = {
		prefix = "stage10_obelisk_particle",
		to = 15,
		from = 1
	},
	stage10_obelisk_stunfx_normal_start = {
		prefix = "stage10_obelisk_stunfx_normal",
		to = 18,
		from = 1
	},
	stage10_obelisk_stunfx_normal_loop = {
		prefix = "stage10_obelisk_stunfx_normal",
		to = 19,
		from = 19
	},
	stage10_obelisk_stunfx_normal_end = {
		prefix = "stage10_obelisk_stunfx_normal",
		to = 31,
		from = 20
	},
	stage10_obelisk_stunfx_big_start = {
		prefix = "stage10_obelisk_stunfx_big",
		to = 18,
		from = 1
	},
	stage10_obelisk_stunfx_big_loop = {
		prefix = "stage10_obelisk_stunfx_big",
		to = 19,
		from = 19
	},
	stage10_obelisk_stunfx_big_end = {
		prefix = "stage10_obelisk_stunfx_big",
		to = 31,
		from = 20
	},
	stage10_obelisk_stunfx_volador_start = {
		prefix = "stage10_obelisk_stunfx_volador",
		to = 18,
		from = 1
	},
	stage10_obelisk_stunfx_volador_loop = {
		prefix = "stage10_obelisk_stunfx_volador",
		to = 19,
		from = 19
	},
	stage10_obelisk_stunfx_volador_end = {
		prefix = "stage10_obelisk_stunfx_volador",
		to = 31,
		from = 20
	},
	stage10_obelisk_crystal_turn_off = {
		prefix = "stage10_obelisk_crystal",
		frames = {
			143,
			142,
			141,
			140,
			139,
			138,
			137,
			136,
			135,
			134,
			133,
			132,
			131,
			130,
			129,
			128,
			127,
			126,
			125,
			124,
			123,
			122,
			121,
			120,
			119,
			118,
			117,
			116,
			115
		}
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage10_decos.lua

-- BEGIN kr3/data/animations/stage11_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage11_decos.lua

local a = {
	mydrias_areaskill_status_in = {
		prefix = "mydrias_areaskill_status",
		to = 16,
		from = 1
	},
	mydrias_areaskill_status_loop = {
		prefix = "mydrias_areaskill_status",
		to = 32,
		from = 17
	},
	mydrias_areaskill_status_out = {
		prefix = "mydrias_areaskill_status",
		to = 44,
		from = 33
	},
	mydrias_areaskill_spawn = {
		prefix = "mydrias_areaskill",
		to = 7,
		from = 1
	},
	mydrias_areaskill_loop = {
		prefix = "mydrias_areaskill",
		to = 28,
		from = 8
	},
	mydrias_areaskill_out = {
		prefix = "mydrias_areaskill",
		to = 35,
		from = 29
	},
	mydrias_areaskill_status_Denas_decal_in = {
		prefix = "mydrias_areaskill_status_Denas_decal",
		to = 16,
		from = 1
	},
	mydrias_areaskill_status_Denas_decal_loop = {
		prefix = "mydrias_areaskill_status_Denas_decal",
		to = 32,
		from = 17
	},
	mydrias_areaskill_status_Denas_decal_out = {
		prefix = "mydrias_areaskill_status_Denas_decal",
		to = 44,
		from = 33
	},
	mydrias_areaskill_status_Denas_in = {
		prefix = "mydrias_areaskill_status_Denas",
		to = 16,
		from = 1
	},
	mydrias_areaskill_status_Denas_loop = {
		prefix = "mydrias_areaskill_status_Denas",
		to = 32,
		from = 17
	},
	mydrias_areaskill_status_Denas_out = {
		prefix = "mydrias_areaskill_status_Denas",
		to = 44,
		from = 33
	},
	mydrias_stuntower_front_spawn = {
		prefix = "mydrias_stuntower_front",
		to = 8,
		from = 1
	},
	mydrias_stuntower_front_run2 = {
		prefix = "mydrias_stuntower_front",
		to = 31,
		from = 9
	},
	mydrias_stuntower_front_dissipate = {
		prefix = "mydrias_stuntower_front",
		to = 52,
		from = 32
	},
	mydrias_stuntower_back_spawn = {
		prefix = "mydrias_stuntower_back",
		to = 8,
		from = 1
	},
	mydrias_stuntower_back_run = {
		prefix = "mydrias_stuntower_back",
		to = 31,
		from = 9
	},
	mydrias_stuntower_back_dissipate = {
		prefix = "mydrias_stuntower_back",
		to = 47,
		from = 32
	},
	mydrias_proyectile_trail_run = {
		prefix = "mydrias_proyectile_trail",
		to = 10,
		from = 1
	},
	mydrias_proyectile_start = {
		prefix = "mydrias_proyectile",
		to = 6,
		from = 1
	},
	mydrias_proyectile_run = {
		prefix = "mydrias_proyectile",
		to = 16,
		from = 7
	},
	mydrias_proyectile_hit = {
		prefix = "mydrias_proyectile",
		to = 25,
		from = 17
	},
	mydrias_character_idle = {
		prefix = "mydrias_character",
		to = 8,
		from = 1
	},
	mydrias_character_attack = {
		prefix = "mydrias_character",
		to = 44,
		from = 9
	},
	mydrias_character_stunnedin = {
		prefix = "mydrias_character",
		to = 61,
		from = 45
	},
	mydrias_character_stunnedloop = {
		prefix = "mydrias_character",
		to = 76,
		from = 62
	},
	mydrias_character_stunnedout = {
		prefix = "mydrias_character",
		to = 87,
		from = 77
	},
	mydrias_clone_walk = {
		prefix = "mydrias_clone",
		to = 24,
		from = 1
	},
	mydrias_clone_walkdown = {
		prefix = "mydrias_clone",
		to = 48,
		from = 25
	},
	mydrias_clone_skill = {
		prefix = "mydrias_clone",
		to = 83,
		from = 49
	},
	mydrias_clone_skillloop = {
		prefix = "mydrias_clone",
		to = 128,
		from = 84
	},
	mydrias_clone_skillout = {
		prefix = "mydrias_clone",
		to = 137,
		from = 129
	},
	mydrias_clone_attack = {
		prefix = "mydrias_clone",
		to = 164,
		from = 138
	},
	mydrias_clone_rangedattack = {
		prefix = "mydrias_clone",
		to = 199,
		from = 165
	},
	mydrias_clone_death = {
		prefix = "mydrias_clone",
		to = 224,
		from = 200
	},
	mydrias_clone_spawn = {
		prefix = "mydrias_clone",
		to = 256,
		from = 225
	},
	mydrias_clone_idle = {
		prefix = "mydrias_clone",
		to = 280,
		from = 257
	},
	mydrias_summoncircle_summoncircle_start = {
		prefix = "mydrias_summoncircle",
		to = 1,
		from = 1
	},
	mydrias_summoncircle_summoncircle_summon = {
		prefix = "mydrias_summoncircle",
		to = 2,
		from = 2
	},
	mydrias_summoncircle_summoncircle_fadeout = {
		prefix = "mydrias_summoncircle",
		to = 3,
		from = 3
	},
	stage11_veznan_export_globito_idle = {
		prefix = "stage11_veznan_export_globito",
		to = 1,
		from = 1
	},
	stage11_veznan_export_veznan_idle = {
		prefix = "stage11_veznan_export_veznan",
		to = 1,
		from = 1
	},
	stage11_veznan_export_veznan_idle_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 1,
		from = 1
	},
	stage11_veznan_export_veznan_spawn = {
		prefix = "stage11_veznan_export_veznan",
		to = 13,
		from = 2
	},
	stage11_veznan_export_veznan_spawn_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 13,
		from = 2
	},
	stage11_veznan_export_veznan_talking_in = {
		prefix = "stage11_veznan_export_veznan",
		to = 25,
		from = 14
	},
	stage11_veznan_export_veznan_talking_in_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 25,
		from = 14
	},
	stage11_veznan_export_veznan_talking_loop = {
		prefix = "stage11_veznan_export_veznan",
		to = 39,
		from = 26
	},
	stage11_veznan_export_veznan_talking_loop_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 39,
		from = 26
	},
	stage11_veznan_export_veznan_talking_out = {
		prefix = "stage11_veznan_export_veznan",
		to = 49,
		from = 40
	},
	stage11_veznan_export_veznan_talking_out_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 49,
		from = 40
	},
	stage11_veznan_export_veznan_charging = {
		prefix = "stage11_veznan_export_veznan",
		to = 63,
		from = 50
	},
	stage11_veznan_export_veznan_charging_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 63,
		from = 50
	},
	stage11_veznan_export_veznan_READY_in = {
		prefix = "stage11_veznan_export_veznan",
		to = 70,
		from = 64
	},
	stage11_veznan_export_veznan_READY_in_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 70,
		from = 64
	},
	stage11_veznan_export_veznan_READY_loop = {
		prefix = "stage11_veznan_export_veznan",
		to = 84,
		from = 71
	},
	stage11_veznan_export_veznan_READY_loop_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 84,
		from = 71
	},
	stage11_veznan_export_veznan_skill1 = {
		prefix = "stage11_veznan_export_veznan",
		to = 108,
		from = 85
	},
	stage11_veznan_export_veznan_skill1_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 108,
		from = 85
	},
	stage11_veznan_export_veznan_Skill2_loop = {
		prefix = "stage11_veznan_export_veznan",
		to = 122,
		from = 109
	},
	stage11_veznan_export_veznan_Skill2_loop_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 122,
		from = 109
	},
	stage11_veznan_export_veznan_Skill2_out = {
		prefix = "stage11_veznan_export_veznan",
		to = 140,
		from = 123
	},
	stage11_veznan_export_veznan_Skill2_out_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 140,
		from = 123
	},
	stage11_veznan_export_veznan_skill3_loop = {
		prefix = "stage11_veznan_export_veznan",
		to = 154,
		from = 141
	},
	stage11_veznan_export_veznan_skill3_loop_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 154,
		from = 141
	},
	stage11_veznan_export_veznan_skill3_out = {
		prefix = "stage11_veznan_export_veznan",
		to = 174,
		from = 155
	},
	stage11_veznan_export_veznan_skill3_out_over = {
		prefix = "stage11_veznan_export_veznan",
		to = 174,
		from = 155
	},
	stage11_veznan_export_tierrita_spawn_start = {
		prefix = "stage11_veznan_export_tierrita_spawn",
		to = 10,
		from = 1
	},
	stage11_veznan_export_tierrita_spawn_loop = {
		prefix = "stage11_veznan_export_tierrita_spawn",
		to = 22,
		from = 11
	},
	stage11_veznan_export_tierrita_spawn_end = {
		prefix = "stage11_veznan_export_tierrita_spawn",
		to = 44,
		from = 23
	},
	stage11_veznan_export_rayo_spawn_start = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 4,
		from = 1
	},
	stage11_veznan_export_rayo_spawn_loop = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 21,
		from = 5
	},
	stage11_veznan_export_rayo_spawn_end = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 36,
		from = 22
	},
	stage11_veznan_export_veznan_electric_skill3_loop = {
		prefix = "stage11_veznan_export_veznan_electric",
		to = 14,
		from = 1
	},
	stage11_veznan_export_veznan_electric_skill3_out = {
		prefix = "stage11_veznan_export_veznan_electric",
		to = 30,
		from = 15
	},
	stage11_veznan_export_spawn_top_spawn = {
		prefix = "stage11_veznan_export_spawn_top",
		to = 26,
		from = 1
	},
	stage11_veznan_export_spawn_fire_idle = {
		prefix = "stage11_veznan_export_spawn_fire",
		to = 10,
		from = 1
	},
	stage11_veznan_export_spawn_decal_in = {
		prefix = "stage11_veznan_export_spawn_decal",
		to = 29,
		from = 1
	},
	stage11_veznan_export_spawn_decal_spawn = {
		prefix = "stage11_veznan_export_spawn_decal",
		to = 55,
		from = 30
	},
	stage11_veznan_export_spawn_decal_out = {
		prefix = "stage11_veznan_export_spawn_decal",
		to = 110,
		from = 56
	},
	stage11_veznan_export_cage_in = {
		prefix = "stage11_veznan_export_cage",
		to = 19,
		from = 1
	},
	stage11_veznan_export_cage_idle = {
		prefix = "stage11_veznan_export_cage",
		to = 60,
		from = 20
	},
	stage11_veznan_export_cage_out = {
		prefix = "stage11_veznan_export_cage",
		to = 85,
		from = 61
	},
	stage11_veznan_export_cage_piso_in = {
		prefix = "stage11_veznan_export_cage_piso",
		to = 19,
		from = 1
	},
	stage11_veznan_export_cage_piso_idle = {
		prefix = "stage11_veznan_export_cage_piso",
		to = 60,
		from = 20
	},
	stage11_veznan_export_cage_piso_out = {
		prefix = "stage11_veznan_export_cage_piso",
		to = 85,
		from = 61
	},
	stage11_veznan_export_skill1_decal_idle = {
		prefix = "stage11_veznan_export_skill1_decal",
		to = 1,
		from = 1
	},
	stage11_veznan_export_skill1_decal_out = {
		prefix = "stage11_veznan_export_skill1_decal",
		to = 15,
		from = 2
	},
	stage11_veznan_export_skill1_hit_piso = {
		prefix = "stage11_veznan_export_skill1_hit_piso",
		to = 25,
		from = 1
	},
	stage11_veznan_export_skill1_hit_idle = {
		prefix = "stage11_veznan_export_skill1_hit",
		to = 25,
		from = 1
	},
	stage11_veznan_export_proyectile_idle = {
		prefix = "stage11_veznan_export_proyectile",
		to = 18,
		from = 1
	},
	stage11_veznan_export_proyectile_spawn = {
		prefix = "stage11_veznan_export_proyectile",
		to = 27,
		from = 19
	},
	reinforcement_demon_guard_idle = {
		prefix = "reinforcement_demon_guard",
		to = 1,
		from = 1
	},
	reinforcement_demon_guard_walk = {
		prefix = "reinforcement_demon_guard",
		to = 17,
		from = 2
	},
	reinforcement_demon_guard_walk_down = {
		prefix = "reinforcement_demon_guard",
		to = 33,
		from = 18
	},
	reinforcement_demon_guard_walk_up = {
		prefix = "reinforcement_demon_guard",
		to = 49,
		from = 34
	},
	reinforcement_demon_guard_attack = {
		prefix = "reinforcement_demon_guard",
		to = 69,
		from = 50
	},
	reinforcement_demon_guard_death = {
		prefix = "reinforcement_demon_guard",
		to = 101,
		from = 70
	},
	reinforcement_demon_guard_infernalNovaDeath = {
		prefix = "reinforcement_demon_guard",
		to = 138,
		from = 102
	},
	reinforcement_demon_guard_spawn = {
		prefix = "reinforcement_demon_guard",
		to = 140,
		from = 139
	},
	denas_dustexplosion_run = {
		prefix = "denas_dustexplosion",
		to = 24,
		from = 1
	},
	denas_spikes2_run = {
		prefix = "denas_spikes2",
		to = 32,
		from = 1
	},
	denas_spikes1_run = {
		prefix = "denas_spikes1",
		to = 29,
		from = 1
	},
	denas_decal_attack = {
		prefix = "denas_decal",
		to = 1,
		from = 1
	},
	denas_character_attack = {
		prefix = "denas_character",
		to = 45,
		from = 1
	},
	denas_character_walk = {
		prefix = "denas_character",
		to = 82,
		from = 46
	},
	denas_character_cagein = {
		prefix = "denas_character",
		to = 88,
		from = 83
	},
	denas_character_cageloop = {
		prefix = "denas_character",
		to = 134,
		from = 89
	},
	denas_character_cageout = {
		prefix = "denas_character",
		to = 142,
		from = 135
	},
	denas_character_stunin = {
		prefix = "denas_character",
		to = 189,
		from = 143
	},
	denas_character_stunloop = {
		prefix = "denas_character",
		to = 201,
		from = 190
	},
	denas_character_stunout = {
		prefix = "denas_character",
		to = 231,
		from = 202
	},
	denas_character_walk_down = {
		prefix = "denas_character",
		to = 265,
		from = 232
	},
	denas_character_spawn_glareling = {
		prefix = "denas_character",
		to = 315,
		from = 266
	},
	denas_character_spawn = {
		prefix = "denas_character",
		to = 343,
		from = 316
	},
	stage11_veznan_export_proyectile_spawn = {
		prefix = "stage11_veznan_export_proyectile",
		to = 26,
		from = 19
	},
	stage11_veznan_export_veznan_electric_skill3_out = {
		prefix = "stage11_veznan_export_veznan_electric",
		to = 30,
		from = 15
	},
	mydrias_proyectile_trail_run = {
		prefix = "mydrias_proyectile_trail",
		to = 9,
		from = 1
	},
	mydrias_stuntower_front_run = {
		prefix = "mydrias_stuntower_front",
		to = 31,
		from = 9
	},
	mydrias_proyectile_flying = {
		prefix = "mydrias_proyectile",
		to = 9,
		from = 1
	},
	mydrias_clone_chain_start = {
		prefix = "mydrias_clone",
		to = 69,
		from = 49
	},
	mydrias_clone_chain_loop = {
		prefix = "mydrias_clone",
		to = 78,
		from = 70
	},
	mydrias_clone_chain_end = {
		prefix = "mydrias_clone",
		to = 87,
		from = 79
	},
	denas_character_idle = {
		prefix = "denas_character",
		to = 1,
		from = 1
	},
	deco_veznan_statue_torch_idle = {
		prefix = "deco_veznan_statue_torch",
		to = 12,
		from = 1
	},
	deco_veznan_statue_statue = {
		prefix = "deco_veznan_statue_statue",
		to = 1,
		from = 1
	},
	stage11_veznan_export_rayo_spawn_in = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 8,
		from = 1
	},
	stage11_veznan_export_rayo_spawn_loop = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 31,
		from = 9
	},
	stage11_veznan_export_rayo_spawn_out = {
		prefix = "stage11_veznan_export_rayo_spawn",
		to = 59,
		from = 32
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage11_decos.lua

-- BEGIN kr3/data/animations/stage15_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage15_decos.lua

local a = {
	denas_decal_Idle = {
		prefix = "denas_decal",
		to = 18,
		from = 1
	},
	denas_hit_fx_Idle = {
		prefix = "denas_hit_fx",
		to = 7,
		from = 1
	},
	denas_floor_fx_idle = {
		prefix = "denas_floor_fx",
		to = 11,
		from = 1
	},
	denas_explosion_fx_idle = {
		prefix = "denas_explosion_fx",
		to = 17,
		from = 1
	},
	denas_hero_spawn = {
		prefix = "denas_hero",
		to = 39,
		from = 1
	},
	denas_hero_idle_a = {
		prefix = "denas_hero",
		to = 65,
		from = 40
	},
	denas_hero_sword_out = {
		prefix = "denas_hero",
		to = 79,
		from = 66
	},
	denas_hero_sword_in = {
		prefix = "denas_hero",
		to = 97,
		from = 80
	},
	denas_hero_sword_out_walk = {
		prefix = "denas_hero",
		to = 107,
		from = 98
	},
	denas_hero_walk = {
		prefix = "denas_hero",
		to = 127,
		from = 108
	},
	denas_hero_idle_b = {
		prefix = "denas_hero",
		to = 128,
		from = 128
	},
	denas_hero_attack_a = {
		prefix = "denas_hero",
		to = 150,
		from = 129
	},
	denas_hero_attack_a_to_idle = {
		prefix = "denas_hero",
		to = 154,
		from = 151
	},
	denas_hero_attack_b = {
		prefix = "denas_hero",
		to = 180,
		from = 155
	},
	denas_hero_attack_c = {
		prefix = "denas_hero",
		to = 222,
		from = 181
	},
	denas_hero_out = {
		prefix = "denas_hero",
		to = 256,
		from = 223
	},
	mutamydrias_fx_Mutamydrias_balcon = {
		prefix = "mutamydrias_fx_Mutamydrias_balcon",
		to = 1,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_spawn = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 8,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_run2 = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 31,
		from = 9
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_dissipate = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 52,
		from = 32
	},
	mutamydrias_fx_Mutamydrias_Tentacle_spawn = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 8,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentacle_run2 = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 31,
		from = 9
	},
	mutamydrias_fx_Mutamydrias_Tentacle_dissipate = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 52,
		from = 32
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_start = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 1,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_stun = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 2,
		from = 2
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_decalfade = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 3,
		from = 3
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_Tentacles_run = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle_Tentacles",
		to = 20,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_decal_decal = {
		prefix = "mutamydrias_fx_Mutamydrias_decal",
		to = 1,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_spawn = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 8,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_run = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 40,
		from = 9
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_idle = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 42,
		from = 41
	},
	mutamydrias_fx_Mutamydrias_Tentaclebig_dissipate = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 51,
		from = 43
	},
	mutamydrias_fx_Mutamydrias_Tentacle_spawn = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 8,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentacle_run = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 40,
		from = 9
	},
	mutamydrias_fx_Mutamydrias_Tentacle_idle = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 42,
		from = 41
	},
	mutamydrias_fx_Mutamydrias_Tentacle_dissipate = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentacle",
		to = 51,
		from = 43
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_Eye_start = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle_Eye",
		to = 1,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_Eye_stun = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle_Eye",
		to = 2,
		from = 2
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_Eye_decalfade = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle_Eye",
		to = 3,
		from = 3
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_start = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 1,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_stun = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 2,
		from = 2
	},
	mutamydrias_fx_Mutamydrias_Stuncircle_decalfade = {
		prefix = "mutamydrias_fx_Mutamydrias_Stuncircle",
		to = 3,
		from = 3
	},
	mutamydrias_fx_Mutamydrias_Tentacle_small_start = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 40,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentacle_small_loop = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 42,
		from = 41
	},
	mutamydrias_fx_Mutamydrias_Tentacle_small_end = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 51,
		from = 43
	},
	mutamydrias_fx_Mutamydrias_Tentacle_big_start = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 40,
		from = 1
	},
	mutamydrias_fx_Mutamydrias_Tentacle_big_loop = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 42,
		from = 41
	},
	mutamydrias_fx_Mutamydrias_Tentacle_big_end = {
		prefix = "mutamydrias_fx_Mutamydrias_Tentaclebig",
		to = 51,
		from = 43
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage15_decos.lua

-- BEGIN kr3/data/animations/stage16_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage16_decos.lua

local a = {
	overseer_fx_overseer_proyectile_proyectile = {
		prefix = "overseer_fx_overseer_proyectile",
		to = 1,
		from = 1
	},
	overseer_fx_overseer_proyectile_explosion_run = {
		prefix = "overseer_fx_overseer_proyectile_explosion",
		to = 18,
		from = 1
	},
	overseer_fx_overseer_teleportfx_run = {
		prefix = "overseer_fx_overseer_teleportfx",
		to = 20,
		from = 3
	},
	overseer_fx_overseer_teleportfx_out_run = {
		prefix = "overseer_fx_overseer_teleportfx_out",
		to = 20,
		from = 3
	},
	overseer_fx_overseer_teleportdecal_decalin = {
		prefix = "overseer_fx_overseer_teleportdecal",
		to = 1,
		from = 1
	},
	overseer_fx_overseer_teleportdecal_decalactivate = {
		prefix = "overseer_fx_overseer_teleportdecal",
		to = 2,
		from = 2
	},
	overseer_fx_overseer_teleportdecal_decalfade = {
		prefix = "overseer_fx_overseer_teleportdecal",
		to = 3,
		from = 3
	},
	overseer_fx_overseer_tentaclesfront_spawn = {
		prefix = "overseer_fx_overseer_tentaclesfront",
		to = 10,
		from = 1
	},
	overseer_fx_overseer_tentaclesfront_run = {
		prefix = "overseer_fx_overseer_tentaclesfront",
		to = 33,
		from = 11
	},
	overseer_fx_overseer_tentaclesfront_dissipate = {
		prefix = "overseer_fx_overseer_tentaclesfront",
		to = 62,
		from = 34
	},
	overseer_fx_overseer_tentaclesfront_destroytower = {
		prefix = "overseer_fx_overseer_tentaclesfront",
		to = 116,
		from = 63
	},
	overseer_fx_overseer_tentaclesback_spawn = {
		prefix = "overseer_fx_overseer_tentaclesback",
		to = 10,
		from = 1
	},
	overseer_fx_overseer_tentaclesback_run = {
		prefix = "overseer_fx_overseer_tentaclesback",
		to = 31,
		from = 11
	},
	overseer_fx_overseer_tentaclesback_dissipate = {
		prefix = "overseer_fx_overseer_tentaclesback",
		to = 63,
		from = 32
	},
	overseer_fx_overseer_tentaclesback_destroytower = {
		prefix = "overseer_fx_overseer_tentaclesback",
		to = 116,
		from = 64
	},
	overseer_fx_overseer_blood = {
		prefix = "overseer_fx_overseer_blood",
		to = 16,
		from = 1
	},
	overseer_fx_overseer_crater_run = {
		prefix = "overseer_fx_overseer_crater",
		to = 54,
		from = 1
	},
	overseer_fx_overseer_proyectile_trail_run = {
		prefix = "overseer_fx_overseer_proyectile_trail",
		to = 10,
		from = 1
	},
	overseer_fx_overseer_destroyray_bright_run = {
		prefix = "overseer_fx_overseer_destroyray_bright",
		to = 12,
		from = 1
	},
	overseer_fx_overseer_crater_run = {
		prefix = "overseer_fx_overseer_crater",
		to = 32,
		from = 1
	},
	overseer_fx_overseer_crater_idle = {
		prefix = "overseer_fx_overseer_crater",
		to = 32,
		from = 32
	},
	overseer_fx_overseer_destroyray_loop = {
		prefix = "overseer_fx_overseer_destroyray",
		to = 16,
		from = 1
	},
	overseer_fx_overseer_destroyray_dissipate = {
		prefix = "overseer_fx_overseer_destroyray",
		to = 26,
		from = 17
	},
	overseer_fx_overseer_crater_run = {
		prefix = "overseer_fx_overseer_crater",
		to = 33,
		from = 1
	},
	overseer_fx_overseer_destroyray_loop = {
		prefix = "overseer_fx_overseer_destroyray",
		to = 26,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage16_decos.lua

-- BEGIN kr3/data/animations/stage17_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage17_decos.lua

local a = {
	hidden_path_reventant_revenant_roots_reveal_revenant_in = {
		prefix = "hidden_path_reventant_revenant_roots_reveal",
		to = 30,
		from = 1
	},
	hidden_path_reventant_revenant_roots_reveal_revenant_idle = {
		prefix = "hidden_path_reventant_revenant_roots_reveal",
		to = 46,
		from = 31
	},
	hidden_path_reventant_revenant_roots_reveal_revenant_anim_reveal = {
		prefix = "hidden_path_reventant_revenant_roots_reveal",
		to = 92,
		from = 47
	},
	hidden_path_reventant_revenant_roots_reveal_revenant_idle_02 = {
		prefix = "hidden_path_reventant_revenant_roots_reveal",
		to = 133,
		from = 93
	},
	hidden_path_reventant_revenant_roots_reveal_revenant_out = {
		prefix = "hidden_path_reventant_revenant_roots_reveal",
		to = 155,
		from = 134
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage17_decos.lua

-- BEGIN kr3/data/animations/stage18_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage18_decos.lua

local a = {
	eridan_s18_arrow_miss = {
		prefix = "eridan_s18_arrow_miss",
		to = 1,
		from = 1
	},
	eridan_s18_arrow = {
		prefix = "eridan_s18_arrow",
		to = 1,
		from = 1
	},
	eridan_s18_arrow_particle = {
		prefix = "eridan_s18_arrow_particle",
		to = 11,
		from = 1
	},
	eridan_s18_eridan_idle = {
		prefix = "eridan_s18_eridan",
		to = 20,
		from = 1
	},
	eridan_s18_eridan_shoot = {
		prefix = "eridan_s18_eridan",
		to = 55,
		from = 21
	},
	eridan_s18_eridan_dash_out = {
		prefix = "eridan_s18_eridan",
		to = 67,
		from = 56
	},
	eridan_s18_eridan_dash_in = {
		prefix = "eridan_s18_eridan",
		to = 72,
		from = 68
	},
	eridan_s18_eridan_fight_sequence = {
		prefix = "eridan_s18_eridan",
		to = 132,
		from = 73
	},
	cuckoo_easter_egg_door_idle = {
		prefix = "cuckoo_easter_egg_door",
		to = 1,
		from = 1
	},
	cuckoo_easter_egg_door_action_1 = {
		prefix = "cuckoo_easter_egg_door",
		to = 8,
		from = 2
	},
	cuckoo_easter_egg_door_action_2_in = {
		prefix = "cuckoo_easter_egg_door",
		to = 46,
		from = 9
	},
	cuckoo_easter_egg_door_action_2_idle = {
		prefix = "cuckoo_easter_egg_door",
		to = 48,
		from = 47
	},
	cuckoo_easter_egg_door_action_2_out = {
		prefix = "cuckoo_easter_egg_door",
		to = 77,
		from = 49
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage18_decos.lua

-- BEGIN kr3/data/animations/stage19_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage19_decos.lua

local a = {
	navira_navira_idle = {
		prefix = "navira_navira",
		to = 32,
		from = 1
	},
	navira_navira_idlecape = {
		prefix = "navira_navira",
		to = 64,
		from = 33
	},
	navira_navira_idlecapeout = {
		prefix = "navira_navira",
		to = 102,
		from = 65
	},
	navira_navira_sealofruin = {
		prefix = "navira_navira",
		to = 180,
		from = 103
	},
	navira_navira_attack = {
		prefix = "navira_navira",
		to = 217,
		from = 181
	},
	navira_navira_tornadoin = {
		prefix = "navira_navira",
		to = 249,
		from = 218
	},
	navira_navira_tornadoloop = {
		prefix = "navira_navira",
		to = 265,
		from = 250
	},
	navira_navira_tornadoend = {
		prefix = "navira_navira",
		to = 311,
		from = 266
	},
	navira_navira_death = {
		prefix = "navira_navira",
		to = 480,
		from = 312
	},
	navira_navira_teleport_out = {
		prefix = "navira_navira",
		to = 496,
		from = 481
	},
	navira_navira_teleport_in = {
		prefix = "navira_navira",
		to = 512,
		from = 497
	},
	navira_navira_shake_in = {
		prefix = "navira_navira",
		to = 520,
		from = 513
	},
	navira_navira_shake_down = {
		prefix = "navira_navira",
		to = 581,
		from = 521
	},
	navira_navira_shake_out = {
		prefix = "navira_navira",
		to = 589,
		from = 582
	},
	navira_soul_idle = {
		prefix = "navira_soul",
		to = 20,
		from = 1
	},
	navira_soul_spawn = {
		prefix = "navira_soul",
		to = 40,
		from = 21
	},
	navira_soulray_run = {
		prefix = "navira_soulray",
		to = 44,
		from = 1
	},
	navira_towerstun_start = {
		prefix = "navira_towerstun",
		to = 8,
		from = 1
	},
	navira_towerstun_loop = {
		prefix = "navira_towerstun",
		to = 40,
		from = 9
	},
	navira_towerstun_end = {
		prefix = "navira_towerstun",
		to = 54,
		from = 41
	},
	navira_hands_dust_01_idle = {
		prefix = "navira_hands_dust_01",
		to = 80,
		from = 1
	},
	navira_hands_dust_02_idle = {
		prefix = "navira_hands_dust_02",
		to = 80,
		from = 1
	},
	navira_hands_stones_01_idle = {
		prefix = "navira_hands_stones_01",
		to = 52,
		from = 1
	},
	navira_hands_stones_02_idle = {
		prefix = "navira_hands_stones_02",
		to = 52,
		from = 1
	},
	navira_hands_hands_idle = {
		prefix = "navira_hands",
		to = 1,
		from = 1
	},
	navira_hands_hands_shake = {
		prefix = "navira_hands",
		to = 194,
		from = 2
	},
	navira_naviracape = {
		prefix = "navira_naviracape",
		to = 12,
		from = 1
	},
	navira_naviracape_run = {
		prefix = "navira_naviracape",
		to = 12,
		from = 1
	},
	navira_heal_fx = {
		prefix = "navira_heal_fx",
		to = 30,
		from = 1
	},
	navira_heal_fx_idle = {
		prefix = "navira_heal_fx",
		to = 30,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage19_decos.lua

-- BEGIN kr3/data/animations/stage1_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage1_decos.lua

local a = {
	stage1_tutorial_hand_indicator = {
		prefix = "tutorial_hand",
		to = 19,
		from = 1
	},
	stage1_waterfall_1 = {
		prefix = "Stage_1_decos_waterfall_water",
		to = 9,
		from = 1
	},
	stage1_waterfall_2 = {
		prefix = "Stage_1_decos_waterfall_2",
		to = 9,
		from = 1
	},
	stage1_waterfall_ripples = {
		prefix = "Stage_1_decos_waterfall_ripples",
		to = 16,
		from = 1
	},
	stage1_wisp_1 = {
		prefix = "Stage_1_decos_wisps1",
		to = 74,
		from = 1
	},
	stage1_wisp_2 = {
		prefix = "Stage_1_decos_wisps2",
		to = 74,
		from = 1
	},
	stage1_wisp_3 = {
		prefix = "Stage_1_decos_wisps3",
		to = 74,
		from = 1
	},
	stage1_wisp_4 = {
		prefix = "Stage_1_decos_wisps4",
		to = 74,
		from = 1
	},
	stage1_wisp_5 = {
		prefix = "Stage_1_decos_wisps5",
		to = 74,
		from = 1
	},
	stage1_wisp_6 = {
		prefix = "Stage_1_decos_wisps6",
		to = 74,
		from = 1
	},
	stage1_wisp_7 = {
		prefix = "Stage_1_decos_wisps7",
		to = 74,
		from = 1
	},
	stage1_wisp_8 = {
		prefix = "Stage_1_decos_wisps8",
		to = 74,
		from = 1
	},
	Stage_1_tutorial_bush_idle = {
		prefix = "Stage_1_tutorial_shaman_holder_bush",
		to = 1,
		from = 1
	},
	Stage_1_tutorial_bush_out = {
		prefix = "Stage_1_tutorial_shaman_holder_bush",
		to = 43,
		from = 2
	},
	Stage_1_tutorial_shaman_idle1 = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 1,
		from = 1
	},
	Stage_1_tutorial_shaman_spawn = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 48,
		from = 2
	},
	Stage_1_tutorial_shaman_idle2 = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 49,
		from = 49
	},
	Stage_1_tutorial_shaman_ability_start = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 73,
		from = 50
	},
	Stage_1_tutorial_shaman_idle3 = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 103,
		from = 74
	},
	Stage_1_tutorial_shaman_ability_end = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 119,
		from = 104
	},
	Stage_1_tutorial_shaman_out = {
		prefix = "Stage_1_tutorial_shaman_shaman_tutorial",
		to = 148,
		from = 120
	},
	robin_hood_easter_egg_layerX_idle = {
		layer_to = 5,
		from = 1,
		layer_prefix = "robin_hood_easter_egg_layer%i",
		to = 1,
		layer_from = 1
	},
	robin_hood_easter_egg_layerX_attack = {
		layer_to = 5,
		from = 2,
		layer_prefix = "robin_hood_easter_egg_layer%i",
		to = 64,
		layer_from = 1
	},
	robin_hood_easter_egg_layerX_fall = {
		layer_to = 5,
		from = 65,
		layer_prefix = "robin_hood_easter_egg_layer%i",
		to = 194,
		layer_from = 1
	},
	campfire_guy_tent_front_idle = {
		prefix = "campfire_guy_tent_front",
		to = 1,
		from = 1
	},
	campfire_guy_tent_front_closes = {
		prefix = "campfire_guy_tent_front",
		to = 10,
		from = 2
	},
	campfire_guy_tent_front_idle_closed_tent = {
		prefix = "campfire_guy_tent_front",
		to = 11,
		from = 11
	},
	campfire_guy_guy_idle = {
		prefix = "campfire_guy_guy",
		to = 1,
		from = 1
	},
	campfire_guy_guy_action = {
		prefix = "campfire_guy_guy",
		to = 61,
		from = 2
	},
	campfire_guy_guy_leaves = {
		prefix = "campfire_guy_guy",
		to = 330,
		from = 62
	},
	campfire_guy_guy_idle_gone = {
		prefix = "campfire_guy_guy",
		to = 331,
		from = 331
	},
	campfire_guy_campfire_idle = {
		prefix = "campfire_guy_campfire",
		to = 12,
		from = 1
	},
	campfire_guy_campfire_extinguish = {
		prefix = "campfire_guy_campfire",
		to = 52,
		from = 13
	},
	campfire_guy_campfire_smoke_idle = {
		prefix = "campfire_guy_campfire",
		to = 92,
		from = 53
	},
	campfire_guy_campfire_lit = {
		prefix = "campfire_guy_campfire",
		to = 110,
		from = 93
	},
	campfire_guy_campfire_big_fire = {
		prefix = "campfire_guy_campfire",
		to = 172,
		from = 111
	},
	campfire_guy_campfire_idle_burnt = {
		prefix = "campfire_guy_campfire",
		to = 197,
		from = 173
	},
	campfire_guy_tent_back_idle = {
		prefix = "campfire_guy_tent_back",
		to = 1,
		from = 1
	},
	Stage_1_rapido_elder_rune_1_idle = {
		prefix = "Stage_1_rapido_elder_rune_1",
		to = 66,
		from = 1
	},
	Stage_1_rapido_elder_rune_1_activation = {
		prefix = "Stage_1_rapido_elder_rune_1",
		to = 118,
		from = 67
	},
	Stage_1_rapido_elder_rune_1_idle_2 = {
		prefix = "Stage_1_rapido_elder_rune_1",
		to = 159,
		from = 119
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage1_decos.lua

-- BEGIN kr3/data/animations/stage20_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage20_decos.lua

local a = {
	arborean_house_hit_1_run = {
		prefix = "arborean_house_hit_1",
		to = 15,
		from = 1
	},
	arborean_house_hit_2_run = {
		prefix = "arborean_house_hit_2",
		to = 19,
		from = 1
	},
	arborean_house_base_idle1 = {
		prefix = "arborean_house_base",
		to = 6,
		from = 1
	},
	arborean_house_base_idle2 = {
		prefix = "arborean_house_base",
		to = 12,
		from = 7
	},
	arborean_house_base_idle3 = {
		prefix = "arborean_house_base",
		to = 18,
		from = 13
	},
	arborean_house_base_idle4 = {
		prefix = "arborean_house_base",
		to = 24,
		from = 19
	},
	arborean_oldtree_trail_trail_run = {
		prefix = "arborean_oldtree_trail_trail",
		to = 12,
		from = 1
	},
	arborean_warrior_barraca_door_open = {
		prefix = "arborean_warrior_barraca_door",
		to = 13,
		from = 1
	},
	arborean_warrior_barraca_door_close = {
		prefix = "arborean_warrior_barraca_door",
		to = 28,
		from = 14
	},
	arborean_warrior_barraca_door_closed = {
		prefix = "arborean_warrior_barraca_door",
		to = 1,
		from = 1
	},
	arborean_warrior_barraca_warrior_idle = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 1,
		from = 1
	},
	arborean_warrior_barraca_warrior_walk = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 25,
		from = 2
	},
	arborean_warrior_barraca_warrior_walkDown = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 49,
		from = 26
	},
	arborean_warrior_barraca_warrior_walkUp = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 73,
		from = 50
	},
	arborean_warrior_barraca_warrior_attack = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 99,
		from = 74
	},
	arborean_warrior_barraca_warrior_death = {
		prefix = "arborean_warrior_barraca_warrior",
		to = 119,
		from = 100
	},
	arborean_warrior_barraca_hit_1_run = {
		prefix = "arborean_warrior_barraca_hit_1",
		to = 15,
		from = 1
	},
	arborean_warrior_barraca_hit_2_run = {
		prefix = "arborean_warrior_barraca_hit_2",
		to = 19,
		from = 1
	},
	arborean_warrior_barraca_varitas_transicion1 = {
		prefix = "arborean_warrior_barraca_varitas",
		to = 16,
		from = 1
	},
	arborean_warrior_barraca_varitas_idle1 = {
		prefix = "arborean_warrior_barraca_varitas",
		to = 48,
		from = 17
	},
	arborean_warrior_barraca_varitas_transicion2 = {
		prefix = "arborean_warrior_barraca_varitas",
		to = 64,
		from = 49
	},
	arborean_warrior_barraca_varitas_idle2 = {
		prefix = "arborean_warrior_barraca_varitas",
		to = 90,
		from = 65
	},
	arborean_warrior_barraca_base_idle1 = {
		prefix = "arborean_warrior_barraca_base",
		to = 4,
		from = 1
	},
	arborean_warrior_barraca_base_idle2 = {
		prefix = "arborean_warrior_barraca_base",
		to = 10,
		from = 5
	},
	arborean_warrior_barraca_base_idle3 = {
		prefix = "arborean_warrior_barraca_base",
		to = 16,
		from = 11
	},
	arborean_warrior_barraca_base_idle4 = {
		prefix = "arborean_warrior_barraca_base",
		to = 22,
		from = 17
	},
	arborean_honey_tower_unit_idle = {
		prefix = "arborean_honey_tower_unit",
		to = 1,
		from = 1
	},
	arborean_honey_tower_unit_hit = {
		prefix = "arborean_honey_tower_unit",
		to = 106,
		from = 1
	},
	arborean_honey_tower_deco_unit_idle_1 = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 1,
		from = 1
	},
	arborean_honey_tower_deco_unit_in = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 55,
		from = 2
	},
	arborean_honey_tower_deco_unit_hit = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 69,
		from = 56
	},
	arborean_honey_tower_deco_unit_out = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 77,
		from = 70
	},
	arborean_honey_tower_deco_unit_loop = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 107,
		from = 78
	},
	arborean_honey_tower_deco_unit_idle_2 = {
		prefix = "arborean_honey_tower_deco_unit",
		to = 142,
		from = 108
	},
	arborean_honey_tower_projectil_run = {
		prefix = "arborean_honey_tower_projectil",
		to = 1,
		from = 1
	},
	arborean_honey_tower_projectil_splash_run = {
		prefix = "arborean_honey_tower_projectil_splash",
		to = 16,
		from = 1
	},
	arborean_honey_tower_decal_in = {
		prefix = "arborean_honey_tower_decal",
		to = 40,
		from = 1
	},
	arborean_honey_tower_smoke = {
		prefix = "arborean_honey_tower_smoke",
		to = 16,
		from = 1
	},
	arborean_honey_tower_modifier = {
		prefix = "arborean_honey_tower_modifier",
		to = 16,
		from = 1
	},
	fx_water_splash_big = {
		prefix = "fx_water_splash_big",
		to = 19,
		from = 1
	},
	fx_water_bubble_big = {
		prefix = "fx_water_bubble_big",
		to = 33,
		from = 1
	},
	fx_water_splash_small = {
		prefix = "fx_water_splash",
		to = 14,
		from = 1
	},
	fx_water_bubble_small = {
		prefix = "fx_water_bubble",
		to = 24,
		from = 1
	},
	fx_water_bubble_big_projectile = {
		prefix = "fx_water_bubble_big_projectile",
		to = 16,
		from = 1
	},
	anim_arborean_ruperto_arborean_idle = {
		prefix = "anim_arborean_ruperto_arborean",
		to = 1,
		from = 1
	},
	anim_arborean_ruperto_arborean_action1 = {
		prefix = "anim_arborean_ruperto_arborean",
		to = 41,
		from = 2
	},
	anim_arborean_ruperto_arborean_action2 = {
		prefix = "anim_arborean_ruperto_arborean",
		to = 77,
		from = 42
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage20_decos.lua

-- BEGIN kr3/data/animations/stage21_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage21_decos.lua

local a = {
	Achievement_lagarto_juancho_creep_idle1 = {
		prefix = "Achievement_lagarto_juancho_creep",
		to = 1,
		from = 1
	},
	Achievement_lagarto_juancho_creep_tap1 = {
		prefix = "Achievement_lagarto_juancho_creep",
		to = 51,
		from = 2
	},
	Achievement_lagarto_juancho_creep_tap2 = {
		prefix = "Achievement_lagarto_juancho_creep",
		to = 164,
		from = 52
	},
	Achievement_lagarto_juancho_creep_idle2 = {
		prefix = "Achievement_lagarto_juancho_creep",
		to = 200,
		from = 165
	},
	Achievement_lagarto_juancho_water = {
		prefix = "Achievement_lagarto_juancho_water",
		to = 1,
		from = 1
	},
	Achievement_lagarto_juancho_boat = {
		prefix = "Achievement_lagarto_juancho_boat",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage21_decos.lua

-- BEGIN kr3/data/animations/stage22_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage22_decos.lua

local a = {
	achievement_donkey_kong_creep_idle = {
		prefix = "achievement_donkey_kong_creep",
		to = 1,
		from = 1
	},
	achievement_donkey_kong_creep_tap1 = {
		prefix = "achievement_donkey_kong_creep",
		to = 29,
		from = 2
	},
	achievement_donkey_kong_creep_tap2 = {
		prefix = "achievement_donkey_kong_creep",
		to = 57,
		from = 30
	},
	achievement_donkey_kong_creep_idle2 = {
		prefix = "achievement_donkey_kong_creep",
		to = 58,
		from = 58
	},
	achievement_donkey_kong_creep_tap3 = {
		prefix = "achievement_donkey_kong_creep",
		to = 89,
		from = 59
	},
	achievement_donkey_kong_creep_loop = {
		prefix = "achievement_donkey_kong_creep",
		to = 93,
		from = 90
	},
	boss_gator_vfx_fire_projetile_run = {
		prefix = "boss_gator_vfx_projectile",
		to = 12,
		from = 1
	},
	boss_gator_vfx_fire_trail = {
		prefix = "boss_gator_vfx_trail",
		to = 8,
		from = 1
	},
	boss_gator_vfx_acid_projectile_run = {
		prefix = "boss_gator_vfx_acid_projectile",
		to = 9,
		from = 1
	},
	boss_gator_vfx_acid_trail = {
		prefix = "boss_gator_vfx_acid_trail",
		to = 14,
		from = 1
	},
	boss_gator_vfx_hit_melee_run = {
		prefix = "boss_gator_vfx_hit_melee",
		to = 15,
		from = 1
	},
	boss_gator_vfx_acid_modifier_run = {
		prefix = "boss_gator_vfx_acid_modifier",
		to = 27,
		from = 1
	},
	boss_gator_vfx_fire_modifier_run = {
		prefix = "boss_gator_vfx_fire_modifier",
		to = 10,
		from = 1
	},
	stage_22_boss_prisoner_04_boss_idle = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 1,
		from = 1
	},
	stage_22_boss_prisoner_04_boss_idle2 = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 29,
		from = 1
	},
	stage_22_boss_prisoner_04_boss_idle3 = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 66,
		from = 30
	},
	stage_22_boss_prisoner_04_boss_skill_in = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 91,
		from = 67
	},
	stage_22_boss_prisoner_04_boss_skill_loop = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 133,
		from = 92
	},
	stage_22_boss_prisoner_04_boss_skill_end = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 153,
		from = 134
	},
	stage_22_boss_prisoner_04_boss_exit = {
		prefix = "stage_22_boss_prisoner_04_boss",
		to = 217,
		from = 154
	},
	Stage_22_shaman_shaman_hitfx_run = {
		prefix = "Stage_22_shaman_shaman_hitfx",
		to = 23,
		from = 1
	},
	Stage_22_shaman_shaman_projectile_run = {
		prefix = "Stage_22_shaman_shaman_projectile",
		to = 12,
		from = 1
	},
	Stage_22_shaman_shaman_trail_run = {
		prefix = "Stage_22_shaman_shaman_trail",
		to = 18,
		from = 1
	},
	Stage_22_shaman_shaman_unit_spawn = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 47,
		from = 1
	},
	Stage_22_shaman_shaman_unit_idle = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 48,
		from = 48
	},
	Stage_22_shaman_shaman_unit_ability = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 88,
		from = 49
	},
	Stage_22_shaman_shaman_unit_out = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 117,
		from = 89
	},
	Stage_22_shaman_shaman_unit_ability_boss = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 157,
		from = 118
	},
	Stage_22_shaman_shaman_unit_tauntIn = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 181,
		from = 158
	},
	Stage_22_shaman_shaman_unit_taunLoop = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 208,
		from = 182
	},
	Stage_22_shaman_shaman_unit_tauntOut = {
		prefix = "Stage_22_shaman_shaman_unit",
		to = 227,
		from = 209
	},
	Stage_22_shaman_shaman_base_idle = {
		prefix = "Stage_22_shaman_shaman_base",
		to = 1,
		from = 1
	},
	remolino_stage_3_anim_in = {
		prefix = "remolino_anim",
		to = 10,
		from = 1
	},
	remolino_stage_3_anim_loop = {
		prefix = "remolino_anim",
		to = 26,
		from = 11
	},
	remolino_stage_3_anim_out = {
		prefix = "remolino_anim",
		to = 38,
		from = 27
	},
	croco_sheepy_idle = {
		prefix = "croco_sheepy",
		to = 1,
		from = 1
	},
	croco_sheepy_running = {
		prefix = "croco_sheepy",
		to = 25,
		from = 2
	},
	croco_sheepy_action1 = {
		prefix = "croco_sheepy",
		to = 61,
		from = 26
	},
	croco_sheepy_death = {
		prefix = "croco_sheepy",
		to = 207,
		from = 62
	},
	crocs_tower_block_tap_tap = {
		prefix = "crocs_tower_block_tap",
		to = 10,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage22_decos.lua

-- BEGIN kr3/data/animations/stage24_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage24_decos.lua

local a = {
	dlc_enanos_stage_02_LAYERS_factorygate_in = {
		prefix = "dlc_enanos_stage_02_LAYERS_factorygate",
		to = 63,
		from = 1
	},
	dlc_enanos_stage_02_LAYERS_factorygate_activeloop = {
		prefix = "dlc_enanos_stage_02_LAYERS_factorygate",
		to = 78,
		from = 64
	},
	dlc_enanos_stage_02_LAYERS_factorygate_out = {
		prefix = "dlc_enanos_stage_02_LAYERS_factorygate",
		to = 92,
		from = 79
	},
	dlc_enanos_stage_02_LAYERS_gear_loop = {
		prefix = "dlc_enanos_stage_02_LAYERS_gear",
		to = 30,
		from = 1
	},
	dlc_dwarf_boss_operator_sparks_run = {
		prefix = "dlc_dwarf_boss_operator_sparks",
		to = 20,
		from = 1
	},
	dlc_dwarf_boss_operator_bossengineer_idle = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 1,
		from = 1
	},
	dlc_dwarf_boss_operator_bossengineer_walk = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 21,
		from = 2
	},
	dlc_dwarf_boss_operator_bossengineer_attack = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 53,
		from = 22
	},
	dlc_dwarf_boss_operator_bossengineer_factory1 = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 94,
		from = 54
	},
	dlc_dwarf_boss_operator_bossengineer_factory2 = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 135,
		from = 95
	},
	dlc_dwarf_boss_operator_bossengineer_factory3 = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 176,
		from = 136
	},
	dlc_dwarf_boss_operator_bossengineer_talkin = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 180,
		from = 177
	},
	dlc_dwarf_boss_operator_bossengineer_talkloop = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 190,
		from = 181
	},
	dlc_dwarf_boss_operator_bossengineer_talkout = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 194,
		from = 191
	},
	dlc_dwarf_boss_operator_bossengineer_preparetojump = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 207,
		from = 195
	},
	dlc_dwarf_boss_operator_decalfire_run = {
		prefix = "dlc_dwarf_boss_operator_decalfire",
		to = 42,
		from = 1
	},
	dlc_dwarf_boss_operator_bossengineer_factory3 = {
		prefix = "dlc_dwarf_boss_operator_bossengineer",
		to = 175,
		from = 136
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage24_decos.lua

-- BEGIN kr3/data/animations/stage27_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage27_decos.lua

local a = {
	cannonLAYERS_flyclone_fly = {
		prefix = "cannonLAYERS_flyclone",
		to = 1,
		from = 1
	},
	cannonLAYERS_clonedecorative_run = {
		prefix = "cannonLAYERS_clonedecorative",
		to = 11,
		from = 1
	},
	cannonLAYERS_cloneland_idle = {
		prefix = "cannonLAYERS_cloneland",
		to = 33,
		from = 1
	},
	grymbeardbossLAYERS_flyboss_fly = {
		prefix = "grymbeardbossLAYERS_flyboss",
		to = 8,
		from = 1
	},
	grymbeardbossLAYERS_flytrail_run = {
		prefix = "grymbeardbossLAYERS_flytrail",
		to = 20,
		from = 1
	},
	grymbeardbossLAYERS_missiletrail_run = {
		prefix = "grymbeardbossLAYERS_missiletrail",
		to = 15,
		from = 1
	},
	grymbeardbossLAYERS_missile_run = {
		prefix = "grymbeardbossLAYERS_missile",
		to = 12,
		from = 1
	},
	boss_fx_scrap_projectile = {
		prefix = "boss_fx_scrap_projectile",
		to = 1,
		from = 1
	},
	boss_fx_scrap_particle = {
		prefix = "boss_fx_scrap_particle",
		to = 6,
		from = 1
	},
	boss_fx_scrap_hit = {
		prefix = "boss_fx_scrap_hit",
		to = 23,
		from = 1
	},
	boss_fx_scrap_tower_fx_idle = {
		prefix = "boss_fx_scrap_tower_fx",
		to = 1,
		from = 1
	},
	boss_fx_scrap_tower_fx_in = {
		prefix = "boss_fx_scrap_tower_fx",
		to = 12,
		from = 2
	},
	boss_fx_scrap_tower_fx_out = {
		prefix = "boss_fx_scrap_tower_fx",
		to = 33,
		from = 13
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage27_decos.lua

-- BEGIN kr3/data/animations/stage28_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage28_decos.lua

local a = {
	redemeed_cultist_barraca_tentacle_raise = {
		prefix = "tentacle",
		to = 21,
		from = 1
	},
	redemeed_cultist_barraca_tentacle_idle = {
		prefix = "tentacle",
		to = 22,
		from = 22
	},
	redemeed_cultist_barraca_tentacle_attack01 = {
		prefix = "tentacle",
		to = 45,
		from = 23
	},
	redemeed_cultist_barraca_tentacle_attack02 = {
		prefix = "tentacle",
		to = 67,
		from = 46
	},
	redemeed_cultist_barraca_tentacle_death = {
		prefix = "tentacle",
		to = 94,
		from = 68
	},
	priest_melee_trail = {
		prefix = "priest_melee_trail",
		to = 6,
		from = 1
	},
	priest_melee_hit = {
		prefix = "priest_melee_hit",
		to = 6,
		from = 1
	},
	priest_projectile_flying = {
		prefix = "priest_projectile",
		to = 1,
		from = 1
	},
	priest_particle_idle = {
		prefix = "priest_particle",
		to = 7,
		from = 1
	},
	priest_ranged_hit_idle = {
		prefix = "priest_ranged_hit",
		to = 10,
		from = 1
	},
	priest_hit_particle = {
		prefix = "priest_hit_particle",
		to = 7,
		from = 1
	},
	redemeed_cultist_barraca_priest_idle = {
		prefix = "priest",
		to = 1,
		from = 1
	},
	redemeed_cultist_barraca_priest_walk = {
		prefix = "priest",
		to = 25,
		from = 2
	},
	redemeed_cultist_barraca_priest_death = {
		prefix = "priest",
		to = 65,
		from = 26
	},
	redemeed_cultist_barraca_priest_ranged_attack = {
		prefix = "priest",
		to = 103,
		from = 66
	},
	redemeed_cultist_barraca_priest_melee_attack = {
		prefix = "priest",
		to = 133,
		from = 104
	},
	redemeed_cultist_barraca_priest_transformation_abomination = {
		prefix = "priest",
		to = 165,
		from = 134
	},
	redemeed_cultist_barraca_priest_transform_tentacle = {
		prefix = "priest",
		to = 182,
		from = 166
	},
	redemeed_cultist_barraca_unblinded_abomination_idle = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination",
		to = 1,
		from = 1
	},
	redemeed_cultist_barraca_unblinded_abomination_walk = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination",
		to = 33,
		from = 2
	},
	redemeed_cultist_barraca_unblinded_abomination_attack = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination",
		to = 55,
		from = 34
	},
	redemeed_cultist_barraca_unblinded_abomination_eat = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination",
		to = 97,
		from = 56
	},
	redemeed_cultist_barraca_unblinded_abomination_death = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination",
		to = 146,
		from = 98
	},
	redemeed_cultist_barraca_unblinded_abomination_hit_fx_idle = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination_hit_fx",
		to = 6,
		from = 1
	},
	redemeed_cultist_barraca_unblinded_abomination_eat_fx = {
		prefix = "redemeed_cultist_barraca_unblinded_abomination_eat_fx",
		to = 11,
		from = 1
	},
	redemeed_cultist_barraca_door_open = {
		prefix = "redemeed_cultist_barraca_door",
		to = 13,
		from = 1
	},
	redemeed_cultist_barraca_door_close = {
		prefix = "redemeed_cultist_barraca_door",
		to = 28,
		from = 14
	},
	redemeed_cultist_barraca_door_closed = {
		prefix = "redemeed_cultist_barraca_door",
		to = 1,
		from = 1
	},
	redemeed_cultist_barraca_fire_candle_idle = {
		prefix = "redemeed_cultist_barraca_fire_candle",
		to = 14,
		from = 1
	},
	redemeed_cultist_barraca_base_idle = {
		prefix = "redemeed_cultist_barraca_base",
		to = 5,
		from = 1
	},
	ogreverse_web = {
		prefix = "ogreverse_web",
		to = 1,
		from = 1
	},
	ogreverse_character_cultist_idle = {
		prefix = "ogreverse_character",
		to = 2,
		from = 1
	},
	ogreverse_character_cultist_transform = {
		prefix = "ogreverse_character",
		to = 22,
		from = 3
	},
	ogreverse_character_spider_idle = {
		prefix = "ogreverse_character",
		to = 24,
		from = 23
	},
	ogreverse_character_spider_transform = {
		prefix = "ogreverse_character",
		to = 46,
		from = 25
	},
	ogreverse_character_pig_idle = {
		prefix = "ogreverse_character",
		to = 48,
		from = 47
	},
	ogreverse_character_pig_transform = {
		prefix = "ogreverse_character",
		to = 72,
		from = 49
	},
	ogreverse_character_ogre_idle = {
		prefix = "ogreverse_character",
		to = 74,
		from = 73
	},
	ogreverse_character_ogre_transform = {
		prefix = "ogreverse_character",
		to = 86,
		from = 75
	},
	ogreverse_character_ogre_fall = {
		prefix = "ogreverse_character",
		to = 130,
		from = 87
	}
}
local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage28_decos.lua

-- BEGIN kr3/data/animations/stage29_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage29_decos.lua

local a = {
	cocon_stage2_coocoon_idle = {
		prefix = "cocon_stage2_coocoon",
		to = 1,
		from = 1
	},
	cocon_stage2_coocoon_idle_anim = {
		prefix = "cocon_stage2_coocoon",
		to = 53,
		from = 2
	},
	cocon_stage2_coocoon_summon_in = {
		prefix = "cocon_stage2_coocoon",
		to = 203,
		from = 54
	},
	cocon_stage2_coocoon_summon_out = {
		prefix = "cocon_stage2_coocoon",
		to = 203,
		from = 203
	},
	cocon_stage2_coocoon_idle_broken = {
		prefix = "cocon_stage2_coocoon",
		to = 185,
		from = 185
	},
	spiderholder_construido_attack = {
		prefix = "spiderholder_construido",
		to = 38,
		from = 1
	},
	spiderholder_spiderholder_climb_down = {
		prefix = "spiderholder_spiderholder",
		to = 10,
		from = 1
	},
	spiderholder_spiderholder_arrive = {
		prefix = "spiderholder_spiderholder",
		to = 16,
		from = 11
	},
	spiderholder_spiderholder_netting = {
		prefix = "spiderholder_spiderholder",
		to = 30,
		from = 17
	},
	spiderholder_spiderholder_climb_up_start = {
		prefix = "spiderholder_spiderholder",
		to = 40,
		from = 31
	},
	spiderholder_spiderholder_climbing_up_idle = {
		prefix = "spiderholder_spiderholder",
		to = 41,
		from = 41
	},
	spiderholder_spiderholder_explode = {
		prefix = "spiderholder_spiderholder",
		to = 55,
		from = 42
	},
	spiderholder_block_tap_tap = {
		prefix = "spiderholder_block_tap",
		to = 10,
		from = 1
	},
	coonsuprices_silksong_idle = {
		prefix = "coonsuprices_silksong",
		to = 1,
		from = 1
	},
	coonsuprices_silksong_clicked = {
		prefix = "coonsuprices_silksong",
		to = 24,
		from = 2
	},
	coonsuprices_silksong_broken = {
		prefix = "coonsuprices_silksong",
		to = 82,
		from = 25
	},
	coonsuprices_silksong_idle_2 = {
		prefix = "coonsuprices_silksong",
		to = 83,
		from = 83
	},
	coonsuprices_cuerdasilksong = {
		prefix = "coonsuprices_cuerdasilksong",
		to = 1,
		from = 1
	},
	coonsuprices_arak_idle = {
		prefix = "coonsuprices_arak",
		to = 1,
		from = 1
	},
	coonsuprices_arak_clicked = {
		prefix = "coonsuprices_arak",
		to = 15,
		from = 2
	},
	coonsuprices_arak_broken = {
		prefix = "coonsuprices_arak",
		to = 25,
		from = 16
	},
	coonsuprices_arak_idle_2 = {
		prefix = "coonsuprices_arak",
		to = 26,
		from = 26
	},
	coonsuprices_fredo_idle = {
		prefix = "coonsuprices_fredo",
		to = 1,
		from = 1
	},
	coonsuprices_fredo_clicked = {
		prefix = "coonsuprices_fredo",
		to = 10,
		from = 2
	},
	coonsuprices_fredo_broken = {
		prefix = "coonsuprices_fredo",
		to = 143,
		from = 11
	},
	coonsuprices_fredo_idle_2 = {
		prefix = "coonsuprices_fredo",
		to = 143,
		from = 143
	},
	coonsuprices_cuerdafredo = {
		prefix = "coonsuprices_cuerdafredo",
		to = 1,
		from = 1
	},
	coonsuprices_jarra_idle = {
		prefix = "coonsuprices_jarra",
		to = 1,
		from = 1
	},
	coonsuprices_jarra_clicked = {
		prefix = "coonsuprices_jarra",
		to = 23,
		from = 2
	},
	coonsuprices_jarra_broken = {
		prefix = "coonsuprices_jarra",
		to = 67,
		from = 24
	},
	coonsuprices_jarra_idle_2 = {
		prefix = "coonsuprices_jarra",
		to = 68,
		from = 68
	},
	coonsuprices_cuerdajarra = {
		prefix = "coonsuprices_cuerdajarra",
		to = 1,
		from = 1
	},
	coonsuprices_darkcrystal_idle = {
		prefix = "coonsuprices_darkcrystal",
		to = 1,
		from = 1
	},
	coonsuprices_darkcrystal_clicked = {
		prefix = "coonsuprices_darkcrystal",
		to = 24,
		from = 2
	},
	coonsuprices_darkcrystal_broken = {
		prefix = "coonsuprices_darkcrystal",
		to = 111,
		from = 25
	},
	coonsuprices_darkcrystal_idle_2 = {
		prefix = "coonsuprices_darkcrystal",
		to = 112,
		from = 112
	},
	coonsuprices_cuerdadarkcrystal = {
		prefix = "coonsuprices_cuerdadarkcrystal",
		to = 1,
		from = 1
	},
	coonsuprices_sheepy_idle = {
		prefix = "coonsuprices_sheepy",
		to = 1,
		from = 1
	},
	coonsuprices_sheepy_clicked = {
		prefix = "coonsuprices_sheepy",
		to = 17,
		from = 2
	},
	coonsuprices_sheepy_broken = {
		prefix = "coonsuprices_sheepy",
		to = 94,
		from = 18
	},
	coonsuprices_sheepy_idle_2 = {
		prefix = "coonsuprices_sheepy",
		to = 95,
		from = 95
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage29_decos.lua

-- BEGIN kr3/data/animations/stage30_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage30_decos.lua

local a = {
	export_easter_egg_lucas_idle = {
		prefix = "export_easter_egg_lucas",
		to = 90,
		from = 1
	},
	export_easter_egg_lucas_tap_1 = {
		prefix = "export_easter_egg_lucas",
		to = 111,
		from = 91
	},
	export_easter_egg_lucas_idle_2 = {
		prefix = "export_easter_egg_lucas",
		to = 112,
		from = 112
	},
	export_easter_egg_lucas_tap_2 = {
		prefix = "export_easter_egg_lucas",
		to = 167,
		from = 113
	},
	export_easter_egg_lucas_tap_3 = {
		prefix = "export_easter_egg_lucas",
		to = 244,
		from = 168
	},
	export_easter_egg_lucas_idle_3 = {
		prefix = "export_easter_egg_lucas",
		to = 245,
		from = 245
	},
	boss_spider_minispider_tower_stun_spider_climbDown = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 10,
		from = 1
	},
	boss_spider_minispider_tower_stun_spider_arrive = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 16,
		from = 11
	},
	boss_spider_minispider_tower_stun_spider_netting = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 30,
		from = 17
	},
	boss_spider_minispider_tower_stun_spider_climbUpStart = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 40,
		from = 31
	},
	boss_spider_minispider_tower_stun_spider_climbingUpIdle = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 41,
		from = 41
	},
	boss_spider_minispider_tower_stun_spider_explode = {
		prefix = "boss_spider_minispider_tower_stun_spider",
		to = 58,
		from = 42
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage30_decos.lua

-- BEGIN kr3/data/animations/stage31_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/stage31_decos.lua

local a = {
	stage31_mecanica_elemental_holder_wood_PROXY_jarra_idle = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_jarra",
		to = 1,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_jarra_broken = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_jarra",
		to = 19,
		from = 2
	},
	stage31_mecanica_elemental_holder_wood_PROXY_holder_idle = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_holder",
		to = 1,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_horns_run = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_horns",
		to = 74,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx_in = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx",
		to = 8,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx_loop = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx",
		to = 14,
		from = 9
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx_out = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_ground_fx",
		to = 22,
		from = 15
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_hability_start_hability = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_hability",
		to = 72,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_buy = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon",
		to = 87,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_idle = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon",
		to = 147,
		from = 88
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_buy_tower = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon",
		to = 223,
		from = 148
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_back_to_tower = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon",
		to = 290,
		from = 224
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre_buy = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre",
		to = 76,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre_idle = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre",
		to = 146,
		from = 77
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre_buy_tower = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_gradiente_torre",
		to = 180,
		from = 147
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1_start = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1",
		to = 14,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1_loop = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1",
		to = 22,
		from = 15
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1_end = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_1",
		to = 31,
		from = 23
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2_start = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2",
		to = 17,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2_loop = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2",
		to = 23,
		from = 18
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2_end = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_2",
		to = 38,
		from = 24
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3_start = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3",
		to = 16,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3_loop = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3",
		to = 24,
		from = 17
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3_end = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_3",
		to = 33,
		from = 25
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4_start = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4",
		to = 17,
		from = 1
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4_loop = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4",
		to = 23,
		from = 18
	},
	stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4_end = {
		prefix = "stage31_mecanica_elemental_holder_wood_PROXY_wood_dragon_root_4",
		to = 38,
		from = 24
	},
	dlc2_generic_tap_hand_tap = {
		prefix = "dlc2_generic_tap_hand",
		to = 10,
		from = 1
	},
	littledragon_easteregg_stage1_easteregg_idle_1 = {
		prefix = "littledragon_easteregg_stage1_easteregg",
		to = 1,
		from = 1
	},
	littledragon_easteregg_stage1_easteregg_tap_1 = {
		prefix = "littledragon_easteregg_stage1_easteregg",
		to = 82,
		from = 2
	},
	littledragon_easteregg_stage1_easteregg_idle_2 = {
		prefix = "littledragon_easteregg_stage1_easteregg",
		to = 83,
		from = 83
	},
	littledragon_easteregg_stage1_easteregg_tap_2 = {
		prefix = "littledragon_easteregg_stage1_easteregg",
		to = 240,
		from = 84
	},
	easter_egg_saitam_saitam_stage_1_idle = {
		prefix = "easter_egg_saitam_saitam_stage_1",
		to = 199,
		from = 1
	},
	easter_egg_saitam_saitam_stage_1_click_1 = {
		prefix = "easter_egg_saitam_saitam_stage_1",
		to = 207,
		from = 200
	},
	easter_egg_saitam_saitam_stage_1_click_2 = {
		prefix = "easter_egg_saitam_saitam_stage_1",
		to = 299,
		from = 208
	},
	easter_egg_saitam_saitam_stage_2_idle = {
		prefix = "easter_egg_saitam_saitam_stage_2",
		to = 199,
		from = 1
	},
	easter_egg_saitam_saitam_stage_2_click_1 = {
		prefix = "easter_egg_saitam_saitam_stage_2",
		to = 207,
		from = 200
	},
	easter_egg_saitam_saitam_stage_2_click_2 = {
		prefix = "easter_egg_saitam_saitam_stage_2",
		to = 290,
		from = 208
	},
	easter_egg_saitam_saitam_stage_3_idle = {
		prefix = "easter_egg_saitam_saitam_stage_3",
		to = 199,
		from = 1
	},
	easter_egg_saitam_saitam_stage_3_click_1 = {
		prefix = "easter_egg_saitam_saitam_stage_3",
		to = 207,
		from = 200
	},
	easter_egg_saitam_saitam_stage_3_click_2 = {
		prefix = "easter_egg_saitam_saitam_stage_3",
		to = 296,
		from = 208
	},
	easter_egg_saitam_saitam_stage_4_idle = {
		prefix = "easter_egg_saitam_saitam_stage_4",
		to = 199,
		from = 1
	},
	easter_egg_saitam_saitam_stage_4_click_1 = {
		prefix = "easter_egg_saitam_saitam_stage_4",
		to = 207,
		from = 200
	},
	easter_egg_saitam_saitam_stage_4_click_2 = {
		prefix = "easter_egg_saitam_saitam_stage_4",
		to = 307,
		from = 208
	},
	easter_egg_saitam_saitam_stage_5_idle = {
		prefix = "easter_egg_saitam_saitam_stage_5",
		to = 199,
		from = 1
	},
	easter_egg_saitam_saitam_stage_5_click_1 = {
		prefix = "easter_egg_saitam_saitam_stage_5",
		to = 207,
		from = 200
	},
	easter_egg_saitam_saitam_stage_5_click_2 = {
		prefix = "easter_egg_saitam_saitam_stage_5",
		to = 322,
		from = 208
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage31_decos.lua

-- BEGIN kr3/data/animations/stage32_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/stage32_decos.lua

local a = {
	ui_redboy_image_in = {
		prefix = "ui_redboy_image",
		to = 23,
		from = 1
	},
	ui_redboy_image_out = {
		prefix = "ui_redboy_image",
		to = 40,
		from = 24
	},
	sheepylava_sheepy_idle_1 = {
		prefix = "sheepylava_sheepy",
		to = 1,
		from = 1
	},
	sheepylava_sheepy_idle_1_anim = {
		prefix = "sheepylava_sheepy",
		to = 7,
		from = 2
	},
	sheepylava_sheepy_click_1 = {
		prefix = "sheepylava_sheepy",
		to = 51,
		from = 8
	},
	sheepylava_sheepy_idle_2 = {
		prefix = "sheepylava_sheepy",
		to = 52,
		from = 52
	},
	sheepylava_sheepy_idle_2_anim = {
		prefix = "sheepylava_sheepy",
		to = 58,
		from = 53
	},
	sheepylava_sheepy_click_2 = {
		prefix = "sheepylava_sheepy",
		to = 154,
		from = 59
	},
	sheepylava_sheepy_idle_3 = {
		prefix = "sheepylava_sheepy",
		to = 169,
		from = 155
	},
	sheepylava_sheepy_click_3 = {
		prefix = "sheepylava_sheepy",
		to = 251,
		from = 170
	},
	sheepylava_crater_3_idle = {
		prefix = "sheepylava_crater_3",
		to = 1,
		from = 1
	},
	sheepylava_crater_3_click_3 = {
		prefix = "sheepylava_crater_3",
		to = 33,
		from = 2
	},
	sheepylava_crater_1_run = {
		prefix = "sheepylava_crater_1",
		to = 1,
		from = 1
	},
	sheepylava_crater_2_idle = {
		prefix = "sheepylava_crater_2",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage32_decos.lua

-- BEGIN kr3/data/animations/stage33_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/stage33_decos.lua

local a = {
	vfx_mecanicas_ray_deco_idle = {
		prefix = "vfx_mecanicas_ray_deco",
		to = 41,
		from = 1
	},
	vfx_mecanicas_ray_decal_Idle = {
		prefix = "vfx_mecanicas_ray_decal",
		to = 42,
		from = 1
	},
	vfx_mecanicas_ray_portal_run = {
		prefix = "vfx_mecanicas_portal",
		to = 48,
		from = 1
	},
	vfx_mecanicas_ray_spawner_run = {
		prefix = "vfx_mecanicas_spawner",
		to = 27,
		from = 1
	},
	stage_33_lightning_strike_fx_power_thunder_explosion = {
		prefix = "rayo_og_exp",
		to = 16,
		from = 1
	},
	stage_33_lightning_strike_fx_power_thunder_explosion_decal = {
		prefix = "rayo_og_exp_decal",
		to = 20,
		from = 1
	},
	vfx_mecanicas_destroy_house_run = {
		prefix = "vfx_mecanicas_destroy_house",
		to = 25,
		from = 1
	},
	stage33_casa1_pescadores_door_open = {
		prefix = "stage33_casa1_pescadores_door",
		to = 10,
		from = 1
	},
	stage33_casa1_pescadores_door_close = {
		prefix = "stage33_casa1_pescadores_door",
		to = 20,
		from = 11
	},
	stage33_casa1_pescadores_base_idle = {
		prefix = "stage33_casa1_pescadores_base",
		to = 1,
		from = 1
	},
	stage33_casa2_pescadores_door_open = {
		prefix = "stage33_casa2_pescadores_door",
		to = 20,
		from = 1
	},
	stage33_casa2_pescadores_door_close = {
		prefix = "stage33_casa2_pescadores_door",
		to = 40,
		from = 21
	},
	stage33_casa2_pescadores_base_idle = {
		prefix = "stage33_casa2_pescadores_base",
		to = 2,
		from = 1
	},
	stage_33_barco_call_tambor_in = {
		prefix = "stage_33_barco_call_tambor",
		to = 120,
		from = 1
	},
	stage_33_barco_call_tambor_loop = {
		prefix = "stage_33_barco_call_tambor",
		to = 144,
		from = 121
	},
	stage_33_barco_call_tambor_out = {
		prefix = "stage_33_barco_call_tambor",
		to = 226,
		from = 145
	},
	stage_33_barco_call_tambor_idle_tambor = {
		prefix = "stage_33_barco_call_tambor",
		to = 227,
		from = 227
	},
	stage_33_barco_call_body_in = {
		prefix = "stage_33_barco_call_body",
		to = 120,
		from = 1
	},
	stage_33_barco_call_body_loop = {
		prefix = "stage_33_barco_call_body",
		to = 144,
		from = 121
	},
	stage_33_barco_call_body_out = {
		prefix = "stage_33_barco_call_body",
		to = 226,
		from = 145
	},
	stage_33_barco_call_body_idle_tambor = {
		prefix = "stage_33_barco_call_body",
		to = 227,
		from = 227
	},
	holder_elemental_33_teleport_teleport_fx_idle = {
		prefix = "holder_elemental_33_teleport_teleport_fx",
		to = 10,
		from = 1
	},
	holder_elemental_33_teleport_teleport_fx_big_idle = {
		prefix = "holder_elemental_33_teleport_teleport_fx_big",
		to = 10,
		from = 1
	},
	envelops_portraits_veznan = {
		prefix = "envelops_portraits",
		to = 56,
		from = 1
	},
	envelops_portraits_versper = {
		prefix = "envelops_portraits",
		to = 112,
		from = 57
	},
	envelops_portraits_nyru = {
		prefix = "envelops_portraits",
		to = 168,
		from = 113
	},
	envelops_portraits_balatro = {
		prefix = "envelops_portraits",
		to = 224,
		from = 169
	},
	envelops_money_run = {
		prefix = "envelops_money",
		to = 34,
		from = 1
	},
	envelops_open_run = {
		prefix = "envelops_open",
		to = 24,
		from = 1
	},
	envelops_decoy_1_in = {
		prefix = "envelops_decoy_1",
		to = 32,
		from = 1
	},
	envelops_decoy_1_idle = {
		prefix = "envelops_decoy_1",
		to = 82,
		from = 33
	},
	envelops_decoy_1_out = {
		prefix = "envelops_decoy_1",
		to = 100,
		from = 83
	},
	envelops_decoy_1_click = {
		prefix = "envelops_decoy_1",
		to = 118,
		from = 101
	},
	envelops_envelop_water_in = {
		prefix = "envelops_envelop_water",
		to = 14,
		from = 1
	},
	envelops_envelop_water_idle = {
		prefix = "envelops_envelop_water",
		to = 62,
		from = 15
	},
	envelops_envelop_water_out = {
		prefix = "envelops_envelop_water",
		to = 76,
		from = 63
	},
	envelops_envelop_showup = {
		prefix = "envelops_envelop",
		to = 24,
		from = 1
	},
	envelops_envelop_idle = {
		prefix = "envelops_envelop",
		to = 87,
		from = 25
	},
	envelops_envelop_out = {
		prefix = "envelops_envelop",
		to = 103,
		from = 88
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage33_decos.lua

-- BEGIN kr3/data/animations/stage34_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/stage34_decos.lua

local a = {
	stage_34_cascadas_1_run = {
		prefix = "stage_34_cascadas_1",
		to = 8,
		from = 1
	},
	stage_34_cascadas_2_run = {
		prefix = "stage_34_cascadas_2",
		to = 8,
		from = 1
	},
	stage_34_cascadas_3_run = {
		prefix = "stage_34_cascadas_3",
		to = 8,
		from = 1
	},
	stage_34_cascadas_6_run = {
		prefix = "stage_34_cascadas_6",
		to = 8,
		from = 1
	},
	golem_holder_hit_hit = {
		prefix = "golem_holder_hit",
		to = 5,
		from = 1
	},
	golem_holder_creep_idle = {
		prefix = "golem_holder_creep",
		to = 22,
		from = 1
	},
	golem_holder_creep_raise = {
		prefix = "golem_holder_creep",
		to = 60,
		from = 23
	},
	golem_holder_creep_walk = {
		prefix = "golem_holder_creep",
		to = 90,
		from = 61
	},
	golem_holder_creep_hit1 = {
		prefix = "golem_holder_creep",
		to = 122,
		from = 91
	},
	golem_holder_creep_death = {
		prefix = "golem_holder_creep",
		to = 168,
		from = 123
	},
	wkstatue_sixear_idle = {
		prefix = "wkstatue_sixear",
		to = 1,
		from = 1
	},
	wkstatue_sixear_click_1 = {
		prefix = "wkstatue_sixear",
		to = 30,
		from = 2
	},
	wkstatue_sixear_click_2 = {
		prefix = "wkstatue_sixear",
		to = 68,
		from = 31
	},
	wkstatue_sixear_idle_click2 = {
		prefix = "wkstatue_sixear",
		to = 69,
		from = 69
	},
	wkstatue_sixear_click_3 = {
		prefix = "wkstatue_sixear",
		to = 153,
		from = 70
	},
	stage_34_barro_splash_in = {
		prefix = "stage_34_barro_splash",
		to = 19,
		from = 1
	},
	stage_34_agua_splash_in = {
		prefix = "stage_34_agua_splash",
		to = 19,
		from = 1
	},
	boss_princess_iron_fan_vfx_hit = {
		prefix = "boss_princess_iron_fan_vfx_hit",
		to = 8,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_particle_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_particle",
		to = 36,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_loop",
		to = 10,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_loop_copy_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_loop_copy",
		to = 10,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_loop_shadow_hero = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_loop_shadow",
		to = 1,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_loop_shadow_death = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_loop_shadow",
		to = 2,
		from = 2
	},
	boss_princess_iron_fan_vfx_stun_hero_in_capture = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero",
		to = 39,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_decal_3_in = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_decal_3",
		to = 26,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_decal_3_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_decal_3",
		to = 27,
		from = 27
	},
	boss_princess_iron_fan_vfx_stun_hero_decal_2_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_decal_2",
		to = 42,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_decal_in = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_decal",
		to = 26,
		from = 1
	},
	boss_princess_iron_fan_vfx_stun_hero_decal_loop = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_decal",
		to = 27,
		from = 27
	},
	boss_princess_iron_fan_vfx_stun_hero_dragon_in_capture = {
		prefix = "boss_princess_iron_fan_vfx_stun_hero_dragon",
		to = 31,
		from = 1
	},
	boss_princess_iron_fan_vfx_projectile_explosion_run = {
		prefix = "boss_princess_iron_fan_vfx_projectile_explosion",
		to = 28,
		from = 1
	},
	boss_princess_iron_fan_vfx_proyectile_run = {
		prefix = "boss_princess_iron_fan_vfx_proyectile",
		to = 21,
		from = 1
	},
	boss_princess_iron_fan_vfx_fx_area_attack = {
		prefix = "boss_princess_iron_fan_vfx_fx_area_attack",
		to = 24,
		from = 1
	},
	boss_princess_iron_fan_vfx_torre_door_idle_door_on = {
		prefix = "boss_princess_iron_fan_vfx_torre_door",
		to = 2,
		from = 1
	},
	boss_princess_iron_fan_vfx_torre_door_door_open = {
		prefix = "boss_princess_iron_fan_vfx_torre_door",
		to = 36,
		from = 3
	},
	boss_princess_iron_fan_vfx_torre_fachada_tower_in = {
		prefix = "boss_princess_iron_fan_vfx_torre_fachada",
		to = 20,
		from = 1
	},
	boss_princess_iron_fan_vfx_torre_fachada_idle_door_on = {
		prefix = "boss_princess_iron_fan_vfx_torre_fachada",
		to = 22,
		from = 21
	},
	boss_princess_iron_fan_vfx_torre_fachada_door_open = {
		prefix = "boss_princess_iron_fan_vfx_torre_fachada",
		to = 55,
		from = 23
	},
	boss_princess_iron_fan_vfx_torre_fachada_idle_door_off = {
		prefix = "boss_princess_iron_fan_vfx_torre_fachada",
		to = 57,
		from = 56
	},
	boss_princess_iron_fan_vfx_torre_fachada_tower_out = {
		prefix = "boss_princess_iron_fan_vfx_torre_fachada",
		to = 102,
		from = 58
	},
	boss_princess_iron_fan_vfx_torre_floor_run = {
		prefix = "boss_princess_iron_fan_vfx_torre_floor",
		to = 2,
		from = 1
	},
	boss_princess_iron_fan_vfx_torre_fx_externos_delante_run = {
		prefix = "boss_princess_iron_fan_vfx_torre_fx_externos_delante",
		to = 95,
		from = 1
	},
	boss_princess_iron_fan_vfx_torre_fx_externos_delante_tower_in = {
		prefix = "boss_princess_iron_fan_vfx_torre_fx_externos_delante",
		to = 127,
		from = 96
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage34_decos.lua

-- BEGIN kr3/data/animations/stage35_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/stage35_decos.lua

local a = {
	sate_5_mono_unit_idle = {
		prefix = "sate_5_mono_unit",
		to = 1,
		from = 1
	},
	sate_5_mono_unit_walk = {
		prefix = "sate_5_mono_unit",
		to = 21,
		from = 2
	},
	sate_5_mono_unit_attack_melee = {
		prefix = "sate_5_mono_unit",
		to = 51,
		from = 22
	},
	sate_5_mono_unit_death = {
		prefix = "sate_5_mono_unit",
		to = 77,
		from = 52
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage35_decos.lua

-- BEGIN kr3/data/animations/stage3_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage3_decos.lua

local a = {
	stage3_decos_barriles2_idle = {
		prefix = "stage3_decos_barriles2",
		to = 1,
		from = 1
	},
	stage3_decos_barriles2_action = {
		prefix = "stage3_decos_barriles2",
		to = 166,
		from = 2
	},
	stage3_decos_gordito_idle = {
		prefix = "stage3_decos_gordito",
		to = 1,
		from = 1
	},
	stage3_decos_gordito_comer = {
		prefix = "stage3_decos_gordito",
		to = 101,
		from = 2
	},
	stage3_decos_gordito_muerte = {
		prefix = "stage3_decos_gordito",
		to = 234,
		from = 102
	},
	stage3_decos_barriles1_action = {
		prefix = "stage3_decos_barriles1",
		to = 184,
		from = 1
	},
	stage3_decos_barriles1_idle = {
		prefix = "stage3_decos_barriles1",
		to = 185,
		from = 185
	},
	stage_3_decos_REF_elder_rune_3_idle = {
		prefix = "stage_3_decos_REF_elder_rune_3",
		to = 66,
		from = 1
	},
	stage_3_decos_REF_elder_rune_3_activation = {
		prefix = "stage_3_decos_REF_elder_rune_3",
		to = 88,
		from = 67
	},
	stage_3_decos_REF_elder_rune_3_idle_2 = {
		prefix = "stage_3_decos_REF_elder_rune_3",
		to = 115,
		from = 96
	},
	stage_3_HeartProy_trail = {
		prefix = "stage_3_HeartProy_trail",
		to = 5,
		from = 1
	},
	stage_3_HeartProy_glow_run = {
		prefix = "stage_3_HeartProy_glow",
		to = 1,
		from = 1
	},
	stage_3_HeartProy_proyectile_run = {
		prefix = "stage_3_HeartProy_proyectile",
		to = 30,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage3_decos.lua

-- BEGIN kr3/data/animations/stage4_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage4_decos.lua

local a = {
	anim_puente1_action1 = {
		prefix = "anim_puente1",
		to = 121,
		from = 1
	},
	anim_puente1_idle = {
		prefix = "anim_puente1",
		to = 122,
		from = 122
	},
	anim_puente1_action2 = {
		prefix = "anim_puente1",
		to = 272,
		from = 123
	},
	anim_puente2_action1 = {
		prefix = "anim_puente2",
		to = 116,
		from = 1
	},
	anim_puente2_idle = {
		prefix = "anim_puente2",
		to = 117,
		from = 117
	},
	anim_puente2_action2 = {
		prefix = "anim_puente2",
		to = 237,
		from = 118
	},
	anim_puente3_action1 = {
		prefix = "anim_puente3",
		to = 138,
		from = 1
	},
	anim_puente3_idle = {
		prefix = "anim_puente3",
		to = 139,
		from = 139
	},
	anim_puente3_action2 = {
		prefix = "anim_puente3",
		to = 319,
		from = 140
	},
	anim_puente3_action3 = {
		prefix = "anim_puente3",
		to = 409,
		from = 320
	},
	stage_4_elder_rune_4_fx_idle = {
		prefix = "stage_4_elder_rune_4_fx",
		to = 66,
		from = 1
	},
	stage_4_elder_rune_4_fx_activation = {
		prefix = "stage_4_elder_rune_4_fx",
		to = 92,
		from = 67
	},
	stage_4_elder_rune_4_fx_idle_2 = {
		prefix = "stage_4_elder_rune_4_fx",
		to = 119,
		from = 93
	},
	stage_4_elder_rune_4_idle = {
		prefix = "stage_4_elder_rune_4",
		to = 66,
		from = 1
	},
	stage_4_elder_rune_4_activation = {
		prefix = "stage_4_elder_rune_4",
		to = 118,
		from = 67
	},
	stage_4_elder_rune_4_idle_2 = {
		prefix = "stage_4_elder_rune_4",
		to = 119,
		from = 119
	},
	stage_4_arboreans_arborean_01_walk = {
		prefix = "stage_4_arboreans_arborean_01",
		to = 12,
		from = 1
	},
	stage_4_arboreans_arborean_01_tap = {
		prefix = "stage_4_arboreans_arborean_01",
		to = 13,
		from = 13
	},
	stage_4_arboreans_arborean_02_walk = {
		prefix = "stage_4_arboreans_arborean_02",
		to = 12,
		from = 1
	},
	stage_4_arboreans_arborean_02_tap = {
		prefix = "stage_4_arboreans_arborean_02",
		to = 13,
		from = 13
	},
	stage_4_arboreans_arborean_03_walk = {
		prefix = "stage_4_arboreans_arborean_03",
		to = 24,
		from = 1
	},
	stage_4_arboreans_arborean_03_tap = {
		prefix = "stage_4_arboreans_arborean_03",
		to = 25,
		from = 25
	},
	stage_4_arboreans_arborean_04_walk = {
		prefix = "stage_4_arboreans_arborean_04",
		to = 16,
		from = 1
	},
	stage_4_arboreans_arborean_04_tap = {
		prefix = "stage_4_arboreans_arborean_04",
		to = 17,
		from = 17
	},
	sheepy_stage4_old_arborean_idle = {
		prefix = "sheepy_stage4_old_arborean",
		to = 1,
		from = 1
	},
	sheepy_stage4_old_arborean_talk = {
		prefix = "sheepy_stage4_old_arborean",
		to = 59,
		from = 2
	},
	sheepy_stage4_sheepy_idle = {
		prefix = "sheepy_stage4_sheepy",
		to = 1,
		from = 1
	},
	sheepy_stage4_sheepy_annotation = {
		prefix = "sheepy_stage4_sheepy",
		to = 59,
		from = 2
	},
	sheepy_stage4_sheepy_fall = {
		prefix = "sheepy_stage4_sheepy",
		to = 75,
		from = 60
	},
	sheepy_stage4_sheepy_idle_fallen = {
		prefix = "sheepy_stage4_sheepy",
		to = 84,
		from = 76
	},
	sheepy_stage4_baby_fall_loop = {
		prefix = "sheepy_stage4_baby",
		to = 9,
		from = 1
	},
	sheepy_stage4_baby_fall = {
		prefix = "sheepy_stage4_baby",
		to = 38,
		from = 10
	},
	sheepy_stage4_baby_sit = {
		prefix = "sheepy_stage4_baby",
		to = 39,
		from = 39
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage4_decos.lua

-- BEGIN kr3/data/animations/stage4_decos2.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage4_decos2.lua

local a = {
	anim_liana_idle1 = {
		prefix = "anim_liana",
		to = 1,
		from = 1
	},
	anim_liana_down = {
		prefix = "anim_liana",
		to = 34,
		from = 2
	},
	anim_liana_idle2 = {
		prefix = "anim_liana",
		to = 42,
		from = 35
	},
	anim_liana_tap = {
		prefix = "anim_liana",
		to = 138,
		from = 43
	},
	anim_liana_no_tap = {
		prefix = "anim_liana",
		to = 160,
		from = 139
	},
	anim_waterfall_idle = {
		prefix = "anim_waterfall",
		to = 9,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage4_decos2.lua

-- BEGIN kr3/data/animations/stage6_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage6_decos.lua

local a = {
	werebeast_boss_boss_layerX_idle = {
		layer_to = 4,
		from = 1,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 1,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_walk1_1 = {
		layer_to = 4,
		from = 2,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 31,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_walk1_2 = {
		layer_to = 4,
		from = 32,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 61,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_attack = {
		layer_to = 4,
		from = 62,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 87,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability2_1 = {
		layer_to = 4,
		from = 88,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 134,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_shadow_ability_2_1 = {
		layer_to = 4,
		from = 135,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 136,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_shadow_ability_3_1 = {
		layer_to = 4,
		from = 137,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 138,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability3_1 = {
		layer_to = 4,
		from = 139,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 187,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_death = {
		layer_to = 4,
		from = 188,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 260,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_idle2_1 = {
		layer_to = 4,
		from = 261,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 261,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_to_ability4_1 = {
		layer_to = 4,
		from = 262,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 330,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability4_1 = {
		layer_to = 4,
		from = 331,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 409,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_to_idle2_1 = {
		layer_to = 4,
		from = 410,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 460,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability5_1 = {
		layer_to = 4,
		from = 461,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 547,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability6_1 = {
		layer_to = 4,
		from = 548,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 641,
		layer_from = 1
	},
	werebeast_boss_boss_layerX_ability7_1 = {
		layer_to = 4,
		from = 642,
		layer_prefix = "werebeast_boss_boss_layer%i",
		to = 672,
		layer_from = 1
	},
	werebeast_boss_attack_and_fall_decal_run = {
		prefix = "werebeast_boss_attack_and_fall_decal",
		to = 32,
		from = 1
	},
	werebeast_boss_death_and_fall_dust_run = {
		prefix = "werebeast_boss_death_and_fall_dust",
		to = 13,
		from = 1
	},
	werebeast_boss_jump_proyectile = {
		prefix = "werebeast_boss_jump_proyectile",
		to = 1,
		from = 1
	},
	werebeast_boss_attack_dust = {
		prefix = "werebeast_boss_attack_dust",
		to = 16,
		from = 1
	},
	stage_6_madriguera_idle = {
		prefix = "stage_6_madriguera",
		to = 1,
		from = 1
	},
	stage_6_madriguera_ability1_1 = {
		prefix = "stage_6_madriguera",
		to = 20,
		from = 2
	},
	stage_6_madriguera_ability2_1 = {
		prefix = "stage_6_madriguera",
		to = 44,
		from = 21
	},
	stage_6_madriguera_idle_2 = {
		prefix = "stage_6_madriguera",
		to = 45,
		from = 45
	},
	stage_6_ascensor_jabali_ability1_1 = {
		prefix = "stage_6_ascensor_jabali",
		to = 16,
		from = 1
	},
	stage_6_ascensor_jabali_ability2_1 = {
		prefix = "stage_6_ascensor_jabali",
		to = 20,
		from = 17
	},
	stage_6_ascensor_jabali_death1_1 = {
		prefix = "stage_6_ascensor_jabali",
		to = 53,
		from = 21
	},
	stage_6_ascensor_ascensor_layerX_idle1_1 = {
		layer_to = 4,
		from = 1,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 1,
		layer_from = 1
	},
	stage_6_ascensor_ascensor_layerX_ability1_1 = {
		layer_to = 4,
		from = 2,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 17,
		layer_from = 1
	},
	stage_6_ascensor_ascensor_layerX_ability2_1 = {
		layer_to = 4,
		from = 18,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 21,
		layer_from = 1
	},
	stage_6_ascensor_ascensor_layerX_ability3_1 = {
		layer_to = 4,
		from = 22,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 23,
		layer_from = 1
	},
	stage_6_ascensor_ascensor_layerX_ability4_1 = {
		layer_to = 4,
		from = 24,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 27,
		layer_from = 1
	},
	stage_6_ascensor_ascensor_layerX_ability5_1 = {
		layer_to = 4,
		from = 28,
		layer_prefix = "stage_6_ascensor_ascensor_layer%i",
		to = 31,
		layer_from = 1
	},
	cult_leader_idle = {
		prefix = "cult_leader",
		to = 1,
		from = 1
	},
	cult_leader_walkingRightLeft = {
		prefix = "cult_leader",
		to = 21,
		from = 2
	},
	werebeast_boss_cultist_smoke_cultist_boss_smoke = {
		prefix = "werebeast_boss_cultist_smoke_cultist_boss_smoke",
		to = 19,
		from = 1
	},
	minecraft_easter_egg_idle = {
		prefix = "minecraft_easter_egg",
		to = 1,
		from = 1
	},
	minecraft_easter_egg_attack = {
		prefix = "minecraft_easter_egg",
		to = 28,
		from = 2
	},
	minecraft_easter_egg_death = {
		prefix = "minecraft_easter_egg",
		to = 151,
		from = 29
	},
	stage_6_elder_rune_6_idle = {
		prefix = "stage_6_elder_rune_6",
		to = 66,
		from = 1
	},
	stage_6_elder_rune_6_activation = {
		prefix = "stage_6_elder_rune_6",
		to = 98,
		from = 67
	},
	stage_6_elder_rune_6_idle_2 = {
		prefix = "stage_6_elder_rune_6",
		to = 125,
		from = 99
	},
	mydrias_cinematic_cinematicspawn = {
		prefix = "mydrias_cinematic",
		to = 26,
		from = 1
	},
	mydrias_cinematic_idle = {
		prefix = "mydrias_cinematic",
		to = 34,
		from = 27
	},
	mydrias_cinematic_cinematicdespawn = {
		prefix = "mydrias_cinematic",
		to = 71,
		from = 35
	},
	stage_6_madriguera_open = {
		prefix = "stage_6_madriguera",
		to = 44,
		from = 44
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage6_decos.lua

-- BEGIN kr3/data/animations/stage_2_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage_2_decos.lua

local a = {
	stage2_decos_viejo_idle1 = {
		prefix = "stage2_decos_viejo",
		to = 1,
		from = 1
	},
	stage2_decos_viejo_idle2 = {
		prefix = "stage2_decos_viejo",
		to = 9,
		from = 2
	},
	stage2_decos_viejo_action1 = {
		prefix = "stage2_decos_viejo",
		to = 65,
		from = 10
	},
	stage2_decos_bebe1_idle1 = {
		prefix = "stage2_decos_bebe1",
		to = 1,
		from = 1
	},
	stage2_decos_bebe1_action1 = {
		prefix = "stage2_decos_bebe1",
		to = 49,
		from = 2
	},
	stage2_decos_bebe1_idle2 = {
		prefix = "stage2_decos_bebe1",
		to = 94,
		from = 50
	},
	stage2_decos_bebe1_action2 = {
		prefix = "stage2_decos_bebe1",
		to = 130,
		from = 95
	},
	stage_2_rapido_elder_rune_2_fx_idle = {
		prefix = "stage_2_rapido_elder_rune_2_fx",
		to = 66,
		from = 1
	},
	stage_2_rapido_elder_rune_2_fx_activation = {
		prefix = "stage_2_rapido_elder_rune_2_fx",
		to = 90,
		from = 67
	},
	stage_2_rapido_elder_rune_2_fx_idle_2 = {
		prefix = "stage_2_rapido_elder_rune_2_fx",
		to = 117,
		from = 91
	},
	fishing_link_idle = {
		prefix = "fishing_link",
		to = 1,
		from = 1
	},
	fishing_link_fishing_fish_or_boot = {
		prefix = "fishing_link",
		to = 121,
		from = 2
	},
	fishing_link_fishing_nothing = {
		prefix = "fishing_link",
		to = 216,
		from = 122
	},
	fishing_link_rupees_notice_in = {
		prefix = "fishing_link",
		to = 264,
		from = 217
	},
	fishing_link_rupees_notice_loop = {
		prefix = "fishing_link",
		to = 272,
		from = 265
	},
	fishing_link_rupees_notice_clicked = {
		prefix = "fishing_link",
		to = 334,
		from = 273
	},
	fishing_link_rupees_notice_out = {
		prefix = "fishing_link",
		to = 351,
		from = 335
	},
	water_splash_splash_out = {
		prefix = "water_splash",
		to = 34,
		from = 1
	},
	water_splash_splash_in = {
		prefix = "water_splash",
		to = 45,
		from = 35
	},
	water_splash_idle = {
		prefix = "water_splash",
		to = 62,
		from = 46
	},
	fishing_link_line_idle = {
		prefix = "fishing_link_line",
		to = 1,
		from = 1
	},
	fishing_link_line_fishing_rupee_in = {
		prefix = "fishing_link_line",
		to = 49,
		from = 2
	},
	fishing_link_line_fishing_rupee_loop = {
		prefix = "fishing_link_line",
		to = 57,
		from = 50
	},
	fishing_link_line_fishing_rupee_clicked = {
		prefix = "fishing_link_line",
		to = 121,
		from = 58
	},
	fishing_link_line_fishing_rupee_out = {
		prefix = "fishing_link_line",
		to = 142,
		from = 122
	},
	fishing_link_line_fishing_fish = {
		prefix = "fishing_link_line",
		to = 264,
		from = 143
	},
	fishing_link_line_fishing_boot = {
		prefix = "fishing_link_line",
		to = 360,
		from = 265
	},
	fishing_link_line_fishing_nothing = {
		prefix = "fishing_link_line",
		to = 456,
		from = 361
	},
	light_copy = {
		prefix = "light_copy",
		to = 1,
		from = 1
	},
	lion_king_easter_egg_layerX_idle = {
		layer_to = 4,
		from = 1,
		layer_prefix = "lion_king_easter_egg_layer%i",
		to = 44,
		layer_from = 1
	},
	lion_king_easter_egg_layerX_action = {
		layer_to = 4,
		from = 45,
		layer_prefix = "lion_king_easter_egg_layer%i",
		to = 190,
		layer_from = 1
	},
	veznan_cinematic_veznan_idle = {
		prefix = "veznan_cinematic_veznan",
		to = 1,
		from = 1
	},
	veznan_cinematic_veznan_in = {
		prefix = "veznan_cinematic_veznan",
		to = 97,
		from = 2
	},
	veznan_cinematic_veznan_loopIn = {
		prefix = "veznan_cinematic_veznan",
		to = 109,
		from = 98
	},
	veznan_cinematic_veznan_loop = {
		prefix = "veznan_cinematic_veznan",
		to = 123,
		from = 110
	},
	veznan_cinematic_veznan_loopEnd = {
		prefix = "veznan_cinematic_veznan",
		to = 133,
		from = 124
	},
	veznan_cinematic_veznan_out = {
		prefix = "veznan_cinematic_veznan",
		to = 167,
		from = 134
	},
	lion_king_easter_egg_layerX_idle = {
		layer_to = 4,
		from = 1,
		layer_prefix = "lion_king_easter_egg_layer%i",
		to = 1,
		layer_from = 1
	},
	lion_king_easter_egg_layerX_stick = {
		layer_to = 4,
		from = 1,
		layer_prefix = "lion_king_easter_egg_layer%i",
		to = 44,
		layer_from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage_2_decos.lua

-- BEGIN kr3/data/animations/stage_2_props.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage_2_props.lua

local a = {
	stage_2_props_wisp = {
		prefix = "stage_2_props_wisp",
		to = 84,
		from = 1
	},
	stage_2_props_waterfall_splash = {
		prefix = "stage_2_props_waterfall_splash",
		to = 20,
		from = 1
	},
	stage_2_props_waterfall = {
		prefix = "stage_2_props_waterfall",
		to = 9,
		from = 1
	},
	stage_2_props_waves = {
		prefix = "stage_2_props_waves",
		to = 57,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage_2_props.lua

-- BEGIN kr3/data/animations/stage_6_modes.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/stage_6_modes.lua

local a = {
	stage_6_poolparty_deco_weapons = {
		prefix = "stage_6_poolparty_deco_weapons",
		to = 1,
		from = 1
	},
	stage_6_poolparty_deco_baby = {
		prefix = "stage_6_poolparty_deco_baby",
		to = 50,
		from = 1
	},
	stage_6_poolparty_deco_music_arborean_layerX_idle = {
		layer_to = 2,
		from = 1,
		layer_prefix = "stage_6_poolparty_deco_music_arborean_layer%i",
		to = 50,
		layer_from = 1
	},
	stage_6_poolparty_deco_volleyball_layerX_idle = {
		layer_to = 4,
		from = 1,
		layer_prefix = "stage_6_poolparty_deco_volleyball_layer%i",
		to = 184,
		layer_from = 1
	},
	stage_6_poolparty_deco_demon_jump_layerX_idle = {
		layer_to = 2,
		from = 1,
		layer_prefix = "stage_6_poolparty_deco_demon_jump_layer%i",
		to = 179,
		layer_from = 1
	},
	stage_6_poolparty_deco_sleeping_arborean = {
		prefix = "stage_6_poolparty_deco_sleeping_arborean",
		to = 59,
		from = 1
	},
	stage_6_poolparty_deco_demon = {
		prefix = "stage_6_poolparty_deco_demon",
		to = 49,
		from = 1
	},
	stage_6_poolparty_deco_water = {
		prefix = "stage_6_poolparty_deco_water",
		to = 1,
		from = 1
	},
	stage_06_parches_tiki_top_bebe2_Idle1 = {
		prefix = "stage_06_parches_tiki_top_bebe2",
		to = 1,
		from = 1
	},
	stage_06_parches_tiki_top_bebe2_Idle2 = {
		prefix = "stage_06_parches_tiki_top_bebe2",
		to = 60,
		from = 2
	},
	stage_06_parches_tiki_top_viejo = {
		prefix = "stage_06_parches_tiki_top_viejo",
		to = 17,
		from = 1
	},
	stage_06_parches_tiki_top_bebe1_idle1 = {
		prefix = "stage_06_parches_tiki_top_bebe1",
		to = 1,
		from = 1
	},
	stage_06_parches_tiki_top_bebe1_idle2 = {
		prefix = "stage_06_parches_tiki_top_bebe1",
		to = 60,
		from = 2
	},
	stage_06_parches_tiki_top = {
		prefix = "stage_06_parches_tiki_top",
		to = 1,
		from = 1
	},
	stage_06_parches_tiki_top_pibe_Idle = {
		prefix = "stage_06_parches_tiki_top_pibe",
		to = 1,
		from = 1
	},
	stage_06_parches_tiki_top_pibe_action = {
		prefix = "stage_06_parches_tiki_top_pibe",
		to = 76,
		from = 2
	},
	stage_06_parches_tiki_bottom = {
		prefix = "stage_06_parches_tiki_bottom",
		to = 1,
		from = 1
	},
	stage_06_parches_espada = {
		prefix = "stage_06_parches_espada",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/stage_6_modes.lua

-- BEGIN kr3/data/animations/storm_elemental.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/storm_elemental.lua

local a = {
	storm_elemental_vfx_ranged_attck_trail_run = {
		prefix = "storm_elemental_vfx_ranged_attck_trail",
		to = 10,
		from = 1
	},
	storm_elemental_vfx_walk_trail_run = {
		prefix = "storm_elemental_vfx_walk_trail",
		to = 30,
		from = 1
	},
	storm_elemental_vfx_asst_area_attack = {
		prefix = "storm_elemental_vfx_asst_area_attack",
		to = 9,
		from = 1
	},
	storm_elemental_vfx_explosion_proyectil = {
		prefix = "storm_elemental_vfx_explosion_proyectil",
		to = 28,
		from = 1
	},
	storm_elemental_vfx_explosion_proyectil_decal = {
		prefix = "storm_elemental_vfx_explosion_proyectil_decal",
		to = 57,
		from = 1
	},
	storm_elemental_vfx_proyectile_in = {
		prefix = "storm_elemental_vfx_proyectile",
		to = 27,
		from = 1
	},
	storm_elemental_vfx_proyectile_loop = {
		prefix = "storm_elemental_vfx_proyectile",
		to = 37,
		from = 28
	},
	storm_elemental_vfx_proyectile_break = {
		prefix = "storm_elemental_vfx_proyectile",
		to = 49,
		from = 38
	},
	storm_elemental_vfx_bodyfx_run = {
		prefix = "storm_elemental_vfx_bodyfx",
		to = 57,
		from = 1
	},
	storm_elemental_vfx_stun_block_tower_in = {
		prefix = "storm_elemental_vfx_stun",
		to = 8,
		from = 1
	},
	storm_elemental_vfx_stun_block_tower_loop = {
		prefix = "storm_elemental_vfx_stun",
		to = 72,
		from = 9
	},
	storm_elemental_vfx_stun_block_tower_out = {
		prefix = "storm_elemental_vfx_stun",
		to = 86,
		from = 73
	},
	storm_elemental_vfx_hit_run = {
		prefix = "storm_elemental_vfx_hit",
		to = 20,
		from = 1
	},
	storm_elemental_vfx_proyectile_fx_run = {
		prefix = "storm_elemental_vfx_proyectile_fx",
		to = 10,
		from = 1
	},
	storm_elemental_vfx_proyectile_trail_idle = {
		prefix = "storm_elemental_vfx_proyectile_trail",
		to = 10,
		from = 1
	},
	storm_elemental_storm_unit_walk = {
		prefix = "storm_elemental_storm_unit",
		to = 32,
		from = 1
	},
	storm_elemental_storm_unit_walk_down = {
		prefix = "storm_elemental_storm_unit",
		to = 64,
		from = 33
	},
	storm_elemental_storm_unit_walk_up = {
		prefix = "storm_elemental_storm_unit",
		to = 96,
		from = 65
	},
	storm_elemental_storm_unit_area_attack = {
		prefix = "storm_elemental_storm_unit",
		to = 152,
		from = 97
	},
	storm_elemental_storm_unit_ranged_attack = {
		prefix = "storm_elemental_storm_unit",
		to = 208,
		from = 153
	},
	storm_elemental_storm_unit_transform = {
		prefix = "storm_elemental_storm_unit",
		to = 270,
		from = 209
	},
	storm_elemental_storm_unit_hability_1 = {
		prefix = "storm_elemental_storm_unit",
		to = 320,
		from = 271
	},
	storm_elemental_storm_unit_hability_1_end = {
		prefix = "storm_elemental_storm_unit",
		to = 333,
		from = 321
	},
	storm_elemental_storm_unit_death = {
		prefix = "storm_elemental_storm_unit",
		to = 385,
		from = 334
	},
	storm_elemental_storm_unit_idle = {
		prefix = "storm_elemental_storm_unit",
		to = 415,
		from = 386
	},
	storm_elemental_storm_unit_raise = {
		prefix = "storm_elemental_storm_unit",
		to = 64,
		from = 33
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/storm_elemental.lua

-- BEGIN kr3/data/animations/storm_spirit.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/storm_spirit.lua

local a = {
	stormspirit_trail_run = {
		prefix = "stormspirit_trail",
		to = 12,
		from = 1
	},
	stormspirit_trail_nubes_run = {
		prefix = "stormspirit_trail_nubes",
		to = 27,
		from = 1
	},
	stormspirit_idle = {
		prefix = "stormspirit",
		to = 2,
		from = 1
	},
	stormspirit_walk = {
		prefix = "stormspirit",
		to = 92,
		from = 3
	},
	stormspirit_walk_down = {
		prefix = "stormspirit",
		to = 182,
		from = 93
	},
	stormspirit_walk_up = {
		prefix = "stormspirit",
		to = 272,
		from = 183
	},
	stormspirit_voltereta = {
		prefix = "stormspirit",
		to = 284,
		from = 273
	},
	stormspirit_zap_in_out = {
		prefix = "stormspirit",
		to = 305,
		from = 285
	},
	stormspirit_zap_loop = {
		prefix = "stormspirit",
		to = 315,
		from = 306
	},
	stormspirit_death = {
		prefix = "stormspirit",
		to = 350,
		from = 316
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/storm_spirit.lua

-- BEGIN kr3/data/animations/terracota.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/terracota.lua

local a = {
	terracota_idle = {
		prefix = "terracotta_creep",
		to = 1,
		from = 1
	},
	terracota_raise = {
		prefix = "terracotta_creep",
		to = 21,
		from = 2
	},
	terracota_walk = {
		prefix = "terracotta_creep",
		to = 45,
		from = 22
	},
	terracota_walkdown = {
		prefix = "terracotta_creep",
		to = 69,
		from = 46
	},
	terracota_walkup = {
		prefix = "terracotta_creep",
		to = 93,
		from = 70
	},
	terracota_attack = {
		prefix = "terracotta_creep",
		to = 147,
		from = 94
	},
	terracota_death = {
		prefix = "terracotta_creep",
		to = 195,
		from = 148
	},
	terracota_fx_hit_run = {
		prefix = "terracotta_fx_hit",
		to = 6,
		from = 1
	},
	terracota_fx_walk_1_run = {
		prefix = "terracotta_fx_walk_1",
		to = 18,
		from = 1
	},
	terracota_fx_walk_2_run = {
		prefix = "terracotta_fx_walk_2",
		to = 18,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/terracota.lua

-- BEGIN kr3/data/animations/terrain_3_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/terrain_3_decos.lua

local a = {
	glare_stage_14_eyelid_2_3_idle_close = {
		prefix = "glare_stage_14_eyelid_2_3",
		to = 1,
		from = 1
	},
	glare_stage_14_eyelid_2_3_open = {
		prefix = "glare_stage_14_eyelid_2_3",
		to = 6,
		from = 2
	},
	glare_stage_14_eyelid_2_3_idle_open = {
		prefix = "glare_stage_14_eyelid_2_3",
		to = 7,
		from = 7
	},
	glare_stage_14_eyelid_2_3_blink = {
		prefix = "glare_stage_14_eyelid_2_3",
		to = 17,
		from = 8
	},
	glare_stage_14_eyelid_2_3_close = {
		prefix = "glare_stage_14_eyelid_2_3",
		to = 22,
		from = 18
	},
	glare_stage_14_eyelid_2_1_idle_close = {
		prefix = "glare_stage_14_eyelid_2_1",
		to = 1,
		from = 1
	},
	glare_stage_14_eyelid_2_1_open = {
		prefix = "glare_stage_14_eyelid_2_1",
		to = 5,
		from = 2
	},
	glare_stage_14_eyelid_2_1_idle_open = {
		prefix = "glare_stage_14_eyelid_2_1",
		to = 6,
		from = 6
	},
	glare_stage_14_eyelid_2_1_blink = {
		prefix = "glare_stage_14_eyelid_2_1",
		to = 16,
		from = 7
	},
	glare_stage_14_eyelid_2_1_close = {
		prefix = "glare_stage_14_eyelid_2_1",
		to = 22,
		from = 17
	},
	glare_stage_14_eyelid_2_big_idle_close = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 1,
		from = 1
	},
	glare_stage_14_eyelid_2_big_open = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 5,
		from = 2
	},
	glare_stage_14_eyelid_2_big_idle_open = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 6,
		from = 6
	},
	glare_stage_14_eyelid_2_big_blink = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 15,
		from = 7
	},
	glare_stage_14_eyelid_2_big_close = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 21,
		from = 16
	},
	glare_stage_14_eyelid_2_big_loop = {
		prefix = "glare_stage_14_eyelid_2_big",
		to = 51,
		from = 22
	},
	glare_stage_14_eyelid_2_2_idle_close = {
		prefix = "glare_stage_14_eyelid_2_2",
		to = 1,
		from = 1
	},
	glare_stage_14_eyelid_2_2_open = {
		prefix = "glare_stage_14_eyelid_2_2",
		to = 5,
		from = 2
	},
	glare_stage_14_eyelid_2_2_idle_open = {
		prefix = "glare_stage_14_eyelid_2_2",
		to = 6,
		from = 6
	},
	glare_stage_14_eyelid_2_2_blink = {
		prefix = "glare_stage_14_eyelid_2_2",
		to = 16,
		from = 7
	},
	glare_stage_14_eyelid_2_2_close = {
		prefix = "glare_stage_14_eyelid_2_2",
		to = 22,
		from = 17
	},
	glare_stage_14_eye_2_3_idle = {
		prefix = "glare_stage_14_eye_2_3",
		to = 1,
		from = 1
	},
	glare_stage_14_eye_2_3_look = {
		prefix = "glare_stage_14_eye_2_3",
		to = 52,
		from = 2
	},
	glare_stage_14_eye_2_1_idle = {
		prefix = "glare_stage_14_eye_2_1",
		to = 1,
		from = 1
	},
	glare_stage_14_eye_2_1_look = {
		prefix = "glare_stage_14_eye_2_1",
		to = 52,
		from = 2
	},
	glare_stage_14_eye_2_big_pupil_idle = {
		prefix = "glare_stage_14_eye_2_big_pupil",
		to = 1,
		from = 1
	},
	glare_stage_14_eye_2_big_pupil_look = {
		prefix = "glare_stage_14_eye_2_big_pupil",
		to = 52,
		from = 2
	},
	glare_stage_14_eye_2_big_idle = {
		prefix = "glare_stage_14_eye_2_big",
		to = 1,
		from = 1
	},
	glare_stage_14_eye_2_2_idle = {
		prefix = "glare_stage_14_eye_2_2",
		to = 1,
		from = 1
	},
	glare_stage_14_eye_2_2_look = {
		prefix = "glare_stage_14_eye_2_2",
		to = 52,
		from = 2
	},
	glare_stage_15_eyelids_1_idle_close = {
		prefix = "glare_stage_15_eyelids_1",
		to = 1,
		from = 1
	},
	glare_stage_15_eyelids_1_open = {
		prefix = "glare_stage_15_eyelids_1",
		to = 5,
		from = 2
	},
	glare_stage_15_eyelids_1_idle_open = {
		prefix = "glare_stage_15_eyelids_1",
		to = 6,
		from = 6
	},
	glare_stage_15_eyelids_1_blink = {
		prefix = "glare_stage_15_eyelids_1",
		to = 15,
		from = 7
	},
	glare_stage_15_eyelids_1_close = {
		prefix = "glare_stage_15_eyelids_1",
		to = 21,
		from = 16
	},
	glare_stage_15_eyelids_3_idle_close = {
		prefix = "glare_stage_15_eyelids_3",
		to = 1,
		from = 1
	},
	glare_stage_15_eyelids_3_open = {
		prefix = "glare_stage_15_eyelids_3",
		to = 5,
		from = 2
	},
	glare_stage_15_eyelids_3_idle_open = {
		prefix = "glare_stage_15_eyelids_3",
		to = 6,
		from = 6
	},
	glare_stage_15_eyelids_3_blink = {
		prefix = "glare_stage_15_eyelids_3",
		to = 15,
		from = 7
	},
	glare_stage_15_eyelids_3_close = {
		prefix = "glare_stage_15_eyelids_3",
		to = 21,
		from = 16
	},
	glare_stage_15_eyes_3_idle = {
		prefix = "glare_stage_15_eyes_3",
		to = 1,
		from = 1
	},
	glare_stage_15_eyes_3_look = {
		prefix = "glare_stage_15_eyes_3",
		to = 52,
		from = 2
	},
	glare_stage_15_eyelids_big_idle_close = {
		prefix = "glare_stage_15_eyelids_big",
		to = 1,
		from = 1
	},
	glare_stage_15_eyelids_big_open = {
		prefix = "glare_stage_15_eyelids_big",
		to = 5,
		from = 2
	},
	glare_stage_15_eyelids_big_idle_open = {
		prefix = "glare_stage_15_eyelids_big",
		to = 6,
		from = 6
	},
	glare_stage_15_eyelids_big_blink = {
		prefix = "glare_stage_15_eyelids_big",
		to = 15,
		from = 7
	},
	glare_stage_15_eyelids_big_close = {
		prefix = "glare_stage_15_eyelids_big",
		to = 21,
		from = 16
	},
	glare_stage_15_eyelids_big_loop = {
		prefix = "glare_stage_15_eyelids_big",
		to = 51,
		from = 22
	},
	glare_stage_15_eyelids_2_idle_close = {
		prefix = "glare_stage_15_eyelids_2",
		to = 1,
		from = 1
	},
	glare_stage_15_eyelids_2_open = {
		prefix = "glare_stage_15_eyelids_2",
		to = 5,
		from = 2
	},
	glare_stage_15_eyelids_2_idle_open = {
		prefix = "glare_stage_15_eyelids_2",
		to = 6,
		from = 6
	},
	glare_stage_15_eyelids_2_blink = {
		prefix = "glare_stage_15_eyelids_2",
		to = 15,
		from = 7
	},
	glare_stage_15_eyelids_2_close = {
		prefix = "glare_stage_15_eyelids_2",
		to = 21,
		from = 16
	},
	glare_stage_15_eyes_1_idle = {
		prefix = "glare_stage_15_eyes_1",
		to = 1,
		from = 1
	},
	glare_stage_15_eyes_1_look = {
		prefix = "glare_stage_15_eyes_1",
		to = 52,
		from = 2
	},
	glare_stage_15_eye_big_pupil_idle = {
		prefix = "glare_stage_15_eye_big_pupil",
		to = 1,
		from = 1
	},
	glare_stage_15_eye_big_pupil_look = {
		prefix = "glare_stage_15_eye_big_pupil",
		to = 52,
		from = 2
	},
	glare_stage_15_eye_big_idle = {
		prefix = "glare_stage_15_eye_big",
		to = 1,
		from = 1
	},
	glare_stage_15_eyes_2_idle = {
		prefix = "glare_stage_15_eyes_2",
		to = 1,
		from = 1
	},
	glare_stage_15_eyes_2_look = {
		prefix = "glare_stage_15_eyes_2",
		to = 52,
		from = 2
	},
	glare_eyelids_3_idle_close = {
		prefix = "glare_eyelids_3",
		to = 1,
		from = 1
	},
	glare_eyelids_3_open = {
		prefix = "glare_eyelids_3",
		to = 6,
		from = 2
	},
	glare_eyelids_3_idle_open = {
		prefix = "glare_eyelids_3",
		to = 7,
		from = 7
	},
	glare_eyelids_3_blink = {
		prefix = "glare_eyelids_3",
		to = 17,
		from = 8
	},
	glare_eyelids_3_close = {
		prefix = "glare_eyelids_3",
		to = 22,
		from = 18
	},
	glare_eyelids_big_idle_close = {
		prefix = "glare_eyelids_big",
		to = 1,
		from = 1
	},
	glare_eyelids_big_open = {
		prefix = "glare_eyelids_big",
		to = 5,
		from = 2
	},
	glare_eyelids_big_idle_open = {
		prefix = "glare_eyelids_big",
		to = 6,
		from = 6
	},
	glare_eyelids_big_blink = {
		prefix = "glare_eyelids_big",
		to = 15,
		from = 7
	},
	glare_eyelids_big_close = {
		prefix = "glare_eyelids_big",
		to = 21,
		from = 16
	},
	glare_eyelids_big_loop = {
		prefix = "glare_eyelids_big",
		to = 51,
		from = 22
	},
	glare_eyelids_2_idle_close = {
		prefix = "glare_eyelids_2",
		to = 1,
		from = 1
	},
	glare_eyelids_2_open = {
		prefix = "glare_eyelids_2",
		to = 5,
		from = 2
	},
	glare_eyelids_2_idle_open = {
		prefix = "glare_eyelids_2",
		to = 6,
		from = 6
	},
	glare_eyelids_2_blink = {
		prefix = "glare_eyelids_2",
		to = 16,
		from = 7
	},
	glare_eyelids_2_close = {
		prefix = "glare_eyelids_2",
		to = 22,
		from = 17
	},
	glare_eyelids_1_idle_close = {
		prefix = "glare_eyelids_1",
		to = 1,
		from = 1
	},
	glare_eyelids_1_open = {
		prefix = "glare_eyelids_1",
		to = 5,
		from = 2
	},
	glare_eyelids_1_idle_open = {
		prefix = "glare_eyelids_1",
		to = 6,
		from = 6
	},
	glare_eyelids_1_blink = {
		prefix = "glare_eyelids_1",
		to = 16,
		from = 7
	},
	glare_eyelids_1_close = {
		prefix = "glare_eyelids_1",
		to = 22,
		from = 17
	},
	glare_eyes_3_idle = {
		prefix = "glare_eyes_3",
		to = 1,
		from = 1
	},
	glare_eyes_3_look = {
		prefix = "glare_eyes_3",
		to = 52,
		from = 2
	},
	glare_eye_big_pupil_idle = {
		prefix = "glare_eye_big_pupil",
		to = 1,
		from = 1
	},
	glare_eye_big_pupil_look = {
		prefix = "glare_eye_big_pupil",
		to = 52,
		from = 2
	},
	glare_eye_big_idle = {
		prefix = "glare_eye_big",
		to = 1,
		from = 1
	},
	glare_eyes_2_idle = {
		prefix = "glare_eyes_2",
		to = 1,
		from = 1
	},
	glare_eyes_2_look = {
		prefix = "glare_eyes_2",
		to = 52,
		from = 2
	},
	glare_eyes_1_idle = {
		prefix = "glare_eyes_1",
		to = 1,
		from = 1
	},
	glare_eyes_1_look = {
		prefix = "glare_eyes_1",
		to = 52,
		from = 2
	},
	glare_stage_16_eyelids_3_idle_close = {
		prefix = "glare_stage_16_eyelids_3",
		to = 1,
		from = 1
	},
	glare_stage_16_eyelids_3_open = {
		prefix = "glare_stage_16_eyelids_3",
		to = 5,
		from = 2
	},
	glare_stage_16_eyelids_3_idle_open = {
		prefix = "glare_stage_16_eyelids_3",
		to = 6,
		from = 6
	},
	glare_stage_16_eyelids_3_blink = {
		prefix = "glare_stage_16_eyelids_3",
		to = 15,
		from = 7
	},
	glare_stage_16_eyelids_3_close = {
		prefix = "glare_stage_16_eyelids_3",
		to = 21,
		from = 16
	},
	glare_stage_16_eyes_3_idle = {
		prefix = "glare_stage_16_eyes_3",
		to = 1,
		from = 1
	},
	glare_stage_16_eyes_3_look = {
		prefix = "glare_stage_16_eyes_3",
		to = 52,
		from = 2
	},
	glare_stage_16_eyelids_2_idle_close = {
		prefix = "glare_stage_16_eyelids_2",
		to = 1,
		from = 1
	},
	glare_stage_16_eyelids_2_open = {
		prefix = "glare_stage_16_eyelids_2",
		to = 5,
		from = 2
	},
	glare_stage_16_eyelids_2_idle_open = {
		prefix = "glare_stage_16_eyelids_2",
		to = 6,
		from = 6
	},
	glare_stage_16_eyelids_2_blink = {
		prefix = "glare_stage_16_eyelids_2",
		to = 15,
		from = 7
	},
	glare_stage_16_eyelids_2_close = {
		prefix = "glare_stage_16_eyelids_2",
		to = 21,
		from = 16
	},
	glare_stage_16_eyes_2_idle = {
		prefix = "glare_stage_16_eyes_2",
		to = 1,
		from = 1
	},
	glare_stage_16_eyes_2_look = {
		prefix = "glare_stage_16_eyes_2",
		to = 52,
		from = 2
	},
	glare_stage_16_eyelids_big_idle_close = {
		prefix = "glare_stage_16_eyelids_big",
		to = 1,
		from = 1
	},
	glare_stage_16_eyelids_big_open = {
		prefix = "glare_stage_16_eyelids_big",
		to = 5,
		from = 2
	},
	glare_stage_16_eyelids_big_idle_open = {
		prefix = "glare_stage_16_eyelids_big",
		to = 6,
		from = 6
	},
	glare_stage_16_eyelids_big_blink = {
		prefix = "glare_stage_16_eyelids_big",
		to = 15,
		from = 7
	},
	glare_stage_16_eyelids_big_close = {
		prefix = "glare_stage_16_eyelids_big",
		to = 21,
		from = 16
	},
	glare_stage_16_eyelids_big_loop = {
		prefix = "glare_stage_16_eyelids_big",
		to = 51,
		from = 22
	},
	glare_stage_16_eye_big_pupil_idle = {
		prefix = "glare_stage_16_eye_big_pupil",
		to = 1,
		from = 1
	},
	glare_stage_16_eye_big_pupil_look = {
		prefix = "glare_stage_16_eye_big_pupil",
		to = 52,
		from = 2
	},
	glare_stage_16_eye_big_idle = {
		prefix = "glare_stage_16_eye_big",
		to = 1,
		from = 1
	},
	glare_stage_16_eyelids_1_idle_close = {
		prefix = "glare_stage_16_eyelids_1",
		to = 1,
		from = 1
	},
	glare_stage_16_eyelids_1_open = {
		prefix = "glare_stage_16_eyelids_1",
		to = 5,
		from = 2
	},
	glare_stage_16_eyelids_1_idle_open = {
		prefix = "glare_stage_16_eyelids_1",
		to = 6,
		from = 6
	},
	glare_stage_16_eyelids_1_blink = {
		prefix = "glare_stage_16_eyelids_1",
		to = 15,
		from = 7
	},
	glare_stage_16_eyelids_1_close = {
		prefix = "glare_stage_16_eyelids_1",
		to = 21,
		from = 16
	},
	glare_stage_16_eyes_1_idle = {
		prefix = "glare_stage_16_eyes_1",
		to = 1,
		from = 1
	},
	glare_stage_16_eyes_1_look = {
		prefix = "glare_stage_16_eyes_1",
		to = 52,
		from = 2
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/terrain_3_decos.lua

-- BEGIN kr3/data/animations/terrain_4_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/terrain_4_decos.lua

local a = {
	cheshire_cat_easter_egg_cat_in = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 36,
		from = 1
	},
	cheshire_cat_easter_egg_cat_idle = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 37,
		from = 37
	},
	cheshire_cat_easter_egg_cat_out = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 73,
		from = 38
	},
	cheshire_cat_easter_egg_cat_action_1 = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 136,
		from = 74
	},
	cheshire_cat_easter_egg_cat_action_2 = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 218,
		from = 137
	},
	cheshire_cat_easter_egg_cat_action_3 = {
		prefix = "cheshire_cat_easter_egg_cat",
		to = 316,
		from = 219
	},
	UpdateHalloween_terrain_anim_idle_blocked = {
		prefix = "UpdateHalloween_terrain_anim",
		to = 1,
		from = 1
	},
	UpdateHalloween_terrain_anim_out = {
		prefix = "UpdateHalloween_terrain_anim",
		to = 20,
		from = 2
	},
	UpdateHalloween_terrain_anim_idle_flag = {
		prefix = "UpdateHalloween_terrain_anim",
		to = 21,
		from = 21
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/terrain_4_decos.lua

-- BEGIN kr3/data/animations/terrain_6_decos.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/terrain_6_decos.lua

local a = {
	DLC_enanos_easter_egg_exodia_arm_idle = {
		prefix = "DLC_enanos_easter_egg_exodia_arm",
		to = 1,
		from = 1
	},
	DLC_enanos_easter_egg_exodia_arm_shine = {
		prefix = "DLC_enanos_easter_egg_exodia_arm",
		to = 23,
		from = 2
	},
	DLC_enanos_easter_egg_exodia_arm_action = {
		prefix = "DLC_enanos_easter_egg_exodia_arm",
		to = 73,
		from = 24
	},
	DLC_enanos_easter_egg_exodia_head_idle = {
		prefix = "DLC_enanos_easter_egg_exodia_head",
		to = 1,
		from = 1
	},
	DLC_enanos_easter_egg_exodia_head_shine = {
		prefix = "DLC_enanos_easter_egg_exodia_head",
		to = 21,
		from = 2
	},
	DLC_enanos_easter_egg_exodia_head_action = {
		prefix = "DLC_enanos_easter_egg_exodia_head",
		to = 70,
		from = 22
	},
	DLC_enanos_easter_egg_exodia_leg_idle = {
		prefix = "DLC_enanos_easter_egg_exodia_leg",
		to = 1,
		from = 1
	},
	DLC_enanos_easter_egg_exodia_leg_shine = {
		prefix = "DLC_enanos_easter_egg_exodia_leg",
		to = 19,
		from = 2
	},
	DLC_enanos_easter_egg_exodia_leg_action = {
		prefix = "DLC_enanos_easter_egg_exodia_leg",
		to = 68,
		from = 20
	},
	DLC_enanos_easter_egg_exodia_arm_action = {
		prefix = "DLC_enanos_easter_egg_exodia_arm",
		to = 72,
		from = 24
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/terrain_6_decos.lua

-- BEGIN kr3/data/animations/tower_ballista.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_ballista.lua

local a = {
	ballista_tower_missed_arrow_dust = {
		prefix = "ballista_tower_missed_arrow_dust",
		to = 16,
		from = 1
	},
	ballista_tower_missed_arrow = {
		prefix = "ballista_tower_missed_arrow",
		to = 6,
		from = 1
	},
	ballista_tower_missed_arrow_decal = {
		prefix = "ballista_tower_missed_arrow_decal",
		to = 1,
		from = 1
	},
	ballista_tower_bomb_fx_idle = {
		prefix = "ballista_tower_bomb_fx",
		to = 21,
		from = 1
	},
	ballista_tower_tower_construction = {
		prefix = "ballista_tower_tower_construction",
		to = 1,
		from = 1
	},
	ballista_tower_lvl123_tower_goblin_idle_1_1 = {
		prefix = "ballista_tower_lvl123_tower_goblin",
		to = 1,
		from = 1
	},
	ballista_tower_lvl123_tower_goblin_ability1 = {
		prefix = "ballista_tower_lvl123_tower_goblin",
		to = 8,
		from = 2
	},
	ballista_tower_lvl1_tower_top_idle_1_1 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 1,
		from = 1
	},
	ballista_tower_lvl1_tower_top_ability1_loop_1_1 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 9,
		from = 2
	},
	ballista_tower_lvl1_tower_top_ability1_out_1_1 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 14,
		from = 10
	},
	ballista_tower_lvl1_tower_top_idle_1_2 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 15,
		from = 15
	},
	ballista_tower_lvl1_tower_top_ability1_loop_1_2 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 23,
		from = 16
	},
	ballista_tower_lvl1_tower_top_ability1_out_1_2 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 28,
		from = 24
	},
	ballista_tower_lvl1_tower_top_idle_1_3 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 29,
		from = 29
	},
	ballista_tower_lvl1_tower_top_ability1_loop_1_3 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 37,
		from = 30
	},
	ballista_tower_lvl1_tower_top_ability1_out_1_3 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 42,
		from = 38
	},
	ballista_tower_lvl1_tower_top_idle_1_4 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 43,
		from = 43
	},
	ballista_tower_lvl1_tower_top_ability1_loop_1_4 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 51,
		from = 44
	},
	ballista_tower_lvl1_tower_top_ability1_out_1_4 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 56,
		from = 52
	},
	ballista_tower_lvl1_tower_top_idle_1_5 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 57,
		from = 57
	},
	ballista_tower_lvl1_tower_top_ability1_loop_1_5 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 65,
		from = 58
	},
	ballista_tower_lvl1_tower_top_ability1_out_1_5 = {
		prefix = "ballista_tower_lvl1_tower_top",
		to = 70,
		from = 66
	},
	ballista_tower_lvl1_tower_layerX_idle_1_1 = {
		layer_to = 3,
		from = 1,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	ballista_tower_lvl1_tower_layerX_ability1 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 9,
		layer_from = 1
	},
	ballista_tower_lvl1_tower_layerX_ability2 = {
		layer_to = 3,
		from = 10,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 17,
		layer_from = 1
	},
	ballista_tower_lvl1_tower_layerX_ability3 = {
		layer_to = 3,
		from = 18,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 25,
		layer_from = 1
	},
	ballista_tower_lvl1_tower_layerX_ability4 = {
		layer_to = 3,
		from = 26,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 33,
		layer_from = 1
	},
	ballista_tower_lvl1_tower_layerX_ability5 = {
		layer_to = 3,
		from = 34,
		layer_prefix = "ballista_tower_lvl1_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	ballista_tower_preview_idle_1_1 = {
		prefix = "ballista_tower_preview",
		to = 1,
		from = 1
	},
	ballista_tower_lvl2_tower_top_idle_1_1 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 1,
		from = 1
	},
	ballista_tower_lvl2_tower_top_ability1_loop_1_1 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 9,
		from = 2
	},
	ballista_tower_lvl2_tower_top_ability1_out_1_1 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 14,
		from = 10
	},
	ballista_tower_lvl2_tower_top_idle_1_2 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 15,
		from = 15
	},
	ballista_tower_lvl2_tower_top_ability1_loop_1_2 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 23,
		from = 16
	},
	ballista_tower_lvl2_tower_top_ability1_out_1_2 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 28,
		from = 24
	},
	ballista_tower_lvl2_tower_top_idle_1_3 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 29,
		from = 29
	},
	ballista_tower_lvl2_tower_top_ability1_loop_1_3 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 37,
		from = 30
	},
	ballista_tower_lvl2_tower_top_ability1_out_1_3 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 42,
		from = 38
	},
	ballista_tower_lvl2_tower_top_idle_1_4 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 43,
		from = 43
	},
	ballista_tower_lvl2_tower_top_ability1_loop_1_4 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 51,
		from = 44
	},
	ballista_tower_lvl2_tower_top_ability1_out_1_4 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 56,
		from = 52
	},
	ballista_tower_lvl2_tower_top_idle_1_5 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 57,
		from = 57
	},
	ballista_tower_lvl2_tower_top_ability1_loop_1_5 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 65,
		from = 58
	},
	ballista_tower_lvl2_tower_top_ability1_out_1_5 = {
		prefix = "ballista_tower_lvl2_tower_top",
		to = 70,
		from = 66
	},
	ballista_tower_lvl2_tower_layerX_idle_1_1 = {
		layer_to = 3,
		from = 1,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	ballista_tower_lvl2_tower_layerX_ability1 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 9,
		layer_from = 1
	},
	ballista_tower_lvl2_tower_layerX_ability2 = {
		layer_to = 3,
		from = 10,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 17,
		layer_from = 1
	},
	ballista_tower_lvl2_tower_layerX_ability3 = {
		layer_to = 3,
		from = 18,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 25,
		layer_from = 1
	},
	ballista_tower_lvl2_tower_layerX_ability4 = {
		layer_to = 3,
		from = 26,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 33,
		layer_from = 1
	},
	ballista_tower_lvl2_tower_layerX_ability5 = {
		layer_to = 3,
		from = 34,
		layer_prefix = "ballista_tower_lvl2_tower_layer%i",
		to = 49,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_top_idle_1_1 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 1,
		from = 1
	},
	ballista_tower_lvl3_tower_top_ability1_loop_1_1 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 9,
		from = 2
	},
	ballista_tower_lvl3_tower_top_ability1_out_1_1 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 14,
		from = 10
	},
	ballista_tower_lvl3_tower_top_idle_1_2 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 15,
		from = 15
	},
	ballista_tower_lvl3_tower_top_ability1_loop_1_2 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 23,
		from = 16
	},
	ballista_tower_lvl3_tower_top_ability1_out_1_2 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 28,
		from = 24
	},
	ballista_tower_lvl3_tower_top_idle_1_3 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 29,
		from = 29
	},
	ballista_tower_lvl3_tower_top_ability1_loop_1_3 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 37,
		from = 30
	},
	ballista_tower_lvl3_tower_top_ability1_out_1_3 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 42,
		from = 38
	},
	ballista_tower_lvl3_tower_top_idle_1_4 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 43,
		from = 43
	},
	ballista_tower_lvl3_tower_top_ability1_loop_1_4 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 51,
		from = 44
	},
	ballista_tower_lvl3_tower_top_ability1_out_1_4 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 56,
		from = 52
	},
	ballista_tower_lvl3_tower_top_idle_1_5 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 57,
		from = 57
	},
	ballista_tower_lvl3_tower_top_ability1_loop_1_5 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 65,
		from = 58
	},
	ballista_tower_lvl3_tower_top_ability1_out_1_5 = {
		prefix = "ballista_tower_lvl3_tower_top",
		to = 70,
		from = 66
	},
	ballista_tower_lvl3_tower_base_layerX_idle_1_1 = {
		layer_to = 3,
		from = 1,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 1,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_base_layerX_ability1 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 9,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_base_layerX_ability2 = {
		layer_to = 3,
		from = 10,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 17,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_base_layerX_ability3 = {
		layer_to = 3,
		from = 18,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 25,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_base_layerX_ability4 = {
		layer_to = 3,
		from = 26,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 33,
		layer_from = 1
	},
	ballista_tower_lvl3_tower_base_layerX_ability5 = {
		layer_to = 3,
		from = 34,
		layer_prefix = "ballista_tower_lvl3_tower_base_layer%i",
		to = 49,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_goblin_idle = {
		prefix = "ballista_tower_lvl4_tower_goblin",
		to = 1,
		from = 1
	},
	ballista_tower_lvl4_tower_goblin_ability1 = {
		prefix = "ballista_tower_lvl4_tower_goblin",
		to = 53,
		from = 2
	},
	ballista_tower_lvl4_tower_top_idle_1_1 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 1,
		from = 1
	},
	ballista_tower_lvl4_tower_top_ability1_loop_1_1 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 9,
		from = 2
	},
	ballista_tower_lvl4_tower_top_ability1_out_1_1 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 34,
		from = 10
	},
	ballista_tower_lvl4_tower_top_idle_1_2 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 35,
		from = 35
	},
	ballista_tower_lvl4_tower_top_ability1_loop_1_2 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 43,
		from = 36
	},
	ballista_tower_lvl4_tower_top_ability1_out_1_2 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 70,
		from = 44
	},
	ballista_tower_lvl4_tower_top_idle_1_3 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 71,
		from = 71
	},
	ballista_tower_lvl4_tower_top_ability1_loop_1_3 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 79,
		from = 72
	},
	ballista_tower_lvl4_tower_top_ability1_out_1_3 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 106,
		from = 80
	},
	ballista_tower_lvl4_tower_top_idle_1_4 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 107,
		from = 107
	},
	ballista_tower_lvl4_tower_top_ability1_loop_1_4 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 115,
		from = 108
	},
	ballista_tower_lvl4_tower_top_ability1_out_1_4 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 142,
		from = 116
	},
	ballista_tower_lvl4_tower_top_idle_1_5 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 143,
		from = 143
	},
	ballista_tower_lvl4_tower_top_ability1_loop_1_5 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 151,
		from = 144
	},
	ballista_tower_lvl4_tower_top_ability1_out_1_5 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 177,
		from = 152
	},
	ballista_tower_lvl4_tower_top_ability2_1 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 195,
		from = 178
	},
	ballista_tower_lvl4_tower_top_ability2_2 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 211,
		from = 196
	},
	ballista_tower_lvl4_tower_top_ability2_3 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 228,
		from = 212
	},
	ballista_tower_lvl4_tower_top_ability2_4 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 245,
		from = 229
	},
	ballista_tower_lvl4_tower_top_ability2_5 = {
		prefix = "ballista_tower_lvl4_tower_top",
		to = 262,
		from = 246
	},
	ballista_tower_lvl4_tower_base_layerX_idle_1_1 = {
		layer_to = 3,
		from = 1,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 1,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_base_layerX_ability1 = {
		layer_to = 3,
		from = 2,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 9,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_base_layerX_ability2 = {
		layer_to = 3,
		from = 10,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 17,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_base_layerX_ability3 = {
		layer_to = 3,
		from = 18,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 25,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_base_layerX_ability4 = {
		layer_to = 3,
		from = 26,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 33,
		layer_from = 1
	},
	ballista_tower_lvl4_tower_base_layerX_ability5 = {
		layer_to = 3,
		from = 34,
		layer_prefix = "ballista_tower_lvl4_tower_base_layer%i",
		to = 49,
		layer_from = 1
	},
	ballista_tower_special_arrow_fx_idle = {
		prefix = "ballista_tower_special_arrow_fx",
		to = 7,
		from = 1
	},
	ballista_tower_special_arrow_idle = {
		prefix = "ballista_tower_special_arrow",
		to = 11,
		from = 1
	},
	ballista_tower_arrow_idle = {
		prefix = "ballista_tower_arrow",
		to = 11,
		from = 1
	},
	ballista_tower_arrow_fx_idle = {
		prefix = "ballista_tower_arrow_fx",
		to = 12,
		from = 1
	},
	ballista_tower_special_hit_idle = {
		prefix = "ballista_tower_special_hit",
		to = 25,
		from = 1
	},
	ballista_tower_hit_idle = {
		prefix = "ballista_tower_hit",
		to = 11,
		from = 1
	},
	ballista_tower_hit_2 = {
		prefix = "ballista_tower_hit_2",
		to = 12,
		from = 1
	},
	ballista_tower_junk_particle_floor = {
		prefix = "ballista_tower_junk_particle_floor",
		to = 16,
		from = 1
	},
	ballista_tower_junk_particle_projectile_1 = {
		prefix = "ballista_tower_junk_particle_projectile_1",
		to = 11,
		from = 1
	},
	ballista_tower_junk_particle_projectile_2 = {
		prefix = "ballista_tower_junk_particle_projectile_2",
		to = 11,
		from = 1
	},
	ballista_tower_bomb_decal_in = {
		prefix = "ballista_tower_bomb_decal",
		to = 15,
		from = 1
	},
	ballista_tower_bomb_decal_idle = {
		prefix = "ballista_tower_bomb_decal",
		to = 16,
		from = 16
	},
	ballista_tower_bomb_decal_ability1 = {
		prefix = "ballista_tower_bomb_decal",
		to = 30,
		from = 17
	},
	ballista_tower_bomb_particle_idle = {
		prefix = "ballista_tower_bomb_particle",
		to = 14,
		from = 1
	},
	ballista_tower_bomb_projectile_idle = {
		prefix = "ballista_tower_bomb_projectile",
		to = 1,
		from = 1
	},
	ballista_tower_bomb_explotion_idle = {
		prefix = "ballista_tower_bomb_explotion",
		to = 30,
		from = 1
	}
}
local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_ballista.lua

-- BEGIN kr3/data/animations/tower_barrel.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_barrel.lua

local a = {
	barrel_tower_preview = {
		prefix = "barrel_tower_preview",
		to = 1,
		from = 1
	},
	barrel_tower_build = {
		prefix = "barrel_tower_build",
		to = 1,
		from = 1
	},
	barrel_tower_lvl1_viking_idle = {
		prefix = "barrel_tower_lvl1_viking",
		to = 1,
		from = 1
	},
	barrel_tower_lvl1_viking_attack = {
		prefix = "barrel_tower_lvl1_viking",
		to = 55,
		from = 2
	},
	barrel_tower_lvl1_tower_tube = {
		prefix = "barrel_tower_lvl1_tower_tube",
		to = 1,
		from = 1
	},
	barrel_tower_lvl1_tower_flow_idle = {
		prefix = "barrel_tower_lvl1_tower_flow",
		to = 8,
		from = 1
	},
	barrel_tower_lvl1_tower = {
		prefix = "barrel_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	barrel_tower_lvl2_viking_idle = {
		prefix = "barrel_tower_lvl2_viking",
		to = 1,
		from = 1
	},
	barrel_tower_lvl2_viking_attack = {
		prefix = "barrel_tower_lvl2_viking",
		to = 55,
		from = 2
	},
	barrel_tower_lvl2_tower_tube = {
		prefix = "barrel_tower_lvl2_tower_tube",
		to = 1,
		from = 1
	},
	barrel_tower_lvl2_tower_flow_idle = {
		prefix = "barrel_tower_lvl2_tower_flow",
		to = 8,
		from = 1
	},
	barrel_tower_lvl2_tower = {
		prefix = "barrel_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	barrel_tower_lvl3_viking_idle = {
		prefix = "barrel_tower_lvl3_viking",
		to = 1,
		from = 1
	},
	barrel_tower_lvl3_viking_attack = {
		prefix = "barrel_tower_lvl3_viking",
		to = 55,
		from = 2
	},
	barrel_tower_lvl3_tower_tube = {
		prefix = "barrel_tower_lvl3_tower_tube",
		to = 1,
		from = 1
	},
	barrel_tower_lvl3_tower_flow_idle = {
		prefix = "barrel_tower_lvl3_tower_flow",
		to = 8,
		from = 1
	},
	barrel_tower_lvl3_tower = {
		prefix = "barrel_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_viking_idle = {
		prefix = "barrel_tower_lvl4_viking",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_viking_attack = {
		prefix = "barrel_tower_lvl4_viking",
		to = 55,
		from = 2
	},
	barrel_tower_lvl4_viking_bad_barrel = {
		prefix = "barrel_tower_lvl4_viking",
		to = 143,
		from = 56
	},
	barrel_tower_lvl4_tower_tube = {
		prefix = "barrel_tower_lvl4_tower_tube",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_tower_flow_idle = {
		prefix = "barrel_tower_lvl4_tower_flow",
		to = 8,
		from = 1
	},
	barrel_tower_lvl4_tower_idle = {
		prefix = "barrel_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_tower_berserker = {
		prefix = "barrel_tower_lvl4_tower",
		to = 40,
		from = 2
	},
	barrel_tower_lvl4_bad_barrel_projectile_decal = {
		prefix = "barrel_tower_lvl4_bad_barrel_projectile_decal",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_bad_barrel_projectile = {
		prefix = "barrel_tower_lvl4_bad_barrel_projectile",
		to = 1,
		from = 1
	},
	barrel_tower_lvl4_bad_barrel_projectile_particle_idle = {
		prefix = "barrel_tower_lvl4_bad_barrel_projectile_particle",
		to = 10,
		from = 1
	},
	barrel_tower_lvl4_bad_barrel_bubbles_fx_loop = {
		prefix = "barrel_tower_lvl4_bad_barrel_bubbles_fx",
		to = 80,
		from = 1
	},
	barrel_tower_lvl4_bad_barrel_start = {
		prefix = "barrel_tower_lvl4_bad_barrel",
		to = 17,
		from = 1
	},
	barrel_tower_lvl4_bad_barrel_loop = {
		prefix = "barrel_tower_lvl4_bad_barrel",
		to = 33,
		from = 18
	},
	barrel_tower_lvl4_bad_barrel_explosion = {
		prefix = "barrel_tower_lvl4_bad_barrel",
		to = 52,
		from = 34
	},
	barrel_tower_lvl4_bad_barrel_decal_idle = {
		prefix = "barrel_tower_lvl4_bad_barrel_decal",
		to = 25,
		from = 1
	},
	barrel_tower_lvl4_tower_berserker_spawn_fx_idle = {
		prefix = "barrel_tower_lvl4_tower_berserker_spawn_fx",
		to = 40,
		from = 1
	},
	barrel_tower_lvl4_tower_berserker_idle = {
		prefix = "barrel_tower_lvl4_tower_berserker",
		to = 82,
		from = 1
	},
	barrel_tower_berserker_unit_hit_fx_idle = {
		prefix = "barrel_tower_berserker_unit_hit_fx",
		to = 16,
		from = 1
	},
	barrel_tower_berserker_unit_idle = {
		prefix = "barrel_tower_berserker_unit",
		to = 20,
		from = 1
	},
	barrel_tower_berserker_unit_walk = {
		prefix = "barrel_tower_berserker_unit",
		to = 40,
		from = 21
	},
	barrel_tower_berserker_unit_attack = {
		prefix = "barrel_tower_berserker_unit",
		to = 60,
		from = 41
	},
	barrel_tower_berserker_unit_attack_2 = {
		prefix = "barrel_tower_berserker_unit",
		to = 82,
		from = 61
	},
	barrel_tower_berserker_unit_spawn = {
		prefix = "barrel_tower_berserker_unit",
		to = 104,
		from = 83
	},
	barrel_tower_berserker_unit_decal_idle = {
		prefix = "barrel_tower_berserker_unit_decal",
		to = 20,
		from = 1
	},
	barrel_tower_projectile_hit_fx_idle = {
		prefix = "barrel_tower_projectile_hit_fx",
		to = 20,
		from = 1
	},
	barrel_tower_projectile_hit_fx_decal_idle = {
		prefix = "barrel_tower_projectile_hit_fx_decal",
		to = 22,
		from = 1
	},
	barrel_tower_projectile_mod_big_idle = {
		prefix = "barrel_tower_projectile_mod_big",
		to = 26,
		from = 1
	},
	barrel_tower_projectile_mod_idle = {
		prefix = "barrel_tower_projectile_mod",
		to = 26,
		from = 1
	},
	barrel_tower_projectile_idle = {
		prefix = "barrel_tower_projectile",
		to = 29,
		from = 1
	},
	barrel_tower_projectile_particle = {
		prefix = "barrel_tower_projectile_particle",
		to = 1,
		from = 1
	}
}
local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_barrel.lua

-- BEGIN kr3/data/animations/tower_dark_elf.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/tower_dark_elf.lua

local a = {
	harrasser_idle = {
		prefix = "harrasser",
		to = 8,
		from = 1
	},
	harrasser_run = {
		prefix = "harrasser",
		to = 17,
		from = 9
	},
	harrasser_attack = {
		prefix = "harrasser",
		to = 46,
		from = 18
	},
	harrasser_attack2 = {
		prefix = "harrasser",
		to = 75,
		from = 47
	},
	harrasser_evade = {
		prefix = "harrasser",
		to = 94,
		from = 76
	},
	harrasser_death = {
		prefix = "harrasser",
		to = 124,
		from = 95
	},
	twilight_longbows_tower_mira_run = {
		prefix = "twilight_longbows_tower_mira",
		to = 56,
		from = 1
	},
	soul_start = {
		prefix = "soul",
		to = 24,
		from = 1
	},
	soul_travelstart = {
		prefix = "soul",
		to = 49,
		from = 25
	},
	soul_travel = {
		prefix = "soul",
		to = 50,
		from = 50
	},
	souldrain_run = {
		prefix = "souldrain",
		to = 13,
		from = 1
	},
	shotexplosion_run = {
		prefix = "shotexplosion",
		to = 11,
		from = 1
	},
	shot_run = {
		prefix = "shot",
		to = 23,
		from = 1
	},
	Archer_lvl4_idle = {
		prefix = "Archer_lvl4",
		to = 1,
		from = 1
	},
	Archer_lvl4_shootstart_begin = {
		prefix = "Archer_lvl4",
		to = 46,
		from = 2
	},
	Archer_lvl4_shootstart_loop = {
		prefix = "Archer_lvl4",
		to = 59,
		from = 47
	},
	Archer_lvl4_shootstart_end = {
		prefix = "Archer_lvl4",
		to = 62,
		from = 60
	},
	Archer_lvl4_shoothigher = {
		prefix = "Archer_lvl4",
		to = 91,
		from = 63
	},
	Archer_lvl4_shootlower = {
		prefix = "Archer_lvl4",
		to = 120,
		from = 92
	},
	Archer_lvl4_idleback = {
		prefix = "Archer_lvl4",
		to = 121,
		from = 121
	},
	Archer_lvl4_shootbackstart_begin = {
		prefix = "Archer_lvl4",
		to = 167,
		from = 122
	},
	Archer_lvl4_shootbackstart_loop = {
		prefix = "Archer_lvl4",
		to = 179,
		from = 168
	},
	Archer_lvl4_shootbackstart_end = {
		prefix = "Archer_lvl4",
		to = 182,
		from = 180
	},
	Archer_lvl4_shootbackhigher = {
		prefix = "Archer_lvl4",
		to = 211,
		from = 183
	},
	Archer_lvl4_shootbacklower = {
		prefix = "Archer_lvl4",
		to = 240,
		from = 212
	},
	Archer_lvl4_transition = {
		prefix = "Archer_lvl4",
		to = 246,
		from = 241
	},
	Archer_lvl4_transitionback = {
		prefix = "Archer_lvl4",
		to = 252,
		from = 247
	},
	Archer_lvl3_idle = {
		prefix = "Archer_lvl3",
		to = 1,
		from = 1
	},
	Archer_lvl3_shootstart_begin = {
		prefix = "Archer_lvl3",
		to = 46,
		from = 2
	},
	Archer_lvl3_shootstart_loop = {
		prefix = "Archer_lvl3",
		to = 59,
		from = 47
	},
	Archer_lvl3_shootstart_end = {
		prefix = "Archer_lvl3",
		to = 62,
		from = 60
	},
	Archer_lvl3_shoothigher = {
		prefix = "Archer_lvl3",
		to = 91,
		from = 63
	},
	Archer_lvl3_shootlower = {
		prefix = "Archer_lvl3",
		to = 120,
		from = 92
	},
	Archer_lvl3_idleback = {
		prefix = "Archer_lvl3",
		to = 121,
		from = 121
	},
	Archer_lvl3_shootbackstart_begin = {
		prefix = "Archer_lvl3",
		to = 167,
		from = 122
	},
	Archer_lvl3_shootbackstart_loop = {
		prefix = "Archer_lvl3",
		to = 179,
		from = 168
	},
	Archer_lvl3_shootbackstart_end = {
		prefix = "Archer_lvl3",
		to = 182,
		from = 180
	},
	Archer_lvl3_shootbackhigher = {
		prefix = "Archer_lvl3",
		to = 211,
		from = 183
	},
	Archer_lvl3_shootbacklower = {
		prefix = "Archer_lvl3",
		to = 240,
		from = 212
	},
	Archer_lvl3_transition = {
		prefix = "Archer_lvl3",
		to = 246,
		from = 241
	},
	Archer_lvl3_transitionback = {
		prefix = "Archer_lvl3",
		to = 252,
		from = 247
	},
	Archer_lvl2_idle = {
		prefix = "Archer_lvl2",
		to = 1,
		from = 1
	},
	Archer_lvl2_shootstart_begin = {
		prefix = "Archer_lvl2",
		to = 46,
		from = 2
	},
	Archer_lvl2_shootstart_loop = {
		prefix = "Archer_lvl2",
		to = 59,
		from = 47
	},
	Archer_lvl2_shootstart_end = {
		prefix = "Archer_lvl2",
		to = 62,
		from = 60
	},
	Archer_lvl2_shoothigher = {
		prefix = "Archer_lvl2",
		to = 91,
		from = 63
	},
	Archer_lvl2_shootlower = {
		prefix = "Archer_lvl2",
		to = 120,
		from = 92
	},
	Archer_lvl2_idleback = {
		prefix = "Archer_lvl2",
		to = 121,
		from = 121
	},
	Archer_lvl2_shootbackstart_begin = {
		prefix = "Archer_lvl2",
		to = 167,
		from = 122
	},
	Archer_lvl2_shootbackstart_loop = {
		prefix = "Archer_lvl2",
		to = 179,
		from = 168
	},
	Archer_lvl2_shootbackstart_end = {
		prefix = "Archer_lvl2",
		to = 182,
		from = 180
	},
	Archer_lvl2_shootbackhigher = {
		prefix = "Archer_lvl2",
		to = 211,
		from = 183
	},
	Archer_lvl2_shootbacklower = {
		prefix = "Archer_lvl2",
		to = 240,
		from = 212
	},
	Archer_lvl2_transition = {
		prefix = "Archer_lvl2",
		to = 246,
		from = 241
	},
	Archer_lvl2_transitionback = {
		prefix = "Archer_lvl2",
		to = 252,
		from = 247
	},
	Archer_lvl1_idle = {
		prefix = "Archer_lvl1",
		to = 1,
		from = 1
	},
	Archer_lvl1_shootstart_begin = {
		prefix = "Archer_lvl1",
		to = 46,
		from = 2
	},
	Archer_lvl1_shootstart_loop = {
		prefix = "Archer_lvl1",
		to = 59,
		from = 47
	},
	Archer_lvl1_shootstart_end = {
		prefix = "Archer_lvl1",
		to = 62,
		from = 60
	},
	Archer_lvl1_shoothigher = {
		prefix = "Archer_lvl1",
		to = 91,
		from = 63
	},
	Archer_lvl1_shootlower = {
		prefix = "Archer_lvl1",
		to = 120,
		from = 92
	},
	Archer_lvl1_idleback = {
		prefix = "Archer_lvl1",
		to = 121,
		from = 121
	},
	Archer_lvl1_shootbackstart_begin = {
		prefix = "Archer_lvl1",
		to = 167,
		from = 122
	},
	Archer_lvl1_shootbackstart_loop = {
		prefix = "Archer_lvl1",
		to = 179,
		from = 168
	},
	Archer_lvl1_shootbackstart_end = {
		prefix = "Archer_lvl1",
		to = 182,
		from = 180
	},
	Archer_lvl1_shootbackhigher = {
		prefix = "Archer_lvl1",
		to = 211,
		from = 183
	},
	Archer_lvl1_shootbacklower = {
		prefix = "Archer_lvl1",
		to = 240,
		from = 212
	},
	Archer_lvl1_transition = {
		prefix = "Archer_lvl1",
		to = 246,
		from = 241
	},
	Archer_lvl1_transitionback = {
		prefix = "Archer_lvl1",
		to = 252,
		from = 247
	},
	Tower_lvl4_door_open = {
		prefix = "Tower_lvl4_door",
		to = 8,
		from = 1
	},
	Tower_lvl4_door_idle = {
		prefix = "Tower_lvl4_door",
		to = 9,
		from = 9
	},
	Tower_lvl4_door_close = {
		prefix = "Tower_lvl4_door",
		to = 13,
		from = 10
	},
	Tower_lvl4_lvl4 = {
		prefix = "Tower_lvl4",
		to = 1,
		from = 1
	},
	Tower_lvl3_lvl3 = {
		prefix = "Tower_lvl3",
		to = 1,
		from = 1
	},
	Tower_lvl2_lvl2 = {
		prefix = "Tower_lvl2",
		to = 1,
		from = 1
	},
	Tower_lvl1_lvl1 = {
		prefix = "Tower_lvl1",
		to = 1,
		from = 1
	},
	Tower_construction_construction = {
		prefix = "Tower_construction",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_dark_elf.lua

-- BEGIN kr3/data/animations/tower_demon_pit.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_demon_pit.lua

local a = {
	demon_pit_tower_demon_big_guy_projectile_idle_1 = {
		prefix = "demon_pit_tower_demon_big_guy_projectile",
		to = 2,
		from = 1
	},
	demon_pit_tower_demon_big_guy_projectile_idle_2 = {
		prefix = "demon_pit_tower_demon_big_guy_projectile",
		to = 8,
		from = 3
	},
	demon_pit_tower_demon_projectile_idle = {
		prefix = "demon_pit_tower_demon_projectile",
		to = 47,
		from = 1
	},
	demon_pit_tower_demon_projectile_particle_idle = {
		prefix = "demon_pit_tower_demon_projectile_particle",
		to = 7,
		from = 1
	},
	demon_pit_tower_lvl4_tower_fuego_idle = {
		prefix = "demon_pit_tower_lvl4_tower_fuego",
		to = 20,
		from = 1
	},
	demon_pit_tower_lvl4_tower_front_idle = {
		prefix = "demon_pit_tower_lvl4_tower_front",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl4_tower_front_splash = {
		prefix = "demon_pit_tower_lvl4_tower_front",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl4_tower_demons_idle = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl4_tower_demons_attack = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 83,
		from = 2
	},
	demon_pit_tower_lvl4_tower_demons_reload_2 = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 95,
		from = 84
	},
	demon_pit_tower_lvl4_tower_demons_big_guy_buy = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 142,
		from = 96
	},
	demon_pit_tower_lvl4_tower_demons_bug_guy_idle = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 143,
		from = 143
	},
	demon_pit_tower_lvl4_tower_demons_big_guy_spawn = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 230,
		from = 144
	},
	demon_pit_tower_lvl4_tower_demons_big_guy_reload_big_guy = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 247,
		from = 231
	},
	demon_pit_tower_lvl4_tower_demons_big_guy_attack = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 329,
		from = 248
	},
	demon_pit_tower_lvl4_tower_demons_big_guy_reload_2 = {
		prefix = "demon_pit_tower_lvl4_tower_demons",
		to = 341,
		from = 330
	},
	demon_pit_tower_lvl4_tower_bubbles_idle = {
		prefix = "demon_pit_tower_lvl4_tower_bubbles",
		to = 20,
		from = 1
	},
	demon_pit_tower_lvl4_tower_base_idle = {
		prefix = "demon_pit_tower_lvl4_tower_base",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl4_tower_base_splash = {
		prefix = "demon_pit_tower_lvl4_tower_base",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl4_tower_reload_reload_1 = {
		prefix = "demon_pit_tower_lvl4_tower_reload",
		to = 10,
		from = 1
	},
	demon_pit_tower_lvl3_tower_front_idle = {
		prefix = "demon_pit_tower_lvl3_tower_front",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl3_tower_front_splash = {
		prefix = "demon_pit_tower_lvl3_tower_front",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl3_tower_demons_idle = {
		prefix = "demon_pit_tower_lvl3_tower_demons",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl3_tower_demons_attack = {
		prefix = "demon_pit_tower_lvl3_tower_demons",
		to = 83,
		from = 2
	},
	demon_pit_tower_lvl3_tower_demons_reload_2 = {
		prefix = "demon_pit_tower_lvl3_tower_demons",
		to = 95,
		from = 84
	},
	demon_pit_tower_lvl3_tower_bubbles_idle = {
		prefix = "demon_pit_tower_lvl3_tower_bubbles",
		to = 20,
		from = 1
	},
	demon_pit_tower_lvl3_tower_base_idle = {
		prefix = "demon_pit_tower_lvl3_tower_base",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl3_tower_base_splash = {
		prefix = "demon_pit_tower_lvl3_tower_base",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl3_tower_reload_reload_1 = {
		prefix = "demon_pit_tower_lvl3_tower_reload",
		to = 10,
		from = 1
	},
	demon_pit_tower_lvl2_tower_front_idle = {
		prefix = "demon_pit_tower_lvl2_tower_front",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl2_tower_front_splash = {
		prefix = "demon_pit_tower_lvl2_tower_front",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl2_tower_demons_idle = {
		prefix = "demon_pit_tower_lvl2_tower_demons",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl2_tower_demons_attack = {
		prefix = "demon_pit_tower_lvl2_tower_demons",
		to = 83,
		from = 2
	},
	demon_pit_tower_lvl2_tower_demons_reload_2 = {
		prefix = "demon_pit_tower_lvl2_tower_demons",
		to = 95,
		from = 84
	},
	demon_pit_tower_lvl2_tower_bubbles_idle = {
		prefix = "demon_pit_tower_lvl2_tower_bulbbles",
		to = 20,
		from = 1
	},
	demon_pit_tower_lvl2_tower_base_idle = {
		prefix = "demon_pit_tower_lvl2_tower_base",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl2_tower_base_splash = {
		prefix = "demon_pit_tower_lvl2_tower_base",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl2_tower_reload_reload_1 = {
		prefix = "demon_pit_tower_lvl2_tower_reload",
		to = 10,
		from = 1
	},
	demon_pit_tower_lvl1_tower_demons_idle = {
		prefix = "demon_pit_tower_lvl1_tower_demons",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl1_tower_demons_attack = {
		prefix = "demon_pit_tower_lvl1_tower_demons",
		to = 83,
		from = 2
	},
	demon_pit_tower_lvl1_tower_demons_reload_2 = {
		prefix = "demon_pit_tower_lvl1_tower_demons",
		to = 95,
		from = 84
	},
	demon_pit_tower_lvl1_tower_bubbles_idle = {
		prefix = "demon_pit_tower_lvl1_tower_bubbles",
		to = 20,
		from = 1
	},
	demon_pit_tower_lvl1_tower_base_idle = {
		prefix = "demon_pit_tower_lvl1_tower_base",
		to = 1,
		from = 1
	},
	demon_pit_tower_lvl1_tower_base_splash = {
		prefix = "demon_pit_tower_lvl1_tower_base",
		to = 7,
		from = 2
	},
	demon_pit_tower_lvl1_tower_demon_reload_reload_1 = {
		prefix = "demon_pit_tower_lvl1_tower_demon_reload",
		to = 10,
		from = 1
	},
	demon_pit_tower_preview = {
		prefix = "demon_pit_tower_preview",
		to = 1,
		from = 1
	},
	demon_pit_tower_build = {
		prefix = "demon_pit_tower_build",
		to = 1,
		from = 1
	},
	demon_pit_tower_demon_minion_hit_fx_idle = {
		prefix = "demon_pit_tower_demon_minion_hit_fx",
		to = 6,
		from = 1
	},
	demon_pit_tower_demon_minion_idle = {
		prefix = "demon_pit_tower_demon_minion",
		to = 1,
		from = 1
	},
	demon_pit_tower_demon_minion_running = {
		prefix = "demon_pit_tower_demon_minion",
		to = 15,
		from = 2
	},
	demon_pit_tower_demon_minion_attack = {
		prefix = "demon_pit_tower_demon_minion",
		to = 37,
		from = 16
	},
	demon_pit_tower_demon_minion_death = {
		prefix = "demon_pit_tower_demon_minion",
		to = 80,
		from = 38
	},
	demon_pit_tower_demon_minion_the_expendables = {
		prefix = "demon_pit_tower_demon_minion",
		to = 120,
		from = 81
	},
	demon_pit_tower_demon_minion_landing = {
		prefix = "demon_pit_tower_demon_minion",
		to = 142,
		from = 121
	},
	demon_pit_tower_demon_big_guy_hit_fx_idle = {
		prefix = "demon_pit_tower_demon_big_guy_hit_fx",
		to = 6,
		from = 1
	},
	demon_pit_tower_demon_big_guy_idle = {
		prefix = "demon_pit_tower_demon_big_guy",
		to = 1,
		from = 1
	},
	demon_pit_tower_demon_big_guy_running = {
		prefix = "demon_pit_tower_demon_big_guy",
		to = 25,
		from = 2
	},
	demon_pit_tower_demon_big_guy_attack = {
		prefix = "demon_pit_tower_demon_big_guy",
		to = 47,
		from = 26
	},
	demon_pit_tower_demon_big_guy_death = {
		prefix = "demon_pit_tower_demon_big_guy",
		to = 87,
		from = 48
	},
	demon_pit_tower_demon_big_guy_landing = {
		prefix = "demon_pit_tower_demon_big_guy",
		to = 105,
		from = 88
	},
	demon_pit_tower_demon_minion_explosion_decal_idle = {
		prefix = "demon_pit_tower_demon_minion_explosion_decal",
		to = 1,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_demon_pit.lua

-- BEGIN kr3/data/animations/tower_dwarf.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_dwarf.lua

local a = {
	tower_dwarf_preview = {
		prefix = "tower_dwarf_preview",
		to = 1,
		from = 1
	},
	tower_dwarf_build = {
		prefix = "tower_dwarf_build",
		to = 1,
		from = 1
	},
	tower_dwarf_lvl4 = {
		prefix = "tower_dwarf_lvl4",
		to = 1,
		from = 1
	},
	tower_dwarf_lvl3 = {
		prefix = "tower_dwarf_lvl3",
		to = 1,
		from = 1
	},
	tower_dwarf_lvl2 = {
		prefix = "tower_dwarf_lvl2",
		to = 1,
		from = 1
	},
	tower_dwarf_lvl1 = {
		prefix = "tower_dwarf_lvl1",
		to = 1,
		from = 1
	},
	tower_dwarf_lvl4_door_open = {
		prefix = "tower_dwarf_lvl4_door",
		to = 10,
		from = 1
	},
	tower_dwarf_lvl4_door_close = {
		prefix = "tower_dwarf_lvl4_door",
		to = 20,
		from = 11
	},
	tower_dwarf_lvl123_door_open = {
		prefix = "tower_dwarf_lvl123_door",
		to = 10,
		from = 1
	},
	tower_dwarf_lvl123_door_close = {
		prefix = "tower_dwarf_lvl123_door",
		to = 20,
		from = 11
	},
	tower_dwarf_attack_2_hit = {
		prefix = "tower_dwarf_attack_2_hit",
		to = 6,
		from = 1
	},
	tower_dwarf_attack_1_hit_hit = {
		prefix = "tower_dwarf_attack_1_hit",
		to = 10,
		from = 1
	},
	tower_dwarf_fire_modifier_big = {
		prefix = "tower_dwarf_fire_modifier_big",
		to = 10,
		from = 1
	},
	tower_dwarf_fire_modifier_small = {
		prefix = "tower_dwarf_fire_modifier_small",
		to = 10,
		from = 1
	},
	tower_dwarf_dwarf_jump_lvl_4 = {
		prefix = "tower_dwarf_dwarf_jump_lvl_4",
		to = 1,
		from = 1
	},
	tower_dwarf_dwarf_jump = {
		prefix = "tower_dwarf_dwarf_jump",
		to = 1,
		from = 1
	},
	tower_dwarf_skill_projectile = {
		prefix = "tower_dwarf_skill_projectile",
		to = 1,
		from = 1
	},
	tower_dwarf_skill_particle = {
		prefix = "tower_dwarf_skill_particle",
		to = 15,
		from = 1
	},
	tower_dwarf_skill_fragment_explosion_idle = {
		prefix = "tower_dwarf_skill_fragment_explosion",
		to = 19,
		from = 1
	},
	tower_dwarf_skill_main_explosion_idle = {
		prefix = "tower_dwarf_skill_main_explosion",
		to = 28,
		from = 1
	},
	tower_dwarf_skill_explosion_decal = {
		prefix = "tower_dwarf_skill_explosion_decal",
		to = 1,
		from = 1
	},
	tower_dwarf_skill_fragment_projectile = {
		prefix = "tower_dwarf_skill_fragment_projectile",
		to = 1,
		from = 1
	},
	tower_dwarf_jump_explosion_lvl4_jump_in_fx = {
		prefix = "tower_dwarf_jump_explosion_lvl4",
		to = 19,
		from = 1
	},
	tower_dwarf_jump_explosion_jump_in_fx = {
		prefix = "tower_dwarf_jump_explosion",
		to = 20,
		from = 1
	},
	tower_dwarf_dwarf_lvl4_idle = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 1,
		from = 1
	},
	tower_dwarf_dwarf_lvl4_walk = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 20,
		from = 2
	},
	tower_dwarf_dwarf_lvl4_jump_in = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 34,
		from = 21
	},
	tower_dwarf_dwarf_lvl4_jump_out = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 45,
		from = 35
	},
	tower_dwarf_dwarf_lvl4_attack_1_up = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 85,
		from = 46
	},
	tower_dwarf_dwarf_lvl4_attack_1_front = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 125,
		from = 86
	},
	tower_dwarf_dwarf_lvl4_attack_1_down = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 165,
		from = 126
	},
	tower_dwarf_dwarf_lvl4_attack_2 = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 207,
		from = 166
	},
	tower_dwarf_dwarf_lvl4_skill = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 265,
		from = 208
	},
	tower_dwarf_dwarf_lvl4_death = {
		prefix = "tower_dwarf_dwarf_lvl4",
		to = 291,
		from = 266
	},
	tower_dwarf_dwarf_lvl3_idle = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 1,
		from = 1
	},
	tower_dwarf_dwarf_lvl3_walk = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 17,
		from = 2
	},
	tower_dwarf_dwarf_lvl3_jump_in = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 31,
		from = 18
	},
	tower_dwarf_dwarf_lvl3_jump_out = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 42,
		from = 32
	},
	tower_dwarf_dwarf_lvl3_attack_1_up = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 82,
		from = 43
	},
	tower_dwarf_dwarf_lvl3_attack_1_front = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 122,
		from = 83
	},
	tower_dwarf_dwarf_lvl3_attack_1_down = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 162,
		from = 123
	},
	tower_dwarf_dwarf_lvl3_attack_2 = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 204,
		from = 163
	},
	tower_dwarf_dwarf_lvl3_death = {
		prefix = "tower_dwarf_dwarf_lvl3",
		to = 230,
		from = 205
	},
	tower_dwarf_dwarf_lvl2_idle = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 1,
		from = 1
	},
	tower_dwarf_dwarf_lvl2_walk = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 17,
		from = 2
	},
	tower_dwarf_dwarf_lvl2_jump_in = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 31,
		from = 18
	},
	tower_dwarf_dwarf_lvl2_jump_out = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 42,
		from = 32
	},
	tower_dwarf_dwarf_lvl2_attack_1_up = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 82,
		from = 43
	},
	tower_dwarf_dwarf_lvl2_attack_1_front = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 122,
		from = 83
	},
	tower_dwarf_dwarf_lvl2_attack_1_down = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 162,
		from = 123
	},
	tower_dwarf_dwarf_lvl2_attack_2 = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 204,
		from = 163
	},
	tower_dwarf_dwarf_lvl2_death = {
		prefix = "tower_dwarf_dwarf_lvl2",
		to = 230,
		from = 205
	},
	tower_dwarf_dwarf_lvl1_idle = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 1,
		from = 1
	},
	tower_dwarf_dwarf_lvl1_walk = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 17,
		from = 2
	},
	tower_dwarf_dwarf_lvl1_jump_in = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 31,
		from = 18
	},
	tower_dwarf_dwarf_lvl1_jump_out = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 42,
		from = 32
	},
	tower_dwarf_dwarf_lvl1_attack_1_up = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 82,
		from = 43
	},
	tower_dwarf_dwarf_lvl1_attack_1_front = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 122,
		from = 83
	},
	tower_dwarf_dwarf_lvl1_attack_1_down = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 162,
		from = 123
	},
	tower_dwarf_dwarf_lvl1_attack_2 = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 204,
		from = 163
	},
	tower_dwarf_dwarf_lvl1_death = {
		prefix = "tower_dwarf_dwarf_lvl1",
		to = 230,
		from = 205
	}
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_dwarf.lua

-- BEGIN kr3/data/animations/tower_elven_barrack.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_elven_barrack.lua

local a = {
	elven_barracks_tower4_top_idle = {
		prefix = "elven_barracks_tower4_top",
		to = 1,
		from = 1
	},
	elven_barracks_tower4_top_idle2 = {
		prefix = "elven_barracks_tower4_top",
		to = 2,
		from = 2
	},
	elven_barracks_tower4_detail_idle = {
		prefix = "elven_barracks_tower4_detail",
		to = 1,
		from = 1
	},
	elven_barracks_tower4_detail_idle2 = {
		prefix = "elven_barracks_tower4_detail",
		to = 2,
		from = 2
	},
	elven_barracks_tower4_base_idle = {
		prefix = "elven_barracks_tower4_base",
		to = 1,
		from = 1
	},
	elven_barracks_tower4_base_idle2 = {
		prefix = "elven_barracks_tower4_base",
		to = 2,
		from = 2
	},
	elven_barracks_elven_soldier_idle = {
		prefix = "elven_barracks_elven_soldier",
		to = 1,
		from = 1
	},
	elven_barracks_elven_soldier_walk = {
		prefix = "elven_barracks_elven_soldier",
		to = 17,
		from = 2
	},
	elven_barracks_elven_soldier_attack = {
		prefix = "elven_barracks_elven_soldier",
		to = 41,
		from = 18
	},
	elven_barracks_elven_soldier_death = {
		prefix = "elven_barracks_elven_soldier",
		to = 75,
		from = 42
	},
	elven_barracks_tower1_idle = {
		prefix = "elven_barracks_tower1",
		to = 1,
		from = 1
	},
	elven_barracks_tower2_idle = {
		prefix = "elven_barracks_tower2",
		to = 1,
		from = 1
	},
	elven_barracks_tower3_idle = {
		prefix = "elven_barracks_tower3",
		to = 1,
		from = 1
	},
	elven_barracks_tower_door_open = {
		prefix = "elven_barracks_tower_door",
		to = 6,
		from = 1
	},
	elven_barracks_tower_door_idleopen = {
		prefix = "elven_barracks_tower_door",
		to = 7,
		from = 7
	},
	elven_barracks_tower_door_close = {
		prefix = "elven_barracks_tower_door",
		to = 14,
		from = 8
	},
	elven_barracks_statechange_idle = {
		prefix = "elven_barracks_statechange",
		to = 23,
		from = 1
	},
	elven_barracks_specterattack_idle = {
		prefix = "elven_barracks_specterattack",
		to = 27,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_elven_barrack.lua

-- BEGIN kr3/data/animations/tower_flamespitter.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_flamespitter.lua

local a = {
	dwarven_flamespitter_tower_lvl1_tower_idle = {
		prefix = "dwarven_flamespitter_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl1_cannon_idle_side = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl1_cannon_attack_side = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl1_cannon_idle_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 47,
		from = 47
	},
	dwarven_flamespitter_tower_lvl1_cannon_attack_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 92,
		from = 48
	},
	dwarven_flamespitter_tower_lvl1_cannon_idle_down = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 93,
		from = 93
	},
	dwarven_flamespitter_tower_lvl1_cannon_attack_down = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 138,
		from = 94
	},
	dwarven_flamespitter_tower_lvl1_cannon_idle_up = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 139,
		from = 139
	},
	dwarven_flamespitter_tower_lvl1_cannon_attack_up = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 184,
		from = 140
	},
	dwarven_flamespitter_tower_lvl1_cannon_idle_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 185,
		from = 185
	},
	dwarven_flamespitter_tower_lvl1_cannon_attack_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl1_cannon",
		to = 230,
		from = 186
	},
	dwarven_flamespitter_tower_lvl2_tower_idle = {
		prefix = "dwarven_flamespitter_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl2_cannon_idle_side = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl2_cannon_attack_side = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl2_cannon_idle_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 47,
		from = 47
	},
	dwarven_flamespitter_tower_lvl2_cannon_attack_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 92,
		from = 48
	},
	dwarven_flamespitter_tower_lvl2_cannon_idle_down = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 93,
		from = 93
	},
	dwarven_flamespitter_tower_lvl2_cannon_attack_down = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 138,
		from = 94
	},
	dwarven_flamespitter_tower_lvl2_cannon_idle_up = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 139,
		from = 139
	},
	dwarven_flamespitter_tower_lvl2_cannon_attack_up = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 184,
		from = 140
	},
	dwarven_flamespitter_tower_lvl2_cannon_idle_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 185,
		from = 185
	},
	dwarven_flamespitter_tower_lvl2_cannon_attack_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl2_cannon",
		to = 230,
		from = 186
	},
	dwarven_flamespitter_tower_lvl3_tower_idle = {
		prefix = "dwarven_flamespitter_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl3_cannon_idle_side = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl3_cannon_attack_side = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl3_cannon_idle_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 47,
		from = 47
	},
	dwarven_flamespitter_tower_lvl3_cannon_attack_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 92,
		from = 48
	},
	dwarven_flamespitter_tower_lvl3_cannon_idle_down = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 93,
		from = 93
	},
	dwarven_flamespitter_tower_lvl3_cannon_attack_down = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 138,
		from = 94
	},
	dwarven_flamespitter_tower_lvl3_cannon_idle_up = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 139,
		from = 139
	},
	dwarven_flamespitter_tower_lvl3_cannon_attack_up = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 184,
		from = 140
	},
	dwarven_flamespitter_tower_lvl3_cannon_idle_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 185,
		from = 185
	},
	dwarven_flamespitter_tower_lvl3_cannon_attack_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl3_cannon",
		to = 230,
		from = 186
	},
	dwarven_flamespitter_tower_lvl123_dude_idle = {
		prefix = "dwarven_flamespitter_tower_lvl123_dude",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl123_dude_attack = {
		prefix = "dwarven_flamespitter_tower_lvl123_dude",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl4_tower_idle = {
		prefix = "dwarven_flamespitter_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_cannon_idle_side = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_cannon_attack_side = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl4_cannon_idle_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 47,
		from = 47
	},
	dwarven_flamespitter_tower_lvl4_cannon_attack_diagonal_down = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 92,
		from = 48
	},
	dwarven_flamespitter_tower_lvl4_cannon_idle_down = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 93,
		from = 93
	},
	dwarven_flamespitter_tower_lvl4_cannon_attack_down = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 138,
		from = 94
	},
	dwarven_flamespitter_tower_lvl4_cannon_idle_up = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 139,
		from = 139
	},
	dwarven_flamespitter_tower_lvl4_cannon_attack_up = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 184,
		from = 140
	},
	dwarven_flamespitter_tower_lvl4_cannon_idle_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 185,
		from = 185
	},
	dwarven_flamespitter_tower_lvl4_cannon_attack_diagonal_up = {
		prefix = "dwarven_flamespitter_tower_lvl4_cannon",
		to = 230,
		from = 186
	},
	dwarven_flamespitter_tower_lvl4_dude_idle = {
		prefix = "dwarven_flamespitter_tower_lvl4_dude",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_dude_attack = {
		prefix = "dwarven_flamespitter_tower_lvl4_dude",
		to = 46,
		from = 2
	},
	dwarven_flamespitter_tower_lvl4_dude_blazing_trail = {
		prefix = "dwarven_flamespitter_tower_lvl4_dude",
		to = 128,
		from = 47
	},
	dwarven_flamespitter_tower_lvl4_dude_scorching_torches = {
		prefix = "dwarven_flamespitter_tower_lvl4_dude",
		to = 230,
		from = 129
	},
	dwarven_flamespitter_tower_lvl4_skill1_idle = {
		prefix = "dwarven_flamespitter_tower_lvl4_skill1",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_skill1_scorching_torches = {
		prefix = "dwarven_flamespitter_tower_lvl4_skill1",
		to = 103,
		from = 2
	},
	dwarven_flamespitter_tower_lvl4_skill2_idle = {
		prefix = "dwarven_flamespitter_tower_lvl4_skill2",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_skill2_blazing_trail = {
		prefix = "dwarven_flamespitter_tower_lvl4_skill2",
		to = 83,
		from = 2
	},
	dwarven_flamespitter_tower_lvl4_stove_fire_fx_blazing_trail = {
		prefix = "dwarven_flamespitter_tower_lvl4_stove_fire_fx",
		to = 58,
		from = 1
	},
	dwarven_flamespitter_tower_lvl4_stove_fire_fx_scorching_torches = {
		prefix = "dwarven_flamespitter_tower_lvl4_stove_fire_fx",
		to = 158,
		from = 59
	},
	dwarven_flamespitter_tower_flamethrower_fx_in = {
		prefix = "dwarven_flamespitter_tower_flamethrower_fx",
		to = 5,
		from = 1
	},
	dwarven_flamespitter_tower_flamethrower_fx_loop = {
		prefix = "dwarven_flamespitter_tower_flamethrower_fx",
		to = 17,
		from = 6
	},
	dwarven_flamespitter_tower_flamethrower_fx_out = {
		prefix = "dwarven_flamespitter_tower_flamethrower_fx",
		to = 41,
		from = 18
	},
	dwarven_flamespitter_tower_blazing_trail_projectile_idle = {
		prefix = "dwarven_flamespitter_tower_blazing_trail_projectile",
		to = 20,
		from = 1
	},
	dwarven_flamespitter_tower_blazing_trail_projectile_particle_idle = {
		prefix = "dwarven_flamespitter_tower_blazing_trail_projectile_particle",
		to = 8,
		from = 1
	},
	dwarven_flamespitter_tower_blazing_trail_path_fx_idle = {
		prefix = "dwarven_flamespitter_tower_blazing_trail_path_fx",
		to = 18,
		from = 1
	},
	dwarven_flamespitter_tower_blazing_trail_explosion_decal = {
		prefix = "dwarven_flamespitter_tower_blazing_trail_explosion_decal",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_blazing_trail_explosion_idle = {
		prefix = "dwarven_flamespitter_tower_blazing_trail_explosion",
		to = 22,
		from = 1
	},
	dwarven_flamespitter_tower_scorching_torches_particle_idle = {
		prefix = "dwarven_flamespitter_tower_scorching_torches_particle",
		to = 10,
		from = 1
	},
	dwarven_flamespitter_tower_scorching_torches_fx_idle = {
		prefix = "dwarven_flamespitter_tower_scorching_torches_fx",
		to = 36,
		from = 1
	},
	dwarven_flamespitter_tower_burn_idle = {
		prefix = "dwarven_flamespitter_tower_burn",
		to = 10,
		from = 1
	},
	dwarven_flamespitter_tower_burn_big_idle = {
		prefix = "dwarven_flamespitter_tower_burn_big",
		to = 10,
		from = 1
	},
	dwarven_flamespitter_tower_build = {
		prefix = "dwarven_flamespitter_tower_build",
		to = 1,
		from = 1
	},
	dwarven_flamespitter_tower_preview = {
		prefix = "dwarven_flamespitter_tower_preview",
		to = 1,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_flamespitter.lua

-- BEGIN kr3/data/animations/tower_ghost.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_ghost.lua

local a = {
	ghost_tower_swap_indicator_particles_idle = {
		prefix = "ghost_tower_swap_indicator_particles",
		to = 30,
		from = 1
	},
	ghost_tower_swap_indicator_front = {
		prefix = "ghost_tower_swap_indicator_front",
		to = 1,
		from = 1
	},
	ghost_tower_swap_indicator_back = {
		prefix = "ghost_tower_swap_indicator_back",
		to = 1,
		from = 1
	},
	ghost_tower_swap_indicator_fx_idle = {
		prefix = "ghost_tower_swap_indicator_fx",
		to = 28,
		from = 1
	},
	ghost_tower_preview = {
		prefix = "ghost_tower_preview",
		to = 1,
		from = 1
	},
	ghost_tower_build = {
		prefix = "ghost_tower_build",
		to = 1,
		from = 1
	},
	ghost_tower_lvl1_tower_shadow_fx_idle = {
		prefix = "ghost_tower_lvl1_tower_shadow_fx",
		to = 36,
		from = 1
	},
	ghost_tower_lvl1_tower_spawn_fx_idle = {
		prefix = "ghost_tower_lvl1_tower_spawn_fx",
		to = 16,
		from = 1
	},
	ghost_tower_lvl1_tower = {
		prefix = "ghost_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	ghost_tower_lvl2_tower_shadow_fx_idle = {
		prefix = "ghost_tower_lvl2_tower_shadow_fx",
		to = 36,
		from = 1
	},
	ghost_tower_lvl2_tower_spawn_fx_idle = {
		prefix = "ghost_tower_lvl2_tower_spawn_fx",
		to = 16,
		from = 1
	},
	ghost_tower_lvl2_tower = {
		prefix = "ghost_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	ghost_tower_lvl3_tower_shadow_fx_idle = {
		prefix = "ghost_tower_lvl3_tower_shadow_fx",
		to = 36,
		from = 1
	},
	ghost_tower_lvl3_tower_spawn_fx_idle = {
		prefix = "ghost_tower_lvl3_tower_spawn_fx",
		to = 16,
		from = 1
	},
	ghost_tower_lvl3_tower = {
		prefix = "ghost_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	ghost_tower_lvl4_tower_shadow_fx_idle = {
		prefix = "ghost_tower_lvl4_tower_shadow_fx",
		to = 36,
		from = 1
	},
	ghost_tower_lvl4_tower_spawn_fx_idle = {
		prefix = "ghost_tower_lvl4_tower_spawn_fx",
		to = 16,
		from = 1
	},
	ghost_tower_lvl4_tower = {
		prefix = "ghost_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	ghost_tower_teleport_fx_out_idle = {
		prefix = "ghost_tower_teleport_fx_out",
		to = 20,
		from = 1
	},
	ghost_tower_teleport_fx_in_idle = {
		prefix = "ghost_tower_teleport_fx_in",
		to = 20,
		from = 1
	},
	ghost_tower_unit_spawn_fx_idle = {
		prefix = "ghost_tower_unit_spawn_fx",
		to = 24,
		from = 1
	},
	ghost_tower_hit_fx_idle = {
		prefix = "ghost_tower_hit_fx",
		to = 6,
		from = 1
	},
	ghost_tower_lvl1_unit_idle = {
		prefix = "ghost_tower_lvl1_unit",
		to = 24,
		from = 1
	},
	ghost_tower_lvl1_unit_running = {
		prefix = "ghost_tower_lvl1_unit",
		to = 48,
		from = 25
	},
	ghost_tower_lvl1_unit_attack = {
		prefix = "ghost_tower_lvl1_unit",
		to = 75,
		from = 49
	},
	ghost_tower_lvl1_unit_death = {
		prefix = "ghost_tower_lvl1_unit",
		to = 109,
		from = 76
	},
	ghost_tower_lvl1_unit_out = {
		prefix = "ghost_tower_lvl1_unit",
		to = 139,
		from = 110
	},
	ghost_tower_lvl1_unit_spawn = {
		prefix = "ghost_tower_lvl1_unit",
		to = 145,
		from = 140
	},
	ghost_tower_lvl2_unit_idle = {
		prefix = "ghost_tower_lvl2_unit",
		to = 24,
		from = 1
	},
	ghost_tower_lvl2_unit_running = {
		prefix = "ghost_tower_lvl2_unit",
		to = 48,
		from = 25
	},
	ghost_tower_lvl2_unit_attack = {
		prefix = "ghost_tower_lvl2_unit",
		to = 75,
		from = 49
	},
	ghost_tower_lvl2_unit_death = {
		prefix = "ghost_tower_lvl2_unit",
		to = 109,
		from = 76
	},
	ghost_tower_lvl2_unit_out = {
		prefix = "ghost_tower_lvl2_unit",
		to = 139,
		from = 110
	},
	ghost_tower_lvl2_unit_spawn = {
		prefix = "ghost_tower_lvl2_unit",
		to = 145,
		from = 140
	},
	ghost_tower_lvl3_unit_idle = {
		prefix = "ghost_tower_lvl3_unit",
		to = 24,
		from = 1
	},
	ghost_tower_lvl3_unit_running = {
		prefix = "ghost_tower_lvl3_unit",
		to = 48,
		from = 25
	},
	ghost_tower_lvl3_unit_attack = {
		prefix = "ghost_tower_lvl3_unit",
		to = 75,
		from = 49
	},
	ghost_tower_lvl3_unit_death = {
		prefix = "ghost_tower_lvl3_unit",
		to = 109,
		from = 76
	},
	ghost_tower_lvl3_unit_out = {
		prefix = "ghost_tower_lvl3_unit",
		to = 139,
		from = 110
	},
	ghost_tower_lvl3_unit_spawn = {
		prefix = "ghost_tower_lvl3_unit",
		to = 145,
		from = 140
	},
	ghost_tower_lvl4_unit_idle = {
		prefix = "ghost_tower_lvl4_unit",
		to = 24,
		from = 1
	},
	ghost_tower_lvl4_unit_running = {
		prefix = "ghost_tower_lvl4_unit",
		to = 48,
		from = 25
	},
	ghost_tower_lvl4_unit_attack = {
		prefix = "ghost_tower_lvl4_unit",
		to = 75,
		from = 49
	},
	ghost_tower_lvl4_unit_death = {
		prefix = "ghost_tower_lvl4_unit",
		to = 109,
		from = 76
	},
	ghost_tower_lvl4_unit_out = {
		prefix = "ghost_tower_lvl4_unit",
		to = 139,
		from = 110
	},
	ghost_tower_lvl4_unit_spawn = {
		prefix = "ghost_tower_lvl4_unit",
		to = 145,
		from = 140
	},
	ghost_tower_buff_skill_front_loop = {
		prefix = "ghost_tower_buff_skill_front",
		to = 16,
		from = 1
	},
	ghost_tower_buff_skill_back_loop = {
		prefix = "ghost_tower_buff_skill_back",
		to = 16,
		from = 1
	},
	ghost_tower_soul_skill_hit_fx_idle = {
		prefix = "ghost_tower_soul_skill_hit_fx",
		to = 10,
		from = 1
	},
	ghost_tower_soul_skill_projectile = {
		prefix = "ghost_tower_soul_skill_projectile",
		to = 1,
		from = 1
	},
	ghost_tower_soul_skill_projectile_particle_idle = {
		prefix = "ghost_tower_soul_skill_projectile_particle",
		to = 13,
		from = 1
	},
	ghost_tower_soul_skill_idle = {
		prefix = "ghost_tower_soul_skill",
		to = 18,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_bigger_loop = {
		prefix = "ghost_tower_soul_skill_enemy_fx_bigger",
		to = 28,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_big_loop = {
		prefix = "ghost_tower_soul_skill_enemy_fx_big",
		to = 28,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_loop = {
		prefix = "ghost_tower_soul_skill_enemy_fx",
		to = 28,
		from = 1
	},
	ghost_tower_spawn_trail_particle_idle = {
		prefix = "ghost_tower_spawn_trail_particle",
		to = 15,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_small = {
		prefix = "ghost_tower_soul_skill_enemy_fx",
		to = 28,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_medium = {
		prefix = "ghost_tower_soul_skill_enemy_fx_big",
		to = 28,
		from = 1
	},
	ghost_tower_soul_skill_enemy_fx_large = {
		prefix = "ghost_tower_soul_skill_enemy_fx_bigger",
		to = 28,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_ghost.lua

-- BEGIN kr3/data/animations/tower_hermit_toad.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_hermit_toad.lua

local a = {
	hermit_toad_tower_bubbles_run = {
		prefix = "hermit_toad_tower_bubbles",
		to = 26,
		from = 1
	},
	hermit_toad_tower_bubbles2_run = {
		prefix = "hermit_toad_tower_bubbles2",
		to = 26,
		from = 1
	},
	hermit_toad_tower_splash_run = {
		prefix = "hermit_toad_tower_splash",
		to = 19,
		from = 1
	},
	hermit_toad_tower_frog1_idle = {
		prefix = "hermit_toad_tower_frog1",
		to = 2,
		from = 1
	},
	hermit_toad_tower_frog1_turn = {
		prefix = "hermit_toad_tower_frog1",
		to = 14,
		from = 3
	},
	hermit_toad_tower_frog1_shoot = {
		prefix = "hermit_toad_tower_frog1",
		to = 54,
		from = 15
	},
	hermit_toad_tower_frog1_idleanim = {
		prefix = "hermit_toad_tower_frog1",
		to = 78,
		from = 55
	},
	hermit_toad_tower_frog1_idleblink = {
		prefix = "hermit_toad_tower_frog1",
		to = 87,
		from = 79
	},
	hermit_toad_tower_frog1_changetower = {
		prefix = "hermit_toad_tower_frog1",
		to = 130,
		from = 88
	},
	hermit_toad_tower_frog1_idle2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 132,
		from = 131
	},
	hermit_toad_tower_frog1_turn2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 144,
		from = 133
	},
	hermit_toad_tower_frog1_shoot2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 197,
		from = 145
	},
	hermit_toad_tower_frog1_idleanim2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 221,
		from = 198
	},
	hermit_toad_tower_frog1_idleblink2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 230,
		from = 222
	},
	hermit_toad_tower_frog1_changetower2 = {
		prefix = "hermit_toad_tower_frog1",
		to = 275,
		from = 231
	},
	hermit_toad_tower_frog2_idle = {
		prefix = "hermit_toad_tower_frog2",
		to = 2,
		from = 1
	},
	hermit_toad_tower_frog2_turn = {
		prefix = "hermit_toad_tower_frog2",
		to = 14,
		from = 3
	},
	hermit_toad_tower_frog2_shoot = {
		prefix = "hermit_toad_tower_frog2",
		to = 54,
		from = 15
	},
	hermit_toad_tower_frog2_idleanim = {
		prefix = "hermit_toad_tower_frog2",
		to = 78,
		from = 55
	},
	hermit_toad_tower_frog2_idleblink = {
		prefix = "hermit_toad_tower_frog2",
		to = 87,
		from = 79
	},
	hermit_toad_tower_frog2_changetower = {
		prefix = "hermit_toad_tower_frog2",
		to = 130,
		from = 88
	},
	hermit_toad_tower_frog2_idle2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 132,
		from = 131
	},
	hermit_toad_tower_frog2_turn2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 144,
		from = 133
	},
	hermit_toad_tower_frog2_shoot2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 197,
		from = 145
	},
	hermit_toad_tower_frog2_idleanim2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 221,
		from = 198
	},
	hermit_toad_tower_frog2_idleblink2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 230,
		from = 222
	},
	hermit_toad_tower_frog2_changetower2 = {
		prefix = "hermit_toad_tower_frog2",
		to = 272,
		from = 231
	},
	hermit_toad_tower_frog3_idle = {
		prefix = "hermit_toad_tower_frog3",
		to = 2,
		from = 1
	},
	hermit_toad_tower_frog3_turn = {
		prefix = "hermit_toad_tower_frog3",
		to = 14,
		from = 3
	},
	hermit_toad_tower_frog3_shoot = {
		prefix = "hermit_toad_tower_frog3",
		to = 54,
		from = 15
	},
	hermit_toad_tower_frog3_idleanim = {
		prefix = "hermit_toad_tower_frog3",
		to = 78,
		from = 55
	},
	hermit_toad_tower_frog3_idleblink = {
		prefix = "hermit_toad_tower_frog3",
		to = 87,
		from = 79
	},
	hermit_toad_tower_frog3_changetower = {
		prefix = "hermit_toad_tower_frog3",
		to = 130,
		from = 88
	},
	hermit_toad_tower_frog3_idle2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 132,
		from = 131
	},
	hermit_toad_tower_frog3_turn2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 144,
		from = 133
	},
	hermit_toad_tower_frog3_shoot2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 197,
		from = 145
	},
	hermit_toad_tower_frog3_idleanim2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 221,
		from = 198
	},
	hermit_toad_tower_frog3_idleblink2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 230,
		from = 222
	},
	hermit_toad_tower_frog3_changetower2 = {
		prefix = "hermit_toad_tower_frog3",
		to = 272,
		from = 231
	},
	hermit_toad_tower_frog4_idle = {
		prefix = "hermit_toad_tower_frog4",
		to = 2,
		from = 1
	},
	hermit_toad_tower_frog4_eat = {
		prefix = "hermit_toad_tower_frog4",
		to = 63,
		from = 3
	},
	hermit_toad_tower_frog4_pathjumpbgin = {
		prefix = "hermit_toad_tower_frog4",
		to = 74,
		from = 64
	},
	hermit_toad_tower_frog4_pathjumpbgidle = {
		prefix = "hermit_toad_tower_frog4",
		to = 76,
		from = 75
	},
	hermit_toad_tower_frog4_pathjump = {
		prefix = "hermit_toad_tower_frog4",
		to = 106,
		from = 77
	},
	hermit_toad_tower_frog4_pathjumpup = {
		prefix = "hermit_toad_tower_frog4",
		to = 108,
		from = 107
	},
	hermit_toad_tower_frog4_pathjumpdown = {
		prefix = "hermit_toad_tower_frog4",
		to = 110,
		from = 109
	},
	hermit_toad_tower_frog4_pathjumpbgout = {
		prefix = "hermit_toad_tower_frog4",
		to = 127,
		from = 111
	},
	hermit_toad_tower_frog4_turn = {
		prefix = "hermit_toad_tower_frog4",
		to = 139,
		from = 128
	},
	hermit_toad_tower_frog4_shoot = {
		prefix = "hermit_toad_tower_frog4",
		to = 179,
		from = 140
	},
	hermit_toad_tower_frog4_idleanim = {
		prefix = "hermit_toad_tower_frog4",
		to = 203,
		from = 180
	},
	hermit_toad_tower_frog4_idleblink = {
		prefix = "hermit_toad_tower_frog4",
		to = 212,
		from = 204
	},
	hermit_toad_tower_frog4_changetower = {
		prefix = "hermit_toad_tower_frog4",
		to = 256,
		from = 213
	},
	hermit_toad_tower_frog4_idle2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 258,
		from = 257
	},
	hermit_toad_tower_frog4_eat2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 319,
		from = 259
	},
	hermit_toad_tower_frog4_pathjumpbgin2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 331,
		from = 320
	},
	hermit_toad_tower_frog4_pathjumpbgidle2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 333,
		from = 332
	},
	hermit_toad_tower_frog4_pathjump2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 363,
		from = 334
	},
	hermit_toad_tower_frog4_pathjumpup2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 365,
		from = 364
	},
	hermit_toad_tower_frog4_pathjumpdown2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 367,
		from = 366
	},
	hermit_toad_tower_frog4_pathjumpbgout2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 386,
		from = 368
	},
	hermit_toad_tower_frog4_turn2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 398,
		from = 387
	},
	hermit_toad_tower_frog4_shoot2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 449,
		from = 399
	},
	hermit_toad_tower_frog4_idleanim2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 473,
		from = 450
	},
	hermit_toad_tower_frog4_idleblink2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 482,
		from = 474
	},
	hermit_toad_tower_frog4_changetower2 = {
		prefix = "hermit_toad_tower_frog4",
		to = 524,
		from = 483
	},
	hermit_toad_tower_construction = {
		prefix = "hermit_toad_tower_construction",
		to = 1,
		from = 1
	},
	hermit_toad_tower_bubbles_frog_pruple = {
		prefix = "hermit_toad_tower_bubbles_frog_pruple",
		to = 79,
		from = 1
	},
	hermit_toad_tower_bubbles_frog_blue = {
		prefix = "hermit_toad_tower_bubbles_frog_blue",
		to = 79,
		from = 1
	},
	hermit_toad_tower_pond_idle = {
		prefix = "hermit_toad_tower_pond",
		to = 1,
		from = 1
	},
	hermit_toad_tower_pond_idle2 = {
		prefix = "hermit_toad_tower_pond",
		to = 2,
		from = 2
	},
	hermit_toad_tower_tongue_run = {
		prefix = "hermit_toad_tower_tongue",
		to = 12,
		from = 1
	},
	hermit_toad_tower_jumpdecal = {
		prefix = "hermit_toad_tower_jumpdecal",
		to = 1,
		from = 1
	},
	hermit_toad_tower_hitfx_run = {
		prefix = "hermit_toad_tower_hitfx",
		to = 23,
		from = 1
	},
	hermit_toad_tower_projectile_run = {
		prefix = "hermit_toad_tower_projectile",
		to = 12,
		from = 1
	},
	hermit_toad_tower_trail_run = {
		prefix = "hermit_toad_tower_trail",
		to = 18,
		from = 1
	},
	hermit_toad_tower_explosion2_idle = {
		prefix = "hermit_toad_tower_explosion2",
		to = 20,
		from = 1
	},
	hermit_toad_tower_tonguehit_run = {
		prefix = "hermit_toad_tower_tonguehit",
		to = 15,
		from = 1
	},
	hermit_toad_tower_hit2_run = {
		prefix = "hermit_toad_tower_hit2",
		to = 12,
		from = 1
	},
	hermit_toad_tower_decal2_run = {
		prefix = "hermit_toad_tower_decal2",
		to = 7,
		from = 1
	},
	hermit_toad_tower_projectile2_run = {
		prefix = "hermit_toad_tower_projectile2",
		to = 8,
		from = 1
	},
	hermit_toad_tower_trail2_run = {
		prefix = "hermit_toad_tower_trail2",
		to = 14,
		from = 1
	},
	hermit_toad_tower_leaves2_idle = {
		prefix = "hermit_toad_tower_leaves2",
		to = 2,
		from = 1
	},
	hermit_toad_tower_leaves2_pathjumpbgin = {
		prefix = "hermit_toad_tower_leaves2",
		to = 46,
		from = 3
	},
	hermit_toad_tower_leaves2_pathjumpbgout = {
		prefix = "hermit_toad_tower_leaves2",
		to = 65,
		from = 47
	},
	hermit_toad_tower_leaves2_changetower = {
		prefix = "hermit_toad_tower_leaves2",
		to = 108,
		from = 66
	},
	hermit_toad_tower_leaves_idle = {
		prefix = "hermit_toad_tower_leaves",
		to = 2,
		from = 1
	},
	hermit_toad_tower_leaves_pathjumpbgin = {
		prefix = "hermit_toad_tower_leaves",
		to = 46,
		from = 3
	},
	hermit_toad_tower_leaves_pathjumpbgout = {
		prefix = "hermit_toad_tower_leaves",
		to = 65,
		from = 47
	},
	hermit_toad_tower_leaves_changetower = {
		prefix = "hermit_toad_tower_leaves",
		to = 108,
		from = 66
	},
	hermit_toad_tower_preview_run = {
		prefix = "hermit_toad_tower_preview",
		to = 1,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_hermit_toad.lua

-- BEGIN kr3/data/animations/tower_necromancer.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_necromancer.lua

local a = {
	necromancer_tower_death_rider_spawn = {
		prefix = "necromancer_tower_death_rider",
		to = 20,
		from = 1
	},
	necromancer_tower_death_rider_idle = {
		prefix = "necromancer_tower_death_rider",
		to = 36,
		from = 27
	},
	necromancer_tower_death_rider_walk_side = {
		prefix = "necromancer_tower_death_rider",
		to = 46,
		from = 37
	},
	necromancer_tower_death_rider_walk_front = {
		prefix = "necromancer_tower_death_rider",
		to = 56,
		from = 47
	},
	necromancer_tower_death_rider_walk_back = {
		prefix = "necromancer_tower_death_rider",
		to = 66,
		from = 57
	},
	necromancer_tower_death_rider_start_walk_FX_side_idle = {
		prefix = "necromancer_tower_death_rider_start_walk_FX_side",
		to = 12,
		from = 1
	},
	necromancer_tower_death_rider_start_walk_FX_front_idle = {
		prefix = "necromancer_tower_death_rider_start_walk_FX_front",
		to = 12,
		from = 1
	},
	necromancer_tower_death_rider_start_walk_FX_back_idle = {
		prefix = "necromancer_tower_death_rider_start_walk_FX_back",
		to = 12,
		from = 1
	},
	necromancer_tower_death_rider_trial_particle_B_idle = {
		prefix = "necromancer_tower_death_rider_trial_particle_B",
		to = 9,
		from = 1
	},
	necromancer_tower_death_rider_trial_particle_A_idle = {
		prefix = "necromancer_tower_death_rider_trial_particle_A",
		to = 13,
		from = 1
	},
	necromancer_tower_bone_golem_idle = {
		prefix = "necromancer_tower_bone_golem",
		to = 1,
		from = 1
	},
	necromancer_tower_bone_golem_walk = {
		prefix = "necromancer_tower_bone_golem",
		to = 25,
		from = 2
	},
	necromancer_tower_bone_golem_attack = {
		prefix = "necromancer_tower_bone_golem",
		to = 58,
		from = 26
	},
	necromancer_tower_bone_golem_death = {
		prefix = "necromancer_tower_bone_golem",
		to = 98,
		from = 59
	},
	necromancer_tower_bone_golem_spawn = {
		prefix = "necromancer_tower_bone_golem",
		to = 155,
		from = 99
	},
	necromancer_tower_skeleton_warrior_spawn = {
		prefix = "necromancer_tower_skeleton_warrior",
		to = 28,
		from = 1
	},
	necromancer_tower_skeleton_warrior_idle = {
		prefix = "necromancer_tower_skeleton_warrior",
		to = 29,
		from = 29
	},
	necromancer_tower_skeleton_warrior_walk = {
		prefix = "necromancer_tower_skeleton_warrior",
		to = 53,
		from = 30
	},
	necromancer_tower_skeleton_warrior_attack = {
		prefix = "necromancer_tower_skeleton_warrior",
		to = 72,
		from = 54
	},
	necromancer_tower_skeleton_warrior_death = {
		prefix = "necromancer_tower_skeleton_warrior",
		to = 94,
		from = 73
	},
	necromancer_tower_revive_big_idle = {
		prefix = "necromancer_tower_revive_big",
		to = 22,
		from = 1
	},
	necromancer_tower_revive_idle = {
		prefix = "necromancer_tower_revive",
		to = 22,
		from = 1
	},
	necromancer_tower_curse_decal_big = {
		prefix = "necromancer_tower_curse_decal_big",
		to = 1,
		from = 1
	},
	necromancer_tower_curse_decal = {
		prefix = "necromancer_tower_curse_decal",
		to = 1,
		from = 1
	},
	necromancer_tower_curse_big_idle = {
		prefix = "necromancer_tower_curse_big",
		to = 26,
		from = 1
	},
	necromancer_tower_curse_idle = {
		prefix = "necromancer_tower_curse",
		to = 26,
		from = 1
	},
	necromancer_tower_skull_projectile_hit_FX_idle = {
		prefix = "necromancer_tower_skull_projectile_hit_FX",
		to = 18,
		from = 1
	},
	necromancer_tower_skull_projectile_particle_trail_idle = {
		prefix = "necromancer_tower_skull_projectile_particle_trail",
		to = 11,
		from = 1
	},
	necromancer_tower_skull_projectile_spawn_FX_idle = {
		prefix = "necromancer_tower_skull_projectile_spawn_FX",
		to = 18,
		from = 1
	},
	necromancer_tower_skull_projectile_idle = {
		prefix = "necromancer_tower_skull_projectile",
		to = 24,
		from = 1
	},
	necromancer_tower_lvl4_necromancer_idle = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 10,
		from = 1
	},
	necromancer_tower_lvl4_necromancer_skull_spawn = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 48,
		from = 11
	},
	necromancer_tower_lvl4_necromancer_attack = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 86,
		from = 49
	},
	necromancer_tower_lvl4_necromancer_attack_back = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 124,
		from = 87
	},
	necromancer_tower_lvl4_necromancer_mark_of_silence = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 168,
		from = 125
	},
	necromancer_tower_lvl4_necromancer_call_death_rider = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 222,
		from = 169
	},
	necromancer_tower_lvl4_necromancer_idle_back = {
		prefix = "necromancer_tower_lvl4_necromancer",
		to = 232,
		from = 223
	},
	necromancer_tower_lvl4_tower_FX_tower_FX_skull_spawn = {
		prefix = "necromancer_tower_lvl4_tower_FX",
		to = 23,
		from = 1
	},
	necromancer_tower_lvl4_tower_FX_tower_FX_attack = {
		prefix = "necromancer_tower_lvl4_tower_FX",
		to = 39,
		from = 24
	},
	necromancer_tower_lvl4_tower_FX_tower_FX_mark_of_silence = {
		prefix = "necromancer_tower_lvl4_tower_FX",
		to = 83,
		from = 40
	},
	necromancer_tower_lvl4_tower_FX_tower_FX_call_death_rider = {
		prefix = "necromancer_tower_lvl4_tower_FX",
		to = 131,
		from = 84
	},
	necromancer_tower_lvl4_tower = {
		prefix = "necromancer_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	necromancer_tower_lvl4_tower_smoke = {
		prefix = "necromancer_tower_lvl4_tower_smoke",
		to = 60,
		from = 1
	},
	necromancer_tower_lvl3_necromancer_idle = {
		prefix = "necromancer_tower_lvl3_necromancer",
		to = 10,
		from = 1
	},
	necromancer_tower_lvl3_necromancer_skull_spawn = {
		prefix = "necromancer_tower_lvl3_necromancer",
		to = 48,
		from = 11
	},
	necromancer_tower_lvl3_necromancer_attack = {
		prefix = "necromancer_tower_lvl3_necromancer",
		to = 86,
		from = 49
	},
	necromancer_tower_lvl3_necromancer_attack_back = {
		prefix = "necromancer_tower_lvl3_necromancer",
		to = 124,
		from = 87
	},
	necromancer_tower_lvl3_necromancer_idle_back = {
		prefix = "necromancer_tower_lvl3_necromancer",
		to = 134,
		from = 125
	},
	necromancer_tower_lvl3_tower_FX_tower_FX_skull_spawn = {
		prefix = "necromancer_tower_lvl3_tower_FX",
		to = 23,
		from = 1
	},
	necromancer_tower_lvl3_tower_FX_tower_FX_attack = {
		prefix = "necromancer_tower_lvl3_tower_FX",
		to = 39,
		from = 24
	},
	necromancer_tower_lvl3_tower = {
		prefix = "necromancer_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	necromancer_tower_lvl2_necromancer_idle = {
		prefix = "necromancer_tower_lvl2_necromancer",
		to = 10,
		from = 1
	},
	necromancer_tower_lvl2_necromancer_skull_spawn = {
		prefix = "necromancer_tower_lvl2_necromancer",
		to = 48,
		from = 11
	},
	necromancer_tower_lvl2_necromancer_attack = {
		prefix = "necromancer_tower_lvl2_necromancer",
		to = 86,
		from = 49
	},
	necromancer_tower_lvl2_necromancer_attack_back = {
		prefix = "necromancer_tower_lvl2_necromancer",
		to = 124,
		from = 87
	},
	necromancer_tower_lvl2_necromancer_idle_back = {
		prefix = "necromancer_tower_lvl2_necromancer",
		to = 134,
		from = 125
	},
	necromancer_tower_lvl2_tower_FX_tower_FX_skull_spawn = {
		prefix = "necromancer_tower_lvl2_tower_FX",
		to = 23,
		from = 1
	},
	necromancer_tower_lvl2_tower_FX_tower_FX_attack = {
		prefix = "necromancer_tower_lvl2_tower_FX",
		to = 39,
		from = 24
	},
	necromancer_tower_lvl2_tower = {
		prefix = "necromancer_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	necromancer_tower_lvl1_necromancer_idle = {
		prefix = "necromancer_tower_lvl1_necromancer",
		to = 10,
		from = 1
	},
	necromancer_tower_lvl1_necromancer_skull_spawn = {
		prefix = "necromancer_tower_lvl1_necromancer",
		to = 48,
		from = 11
	},
	necromancer_tower_lvl1_necromancer_attack = {
		prefix = "necromancer_tower_lvl1_necromancer",
		to = 86,
		from = 49
	},
	necromancer_tower_lvl1_necromancer_attack_back = {
		prefix = "necromancer_tower_lvl1_necromancer",
		to = 124,
		from = 87
	},
	necromancer_tower_lvl1_necromancer_idle_back = {
		prefix = "necromancer_tower_lvl1_necromancer",
		to = 134,
		from = 125
	},
	necromancer_tower_lvl1_tower_FX_tower_FX_attack = {
		prefix = "necromancer_tower_lvl1_tower_FX",
		to = 16,
		from = 1
	},
	necromancer_tower_lvl1_tower = {
		prefix = "necromancer_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	necromancer_tower_build = {
		prefix = "necromancer_tower_build",
		to = 1,
		from = 1
	},
	necromancer_tower_preview = {
		prefix = "necromancer_tower_preview",
		to = 1,
		from = 1
	},
	necromancer_tower_mark_of_silence_totem_start = {
		prefix = "necromancer_tower_mark_of_silence_totem",
		to = 31,
		from = 1
	},
	necromancer_tower_mark_of_silence_totem_idle = {
		prefix = "necromancer_tower_mark_of_silence_totem",
		to = 131,
		from = 32
	},
	necromancer_tower_mark_of_silence_totem_end = {
		prefix = "necromancer_tower_mark_of_silence_totem",
		to = 154,
		from = 132
	},
	necromancer_tower_mark_of_silence_floorFX_idle = {
		prefix = "necromancer_tower_mark_of_silence_floorFX",
		to = 24,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_necromancer.lua

-- BEGIN kr3/data/animations/tower_ogre_shipwreck.lua
do
	local __chunk = (function()
local a = {
--skill_goblin
    skill_goblin_idle = {
        prefix = "skill_goblin",
        from = 1,
        to = 1
    },
    skill_goblin_walk = {
        prefix = "skill_goblin",
        from = 2,
        to = 9
    },
    skill_goblin_attack = {
        prefix = "skill_goblin",
        from = 10,
        to = 23
    },
    skill_goblin_death = {
        prefix = "skill_goblin",
        from = 10,
        to = 23
    },
--cook_orge
    cook_ogre_idle = {
        prefix = "cook_ogre",
        from = 1,
        to = 1
    },
    cook_ogre_walk = {
        prefix = "cook_ogre",
        from = 2,
        to = 35
    },
    cook_ogre_attack = {
        prefix = "cook_ogre",
        from = 36,
        to = 66
    },
    cook_ogre_death = {
        prefix = "cook_ogre",
        from = 67,
        to = 93
    },
    cook_ogre_spawn = {
        prefix = "cook_ogre",
        from = 94,
        to = 109
    },
    cook_ogre_decal_idle = {
        prefix = "cook_ogre_decal",
        from = 1,
        to = 19
    },
    cook_ogre_smoke_idle = {
        prefix = "cook_ogre_smoke",
        from = 1,
        to = 17
    },
--deckhand_goblin
    deckhand_goblin_idle = {
        prefix = "deckhand_goblin",
        from = 1,
        to = 1
    },
    deckhand_goblin_walk = {
        prefix = "deckhand_goblin",
        from = 2,
        to = 9
    },
    deckhand_goblin_attack = {
        prefix = "deckhand_goblin",
        from = 10,
        to = 23
    },
    deckhand_goblin_death = {
        prefix = "deckhand_goblin",
        from = 24,
        to = 36
    },
--bomber
    goblin_bomber_trail_trail = {
        prefix = "goblin_bomber_trail",
        from = 1,
        to = 9
    },
    goblin_bomber_idle = {
        prefix = "goblin_bomber",
        from = 1,
        to = 1
    },
    goblin_bomber_shoot = {
        prefix = "goblin_bomber",
        from = 2,
        to = 40
    },
    goblin_bomber_skill = {
        prefix = "goblin_bomber",
        from = 41,
        to = 80
    },
    goblin_bomber_idleGoblin = {
        prefix = "goblin_bomber",
        from = 81,
        to = 81
    },
    goblin_bomber_shootGoblin = {
        prefix = "goblin_bomber",
        from = 82,
        to = 120
    },
    goblin_bomber_skillGoblin = {
        prefix = "goblin_bomber",
        from = 121,
        to = 160
    },
    goblin_bomber_burst_burst = {
        prefix = "goblin_bomber_burst",
        from = 1,
        to = 20
    },
    ogre_shipwreck_bomber_proyectile_travel = {
        prefix = "goblin_bomber_projectil",
        from = 1,
        to = 14
    },
--musket
    musket_hit_hit = {
        prefix = "musket_hit",
        from = 1,
        to = 7
    },
    musketer_tower_shooter_idle = {
        prefix = "musket_tower",
        from = 1,
        to = 1
    },
    musketer_tower_shooter_shootDown = {
        prefix = "musket_tower",
        from = 2,
        to = 21
    },
    musketer_tower_shooter_idleUp = {
        prefix = "musket_tower",
        from = 22,
        to = 22
    },
    musketer_tower_shooter_shootUp = {
        prefix = "musket_tower",
        from = 23,
        to = 44
    },
    musketer_tower_shooter_skillDownIn = {
        prefix = "musket_tower",
        from = 45,
        to = 50
    },
    musketer_tower_shooter_skillDownLoop = {
        prefix = "musket_tower",
        from = 51,
        to = 56
    },
    musketer_tower_shooter_skillDownEnd = {
        prefix = "musket_tower",
        from = 57,
        to = 70
    },
    musketer_tower_shooter_skillUpIn = {
        prefix = "musket_tower",
        from = 71,
        to = 76
    },
    musketer_tower_shooter_skillUpLoop = {
        prefix = "musket_tower",
        from = 77,
        to = 82
    },
    musketer_tower_shooter_skillUpEnd = {
        prefix = "musket_tower",
        from = 83,
        to = 96
    },
--1级防御塔
    ogre_shipwreck_fromwer_lvl1_layer1_build = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer1",
		from = 1,
		to = 1
	},
    ogre_shipwreck_fromwer_lvl1_layer1_idle = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer1",
		from = 3,
		to = 3
	},
    ogre_shipwreck_fromwer_lvl1_layer1_open = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer1",
		from = 3,
		to = 18
	},
    ogre_shipwreck_fromwer_lvl1_layer1_close = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer1",
		from = 19,
		to = 34
	},
    ogre_shipwreck_fromwer_lvl1_layer2_build = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer2",
		from = 1,
		to = 1
	},
    ogre_shipwreck_fromwer_lvl1_layer2_idle = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer2",
		from = 3,
		to = 3
	},
    ogre_shipwreck_fromwer_lvl1_layer2_open = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer2",
		from = 3,
		to = 18
	},
    ogre_shipwreck_fromwer_lvl1_layer2_close = {
		prefix = "ogre_shipwreck_fromwer_lvl1_layer2",
		from = 19,
		to = 34
	},
--2级防御塔
    ogre_shipwreck_fromwer_lvl2_layer1_idle = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer1",
		from = 2,
		to = 2
	},
    ogre_shipwreck_fromwer_lvl2_layer1_open = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer1",
		from = 2,
		to = 17
	},
    ogre_shipwreck_fromwer_lvl2_layer1_close = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer1",
		from = 18,
		to = 34
	},
    ogre_shipwreck_fromwer_lvl2_layer2_idle = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer2",
		from = 2,
		to = 2
	},
    ogre_shipwreck_fromwer_lvl2_layer2_open = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer2",
		from = 2,
		to = 17
	},
    ogre_shipwreck_fromwer_lvl2_layer2_close = {
		prefix = "ogre_shipwreck_fromwer_lvl2_layer2",
		from = 18,
		to = 34
	},
--3级防御塔
    ogre_shipwreck_fromwer_lvl3_layer1_idle = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer1",
        from = 2,
        to = 2
    },
    ogre_shipwreck_fromwer_lvl3_layer1_open = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer1",
        from = 2,
        to = 17
    },
    ogre_shipwreck_fromwer_lvl3_layer1_close = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer1",
        from = 18,
        to = 34
    },
    ogre_shipwreck_fromwer_lvl3_layer2_idle = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer2",
        from = 2,
        to = 2
    },
    ogre_shipwreck_fromwer_lvl3_layer2_open = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer2",
        from = 2,
        to = 17
    },
    ogre_shipwreck_fromwer_lvl3_layer2_close = {
        prefix = "ogre_shipwreck_fromwer_lvl3_layer2",
        from = 18,
        to = 34
    },
--4级防御塔
    ogre_shipwreck_fromwer_lvl4_layer1_idle = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer1",
        from = 2,
        to = 2
    },
    ogre_shipwreck_fromwer_lvl4_layer1_open = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer1",
        from = 2,
        to = 17
    },
    ogre_shipwreck_fromwer_lvl4_layer1_close = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer1",
        from = 18,
        to = 34
    },
    ogre_shipwreck_fromwer_lvl4_layer2_idle = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer2",
        from = 2,
        to = 2
    },
    ogre_shipwreck_fromwer_lvl4_layer2_open = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer2",
        from = 2,
        to = 17
    },
    ogre_shipwreck_fromwer_lvl4_layer2_close = {
        prefix = "ogre_shipwreck_fromwer_lvl4_layer2",
        from = 18,
        to = 34
    },
    ogre_shipwreck_tower_lvl4_flags_run = {
        prefix = "ogre_shipwreck_tower_lvl4_flags",
        from = 1,
        to = 20
    },
--end
}


local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_ogre_shipwreck.lua

-- BEGIN kr3/data/animations/tower_panda.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/tower_panda.lua

local a = {
	tower_pandas_target_ray_run = {
		prefix = "tower_pandas_target_ray",
		to = 16,
		from = 1
	},
	tower_pandas_panda_blue_lvl4_idle = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 1,
		from = 1
	},
	tower_pandas_panda_blue_lvl4_walk = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 21,
		from = 2
	},
	tower_pandas_panda_blue_lvl4_attack = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 53,
		from = 22
	},
	tower_pandas_panda_blue_lvl4_skill = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 87,
		from = 54
	},
	tower_pandas_panda_blue_lvl4_death = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 109,
		from = 88
	},
	tower_pandas_panda_blue_lvl4_scape_loop = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 121,
		from = 110
	},
	tower_pandas_panda_blue_lvl4_scape_end = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 143,
		from = 122
	},
	tower_pandas_panda_blue_lvl4_spell = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 173,
		from = 144
	},
	tower_pandas_panda_blue_lvl4_spawn_in = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 185,
		from = 174
	},
	tower_pandas_panda_blue_lvl4_spawn_end = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 211,
		from = 186
	},
	tower_pandas_panda_blue_lvl4_idle_torre = {
		prefix = "tower_pandas_panda_blue_lvl4",
		to = 212,
		from = 212
	},
	tower_pandas_projectile_ray_run = {
		prefix = "tower_pandas_projectile_ray",
		to = 11,
		from = 1
	},
	tower_pandas_tower_lvl_04_idle = {
		prefix = "tower_pandas_tower_lvl_04",
		to = 1,
		from = 1
	},
	la_red_lvl4_tp_fire_enemy_run = {
		prefix = "la_red_lvl4_tp_fire_enemy",
		to = 20,
		from = 1
	},
	tower_pandas_level_up_fx_run = {
		prefix = "tower_pandas_level_up_fx",
		to = 8,
		from = 1
	},
	tower_pandas_projectile_air_hit_run = {
		prefix = "tower_pandas_projectile_air_hit",
		to = 4,
		from = 1
	},
	tower_pandas_projectile_ray_hit_run = {
		prefix = "tower_pandas_projectile_ray_hit",
		to = 4,
		from = 1
	},
	tower_pandas_projectile_fire_hit_run = {
		prefix = "tower_pandas_projectile_fire_hit",
		to = 4,
		from = 1
	},
	tower_pandas_projectile_air_Run = {
		prefix = "tower_pandas_projectile_air",
		to = 4,
		from = 1
	},
	tower_pandas_projectile_air_flying = {
		prefix = "tower_pandas_projectile_air",
		to = 4,
		from = 1
	},
	tower_pandas_trail_fire_trail = {
		prefix = "tower_pandas_trail_fire",
		to = 16,
		from = 1
	},
	tower_pandas_projectile_fire_run = {
		prefix = "tower_pandas_projectile_fire",
		to = 8,
		from = 1
	},
	tower_pandas_projectile_fire_flying = {
		prefix = "tower_pandas_projectile_fire",
		to = 8,
		from = 1
	},
	tower_pandas_panda_green_lvl4_idle = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 1,
		from = 1
	},
	tower_pandas_panda_green_lvl4_walk = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 21,
		from = 2
	},
	tower_pandas_panda_green_lvl4_attack = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 53,
		from = 22
	},
	tower_pandas_panda_green_lvl4_skill = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 85,
		from = 54
	},
	tower_pandas_panda_green_lvl4_death = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 121,
		from = 86
	},
	tower_pandas_panda_green_lvl4_scape_loop = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 133,
		from = 122
	},
	tower_pandas_panda_green_lvl4_scape_end = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 157,
		from = 134
	},
	tower_pandas_panda_green_lvl4_spell = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 185,
		from = 158
	},
	tower_pandas_panda_green_lvl4_spawn_in = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 197,
		from = 186
	},
	tower_pandas_panda_green_lvl4_spawn_end = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 231,
		from = 198
	},
	tower_pandas_panda_green_lvl4_idle_torre = {
		prefix = "tower_pandas_panda_green_lvl4",
		to = 232,
		from = 232
	},
	tower_pandas_panda_green_lvl3_idle = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 1,
		from = 1
	},
	tower_pandas_panda_green_lvl3_walk = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 21,
		from = 2
	},
	tower_pandas_panda_green_lvl3_attack = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 43,
		from = 22
	},
	tower_pandas_panda_green_lvl3_death = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 87,
		from = 44
	},
	tower_pandas_panda_green_lvl3_scape_loop = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 99,
		from = 88
	},
	tower_pandas_panda_green_lvl3_scape_end = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 117,
		from = 100
	},
	tower_pandas_panda_green_lvl3_idle_tower = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 118,
		from = 118
	},
	tower_pandas_panda_green_lvl3_spell = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 146,
		from = 119
	},
	tower_pandas_panda_green_lvl3_spawn_in = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 156,
		from = 147
	},
	tower_pandas_panda_green_lvl3_spawn_end = {
		prefix = "tower_pandas_panda_green_lvl3",
		to = 176,
		from = 157
	},
	tower_pandas_panda_green_lvl2_idle = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 1,
		from = 1
	},
	tower_pandas_panda_green_lvl2_walk = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 21,
		from = 2
	},
	tower_pandas_panda_green_lvl2_attack = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 43,
		from = 22
	},
	tower_pandas_panda_green_lvl2_death = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 87,
		from = 44
	},
	tower_pandas_panda_green_lvl2_scape_loop = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 99,
		from = 88
	},
	tower_pandas_panda_green_lvl2_scape_end = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 117,
		from = 100
	},
	tower_pandas_panda_green_lvl2_idle_tower = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 118,
		from = 118
	},
	tower_pandas_panda_green_lvl2_spell = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 146,
		from = 119
	},
	tower_pandas_panda_green_lvl2_spawn_in = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 156,
		from = 147
	},
	tower_pandas_panda_green_lvl2_spawn_end = {
		prefix = "tower_pandas_panda_green_lvl2",
		to = 176,
		from = 157
	},
	tower_pandas_panda_green_lvl1_idle = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 1,
		from = 1
	},
	tower_pandas_panda_green_lvl1_walk = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 21,
		from = 2
	},
	tower_pandas_panda_green_lvl1_attack = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 43,
		from = 22
	},
	tower_pandas_panda_green_lvl1_death = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 87,
		from = 44
	},
	tower_pandas_panda_green_lvl1_scape_loop = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 99,
		from = 88
	},
	tower_pandas_panda_green_lvl1_scape_end = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 117,
		from = 100
	},
	tower_pandas_panda_green_lvl1_idle_tower = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 118,
		from = 118
	},
	tower_pandas_panda_green_lvl1_spell = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 146,
		from = 119
	},
	tower_pandas_panda_green_lvl1_spawn_in = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 156,
		from = 147
	},
	tower_pandas_panda_green_lvl1_spawn_end = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 177,
		from = 157
	},
	tower_pandas_panda_blue_lvl3_idle = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 1,
		from = 1
	},
	tower_pandas_panda_blue_lvl3_walk = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 21,
		from = 2
	},
	tower_pandas_panda_blue_lvl3_attack = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 43,
		from = 22
	},
	tower_pandas_panda_blue_lvl3_death = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 87,
		from = 44
	},
	tower_pandas_panda_blue_lvl3_scape_loop = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 99,
		from = 88
	},
	tower_pandas_panda_blue_lvl3_scape_end = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 117,
		from = 100
	},
	tower_pandas_panda_blue_lvl3_idle_tower = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 118,
		from = 118
	},
	tower_pandas_panda_blue_lvl3_spell = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 146,
		from = 119
	},
	tower_pandas_panda_blue_lvl3_spawn_in = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 156,
		from = 147
	},
	tower_pandas_panda_blue_lvl3_spawn_end = {
		prefix = "tower_pandas_panda_blue_lvl3",
		to = 176,
		from = 157
	},
	tower_pandas_panda_blue_lvl2_idle = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 1,
		from = 1
	},
	tower_pandas_panda_blue_lvl2_walk = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 21,
		from = 2
	},
	tower_pandas_panda_blue_lvl2_attack = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 43,
		from = 22
	},
	tower_pandas_panda_blue_lvl2_death = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 87,
		from = 44
	},
	tower_pandas_panda_blue_lvl2_scape_loop = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 99,
		from = 88
	},
	tower_pandas_panda_blue_lvl2_scape_end = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 117,
		from = 100
	},
	tower_pandas_panda_blue_lvl2_idle_tower = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 118,
		from = 118
	},
	tower_pandas_panda_blue_lvl2_spell = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 146,
		from = 119
	},
	tower_pandas_panda_blue_lvl2_spawn_in = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 156,
		from = 147
	},
	tower_pandas_panda_blue_lvl2_spawn_end = {
		prefix = "tower_pandas_panda_blue_lvl2",
		to = 177,
		from = 157
	},
	tower_pandas_panda_blue_lvl1_idle = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 1,
		from = 1
	},
	tower_pandas_panda_blue_lvl1_walk = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 21,
		from = 2
	},
	tower_pandas_panda_blue_lvl1_attack = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 43,
		from = 22
	},
	tower_pandas_panda_blue_lvl1_death = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 87,
		from = 44
	},
	tower_pandas_panda_blue_lvl1_scape_loop = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 99,
		from = 88
	},
	tower_pandas_panda_blue_lvl1_scape_end = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 117,
		from = 100
	},
	tower_pandas_panda_blue_lvl1_idle_tower = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 118,
		from = 118
	},
	tower_pandas_panda_blue_lvl1_spell = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 146,
		from = 119
	},
	tower_pandas_panda_blue_lvl1_spawn_in = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 156,
		from = 147
	},
	tower_pandas_panda_blue_lvl1_spawn_end = {
		prefix = "tower_pandas_panda_blue_lvl1",
		to = 177,
		from = 157
	},
	tower_pandas_panda_red_lvl3_idle = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 1,
		from = 1
	},
	tower_pandas_panda_red_lvl3_walk = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 21,
		from = 2
	},
	tower_pandas_panda_red_lvl3_attack = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 43,
		from = 22
	},
	tower_pandas_panda_red_lvl3_death = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 87,
		from = 44
	},
	tower_pandas_panda_red_lvl3_scape_loop = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 99,
		from = 88
	},
	tower_pandas_panda_red_lvl3_scape_end = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 117,
		from = 100
	},
	tower_pandas_panda_red_lvl3_idle_torre = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 118,
		from = 118
	},
	tower_pandas_panda_red_lvl3_spell = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 146,
		from = 119
	},
	tower_pandas_panda_red_lvl3_spawn_in = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 156,
		from = 147
	},
	tower_pandas_panda_red_lvl3_spawn_end = {
		prefix = "tower_pandas_panda_red_lvl3",
		to = 176,
		from = 157
	},
	tower_pandas_panda_red_lvl2_idle = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 1,
		from = 1
	},
	tower_pandas_panda_red_lvl2_walk = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 21,
		from = 2
	},
	tower_pandas_panda_red_lvl2_attack = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 43,
		from = 22
	},
	tower_pandas_panda_red_lvl2_death = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 87,
		from = 44
	},
	tower_pandas_panda_red_lvl2_scape_loop = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 99,
		from = 88
	},
	tower_pandas_panda_red_lvl2_scape_end = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 117,
		from = 100
	},
	tower_pandas_panda_red_lvl2_idle_torre = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 118,
		from = 118
	},
	tower_pandas_panda_red_lvl2_spell = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 146,
		from = 119
	},
	tower_pandas_panda_red_lvl2_spawn_in = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 156,
		from = 147
	},
	tower_pandas_panda_red_lvl2_spawn_end = {
		prefix = "tower_pandas_panda_red_lvl2",
		to = 176,
		from = 157
	},
	tower_pandas_panda_red_lvl1_idle = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 1,
		from = 1
	},
	tower_pandas_panda_red_lvl1_walk = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 21,
		from = 2
	},
	tower_pandas_panda_red_lvl1_attack = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 43,
		from = 22
	},
	tower_pandas_panda_red_lvl1_death = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 87,
		from = 44
	},
	tower_pandas_panda_red_lvl1_scape_loop = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 99,
		from = 88
	},
	tower_pandas_panda_red_lvl1_scape_end = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 117,
		from = 100
	},
	tower_pandas_panda_red_lvl1_idle_torre = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 118,
		from = 118
	},
	tower_pandas_panda_red_lvl1_spell = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 146,
		from = 119
	},
	tower_pandas_panda_red_lvl1_spawn_in = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 156,
		from = 147
	},
	tower_pandas_panda_red_lvl1_spawn_end = {
		prefix = "tower_pandas_panda_red_lvl1",
		to = 177,
		from = 157
	},
	tower_pandas_red_lvl4_tp_decal_enemy_run = {
		prefix = "tower_pandas_red_lvl4_tp_decal_enemy",
		to = 20,
		from = 1
	},
	tower_pandas_red_lvl4_tp_decal_run = {
		prefix = "tower_pandas_red_lvl4_tp_decal",
		to = 22,
		from = 1
	},
	tower_pandas_tower_build_idle = {
		prefix = "tower_pandas_tower_build",
		to = 1,
		from = 1
	},
	tower_pandas_tower_lvl_03_idle = {
		prefix = "tower_pandas_tower_lvl_03",
		to = 1,
		from = 1
	},
	tower_pandas_tower_lvl_02_idle = {
		prefix = "tower_pandas_tower_lvl_02",
		to = 1,
		from = 1
	},
	tower_pandas_tower_lvl_01_idle = {
		prefix = "tower_pandas_tower_lvl_01",
		to = 1,
		from = 1
	},
	tower_pandas_lighting_sky_run = {
		prefix = "tower_pandas_lighting_sky",
		to = 24,
		from = 1
	},
	tower_pandas_panda_red_lvl4_idle = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 1,
		from = 1
	},
	tower_pandas_panda_red_lvl4_walk = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 21,
		from = 2
	},
	tower_pandas_panda_red_lvl4_attack = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 55,
		from = 22
	},
	tower_pandas_panda_red_lvl4_skill = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 93,
		from = 56
	},
	tower_pandas_panda_red_lvl4_death = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 125,
		from = 94
	},
	tower_pandas_panda_red_lvl4_scape_loop = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 137,
		from = 126
	},
	tower_pandas_panda_red_lvl4_scape_end = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 159,
		from = 138
	},
	tower_pandas_panda_red_lvl4_spell = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 189,
		from = 160
	},
	tower_pandas_panda_red_lvl4_spawn_in = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 201,
		from = 190
	},
	tower_pandas_panda_red_lvl4_spawn_end = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 229,
		from = 202
	},
	tower_pandas_panda_red_lvl4_idle_torre = {
		prefix = "tower_pandas_panda_red_lvl4",
		to = 230,
		from = 230
	},
	tower_pandas_disappear_wood = {
		prefix = "tower_pandas_panda_green_lvl1",
		to = 87,
		from = 54
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_panda.lua

-- BEGIN kr3/data/animations/tower_ray.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_ray.lua

local a = {
	channeler_tower_sheep_idle = {
		prefix = "channeler_tower_sheep",
		to = 1,
		from = 1
	},
	channeler_tower_sheep_walk = {
		prefix = "channeler_tower_sheep",
		to = 13,
		from = 2
	},
	channeler_tower_sheep_walk_down = {
		prefix = "channeler_tower_sheep",
		to = 25,
		from = 14
	},
	channeler_tower_sheep_walk_up = {
		prefix = "channeler_tower_sheep",
		to = 37,
		from = 26
	},
	channeler_tower_sheep_death = {
		prefix = "channeler_tower_sheep",
		to = 49,
		from = 38
	},
	channeler_tower_sheep_flying_idle = {
		prefix = "channeler_tower_sheep_flying",
		to = 16,
		from = 1
	},
	channeler_tower_sheep_flying_walk = {
		prefix = "channeler_tower_sheep_flying",
		to = 32,
		from = 17
	},
	channeler_tower_sheep_flying_walk_down = {
		prefix = "channeler_tower_sheep_flying",
		to = 48,
		from = 33
	},
	channeler_tower_sheep_flying_walk_up = {
		prefix = "channeler_tower_sheep_flying",
		to = 64,
		from = 49
	},
	channeler_tower_sheep_flying_death = {
		prefix = "channeler_tower_sheep_flying",
		to = 76,
		from = 65
	},
	channeler_tower_sheep_flying_shadow = {
		prefix = "channeler_tower_sheep_flying_shadow",
		to = 1,
		from = 1
	},
	channeler_tower_mutation_fx_big_idle = {
		prefix = "channeler_tower_mutation_fx_big",
		to = 16,
		from = 1
	},
	channeler_tower_mutation_fx_idle = {
		prefix = "channeler_tower_mutation_fx",
		to = 16,
		from = 1
	},
	channeler_tower_mutation_projectile_particle_idle = {
		prefix = "channeler_tower_mutation_projectile_particle",
		to = 8,
		from = 1
	},
	channeler_tower_mutation_tower_fx_idle = {
		prefix = "channeler_tower_mutation_tower_fx",
		to = 21,
		from = 1
	},
	channeler_tower_ray_start_loop = {
		prefix = "channeler_tower_ray_start",
		to = 12,
		from = 1
	},
	channeler_tower_ray_end_loop = {
		prefix = "channeler_tower_ray_end",
		to = 12,
		from = 1
	},
	channeler_tower_ray_loop = {
		prefix = "channeler_tower_ray",
		to = 11,
		from = 1
	},
	channeler_tower_ray_fade = {
		prefix = "channeler_tower_ray",
		to = 19,
		from = 12
	},
	channeler_tower_crystal_union_fx_run = {
		prefix = "channeler_tower_crystal_union_fx",
		to = 21,
		from = 1
	},
	channeler_tower_crystal_full_idle = {
		prefix = "channeler_tower_crystal_full",
		to = 6,
		from = 1
	},
	channeler_tower_preview = {
		prefix = "channeler_tower_preview",
		to = 1,
		from = 1
	},
	channeler_tower_build = {
		prefix = "channeler_tower_build",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_a_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_a_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_a",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_a_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_a",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_2_3_crystal_b_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_b_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_b",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_b_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_b",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_2_3_crystal_c_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_c_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_c",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_c_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_c",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_2_3_crystal_d_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_d_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_d",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_d_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_d",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_2_3_crystal_e_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_e_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_e",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_e_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_e",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_2_3_crystal_f_idle = {
		prefix = "channeler_tower_lvl1_2_3_crystal_f",
		to = 1,
		from = 1
	},
	channeler_tower_lvl1_2_3_crystal_f_union = {
		prefix = "channeler_tower_lvl1_2_3_crystal_f",
		to = 10,
		from = 2
	},
	channeler_tower_lvl1_2_3_crystal_f_break = {
		prefix = "channeler_tower_lvl1_2_3_crystal_f",
		to = 19,
		from = 11
	},
	channeler_tower_lvl1_mage_idle = {
		prefix = "channeler_tower_lvl1_mage",
		to = 48,
		from = 1
	},
	channeler_tower_lvl1_mage_attack_start = {
		prefix = "channeler_tower_lvl1_mage",
		to = 58,
		from = 49
	},
	channeler_tower_lvl1_mage_attack_loop = {
		prefix = "channeler_tower_lvl1_mage",
		to = 70,
		from = 59
	},
	channeler_tower_lvl1_mage_attack_end = {
		prefix = "channeler_tower_lvl1_mage",
		to = 80,
		from = 71
	},
	channeler_tower_lvl1_mage_idle_back = {
		prefix = "channeler_tower_lvl1_mage",
		to = 128,
		from = 81
	},
	channeler_tower_lvl1_mage_attack_back_start = {
		prefix = "channeler_tower_lvl1_mage",
		to = 138,
		from = 129
	},
	channeler_tower_lvl1_mage_attack_back_loop = {
		prefix = "channeler_tower_lvl1_mage",
		to = 150,
		from = 139
	},
	channeler_tower_lvl1_mage_attack_back_end = {
		prefix = "channeler_tower_lvl1_mage",
		to = 160,
		from = 151
	},
	channeler_tower_lvl1_rune_glow_glow_start = {
		prefix = "channeler_tower_lvl1_rune_glow",
		to = 4,
		from = 1
	},
	channeler_tower_lvl1_rune_glow_idle = {
		prefix = "channeler_tower_lvl1_rune_glow",
		to = 5,
		from = 5
	},
	channeler_tower_lvl1_rune_glow_glow_end = {
		prefix = "channeler_tower_lvl1_rune_glow",
		to = 9,
		from = 6
	},
	channeler_tower_lvl1_tower = {
		prefix = "channeler_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_mage_idle = {
		prefix = "channeler_tower_lvl2_mage",
		to = 48,
		from = 1
	},
	channeler_tower_lvl2_mage_attack_start = {
		prefix = "channeler_tower_lvl2_mage",
		to = 58,
		from = 49
	},
	channeler_tower_lvl2_mage_attack_loop = {
		prefix = "channeler_tower_lvl2_mage",
		to = 70,
		from = 59
	},
	channeler_tower_lvl2_mage_attack_end = {
		prefix = "channeler_tower_lvl2_mage",
		to = 80,
		from = 71
	},
	channeler_tower_lvl2_mage_idle_back = {
		prefix = "channeler_tower_lvl2_mage",
		to = 128,
		from = 81
	},
	channeler_tower_lvl2_mage_attack_back_start = {
		prefix = "channeler_tower_lvl2_mage",
		to = 138,
		from = 129
	},
	channeler_tower_lvl2_mage_attack_back_loop = {
		prefix = "channeler_tower_lvl2_mage",
		to = 150,
		from = 139
	},
	channeler_tower_lvl2_mage_attack_back_end = {
		prefix = "channeler_tower_lvl2_mage",
		to = 160,
		from = 151
	},
	channeler_tower_lvl2_stone_a = {
		prefix = "channeler_tower_lvl2_stone_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_stone_b = {
		prefix = "channeler_tower_lvl2_stone_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_stone_c = {
		prefix = "channeler_tower_lvl2_stone_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_stone_d = {
		prefix = "channeler_tower_lvl2_stone_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_stone_e = {
		prefix = "channeler_tower_lvl2_stone_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl2_rune_glow_glow_start = {
		prefix = "channeler_tower_lvl2_rune_glow",
		to = 4,
		from = 1
	},
	channeler_tower_lvl2_rune_glow_idle = {
		prefix = "channeler_tower_lvl2_rune_glow",
		to = 5,
		from = 5
	},
	channeler_tower_lvl2_rune_glow_glow_end = {
		prefix = "channeler_tower_lvl2_rune_glow",
		to = 9,
		from = 6
	},
	channeler_tower_lvl2_tower = {
		prefix = "channeler_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_mage_idle = {
		prefix = "channeler_tower_lvl3_mage",
		to = 48,
		from = 1
	},
	channeler_tower_lvl3_mage_attack_start = {
		prefix = "channeler_tower_lvl3_mage",
		to = 58,
		from = 49
	},
	channeler_tower_lvl3_mage_attack_loop = {
		prefix = "channeler_tower_lvl3_mage",
		to = 70,
		from = 59
	},
	channeler_tower_lvl3_mage_attack_end = {
		prefix = "channeler_tower_lvl3_mage",
		to = 80,
		from = 71
	},
	channeler_tower_lvl3_mage_idle_back = {
		prefix = "channeler_tower_lvl3_mage",
		to = 128,
		from = 81
	},
	channeler_tower_lvl3_mage_attack_back_start = {
		prefix = "channeler_tower_lvl3_mage",
		to = 138,
		from = 129
	},
	channeler_tower_lvl3_mage_attack_back_loop = {
		prefix = "channeler_tower_lvl3_mage",
		to = 150,
		from = 139
	},
	channeler_tower_lvl3_mage_attack_back_end = {
		prefix = "channeler_tower_lvl3_mage",
		to = 160,
		from = 151
	},
	channeler_tower_lvl3_rune_glow_glow_start = {
		prefix = "channeler_tower_lvl3_rune_glow",
		to = 4,
		from = 1
	},
	channeler_tower_lvl3_rune_glow_idle = {
		prefix = "channeler_tower_lvl3_rune_glow",
		to = 5,
		from = 5
	},
	channeler_tower_lvl3_rune_glow_glow_end = {
		prefix = "channeler_tower_lvl3_rune_glow",
		to = 9,
		from = 6
	},
	channeler_tower_lvl3_tower = {
		prefix = "channeler_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_a = {
		prefix = "channeler_tower_lvl3_stone_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_b = {
		prefix = "channeler_tower_lvl3_stone_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_c = {
		prefix = "channeler_tower_lvl3_stone_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_d = {
		prefix = "channeler_tower_lvl3_stone_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_e = {
		prefix = "channeler_tower_lvl3_stone_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl3_stone_f = {
		prefix = "channeler_tower_lvl3_stone_f",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_a_idle = {
		prefix = "channeler_tower_lvl4_crystal_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_a_union = {
		prefix = "channeler_tower_lvl4_crystal_a",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_a_break = {
		prefix = "channeler_tower_lvl4_crystal_a",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_b_idle = {
		prefix = "channeler_tower_lvl4_crystal_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_b_union = {
		prefix = "channeler_tower_lvl4_crystal_b",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_b_break = {
		prefix = "channeler_tower_lvl4_crystal_b",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_c_idle = {
		prefix = "channeler_tower_lvl4_crystal_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_c_union = {
		prefix = "channeler_tower_lvl4_crystal_c",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_c_break = {
		prefix = "channeler_tower_lvl4_crystal_c",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_d_idle = {
		prefix = "channeler_tower_lvl4_crystal_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_d_union = {
		prefix = "channeler_tower_lvl4_crystal_d",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_d_break = {
		prefix = "channeler_tower_lvl4_crystal_d",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_e_idle = {
		prefix = "channeler_tower_lvl4_crystal_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_e_union = {
		prefix = "channeler_tower_lvl4_crystal_e",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_e_break = {
		prefix = "channeler_tower_lvl4_crystal_e",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_f_idle = {
		prefix = "channeler_tower_lvl4_crystal_f",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_f_union = {
		prefix = "channeler_tower_lvl4_crystal_f",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_f_break = {
		prefix = "channeler_tower_lvl4_crystal_f",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_g_idle = {
		prefix = "channeler_tower_lvl4_crystal_g",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_g_union = {
		prefix = "channeler_tower_lvl4_crystal_g",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_g_break = {
		prefix = "channeler_tower_lvl4_crystal_g",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_crystal_h_idle = {
		prefix = "channeler_tower_lvl4_crystal_h",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_crystal_h_union = {
		prefix = "channeler_tower_lvl4_crystal_h",
		to = 10,
		from = 2
	},
	channeler_tower_lvl4_crystal_h_break = {
		prefix = "channeler_tower_lvl4_crystal_h",
		to = 19,
		from = 11
	},
	channeler_tower_lvl4_idle_shock_fx_a_idle = {
		prefix = "channeler_tower_lvl4_idle_shock_fx_a",
		to = 16,
		from = 1
	},
	channeler_tower_lvl4_idle_shock_fx_b_idle = {
		prefix = "channeler_tower_lvl4_idle_shock_fx_b",
		to = 16,
		from = 1
	},
	channeler_tower_lvl4_idle_shock_fx_c_idle = {
		prefix = "channeler_tower_lvl4_idle_shock_fx_c",
		to = 16,
		from = 1
	},
	channeler_tower_lvl4_idle_shock_fx_d_idle = {
		prefix = "channeler_tower_lvl4_idle_shock_fx_d",
		to = 16,
		from = 1
	},
	channeler_tower_lvl4_tower_attack_fx_idle = {
		prefix = "channeler_tower_lvl4_tower_attack_fx",
		to = 16,
		from = 1
	},
	channeler_tower_lvl4_rock_a_idle = {
		prefix = "channeler_tower_lvl4_rock_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_rock_a_glow_start = {
		prefix = "channeler_tower_lvl4_rock_a",
		to = 5,
		from = 2
	},
	channeler_tower_lvl4_rock_a_idle_2 = {
		prefix = "channeler_tower_lvl4_rock_a",
		to = 6,
		from = 6
	},
	channeler_tower_lvl4_rock_a_glow_end = {
		prefix = "channeler_tower_lvl4_rock_a",
		to = 11,
		from = 7
	},
	channeler_tower_lvl4_rock_b_idle = {
		prefix = "channeler_tower_lvl4_rock_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_rock_b_glow_start = {
		prefix = "channeler_tower_lvl4_rock_b",
		to = 5,
		from = 2
	},
	channeler_tower_lvl4_rock_b_idle_2 = {
		prefix = "channeler_tower_lvl4_rock_b",
		to = 6,
		from = 6
	},
	channeler_tower_lvl4_rock_b_glow_end = {
		prefix = "channeler_tower_lvl4_rock_b",
		to = 11,
		from = 7
	},
	channeler_tower_lvl4_rock_c_idle = {
		prefix = "channeler_tower_lvl4_rock_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_rock_c_glow_start = {
		prefix = "channeler_tower_lvl4_rock_c",
		to = 5,
		from = 2
	},
	channeler_tower_lvl4_rock_c_idle_2 = {
		prefix = "channeler_tower_lvl4_rock_c",
		to = 6,
		from = 6
	},
	channeler_tower_lvl4_rock_c_glow_end = {
		prefix = "channeler_tower_lvl4_rock_c",
		to = 11,
		from = 7
	},
	channeler_tower_lvl4_mage_idle = {
		prefix = "channeler_tower_lvl4_mage",
		to = 48,
		from = 1
	},
	channeler_tower_lvl4_mage_attack_start = {
		prefix = "channeler_tower_lvl4_mage",
		to = 58,
		from = 49
	},
	channeler_tower_lvl4_mage_attack_loop = {
		prefix = "channeler_tower_lvl4_mage",
		to = 70,
		from = 59
	},
	channeler_tower_lvl4_mage_attack_end = {
		prefix = "channeler_tower_lvl4_mage",
		to = 80,
		from = 71
	},
	channeler_tower_lvl4_mage_idle_back = {
		prefix = "channeler_tower_lvl4_mage",
		to = 128,
		from = 81
	},
	channeler_tower_lvl4_mage_attack_back_start = {
		prefix = "channeler_tower_lvl4_mage",
		to = 138,
		from = 129
	},
	channeler_tower_lvl4_mage_attack_back_loop = {
		prefix = "channeler_tower_lvl4_mage",
		to = 150,
		from = 139
	},
	channeler_tower_lvl4_mage_attack_back_end = {
		prefix = "channeler_tower_lvl4_mage",
		to = 160,
		from = 151
	},
	channeler_tower_lvl4_rock_core = {
		prefix = "channeler_tower_lvl4_rock_core",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_rock_d = {
		prefix = "channeler_tower_lvl4_rock_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_rock_e = {
		prefix = "channeler_tower_lvl4_rock_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_a = {
		prefix = "channeler_tower_lvl4_stone_a",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_b = {
		prefix = "channeler_tower_lvl4_stone_b",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_c = {
		prefix = "channeler_tower_lvl4_stone_c",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_d = {
		prefix = "channeler_tower_lvl4_stone_d",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_e = {
		prefix = "channeler_tower_lvl4_stone_e",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_f = {
		prefix = "channeler_tower_lvl4_stone_f",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_g = {
		prefix = "channeler_tower_lvl4_stone_g",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_h = {
		prefix = "channeler_tower_lvl4_stone_h",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_i = {
		prefix = "channeler_tower_lvl4_stone_i",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_j = {
		prefix = "channeler_tower_lvl4_stone_j",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_k = {
		prefix = "channeler_tower_lvl4_stone_k",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_stone_l = {
		prefix = "channeler_tower_lvl4_stone_l",
		to = 1,
		from = 1
	},
	channeler_tower_lvl4_tower_shadow = {
		prefix = "channeler_tower_lvl4_tower_shadow",
		to = 1,
		from = 1
	},
	channeler_tower_towers_decal = {
		prefix = "channeler_tower_towers_decal",
		to = 1,
		from = 1
	}
}
local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_ray.lua

-- BEGIN kr3/data/animations/tower_rocket_gunners.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_rocket_gunners.lua

local a = {
	rocket_gunners_tower_sting_missiles_floor_decal_smoke_idle = {
		prefix = "rocket_gunners_tower_sting_missiles_floor_decal_smoke",
		to = 24,
		from = 1
	},
	rocket_gunners_tower_sting_missiles_floor_decal = {
		prefix = "rocket_gunners_tower_sting_missiles_floor_decal",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_reticle_start = {
		prefix = "rocket_gunners_tower_reticle",
		to = 8,
		from = 1
	},
	rocket_gunners_tower_reticle_idle = {
		prefix = "rocket_gunners_tower_reticle",
		to = 12,
		from = 9
	},
	rocket_gunners_tower_lvl4_tower_idle = {
		prefix = "rocket_gunners_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_lvl4_tower_spawn = {
		prefix = "rocket_gunners_tower_lvl4_tower",
		to = 62,
		from = 2
	},
	rocket_gunners_tower_lvl3_tower_idle = {
		prefix = "rocket_gunners_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_lvl3_tower_spawn = {
		prefix = "rocket_gunners_tower_lvl3_tower",
		to = 62,
		from = 2
	},
	rocket_gunners_tower_lvl2_tower_idle = {
		prefix = "rocket_gunners_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_lvl2_tower_spawn = {
		prefix = "rocket_gunners_tower_lvl2_tower",
		to = 62,
		from = 2
	},
	rocket_gunners_tower_lvl1_tower_idle = {
		prefix = "rocket_gunners_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_lvl1_tower_spawn = {
		prefix = "rocket_gunners_tower_lvl1_tower",
		to = 62,
		from = 2
	},
	rocket_gunners_tower_preview = {
		prefix = "rocket_gunners_tower_preview",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_build = {
		prefix = "rocket_gunners_tower_build",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_phosphoric_coating_explosion_air_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_explosion_air",
		to = 18,
		from = 1
	},
	rocket_gunners_tower_phosphoric_coating_explosion_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_explosion",
		to = 21,
		from = 1
	},
	rocket_gunners_tower_sting_missiles_particles_idle = {
		prefix = "rocket_gunners_tower_sting_missiles_particles",
		to = 9,
		from = 1
	},
	rocket_gunners_tower_sting_missiles_projectile_idle = {
		prefix = "rocket_gunners_tower_sting_missiles_projectile",
		to = 3,
		from = 1
	},
	rocket_gunners_tower_phosphoric_coating_trace_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_trace",
		to = 2,
		from = 1
	},
	rocket_gunners_tower_phosphoric_coating_hit_fx_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_hit_fx",
		to = 22,
		from = 1
	},
	rocket_gunners_tower_phosphoric_coating_hit_fx_floor_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_hit_fx_floor",
		to = 25,
		from = 1
	},
	rocket_gunners_tower_hit_fx_idle = {
		prefix = "rocket_gunners_tower_hit_fx",
		to = 8,
		from = 1
	},
	rocket_gunners_tower_hit_fx_floor_idle = {
		prefix = "rocket_gunners_tower_hit_fx_floor",
		to = 25,
		from = 1
	},
	rocket_gunners_tower_take_off_fx_idle = {
		prefix = "rocket_gunners_tower_take_off_fx",
		to = 17,
		from = 1
	},
	rocket_gunners_tower_landing_fx_idle = {
		prefix = "rocket_gunners_tower_landing_fx",
		to = 15,
		from = 1
	},
	rocket_gunners_tower_lvl4_gunner_idle_air = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 24,
		from = 1
	},
	rocket_gunners_tower_lvl4_gunner_idle_air_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 32,
		from = 25
	},
	rocket_gunners_tower_lvl4_gunner_idle_floor = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 33,
		from = 33
	},
	rocket_gunners_tower_lvl4_gunner_attack_air = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 55,
		from = 34
	},
	rocket_gunners_tower_lvl4_gunner_attack_air_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 77,
		from = 56
	},
	rocket_gunners_tower_lvl4_gunner_attack_floor = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 99,
		from = 78
	},
	rocket_gunners_tower_lvl4_gunner_attack_floor_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 121,
		from = 100
	},
	rocket_gunners_tower_lvl4_gunner_phosphoric_coating_air = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 143,
		from = 122
	},
	rocket_gunners_tower_lvl4_gunner_phosphoric_coating_air_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 165,
		from = 144
	},
	rocket_gunners_tower_lvl4_gunner_phosphoric_coating_floor = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 187,
		from = 166
	},
	rocket_gunners_tower_lvl4_gunner_phosphoric_coating_floor_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 209,
		from = 188
	},
	rocket_gunners_tower_lvl4_gunner_sting_missiles_air = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 241,
		from = 210
	},
	rocket_gunners_tower_lvl4_gunner_sting_missiles_floor = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 273,
		from = 242
	},
	rocket_gunners_tower_lvl4_gunner_walk = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 293,
		from = 274
	},
	rocket_gunners_tower_lvl4_gunner_landing = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 297,
		from = 294
	},
	rocket_gunners_tower_lvl4_gunner_take_off = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 303,
		from = 298
	},
	rocket_gunners_tower_lvl4_gunner_death_air = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 333,
		from = 304
	},
	rocket_gunners_tower_lvl4_gunner_death_floor = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 379,
		from = 334
	},
	rocket_gunners_tower_lvl3_gunner_idle_air = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 24,
		from = 1
	},
	rocket_gunners_tower_lvl3_gunner_idle_air_back = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 32,
		from = 25
	},
	rocket_gunners_tower_lvl3_gunner_idle_floor = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 33,
		from = 33
	},
	rocket_gunners_tower_lvl3_gunner_attack_air = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 55,
		from = 34
	},
	rocket_gunners_tower_lvl3_gunner_attack_air_back = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 77,
		from = 56
	},
	rocket_gunners_tower_lvl3_gunner_attack_floor = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 99,
		from = 78
	},
	rocket_gunners_tower_lvl3_gunner_attack_floor_back = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 121,
		from = 100
	},
	rocket_gunners_tower_lvl3_gunner_walk = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 141,
		from = 122
	},
	rocket_gunners_tower_lvl3_gunner_landing = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 145,
		from = 142
	},
	rocket_gunners_tower_lvl3_gunner_take_off = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 151,
		from = 146
	},
	rocket_gunners_tower_lvl3_gunner_death_air = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 181,
		from = 152
	},
	rocket_gunners_tower_lvl3_gunner_death_floor = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_lvl2_gunner_idle_air = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 24,
		from = 1
	},
	rocket_gunners_tower_lvl2_gunner_idle_air_back = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 32,
		from = 25
	},
	rocket_gunners_tower_lvl2_gunner_idle = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 33,
		from = 33
	},
	rocket_gunners_tower_lvl2_gunner_idle_floor = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 33,
		from = 33
	},
	rocket_gunners_tower_lvl2_gunner_attack_air = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 55,
		from = 34
	},
	rocket_gunners_tower_lvl2_gunner_attack_air_back = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 77,
		from = 56
	},
	rocket_gunners_tower_lvl2_gunner_attack_floor = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 99,
		from = 78
	},
	rocket_gunners_tower_lvl2_gunner_attack_floor_back = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 121,
		from = 100
	},
	rocket_gunners_tower_lvl2_gunner_walk = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 141,
		from = 122
	},
	rocket_gunners_tower_lvl2_gunner_landing = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 145,
		from = 142
	},
	rocket_gunners_tower_lvl2_gunner_take_off = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 151,
		from = 146
	},
	rocket_gunners_tower_lvl2_gunner_death_air = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 181,
		from = 152
	},
	rocket_gunners_tower_lvl2_gunner_death_floor = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_lvl1_gunner_idle_air = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 24,
		from = 1
	},
	rocket_gunners_tower_lvl1_gunner_idle_air_back = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 32,
		from = 25
	},
	rocket_gunners_tower_lvl1_gunner_idle_floor = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 33,
		from = 33
	},
	rocket_gunners_tower_lvl1_gunner_attack_air = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 55,
		from = 34
	},
	rocket_gunners_tower_lvl1_gunner_attack_air_back = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 77,
		from = 56
	},
	rocket_gunners_tower_lvl1_gunner_attack_floor = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 99,
		from = 78
	},
	rocket_gunners_tower_lvl1_gunner_attack_floor_back = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 121,
		from = 100
	},
	rocket_gunners_tower_lvl1_gunner_walk = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 141,
		from = 122
	},
	rocket_gunners_tower_lvl1_gunner_landing = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 145,
		from = 142
	},
	rocket_gunners_tower_lvl1_gunner_take_off = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 151,
		from = 146
	},
	rocket_gunners_tower_lvl1_gunner_death_air = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 181,
		from = 152
	},
	rocket_gunners_tower_lvl1_gunner_death_floor = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_gunner_shadow = {
		prefix = "rocket_gunners_tower_gunner_shadow",
		to = 1,
		from = 1
	},
	rocket_gunners_tower_lvl1_gunner_death = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_lvl2_gunner_death = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_lvl3_gunner_death = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 227,
		from = 182
	},
	rocket_gunners_tower_lvl4_gunner_death = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 379,
		from = 334
	},
	rocket_gunners_tower_lvl1_gunner_idle_floor_back = {
		prefix = "rocket_gunners_tower_lvl1_gunner",
		to = 121,
		from = 121
	},
	rocket_gunners_tower_lvl2_gunner_idle_floor_back = {
		prefix = "rocket_gunners_tower_lvl2_gunner",
		to = 121,
		from = 121
	},
	rocket_gunners_tower_lvl3_gunner_idle_floor_back = {
		prefix = "rocket_gunners_tower_lvl3_gunner",
		to = 121,
		from = 121
	},
	rocket_gunners_tower_lvl4_gunner_idle_floor_back = {
		prefix = "rocket_gunners_tower_lvl4_gunner",
		to = 121,
		from = 121
	},
	rocket_gunners_tower_phosphoric_coating_hit_fx_idle = {
		prefix = "rocket_gunners_tower_phosphoric_coating_hit_fx",
		to = 12,
		from = 1
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_rocket_gunners.lua

-- BEGIN kr3/data/animations/tower_royal_archers.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_royal_archers.lua

local a = {
	royal_archer_tower_lvl4_tower_rapacious_hunter_base = {
		prefix = "royal_archer_tower_lvl4_tower_rapacious_hunter_base",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl4_tower_front = {
		prefix = "royal_archer_tower_lvl4_tower_front",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl4_tower = {
		prefix = "royal_archer_tower_lvl4_tower",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl3_tower_front = {
		prefix = "royal_archer_tower_lvl3_tower_front",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl3_tower = {
		prefix = "royal_archer_tower_lvl3_tower",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl2_tower_front = {
		prefix = "royal_archer_tower_lvl2_tower_front",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl2_tower = {
		prefix = "royal_archer_tower_lvl2_tower",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl1_tower_front = {
		prefix = "royal_archer_tower_lvl1_tower_front",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl1_tower = {
		prefix = "royal_archer_tower_lvl1_tower",
		to = 1,
		from = 1
	},
	royal_archer_tower_build = {
		prefix = "royal_archer_tower_build",
		to = 1,
		from = 1
	},
	royal_archer_tower_preview = {
		prefix = "royal_archer_tower_preview",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_armor_breaker_hit_fx_armor_breaker_hit_fx = {
		prefix = "royal_archer_tower_royal_archer_lvl4_armor_breaker_hit_fx",
		to = 6,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_hit_fx_rapacious_hunter_hit_fx = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_hit_fx",
		to = 7,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_attack_particle_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_attack_particle",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle",
		to = 20,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_attack_in = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle",
		to = 26,
		from = 21
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_projectile = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle",
		to = 27,
		from = 27
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle_attack_out = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_eagle",
		to = 33,
		from = 28
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_idle_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 39,
		from = 2
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_leave = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 61,
		from = 40
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_idle_3 = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 62,
		from = 62
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_cheer_up = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 96,
		from = 63
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_return = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 108,
		from = 97
	},
	royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer_in_animation = {
		prefix = "royal_archer_tower_royal_archer_lvl4_rapacious_hunter_tamer",
		to = 127,
		from = 109
	},
	royal_archer_tower_royal_archer_lvl4_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl4",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl4_attack_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl4",
		to = 20,
		from = 2
	},
	royal_archer_tower_royal_archer_lvl4_idle_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl4",
		to = 21,
		from = 21
	},
	royal_archer_tower_royal_archer_lvl4_attack_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl4",
		to = 40,
		from = 22
	},
	royal_archer_tower_royal_archer_lvl4_armor_piercer = {
		prefix = "royal_archer_tower_royal_archer_lvl4",
		to = 108,
		from = 41
	},
	royal_archer_tower_royal_archer_lvl3_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl3",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl3_attack_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl3",
		to = 20,
		from = 2
	},
	royal_archer_tower_royal_archer_lvl3_idle_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl3",
		to = 21,
		from = 21
	},
	royal_archer_tower_royal_archer_lvl3_attack_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl3",
		to = 40,
		from = 22
	},
	royal_archer_tower_royal_archer_lvl2_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl2",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl2_attack_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl2",
		to = 20,
		from = 2
	},
	royal_archer_tower_royal_archer_lvl2_idle_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl2",
		to = 21,
		from = 21
	},
	royal_archer_tower_royal_archer_lvl2_attack_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl2",
		to = 40,
		from = 22
	},
	royal_archer_tower_royal_archer_lvl1_idle_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl1",
		to = 1,
		from = 1
	},
	royal_archer_tower_royal_archer_lvl1_attack_1 = {
		prefix = "royal_archer_tower_royal_archer_lvl1",
		to = 20,
		from = 2
	},
	royal_archer_tower_royal_archer_lvl1_idle_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl1",
		to = 21,
		from = 21
	},
	royal_archer_tower_royal_archer_lvl1_attack_2 = {
		prefix = "royal_archer_tower_royal_archer_lvl1",
		to = 40,
		from = 22
	},
	royal_archer_tower_lvl4_arrow_armor_piercer_trail_particle_idle_1 = {
		prefix = "royal_archer_tower_lvl4_arrow_armor_piercer_trail_particle",
		to = 10,
		from = 1
	},
	royal_archer_tower_lvl4_arrow_armor_piercer_idle_1 = {
		prefix = "royal_archer_tower_lvl4_arrow_armor_piercer",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl4_arrow_armor_piercer_idle_2 = {
		prefix = "royal_archer_tower_lvl4_arrow_armor_piercer",
		to = 2,
		from = 2
	},
	royal_archer_tower_lvl4_arrow_idle_1 = {
		prefix = "royal_archer_tower_lvl4_arrow",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl4_arrow_idle_2 = {
		prefix = "royal_archer_tower_lvl4_arrow",
		to = 2,
		from = 2
	},
	royal_archer_tower_lvl1_arrow_idle_1 = {
		prefix = "royal_archer_tower_lvl1_arrow",
		to = 1,
		from = 1
	},
	royal_archer_tower_lvl1_arrow_idle_2 = {
		prefix = "royal_archer_tower_lvl1_arrow",
		to = 2,
		from = 2
	}
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_royal_archers.lua

-- BEGIN kr3/data/animations/tower_sand.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_sand.lua

local a = {
	tower_sand_basic_hit = {
		prefix = "tower_sand_basic_hit",
		to = 6,
		from = 1
	},
	tower_sand_build = {
		prefix = "tower_sand_build",
		to = 1,
		from = 1
	},
	tower_sand_preview = {
		prefix = "tower_sand_preview",
		to = 1,
		from = 1
	},
	tower_sand_lvl1_tower_front_idle = {
		prefix = "tower_sand_lvl1_tower_front",
		to = 1,
		from = 1
	},
	tower_sand_lvl1_tower_idle = {
		prefix = "tower_sand_lvl1_tower",
		to = 1,
		from = 1
	},
	tower_sand_lvl1_sentinel_idle = {
		prefix = "tower_sand_lvl1_sentinel",
		to = 1,
		from = 1
	},
	tower_sand_lvl1_sentinel_attack = {
		prefix = "tower_sand_lvl1_sentinel",
		to = 25,
		from = 2
	},
	tower_sand_lvl1_sentinel_idle_back = {
		prefix = "tower_sand_lvl1_sentinel",
		to = 26,
		from = 26
	},
	tower_sand_lvl1_sentinel_attack_back = {
		prefix = "tower_sand_lvl1_sentinel",
		to = 50,
		from = 27
	},
	tower_sand_lvl1_projectile_idle = {
		prefix = "tower_sand_lvl1_projectile",
		to = 3,
		from = 1
	},
	tower_sand_lvl1_particle_idle = {
		prefix = "tower_sand_lvl1_particle",
		to = 7,
		from = 1
	},
	tower_sand_lvl2_tower = {
		prefix = "tower_sand_lvl2_tower",
		to = 1,
		from = 1
	},
	tower_sand_lvl2_sentinel_idle = {
		prefix = "tower_sand_lvl2_sentinel",
		to = 1,
		from = 1
	},
	tower_sand_lvl2_sentinel_attack = {
		prefix = "tower_sand_lvl2_sentinel",
		to = 25,
		from = 2
	},
	tower_sand_lvl2_sentinel_idle_back = {
		prefix = "tower_sand_lvl2_sentinel",
		to = 26,
		from = 26
	},
	tower_sand_lvl2_sentinel_attack_back = {
		prefix = "tower_sand_lvl2_sentinel",
		to = 50,
		from = 27
	},
	tower_sand_lvl3_tower_idle = {
		prefix = "tower_sand_lvl3_tower",
		to = 1,
		from = 1
	},
	tower_sand_lvl3_sentinel_idle = {
		prefix = "tower_sand_lvl3_sentinel",
		to = 1,
		from = 1
	},
	tower_sand_lvl3_sentinel_attack = {
		prefix = "tower_sand_lvl3_sentinel",
		to = 25,
		from = 2
	},
	tower_sand_lvl3_sentinel_idle_back = {
		prefix = "tower_sand_lvl3_sentinel",
		to = 26,
		from = 26
	},
	tower_sand_lvl3_sentinel_attack_back = {
		prefix = "tower_sand_lvl3_sentinel",
		to = 50,
		from = 27
	},
	tower_sand_lvl4_skill_1_projectile_idle = {
		prefix = "tower_sand_lvl4_skill_1_projectile",
		to = 3,
		from = 1
	},
	tower_sand_lvl4_skill_1_particle_idle = {
		prefix = "tower_sand_lvl4_skill_1_particle",
		to = 7,
		from = 1
	},
	tower_sand_lvl4_skill_1_hit = {
		prefix = "tower_sand_lvl4_skill_1_hit",
		to = 6,
		from = 1
	},
	tower_sand_lvl4_skill_1_coins_hit = {
		prefix = "tower_sand_lvl4_skill_1_coins_hit",
		to = 16,
		from = 1
	},
	tower_sand_lvl4_skill_2_decal_in = {
		prefix = "tower_sand_lvl4_skill_2_decal",
		to = 10,
		from = 1
	},
	tower_sand_lvl4_skill_2_decal_loop = {
		prefix = "tower_sand_lvl4_skill_2_decal",
		to = 25,
		from = 11
	},
	tower_sand_lvl4_skill_2_decal_out = {
		prefix = "tower_sand_lvl4_skill_2_decal",
		to = 47,
		from = 26
	},
	tower_sand_lvl4_skill_2_projectile_idle = {
		prefix = "tower_sand_lvl4_skill_2_projectile",
		to = 3,
		from = 1
	},
	tower_sand_lvl4_skill_2_particle_idle = {
		prefix = "tower_sand_lvl4_skill_2_particle",
		to = 8,
		from = 1
	},
	tower_sand_lvl4_skill_2_hit_FX_loop = {
		prefix = "tower_sand_lvl4_skill_2_hit_FX",
		to = 10,
		from = 1
	},
	tower_sand_lvl4_particle_idle = {
		prefix = "tower_sand_lvl4_particle",
		to = 7,
		from = 1
	},
	tower_sand_lvl4_projectile_idle = {
		prefix = "tower_sand_lvl4_projectile",
		to = 3,
		from = 1
	},
	tower_sand_lvl4_sentinel_idle = {
		prefix = "tower_sand_lvl4_sentinel",
		to = 1,
		from = 1
	},
	tower_sand_lvl4_sentinel_attack = {
		prefix = "tower_sand_lvl4_sentinel",
		to = 25,
		from = 2
	},
	tower_sand_lvl4_sentinel_idle_back = {
		prefix = "tower_sand_lvl4_sentinel",
		to = 26,
		from = 26
	},
	tower_sand_lvl4_sentinel_attack_back = {
		prefix = "tower_sand_lvl4_sentinel",
		to = 50,
		from = 27
	},
	tower_sand_lvl4_sentinel_skill1 = {
		prefix = "tower_sand_lvl4_sentinel",
		to = 81,
		from = 51
	},
	tower_sand_lvl4_tower_front_idle = {
		prefix = "tower_sand_lvl4_tower_front",
		to = 1,
		from = 1
	},
	tower_sand_lvl4_tower_idle = {
		prefix = "tower_sand_lvl4_tower",
		to = 1,
		from = 1
	},
	tower_sand_lvl4_tower_skill2 = {
		prefix = "tower_sand_lvl4_tower",
		to = 53,
		from = 2
	}
}

local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_sand.lua

-- BEGIN kr3/data/animations/tower_sparking_geode.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_sparking_geode.lua

local a = {
	sparking_geode_evolve_run = {
		prefix = "sparking_geode_evolve",
		to = 19,
		from = 1
	},
	sparking_geode_longray_decal_up_run = {
		prefix = "sparking_geode_longray_decal_up",
		to = 14,
		from = 1
	},
	sparking_geode_longray_ray_down = {
		prefix = "sparking_geode_longray",
		to = 12,
		from = 1
	},
	sparking_geode_longray_ray_up = {
		prefix = "sparking_geode_longray",
		to = 24,
		from = 13
	},
	sparking_geode_longray_decal_down_run = {
		prefix = "sparking_geode_longray_decal_down",
		to = 15,
		from = 1
	},
	sparking_geode_electric_decal_1_idle = {
		prefix = "sparking_geode_electric_decal_1",
		to = 42,
		from = 1
	},
	sparking_geode_electric_decal_2_idle = {
		prefix = "sparking_geode_electric_decal_2",
		to = 34,
		from = 1
	},
	sparking_geode_modifier_run = {
		prefix = "sparking_geode_modifier",
		to = 6,
		from = 1
	},
	sparking_geode_cystal_fx_in = {
		prefix = "sparking_geode_cystal_fx",
		to = 19,
		from = 1
	},
	sparking_geode_cystal_fx_idle = {
		prefix = "sparking_geode_cystal_fx",
		to = 53,
		from = 20
	},
	sparking_geode_cystal_fx_death = {
		prefix = "sparking_geode_cystal_fx",
		to = 67,
		from = 54
	},
	sparking_geode_crystal_big_in = {
		prefix = "sparking_geode_crystal_big",
		to = 19,
		from = 1
	},
	sparking_geode_crystal_big_idle = {
		prefix = "sparking_geode_crystal_big",
		to = 53,
		from = 20
	},
	sparking_geode_crystal_mid_in = {
		prefix = "sparking_geode_crystal_mid",
		to = 19,
		from = 1
	},
	sparking_geode_crystal_mid_idle = {
		prefix = "sparking_geode_crystal_mid",
		to = 53,
		from = 20
	},
	sparking_geode_crystal_small_in = {
		prefix = "sparking_geode_crystal_small",
		to = 19,
		from = 1
	},
	sparking_geode_crystal_small_idle = {
		prefix = "sparking_geode_crystal_small",
		to = 53,
		from = 20
	},
	sparking_geode_tower_attack_fx_attack_in = {
		prefix = "sparking_geode_tower_attack_fx",
		to = 24,
		from = 1
	},
	sparking_geode_tower_attack_fx_attack_loop = {
		prefix = "sparking_geode_tower_attack_fx",
		to = 56,
		from = 25
	},
	sparking_geode_tower_attack_fx_attack_out = {
		prefix = "sparking_geode_tower_attack_fx",
		to = 81,
		from = 57
	},
	sparking_geode_ray_rebote_hit = {
		prefix = "sparking_geode_longray_decal_up",
		to = 14,
		from = 4
	},
	sparking_geode_ray_rebote_run = {
		prefix = "sparking_geode_ray_rebote",
		to = 12,
		from = 1
	},
	sparking_geode_ray_run = {
		prefix = "sparking_geode_ray",
		to = 16,
		from = 1
	},
	sparking_geode_construction_run = {
		prefix = "sparking_geode_construction",
		to = 1,
		from = 1
	},
	sparking_geode_preview_run = {
		prefix = "sparking_geode_preview",
		to = 1,
		from = 1
	},
	sparking_geode_base_lvl1_idle = {
		prefix = "sparking_geode_base_lvl1",
		to = 1,
		from = 1
	},
	sparking_geode_base_off_idle = {
		prefix = "sparking_geode_base",
		to = 2,
		from = 1
	},
	sparking_geode_base_on_anim = {
		prefix = "sparking_geode_base",
		to = 8,
		from = 3
	},
	sparking_geode_base_on_loop = {
		prefix = "sparking_geode_base",
		to = 26,
		from = 9
	},
	sparking_geode_base_off_anim = {
		prefix = "sparking_geode_base",
		to = 30,
		from = 27
	},
	sparking_geode_tower_lvl1_idleup = {
		prefix = "sparking_geode_tower_lvl1",
		to = 38,
		from = 1
	},
	sparking_geode_tower_lvl1_attack_in = {
		prefix = "sparking_geode_tower_lvl1",
		to = 62,
		from = 39
	},
	sparking_geode_tower_lvl1_attack_loop = {
		prefix = "sparking_geode_tower_lvl1",
		to = 94,
		from = 63
	},
	sparking_geode_tower_lvl1_attack_out = {
		prefix = "sparking_geode_tower_lvl1",
		to = 118,
		from = 95
	},
	sparking_geode_tower_lvl2_idleup = {
		prefix = "sparking_geode_tower_lvl2",
		to = 38,
		from = 1
	},
	sparking_geode_tower_lvl2_attack_in = {
		prefix = "sparking_geode_tower_lvl2",
		to = 62,
		from = 39
	},
	sparking_geode_tower_lvl2_attack_loop = {
		prefix = "sparking_geode_tower_lvl2",
		to = 94,
		from = 63
	},
	sparking_geode_tower_lvl2_attack_out = {
		prefix = "sparking_geode_tower_lvl2",
		to = 118,
		from = 95
	},
	sparking_geode_tower_lvl3_idleup = {
		prefix = "sparking_geode_tower_lvl3",
		to = 38,
		from = 1
	},
	sparking_geode_tower_lvl3_attack_in = {
		prefix = "sparking_geode_tower_lvl3",
		to = 62,
		from = 39
	},
	sparking_geode_tower_lvl3_attack_loop = {
		prefix = "sparking_geode_tower_lvl3",
		to = 94,
		from = 63
	},
	sparking_geode_tower_lvl3_attack_out = {
		prefix = "sparking_geode_tower_lvl3",
		to = 118,
		from = 95
	},
	sparking_geode_tower_lvl4_idleup = {
		prefix = "sparking_geode_tower_lvl4",
		to = 36,
		from = 1
	},
	sparking_geode_tower_lvl4_attack_in = {
		prefix = "sparking_geode_tower_lvl4",
		to = 60,
		from = 37
	},
	sparking_geode_tower_lvl4_attack_loop = {
		prefix = "sparking_geode_tower_lvl4",
		to = 92,
		from = 61
	},
	sparking_geode_tower_lvl4_attack_out = {
		prefix = "sparking_geode_tower_lvl4",
		to = 116,
		from = 93
	},
	sparking_geode_tower_lvl4_hability_1 = {
		prefix = "sparking_geode_tower_lvl4",
		to = 140,
		from = 117
	},
	sparking_geode_tower_lvl4_hability_2 = {
		prefix = "sparking_geode_tower_lvl4",
		to = 182,
		from = 141
	}
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_sparking_geode.lua

-- BEGIN kr3/data/animations/tower_stargazers.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/tower_stargazers.lua

local a = {
	elven_stargazers_tower_mark_start = {
		prefix = "elven_stargazers_tower_mark",
		to = 15,
		from = 1
	},
	elven_stargazers_tower_mark_idle = {
		prefix = "elven_stargazers_tower_mark",
		to = 16,
		from = 16
	},
	elven_stargazers_tower_ray_idle = {
		prefix = "elven_stargazers_tower_ray",
		to = 33,
		from = 1
	},
	elven_stargazers_tower_ray_end_loop = {
		prefix = "elven_stargazers_tower_ray_end",
		to = 12,
		from = 1
	},
	elven_stargazers_tower_ray_end_end = {
		prefix = "elven_stargazers_tower_ray_end",
		to = 28,
		from = 13
	},
	elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1_start = {
		prefix = "elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1",
		to = 10,
		from = 1
	},
	elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1_loop = {
		prefix = "elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1",
		to = 21,
		from = 11
	},
	elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1_end = {
		prefix = "elven_stargazers_tower_ray_start_lvl3_lvl2_lvl1",
		to = 33,
		from = 22
	},
	elven_stargazers_tower_ray_start_lvl4_start = {
		prefix = "elven_stargazers_tower_ray_start_lvl4",
		to = 10,
		from = 1
	},
	elven_stargazers_tower_ray_start_lvl4_loop = {
		prefix = "elven_stargazers_tower_ray_start_lvl4",
		to = 21,
		from = 11
	},
	elven_stargazers_tower_ray_start_lvl4_end = {
		prefix = "elven_stargazers_tower_ray_start_lvl4",
		to = 34,
		from = 22
	},
	elven_stargazers_tower_rising_star_explosion_idle = {
		prefix = "elven_stargazers_tower_rising_star_explosion",
		to = 15,
		from = 1
	},
	elven_stargazers_tower_rising_star_particle_trail_idle = {
		prefix = "elven_stargazers_tower_rising_star_particle_trail",
		to = 7,
		from = 1
	},
	elven_stargazers_tower_rising_star_star_spawn = {
		prefix = "elven_stargazers_tower_rising_star_star",
		to = 4,
		from = 1
	},
	elven_stargazers_tower_rising_star_star_idle = {
		prefix = "elven_stargazers_tower_rising_star_star",
		to = 4,
		from = 4
	},
	elven_stargazers_tower_rising_star_hit_fx_idle = {
		prefix = "elven_stargazers_tower_rising_star_hit_fx",
		to = 15,
		from = 1
	},
	elven_stargazers_tower_event_horizon_idle = {
		prefix = "elven_stargazers_tower_event_horizon",
		to = 31,
		from = 1
	},
	elven_stargazers_tower_event_horizon_decal_idle = {
		prefix = "elven_stargazers_tower_event_horizon_decal",
		to = 25,
		from = 1
	},
	elven_stargazers_tower_event_horizon_decal_big_idle = {
		prefix = "elven_stargazers_tower_event_horizon_decal_big",
		to = 25,
		from = 1
	},
	elven_stargazers_tower_event_horizon_tower_fx_idle = {
		prefix = "elven_stargazers_tower_event_horizon_tower_fx",
		to = 64,
		from = 1
	},
	elven_stargazers_tower_lvl1_elf_idle = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_lvl1_elf_attack_in = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 15,
		from = 2
	},
	elven_stargazers_tower_lvl1_elf_attack_loop = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 19,
		from = 16
	},
	elven_stargazers_tower_lvl1_elf_attack_out = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 29,
		from = 20
	},
	elven_stargazers_tower_lvl1_elf_idle_back = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 30,
		from = 30
	},
	elven_stargazers_tower_lvl1_elf_attack_in_back = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 44,
		from = 31
	},
	elven_stargazers_tower_lvl1_elf_attack_loop_back = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 48,
		from = 45
	},
	elven_stargazers_tower_lvl1_elf_attack_out_back = {
		prefix = "elven_stargazers_tower_lvl1_elf",
		to = 58,
		from = 49
	},
	elven_stargazers_tower_lvl2_elf_idle = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_lvl2_elf_attack_in = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 15,
		from = 2
	},
	elven_stargazers_tower_lvl2_elf_attack_loop = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 19,
		from = 16
	},
	elven_stargazers_tower_lvl2_elf_attack_out = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 29,
		from = 20
	},
	elven_stargazers_tower_lvl2_elf_idle_back = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 30,
		from = 30
	},
	elven_stargazers_tower_lvl2_elf_attack_in_back = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 44,
		from = 31
	},
	elven_stargazers_tower_lvl2_elf_attack_loop_back = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 48,
		from = 45
	},
	elven_stargazers_tower_lvl2_elf_attack_out_back = {
		prefix = "elven_stargazers_tower_lvl2_elf",
		to = 58,
		from = 49
	},
	elven_stargazers_tower_lvl3_elf_idle = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_lvl3_elf_attack_in = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 15,
		from = 2
	},
	elven_stargazers_tower_lvl3_elf_attack_loop = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 19,
		from = 16
	},
	elven_stargazers_tower_lvl3_elf_attack_out = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 29,
		from = 20
	},
	elven_stargazers_tower_lvl3_elf_idle_back = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 30,
		from = 30
	},
	elven_stargazers_tower_lvl3_elf_attack_in_back = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 44,
		from = 31
	},
	elven_stargazers_tower_lvl3_elf_attack_loop_back = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 48,
		from = 45
	},
	elven_stargazers_tower_lvl3_elf_attack_out_back = {
		prefix = "elven_stargazers_tower_lvl3_elf",
		to = 58,
		from = 49
	},
	elven_stargazers_tower_lvl4_elf_idle = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_lvl4_elf_attack_in = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 15,
		from = 2
	},
	elven_stargazers_tower_lvl4_elf_attack_loop = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 19,
		from = 16
	},
	elven_stargazers_tower_lvl4_elf_attack_out = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 29,
		from = 20
	},
	elven_stargazers_tower_lvl4_elf_idle_back = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 30,
		from = 30
	},
	elven_stargazers_tower_lvl4_elf_attack_in_back = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 44,
		from = 31
	},
	elven_stargazers_tower_lvl4_elf_attack_loop_back = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 48,
		from = 45
	},
	elven_stargazers_tower_lvl4_elf_attack_out_back = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 58,
		from = 49
	},
	elven_stargazers_tower_lvl4_elf_attack_in_event_horizon = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 70,
		from = 59
	},
	elven_stargazers_tower_lvl4_elf_attack_loop_event_horizon = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 82,
		from = 71
	},
	elven_stargazers_tower_lvl4_elf_attack_out_event_horizon = {
		prefix = "elven_stargazers_tower_lvl4_elf",
		to = 98,
		from = 83
	},
	elven_stargazers_tower_preview = {
		prefix = "elven_stargazers_tower_preview",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_build = {
		prefix = "elven_stargazers_tower_build",
		to = 1,
		from = 1
	},
	elven_stargazers_tower_lvl1_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "elven_stargazers_tower_lvl1_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	elven_stargazers_tower_lvl1_tower_layerX_attack_in = {
		layer_to = 3,
		from = 2,
		layer_prefix = "elven_stargazers_tower_lvl1_tower_layer%i",
		to = 7,
		layer_from = 1
	},
	elven_stargazers_tower_lvl1_tower_layerX_atack_loop = {
		layer_to = 3,
		from = 8,
		layer_prefix = "elven_stargazers_tower_lvl1_tower_layer%i",
		to = 8,
		layer_from = 1
	},
	elven_stargazers_tower_lvl1_tower_layerX_attack_out = {
		layer_to = 3,
		from = 9,
		layer_prefix = "elven_stargazers_tower_lvl1_tower_layer%i",
		to = 22,
		layer_from = 1
	},
	elven_stargazers_tower_lvl2_tower_layerX_idle = {
		layer_to = 3,
		from = 1,
		layer_prefix = "elven_stargazers_tower_lvl2_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	elven_stargazers_tower_lvl2_tower_layerX_attack_in = {
		layer_to = 3,
		from = 2,
		layer_prefix = "elven_stargazers_tower_lvl2_tower_layer%i",
		to = 9,
		layer_from = 1
	},
	elven_stargazers_tower_lvl2_tower_layerX_atack_loop = {
		layer_to = 3,
		from = 10,
		layer_prefix = "elven_stargazers_tower_lvl2_tower_layer%i",
		to = 10,
		layer_from = 1
	},
	elven_stargazers_tower_lvl2_tower_layerX_attack_out = {
		layer_to = 3,
		from = 11,
		layer_prefix = "elven_stargazers_tower_lvl2_tower_layer%i",
		to = 22,
		layer_from = 1
	},
	elven_stargazers_tower_lvl3_tower_layerX_idle = {
		layer_to = 6,
		from = 1,
		layer_prefix = "elven_stargazers_tower_lvl3_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	elven_stargazers_tower_lvl3_tower_layerX_attack_in = {
		layer_to = 6,
		from = 2,
		layer_prefix = "elven_stargazers_tower_lvl3_tower_layer%i",
		to = 19,
		layer_from = 1
	},
	elven_stargazers_tower_lvl3_tower_layerX_atack_loop = {
		layer_to = 6,
		from = 20,
		layer_prefix = "elven_stargazers_tower_lvl3_tower_layer%i",
		to = 20,
		layer_from = 1
	},
	elven_stargazers_tower_lvl3_tower_layerX_attack_out = {
		layer_to = 6,
		from = 21,
		layer_prefix = "elven_stargazers_tower_lvl3_tower_layer%i",
		to = 38,
		layer_from = 1
	},
	elven_stargazers_tower_lvl4_tower_layerX_idle = {
		layer_to = 8,
		from = 1,
		layer_prefix = "elven_stargazers_tower_lvl4_tower_layer%i",
		to = 1,
		layer_from = 1
	},
	elven_stargazers_tower_lvl4_tower_layerX_attack_in = {
		layer_to = 8,
		from = 2,
		layer_prefix = "elven_stargazers_tower_lvl4_tower_layer%i",
		to = 23,
		layer_from = 1
	},
	elven_stargazers_tower_lvl4_tower_layerX_atack_loop = {
		layer_to = 8,
		from = 24,
		layer_prefix = "elven_stargazers_tower_lvl4_tower_layer%i",
		to = 24,
		layer_from = 1
	},
	elven_stargazers_tower_lvl4_tower_layerX_attack_out = {
		layer_to = 8,
		from = 25,
		layer_prefix = "elven_stargazers_tower_lvl4_tower_layer%i",
		to = 45,
		layer_from = 1
	}
}
local o = {}

o.animations = a

return o

--return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_stargazers.lua

-- BEGIN kr3/data/animations/tower_twilight_elves_barrack.lua
do
	local __chunk = (function()
local a = {
    elves_soldier_harasser_lvl1_idle = {
        prefix = "elves_soldier_harasser_lvl1",
        to = 1,
        from = 1
    },
    elves_soldier_harasser_lvl1_walk = {
        prefix = "elves_soldier_harasser_lvl1",
        to = 7,
        from = 2
    },
    elves_soldier_harasser_lvl1_attack = {
        prefix = "elves_soldier_harasser_lvl1",
        to = 31,
        from = 8
    },
    elves_soldier_harasser_lvl1_attack2 = {
        prefix = "elves_soldier_harasser_lvl1",
        to = 55,
        from = 32
    },
    elves_soldier_harasser_lvl1_shoot = {
        to = 77,
        from = 56,
        prefix = "elves_soldier_harasser_lvl1"
    },
    elves_soldier_harasser_lvl1_dodge = {
        to = 95,
        from = 78,
        prefix = "elves_soldier_harasser_lvl1"
    },
    elves_soldier_harasser_lvl1_death = {
        prefix = "elves_soldier_harasser_lvl1",
        to = 111,
        from = 96
    },
    twilight_elves_barrack_tower_lvl1_open = {
		prefix = "twilight_elves_barrack_tower_lvl1_layer2",
		to = 12,
		from = 1
	},
	twilight_elves_barrack_tower_lvl1_close = {
		prefix = "twilight_elves_barrack_tower_lvl1_layer2",
		to = 23,
		from = 13
	},

    elves_soldier_harasser_lvl2_idle = {
        prefix = "elves_soldier_harasser_lvl2",
        to = 1,
        from = 1
    },
    elves_soldier_harasser_lvl2_walk = {
        prefix = "elves_soldier_harasser_lvl2",
        to = 7,
        from = 2
    },
    elves_soldier_harasser_lvl2_attack = {
        prefix = "elves_soldier_harasser_lvl2",
        to = 31,
        from = 8
    },
    elves_soldier_harasser_lvl2_attack2 = {
        prefix = "elves_soldier_harasser_lvl2",
        to = 55,
        from = 32
    },
    elves_soldier_harasser_lvl2_shoot = {
        to = 77,
        from = 56,
        prefix = "elves_soldier_harasser_lvl2"
    },
    elves_soldier_harasser_lvl2_dodge = {
        to = 95,
        from = 78,
        prefix = "elves_soldier_harasser_lvl2"
    },
    elves_soldier_harasser_lvl2_death = {
        prefix = "elves_soldier_harasser_lvl2",
        to = 111,
        from = 96
    },
    twilight_elves_barrack_tower_lvl2_open = {
		prefix = "twilight_elves_barrack_tower_lvl2_layer2",
		to = 12,
		from = 1
	},
	twilight_elves_barrack_tower_lvl2_close = {
		prefix = "twilight_elves_barrack_tower_lvl2_layer2",
		to = 23,
		from = 13
	},

    elves_soldier_harasser_lvl3_idle = {
        prefix = "elves_soldier_harasser_lvl3",
        to = 1,
        from = 1
    },
    elves_soldier_harasser_lvl3_walk = {
        prefix = "elves_soldier_harasser_lvl3",
        to = 7,
        from = 2
    },
    elves_soldier_harasser_lvl3_attack = {
        prefix = "elves_soldier_harasser_lvl3",
        to = 29,
        from = 8
    },
    elves_soldier_harasser_lvl3_attack2 = {
        prefix = "elves_soldier_harasser_lvl3",
        to = 53,
        from = 30
    },
    elves_soldier_harasser_lvl3_shoot = {
        to = 77,
        from = 54,
        prefix = "elves_soldier_harasser_lvl3"
    },
    elves_soldier_harasser_lvl3_dodge = {
        to = 92,
        from = 78,
        prefix = "elves_soldier_harasser_lvl3"
    },
    elves_soldier_harasser_lvl3_death = {
        prefix = "elves_soldier_harasser_lvl3",
        to = 109,
        from = 93
    },
    twilight_elves_barrack_tower_lvl3_open = {
		prefix = "twilight_elves_barrack_tower_lvl3_layer2",
		to = 12,
		from = 1
	},
	twilight_elves_barrack_tower_lvl3_close = {
		prefix = "twilight_elves_barrack_tower_lvl3_layer2",
		to = 23,
		from = 13
	},

    elves_soldier_harasser_lvl4_idle = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 1,
        from = 1
    },
    elves_soldier_harasser_lvl4_walk = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 17,
        from = 2
    },
    elves_soldier_harasser_lvl4_attack = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 35,
        from = 18
    },
    elves_soldier_harasser_lvl4_attack2 = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 69,
        from = 36
    },
    elves_soldier_harasser_lvl4_shoot = {
        to = 93,
        from = 70,
        prefix = "elves_soldier_harasser_lvl4"
    },
    elves_soldier_harasser_lvl4_inshoot = {
        to = 101,
        from = 94,
        prefix = "elves_soldier_harasser_lvl4"
    },
    elves_soldier_harasser_lvl4_multishoot = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 106,
        from = 102
    },
    elves_soldier_harasser_lvl4_outshoot = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 119,
        from = 107
    },
    elves_soldier_harasser_lvl4_backstabHit = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 135,
        from = 120
    },
    elves_soldier_harasser_lvl4_backstab = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 155,
        from = 136
    },
    elves_soldier_harasser_lvl4_death = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 171,
        from = 156
    },
    elves_soldier_harasser_lvl4_transform = {
        prefix = "elves_soldier_harasser_lvl4",
        to = 245,
        from = 172
    },
    twilight_elves_barrack_tower_lvl4_open = {
		prefix = "twilight_elves_barrack_tower_lvl4_layer2",
		to = 9,
		from = 1
	},
	twilight_elves_barrack_tower_lvl4_close = {
		prefix = "twilight_elves_barrack_tower_lvl4_layer2",
		to = 20,
		from = 10
	},
    elves_soldier_espectral_harasser_run_effect_run = {
        prefix = "elves_soldier_espectral_harasser_run_effect",
		to = 4,
		from = 1
    },
    elves_soldier_espectral_harasser_idle = {
		prefix = "elves_soldier_espectral_harasser",
		to = 10,
		from = 1
	},
    elves_soldier_espectral_harasser_walk = {
		prefix = "elves_soldier_espectral_harasser",
		to = 26,
		from = 11
	},
    elves_soldier_espectral_harasser_attack = {
		prefix = "elves_soldier_espectral_harasser",
		to = 51,
		from = 27
	},
    elves_soldier_espectral_harasser_death = {
		prefix = "elves_soldier_espectral_harasser",
		to = 95,
		from = 52
	},
    elves_soldier_espectral_harasser_raise = {
		prefix = "elves_soldier_espectral_harasser",
		to = 158,
		from = 96
	}
}

local o = {}

o.animations = a

return o
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/tower_twilight_elves_barrack.lua

-- BEGIN kr3/data/animations/unblinded_priest.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/unblinded_priest.lua

local a = {
	unblinded_priest_idle = {
		prefix = "unblinded_priest",
		to = 1,
		from = 1
	},
	unblinded_priest_walkingRightLeft = {
		prefix = "unblinded_priest",
		to = 25,
		from = 2
	},
	unblinded_priest_walkingDown = {
		prefix = "unblinded_priest",
		to = 49,
		from = 26
	},
	unblinded_priest_walkingUp = {
		prefix = "unblinded_priest",
		to = 73,
		from = 50
	},
	unblinded_priest_attack_ranged = {
		prefix = "unblinded_priest",
		to = 120,
		from = 74
	},
	unblinded_priest_attack_melee = {
		prefix = "unblinded_priest",
		to = 150,
		from = 121
	},
	unblinded_priest_death = {
		prefix = "unblinded_priest",
		to = 180,
		from = 151
	},
	unblinded_priest_transformation_start = {
		prefix = "unblinded_priest",
		to = 196,
		from = 181
	},
	unblinded_priest_transformation_loop = {
		prefix = "unblinded_priest",
		to = 214,
		from = 197
	},
	unblinded_priest_transformation_end = {
		prefix = "unblinded_priest",
		to = 248,
		from = 215
	},
	unblinded_priest_projectile_flying = {
		prefix = "unblinded_priest_projectile",
		to = 9,
		from = 1
	},
	unblinded_priest_projectile_trail_idle = {
		prefix = "unblinded_priest_projectile_trail",
		to = 6,
		from = 1
	},
	unblinded_priest_projectile_hit_fx_idle = {
		prefix = "unblinded_priest_projectile_hit_fx",
		to = 7,
		from = 1
	},
	unblinded_priest_melee_hit_fx = {
		prefix = "unblinded_priest_melee_hit_fx",
		to = 9,
		from = 1
	},
	unblinded_abomination_unblinded_abomination_idle = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 1,
		from = 1
	},
	unblinded_abomination_unblinded_abomination_walkingRightLeft = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 33,
		from = 2
	},
	unblinded_abomination_unblinded_abomination_walkingDown = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 65,
		from = 34
	},
	unblinded_abomination_unblinded_abomination_walkingUp = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 97,
		from = 66
	},
	unblinded_abomination_unblinded_abomination_attack = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 119,
		from = 98
	},
	unblinded_abomination_unblinded_abomination_eat = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 161,
		from = 120
	},
	unblinded_abomination_unblinded_abomination_death = {
		prefix = "unblinded_abomination_unblinded_abomination",
		to = 210,
		from = 162
	},
	unblinded_abomination_unblinded_abomination_hit_fx_idle = {
		prefix = "unblinded_abomination_unblinded_abomination_hit_fx",
		to = 6,
		from = 1
	},
	unblinded_abomination_unblinded_abomination_eat_fx = {
		prefix = "unblinded_abomination_unblinded_abomination_eat_fx",
		to = 11,
		from = 1
	},
	unblinded_abomination_unblinded_abomination_decal_idle = {
		prefix = "unblinded_abomination_unblinded_abomination_decal",
		to = 1,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/unblinded_priest.lua

-- BEGIN kr3/data/animations/unblinded_shackler.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/unblinded_shackler.lua

local a = {
	unblinded_shackler_tower_mod_in = {
		prefix = "unblinded_shackler_tower_mod",
		to = 10,
		from = 1
	},
	unblinded_shackler_tower_mod_idle = {
		prefix = "unblinded_shackler_tower_mod",
		to = 46,
		from = 11
	},
	unblinded_shackler_tower_mod_out = {
		prefix = "unblinded_shackler_tower_mod",
		to = 58,
		from = 47
	},
	unblinded_shackler_creep_idle = {
		prefix = "unblinded_shackler_creep",
		to = 1,
		from = 1
	},
	unblinded_shackler_creep_walk = {
		prefix = "unblinded_shackler_creep",
		to = 24,
		from = 2
	},
	unblinded_shackler_creep_walk_front = {
		prefix = "unblinded_shackler_creep",
		to = 47,
		from = 25
	},
	unblinded_shackler_creep_walk_back = {
		prefix = "unblinded_shackler_creep",
		to = 70,
		from = 48
	},
	unblinded_shackler_creep_attack = {
		prefix = "unblinded_shackler_creep",
		to = 98,
		from = 71
	},
	unblinded_shackler_creep_skill_in = {
		prefix = "unblinded_shackler_creep",
		to = 114,
		from = 99
	},
	unblinded_shackler_creep_skill_loop = {
		prefix = "unblinded_shackler_creep",
		to = 126,
		from = 115
	},
	unblinded_shackler_creep_skill_out = {
		prefix = "unblinded_shackler_creep",
		to = 140,
		from = 127
	},
	unblinded_shackler_creep_death = {
		prefix = "unblinded_shackler_creep",
		to = 174,
		from = 141
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/unblinded_shackler.lua

-- BEGIN kr3/data/animations/vile_spawner.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/vile_spawner.lua

local a = {
	vile_spawner_hit_fx_attack_1_hit = {
		prefix = "vile_spawner_hit_fx",
		to = 6,
		from = 1
	},
	vile_spawner_projectile_fx_idle = {
		prefix = "vile_spawner_projectile_fx",
		to = 8,
		from = 1
	},
	vile_spawner_projectile = {
		prefix = "vile_spawner_projectile",
		to = 1,
		from = 1
	},
	vile_spawner_creep_idle = {
		prefix = "vile_spawner_creep",
		to = 24,
		from = 1
	},
	vile_spawner_creep_walk = {
		prefix = "vile_spawner_creep",
		to = 48,
		from = 25
	},
	vile_spawner_creep_walk_front = {
		prefix = "vile_spawner_creep",
		to = 72,
		from = 49
	},
	vile_spawner_creep_walk_back = {
		prefix = "vile_spawner_creep",
		to = 96,
		from = 73
	},
	vile_spawner_creep_attack_melee = {
		prefix = "vile_spawner_creep",
		to = 125,
		from = 97
	},
	vile_spawner_creep_projectile_spawn = {
		prefix = "vile_spawner_creep",
		to = 164,
		from = 126
	},
	vile_spawner_creep_death = {
		prefix = "vile_spawner_creep",
		to = 191,
		from = 165
	},
	lesser_eye_creep_idle = {
		prefix = "lesser_eye_creep",
		to = 24,
		from = 1
	},
	lesser_eye_creep_walk = {
		prefix = "lesser_eye_creep",
		to = 48,
		from = 25
	},
	lesser_eye_creep_walk_front = {
		prefix = "lesser_eye_creep",
		to = 72,
		from = 49
	},
	lesser_eye_creep_walk_back = {
		prefix = "lesser_eye_creep",
		to = 96,
		from = 73
	},
	lesser_eye_creep_spawn = {
		prefix = "lesser_eye_creep",
		to = 116,
		from = 97
	},
	lesser_eye_creep_death = {
		prefix = "lesser_eye_creep",
		to = 140,
		from = 117
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/vile_spawner.lua

-- BEGIN kr3/data/animations/water_spirit.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/water_spirit.lua

local a = {
	wukong_water_spirit_trail_nadar_run = {
		prefix = "wukong_water_spirit_trail_nadar",
		to = 1,
		from = 1
	},
	wukong_water_spirit_charco_caida_run = {
		prefix = "wukong_water_spirit_charco_caida",
		to = 13,
		from = 1
	},
	wukong_water_spirit_hit_run = {
		prefix = "wukong_water_spirit_hit",
		to = 7,
		from = 1
	},
	wukong_water_spirit_ranged_attck_trail_run = {
		prefix = "wukong_water_spirit_ranged_attck_trail",
		to = 11,
		from = 1
	},
	wukong_water_spirit_walk_trail_run = {
		prefix = "wukong_water_spirit_walk_trail",
		to = 22,
		from = 1
	},
	wukong_water_spirit_fx_splash = {
		prefix = "wukong_water_spirit_fx_splash",
		to = 17,
		from = 1
	},
	wukong_water_spirit_creep_idle = {
		prefix = "wukong_water_spirit_creep",
		to = 28,
		from = 1
	},
	wukong_water_spirit_creep_walk = {
		prefix = "wukong_water_spirit_creep",
		to = 56,
		from = 29
	},
	wukong_water_spirit_creep_walk_down = {
		prefix = "wukong_water_spirit_creep",
		to = 84,
		from = 57
	},
	wukong_water_spirit_creep_walk_up = {
		prefix = "wukong_water_spirit_creep",
		to = 112,
		from = 85
	},
	wukong_water_spirit_creep_attack = {
		prefix = "wukong_water_spirit_creep",
		to = 138,
		from = 113
	},
	wukong_water_spirit_creep_death = {
		prefix = "wukong_water_spirit_creep",
		to = 166,
		from = 139
	},
	wukong_water_spirit_creep_awahead = {
		prefix = "wukong_water_spirit_creep",
		to = 177,
		from = 167
	},
	wukong_water_spirit_creep_air_loop = {
		prefix = "wukong_water_spirit_creep",
		to = 181,
		from = 178
	},
	wukong_water_spirit_creep_land = {
		prefix = "wukong_water_spirit_creep",
		to = 189,
		from = 182
	},
	wukong_water_spirit_creep_land_r = {
		prefix = "wukong_water_spirit_creep",
		to = 197,
		from = 190
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/water_spirit.lua

-- BEGIN kr3/data/animations/watersorceress.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/watersorceress.lua

local a = {
	watersorceress_projectile_hit_run = {
		prefix = "watersorceress_projectile_hit",
		to = 19,
		from = 1
	},
	watersorceress_projectile_trail_run = {
		prefix = "watersorceress_projectile_trail",
		to = 14,
		from = 1
	},
	watersorceress_projectile_run = {
		prefix = "watersorceress_projectile",
		to = 8,
		from = 1
	},
	watersorceress_projectile_idle = {
		prefix = "watersorceress_projectile",
		to = 8,
		from = 1
	},
	watersorceress_wave_run = {
		prefix = "watersorceress_wave",
		to = 37,
		from = 1
	},
	watersorceress_heal = {
		prefix = "watersorceress_heal",
		to = 88,
		from = 1
	},
	watersorceress_trail_wave_idle = {
		prefix = "watersorceress_trail_wave",
		to = 2,
		from = 1
	},
	watersorceress_trail_wave_out = {
		prefix = "watersorceress_trail_wave",
		to = 36,
		from = 3
	},
	watersorceress_raise = {
		prefix = "watersorceress",
		to = 1,
		from = 1
	},
	watersorceress_idle = {
		prefix = "watersorceress",
		to = 2,
		from = 1
	},
	watersorceress_walk = {
		prefix = "watersorceress",
		to = 24,
		from = 3
	},
	watersorceress_walk_down = {
		prefix = "watersorceress",
		to = 46,
		from = 25
	},
	watersorceress_walk_up = {
		prefix = "watersorceress",
		to = 68,
		from = 47
	},
	watersorceress_basic_attack = {
		prefix = "watersorceress",
		to = 106,
		from = 69
	},
	watersorceress_melee = {
		prefix = "watersorceress",
		to = 136,
		from = 107
	},
	watersorceress_melee_2 = {
		prefix = "watersorceress",
		to = 171,
		from = 137
	},
	watersorceress_special_attack = {
		prefix = "watersorceress",
		to = 215,
		from = 172
	},
	watersorceress_death = {
		prefix = "watersorceress",
		to = 257,
		from = 216
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/watersorceress.lua

-- BEGIN kr3/data/animations/wuxian.lua
do
	local __chunk = (function()
-- chunkname: @./kr5/data/animations/all/wuxian.lua

local a = {
	wuxian_buff_run = {
		prefix = "wuxian_buff",
		to = 23,
		from = 1
	},
	wuxian_creep_idle = {
		prefix = "wuxian_creep",
		to = 1,
		from = 1
	},
	wuxian_creep_walk = {
		prefix = "wuxian_creep",
		to = 31,
		from = 2
	},
	wuxian_creep_walk_up = {
		prefix = "wuxian_creep",
		to = 61,
		from = 32
	},
	wuxian_creep_walk_down = {
		prefix = "wuxian_creep",
		to = 91,
		from = 62
	},
	wuxian_creep_attack_mele = {
		prefix = "wuxian_creep",
		to = 137,
		from = 92
	},
	wuxian_creep_attack_mele_2 = {
		prefix = "wuxian_creep",
		to = 159,
		from = 138
	},
	wuxian_creep_attack_range = {
		prefix = "wuxian_creep",
		to = 195,
		from = 160
	},
	wuxian_creep_death = {
		prefix = "wuxian_creep",
		to = 235,
		from = 196
	},
	wuxian_bolt_flying = {
		prefix = "wuxian_bolt",
		to = 18,
		from = 1
	},
	wuxian_trail_idle = {
		prefix = "wuxian_trail",
		to = 6,
		from = 1
	},
	wuxian_explosion_run = {
		prefix = "wuxian_explosion",
		to = 19,
		from = 1
	},
	wuxian_hit_mele_hit = {
		prefix = "wuxian_hit_mele",
		to = 5,
		from = 1
	},
	wuxian_hit_run = {
		prefix = "wuxian_hit",
		to = 47,
		from = 1
	}
}

return a
	end)()
	__merge_animations(__chunk)
end
-- END kr3/data/animations/wuxian.lua

return out
