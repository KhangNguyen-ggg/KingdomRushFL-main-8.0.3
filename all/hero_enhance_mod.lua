-- chunkname: @./all/hero_enhance_mod.lua

local log = require("klua.log"):new("hero_enhance_mod")
local E = require("entity_db")
local GS = require("game_settings")
local GU5 = require("gui_utils_5")
local S = require("sound_db")
local U = require("utils")
local hook_utils = require("hook_utils")
local i18n = require("i18n")
local storage = require("storage")
local sys = require("systems")

local HOOK = hook_utils.HOOK

local hero_enhance_mod = {
	installed = false,
	game_hooked = false,
	game_gui_hooked = false,
	hero_room_hooked = false,
	original_utils = nil,
	original_script_utils = nil
}

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function CJK(default, zh, ja, kr)
	return i18n:cjk(default, zh, ja, kr)
end

local function current_slot()
	if storage.slot then
		return storage.slot
	end

	if storage.active_slot_idx then
		return storage:load_slot(nil, true)
	end

	return nil
end

function hero_enhance_mod:is_enabled()
	local slot = current_slot()
	local liuhui = slot and slot.liuhui

	return liuhui and liuhui.hero_enhance == true
end

function hero_enhance_mod:capture_runtime_originals()
	if not self.original_utils then
		local utils = require("utils")

		self.original_utils = {
			find_nearest_enemy = utils.find_nearest_enemy,
			find_foremost_enemy = utils.find_foremost_enemy
		}
	end

	if not self.original_script_utils then
		local script_utils = require("script_utils")

		self.original_script_utils = {
			soldier_pick_ranged_target_and_attack = script_utils.soldier_pick_ranged_target_and_attack,
			y_soldier_ranged_attacks = script_utils.y_soldier_ranged_attacks
		}
	end
end

function hero_enhance_mod:restore_runtime_originals()
	if self.original_utils and package.loaded["utils"] then
		local utils = require("utils")

		utils.find_nearest_enemy = self.original_utils.find_nearest_enemy
		utils.find_foremost_enemy = self.original_utils.find_foremost_enemy
	end

	if self.original_script_utils and package.loaded["script_utils"] then
		local script_utils = require("script_utils")

		script_utils.soldier_pick_ranged_target_and_attack = self.original_script_utils.soldier_pick_ranged_target_and_attack
		script_utils.y_soldier_ranged_attacks = self.original_script_utils.y_soldier_ranged_attacks
	end
end

local function clear_hero_script_packages()
	local packages = {
		"game_scripts",
		"game_scripts-1",
		"game_scripts-1-rebbborn",
		"game_scripts-2",
		"game_scripts-4",
		"game_scripts-5",
		"scripts",
		"scripts_4",
		"scripts_5",
		"script_utils",
		"script_utils_5",
		"utils_5",
		"utils_UH",
		"scripts_UH",
		"template_UH"
	}

	for _, name in ipairs(packages) do
		package.loaded[name] = nil
	end
end

function hero_enhance_mod:apply_strings(enabled)
	local ok, strings_UH = pcall(require, "strings_UH")

	if not ok then
		log.error("could not load strings_UH: %s", tostring(strings_UH))

		return false
	end

	if strings_UH.apply then
		strings_UH:apply(enabled)
	elseif enabled and strings_UH.init then
		strings_UH:init()
	end

	return true
end

function hero_enhance_mod:set_enabled(enabled)
	self:apply_strings(enabled)

	if enabled then
		self:capture_runtime_originals()
	else
		self:restore_runtime_originals()
		self:restore_animations()
	end
end

function hero_enhance_mod:load_UH()
	require("game_scripts")
	require("game_scripts-1")
	pcall(require, "game_scripts-1-rebbborn")
	require("game_scripts-2")
	require("game_scripts-4")
	require("game_scripts-5")

	local scripts_UH = require("scripts_UH")
	local template_UH = require("template_UH")

	self:capture_runtime_originals()
	scripts_UH:init()
	scripts_UH:utils()
	scripts_UH:script_utils()
	scripts_UH:scripts()
	self:apply_strings(true)

	for i = 1, 5 do
		scripts_UH["enhance" .. i](scripts_UH)
		template_UH["enhance" .. i](template_UH)
	end
end

function hero_enhance_mod:apply_animations()
	local A_UH = require("animations_UH")

	for i = 1, 5 do
		A_UH["a" .. i]()
	end
end

function hero_enhance_mod:restore_animations()
	local ok, mod_utils = pcall(require, "mod_utils")

	if ok and mod_utils.restore_a_db_reset then
		mod_utils.restore_a_db_reset()
	end
end

