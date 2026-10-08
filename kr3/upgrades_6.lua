local E = require("entity_db")
local balance = require("data/balance/balance_6")
local power_upgrade_specs = require("power_upgrades_6_specs")
local power_upgrades_6 = require("power_upgrades_6")

local M = {}
local b = balance.towers.upgrades

local lists = {
	barracks_miners = {
		"tower_miners_lvl1", "tower_miners_lvl2", "tower_miners_lvl3", "tower_miners_lvl4"
	},
	barracks_soldiers = {
		"soldier_wildcat_lvl1", "soldier_wildcat_lvl2", "soldier_wildcat_lvl3", "soldier_wildcat_lvl4",
		"soldier_knights_lvl1", "soldier_knights_lvl2", "soldier_knights_lvl3", "soldier_knights_lvl4",
		"soldier_miners_lvl1", "soldier_miners_lvl2", "soldier_miners_lvl3", "soldier_miners_lvl4",
		"soldier_miners_skill_a_lvl1", "soldier_miners_skill_a_lvl2", "soldier_miners_skill_a_lvl3"
	},
	barracks_soldiers_no_miners = {
		"soldier_wildcat_lvl1", "soldier_wildcat_lvl2", "soldier_wildcat_lvl3", "soldier_wildcat_lvl4",
		"soldier_knights_lvl1", "soldier_knights_lvl2", "soldier_knights_lvl3", "soldier_knights_lvl4"
	},
	barracks_bullets = {
		"bullet_wildcat_lvl1", "bullet_wildcat_lvl2", "bullet_wildcat_lvl3", "bullet_wildcat_lvl4"
	},
	archer_towers = {
		"tower_archers_lvl1", "tower_archers_lvl2", "tower_archers_lvl3", "tower_archers_lvl4",
		"tower_ranger_lvl1", "tower_ranger_lvl2", "tower_ranger_lvl3", "tower_ranger_lvl4",
		"tower_crossbows_lvl1", "tower_crossbows_lvl2", "tower_crossbows_lvl3", "tower_crossbows_lvl4",
		"tower_sniper_lvl1", "tower_sniper_lvl2", "tower_sniper_lvl3", "tower_sniper_lvl4"
	},
	archer_towers_max = {
		"tower_archers_lvl4", "tower_ranger_lvl4", "tower_crossbows_lvl4", "tower_sniper_lvl4"
	},
	archer_bullets = {
		"bullet_archers_lvl1", "bullet_archers_lvl2", "bullet_archers_lvl3", "bullet_archers_lvl4",
		"bullet_ranger_lvl1", "bullet_ranger_lvl2", "bullet_ranger_lvl3", "bullet_ranger_lvl4",
		"bullet_ranger_skill_c_lvl1", "bullet_ranger_skill_c_lvl2", "bullet_ranger_skill_c_lvl3",
		"bullet_ranger_skill_c_bounce_clone_lvl1", "bullet_ranger_skill_c_bounce_clone_lvl2", "bullet_ranger_skill_c_bounce_clone_lvl3",
		"bullet_crossbows_basic_lvl1", "bullet_crossbows_basic_lvl2", "bullet_crossbows_basic_lvl3", "bullet_crossbows_basic_lvl4",
		"bullet_crossbows_skill_a_lvl1", "bullet_crossbows_skill_a_lvl2", "bullet_crossbows_skill_a_lvl3",
		"bullet_crossbows_skill_c_lvl1", "bullet_crossbows_skill_c_lvl2", "bullet_crossbows_skill_c_lvl3",
		"bullet_sniper_basic_lvl1", "bullet_sniper_basic_lvl2", "bullet_sniper_basic_lvl3", "bullet_sniper_basic_lvl4",
		"bullet_sniper_skill_b_lvl1", "bullet_sniper_skill_b_lvl2", "bullet_sniper_skill_b_lvl3"
	},
	mage_bullets = {
		"bolt_tower_wizard_lvl1", "bolt_tower_wizard_lvl2", "bolt_tower_wizard_lvl3", "bolt_tower_wizard_lvl4",
		"bullet_sunray_master_beam_lvl1", "bullet_sunray_master_beam_lvl2", "bullet_sunray_master_beam_lvl3", "bullet_sunray_master_beam_lvl4",
		"bullet_sunray_master_rapid_fire_lvl1", "bullet_sunray_master_rapid_fire_lvl2", "bullet_sunray_master_rapid_fire_lvl3", "bullet_sunray_master_rapid_fire_lvl4",
		"bullet_light_priestess_lvl1", "bullet_light_priestess_lvl2", "bullet_light_priestess_lvl3", "bullet_light_priestess_lvl4",
		"bullet_forger_basic_lvl1", "bullet_forger_basic_lvl2", "bullet_forger_basic_lvl3", "bullet_forger_basic_lvl4"
	},
	mage_auras = {
		"aura_sunray_master_beam_lvl1", "aura_sunray_master_beam_lvl2", "aura_sunray_master_beam_lvl3", "aura_sunray_master_beam_lvl4"
	},
	mage_towers = {
		"tower_wizard_lvl1", "tower_wizard_lvl2", "tower_wizard_lvl3", "tower_wizard_lvl4",
		"tower_sunray_master_lvl1", "tower_sunray_master_lvl2", "tower_sunray_master_lvl3", "tower_sunray_master_lvl4",
		"tower_light_priestess_lvl1", "tower_light_priestess_lvl2", "tower_light_priestess_lvl3", "tower_light_priestess_lvl4",
		"tower_forger_lvl1", "tower_forger_lvl2", "tower_forger_lvl3", "tower_forger_lvl4"
	},
	mage_towers_max = {
		"tower_wizard_lvl4", "tower_sunray_master_lvl4", "tower_light_priestess_lvl4", "tower_forger_lvl4"
	},
	mage_towers_skill_cd = {
		"tower_wizard_lvl4", "tower_light_priestess_lvl4", "tower_forger_lvl4"
	},
	mage_count_tower_types = {
		"mage", "g1_mage", "g2_mage", "archmage", "necromancer",
		"wicked_sisters", "deep_devils", "blazing_watcher", "orc_shaman", "spirit_mausoleum",
		"infernal_mage", "sc_winter", "sc_frost_gem",
		"arcane_wizard5", "arborean_emissary", "necromancer5", "elven_stargazers", "ray", "dragons",
		"hermit_toad",
		"arcane", "wild_magus", "high_elven", "arcane_wizard", "sorcerer",
		"kr6_mage_kr1", "kr6_arcane_wizard_kr1", "kr6_sorcerer_kr1",
		"kr6_wizard", "kr6_sunray_master", "kr6_light_priestess", "kr6_forger"
	},
	artillery_towers = {
		"tower_catapult_lvl1", "tower_catapult_lvl2", "tower_catapult_lvl3", "tower_catapult_lvl4",
		"tower_culverine_lvl1", "tower_culverine_lvl2", "tower_culverine_lvl3", "tower_culverine_lvl4",
		"tower_tree_lvl1", "tower_tree_lvl2", "tower_tree_lvl3", "tower_tree_lvl4",
		"tower_alchemist_lvl1", "tower_alchemist_lvl2", "tower_alchemist_lvl3", "tower_alchemist_lvl4"
	},
	artillery_towers_max = {
		"tower_catapult_lvl4", "tower_culverine_lvl4", "tower_tree_lvl4", "tower_alchemist_lvl4"
	},
	artillery_tree_towers = {
		"tower_tree_lvl1", "tower_tree_lvl2", "tower_tree_lvl3", "tower_tree_lvl4"
	},
	artillery_tree_soldiers = {
		"soldier_tree_lvl1", "soldier_tree_lvl2", "soldier_tree_lvl3", "soldier_tree_lvl4"
	},
	artillery_bullets = {
		"bullet_catapult_lvl1", "bullet_catapult_lvl2", "bullet_catapult_lvl3", "bullet_catapult_lvl4", "bullet_catapult_skill_b",
		"bullet_culverine_lvl1", "bullet_culverine_lvl2", "bullet_culverine_lvl3", "bullet_culverine_lvl4",
		"bullet_green_alchemist_lvl1", "bullet_green_alchemist_lvl2", "bullet_green_alchemist_lvl3", "bullet_green_alchemist_lvl4",
		"bullet_alchemist_skill_c_lvl1", "bullet_alchemist_skill_c_lvl2", "bullet_alchemist_skill_c_lvl3"
	},
	artillery_auras = {
		"aura_bullet_culverine_lvl1", "aura_bullet_culverine_lvl2", "aura_bullet_culverine_lvl3", "aura_bullet_culverine_lvl4",
		"aura_bullet_culverine_skill_b_lvl1", "aura_bullet_culverine_skill_b_lvl2", "aura_bullet_culverine_skill_b_lvl3",
		"aura_tree_attack_lvl1", "aura_tree_attack_lvl2", "aura_tree_attack_lvl3", "aura_tree_attack_lvl4",
		"aura_bullet_alchemist_lvl1", "aura_bullet_alchemist_lvl2", "aura_bullet_alchemist_lvl3", "aura_bullet_alchemist_lvl4",
		"aura_alchemist_skill_c_lvl1", "aura_alchemist_skill_c_lvl2", "aura_alchemist_skill_c_lvl3"
	},
	artillery_stun_auras = {
		"aura_bullet_culverine_lvl1", "aura_bullet_culverine_lvl2", "aura_bullet_culverine_lvl3", "aura_bullet_culverine_lvl4",
		"aura_bullet_culverine_skill_b_lvl1", "aura_bullet_culverine_skill_b_lvl2", "aura_bullet_culverine_skill_b_lvl3",
		"aura_tree_attack_lvl1", "aura_tree_attack_lvl2", "aura_tree_attack_lvl3", "aura_tree_attack_lvl4"
	}
}

