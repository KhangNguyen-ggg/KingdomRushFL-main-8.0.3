local M = {}

M.order = {
	"reinforcements",
	"rain_of_fire",
	"royal_edict",
	"soaring_shop",
	"aspect_of_sol",
	"teleportation_sigil",
	"thunder_zapper",
	"wintersongs_wrath",
	"musketeers"
}

M.powers = {
	reinforcements = {
		spec_prefix = "power_reinforcements",
		icon_prefix = "power_upgrade_icons_reinforcements"
	},
	rain_of_fire = {
		spec_prefix = "power_rain_of_fire",
		icon_prefix = "power_upgrade_icons_rain_of_fire"
	},
	royal_edict = {
		spec_prefix = "power_royal_edict",
		icon_prefix = "power_upgrade_icons_royal_edict"
	},
	soaring_shop = {
		spec_prefix = "power_soaring_shop",
		icon_prefix = "power_upgrade_icons_soaring_shop"
	},
	aspect_of_sol = {
		spec_prefix = "power_aspect_of_sol",
		icon_prefix = "power_upgrade_icons_aspectofsol"
	},
	teleportation_sigil = {
		spec_prefix = "power_teleportation_sigil",
		icon_prefix = "power_upgrade_icons_sigil_teleporter"
	},
	thunder_zapper = {
		spec_prefix = "power_thunder_zapper",
		icon_prefix = "power_upgrade_icons_thunder_zapper"
	},
	wintersongs_wrath = {
		spec_prefix = "power_wintersongs_wrath",
		icon_prefix = "power_upgrade_icons_wintersong"
	},
	musketeers = {
		spec_prefix = "musketeers",
		icon_prefix = "power_upgrade_icons_musketeers"
	}
}

local tier_nodes = {
	{tier = 1, level = 2, branch = "a", icon = 1},
	{tier = 1, level = 2, branch = "b", icon = 2},
	{tier = 2, level = 3, icon = 3},
	{tier = 3, level = 4, branch = "a", icon = 4},
	{tier = 3, level = 4, branch = "b", icon = 5},
	{tier = 4, level = 5, branch = "a", icon = 6},
	{tier = 4, level = 5, branch = "b", icon = 7},
	{tier = 5, level = 6, icon = 8}
}

local branch_tiers = {
	[1] = true,
	[3] = true,
	[4] = true
}

for power_name, power in pairs(M.powers) do
	power.name_key_prefix = "POWER_" .. string.upper(power_name)
	power.nodes = {}

	for _, source in ipairs(tier_nodes) do
		local suffix = "l" .. source.level .. (source.branch or "")
		local node = {
			power_name = power_name,
			tier = source.tier,
			branch = source.branch,
			icon = power.icon_prefix .. "_" .. source.icon,
			upgrade_key = power.spec_prefix .. "_" .. suffix,
			name_key = power.name_key_prefix .. "_" .. string.upper(suffix) .. "_NAME",
			description_key = power.name_key_prefix .. "_" .. string.upper(suffix) .. "_DESC"
		}

		table.insert(power.nodes, node)
	end
end

function M.normalize(user_data)
	if type(user_data) ~= "table" then
		return {}, false
	end

	local changed = false

	if type(user_data.liuhui) ~= "table" then
		user_data.liuhui = {}
		changed = true
	end

	local state = user_data.liuhui.kr6_power_upgrades

	if type(state) ~= "table" then
		state = {}
		user_data.liuhui.kr6_power_upgrades = state
		changed = true
	end

	for _, power_name in ipairs(M.order) do
		local choices = state[power_name]

		if type(choices) ~= "table" then
			choices = {}
			state[power_name] = choices
			changed = true
		end

		for tier in pairs(branch_tiers) do
			local branch = choices[tier] or choices[tostring(tier)]

			if branch ~= "a" and branch ~= "b" then
				branch = "a"
				changed = true
			end

			if choices[tier] ~= branch then
				choices[tier] = branch
				changed = true
			end

			if choices[tostring(tier)] ~= nil then
				choices[tostring(tier)] = nil
				changed = true
			end
		end

		if choices[4] ~= choices[3] then
			choices[4] = choices[3]
			changed = true
		end
	end

	return state, changed
end

function M.get_nodes(power_name)
	local power = M.powers[power_name]

	return power and power.nodes or {}
end

function M.get_branch(user_data, power_name, tier)
	local state = M.normalize(user_data)
	local choices = state[power_name]

	return choices and choices[tier] or "a"
end

function M.set_branch(user_data, power_name, tier, branch)
	if not M.powers[power_name] or not branch_tiers[tier] or (branch ~= "a" and branch ~= "b") then
		return false
	end

	local state = M.normalize(user_data)

	if tier == 3 or tier == 4 then
		state[power_name][3] = branch
		state[power_name][4] = branch
	else
		state[power_name][tier] = branch
	end

	return true
end

function M.is_node_active(user_data, node)
	return not node.branch or M.get_branch(user_data, node.power_name, node.tier) == node.branch
end

function M.active_keys(user_data)
	local result = {}

	M.normalize(user_data)

	for _, power_name in ipairs(M.order) do
		for _, node in ipairs(M.powers[power_name].nodes) do
			if M.is_node_active(user_data, node) then
				table.insert(result, node.upgrade_key)
			end
		end
	end

	return result
end

return M
