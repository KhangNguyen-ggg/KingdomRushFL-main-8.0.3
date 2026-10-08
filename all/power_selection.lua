local UPGR = require("upgrades")
local generation_upgrades = require("generation_upgrades")
local power_upgrades_6 = require("power_upgrades_6")

local M = {}

local kr6_power_exoskeleton_groups = {
	royal_edict = {"go_power_royal_edict"},
	soaring_shop = {"go_power_soaring_shop"},
	aspect_of_sol = {"go_power_aspect_of_sol"},
	teleportation_sigil = {"go_power_teleportation_sigil"},
	thunder_zapper = {"go_power_thunder_zapper"},
	wintersongs_wrath = {"go_power_wintersongs_wrath"}
}

local function kr6_power_option(power_name, label, description, pointer_style, reinforcement)
	return {
		label = label,
		icon = "kr6_icon_room_power_" .. power_name,
		map_icon = "kr6_icon_room_power_" .. power_name,
		button_icon = "in_game_icon_power_" .. power_name,
		button_scale = 0.7,
		pointer_icon = "pointer_power_" .. power_name,
		pointer_scale = 0.8,
		pointer_style = pointer_style or "point",
		kind = reinforcement and "reinforcement" or "kr6_power",
		generation = 6,
		power_name = power_name,
		controller_name = reinforcement and "power_reinforcements_control_g6" or "power_" .. power_name .. "_control",
		description = description,
		required_textures = {"kr6_ui_icons", "go_power_" .. power_name},
		required_sounds = {"kr6_common_gameplay", "powers_" .. power_name},
		required_exoskeleton_groups = kr6_power_exoskeleton_groups[power_name]
	}
end

local item_required_exoskeletons = {
	portable_coil = {
		"item_portable_coilDef",
		"item_portable_coil_hitDef"
	},
	veznan_wrath = {
		"veznan_wrath_exoskeleton"
	}
}

M.order = {
	"empty_spell",
	"default_cataclysm",
	"default_reinforcement",
	"lightning_flash",
	"reinforcement_g1",
	"reinforcement_g2",
	"reinforcement_g3",
	"reinforcement_g4",
	"reinforcement_g5",
	"fireball_g1",
	"fireball_g2",
	"thunder_g3",
	"mermaid_gift",
	"yao_spirit_blessing",
	"shaosiyuan_fateful_bond",
	"item_cluster_bomb",
	"item_portable_coil",
	"item_scroll_of_spaceshift",
	"item_deaths_touch",
	"item_winter_age",
	"item_summon_blackburn",
	"item_loot_box",
	"item_medical_kit",
	"item_veznan_wrath",
	"kro_teleport_scroll",
	"kro_horn_heroism",
	"kro_gem_timewarp",
	"kro_rod_dragon_fire",
	"kro_hand_midas",
	"kro_wrath_of_elynia",
	"reinforcement_g6",
	"fireball_g6",
	"royal_edict_g6",
	"soaring_shop_g6",
	"aspect_of_sol_g6",
	"teleportation_sigil_g6",
	"thunder_zapper_g6",
	"wintersongs_wrath_g6",
	"musketeers_g6"
}

local function cheat_item_option(item_name, label, price, cooldown, effect, pointer_style, max_uses, controller_values)
	return {
		label = label,
		icon = "cheat_item_spell_" .. item_name,
		map_icon = "cheat_item_spell_" .. item_name,
		pointer_icon = "pointer_cheat_item_spell_" .. item_name,
		pointer_style = pointer_style,
		kind = "cheat_item",
		controller_name = "controller_item_" .. item_name,
		item_name = item_name,
		price = price,
		cooldown = cooldown,
		max_uses = max_uses,
		controller_values = controller_values,
		required_textures = {"go_items_" .. item_name},
		required_exoskeletons = item_required_exoskeletons[item_name],
		required_sounds = {"item_" .. item_name},
		description = string.format("%s 冷却时间为%i秒。%s", effect, cooldown,
			max_uses and string.format("每局最多使用%i次。", max_uses) or "")
	}
end

