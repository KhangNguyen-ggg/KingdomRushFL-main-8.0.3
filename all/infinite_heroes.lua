-- Persistent unlimited hero loadout for FL 8.0.3. Names survive roster reordering.
local M = {}
local allied_blackburn = require("allied_blackburn")
M.bosses = require("allied_bosses")
M.get_boss = M.bosses.get
M.boss_name = allied_blackburn.name
M.boss_portrait = "cheat_item_spell_summon_blackburn"
M.boss_texture = allied_blackburn.texture

function M.settings(slot)
	slot.liuhui_hero = slot.liuhui_hero or {}
	local settings = slot.liuhui_hero
	if type(settings.infinite_teams) ~= "table" or #settings.infinite_teams == 0 then
		settings.infinite_teams = {{name = "Đội 1", heroes = settings.infiniteheroes or {}}}
	end
	local index = math.floor(tonumber(settings.infinite_team_index) or 1)
	index = math.max(1, math.min(index, #settings.infinite_teams))
	settings.infinite_team_index = index
	local team = settings.infinite_teams[index]
	if type(team) ~= "table" then
		team = {}
		settings.infinite_teams[index] = team
	end
	if type(team.name) ~= "string" then team.name = "Đội " .. index end
	if type(team.heroes) ~= "table" then team.heroes = {} end
	settings.infiniteheroes = team.heroes
	return settings
end

function M.select_team(slot, index)
	local settings = M.settings(slot)
	settings.infinite_team_index = (index - 1) % #settings.infinite_teams + 1
	return M.settings(slot)
end

function M.new_team(slot, copy_current)
	local settings = M.settings(slot)
	local heroes = {}
	if copy_current then
		for n, name in ipairs(settings.infiniteheroes) do heroes[n] = name end
	end
	local index = #settings.infinite_teams + 1
	local number = index
	for _, team in ipairs(settings.infinite_teams) do
		local existing = tonumber(tostring(team.name):match("^Đội (%d+)$")) or 0
		number = math.max(number, existing + 1)
	end
	settings.infinite_teams[index] = {name = "Đội " .. number, heroes = heroes}
	settings.infinite_team_index = index
	return M.settings(slot)
end

function M.delete_team(slot)
	local settings = M.settings(slot)
	if #settings.infinite_teams <= 1 then return false end
	table.remove(settings.infinite_teams, settings.infinite_team_index)
	settings.infinite_team_index = math.min(settings.infinite_team_index, #settings.infinite_teams)
	M.settings(slot)
	return true
end

function M.enabled(slot)
	return slot and slot.liuhui_hero and slot.liuhui_hero.useinfinitehero == true
end

function M.allowed(store, slot, level_mode)
	if not M.enabled(slot) then return false end
	if (level_mode or store.level_mode) == GAME_MODE_CAMPAIGN and store.campaign_variant and store.campaign_variant ~= CAMPAIGN_VARIANT_REGULAR then return false end
	return true
end

function M.names(slot, roster)
	local settings = slot.liuhui_hero or {}
	local valid = {}
	for _, boss in ipairs(M.bosses.list) do valid[boss.name] = true end
	for _, hd in ipairs(roster) do
		if not hd.transplanting and (hd.available_level or 0) <= #(slot.levels or {}) then valid[hd.name] = true end
	end
	local out = {}
	for _, name in ipairs(settings.infiniteheroes or {}) do
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
	if not slot or not slot.heroes or not slot.heroes.status then error("Cannot read hero save; refusing to spawn the team") end
	local selected, status = store.selected_hero, store.selected_hero_status
	store._inserting_infinite_heroes = true
	local heroes = {}
	local ok, err = pcall(function()
		for _, name in ipairs(store.infinite_hero_names) do
			if M.get_boss(name) then M.bosses.register(name) end
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