local function append(first, second)
	local result = {}

	for _, value in ipairs(first) do
		table.insert(result, value)
	end
	for _, value in ipairs(second) do
		table.insert(result, value)
	end

	return result
end

local function item(key, level, price, icon, title_key, description_key, extra)
	local result = {
		key = key,
		level = level,
		price = price,
		sprite = string.format("KR6_Tech_Upgrade_%04d", icon),
		name_key = title_key,
		description_key = description_key
	}

	for k, value in pairs(extra or {}) do
		result[k] = value
	end

	return result
end

local function branch_tree(name, root_name, root_description, root_icon, class_name, definitions)
	local prefix = class_name .. "_"

	return {
		name = name,
		root_name = root_name,
		root_description = root_description,
		root_sprite = string.format("KR6_Tech_Type_%04d", root_icon),
		exclusive_price_groups = {
			{prefix .. "l3a", prefix .. "l3b"},
			{prefix .. "l4a", prefix .. "l4b"}
		},
		items = definitions
	}
end

local common_requirements = function(prefix)
	return {
		l2 = {requires = {prefix .. "l1"}},
		l3a = {requires = {prefix .. "l2"}, blocks = {prefix .. "l3b"}},
		l3b = {requires = {prefix .. "l2"}, blocks = {prefix .. "l3a"}},
		l4a = {requires = {prefix .. "l3a"}, blocks = {prefix .. "l4b"}},
		l4b = {requires = {prefix .. "l3b"}, blocks = {prefix .. "l4a"}},
		ulti = {requires_any = {prefix .. "l4a", prefix .. "l4b"}}
	}
