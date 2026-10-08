local upgrades_6 = require("upgrades_6")

local generation_upgrades = {}

generation_upgrades.tree_order = {
	"g4_reinforcements",
	"g4_towers",
	"g5_reinforcements",
	"g5_towers",
	"g6_archers",
	"g6_barracks",
	"g6_mages",
	"g6_artillery"
}

generation_upgrades.page_tree_order = {
	[4] = {"g4_reinforcements", "g4_towers", "g5_reinforcements", "g5_towers"},
	[5] = upgrades_6.tree_order
}

generation_upgrades.trees = {
	g4_reinforcements = {
		name = "4代援军",
		root_name = "4代援军科技",
		root_description = "适用于4代关卡中的援军。",
		root_sprite = "Generation_G4_0028",
		exclusive_price_groups = {
			{
				"g4_reinforcements_guard",
				"g4_reinforcements_trident"
			},
			{
				"g4_reinforcements_guard_nova",
				"g4_reinforcements_flaming_trident"
			}
		},
		items = {
			{
				key = "g4_reinforcements_death_burst",
				level = 1,
				price = 2,
				icon = 26,
				name = "爆裂消亡",
				description = "4代援军死亡时对附近敌人造成范围伤害。"
			},
			{
				key = "g4_reinforcements_training",
				level = 2,
				price = 3,
				icon = 27,
				name = "强化恶魔",
				description = "将4代援军强化为训练有素的小恶魔。",
				requires = {"g4_reinforcements_death_burst"}
			},
			{
				key = "g4_reinforcements_guard",
				level = 3,
				price = 3,
				icon = 28,
				name = "恶魔卫兵",
				description = "召唤生命和护甲更高的近战恶魔卫兵。",
				requires = {"g4_reinforcements_training"},
				blocks = {"g4_reinforcements_trident"}
			},
			{
				key = "g4_reinforcements_trident",
				level = 3,
				price = 3,
				icon = 28,
				name = "地狱三叉戟",
				description = "召唤能够攻击地面与飞行敌人的远程恶魔。",
				requires = {"g4_reinforcements_training"},
				blocks = {"g4_reinforcements_guard"}
			},
			{
				key = "g4_reinforcements_guard_nova",
				level = 4,
				price = 3,
				icon = 29,
				name = "地狱新星",
				description = "恶魔卫兵死亡时产生更强、更大的爆炸。",
				requires = {"g4_reinforcements_guard"},
				blocks = {"g4_reinforcements_flaming_trident"}
			},
			{
				key = "g4_reinforcements_flaming_trident",
				level = 4,
				price = 3,
				icon = 29,
				name = "燃烧三叉戟",
				description = "远程恶魔的三叉戟会点燃命中的敌人。",
				requires = {"g4_reinforcements_trident"},
				blocks = {"g4_reinforcements_guard_nova"}
			},
			{
				key = "g4_reinforcements_pit_lord",
				level = 5,
				price = 4,
				icon = 30,
				name = "深渊领主",
				description = "召唤4代援军时有30%几率额外出现一名深渊领主。",
				requires_any = {
					"g4_reinforcements_guard_nova",
					"g4_reinforcements_flaming_trident"
				}
			}
		}
	},
	g4_towers = {
		name = "4代防御塔",
		root_name = "4代防御塔科技",
		root_description = "属于4代的防御塔和兵营单位可享受这些科技。",
		root_sprite = "Generation_G4_0013",
		items = {
			{
				key = "g4_towers_blitz_tactics",
				level = 1,
				price = 1,
				icon = 21,
				name = "闪电战术",
				description = "提前召唤敌人的奖励金币提高80%。"
			},
			{
				key = "g4_towers_war_rations",
				level = 2,
				price = 1,
				icon = 22,
				name = "军粮",
				description = "4代兵营士兵和部分雇佣兵单位的生命上限提高30%。",
				requires = {"g4_towers_blitz_tactics"}
			},
			{
				key = "g4_towers_large_bombs",
				level = 2,
				price = 1,
				icon = 23,
				name = "大型炸弹",
				description = "4代炮塔炮弹的爆炸范围提高20%。",
				requires = {"g4_towers_blitz_tactics"}
			},
			{
				key = "g4_towers_gxr1",
				level = 3,
				price = 2,
				icon = 24,
				name = "GXR-1瞄准系统",
				description = "4代高塔上的射手攻击范围提高5%。",
				requires = {"g4_towers_war_rations"}
			},
			{
				key = "g4_towers_rune_power",
				level = 3,
				price = 2,
				icon = 25,
				name = "力量符文",
				description = "4代法师塔攻击有10%几率造成2倍伤害。",
				chance = 0.1,
				damage_factor = 2,
				requires = {"g4_towers_large_bombs"}
			},
			{
				key = "g4_towers_merchant_guild",
				level = 4,
				price = 2,
				icon = 19,
				name = "商人行会",
				description = "4代防御塔的技能价格降低15%。",
				requires = {
					"g4_towers_gxr1",
					"g4_towers_rune_power"
				}
			},
			{
				key = "g4_towers_master_architect",
				level = 5,
				price = 2,
				icon = 20,
				name = "建筑大师",
				description = "4代防御塔和兵营单位造成的伤害提高10%。",
				requires = {"g4_towers_merchant_guild"}
			},
			{
				key = "g4_towers_death_coils",
				level = 5,
				price = 4,
				icon = 30,
				name = "死亡线圈",
				description = "每180秒从出口发射死亡线圈，造成150-300点真实伤害。",
				requires = {"g4_towers_merchant_guild"}
			}
		}
	},
	g5_reinforcements = {
		name = "5代援军",
		root_name = "5代援军科技",
		root_description = "适用于5代关卡中的援军。",
		root_sprite = "Generation_G5_Reinforcements_0008",
		exclusive_price_groups = {
			{
				"reinforcements_rebel_militia",
				"reinforcements_shadow_archer"
			},
			{
				"reinforcements_thorny_armor",
				"reinforcements_night_veil"
			},
			{
				"reinforcements_power_trio",
				"reinforcements_power_trio_dark"
			}
		},
		items = {
			{
				key = "reinforcements_master_blacksmiths",
				level = 1,
				price = 1,
				icon = 26,
				name_key = "reinforcements_master_blacksmiths_NAME",
				description_key = "reinforcements_master_blacksmiths_DESCRIPTION"
			},
			{
				key = "reinforcements_intense_workout",
				level = 2,
				price = 1,
				icon = 27,
				name_key = "reinforcements_intense_workout_NAME",
				description_key = "reinforcements_intense_workout_DESCRIPTION",
				requires = {"reinforcements_master_blacksmiths"}
			},
			{
				key = "reinforcements_rebel_militia",
				level = 3,
				price = 2,
				icon = 28,
				name_key = "reinforcements_rebel_militia_NAME",
				description_key = "reinforcements_rebel_militia_DESCRIPTION",
				requires = {"reinforcements_intense_workout"},
				blocks = {"reinforcements_shadow_archer"}
			},
			{
				key = "reinforcements_shadow_archer",
				level = 3,
				price = 2,
				icon = 28,
				name_key = "reinforcements_shadow_archer_NAME",
				description_key = "reinforcements_shadow_archer_DESCRIPTION",
				requires = {"reinforcements_intense_workout"},
				blocks = {"reinforcements_rebel_militia"}
			},
			{
				key = "reinforcements_thorny_armor",
				level = 4,
				price = 2,
				icon = 29,
				name_key = "reinforcements_thorny_armor_NAME",
				description_key = "reinforcements_thorny_armor_DESCRIPTION",
				requires = {"reinforcements_rebel_militia"}
			},
			{
				key = "reinforcements_night_veil",
				level = 4,
				price = 2,
				icon = 29,
				name_key = "reinforcements_night_veil_NAME",
				description_key = "reinforcements_night_veil_DESCRIPTION",
				requires = {"reinforcements_shadow_archer"}
			},
			{
				key = "reinforcements_power_trio",
				level = 5,
				price = 4,
				icon = 30,
				name_key = "reinforcements_power_trio_NAME",
				description_key = "reinforcements_power_trio_DESCRIPTION",
				requires = {"reinforcements_thorny_armor"}
			},
			{
				key = "reinforcements_power_trio_dark",
				level = 5,
				price = 4,
				icon = 30,
				name_key = "reinforcements_power_trio_dark_NAME",
				description_key = "reinforcements_power_trio_dark_DESCRIPTION",
				requires = {"reinforcements_night_veil"}
			}
		}
	},
	g5_towers = {
		name = "5代防御塔",
		root_name = "5代防御塔科技",
		root_description = "属于5代的防御塔和兵营单位可享受这些科技。",
		root_sprite = "Generation_G5_Towers_0008",
		items = {
			{
				key = "towers_war_rations",
				level = 1,
				price = 1,
				icon = 1,
				name_key = "towers_war_rations_NAME",
				description_key = "towers_war_rations_DESCRIPTION"
			},
			{
				key = "towers_wise_investment",
				level = 2,
				price = 1,
				icon = 2,
				name_key = "towers_wise_investment_NAME",
				description_key = "towers_wise_investment_DESCRIPTION",
				requires = {"towers_scoping_mechanism"}
			},
			{
				key = "towers_scoping_mechanism",
				level = 2,
				price = 2,
				icon = 3,
				name_key = "towers_scoping_mechanism_NAME",
				description_key = "towers_scoping_mechanism_DESCRIPTION",
				requires = {"towers_war_rations"}
			},
			{
				key = "towers_golden_time",
				level = 3,
				price = 2,
				icon = 4,
				name_key = "towers_golden_time_NAME",
				description_key = "towers_golden_time_DESCRIPTION",
				requires = {"towers_wise_investment"}
			},
			{
				key = "towers_improved_formulas",
				level = 4,
				price = 3,
				icon = 7,
				name_key = "towers_improved_formulas_NAME",
				description_key = "towers_improved_formulas_DESCRIPTION",
				requires = {"towers_royal_training"}
			},
			{
				key = "towers_royal_training",
				level = 3,
				price = 2,
				icon = 5,
				name_key = "towers_royal_training_NAME",
				description_key = "towers_royal_training_DESCRIPTION",
				requires = {"towers_scoping_mechanism"}
			},
			{
				key = "towers_favorite_customer",
				level = 4,
				price = 3,
				icon = 6,
				name_key = "towers_favorite_customer_NAME",
				description = "降低防御塔2、3级技能25%的购买价格。如果技能只有2级则降低2级50%价格，只有1级则降低1级20%价格。",
				requires = {"towers_golden_time"}
			},
			{
				key = "towers_keen_accuracy",
				level = 5,
				price = 4,
				icon = 8,
				name_key = "towers_keen_accuracy_NAME",
				description_key = "towers_keen_accuracy_DESCRIPTION",
				requires = {"towers_improved_formulas"}
			}
		}
	}
}

