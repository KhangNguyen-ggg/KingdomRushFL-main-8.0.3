-- chunkname: @./lib/klua/log.lua

local dgetinfo = debug.getinfo
local strformat = string.format
local noNames = {
	INFO_LEVEL = true,
	ERROR_LEVEL = true,
	DEBUG_LEVEL = true,
	debug = true,
	TODO_LEVEL = true,
	paranoid = true,
	WARNING_LEVEL = true,
	PARANOID_LEVEL = true,
	warning = true,
	error = true,
	OFF_LEVEL = true,
	new = true,
	info = true,
	todo = true
}
local klog = {
	WARNING_LEVEL = 2,
	ERROR_LEVEL = 1,
	DEBUG_LEVEL = 4,
	TODO_LEVEL = 1,
	INFO_LEVEL = 3,
	OFF_LEVEL = 0,
	PARANOID_LEVEL = 5
}

klog.__index = klog
klog.level = klog.ERROR_LEVEL
klog.default_level_by_name = {}
klog.last_log_msgs = {}
klog.last_log_count = 10
klog.android_log_path = nil
klog.android_log_error = nil
klog.android_log_initialized = false
klog.android_diag_msgs = {}
klog.android_diag_count = 120

local function is_android_runtime()
	if _G.IS_ANDROID ~= nil then
		return _G.IS_ANDROID
	end

	return love and love.system and love.system.getOS and love.system.getOS() == "Android"
end

local function android_log_try_write(path, mode, text)
	local ok, err = pcall(function()
		local f, open_err = io.open(path, mode)

		if not f then
			error(open_err or "open failed")
		end

		f:write(text)
		f:close()
	end)

	if ok then
		return true
	end

	return false, err
end

local function android_log_remember_diag(text)
	if not is_android_runtime() then
		return
	end

	text = tostring(text or "")

	if string.find(text, "KRFLAPK", 1, true) then
		table.insert(klog.android_diag_msgs, 1, text)

		while #klog.android_diag_msgs > klog.android_diag_count do
			table.remove(klog.android_diag_msgs)
		end
	end
end

local function android_log_candidates()
	local list = {}
	local seen = {}

	local function add(path)
		if path and path ~= "" and not seen[path] then
			if string.match(path, "^/data/") then
				return
			end

			seen[path] = true
			table.insert(list, path)
		end
	end

	if love and love.filesystem and love.filesystem.getUserDirectory then
		local ok, user_dir = pcall(love.filesystem.getUserDirectory)

		if ok and user_dir then
			user_dir = string.gsub(user_dir, "\\", "/")
			user_dir = string.gsub(user_dir, "/$", "")

			add(user_dir .. "/KRFL_android_log.txt")
			add(user_dir .. "/Download/KRFL_android_log.txt")
			add(user_dir .. "/Documents/KRFL_android_log.txt")
			add(user_dir .. "/Documents/Tencent Files/KRFL_android_log.txt")
		end
	end

	-- No hard-coded shared-storage path here: Harmony/Android compatibility
	-- layers may expose a different user directory. Keep only generic relative
	-- fallbacks before the app-private save directory.
	add("KRFL_android_log.txt")
	add("Download/KRFL_android_log.txt")
	add("Documents/KRFL_android_log.txt")

	if love and love.filesystem and love.filesystem.getSaveDirectory then
		local ok, save_dir = pcall(love.filesystem.getSaveDirectory)

		if ok and save_dir then
			add(save_dir .. "/KRFL_android_log.txt")
		end
	end

	return list
end

function klog.android_log_write(text)
	if not is_android_runtime() then
		return
	end

	text = tostring(text or "")

	if not klog.android_log_initialized then
		klog.android_log_initialized = true

		local header = strformat("\n===== KRFL Android log start %.4f =====\n", love and love.timer and love.timer.getTime() or os.clock())
		local errors = {}

		for _, path in ipairs(android_log_candidates()) do
			local ok, err = android_log_try_write(path, "w", header)

			if ok then
				klog.android_log_path = path
				klog.android_log_error = nil

				break
			else
				table.insert(errors, strformat("%s => %s", path, tostring(err)))
			end
		end

		if not klog.android_log_path then
			if love and love.filesystem and love.filesystem.write then
				local ok = pcall(love.filesystem.write, "KRFL_android_log.txt", header)

				if ok then
					klog.android_log_path = "lovefs://KRFL_android_log.txt"
					klog.android_log_error = nil
				else
					klog.android_log_error = table.concat(errors, "\n")
				end
			else
				klog.android_log_error = table.concat(errors, "\n")
			end
		end
	end

	android_log_remember_diag(text)

	if klog.android_log_path then
		if string.match(klog.android_log_path, "^lovefs://") then
			if love and love.filesystem then
				if love.filesystem.append then
					pcall(love.filesystem.append, "KRFL_android_log.txt", text)
				else
					local old = ""

					if love.filesystem.read then
						local ok, data = pcall(love.filesystem.read, "KRFL_android_log.txt")

						if ok and data then
							old = data
						end
					end

					if love.filesystem.write then
						pcall(love.filesystem.write, "KRFL_android_log.txt", old .. text)
					end
				end
			end

			return
		end

		local ok, err = android_log_try_write(klog.android_log_path, "a", text)

		if not ok then
			klog.android_log_error = tostring(err)
		end
	elseif love and love.filesystem then
		if love.filesystem.append then
			pcall(love.filesystem.append, "KRFL_android_log.txt", text)
		else
			local old = ""

			if love.filesystem.read then
				local ok, data = pcall(love.filesystem.read, "KRFL_android_log.txt")

				if ok and data then
					old = data
				end
			end

			if love.filesystem.write then
				pcall(love.filesystem.write, "KRFL_android_log.txt", old .. text)
			end
		end
	end