end

local ar = common_requirements("archers_")
local ba = common_requirements("barracks_")
local ma = common_requirements("mages_")
local at = common_requirements("artillery_")

M.tree_order = {"g6_archers", "g6_barracks", "g6_mages", "g6_artillery"}
M.trees = {
	g6_archers = branch_tree("6代箭塔", "6代箭塔科技", "属于6代的箭塔可享受这些科技。", 3, "archers", {
		item("archers_l1", 1, 1, 15, "TOWER_MARKSMAN_UPGRADE_RANGE_TITLE", "TOWER_MARKSMAN_UPGRADE_RANGE_DESC"),
		item("archers_l2", 2, 2, 21, "TOWER_MARKSMAN_UPGRADE_DAMAGE_TITLE", "TOWER_MARKSMAN_UPGRADE_DAMAGE_DESC", ar.l2),
		item("archers_l3a", 3, 3, 16, "TOWER_MARKSMAN_UPGRADE_BLOCKEDDMG_TITLE", "TOWER_MARKSMAN_UPGRADE_BLOCKEDDMG_DESC", ar.l3a),
		item("archers_l3b", 3, 3, 18, "TOWER_MARKSMAN_UPGRADE_COOLDOWN_TITLE", "TOWER_MARKSMAN_UPGRADE_COOLDOWN_DESC", ar.l3b),
		item("archers_l4a", 4, 3, 17, "TOWER_MARKSMAN_UPGRADE_CRITDAMAGE_TITLE", "TOWER_MARKSMAN_UPGRADE_CRITDAMAGE_DESC", ar.l4a),
		item("archers_l4b", 4, 3, 19, "TOWER_MARKSMAN_UPGRADE_MAXDAMAGE_TITLE", "TOWER_MARKSMAN_UPGRADE_MAXDAMAGE_DESC", ar.l4b),
		item("archers_ulti", 5, 5, 20, "TOWER_MARKSMAN_UPGRADE_ULTIMATE_TITLE", "TOWER_MARKSMAN_UPGRADE_ULTIMATE_DESC", ar.ulti)
	}),
	g6_barracks = branch_tree("6代兵营", "6代兵营科技", "属于6代的兵营和兵营单位可享受这些科技。", 1, "barracks", {
		item("barracks_l1", 1, 1, 1, "TOWER_BARRACKS_UPGRADE_HP_TITLE", "TOWER_BARRACKS_UPGRADE_HP_DESC"),
		item("barracks_l2", 2, 2, 4, "TOWER_BARRACKS_UPGRADE_COOLDOWN_TITLE", "TOWER_BARRACKS_UPGRADE_COOLDOWN_DESC", ba.l2),
		item("barracks_l3a", 3, 3, 2, "TOWER_BARRACKS_UPGRADE_DAMAGE_TITLE", "TOWER_BARRACKS_UPGRADE_DAMAGE_DESC", ba.l3a),
		item("barracks_l3b", 3, 3, 3, "TOWER_BARRACKS_UPGRADE_HPARMOR_TITLE", "TOWER_BARRACKS_UPGRADE_HPARMOR_DESC", ba.l3b),
		item("barracks_l4a", 4, 3, 6, "TOWER_BARRACKS_UPGRADE_CRITDAMAGE_TITLE", "TOWER_BARRACKS_UPGRADE_CRITDAMAGE_DESC", ba.l4a),
		item("barracks_l4b", 4, 3, 5, "TOWER_BARRACKS_UPGRADE_RESISTDMG_TITLE", "TOWER_BARRACKS_UPGRADE_RESISTDMG_DESC", ba.l4b),
		item("barracks_ulti", 5, 5, 7, "TOWER_BARRACKS_UPGRADE_ULTIMATE_TITLE", "TOWER_BARRACKS_UPGRADE_ULTIMATE_DESC", ba.ulti)
	}),
	g6_mages = branch_tree("6代法师", "6代法师科技", "属于6代的法师塔可享受这些科技。", 2, "mages", {
		item("mages_l1", 1, 1, 8, "TOWER_MAGES_UPGRADE_MINDAMAGE_TITLE", "TOWER_MAGES_UPGRADE_MINDAMAGE_DESC"),
		item("mages_l2", 2, 2, 9, "TOWER_MAGES_UPGRADE_COST_TITLE", "TOWER_MAGES_UPGRADE_COST_DESC", ma.l2),
		item("mages_l3a", 3, 3, 10, "TOWER_MAGES_UPGRADE_SKILLCOST_TITLE", "TOWER_MAGES_UPGRADE_SKILLCOST_DESC", ma.l3a),
		item("mages_l3b", 3, 3, 12, "TOWER_MAGES_UPGRADE_RANGEDMG_TITLE", "TOWER_MAGES_UPGRADE_RANGEDMG_DESC", ma.l3b),
		item("mages_l4a", 4, 3, 12, "TOWER_MAGES_UPGRADE_SKILLCD_TITLE", "TOWER_MAGES_UPGRADE_SKILLCD_DESC", ma.l4a),
		item("mages_l4b", 4, 3, 14, "TOWER_MAGES_UPGRADE_DMGPERTOWER_TITLE", "TOWER_MAGES_UPGRADE_DMGPERTOWER_DESC", {
			requires = ma.l4b.requires,
			blocks = ma.l4b.blocks,
			tower_types = {"kr6_wizard", "kr6_sunray_master", "kr6_light_priestess", "kr6_forger"},
			count_tower_types = lists.mage_count_tower_types,
			bullet_names = append(lists.mage_bullets, lists.mage_auras),
			damage_factors = b.mages.l4b.dmg_factors
		}),
		item("mages_ulti", 5, 5, 13, "TOWER_MAGES_UPGRADE_ULTIMATE_TITLE", "TOWER_MAGES_UPGRADE_ULTIMATE_DESC", ma.ulti)
	}),
	g6_artillery = branch_tree("6代炮塔", "6代炮塔科技", "属于6代的炮塔可享受这些科技。", 4, "artillery", {
		item("artillery_l1", 1, 1, 22, "TOWER_ARTILLERY_UPGRADE_AREAINC_TITLE", "TOWER_ARTILLERY_UPGRADE_AREAINC_DESC"),
		item("artillery_l2", 2, 2, 23, "TOWER_ARTILLERY_UPGRADE_DAMAGE_TITLE", "TOWER_ARTILLERY_UPGRADE_DAMAGE_DESC", at.l2),
		item("artillery_l3a", 3, 3, 24, "TOWER_ARTILLERY_UPGRADE_COOLDOWN_TITLE", "TOWER_ARTILLERY_UPGRADE_COOLDOWN_DESC", at.l3a),
		item("artillery_l3b", 3, 3, 25, "TOWER_ARTILLERY_UPGRADE_IGNOREARMOR_TITLE", "TOWER_ARTILLERY_UPGRADE_IGNOREARMOR_DESC", at.l3b),
		item("artillery_l4a", 4, 3, 26, "TOWER_ARTILLERY_UPGRADE_STUN_TITLE", "TOWER_ARTILLERY_UPGRADE_STUN_DESC", at.l4a),
		item("artillery_l4b", 4, 3, 27, "TOWER_ARTILLERY_UPGRADE_RANGEDMG_TITLE", "TOWER_ARTILLERY_UPGRADE_RANGEDMG_DESC", at.l4b),
		item("artillery_ulti", 5, 5, 28, "TOWER_ARTILLERY_UPGRADE_ULTIMATE_TITLE", "TOWER_ARTILLERY_UPGRADE_ULTIMATE_DESC", at.ulti)
	})
}