for tree_id, tree in pairs(upgrades_6.trees) do
	generation_upgrades.trees[tree_id] = tree
end

generation_upgrades.by_key = {}

for tree_id, tree in pairs(generation_upgrades.trees) do
	for _, item in ipairs(tree.items) do
		item.tree = tree_id
		generation_upgrades.by_key[item.key] = item
	end
end

local generation_sprites = {
	g4_reinforcements_death_burst = "Generation_G4_0022",
	g4_reinforcements_training = "Generation_G4_0023",
	g4_reinforcements_guard = "Generation_G4_0024",
	g4_reinforcements_trident = "Generation_G4_0025",
	g4_reinforcements_guard_nova = "Generation_G4_0027",
	g4_reinforcements_flaming_trident = "Generation_G4_0026",
	g4_reinforcements_pit_lord = "Generation_G4_0028",
	g4_towers_blitz_tactics = "Generation_G4_0006",
	g4_towers_war_rations = "Generation_G4_0007",
	g4_towers_large_bombs = "Generation_G4_0009",
	g4_towers_gxr1 = "Generation_G4_0008",
	g4_towers_rune_power = "Generation_G4_0010",
	g4_towers_merchant_guild = "Generation_G4_0011",
	g4_towers_master_architect = "Generation_G4_0013",
	g4_towers_death_coils = "Generation_G4_0012"
}