local function kro_item_option(item_name, template_name, label, cooldown, effect, pointer_style, max_uses,
		required_textures, cast_sound, required_sounds)
	return {
		label = label,
		icon = "cheat_item_spell_kro_" .. item_name,
		map_icon = "cheat_item_spell_kro_" .. item_name,
		pointer_icon = "pointer_cheat_item_spell_kro_" .. item_name,
		pointer_style = pointer_style,
		kind = "cheat_item",
		controller_name = "user_item_" .. template_name,
		item_name = "kro_" .. item_name,
		cooldown = cooldown,
		max_uses = max_uses,
		required_textures = required_textures or {},
		cast_sound = cast_sound,
		required_sounds = required_sounds or {},
		description = string.format("%s 冷却时间为%i秒。%s", effect, cooldown,
			max_uses and string.format("每局最多使用%i次。", max_uses) or "")
	}
end

M.options = {
	reinforcement_g1 = {
		label = "1代援军",
		icon = "reinforcements_0001",
		map_icon = "spell_selection_icon_reinforcement",
		pointer_icon = "pointer_user_power_0002",
		pointer_style = "point",
		kind = "reinforcement",
		generation = 1,
		tech_upgrade = "reinforcements"
	},
	reinforcement_g2 = {
		label = "2代援军",
		icon = "reinforcements_0001",
		map_icon = "spell_selection_icon_reinforcement",
		pointer_icon = "pointer_user_power_0002",
		pointer_style = "point",
		kind = "reinforcement",
		generation = 2,
		tech_upgrade = "reinforcements"
	},
	reinforcement_g3 = {
		label = "3代援军",
		icon = "power_button_icons_0018",
		map_icon = "spell_selection_icon_reinforcement_g3",
		pointer_icon = "pointer_hero_power_0018",
		pointer_style = "point",
		kind = "reinforcement",
		generation = 3,
		tech_upgrade = "reinforcements"
	},
	reinforcement_g4 = {
		label = "4代援军",
		icon = "reinforcements_0001",
		map_icon = "spell_selection_icon_reinforcement",
		pointer_icon = "pointer_user_power_0002",
		pointer_style = "point",
		kind = "reinforcement",
		generation = 4,
		tech_upgrade = "reinforcements",
		scale_required_textures = {"kr4_power_reinforcements"}
	},
	reinforcement_g5 = {
		label = "5代援军",
		icon = "reinforcements_0001",
		map_icon = "spell_selection_icon_reinforcement",
		pointer_icon = "pointer_user_power_0002",
		pointer_style = "point",
		kind = "reinforcement",
		generation = 5,
		tech_upgrade = "reinforcements"
	},
	reinforcement_g6 = kr6_power_option("reinforcements", "6代援军",
		"召唤两名近战单位上场与敌人战斗。基础冷却时间为15秒。", "point", true),
	fireball_g1 = {
		label = "1代火雨",
		icon = "fire_0001",
		map_icon = "spell_selection_icon_fire",
		pointer_icon = "pointer_user_power_0001",
		pointer_style = "area",
		kind = "fireball",
		generation = 1,
		tech_upgrade = "thunder"
	},
	fireball_g2 = {
		label = "2代火雨",
		icon = "fire_0001",
		map_icon = "spell_selection_icon_fire",
		pointer_icon = "pointer_user_power_0001",
		pointer_style = "area",
		kind = "fireball",
		generation = 2,
		tech_upgrade = "thunder"
	},
	thunder_g3 = {
		label = "3代闪电",
		icon = "power_button_icons_0017",
		map_icon = "spell_selection_icon_thunder",
		pointer_icon = "pointer_hero_power_0017",
		pointer_style = "area",
		kind = "thunder",
		generation = 3,
		tech_upgrade = "thunder"
	},
	fireball_g6 = kr6_power_option("rain_of_fire", "6代火雨",
		"召来毁灭的魔法流星，让炽烈燃烧的陨石降下冲击，在范围内对敌军造成大量伤害。基础冷却时间为60秒。", "area"),
	royal_edict_g6 = kr6_power_option("royal_edict", "皇家号令",
		"提升周围防御塔的伤害，持续数秒。基础冷却时间为50秒。", "area"),
	soaring_shop_g6 = kr6_power_option("soaring_shop", "侏儒商店",
		"召唤一间飞行商店，投掷炸药攻击敌人。基础冷却时间为50秒。", "point"),
	aspect_of_sol_g6 = kr6_power_option("aspect_of_sol", "索罗化身",
		"召唤初代圣骑士的化身与敌人战斗。基础冷却时间为60秒。", "point"),
	teleportation_sigil_g6 = kr6_power_option("teleportation_sigil", "传送符印",
		"将部分敌人沿路径向后传送。基础冷却时间为45秒。", "area"),
	thunder_zapper_g6 = kr6_power_option("thunder_zapper", "放电工程师",
		"召唤一名放电工程师，释放电流攻击途经的敌人。基础冷却时间为50秒。", "point"),
	wintersongs_wrath_g6 = kr6_power_option("wintersongs_wrath", "凛冬怒咏",
		"召唤伊罗拉以冰霜之力妨碍敌人的行动。基础冷却时间为40秒。", "area"),
	musketeers_g6 = kr6_power_option("musketeers", "王牌火枪手",
		"召唤数名火枪手射击敌人。基础冷却时间为20秒。", "point"),
	lightning_flash = {
		label = "Flash闪电",
		icon = "lightning_0001",
		map_icon = "spell_selection_icon_flash",
		pointer_icon = "pointer_user_power_0003",
		pointer_style = "point",
		kind = "lightning",
		description = "本法术为1代flash版的付费内容。效果是造成666-999点单体真实伤害，冷却时间25秒。"
	},
	mermaid_gift = {
		label = "人鱼赐福",
		icon = "dolia_mermaid_gift_0001",
		map_icon = "dolia_mermaid_gift_0001",
		pointer_icon = "pointer_dolia_mermaid_gift_0001",
		pointer_style = "point",
		kind = "mermaid_gift",
		cooldown = 40,
		description = "刷新所有正在冷却的英雄大招，并治疗、复活全屏友军；其他法术不受影响。若有多个相同的主动英雄大招，只刷新其中剩余冷却时间最长的一个。必须有可刷新的英雄大招正在冷却才能释放。冷却时间为40秒加上本次实际刷新冷却总时间的1.6倍，最高200秒。"
	},
	yao_spirit_blessing = {
		label = "独立兮山之上",
		icon = "yao_spell_icon_0001",
		map_icon = "yao_spell_icon_0001",
		pointer_icon = "pointer_yao_spell_0001",
		pointer_style = "point",
		kind = "global_support",
		controller_name = "controller_power_yao_spirit_blessing",
		cooldown = 70,
		revive_allies = true,
		cast_sound = "YaoSpellCast",
		required_textures = {"yao_spell_icon", "yao_spell_fx"},
		required_sounds = {"power_yao_spell"},
		description = "立即复活我方所有单位，为全场所有我方非飞行单位提供200点护盾；沉默场上所有敌方英雄，并使其攻击力、护甲与魔抗降低50%，持续14秒。冷却时间为70秒。"
	},
	shaosiyuan_fateful_bond = {
		label = "因缘际会",
		icon = "shaosiyuan_spell_icon_0001",
		map_icon = "shaosiyuan_spell_icon_0001",
		pointer_icon = "pointer_shaosiyuan_spell_0001",
		pointer_style = "point",
		kind = "global_support",
		controller_name = "controller_power_shaosiyuan_fateful_bond",
		cooldown = 80,
		revive_allies = true,
		cast_sound = "ShaosiyuanSpellCast",
		required_textures = {"shaosiyuan_spell_icon", "shaosiyuan_spell_fx"},
		required_sounds = {"power_shaosiyuan_spell"},
		description = "立即复活我方所有单位；持续16秒，全场所有我方单位每秒回复10%最大生命值，所有怪物降低30%移动速度并每秒受到8点真实伤害。每命中2名我方士兵，或者每命中2名敌人，都会获得2金币的奖励。冷却时间为80秒。"
	},
	default_cataclysm = {
		label = "默认天灾",
		icon = "power_button_icons_0017",
		map_icon = "spell_selection_icon_thunder",
		pointer_icon = "pointer_hero_power_0017",
		pointer_style = "area",
		kind = "default_cataclysm",
		description = "使用所进入关卡的默认自带的天灾。1/4代使用1代火雨，2代使用2代火雨，3/5代使用3代闪电，6代使用6代火雨。"
	},
	default_reinforcement = {
		label = "默认援军",
		icon = "reinforcements_0001",
		map_icon = "spell_selection_icon_reinforcement",
		pointer_icon = "pointer_user_power_0002",
		pointer_style = "point",
		kind = "reinforcement",
		default_generation = true,
		description = "使用所进入关卡的默认自带的援军。"
	},
	empty_spell = {
		label = "空法术",
		icon = "spell_selection_icon_empty",
		map_icon = "spell_selection_icon_empty",
		pointer_icon = "spell_selection_icon_empty",
		pointer_style = "point",
		kind = "empty",
		description = "不启用该法术槽位",
		cooldown = 100
	},
	item_cluster_bomb = cheat_item_option("cluster_bomb", "集束炸弹", 50, 24,
		"投掷一枚炸弹，对范围内的敌人造成伤害，并在周围分裂出更多小型炸弹。", "area"),
	item_portable_coil = cheat_item_option("portable_coil", "便携式线圈", 80, 24,
		"在路径上设置陷阱，伤害并眩晕触发它的敌人，效果可连锁至附近敌人。", "area"),
	item_scroll_of_spaceshift = cheat_item_option("scroll_of_spaceshift", "空间移动卷轴", 150, 30,
		"将范围内最多10名敌人向路径后方传送。", "area"),
	item_deaths_touch = cheat_item_option("deaths_touch", "死亡之触", 300, 90,
		"点击敌人将其立即消灭；对首领造成高额真实伤害。", "point"),
	item_winter_age = cheat_item_option("winter_age", "凛冬已至", 350, 75,
		"冻结战场上的所有有效敌人。", "area"),
	item_summon_blackburn = cheat_item_option("summon_blackburn", "布莱克本之盔", 600, 108,
		"召唤布莱克本领主在路径上协助作战。", "point"),
	item_loot_box = cheat_item_option("loot_box", "战利品箱", 400, 150,
		"向路径投下宝箱，对敌人造成伤害并获得666金币。", "area", 2, {gold_amount = 666}),
	item_medical_kit = cheat_item_option("medical_kit", "医疗包", 300, 150,
		"获得5点生命值。", "point", 2, {hearts = 5}),
	item_veznan_wrath = cheat_item_option("veznan_wrath", "维兹南之怒", 990, 180,
		"维兹南施放强大魔法，对战场上的所有敌人造成毁灭性打击。", "area", 1),
	kro_teleport_scroll = kro_item_option("teleport_scroll", "teleport_scroll", "传送卷轴", 30,
		"将范围内的敌人向路径后方传送。", "area"),
	kro_horn_heroism = kro_item_option("horn_heroism", "horn_heroism", "英雄号角", 84,
		"强化附近的士兵与防御塔，使其获得保护并造成双倍伤害。", "area"),
	kro_gem_timewarp = kro_item_option("gem_timewarp", "gem_timewarp", "漩涡之门", 72,
		"对战场上的所有怪物造成128点魔法伤害，将其向路径后方传送并使其减速。", "area", nil, nil,
		"DaqiaoVortexGateCast", {"power_daqiao_vortex_gate"}),
	kro_rod_dragon_fire = kro_item_option("rod_dragon_fire", "rod_dragon_fire", "龙息法杖", 120,
		"在路径上放置龙息法杖，持续向附近敌人发射火球。", "point", nil, {"go_items_rod_dragon_fire"}),
	kro_hand_midas = kro_item_option("hand_midas", "hand_midas", "迈达斯之手", 120,
		"在35秒内使击杀敌人获得的金币翻倍。", "point", 2),
	kro_wrath_of_elynia = kro_item_option("wrath_of_elynia", "wrath_of_elynia", "艾纳妮之怒", 180,
		"消灭战场上的普通敌人，并对首领造成3000点真实伤害。", "area", 1)
}

