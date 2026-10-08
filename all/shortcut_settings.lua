local storage = require("storage")

local M = {}

local RESERVED_KEYS = {
	escape = true,
	f1 = true,
	f2 = true,
	f3 = true,
	f4 = true,
	f5 = true,
	f6 = true,
	f7 = true,
	f8 = true
}

local CONTEXTS = {
	map = {
		{id = "close", label = "关闭/返回", slots = {{key = "escape", fixed = true}}},
		{id = "more_options", label = "配置菜单", slots = {{key = "f1", fixed = true}, {key = "o"}}},
		{id = "heroes", label = "英雄殿堂", slots = {{key = "f2", fixed = true}, {key = "h"}}},
		{id = "towers", label = "防御塔选择", slots = {{key = "f3", fixed = true}, {key = "t"}}},
		{id = "upgrades", label = "科技树", slots = {{key = "f4", fixed = true}, {key = "u"}}},
		{id = "spells", label = "法术选择", slots = {{key = "f5", fixed = true}, {key = "s"}}},
		{id = "difficulty", label = "难度选择", slots = {{key = "f6", fixed = true}, {key = "d"}}},
		{id = "encyclopedia", label = "百科全书", slots = {{key = "f7", fixed = true}, {key = "e"}}},
		{id = "achievements", label = "成就", slots = {{key = "f8", fixed = true}, {key = "a"}}},
		{id = "map_1", label = "切换第1代地图", slots = {{key = "1"}}},
		{id = "map_2", label = "切换第2代地图", slots = {{key = "2"}}},
		{id = "map_3", label = "切换第3代地图", slots = {{key = "3"}}},
		{id = "map_4", label = "切换第4代地图", slots = {{key = "4"}}},
		{id = "map_5", label = "切换第5代地图", slots = {{key = "5"}}},
		{id = "toggle_ui", label = "隐藏/显示地图UI", slots = {{key = "tab"}}}
	},
	game = {
		{id = "pause", label = "暂停/返回", slots = {{key = "escape", fixed = true}}},
		{id = "pow_1", label = "1号法术", slots = {{key = "1"}}},
		{id = "pow_2", label = "2号法术", slots = {{key = "2"}}},
		{id = "pow_3", label = "3号法术", slots = {{key = "3"}}},
		{id = "pow_a", label = "A号英雄大招", slots = {{key = "a"}}},
		{id = "pow_s", label = "S号英雄大招", slots = {{key = "s"}}},
		{id = "hero_1", label = "选择第1名英雄", slots = {{key = "4"}}},
		{id = "hero_2", label = "选择第2名英雄", slots = {{key = "5"}}},
		{id = "durax_clone", label = "控制杜拉斯水晶人", slots = {{key = "6"}}},
		{id = "hero_3", label = "选择第3名英雄", slots = {{key = "7"}}},
		{id = "hero_4", label = "选择第4名英雄", slots = {{key = "8"}}},
		{id = "hero_5", label = "选择第5名英雄", slots = {{key = "9"}}},
		{id = "hero_cycle", label = "循环选择英雄", slots = {{key = "space"}}},
		{id = "wave", label = "提前下一波", slots = {{key = "w"}, {key = "return"}}},
		{id = "speed_slow", label = "减速（按住）", slots = {{key = "q"}}},
		{id = "speed_3x", label = "3倍加速（按住）", slots = {{key = "e"}}},
		{id = "speed_12x", label = "12倍加速（按住）", slots = {{key = "r"}}},
		{id = "build_menu", label = "一键造塔菜单", slots = {{key = "z"}}},
		{id = "build_mode", label = "一键造塔模式", slots = {{key = "c"}}}
	}
}

local LEGACY_SETTINGS = {
	pow_1 = "key_pow_1",
	pow_2 = "key_pow_2",
	pow_3 = "key_pow_3",
	hero_1 = "key_hero_1",
	hero_2 = "key_hero_2",
	durax_clone = "key_hero_3",
	wave = "key_wave"
}

local DISPLAY_NAMES = {
	escape = "Esc",
	space = "Space",
	["return"] = "Enter",
	tab = "Tab",
	backspace = "Backspace",
	delete = "Delete",
	insert = "Insert",
	home = "Home",
	["end"] = "End",
	pageup = "PageUp",
	pagedown = "PageDown",
	up = "Up",
	down = "Down",
	left = "Left",
	right = "Right",
	lshift = "LShift",
	rshift = "RShift",
	lctrl = "LCtrl",
	rctrl = "RCtrl",
	lalt = "LAlt",
	ralt = "RAlt"
}

local function normalize_key(key)
	if type(key) ~= "string" then
		return nil
	end

	key = string.lower(key)

	if key == "" or key == "unknown" then
		return nil
	end

	return key
end

