local M = {}

M.GENERATION_COUNT = 5

function M.normalize(user_data)
	user_data.liuhui = user_data.liuhui or {}

	local generations = user_data.liuhui.tower_generations
	local changed = false

	if type(generations) ~= "table" then
		-- The old three-state switch remains the master selector for legacy,
		-- high-generation, or combined decks. The detailed generation choices
		-- therefore start enabled independently of that switch.
		generations = {true, true, true, false, false}
		user_data.liuhui.tower_generations = generations
		changed = true
	end

	for i = 1, M.GENERATION_COUNT do
		if type(generations[i]) ~= "boolean" then
			generations[i] = i <= 3
			changed = true
		end
	end

	local any_enabled = false

	for i = 1, M.GENERATION_COUNT do
		any_enabled = any_enabled or generations[i]
	end

	if not any_enabled then
		generations[1] = true
		changed = true
	end

	return generations, changed
end

return M
