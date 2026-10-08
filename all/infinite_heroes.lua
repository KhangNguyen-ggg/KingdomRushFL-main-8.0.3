-- Persistent unlimited hero loadout for FL 8.0.3. Names survive roster reordering.
local M = {}

function M.enabled(slot)
	return slot and slot.liuhui_hero and slot.liuhui_hero.useinfinitehero == true
end

function M.allowed(store, slot, level_mode)
	if not M.enabled(slot) then return false end
	if (level_mode or store.level_mode) == GAME_MODE_CAMPAIGN and store.campaign_variant and store.campaign_variant ~= CAMPAIGN_VARIANT_REGULAR then return false end
	return true
end

function M.names(slot, roster)
	local valid = {}
	for _, hd in ipairs(roster) do
		if not hd.transplanting and (hd.available_level or 0) <= #(slot.levels or {}) then valid[hd.name] = true end
	end
	local out = {}
	for _, name in ipairs(slot.liuhui_hero and slot.liuhui_hero.infiniteheroes or {}) do
		if valid[name] then out[#out + 1] = name end
	end
	return out
end

function M.active(store)
	return store and store.infinite_hero_names and #store.infinite_hero_names > 0 and not (store.level and (store.level.locked_hero or store.level.manual_hero_insertion))
end

function M.spawn(store, insert_hero)
	if store._infinite_heroes_initialized then return store.main_heroes end
	if not M.active(store) or store._inserting_infinite_heroes then return end
	local slot = require("storage"):load_slot(nil, true)
	local selected, status = store.selected_hero, store.selected_hero_status
	store._inserting_infinite_heroes = true
	local heroes = {}
	local ok, err = pcall(function()
		for _, name in ipairs(store.infinite_hero_names) do
			store.selected_hero = name
			store.selected_hero_status = slot.heroes.status[name] or {xp = 0, skills = {}}
			local hero = insert_hero(store)
			if hero then heroes[#heroes + 1] = hero end
		end
	end)
	store.selected_hero, store.selected_hero_status = selected, status
	store._inserting_infinite_heroes = nil
	if not ok then error(err) end
	store.main_heroes = heroes
	store.main_hero, store.main1_hero = heroes[1], heroes[2]
	store._infinite_heroes_initialized = true
	store._campaign_heroes_initialized = true
	return heroes
end

return M
