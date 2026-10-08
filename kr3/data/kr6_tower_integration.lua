local M = {}

M.encyclopedia_icon_offset = 700

M.towers = {
	"archers",
	"knights",
	"wizard",
	"catapult",
	"ranger",
	"culverine",
	"sunray_master",
	"light_priestess",
	"tree",
	"wildcat",
	"alchemist",
	"forger",
	"crossbows",
	"miners",
	"sniper"
}

M.source_holder_indices = {
	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 18, 19
}

M.legacy_towers = {
	"archer_kr1",
	"barrack_kr1",
	"mage_kr1",
	"engineer_kr1"
}

M.legacy_source_holder_indices = {
	14, 15, 16, 17
}

M.detail_templates = {
	"tower_archers_lvl4",
	"tower_knights_lvl4",
	"tower_wizard_lvl4",
	"tower_catapult_lvl4",
	"tower_ranger_lvl4",
	"tower_culverine_lvl4",
	"tower_sunray_master_lvl4",
	"tower_light_priestess_lvl4",
	"tower_tree_lvl4",
	"tower_wildcat_lvl4",
	"tower_alchemist_lvl4",
	"tower_forger_lvl4",
	"tower_crossbows_lvl4",
	"tower_miners_lvl4",
	"tower_sniper_lvl4"
}

M.encyclopedia_icons = {
	archers = 4,
	knights = 8,
	wizard = 12,
	catapult = 16,
	ranger = 20,
	culverine = 24,
	sunray_master = 32,
	light_priestess = 40,
	tree = 56,
	wildcat = 28,
	alchemist = 48,
	forger = 52,
	crossbows = 44,
	miners = 36,
	sniper = 80
}

M.encyclopedia_entries = {}

for _, tower_name in ipairs(M.towers) do
	local level_4_icon = M.encyclopedia_icons[tower_name]

	for level = 1, 4 do
		table.insert(M.encyclopedia_entries, {
			name = string.format("tower_%s_lvl%d", tower_name, level),
			icon = level_4_icon - 4 + level
		})
	end
end

M.legacy_detail_templates = {
	"tower_archer_kr1_lvl1",
	"tower_barrack_kr1_lvl1",
	"tower_mage_kr1_lvl1",
	"tower_engineer_kr1_lvl1"
}

M.legacy_encyclopedia_towers = {
	{name = "tower_archer_kr1_lvl1", icon = 62, i18n_key = "G6_TOWER_ARCHER_1"},
	{name = "tower_barrack_kr1_lvl1", icon = 57, i18n_key = "G6_TOWER_BARRACK_1"},
	{name = "tower_mage_kr1_lvl1", icon = 72, i18n_key = "G6_TOWER_MAGE_1"},
	{name = "tower_engineer_kr1_lvl1", icon = 67, i18n_key = "TOWER_ENGINEER_1"},
	{name = "tower_archer_kr1_lvl2", icon = 63, i18n_key = "G6_TOWER_ARCHER_2"},
	{name = "tower_barrack_kr1_lvl2", icon = 58, i18n_key = "G6_TOWER_BARRACK_2"},
	{name = "tower_mage_kr1_lvl2", icon = 73, i18n_key = "G6_TOWER_MAGE_2"},
	{name = "tower_engineer_kr1_lvl2", icon = 68, i18n_key = "TOWER_ENGINEER_2"},
	{name = "tower_archer_kr1_lvl3", icon = 64, i18n_key = "G6_TOWER_ARCHER_3"},
	{name = "tower_barrack_kr1_lvl3", icon = 59, i18n_key = "G6_TOWER_BARRACK_3"},
	{name = "tower_mage_kr1_lvl3", icon = 74, i18n_key = "G6_TOWER_MAGE_3"},
	{name = "tower_engineer_kr1_lvl3", icon = 69, i18n_key = "TOWER_ENGINEER_3"},
	{name = "tower_ranger_kr1", icon = 65, i18n_key = "TOWER_RANGERS"},
	{name = "tower_paladin_kr1", icon = 60, i18n_key = "TOWER_PALADINS"},
	{name = "tower_arcane_wizard_kr1", icon = 75, i18n_key = "G6_TOWER_ARCANE"},
	{name = "tower_bfg_kr1", icon = 70, i18n_key = "TOWER_BFG"},
	{name = "tower_musketeer_kr1", icon = 66, i18n_key = "TOWER_MUSKETEERS"},
	{name = "tower_barbarian_kr1", icon = 61, i18n_key = "TOWER_BARBARIANS"},
	{name = "tower_sorcerer_kr1", icon = 76, i18n_key = "TOWER_SORCERER"},
	{name = "tower_tesla_kr1", icon = 71, i18n_key = "TOWER_TESLA"}
}

