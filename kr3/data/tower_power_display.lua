local kr6_tower_integration = require("data.kr6_tower_integration")

local M = {}
local balance_6
local kr6_tower_names = {}

for _, tower_name in ipairs(kr6_tower_integration.detail_templates or {}) do
	kr6_tower_names[tower_name] = true
end

local function level_value(value, level)
	if type(value) == "table" then
		return value[level or 1] or value[#value]
	end

	return value
end

function M.price(power, level)
	if type(power) ~= "table" or power.price_base == nil then
		return nil
	end

	if (level or 1) <= 1 then
		return power.price_base
	end

	return power.price_inc or power.price_base
end

function M.cooldown(tower_name, power_name, power, level)
	if not kr6_tower_names[tower_name] then
		return nil
	end

	local cooldown = level_value(power and power.cooldown, level)

	if cooldown == nil then
		balance_6 = balance_6 or require("data.balance.balance_6")

		local balance_name = string.match(tower_name, "^tower_(.+)_lvl4$")
		local tower_balance = balance_name and balance_6.towers and balance_6.towers[balance_name]
		local power_balance = tower_balance and tower_balance[power_name]

		cooldown = level_value(power_balance and power_balance.cooldown, level)
	end

	return type(cooldown) == "number" and cooldown > 0 and cooldown or nil
end

function M.desc_has_cooldown(desc)
	if type(desc) ~= "string" or desc == "" then
		return false
	end

	local lower_desc = string.lower(desc)

	return string.find(desc, "冷却", 1, true) ~= nil
		or string.find(lower_desc, "cooldown", 1, true) ~= nil
		or string.find(string.upper(desc), "CD", 1, true) ~= nil
end

function M.append_cooldown(desc, tower_name, power_name, power, level, already_described)
	if type(desc) ~= "string" or desc == "" then
		return desc
	end

	local cooldown = M.cooldown(tower_name, power_name, power, level)

	if not cooldown or already_described or M.desc_has_cooldown(desc) then
		return desc
	end

	local cooldown_text

	if math.abs(cooldown - math.floor(cooldown)) < 0.0001 then
		cooldown_text = tostring(math.floor(cooldown))
	else
		cooldown_text = string.format("%.3f", cooldown)
		cooldown_text = string.gsub(cooldown_text, "0+$", "")
		cooldown_text = string.gsub(cooldown_text, "%.$", "")
	end

	return string.format("%s CD%s秒。", desc, cooldown_text)
end

return M
