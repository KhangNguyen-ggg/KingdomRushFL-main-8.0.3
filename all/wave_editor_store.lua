-- Wave editor persistence and runtime selection.
-- Official files under kr3/data/waves are always treated as read-only.

local log = require("klua.log"):new("wave_editor_store")
local FS = love.filesystem
local storage = require("storage")
local tsv = require("klua.tsv")

require("klua.table")
require("constants")

local M = {}

M.ROOT = "wave_editor"
M.LISTS_DIR = M.ROOT .. "/lists"
M.REGISTRY_FILE = M.ROOT .. "/registry.lua"

local mode_suffixes = {
	[GAME_MODE_CAMPAIGN] = "campaign",
	[GAME_MODE_HEROIC] = "heroic",
	[GAME_MODE_IRON] = "iron"
}

local function trim(value)
	return tostring(value or ""):match("^%s*(.-)%s*$")
end

local function clone_row(row)
	local out = {}

	for i = 1, #row do
		out[i] = row[i]
	end

	return out
end

local function row_is_comment(row)
	for _, value in ipairs(row or {}) do
		value = trim(value)
		if value ~= "" then
			return string.sub(value, 1, 1) == "#"
		end
	end

	return false
end

local function parse_spawn_cell(value, prefix)
	value = trim(value)
	local name, count, interval, interval_next = value:match("^(.-)|(%d+)|([%d%.]+)|([%d%.]+)$")

	name = name or value
	if string.sub(name, 1, 1) == "=" then
		name = string.sub(name, 2)
	else
		name = (prefix or "") .. name
	end

	return name, tonumber(count) or 1, tonumber(interval) or 0, tonumber(interval_next) or 0
end

local function compact_number(value)
	value = tonumber(value) or 0

	if value == math.floor(value) then
		return tostring(math.floor(value))
	end

	return tostring(value)
end