M.legacy_advanced_skills = {
	tower_ranger_kr1 = {menu = "kr6_ranger_kr1", powers = {"poison", "thorn"}},
	tower_musketeer_kr1 = {menu = "kr6_musketeer_kr1", powers = {"sniper", "shrapnel"}},
	tower_paladin_kr1 = {menu = "kr6_paladin_kr1", powers = {"healing", "shield", "holystrike"}},
	tower_barbarian_kr1 = {menu = "kr6_barbarian_kr1", powers = {"dual", "twister", "throwing"}},
	tower_arcane_wizard_kr1 = {menu = "kr6_arcane_wizard_kr1", powers = {"disintegrate", "teleport"}},
	tower_sorcerer_kr1 = {menu = "kr6_sorcerer_kr1", powers = {"polymorph", "elemental"}},
	tower_bfg_kr1 = {menu = "kr6_bfg_kr1", powers = {"missile", "cluster"}},
	tower_tesla_kr1 = {menu = "kr6_tesla_kr1", powers = {"bolt", "overcharge"}}
}

M.menu_names = {
	"archers",
	"knights",
	"wizard",
	"catapult",
	"ranger",
	"culverine",
	"sunray_master",
	"light_priestess",
	"tree",
	"wildcat",
	"alchemist",
	"forger",
	"crossbows",
	"archer_kr1",
	"ranger_kr1",
	"musketeer_kr1",
	"barrack_kr1",
	"paladin_kr1",
	"barbarian_kr1",
	"mage_kr1",
	"arcane_wizard_kr1",
	"sorcerer_kr1",
	"engineer_kr1",
	"bfg_kr1",
	"tesla_kr1",
	"miners",
	"sniper"
}

M.ultimate_data = {
	archers = {icon = "archers", key = "archers_ulti", text = "ARCHERS"},
	knights = {icon = "knights", key = "barracks_ulti", text = "KNIGHTS"},
	wizard = {icon = "wizard", key = "mages_ulti", text = "WIZARD"},
	catapult = {icon = "catapult", key = "artillery_ulti", text = "CATAPULT"},
	ranger = {icon = "rangers", key = "archers_ulti", text = "RANGER"},
	culverine = {icon = "culverine", key = "artillery_ulti", text = "CULVERINE"},
	sunray_master = {icon = "sunray_master", key = "mages_ulti", text = "SUNRAY"},
	light_priestess = {icon = "light_priestess", key = "mages_ulti", text = "PRIESTESS"},
	tree = {icon = "tree", key = "artillery_ulti", text = "TREE"},
	wildcat = {icon = "wildcat", key = "barracks_ulti", text = "WILDCAT"},
	alchemist = {icon = "alchemist", key = "artillery_ulti", text = "ALCHEMIST"},
	forger = {icon = "forger", key = "mages_ulti", text = "FORGER"},
	crossbows = {icon = "crossbows", key = "archers_ulti", text = "CROSSBOWS"},
	miners = {icon = "dwarven_miners", key = "barracks_ulti", text = "MINERS"},
	sniper = {icon = "sniper", key = "archers_ulti", text = "SNIPER"}
}

return M