local function definition_for(context, action_id)
	for _, definition in ipairs(CONTEXTS[context] or {}) do
		if definition.id == action_id then
			return definition
		end
	end
end

local function sanitized_context(context, source, settings)
	local result = {}
	local used = {}

	source = type(source) == "table" and source or nil
	settings = type(settings) == "table" and settings or {}

	for _, definition in ipairs(CONTEXTS[context] or {}) do
		result[definition.id] = {}

		for slot_index, slot in ipairs(definition.slots) do
			local key = slot.key

			if not slot.fixed then
				local saved = source and source[definition.id]
				local old_game_bindings = context == "game" and source and type(source.durax_clone) ~= "table"

				if old_game_bindings and definition.id == "durax_clone" then
					saved = source.hero_3
				elseif old_game_bindings and definition.id == "hero_3" then
					saved = nil
				end

				saved = type(saved) == "table" and saved or nil
				local candidate = normalize_key(saved and saved[slot_index])

				if not candidate and context == "game" and definition.id == "hero_cycle" and source then
					local old_hero_binding = type(source.hero_1) == "table" and source.hero_1 or nil

					candidate = normalize_key(old_hero_binding and old_hero_binding[2])
				end

				if not candidate and context == "game" and slot_index == 1 and LEGACY_SETTINGS[definition.id] then
					candidate = normalize_key(settings[LEGACY_SETTINGS[definition.id]])
				end

				if candidate and not RESERVED_KEYS[candidate] and not used[candidate] then
					key = candidate
				end

				if used[key] and context == "game" and (definition.id == "hero_3" or definition.id == "hero_4" or definition.id == "hero_5") then
					for _, alternative in ipairs({"kp7", "kp8", "kp9", "kp0", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6"}) do
						if not used[alternative] then
							key = alternative
							break
						end
					end
				end
			end

			result[definition.id][slot_index] = key
			used[key] = true
		end
	end

	return result
end

function M.is_pc()
	return KR_PLATFORM ~= "android" and KR_TARGET ~= "phone" and KR_TARGET ~= "tablet"
end

function M.get_definitions(context)
	return CONTEXTS[context] or {}
end

function M.is_reserved(key)
	return RESERVED_KEYS[normalize_key(key)] == true
end

function M.display_key(key)
	key = normalize_key(key) or "?"

	if DISPLAY_NAMES[key] then
		return DISPLAY_NAMES[key]
	elseif key:match("^f%d+$") then
		return string.upper(key)
	elseif key:match("^kp%d$") then
		return "Num" .. key:sub(3)
	elseif #key == 1 then
		return string.upper(key)
	end

	return key
end

function M.load_context(context)
	local settings = storage:load_settings() or {}
	local is_pc = M.is_pc()
	local source = is_pc and type(settings.pc_shortcuts) == "table" and settings.pc_shortcuts[context]

	return sanitized_context(context, source, is_pc and settings or {})
end

function M.save_context(context, bindings)
	local settings = storage:load_settings() or {}
	local sanitized = sanitized_context(context, bindings, settings)

	if type(settings.pc_shortcuts) ~= "table" then
		settings.pc_shortcuts = {}
	end

	settings.pc_shortcuts[context] = sanitized
	storage:save_settings(settings, true)

	return sanitized
end

function M.reset_context(context)
	local settings = storage:load_settings() or {}

	if type(settings.pc_shortcuts) == "table" then
		settings.pc_shortcuts[context] = nil
	end

	if context == "game" then
		for _, setting_name in pairs(LEGACY_SETTINGS) do
			settings[setting_name] = nil
		end
	end

	storage:save_settings(settings, true)

	return sanitized_context(context, nil, settings)
end

function M.set_binding(bindings, context, action_id, slot_index, key)
	local definition = definition_for(context, action_id)
	local slot = definition and definition.slots[slot_index]

	key = normalize_key(key)

	if not definition or not slot or slot.fixed or not key then
		return false, "invalid"
	elseif RESERVED_KEYS[key] then
		return false, "reserved"
	end

	for other_action, keys in pairs(bindings or {}) do
		for other_slot, assigned_key in ipairs(keys) do
			if assigned_key == key and (other_action ~= action_id or other_slot ~= slot_index) then
				local other_definition = definition_for(context, other_action)

				return false, "conflict", other_definition and other_definition.label or other_action
			end
		end
	end

	bindings[action_id][slot_index] = key

	return true, key
end

function M.matches(bindings, action_id, key)
	key = normalize_key(key)

	for _, assigned_key in ipairs(bindings and bindings[action_id] or {}) do
		if assigned_key == key then
			return true
		end
	end

	return false
end

function M.key(bindings, action_id, slot_index, fallback)
	return bindings and bindings[action_id] and bindings[action_id][slot_index or 1] or fallback
end

return M