for key, sprite in pairs(generation_sprites) do
	generation_upgrades.by_key[key].sprite = sprite
end
for i, item in ipairs(generation_upgrades.trees.g5_reinforcements.items) do
	item.sprite = string.format("Generation_G5_Reinforcements_%04d", i)
end
for _, item in ipairs(generation_upgrades.trees.g5_towers.items) do
	item.sprite = string.format("Generation_G5_Towers_%04d", item.icon)
end

local function contains(list, value)
	for _, current in ipairs(list or {}) do
		if current == value then
			return true
		end
	end

	return false
end

local G5_LOGIC_VERSION = 2
local G6_LOGIC_VERSION = 1

local function normalize_g5_tree_state(user_data, tree_id)
	local source = user_data.generation_upgrades[tree_id]
	local selected = {}
	local purchase_order = {}
	local normalized = {}
	local changed = false

	for _, key in ipairs(source) do
		local item = generation_upgrades.by_key[key]

		if item and item.tree == tree_id and not selected[key] then
			selected[key] = true
			purchase_order[key] = #normalized + 1
			table.insert(normalized, key)
		else
			changed = true
		end
	end

	local removed = true

	while removed do
		removed = false

		for index = #normalized, 1, -1 do
			local key = normalized[index]
			local item = generation_upgrades.by_key[key]
			local valid = true

			for _, required_key in ipairs(item.requires or {}) do
				if not selected[required_key] then
					valid = false

					break
				end
			end

			if valid and item.requires_any then
				valid = false

				for _, required_key in ipairs(item.requires_any) do
					if selected[required_key] then
						valid = true

						break
					end
				end
			end

			if valid then
				for _, blocked_key in ipairs(item.blocks or {}) do
					if selected[blocked_key] and purchase_order[blocked_key] < purchase_order[key] then
						valid = false

						break
					end
				end
			end

			if not valid then
				table.remove(normalized, index)
				selected[key] = nil
				changed = true
				removed = true
			end
		end
	end

	if changed then
		user_data.generation_upgrades[tree_id] = normalized
	end

	return changed