local cataclysm_options = {
	default_cataclysm = true,
	fireball_g1 = true,
	fireball_g2 = true,
	thunder_g3 = true,
	fireball_g6 = true
}

function M.is_cataclysm(option_id)
	return cataclysm_options[option_id] == true
end

local default_slots = {
	"default_cataclysm",
	"default_reinforcement",
	"empty_spell"
}

function M.normalize(user_data)
	user_data.liuhui = user_data.liuhui or {}

	local changed = false
	local _, power_upgrades_changed = power_upgrades_6.normalize(user_data)
	local selection = user_data.liuhui.power_selection

	changed = changed or power_upgrades_changed

	if type(selection) ~= "table" then
		selection = {}
		user_data.liuhui.power_selection = selection
		changed = true
	end

	if type(selection.slots) ~= "table" then
		selection.slots = {}
		changed = true
	end

	for slot = 1, 3 do
		if not M.options[selection.slots[slot]] then
			selection.slots[slot] = default_slots[slot]
			changed = true
		end
	end

	local has_cataclysm = false

	for slot = 1, 3 do
		if M.is_cataclysm(selection.slots[slot]) then
			if has_cataclysm then
				selection.slots[slot] = "empty_spell"
				changed = true
			else
				has_cataclysm = true
			end
		end
	end

	if selection.hero_ultimate ~= nil then
		selection.hero_ultimate = nil
		changed = true
	end

	return selection, changed
