local enemy_enhance = {}

local growth_rates = {
	[1] = 0.028,
	[2] = 0.06,
	[3] = 0.10
}

function enemy_enhance.level(value)
	if value == true then
		return 1
	end

	if type(value) ~= "number" then
		return 0
	end

	return math.max(0, math.min(3, math.floor(value)))
end

function enemy_enhance.enabled(value)
	return enemy_enhance.level(value) > 0
end

function enemy_enhance.growth_rate(value)
	return growth_rates[enemy_enhance.level(value)] or 0
end

function enemy_enhance.wave_health_factor(value, wave_number)
	local steps = math.max(0, math.min(10, math.floor(wave_number or 0) - 5))

	return 1 + steps * enemy_enhance.growth_rate(value)
end

return enemy_enhance
