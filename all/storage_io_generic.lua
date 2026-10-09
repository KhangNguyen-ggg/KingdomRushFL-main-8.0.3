-- chunkname: @./all/storage_io_generic.lua

local log = require("klua.log"):new("storage_io_generic")
local signal = require("hump.signal")
local km = require("klua.macros")
local persistence = require("klua.persistence")

require("klua.table")

local sio = {}

sio.cache_str = {}
sio.cache_data = {}
sio.write_queue = {}
sio.checksum_enabled = nil
sio.CHECKSUM_EXTRA = "Found it! Now you can avoid paying for gems, making it harder for us to make more games. Happy?"

function sio:_load_file(filename, force_load)
	local str, ok, chunk, data, siz, err

	if force_load then
		sio.cache_str[filename] = nil
		sio.cache_data[filename] = nil
	end

	if sio.cache_data[filename] then
		log.debug("loading file %s from cache_data", filename)

		return true, sio.cache_data[filename]
	elseif sio.cache_str[filename] then
		log.debug("loading file %s from cache_str", filename)

		ok, str = true, sio.cache_str[filename]
	else
		log.debug("loading file %s from filesystem", filename)

		ok, str, siz = pcall(love.filesystem.read, filename)
	end

	if not ok then
		log.error("error reading %s", filename)

		return nil
	end

	if not str then
		log.info("error reading %s. %s", filename, tostring(siz))

		return nil
	end

	ok, chunk, err = pcall(loadstring, str, "@" .. filename)

	if not ok or err then
		log.error("error parsing %s. %s", filename, err)

		return nil
	end

	local env = {}

	setfenv(chunk, env)

	ok, data = pcall(chunk)

	if not ok then
		log.error("error evaluating chunk. %s", tostring(data))

		return nil
	end

	if ok and data then
		sio.cache_str[filename] = str
		sio.cache_data[filename] = data
	end

	return ok, data
end

local function is_slot_file(filename)
	return filename:match("^fl_save/slot_%d+%.lua$") ~= nil
end

local function valid_slot(data)
	return type(data) == "table" and type(data.levels) == "table" and
		type(data.upgrades) == "table" and type(data.heroes) == "table"
end

local function file_exists(filename)
	if love.filesystem.getInfo then return love.filesystem.getInfo(filename, "file") ~= nil end
	return love.filesystem.isFile(filename)
end

function sio:load_file(filename, force_load)
	local ok, data = self:_load_file(filename, force_load)
	if not is_slot_file(filename) then return ok, data end
	if ok and valid_slot(data) then return ok, data end
	self.cache_str[filename], self.cache_data[filename] = nil, nil
	local backup_ok, backup = self:_load_file(filename .. ".bak", true)
	if backup_ok and valid_slot(backup) then
		log.error("save %s unreadable; using backup without deleting original", filename)
		return true, backup
	end
	return nil
end

function sio:write_file(filename, data_table)
	local slot_file = is_slot_file(filename)
	if slot_file and not valid_slot(data_table) then
		log.error("refusing to write invalid save %s", filename)
		return false
	end
	local serialized, data_string = pcall(persistence.serialize_to_string, data_table)
	if not serialized then
		log.error("cannot serialize %s: %s", filename, tostring(data_string))
		return false
	end
	if self.cache_str[filename] == data_string then return true end

	if slot_file then
		local backup_string
		if file_exists(filename) then
			local read_ok, previous_string = pcall(love.filesystem.read, filename)
			if not read_ok or not previous_string then return false end
			local previous_ok, previous = self:_load_file(filename, true)
			if previous_ok and valid_slot(previous) then
				backup_string = previous_string
			elseif not file_exists(filename .. ".corrupt") then
				local preserved, result = pcall(love.filesystem.write, filename .. ".corrupt", previous_string)
				if not preserved or not result then return false end
			end
		elseif not file_exists(filename .. ".bak") then
			backup_string = data_string
		end
		if backup_string then
			local backed_up, result = pcall(love.filesystem.write, filename .. ".bak", backup_string)
			if not backed_up or not result then
				log.error("cannot back up %s; original save was not overwritten", filename)
				return false
			end
			self.cache_str[filename .. ".bak"], self.cache_data[filename .. ".bak"] = nil, nil
		end
	end

	local called, success, err = pcall(love.filesystem.write, filename, data_string)
	if called and success then
		self.cache_str[filename] = data_string
		self.cache_data[filename] = data_table
		return true
	end
	self.cache_str[filename], self.cache_data[filename] = nil, nil
	log.error("error writing %s: %s", filename, tostring(called and err or success))
	return false
end

function sio:remove_file(filename)
	self.cache_str[filename], self.cache_data[filename] = nil, nil
	local success = love.filesystem.remove(filename)
	if is_slot_file(filename) then
		-- Explicit deletion must not resurrect the slot from its backup.
		if not file_exists(filename) then success = true end
		if success and file_exists(filename .. ".bak") then
			success = love.filesystem.remove(filename .. ".bak")
		end
		self.cache_str[filename .. ".bak"], self.cache_data[filename .. ".bak"] = nil, nil
	end
	return success
end

function sio:commit()
	return true
end

function sio:update()
	return
end

function sio:is_busy()
	return false
end

function sio:is_pending()
	return false
end

return sio

