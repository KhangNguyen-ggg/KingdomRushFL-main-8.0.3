local E = require("entity_db")
local log = require("klua.log"):new("hero_upgrades_6")
local data = require("hero_upgrades_6_data")
local patch_order = require("hero_upgrades_6_order")
local specs = require("hero_upgrades_6_specs")

require("klua.table")

local M = {}

M.hero_names = {
	"hero_gerald_g6",
	"hero_zefira",
	"hero_bolin_g6",
	"hero_malik_g6",
	"hero_ashbite",
	"hero_rhodes",
	"hero_drakkan",
	"hero_myriath",
	"hero_connor",
	"hero_ignus_g6",
	"hero_oni_g6",
	"hero_illiana",
	"hero_silent"
}

M.node_order = {
	"skill_a",
	"upg_sa1",
	"upg_sa2",
	"skill_b",
	"upg_sb1",
	"upg_sb2",
	"skill_c",
	"upg_sc1",
	"upg_sc2",
	"talent_1",
	"talent_2",
	"ulti",
	"upg_a",
	"upg_b",
	"upg_c",
	"upg_d",
	"upg_e"
}

M.exclusive_nodes = {
	talent_1 = "talent_2",
	talent_2 = "talent_1"
}

M.balance_names = {
	hero_gerald_g6 = "hero_gerald",
	hero_bolin_g6 = "hero_bolin",
	hero_malik_g6 = "hero_malik",
	hero_ignus_g6 = "hero_ignus",
	hero_oni_g6 = "hero_oni"
}

M.data = data

local function clone(value)
	return type(value) == "table" and table.deepclone(value) or value
end

local operators = {
	set = function(_, value)
		return clone(value)
	end,
	mul = function(current, value)
		return current * value
	end,
	mul_sub = function(current, value)
		return current * (1 - value)
	end,
	ceil = function(current)
		return math.ceil(current)
	end,
	map_mul = function(current, value)
		local result = table.deepclone(current)

		for i, item in ipairs(result) do
			result[i] = math.ceil(item * value)
		end

		return result
	end,
	map_mul_sum = function(current, value)
		local result = table.deepclone(current)

		for i, item in ipairs(result) do
			result[i] = math.ceil(item * (1 + value))
		end

		return result
	end,
	map_set = function(current, value)
		local result = table.deepclone(current)

		for i in ipairs(result) do
			result[i] = value
		end

		return result
	end,
	map_sum = function(current, value)
		local result = table.deepclone(current)

		for i, item in ipairs(result) do
			result[i] = item + value
		end

		return result
	end
}

local function parse_path(path)
	local result = {}

	for part in path:gmatch("([^%.]+)") do
		local name, index = part:match("^([^%[]+)%[(%d+)%]$")

		if name then
			table.insert(result, name)
			table.insert(result, tonumber(index))
		else
			table.insert(result, part)
		end
	end

	return result
end

local function apply_patch(upgrade_key, patch_index, patch)
	local operation_names = type(patch.operators) == "table" and patch.operators or {patch.operators}

	for _, template_name in ipairs(patch.templates) do
		local template_names = {template_name}

		if table.contains(M.hero_names, template_name) and E.entities[template_name .. "_2"] then
			table.insert(template_names, template_name .. "_2")
		end

		for _, target_name in ipairs(template_names) do
			local template = E:get_template(target_name)

			if not template then
				log.error("upgrade %s references missing template %s", upgrade_key, target_name)
			else
				for _, path in ipairs(patch.paths) do
					local parts = parse_path(path)
					local holder = template
					local valid = true

					for i = 1, #parts - 1 do
						holder = holder[parts[i]]

						if holder == nil then
							log.error("upgrade %s patch %s cannot resolve %s", upgrade_key, patch_index, path)
							valid = false
							break
						end
					end

					if valid then
						local field = parts[#parts]
						local value = holder[field]

						for _, operation_name in ipairs(operation_names) do
							local operation = operators[operation_name]

							if not operation then
								error(string.format("unsupported sixth-generation hero upgrade operator %s", tostring(operation_name)))
							end

							value = operation(value, patch.value)
						end

						holder[field] = value
					end
				end
			end
		end
	end
end

function M.is_hero(hero_name)
	return data[hero_name] ~= nil
end

function M.normalize(user_data)
	user_data.hero_upgrades_6 = user_data.hero_upgrades_6 or {}

	local changed = false

	for _, hero_name in ipairs(M.hero_names) do
		if type(user_data.hero_upgrades_6[hero_name]) ~= "table" then
			user_data.hero_upgrades_6[hero_name] = {}
			changed = true
		end

		local bought = user_data.hero_upgrades_6[hero_name]

		if bought.talent_1 and bought.talent_2 then
			bought.talent_2 = nil
			changed = true
		end
	end

	return changed
end


function M.is_bought(user_data, hero_name, node_id)
	M.normalize(user_data)

	return user_data.hero_upgrades_6[hero_name][node_id] == true
end

function M.spent_points(user_data, hero_name)
	M.normalize(user_data)

	local tree = data[hero_name]
	local bought = user_data.hero_upgrades_6[hero_name]
	local spent = 0

	if not tree then
		return spent
	end

	for _, node_id in ipairs(M.node_order) do
		if bought[node_id] then
			spent = spent + tree.nodes[node_id].cost
		end
	end

	return spent
end

function M.remaining_points(user_data, hero_name, hero_level, points_by_level)
	local total = points_by_level[hero_level] or 0

	return math.max(0, total - M.spent_points(user_data, hero_name))
end

function M.can_buy(user_data, hero_name, node_id, hero_level, points_by_level)
	local tree = data[hero_name]
	local node = tree and tree.nodes[node_id]

	if not node or M.is_bought(user_data, hero_name, node_id) then
		return false
	end

	if node.requires and not M.is_bought(user_data, hero_name, node.requires) then
		return false
	end

	local exclusive_node = M.exclusive_nodes[node_id]
	local remaining = M.remaining_points(user_data, hero_name, hero_level, points_by_level)

	if exclusive_node and M.is_bought(user_data, hero_name, exclusive_node) then
		remaining = remaining + tree.nodes[exclusive_node].cost
	end

	return remaining >= node.cost
end

function M.buy(user_data, hero_name, node_id, hero_level, points_by_level)
	if not M.can_buy(user_data, hero_name, node_id, hero_level, points_by_level) then
		return false
	end

	local bought = user_data.hero_upgrades_6[hero_name]
	local exclusive_node = M.exclusive_nodes[node_id]

	if exclusive_node then
		bought[exclusive_node] = nil
	end

	bought[node_id] = true

	return true
end

function M.reset(user_data, hero_name)
	M.normalize(user_data)
	user_data.hero_upgrades_6[hero_name] = {}
end

function M.apply(user_data)
	M.normalize(user_data)

	for _, upgrade_key in ipairs(patch_order) do
		local upgrade = specs[upgrade_key]
		local bought = user_data.hero_upgrades_6[upgrade.class]

		if bought and bought[upgrade.id] then
			for patch_index, patch in ipairs(upgrade.patches or {}) do
				apply_patch(upgrade_key, patch_index, patch)
			end
		end
	end
end

return M