local first_strike_damage = function(this, store, attack, target)
	local factor = 1

	this._barracks_l4a_targets = this._barracks_l4a_targets or {}

	if not table.contains(this._barracks_l4a_targets, target.id) then
		factor = b.barracks.l4a.dmg_factor
		attack._barracks_l4a_old_pop = attack._barracks_l4a_old_pop or attack.pop
		attack._barracks_l4a_old_pop_chance = attack._barracks_l4a_old_pop_chance or attack.pop_chance
		attack.pop = {"pop_crit"}
		attack.pop_chance = 1
		table.insert(this._barracks_l4a_targets, target.id)
	else
		attack.pop = attack._barracks_l4a_old_pop
		attack.pop_chance = attack._barracks_l4a_old_pop_chance
	end

	return math.ceil(factor * this.unit.damage_factor * math.random(attack.damage_min, attack.damage_max))
end

local skill_price_paths = {
	"powers.skill_a.price[1]", "powers.skill_a.price[2]", "powers.skill_a.price[3]",
	"powers.skill_a.price_base", "powers.skill_a.price_inc",
	"powers.skill_b.price[1]", "powers.skill_b.price[2]", "powers.skill_b.price[3]",
	"powers.skill_b.price_base", "powers.skill_b.price_inc",
	"powers.skill_c.price[1]", "powers.skill_c.price[2]", "powers.skill_c.price[3]",
	"powers.skill_c.price_base", "powers.skill_c.price_inc"
}
local skill_cooldown_paths = {}