end

function generation_upgrades.normalize(user_data)
	if not user_data then
		return false
	end

	local changed = false

	if type(user_data.generation_upgrades) ~= "table" then
		user_data.generation_upgrades = {}
		changed = true
	end

	for _, tree_id in ipairs(generation_upgrades.tree_order) do
		if type(user_data.generation_upgrades[tree_id]) ~= "table" then
			user_data.generation_upgrades[tree_id] = {}
			changed = true
		end
	end

	if user_data.generation_upgrades._g5_logic_version ~= G5_LOGIC_VERSION then
		for _, tree_id in ipairs({"g5_reinforcements", "g5_towers"}) do
			if normalize_g5_tree_state(user_data, tree_id) then
				changed = true
			end
		end

		user_data.generation_upgrades._g5_logic_version = G5_LOGIC_VERSION
		changed = true
	end

	if user_data.generation_upgrades._g6_logic_version ~= G6_LOGIC_VERSION then
		for _, tree_id in ipairs(generation_upgrades.page_tree_order[5]) do
			if normalize_g5_tree_state(user_data, tree_id) then
				changed = true
			end
		end

		user_data.generation_upgrades._g6_logic_version = G6_LOGIC_VERSION
		changed = true
	end

	return changed
end

function generation_upgrades.get(key)
	return generation_upgrades.by_key[key]
end

function generation_upgrades.has(user_data, tree_id, key)
	generation_upgrades.normalize(user_data)

	return contains(user_data.generation_upgrades[tree_id], key)
end

function generation_upgrades.has_key(user_data, key)
	local item = generation_upgrades.get(key)

	return item and generation_upgrades.has(user_data, item.tree, key) or false
end

local function prerequisites_met(user_data, item)
	for _, key in ipairs(item.requires or {}) do
		if not generation_upgrades.has_key(user_data, key) then
			return false
		end
	end

	if item.requires_any then
		local any = false

		for _, key in ipairs(item.requires_any) do
			if generation_upgrades.has_key(user_data, key) then
				any = true

				break
			end
		end

		if not any then
			return false
		end
	end

	return true
end

function generation_upgrades.can_buy(user_data, tree_id, key)
	local item = generation_upgrades.get(key)

	if not item or item.tree ~= tree_id or generation_upgrades.has(user_data, tree_id, key) then
		return false
	end

	for _, blocked_key in ipairs(item.blocks or {}) do
		if generation_upgrades.has_key(user_data, blocked_key) then
			return false
		end
	end

	return prerequisites_met(user_data, item)
end

function generation_upgrades.buy(user_data, tree_id, key)
	if not generation_upgrades.can_buy(user_data, tree_id, key) then
		return false
	end

	table.insert(user_data.generation_upgrades[tree_id], key)

	return true
end

local function remove_key(list, key)
	for index = #list, 1, -1 do
		if list[index] == key then
			table.remove(list, index)

			return true
		end
	end

	return false
end