end

function M.get(user_data, slot)
	local selection = M.normalize(user_data)

	return M.options[selection.slots[slot]], selection.slots[slot]
end

function M.set(user_data, slot, option_id)
	if slot < 1 or slot > 3 or not M.options[option_id] then
		return false, "invalid_option"
	end

	local selection = M.normalize(user_data)

	if M.is_cataclysm(option_id) then
		for other_slot = 1, 3 do
			if other_slot ~= slot and M.is_cataclysm(selection.slots[other_slot]) then
				return false, "cataclysm_limit"
			end
		end
	end

	selection.slots[slot] = option_id

	return true
end

function M.apply_default(user_data)
	local selection = M.normalize(user_data)

	for slot = 1, 3 do
		selection.slots[slot] = default_slots[slot]
	end

	return true
end

function M.get_description(user_data, option_id)
	local option = M.options[option_id]

	if not option then
		return ""
	end

	if option.tech_upgrade then
		local level = 0

		if user_data and option.generation and option.generation <= 3 then
			level = UPGR:get_user_levels(user_data, option.generation)[option.tech_upgrade] or 0
		elseif user_data and option.kind == "reinforcement" and (option.generation == 4 or option.generation == 5) then
			level = generation_upgrades.level(user_data, "g" .. option.generation .. "_reinforcements")
		end

		return string.format("本法术受科技树相应栏目的影响。不在本页面调整。当前科技等级为%i", level)
	end

	return option.description or ""