local function format_spawn_cell(spawn, prefix)
	local creep = tostring(spawn.creep or "")
	local name

	if prefix ~= "" and string.sub(creep, 1, #prefix) == prefix then
		name = string.sub(creep, #prefix + 1)
	elseif prefix == "" then
		name = creep
	else
		name = "=" .. creep
	end

	local count = math.max(0, math.min(99999, math.floor(tonumber(spawn.max) or 0)))
	local interval = math.max(0, math.min(999, tonumber(spawn.interval) or 0))
	local interval_next = math.max(0, math.min(9999, tonumber(spawn.interval_next) or 0))

	if count == 1 and interval == 0 and interval_next == 0 then
		return name
	end

	return table.concat({name, count, compact_number(interval), compact_number(interval_next)}, "|")
end

local function parse_column_layout(row)
	local layout = {
		inc_col = nil,
		path_columns = {},
		path_by_col = {},
		max_columns = #row
	}

	for col_idx, value in ipairs(row or {}) do
		value = trim(value)
		if value == "inc" then
			layout.inc_col = col_idx
		else
			local pi, spi = value:match("^(%d+):([^:]+)$")
			if pi then
				pi = tonumber(pi)
				spi = spi == "*" and "*" or tonumber(spi)
				layout.path_columns[pi] = layout.path_columns[pi] or {}
				layout.path_columns[pi][spi] = col_idx
				layout.path_by_col[col_idx] = {
					pi = pi,
					spi = spi
				}
			end
		end
	end

	return layout
end

local function copy_layout(layout)
	local out = {
		inc_col = layout and layout.inc_col,
		path_columns = {},
		path_by_col = {},
		max_columns = layout and layout.max_columns or 0
	}

	for pi, columns in pairs(layout and layout.path_columns or {}) do
		out.path_columns[pi] = {}
		for spi, col_idx in pairs(columns) do
			out.path_columns[pi][spi] = col_idx
			out.path_by_col[col_idx] = {
				pi = pi,
				spi = spi
			}
		end
	end

	return out
end

local function ensure_path_wave(group, path_index)
	group._paths = group._paths or {}
	local path_wave = group._paths[path_index]

	if not path_wave then
		path_wave = {
			delay = 0,
			path_index = path_index,
			spawns = {}
		}
		group._paths[path_index] = path_wave
		group.waves[#group.waves + 1] = path_wave
	end

	return path_wave
end

local function project_tsv_rows(rows)
	local wave = {
		groups = {},
		_source_format = "tsv"
	}
	local context = {
		groups = {},
		spawn_rows = {},
		max_columns = 0
	}
	local layout = {
		path_columns = {},
		path_by_col = {},
		max_columns = 0
	}
	local prefix = ""
	local default_increment = 1
	local current_group

	for row_idx, row in ipairs(rows or {}) do
		context.max_columns = math.max(context.max_columns, #row)
		if not row_is_comment(row) then
			local command = trim(row[2])

			if command == "column_names" then
				layout = parse_column_layout(row)
			elseif command == "enemy_prefix" then
				prefix = trim(row[3])
			elseif command == "default_increment" then
				default_increment = tonumber(row[3]) or default_increment
			elseif command == "wave" then
				if current_group then
					context.groups[current_group._tsv_group_idx].insert_before = row_idx
				end

				current_group = {
					interval = (tonumber(layout.inc_col and row[layout.inc_col]) or -1) * FPS,
					waves = {},
					_tsv_group_idx = #wave.groups + 1
				}
				wave.groups[#wave.groups + 1] = current_group
				context.groups[current_group._tsv_group_idx] = {
					insert_before = #rows + 1,
					layout = copy_layout(layout),
					prefix = prefix
				}
			elseif command == "manual_wave" then
				if current_group then
					context.groups[current_group._tsv_group_idx].insert_before = row_idx
				end
				current_group = nil
			elseif current_group and (command == "" or command == "spawn") then
				local cells = {}

				for col_idx, path in pairs(layout.path_by_col or {}) do
					if trim(row[col_idx]) ~= "" then
						cells[#cells + 1] = {
							col_idx = col_idx,
							path = path
						}
					end
				end

				if #cells > 0 then
					table.sort(cells, function(a, b)
						return a.col_idx < b.col_idx
					end)
					local row_info = {
						group_idx = current_group._tsv_group_idx,
						layout = copy_layout(layout),
						prefix = prefix
					}
					context.spawn_rows[row_idx] = row_info

					for _, cell in ipairs(cells) do
						local creep, count, interval, interval_next = parse_spawn_cell(row[cell.col_idx], prefix)
						local path_wave = ensure_path_wave(current_group, cell.path.pi)

						path_wave.spawns[#path_wave.spawns + 1] = {
							creep = creep,
							fixed_sub_path = cell.path.spi == "*" and 0 or 1,
							interval = interval,
							interval_next = interval_next,
							max = count,
							max_same = 0,
							path = cell.path.spi == "*" and 1 or cell.path.spi,
							_tsv_col_idx = cell.col_idx,
							_tsv_group_idx = current_group._tsv_group_idx,
							_tsv_row_idx = row_idx,
							_tsv_wait_time = tonumber(layout.inc_col and row[layout.inc_col]) or default_increment
						}
					end
				end
			end
		end
	end

	if current_group then
		context.groups[current_group._tsv_group_idx].insert_before = #rows + 1
	end

	for _, group in ipairs(wave.groups) do
		group._paths = nil
		table.sort(group.waves, function(a, b)
			return (a.path_index or 0) < (b.path_index or 0)
		end)
	end

	return wave, context
end

local function blank_tsv_row(size)
	local row = {}

	for i = 1, size do
		row[i] = ""
	end

	return row
end

local function column_for_spawn(group_context, path_index, spawn)
	local columns = group_context and group_context.layout and group_context.layout.path_columns[path_index]

	if not columns then
		return nil
	end

	if tonumber(spawn.fixed_sub_path) == 0 and columns["*"] then
		return columns["*"]
	end

	return columns[tonumber(spawn.path)] or columns["*"] or select(2, next(columns))
end

local function render_tsv_data(source_data, wave)
	local rows = tsv.parse_tsv(source_data or "")
	local _, context = project_tsv_rows(rows)
	local mapped = {}
	local added = {}

	for group_idx, group in ipairs(wave and wave.groups or {}) do
		for _, path_wave in ipairs(group.waves or {}) do
			for _, spawn in ipairs(path_wave.spawns or {}) do
				local row_idx = tonumber(spawn._tsv_row_idx)
				local col_idx = tonumber(spawn._tsv_col_idx)

				if row_idx and col_idx and context.spawn_rows[row_idx] then
					mapped[row_idx] = mapped[row_idx] or {}
					mapped[row_idx][col_idx] = spawn
				else
					added[group_idx] = added[group_idx] or {}
					added[group_idx][#added[group_idx] + 1] = {
						path_index = tonumber(path_wave.path_index) or 1,
						spawn = spawn
					}
				end
			end
		end
	end

	local insertions = {}
	for group_idx, entries in pairs(added) do
		local group_context = context.groups[group_idx]
		if group_context then
			local before = group_context.insert_before or #rows + 1
			insertions[before] = insertions[before] or {}
			for _, entry in ipairs(entries) do
				local col_idx = column_for_spawn(group_context, entry.path_index, entry.spawn)
				if col_idx then
					local row = blank_tsv_row(math.max(context.max_columns, group_context.layout.max_columns))
					if group_context.layout.inc_col then
						row[group_context.layout.inc_col] = "0"
					end
					row[col_idx] = format_spawn_cell(entry.spawn, group_context.prefix)
					insertions[before][#insertions[before] + 1] = row
				else
					log.error("TSV wave editor could not map path %s in group %s", tostring(entry.path_index), tostring(group_idx))
				end
			end
		end
	end

	local out_rows = {}
	for row_idx = 1, #rows + 1 do
		for _, row in ipairs(insertions[row_idx] or {}) do
			out_rows[#out_rows + 1] = row
		end

		local source_row = rows[row_idx]
		if source_row then
			local row = clone_row(source_row)
			local info = context.spawn_rows[row_idx]
			local keep_row = true
			if info then
				for col_idx in pairs(info.layout.path_by_col) do
					row[col_idx] = ""
				end
				for col_idx, spawn in pairs(mapped[row_idx] or {}) do
					row[col_idx] = format_spawn_cell(spawn, info.prefix)
				end

				keep_row = next(mapped[row_idx] or {}) ~= nil
			end
			if keep_row then
				out_rows[#out_rows + 1] = row
			end
		end
	end

	local lines = {}
	for _, row in ipairs(out_rows) do
		lines[#lines + 1] = table.concat(row, "\t")
	end

	local data = table.concat(lines, "\n") .. "\n"
	local projected = project_tsv_rows(out_rows)

	return data, projected
end

local function clone(value, seen)
	if type(value) ~= "table" then
		return value
	end

	seen = seen or {}
	if seen[value] then
		return seen[value]
	end

	local out = {}
	seen[value] = out

	for k, v in pairs(value) do
		out[clone(k, seen)] = clone(v, seen)
	end

	return out
end

local function ensure_dirs()
	FS.createDirectory(M.ROOT)
	FS.createDirectory(M.LISTS_DIR)
end

local function default_registry()
	return {
		schema_version = 1,
		next_id = 1,
		assignments = {},
		lists = {}
	}
end

local function normalize_registry(registry)
	registry = type(registry) == "table" and registry or default_registry()
	registry.schema_version = 1
	registry.next_id = tonumber(registry.next_id) or 1
	registry.assignments = type(registry.assignments) == "table" and registry.assignments or {}
	registry.lists = type(registry.lists) == "table" and registry.lists or {}

	for id in pairs(registry.lists) do
		registry.next_id = math.max(registry.next_id, (tonumber(id) or 0) + 1)
	end

	return registry
end

function M.mode_suffix(mode)
	return mode_suffixes[mode]
end

function M.level_name(level_idx)
	return string.format("level%02d", tonumber(level_idx) or 1)
end

function M.assignment_key(level_name_or_idx, mode)
	local level_name = type(level_name_or_idx) == "number" and M.level_name(level_name_or_idx) or level_name_or_idx
	local suffix = M.mode_suffix(mode)

	return suffix and string.format("%s:%s", level_name, suffix) or nil
end

function M.source_path(level_idx, mode)
	local suffix = M.mode_suffix(mode)

	if not suffix then
		return nil
	end

	local base = string.format("%s/data/waves/%s_waves_%s", KR_PATH_GAME, M.level_name(level_idx), suffix)
	local tsv_path = base .. ".tsv"

	if FS.isFile(tsv_path) then
		return tsv_path, "tsv"
	end

	return base .. ".lua", "lua"
end

function M.source_exists(level_idx, mode)
	local path = M.source_path(level_idx, mode)

	return path and FS.isFile(path) or false
end

function M.source_format(level_idx, mode)
	local path, format = M.source_path(level_idx, mode)

	return path and FS.isFile(path) and format or nil
end

function M.load_registry(force)
	ensure_dirs()

	return normalize_registry(storage:load_lua(M.REGISTRY_FILE, force))
end

function M.save_registry(registry)
	ensure_dirs()

	return storage:write_lua(M.REGISTRY_FILE, normalize_registry(registry), true)
end

function M.list_path(id)
	return string.format("%s/list_%04d.lua", M.LISTS_DIR, tonumber(id) or 0)
end

local function load_table_file(path)
	local ok, chunk = pcall(FS.load, path)

	if not ok or type(chunk) ~= "function" then
		log.error("Could not load wave table %s: %s", tostring(path), tostring(chunk))

		return nil
	end

	local ran, data = pcall(chunk)

	if not ran or type(data) ~= "table" then
		log.error("Could not evaluate wave table %s: %s", tostring(path), tostring(data))

		return nil
	end

	return data
end

function M.load_source_document(level_idx, mode)
	local path, format = M.source_path(level_idx, mode)

	if not path or not FS.isFile(path) then
		return nil, "source_not_found"
	end

	if format == "tsv" then
		local ok, data = pcall(FS.read, path)

		if not ok or type(data) ~= "string" then
			log.error("Could not read TSV wave source %s: %s", tostring(path), tostring(data))

			return nil, "source_load_failed"
		end

		local rows = tsv.parse_tsv(data)
		local wave = project_tsv_rows(rows)

		return {
			format = "tsv",
			tsv_data = data,
			wave = wave
		}
	end

	local data = load_table_file(path)

	if not data then
		return nil, "source_load_failed"
	end

	return {
		format = "lua",
		wave = clone(data)
	}
end

function M.load_source(level_idx, mode)
	local document, err = M.load_source_document(level_idx, mode)

	return document and clone(document.wave) or nil, err, document and document.format or nil
end

function M.load_list(id, force)
	local path = M.list_path(id)

	if force then
		return storage:load_lua(path, true)
	end

	return storage:load_lua(path)
end

function M.save_list(id, document)
	ensure_dirs()

	document = type(document) == "table" and document or {}
	document.schema_version = 1
	document.id = tonumber(id)
	document.format = document.format == "tsv" and "tsv" or "lua"
	document.wave = type(document.wave) == "table" and document.wave or {groups = {}}

	if document.format == "tsv" then
		if type(document.tsv_data) ~= "string" then
			return false, "missing_tsv_data"
		end

		document.tsv_data, document.wave = render_tsv_data(document.tsv_data, document.wave)
	end

	document.updated_at = os.time()

	local ok = storage:write_lua(M.list_path(id), document, true)

	return ok, ok and document or nil
end

function M.get_lists(level_idx, mode)
	local registry = M.load_registry()
	local out = {}
	local source_format = M.source_format(level_idx, mode)

	for id, meta in pairs(registry.lists) do
		id = tonumber(id)
		local list_format = type(meta) == "table" and (meta.format or "lua")
		if id and type(meta) == "table" and meta.level_idx == level_idx and meta.mode == mode and list_format == source_format then
			out[#out + 1] = {
				id = id,
				name = meta.name or string.format("Tùy chỉnh %d", id)
			}
		end
	end

	table.sort(out, function(a, b)
		return a.id < b.id
	end)

	return out
end

function M.create_from_source(level_idx, mode)
	local source, err = M.load_source_document(level_idx, mode)

	if not source then
		return nil, err
	end

	local registry = M.load_registry(true)
	local id = registry.next_id
	registry.next_id = id + 1

	local meta = {
		id = id,
		level_idx = level_idx,
		mode = mode,
		format = source.format,
		name = string.format("Tùy chỉnh %d", id),
		created_at = os.time()
	}
	registry.lists[id] = meta

	local document = clone(source)
	for key, value in pairs(meta) do
		document[key] = value
	end

	local saved, saved_document = M.save_list(id, document)

	if not saved then
		return nil, "save_failed"
	end

	local key = M.assignment_key(level_idx, mode)
	registry.assignments[key] = id

	if not M.save_registry(registry) then
		return nil, "registry_save_failed"
	end

	return id, saved_document
end

function M.update_list(id, wave)
	local document = M.load_list(id, true)

	if type(document) ~= "table" then
		return false, "list_not_found"
	end

	document.wave = clone(wave)

	local ok, saved_document = M.save_list(id, document)

	return ok, ok and saved_document.wave or nil
end

function M.delete_list(id)
	id = tonumber(id)

	if not id then
		return false, "invalid_id"
	end

	local registry = M.load_registry(true)

	if not registry.lists[id] then
		return false, "list_not_found"
	end

	registry.lists[id] = nil
	for key, assigned_id in pairs(registry.assignments) do
		if tonumber(assigned_id) == id then
			registry.assignments[key] = nil
		end
	end

	if not M.save_registry(registry) then
		return false, "registry_save_failed"
	end

	local path = M.list_path(id)

	if FS.isFile(path) and not storage:remove(path, true) then
		log.warning("Could not remove orphaned wave list file %s", path)
	end

	return true
end

function M.get_assignment(level_name_or_idx, mode)
	local key = M.assignment_key(level_name_or_idx, mode)

	if not key then
		return nil
	end

	local registry = M.load_registry()
	local id = tonumber(registry.assignments[key])

	if id and registry.lists[id] then
		local meta = registry.lists[id]
		local level_idx = type(level_name_or_idx) == "number" and level_name_or_idx or tonumber(tostring(level_name_or_idx):match("%d+"))
		local source_format = level_idx and M.source_format(level_idx, mode)
		local list_format = type(meta) == "table" and (meta.format or "lua")

		if source_format == list_format then
			return id
		end
	end

	return nil
end

function M.set_assignment(level_name_or_idx, mode, id)
	local key = M.assignment_key(level_name_or_idx, mode)

	if not key then
		return false
	end

	local registry = M.load_registry(true)
	id = tonumber(id)

	if id and registry.lists[id] then
		local meta = registry.lists[id]
		local level_idx = type(level_name_or_idx) == "number" and level_name_or_idx or tonumber(tostring(level_name_or_idx):match("%d+"))
		local source_format = level_idx and M.source_format(level_idx, mode)
		local list_format = type(meta) == "table" and (meta.format or "lua")

		if source_format == list_format then
			registry.assignments[key] = id
		else
			return false
		end
	else
		registry.assignments[key] = nil
	end

	return M.save_registry(registry)
end

function M.load_active_wave(level_name, mode)
	local id = M.get_assignment(level_name, mode)

	if not id then
		return nil
	end

	local document = M.load_list(id, true)

	if type(document) ~= "table" or type(document.wave) ~= "table" then
		log.error("Selected custom wave list %s is missing or invalid", tostring(id))

		return nil
	end

	return clone(document.wave), id
end

function M.load_active_lua_wave(level_name, mode)
	local id = M.get_assignment(level_name, mode)

	if not id then
		return nil
	end

	local document = M.load_list(id, true)

	if type(document) ~= "table" or (document.format or "lua") ~= "lua" or type(document.wave) ~= "table" then
		return nil
	end

	return clone(document.wave), id
end

function M.load_active_tsv(level_name, mode)
	local id = M.get_assignment(level_name, mode)

	if not id then
		return nil
	end

	local document = M.load_list(id, true)

	if type(document) ~= "table" or document.format ~= "tsv" or type(document.tsv_data) ~= "string" then
		return nil
	end

	return document.tsv_data, id
end

function M.get_level_generation(level_idx)
	local resources = require("data.encyclopedia_enemy_resources")

	for _, region in pairs(resources.regions) do
		if type(region) == "table" and type(region.levels) == "table" then
			for _, idx in ipairs(region.levels) do
				if idx == level_idx then
					return region.generation
				end
			end
		end
	end

	return nil
end

function M.levels_for_generation(generation)
	local resources = require("data.encyclopedia_enemy_resources")
	local seen = {}
	local out = {}

	for _, region in pairs(resources.regions) do
		if region.generation == generation then
			for _, level_idx in ipairs(region.levels or {}) do
				if not seen[level_idx] then
					seen[level_idx] = true
					out[#out + 1] = level_idx
				end
			end
		end
	end

	table.sort(out)

	local editable = {}

	for _, level_idx in ipairs(out) do
		if M.source_exists(level_idx, GAME_MODE_CAMPAIGN) or M.source_exists(level_idx, GAME_MODE_HEROIC) or M.source_exists(level_idx, GAME_MODE_IRON) then
			editable[#editable + 1] = level_idx
		end
	end

	return editable
end

function M.path_count(level_idx, wave)
	local ok, path_data = pcall(require, string.format("data.levels.%s_paths", M.level_name(level_idx)))
	local count = ok and type(path_data) == "table" and type(path_data.paths) == "table" and #path_data.paths or 0

	for _, group in ipairs(wave and wave.groups or {}) do
		for _, path_wave in ipairs(group.waves or {}) do
			count = math.max(count, tonumber(path_wave.path_index) or 0)
		end
	end

	return math.max(1, count)
end

function M.collect_creeps(wave)
	local seen = {}
	local out = {}

	for _, group in ipairs(wave and wave.groups or {}) do
		for _, path_wave in ipairs(group.waves or {}) do
			for _, spawn in ipairs(path_wave.spawns or {}) do
				for _, name in ipairs({spawn.creep, spawn.creep_aux}) do
					if type(name) == "string" and not seen[name] then
						seen[name] = true
						out[#out + 1] = name
					end
				end
			end
		end
	end

	table.sort(out)

	return out
end

function M.active_atlases(level_name, mode)
	local wave = M.load_active_wave(level_name, mode)

	if not wave then
		return {}, {}
	end

	local resources = require("data.encyclopedia_enemy_resources")
	local normal, scaled = {}, {}
	local normal_seen, scaled_seen = {}, {}

	for _, enemy_name in ipairs(M.collect_creeps(wave)) do
		local entry = resources.enemies[enemy_name]

		if entry then
			local target, target_seen

			if entry.scale_required_texture then
				target = scaled
				target_seen = scaled_seen
			else
				target = normal
				target_seen = normal_seen
			end

			for _, atlas in ipairs(entry.atlases or {}) do
				if not target_seen[atlas] then
					target_seen[atlas] = true
					target[#target + 1] = atlas
				end
			end
		end
	end

	return normal, scaled
end

return M