end

local function log(print_fn, logname, level, fmt, ...)
	local func_info = dgetinfo(3, "n")
	local func_name = func_info.name or "-"
	local time = love and love.timer.getTime() or os.clock()
	local user_str = strformat(fmt or "", ...)
	local out = strformat("[%.4f] %s.%s %s() - %s\n", time, logname, level, func_name, user_str)

	if level == "ERROR   " or level == "WARNING " or level == "ASSERT   " then
		table.insert(klog.last_log_msgs, 1, out)

		if #klog.last_log_msgs > klog.last_log_count then
			table.remove(klog.last_log_msgs)
		end
	end

	if level == "ERROR   " or level == "WARNING " or level == "ASSERT   " then
		klog.android_log_write(out)
	end

	if print_fn then
		print_fn(out)
	else
		io.write(out)

		if io.output() == io.stdout then
			io.flush()
		end
	end
end

function klog.new(parentlog, name, newlevel)
	local newlog = setmetatable({}, parentlog)

	parentlog.__index = parentlog

	if parentlog then
		if parentlog.default_level_by_name and parentlog.default_level_by_name[name] then
			newlog.level = parentlog.default_level_by_name[name]
		else
			newlog.level = newlevel and newlevel or parentlog.level
		end

		newlog.print_fn = parentlog.print_fn
	else
		newlog.level = newlevel and newlevel or klog.level
	end

	if type(name) == "string" then
		assert(not noNames[name], "Can't use name " .. name .. " for a klogger. It's reserved!")

		newlog.name = name
		klog[name] = newlog
	end

	function newlog.paranoid(fmt, ...)
		if newlog.level >= klog.PARANOID_LEVEL then
			log(newlog.print_fn, newlog.name, "PARANOID", fmt, ...)
		end
	end

	function newlog.debug(fmt, ...)
		if newlog.level >= klog.DEBUG_LEVEL then
			log(newlog.print_fn, newlog.name, "DEBUG   ", fmt, ...)
		end
	end

	function newlog.info(fmt, ...)
		if newlog.level >= klog.INFO_LEVEL then
			log(newlog.print_fn, newlog.name, "INFO    ", fmt, ...)
		end
	end

	function newlog.warning(fmt, ...)
		if newlog.level >= klog.WARNING_LEVEL then
			log(newlog.print_fn, newlog.name, "WARNING ", fmt, ...)
		end
	end

	function newlog.error(fmt, ...)
		if newlog.level >= klog.ERROR_LEVEL then
			log(newlog.print_fn, newlog.name, "ERROR   ", fmt, ...)
		end
	end

	function newlog.todo(fmt, ...)
		if newlog.level >= klog.TODO_LEVEL then
			log(newlog.print_fn, newlog.name, "TODO   ", fmt, ...)
		end
	end

	function newlog.assert(check, fmt, ...)
		if check then
			return
		end

		if newlog.level >= klog.DEBUG_LEVEL then
			assert(check, string.format(fmt, ...))
		else
			log(newlog.print_fn, newlog.name, "ASSERT   ", fmt, ...)
		end
	end

	function newlog.traceall(msg)
		msg = msg or ""

		log(newlog.print_fn, newlog.name, "TRACEBACK  ", "\n%s", debug.traceback(msg, 2))
	end

	function newlog.trace(depth)
		if newlog.level >= klog.DEBUG_LEVEL then
			local level = 1
			local o = ""

			while true do
				local info = debug.getinfo(level, "Sln")

				if not info or depth and depth < level then
					break
				end

				if info.what == "C" then
					o = o .. string.format("    %2i - C function \n", level)
				else
					o = o .. string.format("    %2i - [%s]:%d at %s: %s\n", level, info.short_src, info.currentline, info.namewhat, info.name)
				end

				level = level + 1
			end

			log(newlog.print_fn, newlog.name, "TRACE   ", "\n%s", o)
		end
	end

	return newlog
end

return klog:new("root")