function generation_upgrades.refund_from(user_data, tree_id, key)
	if not generation_upgrades.has(user_data, tree_id, key) then
		return 0
	end

	local refunded = 0
	local tree = generation_upgrades.trees[tree_id]

	remove_key(user_data.generation_upgrades[tree_id], key)
	refunded = refunded + generation_upgrades.by_key[key].price

	local changed = true

	while changed do
		changed = false

		for _, item in ipairs(tree.items) do
			if generation_upgrades.has(user_data, tree_id, item.key) and not prerequisites_met(user_data, item) then
				remove_key(user_data.generation_upgrades[tree_id], item.key)
				refunded = refunded + item.price
				changed = true
			end
		end
	end

	return refunded
end

function generation_upgrades.reset(user_data, tree_id)
	generation_upgrades.normalize(user_data)
	user_data.generation_upgrades[tree_id] = {}
end

function generation_upgrades.reset_all(user_data)
	for _, tree_id in ipairs(generation_upgrades.tree_order) do
		generation_upgrades.reset(user_data, tree_id)
	end
end

function generation_upgrades.reset_page(user_data, page)
	for _, tree_id in ipairs(generation_upgrades.page_tree_order[page] or {}) do
		generation_upgrades.reset(user_data, tree_id)
	end
end

function generation_upgrades.spent(user_data, tree_id)
	generation_upgrades.normalize(user_data)

	local total = 0
	local trees = tree_id and {tree_id} or generation_upgrades.tree_order

	for _, current_tree in ipairs(trees) do
		for _, key in ipairs(user_data.generation_upgrades[current_tree]) do
			local item = generation_upgrades.get(key)

			if item then
				total = total + item.price
			end
		end
	end

	return total
end

function generation_upgrades.spent_page(user_data, page)
	local total = 0

	for _, tree_id in ipairs(generation_upgrades.page_tree_order[page] or {}) do
		total = total + generation_upgrades.spent(user_data, tree_id)
	end

	return total
end

function generation_upgrades.total_price(tree_id)
	local total = 0
	local trees = tree_id and {tree_id} or generation_upgrades.tree_order

	for _, current_tree in ipairs(trees) do
		local tree = generation_upgrades.trees[current_tree]
		local tree_total = 0

		for _, item in ipairs(tree.items) do
			tree_total = tree_total + item.price
		end

		for _, group in ipairs(tree.exclusive_price_groups or {}) do
			local group_total = 0
			local group_max = 0

			for _, key in ipairs(group) do
				local item = generation_upgrades.get(key)

				if item and item.tree == current_tree then
					group_total = group_total + item.price
					group_max = math.max(group_max, item.price)
				end
			end

			tree_total = tree_total - group_total + group_max
		end

		total = total + tree_total
	end

	return total
end

function generation_upgrades.copy_state(user_data)
	generation_upgrades.normalize(user_data)

	local result = {}

	for _, tree_id in ipairs(generation_upgrades.tree_order) do
		result[tree_id] = {}

		for _, key in ipairs(user_data.generation_upgrades[tree_id]) do
			table.insert(result[tree_id], key)
		end
	end

	return result
end

function generation_upgrades.restore_state(user_data, state)
	generation_upgrades.normalize(user_data)

	for _, tree_id in ipairs(generation_upgrades.tree_order) do
		user_data.generation_upgrades[tree_id] = {}

		for _, key in ipairs(state and state[tree_id] or {}) do
			if generation_upgrades.get(key) then
				table.insert(user_data.generation_upgrades[tree_id], key)
			end
		end
	end
end

function generation_upgrades.early_wave_reward_factor(user_data, level_idx)
	if level_idx and level_idx >= 101 and level_idx <= 149 then
		return generation_upgrades.has_key(user_data, "towers_golden_time") and 1.8 or 1
	elseif level_idx and level_idx >= 150 and level_idx <= 201 then
		return generation_upgrades.has_key(user_data, "g4_towers_blitz_tactics") and 1.8 or 1
	end

	return 1
end

function generation_upgrades.level(user_data, tree_id)
	local level = 0

	for _, item in ipairs(generation_upgrades.trees[tree_id].items) do
		if generation_upgrades.has(user_data, tree_id, item.key) then
			level = math.max(level, item.level)
		end
	end

	return level
end

function generation_upgrades.g4_reinforcement_branch(user_data)
	if generation_upgrades.has_key(user_data, "g4_reinforcements_trident") then
		return "dark"
	end

	return "royal"
end

function generation_upgrades.g5_reinforcement_branch(user_data)
	if generation_upgrades.has_key(user_data, "reinforcements_shadow_archer") then
		return "dark"
	end

	return "royal"
end

return generation_upgrades