for _, skill_name in ipairs({"skill_a", "skill_b", "skill_c"}) do
	for level = 1, 3 do
		table.insert(skill_cooldown_paths, string.format("powers.%s.cooldown[%d]", skill_name, level))
	end
end

local specs = {
	barracks_l1 = {{templates = lists.barracks_soldiers, paths = {"health.hp_max"}, operators = {"mul", "round_five"}, value = b.barracks.l1.hp_factor}},
	barracks_l2 = {
		{templates = lists.barracks_soldiers_no_miners, paths = {"health.dead_lifetime"}, operators = "sum", value = -b.barracks.l2.spawn_reduction},
		{templates = lists.barracks_miners, paths = {"spawn_soldier_interval"}, operators = "sum", value = -b.barracks.l2.spawn_reduction_miners}
	},
	barracks_l3a = {
		{templates = lists.barracks_soldiers, paths = {"melee.attacks[1].damage_min", "melee.attacks[1].damage_max"}, operators = {"mul", "ceil"}, value = b.barracks.l3a.dmg_factor},
		{templates = lists.barracks_bullets, paths = {"bullet.damage_min", "bullet.damage_max"}, operators = {"mul", "ceil"}, value = b.barracks.l3a.dmg_factor}
	},
	barracks_l3b = {
		{templates = lists.barracks_soldiers, paths = {"health.hp_max"}, operators = {"mul", "round_five"}, value = b.barracks.l3b.hp_factor},
		{templates = lists.barracks_soldiers, paths = {"health.armor"}, operators = "sum", value = b.barracks.l3b.armor_inc}
	},
	barracks_l4a = {{templates = lists.barracks_soldiers, paths = {"melee.attacks[1].fn_damage"}, operators = "set", value = first_strike_damage}},
	barracks_l4b = {{templates = lists.barracks_soldiers, paths = {"auras.list"}, operators = "aura_attack", value = "aura_upgrades_barracks_l4b"}},
	barracks_ulti = {
		{templates = {"soldier_knights_lvl4"}, paths = {"powers.ultimate.active"}, operators = "set", value = true},
		{templates = {"tower_wildcat_lvl4", "tower_miners_lvl4"}, paths = {"powers.ultimate.active"}, operators = "set", value = true}
	},
	archers_l1 = {{templates = lists.archer_towers, paths = {"attacks.range"}, operators = "mul", value = b.archers.l1.range_factor}},
	archers_l2 = {{templates = lists.archer_bullets, paths = {"bullet.damage_min", "bullet.damage_max"}, operators = {"mul", "ceil"}, value = b.archers.l2.dmg_factor}},
	archers_l3a = {{templates = lists.archer_bullets, paths = {"bullet.disabled_dmg_factor"}, operators = "mul", value = b.archers.l3a.disabled_dmg_factor}},
	archers_l3b = {{templates = lists.archer_towers, paths = {"attacks.list[1].cooldown"}, operators = "mul", value = b.archers.l3b.attack_speed_factor}},
	archers_l4a = {{templates = lists.archer_bullets, paths = {"bullet.critical_chance"}, operators = "sum", value = b.archers.l4a.double_dmg_chance}},
	archers_l4b = {{templates = lists.archer_bullets, paths = {"bullet.max_dmg_unarmored"}, operators = "set", value = true}},
	archers_ulti = {{templates = lists.archer_towers_max, paths = {"powers.ultimate.active"}, operators = "set", value = true}},
	mages_l1 = {
		{templates = lists.mage_bullets, paths = {"bullet.damage_min"}, operators = {"mul", "ceil"}, value = b.mages.l1.min_dmg_factor},
		{templates = lists.mage_auras, paths = {"aura.damage_min"}, operators = {"mul", "ceil"}, value = b.mages.l1.min_dmg_factor}
	},
	mages_l2 = {{templates = lists.mage_towers, paths = {"tower.price"}, operators = {"mul", "round_five"}, value = b.mages.l2.build_cost_red_factor}},
	mages_l3a = {{templates = lists.mage_towers_max, paths = skill_price_paths, operators = {"mul", "round_five"}, value = b.mages.l3a.skill_cost_red_factor}},
	mages_l3b = {
		{templates = lists.mage_bullets, paths = {"bullet.damage_min", "bullet.damage_max"}, operators = {"mul", "ceil"}, value = b.mages.l3b.dmg_factor},
		{templates = lists.mage_auras, paths = {"aura.damage_min", "aura.damage_max"}, operators = {"mul", "ceil"}, value = b.mages.l3b.dmg_factor},
		{templates = lists.mage_towers, paths = {"attacks.range"}, operators = "mul", value = b.mages.l3b.range_factor}
	},
	mages_l4a = {{templates = lists.mage_towers_skill_cd, paths = skill_cooldown_paths, operators = "mul", value = b.mages.l4a.skills_cd_red_factor}},
	mages_ulti = {{templates = lists.mage_towers_max, paths = {"powers.ultimate.active"}, operators = "set", value = true}},
	artillery_l1 = {
		{templates = lists.artillery_bullets, paths = {"bullet.damage_radius"}, operators = "mul", value = b.artillery.l1.area_inc_factor},
		{templates = lists.artillery_auras, paths = {"aura.radius"}, operators = "mul", value = b.artillery.l1.area_inc_factor},
		{templates = lists.artillery_tree_towers, paths = {"attacks.range"}, operators = "mul", value = b.artillery.l1.area_inc_factor},
		{templates = lists.artillery_tree_soldiers, paths = {"melee.attacks[1].damage_radius"}, operators = "mul", value = b.artillery.l1.area_inc_factor}
	},
	artillery_l2 = {
		{templates = lists.artillery_bullets, paths = {"bullet.damage_min", "bullet.damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l2.dmg_factor},
		{templates = lists.artillery_auras, paths = {"aura.damage_min", "aura.damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l2.dmg_factor},
		{templates = lists.artillery_tree_towers, paths = {"attacks.list[1].damage_min", "attacks.list[1].damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l2.dmg_factor},
		{templates = lists.artillery_tree_soldiers, paths = {"melee.attacks[1].damage_min", "melee.attacks[1].damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l2.dmg_factor}
	},
	artillery_l3a = {{templates = lists.artillery_towers, paths = {"attacks.cooldown"}, operators = "mul", value = b.artillery.l3a.attack_speed_factor}},
	artillery_l3b = {
		{templates = lists.artillery_bullets, paths = {"bullet.explosive_factor"}, operators = "set", value = 1 - b.artillery.l3b.armor_ignore_factor},
		{templates = lists.artillery_auras, paths = {"aura.explosive_factor"}, operators = "set", value = 1 - b.artillery.l3b.armor_ignore_factor}
	},
	artillery_l4a = {
		{templates = lists.artillery_bullets, paths = {"bullet.mods"}, operators = "table_append", value = "mod_upgrades_artillery_l4a"},
		{templates = lists.artillery_stun_auras, paths = {"aura.mods"}, operators = "table_append", value = "mod_upgrades_artillery_l4a"},
		{templates = lists.artillery_tree_soldiers, paths = {"melee.attacks[1].mod"}, operators = "set", value = "mod_upgrades_artillery_l4a"}
	},
	artillery_l4b = {
		{templates = lists.artillery_bullets, paths = {"bullet.damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l4b.dmg_factor},
		{templates = lists.artillery_auras, paths = {"aura.damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l4b.dmg_factor},
		{templates = lists.artillery_tree_towers, paths = {"attacks.list[1].damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l4b.dmg_factor},
		{templates = lists.artillery_tree_soldiers, paths = {"melee.attacks[1].damage_max"}, operators = {"mul", "ceil"}, value = b.artillery.l4b.dmg_factor},
		{templates = lists.artillery_towers, paths = {"attacks.range"}, operators = "mul", value = b.artillery.l4b.range_inc_factor}
	},
	artillery_ulti = {{templates = lists.artillery_towers_max, paths = {"powers.ultimate.active"}, operators = "set", value = true}}
}

for upgrade_key, upgrade in pairs(power_upgrade_specs) do
	specs[upgrade_key] = upgrade.patches or {}
end

local baseline_entities
local baseline = {}
local nil_value = {}

local function clone(value, seen)
	if type(value) ~= "table" then
		return value
	end

	seen = seen or {}
	if seen[value] then
		return seen[value]
	end

	local result = {}
	seen[value] = result

	for key, child in pairs(value) do
		result[clone(key, seen)] = clone(child, seen)
	end

	return setmetatable(result, getmetatable(value))
end

local function path_parts(path)
	local result = {}

	for part in string.gmatch(path, "[^.%[%]]+") do
		table.insert(result, tonumber(part) or part)
	end

	return result
end

local function field_holder(template, path)
	local parts = path_parts(path)
	local holder = template

	for index = 1, #parts - 1 do
		holder = holder and holder[parts[index]]
		if holder == nil then
			return nil
		end
	end

	return holder, parts[#parts]
end

local function record_baseline()
	for _, patches in pairs(specs) do
		for _, patch in ipairs(patches) do
			for _, template_name in ipairs(patch.templates) do
				local template = E.entities[template_name]

				if template then
					for _, path in ipairs(patch.paths) do
						local id = template_name .. "\0" .. path

						if baseline[id] == nil then
							local holder, key = field_holder(template, path)

							if holder then
								baseline[id] = {
									template_name = template_name,
									path = path,
									value = holder[key] == nil and nil_value or clone(holder[key])
								}
							end
						end
					end
				end
			end
		end
	end
end

local function restore_baseline()
	for _, entry in pairs(baseline) do
		local template = E.entities[entry.template_name]
		local holder, key

		if template then
			holder, key = field_holder(template, entry.path)
		end

		if holder then
			if entry.value == nil_value then
				holder[key] = nil
			else
				holder[key] = clone(entry.value)
			end
		end
	end
end

local function apply_operator(value, operator, operand)
	if operator == "set" then
		return operand
	elseif operator == "mul" then
		return value ~= nil and value * operand or value
	elseif operator == "ceil" then
		return value ~= nil and math.ceil(value) or value
	elseif operator == "sum" then
		return (value or 0) + operand
	elseif operator == "sub" then
		return value ~= nil and value - operand or operand
	elseif operator == "round_five" then
		return value ~= nil and math.floor(value / 5 + 0.5) * 5 or value
	elseif operator == "table_append" then
		value = value or {}
		table.insert(value, operand)
		return value
	elseif operator == "aura_attack" then
		value = value or {}
		local aura = E:clone_c("aura_attack")

		aura.name = operand
		aura.cooldown = 0
		table.insert(value, aura)
		return value
	end

	return value
end

local function apply_patch(patch)
	for _, template_name in ipairs(patch.templates) do
		local template = E.entities[template_name]

		if template then
			for _, path in ipairs(patch.paths) do
				local holder, key = field_holder(template, path)

				if holder then
					local value = holder[key]
					local operators = type(patch.operators) == "table" and patch.operators or {patch.operators}

					for _, operator in ipairs(operators) do
						value = apply_operator(value, operator, patch.value)
					end

					holder[key] = value
				end
			end
		end
	end
end

function M.apply(user_data, has_upgrade)
	if baseline_entities ~= E.entities then
		baseline_entities = E.entities
		baseline = {}
	end

	restore_baseline()
	record_baseline()

	for _, tree_id in ipairs(M.tree_order) do
		for _, upgrade in ipairs(M.trees[tree_id].items) do
			if has_upgrade(user_data, upgrade.key) then
				for _, patch in ipairs(specs[upgrade.key] or {}) do
					apply_patch(patch)
				end
			end
		end
	end

	for _, upgrade_key in ipairs(power_upgrades_6.active_keys(user_data)) do
		for _, patch in ipairs(specs[upgrade_key] or {}) do
			apply_patch(patch)
		end
	end
end

return M