function hero_enhance_mod:init(game, game_gui)
	if not self.installed then
		HOOK(E, "load", function(load, entity_db)
			local enabled = hero_enhance_mod:is_enabled()

			if not enabled then
				hero_enhance_mod:restore_runtime_originals()
			end

			clear_hero_script_packages()
			load(entity_db)

			if enabled then
				hero_enhance_mod:load_UH()
			else
				hero_enhance_mod:restore_runtime_originals()
				hero_enhance_mod:apply_strings(false)
			end
		end)

		HOOK(sys.level, "init", function(init, level_sys, store)
			init(level_sys, store)

			if hero_enhance_mod:is_enabled() then
				hero_enhance_mod:apply_animations()
			else
				hero_enhance_mod:restore_animations()
			end
		end)

		self.installed = true
	end

	if game and not self.game_hooked then
		HOOK(game, "mousepressed", function(mousepressed, game_self, x, y, button, istouch)
			if not hero_enhance_mod:is_enabled() then
				return mousepressed(game_self, x, y, button, istouch)
			end

			if not game_self.mp then
				game_self.mp = {
					pos = {},
					button = {},
					istouch = nil
				}
			end

			for i in pairs(game_self.mp.button) do
				game_self.mp.button[i] = nil
			end

			game_self.mp.pos = {}
			game_self.mp.istouch = nil

			mousepressed(game_self, x, y, button, istouch)

			if button == 2 then
				game_self.mp.button[2] = true
				game_self.mp.pos = v(x, y)
				game_self.mp.istouch = istouch
			end
		end)

		self.game_hooked = true
	end

	if game_gui and not self.game_gui_hooked then
		HOOK(game_gui, "init", function(init, gui_self, w, h, game_instance)
			init(gui_self, w, h, game_instance)

			if hero_enhance_mod:is_enabled() and gui_self.mouse_pointer and gui_self.mouse_pointer.get_window then
				gui_self.mouse_pointer.window = gui_self.mouse_pointer:get_window()
			end
		end)

		self.game_gui_hooked = true
	end
end

function hero_enhance_mod:hook_hero_room(HeroRoomView)
	self:init()

	if self.hero_room_hooked or not HeroRoomView then
		return
	end

	HOOK(HeroRoomView, "initialize", function(init, view_self, sw, sh)
		init(view_self, sw, sh)

		if not hero_enhance_mod:is_enabled() then
			return
		end

		local kr3_y_offset = KR_GAME == "kr3" and 4 or 0
		local cheat_up = KImageView:new("heroroom_012")

		cheat_up.pos = v(75, 36 + kr3_y_offset + 50)
		cheat_up.anchor = v(cheat_up.size.x / 2, cheat_up.size.y / 2)

		local function hero_index_by_name(hero_name)
			for i, h in ipairs(screen_map.hero_data) do
				if h.name == hero_name then
					return i
				end
			end

			return nil
		end

		local function get_hero_stats(p)
			local out = {}
			local index

			if type(p) == "number" then
				index = p
			else
				index = hero_index_by_name(p)
			end

			local data = screen_map.hero_data[index]
			local hero_name = data.name
			local user_data = storage:load_slot()
			local status = user_data.heroes.status[hero_name]

			if not status then
				log.debug("hero status for %s not found in slot. overwritting from template", hero_name)

				local template = require("data.slot_template")

				user_data.heroes.status[hero_name] = template.heroes.status[hero_name]
				status = template.heroes.status[hero_name]
			end

			local h = E:create_entity(hero_name)

			h.hero.xp = status.xp

			local level, level_progress = U.get_hero_level(h.hero.xp, GS.hero_xp_thresholds)

			h.hero.level = level

			if h.hero.level < data.starting_level then
				h.hero.level = data.starting_level
				h.hero.xp = GS.hero_xp_thresholds[h.hero.level]
			end

			out.skill_names = {}
			out.skill_names_i18n = {}

			local used_points = 0

			for k, skill in pairs(status.skills) do
				h.hero.skills[k].level = skill

				local i = h.hero.skills[k].hr_order

				out.skill_names[i] = k
				out.skill_names_i18n[i] = h.hero.skills[k].key

				for j = 1, skill do
					used_points = used_points + h.hero.skills[k].hr_cost[j]
				end
			end

			h.hero.fn_level_up(h, {}, true)

			local info = h.info.fn(h)

			out.index = index
			out.name = hero_name
			out.name_i18n = h.info.i18n_key or hero_name
			out.icon = data.icon
			out.thumb = data.thumb
			out.portrait = data.portrait
			out.level = h.hero.level
			out.xp = h.hero.xp
			out.level_progress = level_progress
			out.taunt = h.sound_events.change_rally_point .. "Select"
			out.hero_class = _(string.upper(out.name_i18n) .. "_CLASS")
			out.health = info.hp_max

			if info.no_ranged then
				out.damage = info.damage_min .. " - " .. info.damage_max
			elseif info.ranged_damage_min and info.map_melee then
				out.damage = info.damage_min .. " - " .. info.damage_max
			elseif info.ranged_damage_min then
				out.damage = info.ranged_damage_min .. " - " .. info.ranged_damage_max
			else
				out.damage = info.damage_min .. " - " .. info.damage_max
			end

			out.armor = GU5.armor_value_desc(info.armor)
			out.attack_rate = _(string.upper(out.name_i18n) .. "_ATTACKRATE")
			out.damage_icon = h.info.damage_icon or 1
			out.skills = h.hero.skills
			out.remaining_points = GS.skill_points_for_hero_level[h.hero.level] - used_points

			return out, h
		end

		function cheat_up.on_click()
			local user_data = storage:load_slot()
			local hero = get_hero_stats(view_self.selected_index)
			local status = user_data.heroes.status[hero.name]

			if hero.level < 10 then
				status.xp = GS.hero_xp_thresholds[hero.level]
			end

			storage:save_slot(user_data)
			view_self:construct_hero(view_self.selected_index)
		end

		view_self.back:add_child(cheat_up)
		view_self.cheat_up = cheat_up
	end)

	self.hero_room_hooked = true
end

return hero_enhance_mod