end

function M.get_selected_dependencies(user_data)
	local selection = M.normalize(user_data)
	local result = {
		required_textures = {},
		scale_required_textures = {},
		required_sounds = {},
		required_exoskeletons = {},
		required_exoskeleton_groups = {}
	}
	local seen = {}

	local function append_unique(target_name, value)
		local key = target_name .. ":" .. value

		if not seen[key] then
			seen[key] = true
			table.insert(result[target_name], value)
		end
	end

	for slot = 1, 3 do
		local option = M.options[selection.slots[slot]]

		if option then
			for _, value in ipairs(option.required_textures or {}) do
				append_unique("required_textures", value)
			end

			for _, value in ipairs(option.scale_required_textures or {}) do
				append_unique("scale_required_textures", value)
			end

			for _, value in ipairs(option.required_sounds or {}) do
				append_unique("required_sounds", value)
			end

			for _, value in ipairs(option.required_exoskeletons or {}) do
				append_unique("required_exoskeletons", value)
			end

			for _, value in ipairs(option.required_exoskeleton_groups or {}) do
				append_unique("required_exoskeleton_groups", value)
			end
		end
	end

	return result
end

function M.should_auto_cast_hero_ultimate(store, hero, allowed, excluded)
	if not store or not hero or type(hero.template_name) ~= "string" then
		return false
	end

	if store.level_mode == GAME_MODE_CAMPAIGN and store.campaign_variant == CAMPAIGN_VARIANT_HERO_RALLY then
		return true
	end

	return allowed and not excluded and string.sub(hero.template_name, -2) == "_2"
end

return M
