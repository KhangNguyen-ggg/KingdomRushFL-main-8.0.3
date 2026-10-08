-- chunkname: @./main.lua
-- 20260307
if arg[2] == "debug" then
	LLDEBUGGER = require("lldebugger")
	LLDEBUGGER.start()
end

local G = love.graphics

-- KRFLAPK_COLOR_COMPAT: desktop code mostly uses LÖVE 0.10 style 0-255
-- colors, while the Android shell uses LÖVE 11 style 0-1 colors. Without
-- this wrapper semi-transparent black overlays become fully opaque and
-- non-white label colors are clamped to white.
local krflapk_raw_set_color = love.graphics.setColor

local function krflapk_color_channel(v, default)
	if v == nil then
		return default
	end

	if v > 1 then
		return v / 255
	end

	return v
end

love.graphics.setColor_old = krflapk_raw_set_color

local krflapk_love_major = love.getVersion and select(1, love.getVersion()) or love._version_major
local krflapk_needs_color_compat = (love.system and love.system.getOS and love.system.getOS() == "Android") or (krflapk_love_major and krflapk_love_major >= 11)

if krflapk_needs_color_compat then
	love.graphics.setColor = function(r, g, b, a)
		if type(r) == "table" then
			local c = r

			return krflapk_raw_set_color(krflapk_color_channel(c[1], 1), krflapk_color_channel(c[2], 1), krflapk_color_channel(c[3], 1), krflapk_color_channel(c[4], 1))
		end

		if g == nil and b == nil then
			g = r
			b = r
		end

		return krflapk_raw_set_color(krflapk_color_channel(r, 1), krflapk_color_channel(g, 1), krflapk_color_channel(b, 1), krflapk_color_channel(a, 1))
	end
end

require("main_globals")

IS_ANDROID = love.system and love.system.getOS and love.system.getOS() == "Android"

-- KRFLAPK_FILESYSTEM_COMPAT: the KR desktop Lua code still uses LÖVE 0.10-style
-- filesystem helpers, while the Android shell exposes the newer getInfo API.
if love.filesystem.getInfo then
	if not love.filesystem.isFile then
		function love.filesystem.isFile(path)
			local info = love.filesystem.getInfo(path)

			return info and info.type == "file"
		end
	end

	if not love.filesystem.isDirectory then
		function love.filesystem.isDirectory(path)
			local info = love.filesystem.getInfo(path)

			return info and info.type == "directory"
		end
	end

	if not love.filesystem.exists then
		function love.filesystem.exists(path)
			return love.filesystem.getInfo(path) ~= nil
		end
	end
end

-- KRFLAPK_WINDOW_GRAPHICS_COMPAT: KR desktop startup code uses a few window/graphics
-- helpers that are absent in some Android LÖVE shells.
do
	local function pixel_scale()
		if love.window and love.window.getDPIScale then
			local ok, scale = pcall(love.window.getDPIScale)

			if ok and scale then
				return scale
			end
		end

		if love.graphics and love.graphics.getDPIScale then
			local ok, scale = pcall(love.graphics.getDPIScale)

			if ok and scale then
				return scale
			end
		end

		return 1
	end

	if love.window then
		if not love.window.getPixelScale then
			function love.window.getPixelScale()
				return pixel_scale()
			end
		end

		if not love.window.toPixels then
			function love.window.toPixels(x, y)
				local s = pixel_scale()

				if y ~= nil then
					return x * s, y * s
				end

				return x * s
			end
		end

		if not love.window.fromPixels then
			function love.window.fromPixels(x, y)
				local s = pixel_scale()

				if y ~= nil then
					return x / s, y / s
				end

				return x / s
			end
		end

		if not love.window.isCreated then
			function love.window.isCreated()
				return love.graphics and (not love.graphics.isActive or love.graphics.isActive()) or true
			end
		end

		if not love.window.isOpen then
			function love.window.isOpen()
				return true
			end
		end
	end

	if love.graphics then
		if not love.graphics.isActive then
			function love.graphics.isActive()
				return true
			end
		end

		if not love.graphics.isCreated then
			function love.graphics.isCreated()
				return true
			end
		end

		if not love.graphics.getSupported then
			function love.graphics.getSupported()
				return {}
			end
		end

		if not love.graphics.getSystemLimits then
			function love.graphics.getSystemLimits()
				return {}
			end
		end

		if not love.graphics.getRendererInfo then
			function love.graphics.getRendererInfo()
				return "unknown", "unknown", "unknown", "unknown"
			end
		end
	end
end

local base_dir = love.filesystem.getSourceBaseDirectory()
local work_dir = love.filesystem.getWorkingDirectory()
local ppref

if love.filesystem.isFused() then
	ppref = ""
elseif KR_PLATFORM == "android" then
	ppref = base_dir .. "/lovegame/"
else
	ppref = base_dir ~= work_dir and "" or "src/"
end

local additional_paths = {
	string.format("%s%s-%s/?.lua", ppref, KR_GAME, KR_TARGET),
	string.format("%s%s/?.lua", ppref, KR_GAME),
	string.format("%sall-%s/?.lua", ppref, KR_TARGET),
	string.format("%sall/?.lua", ppref),
	string.format("%slib/?.lua", ppref),
	string.format("%slib/?/init.lua", ppref)
}

package.path = package.path .. ";" .. table.concat(additional_paths, ";")

love.filesystem.setRequirePath("?.lua;?/init.lua" .. ";" .. table.concat(additional_paths, ";"))

KR_FULLPATH_BASE = base_dir .. "/src"

local prefix_dir = ""

KR_PATH_ALL = string.format("%s%s", prefix_dir, "all")
KR_PATH_ALL_TARGET = string.format("%s%s-%s", prefix_dir, "all", KR_TARGET)
KR_PATH_GAME = string.format("%s%s", prefix_dir, KR_GAME)
KR_PATH_GAME_TARGET = string.format("%s%s-%s", prefix_dir, KR_GAME, KR_TARGET)

local log = require("klua.log")

if IS_ANDROID and log.android_log_write then
	local love_version = "unknown"

	if love.getVersion then
		local major, minor, revision, codename = love.getVersion()

		love_version = string.format("%s.%s.%s %s", tostring(major), tostring(minor), tostring(revision), tostring(codename))
	end

	log.android_log_write(string.format("startup: KRFL=%s os=%s love=%s game=%s target=%s platform=%s\n", tostring(KR_FL_VERSION), love.system and love.system.getOS and love.system.getOS() or "unknown", love_version, tostring(KR_GAME), tostring(KR_TARGET), tostring(KR_PLATFORM)))

	if love.filesystem and love.filesystem.getSaveDirectory then
		local ok, save_dir = pcall(love.filesystem.getSaveDirectory)

		if ok and save_dir then
			log.android_log_write("save_dir: " .. tostring(save_dir) .. "\n")
		end
	end
end

require("klua.table")
require("klua.dump")
require("version")
require("constants")

if version.build == "RELEASE" then
	DEBUG = nil
	log.level = log.ERROR_LEVEL

	local ok, l = pcall(require, "log_levels_release")

	log.default_level_by_name = ok and l or {}
else
	DEBUG = true
	log.level = log.INFO_LEVEL

	local ok, l = pcall(require, "log_levels_debug")

	log.default_level_by_name = ok and l or {}
end

log.use_print = KR_PLATFORM == "android"

local features = require("features")
local storage = require("storage")
local F = require("klove.font_db")
F:init()
local MU = require("main_utils")
local i18n = require("i18n")

main = {}
main.handler = nil
main.profiler = nil
main.profiler_displayed = false
main.draw_stats = nil
main.draw_stats_displayed = false
main.log_output = nil

function main:set_locale(locale)
	i18n.load_locale(locale)

	if DEBUG then
		package.loaded["data.font_subst"] = nil
	end

	local fs = require("data.font_subst")

	for _, v in pairs(fs.global) do
		F:set_font_subst(unpack(v))
	end

	local locale_subst = fs[locale] or fs.default

	for _, v in pairs(locale_subst) do
		F:set_font_subst(unpack(v))
	end
end

local function close_log()
	if main.log_output then
		log.error("<< closing >>")
		io.stderr:write("Closing log file\n")
		io.flush()
		main.log_output:close()
		io.stderr:write("Bye\n")
	end
end

local function load_director()
	love.window.setMode(main.params.width, main.params.height, {
		fullscreentype = "exclusive",
		centered = false,
		fullscreen = main.params.fullscreen,
		vsync = main.params.vsync,
		msaa = main.params.msaa,
		highdpi = main.params.highdpi
	})

	local aw, ah = love.graphics.getDimensions()

	if aw and ah and (aw ~= main.params.width or ah ~= main.params.height) then
		log.debug("patching width/height from %s,%s, to %s,%s dpi scale:%s", main.params.width, main.params.height, aw,
			ah, love.window.getPixelScale())

		main.params.width, main.params.height = aw, ah
	end

	if main.params.wpos then
		local x, y = unpack(main.params.wpos)

		love.window.setPosition(x or 1, y or 1)
	end

	local director = require("director")

	director:init(main.params)

	main.handler = director
end

local function load_app_settings()
	local I = require("klove.image_db")
	local settings = require("screen_settings")
	local w, h = 400, 500

	for _, t in pairs(settings.required_textures) do
		I:load_atlas(1, KR_PATH_GAME_TARGET .. "/assets/images/fullhd", t)
	end

	local function done_cb()
		storage:save_settings(main.params)

		main.handler = nil

		for _, t in pairs(settings.required_textures) do
			I:unload_atlas(t, 1)
		end

		load_director()
	end

	settings:init(w, h, main.params, done_cb)

	main.handler = settings

	love.window.setMode(w, h, {
		centered = true,
		vsync = false
	})
end

function love.load(arg)
	love.filesystem.setIdentity(version.identity)

	local save_dir = "fl_save"
	if not love.filesystem.isDirectory(save_dir) then
		if not love.filesystem.createDirectory(save_dir) then
			log.error("error creating save_dir: %s", save_dir)
		end
	end
	if love.filesystem.isFused() then
		if not love.filesystem.mount(base_dir, "/", true) then
			log.error("error mounting assets base_dir: %s", base_dir)
		end
		--[[for _, n in pairs({
            KR_PATH_ALL_TARGET,
            KR_PATH_GAME_TARGET
        }) do
            local fn = string.format("%s.dat", n)
            local dn = string.format("%s", n)

            log.debug("mounting %s -> %s", fn, dn)

            if not love.filesystem.mount(fn, dn, true) then
                log.error("error mounting assets file: %s", fn)

                return
            end
        end]]
	end

	main.params = storage:load_settings()

	-- Snapshot display geometry once per process. The Android map options panel
	-- writes the next value, which is intentionally applied after a restart.
	if IS_ANDROID then
		ANDROID_WIDESCREEN_ENABLED = main.params.mobile_widescreen ~= false

		local requested_ui_scale = tonumber(main.params.mobile_ui_scale) or 1
		local valid_ui_scales = {1, 1.1, 1.2, 1.3, 1.4}

		ANDROID_UI_SCALE = 1

		for _, scale in ipairs(valid_ui_scales) do
			if math.abs(requested_ui_scale - scale) < 0.001 then
				ANDROID_UI_SCALE = scale

				break
			end
		end
	end

	MU.basic_init()

	if DEBUG and love.filesystem.isFile("args.lua") then
		print("WARNING: Reading parameters from args.lua. Overrides all cmdline arguments")

		arg = require("args")
	end

	MU.parse_args(arg, main.params)
	MU.default_params(main.params, KR_GAME, KR_TARGET, KR_PLATFORM)
	MU.apply_params(main.params, KR_GAME, KR_TARGET, KR_PLATFORM)

	if main.params.log_level then
		log.level = tonumber(main.params.log_level)
	end

	main.log_output = MU.redirect_output(main.params)

	if main.log_output then
		log.error(MU.get_version_info(version))
		log.error(MU.get_graphics_features())
	end

	MU.start_debugger(main.params)

	if DEBUG then
		log.info(MU.get_debug_info(main.params))
	end

	F:init(KR_PATH_ALL_TARGET .. "/assets/fonts")
	F:load()
	main:set_locale(main.params.locale)
	love.window.setTitle(string.format(_("GAME_TITLE_" .. string.upper(KR_GAME)), KR_FL_VERSION))

	local icon = KR_PATH_GAME_TARGET .. "/assets/icons/icon256.png"

	if love.filesystem.isFile(icon) then
		love.window.setIcon(love.image.newImageData(icon))
	end

	if not main.params.skip_settings_dialog then
		load_app_settings()
	else
		load_director()
	end

	if main.params.profiler then
		main.profiler = require("profiler")
	end

	if main.params.draw_stats then
		main.draw_stats = require("draw_stats")
		main.draw_stats_displayed = true

		main.draw_stats:init(main.params.width, main.params.height)
	end

	if DEBUG then
		require("debug_tools")

		if main.params.localuser then
			log.error("---- LOADING LOCALUSER -----")
			require("localuser")
		end
	end

	if main.params.custom_script then
		log.error("---- LOADING CUSTOM SCRIPT %s ----", main.params.custom_script)
		require(main.params.custom_script)

		if custom_script.init then
			custom_script:init()
		end
	end
end

function love.update(dt)
	if DEBUG and not main.params.debug and main.params.repl then
		repl_t()
	end

	storage:update(dt)
	main.handler:update(dt)

	if DEBUG and main.params.localuser and localuser_update then
		localuser_update(dt)
	end

	if custom_script and custom_script.update then
		custom_script:update(dt)
	end
end

function love.draw()
	main.handler:draw()

	if main.profiler and main.profiler_displayed then
		main.profiler.draw(main.params.width, main.params.height, F:f("DroidSansMono", 14))
	end

	if main.draw_stats and main.draw_stats_displayed then
		main.draw_stats:draw(main.params.width, main.params.height)
	end

	-- Android diagnostics continue to be written to KRFL_android_log.txt, but
	-- the release/test package must not cover the game with an on-screen log.
	if false and IS_ANDROID and log then
		local msgs = log.last_log_msgs or {}
		local path = log.android_log_path
		local err = log.android_log_error

		if path or err or #msgs > 0 then
			local font = main.krflapk_android_log_font

			if not font then
				local ok, f = pcall(function()
					return F:f("DroidSansMono", 12)
				end)

				font = ok and f or G.newFont(12)
				main.krflapk_android_log_font = font
			end

			local all_lines = {}

			table.insert(all_lines, path and ("KRFL log: " .. tostring(path)) or ("KRFL log fallback/error: " .. tostring(err or "not initialized")))

			local diag_msgs = log.android_diag_msgs or {}

			for i = 1, #diag_msgs do
				local line = tostring(diag_msgs[i] or "")

				line = line:gsub("\r", " "):gsub("\n", " ")

				if #line > 220 then
					line = line:sub(1, 220) .. "..."
				end

				table.insert(all_lines, line)
			end

			for i = 1, math.min(#msgs, 4) do
				local line = tostring(msgs[i] or "")

				line = line:gsub("\r", " "):gsub("\n", " ")

				if string.find(line, "sprite_for_error_testing", 1, true) then
					line = "image_db: sprite_for_error_testing missing on desktop too; ignored"
				elseif #line > 120 then
					line = line:sub(1, 120) .. "..."
				end

				table.insert(all_lines, line)
			end

			local line_h = 15
			local visible_count = math.max(4, math.floor((G.getHeight() * 0.72 - 28) / line_h))
			local max_scroll = math.max(0, #all_lines - visible_count)

			main.krflapk_android_log_scroll = math.max(0, math.min(max_scroll, main.krflapk_android_log_scroll or 0))

			local first = math.floor(main.krflapk_android_log_scroll) + 1
			local last = math.min(#all_lines, first + visible_count - 1)
			local lines = {}

			for i = first, last do
				table.insert(lines, all_lines[i])
			end

			if max_scroll > 0 then
				table.insert(lines, 1, string.format("[log %s-%s/%s，可在黑色日志区域上下滑动]", first, last, #all_lines))
			end

			local text = table.concat(lines, "\n")
			local old_font = G.getFont and G.getFont()
			local overlay_w = math.min(G.getWidth() - 16, 1500)
			local overlay_h = math.min(G.getHeight() - 16, 22 + #lines * line_h)

			main.krflapk_android_log_rect = {
				x = 8,
				y = 8,
				w = overlay_w,
				h = overlay_h,
				max_scroll = max_scroll
			}

			G.setFont(font)
			G.setColor(0, 0, 0, 180)
			G.rectangle("fill", 8, 8, overlay_w, overlay_h)
			G.setColor(255, 230, 80, 255)
			G.printf(text, 14, 14, math.max(1, overlay_w - 12), "left")
			G.setColor(255, 255, 255, 255)

			if old_font then
				G.setFont(old_font)
			end
		end
	end
end

local function krflapk_android_touch_pixels(x, y)
	if x >= 0 and x <= 1 and y >= 0 and y <= 1 then
		return x * G.getWidth(), y * G.getHeight()
	end

	return x, y
end


local function krflapk_android_log_touch_begin(id, x, y)
	if not IS_ANDROID or not main.krflapk_android_log_rect then
		return false
	end

	local px, py = krflapk_android_touch_pixels(x, y)
	local r = main.krflapk_android_log_rect

	if px < r.x or px > r.x + r.w or py < r.y or py > r.y + r.h then
		return false
	end

	main.krflapk_android_log_touch_id = id
	main.krflapk_android_log_touch_y = py

	return true
end


local function krflapk_android_log_touch_move(id, x, y)
	if main.krflapk_android_log_touch_id ~= id then
		return false
	end

	local _, py = krflapk_android_touch_pixels(x, y)
	local previous_y = main.krflapk_android_log_touch_y or py
	local delta_lines = (previous_y - py) / 15
	local max_scroll = main.krflapk_android_log_rect and main.krflapk_android_log_rect.max_scroll or 0

	main.krflapk_android_log_scroll = math.max(0, math.min(max_scroll, (main.krflapk_android_log_scroll or 0) + delta_lines))
	main.krflapk_android_log_touch_y = py

	return true
end


local function krflapk_android_log_touch_end(id)
	if main.krflapk_android_log_touch_id ~= id then
		return false
	end

	main.krflapk_android_log_touch_id = nil
	main.krflapk_android_log_touch_y = nil

	return true
end

function love.keypressed(key, scancode, isrepeat)
	if main.profiler then
		if key == "f1" then
			main.profiler.start()
		elseif key == "f2" then
			main.profiler.stop()
		elseif key == "f3" then
			main.profiler_displayed = not main.profiler_displayed
		elseif key == "f4" then
			main.profiler.flag_l2_shown = not main.profiler.flag_l2_shown
			main.profiler.flag_dirty = true
		end
	end

	if main.draw_stats and key == "f" then
		main.draw_stats_displayed = not main.draw_stats_displayed
	end

	if custom_script and custom_script.keypressed then
		custom_script:keypressed(key, isrepeat)
	end

	main.handler:keypressed(key, isrepeat)
end

function love.keyreleased(key, scancode)
	main.handler:keyreleased(key)
end

function love.textinput(t)
	if main.handler.textinput then
		main.handler:textinput(t)
	end
end

function love.mousepressed(x, y, button, istouch)
	main.handler:mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
	main.handler:mousereleased(x, y, button, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
	if main.handler.mousemoved then
		main.handler:mousemoved(x, y, dx, dy, istouch)
	end
end

function love.wheelmoved(dx, dy)
	if IS_ANDROID and main.krflapk_android_log_rect and main.krflapk_android_log_rect.max_scroll > 0 then
		main.krflapk_android_log_scroll = math.max(0, math.min(main.krflapk_android_log_rect.max_scroll, (main.krflapk_android_log_scroll or 0) - dy * 3))

		return
	end

	if main.handler.wheelmoved then
		main.handler:wheelmoved(dx, dy, button)
	end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
	if krflapk_android_log_touch_begin(id, x, y) then
		return
	end

	if main.handler.touchpressed then
		main.handler:touchpressed(id, x, y, dx, dy, pressure)
	end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
	if krflapk_android_log_touch_end(id) then
		return
	end

	if main.handler.touchreleased then
		main.handler:touchreleased(id, x, y, dx, dy, pressure)
	end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
	if krflapk_android_log_touch_move(id, x, y) then
		return
	end

	if main.handler.touchmoved then
		main.handler:touchmoved(id, x, y, dx, dy, pressure)
	end
end

function love.gamepadaxis(joystick, axis, value)
	if main.handler.gamepadaxis then
		main.handler:gamepadaxis(joystick, axis, value)
	end
end

function love.gamepadpressed(joystick, button)
	if custom_script and custom_script.gamepadpressed then
		custom_script:gamepadpressed(joystick, button)
	end

	if main.handler.gamepadpressed then
		main.handler:gamepadpressed(joystick, button)
	end
end

function love.gamepadreleased(joystick, button)
	if main.handler.gamepadreleased then
		main.handler:gamepadreleased(joystick, button)
	end
end

function love.joystickpressed(joystick, button)
	if main.handler.joystickpressed then
		main.handler:joystickpressed(joystick, button)
	end
end

function love.joystickreleased(joystick, button)
	if main.handler.joystickreleased then
		main.handler:joystickreleased(joystick, button)
	end
end

function love.joystickadded(joystick)
	if main.handler.joystickadded then
		main.handler:joystickadded(joystick)
	end
end

function love.joystickremoved(joystick)
	if main.handler.joystickremoved then
		main.handler:joystickremoved(joystick)
	end
end

function love.resize(w, h)
	if main.handler.resize then
		main.handler:resize(w, h)
	end
end

function love.focus(focus)
	if main.handler.focus then
		main.handler:focus(focus)
	end
end

function love.run()
	if love.math then
		love.math.setRandomSeed(os.time())

		for i = 1, 3 do
			love.math.random()
		end
	end

	if love.load then
		love.load(arg)
	end

	my_data_processing()

	if love.timer then
		love.timer.step()
	end

	local dt = 0
	local updatei, updatef, presi, presf, drawi, drawf
	local nx, nx_on = love.nx

	while true do
		if main.profiler and nx and nx.isProfiling() then
			nx_on = true
		end

		if nx_on then
			nx.profilerHeartbeat()
		end

		if love.event then
			love.event.pump()

			for e, a, b, c, d in love.event.poll() do
				if e == "quit" and (not love.quit or not love.quit()) then
					return
				end

				love.handlers[e](a, b, c, d)
			end
		end

		if love.timer then
			love.timer.step()

			dt = love.timer.getDelta()
		end

		if main.draw_stats then
			updatei = love.timer.getTime()
		end

		if nx_on then
			nx.profilerEnterCodeBlock("update")
		end

		if love.update then
			love.update(dt)
		end

		if nx_on then
			nx.profilerExitCodeBlock("update")
		end

		if main.draw_stats then
			updatef = love.timer.getTime()

			main.draw_stats:update_lap(dt, updatei, updatef)
		end

		if love.window and love.graphics and love.window.isCreated() then
			if nx_on then
				nx.profilerEnterCodeBlock("clear")
			end

			love.graphics.clear()
			love.graphics.origin()

			if nx_on then
				nx.profilerExitCodeBlock("clear")
			end

			if love.draw then
				if main.draw_stats then
					drawi = love.timer.getTime()
				end

				if nx_on then
					nx.profilerEnterCodeBlock("draw")
				end

				love.draw()

				if nx_on then
					nx.profilerExitCodeBlock("draw")
				end

				if main.draw_stats then
					drawf = love.timer.getTime()

					main.draw_stats:draw_lap(drawi, drawf)
				end
			end

			collectgarbage("step")

			if main.draw_stats then
				presi = love.timer.getTime()
			end

			if nx_on then
				nx.profilerEnterCodeBlock("present")
			end

			love.graphics.present()

			if nx_on then
				nx.profilerExitCodeBlock("present")
			end

			if main.draw_stats then
				presf = love.timer.getTime()

				main.draw_stats:present_lap(presi, presf)
			end

			if main.handler.limit_fps then
				if nx_on then
					nx.profilerEnterCodeBlock("limit_fps")
				end

				main.handler:limit_fps()

				if nx_on then
					nx.profilerExitCodeBlock("limit_fps")
				end
			end
		end

		if love.timer then
			love.timer.sleep(0.001)
		end
	end
end

function love.quit()
	log.info("Quitting...")
	close_log()
end

local function get_error_stack(msg, layer)
	return (debug.traceback("Error: " .. tostring(msg), 1 + (layer or 1)):gsub("\n[^\n]+$", ""))
end

local function crash_report(str)
	if KR_PLATFORM == "android" then
		local jnia = require("jni_android")

		jnia.crashlytics_log_and_crash(str)
	end
end

function love.errhand(msg)
	local error_canvas = G.newCanvas(G.getWidth(), G.getHeight())
	local last_canvas = G.getCanvas()
	G.setCanvas(error_canvas)

	local last_log_msg = log.last_log_msgs and table.concat(log.last_log_msgs, "") or ""

	msg = tostring(msg)

	local stack_msg = debug.traceback("Error: " .. tostring(msg), 3):gsub("\n[^\n]+$", "")

	stack_msg = (stack_msg or "") .. "\n" .. last_log_msg

	print(stack_msg)
	log.error(stack_msg)

	if IS_ANDROID and log.android_log_write then
		log.android_log_write("\n===== KRFL fatal error =====\n" .. stack_msg .. "\n")
	end

	close_log()
	pcall(crash_report, stack_msg)

	if not love.window or not G or not love.event then
		return
	end

	if not G.isCreated() or not love.window.isOpen() then
		local success, status = pcall(love.window.setMode, 800, 600)

		if not success or not status then
			return
		end
	end

	if love.mouse then
		love.mouse.setVisible(true)
		love.mouse.setGrabbed(false)
		love.mouse.setRelativeMode(false)

		if love.mouse.hasCursor() then
			love.mouse.setCursor()
		end
	end

	if love.joystick then
		for i, v in ipairs(love.joystick.getJoysticks()) do
			v:setVibration()
		end
	end

	if love.audio then
		love.audio.stop()
	end

	G.reset()

	local font = G.setNewFont(math.floor(love.window.toPixels(15)))
	local cn_font = G.setNewFont("all-desktop/assets/fonts/msyh.ttf", math.floor(love.window.toPixels(16)))

	love.graphics.setBackgroundColor(89, 157, 220)
	love.graphics.setColor(255, 255, 255, 255)

	local pt = string.format(
		"Version %s\n\n出了一些错误。如果你不想被嘲讽连中文都不认识的话，请将此截图发到作者的发布贴或发布视频，并详细描述局内的情况。",
		KR_FL_VERSION)

	pt = string.gsub(pt, "\t", "")
	pt = string.gsub(pt, "%[string \"(.-)\"%]", "%1")

	local p = stack_msg

	p = string.gsub(p, "\t", "")
	p = string.gsub(p, "%[string \"(.-)\"%]", "%1")

	local pos = love.window.toPixels(70)
	local error_pos = pos + love.window.toPixels(90)
	local text_width = G.getWidth() - pos * 2

	local function draw()
		G.clear(G.getBackgroundColor())
		G.origin()
		G.setColor(255, 255, 255, 255)
		G.setFont(cn_font)
		G.printf(pt, pos, pos, text_width)
		G.setFont(font)
		G.printf(p, pos, error_pos, text_width)
		G.present()
	end

	draw()

	if LLDEBUGGER then
		LLDEBUGGER.start()
	end

	while true do
		love.event.pump()

		for e, a, b, c in love.event.poll() do
			if e == "quit" then
				return
			elseif e == "keypressed" then
				if a == "escape" then
					return
				else
					return
				end
			elseif e == "touchpressed" then
				local name = love.window.getTitle()

				if #name == 0 or name == "Untitled" then
					name = "Game"
				end

				local buttons = { "OK", "Cancel" }
				local pressed = love.window.showMessageBox("Quit " .. name .. "?", "", buttons)

				if pressed == 1 then
					return
				end
			end
		end

		draw()

		if love.timer then
			love.timer.sleep(3)
		end
	end
end

-- customization
function my_data_processing()
	local function to_xml(t, level)
		local function indent(l)
			local v = ""
	
			for i = 1, l do
				v = v .. "\t"
			end
	
			return v
		end
	
		local o = ""
	
		if type(t) == "table" then
			if #t > 0 then
				o = o .. indent(level) .. "<array>\n"
	
				for k, v in pairs(t) do
					o = o .. to_xml(v, level + 1)
				end
	
				o = o .. indent(level) .. "</array>\n"
			else
				o = o .. indent(level) .. "<dict>\n"
	
				for k, v in pairs(t) do
					o = o .. indent(level + 1) .. "<key>" .. k .. "</key>\n"
					o = o .. to_xml(v, level + 1)
				end
	
				o = o .. indent(level) .. "</dict>\n"
			end
		elseif type(t) == "boolean" then
			o = o .. indent(level) .. (t and "<true/>" or "<false/>") .. "\n"
		elseif type(t) == "number" then
			o = o .. indent(level) .. "<real>" .. tostring(t) .. "</real>\n"
		elseif type(t) == "string" then
			o = o .. indent(level) .. "<string>" .. tostring(t) .. "</string>\n"
		end
	
		return o
	end
	
	local function to_plist(t, a_name, size)
		local o = ""
	
		o = o .. "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
		o = o .. "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
		o = o .. "<plist version=\"1.0\">\n"
		o = o .. "\t<dict>\n"
		o = o .. "\t\t<key>frames</key>\n"
		o = o .. to_xml(t, 2)
		o = o .. "\t\t<key>metadata</key>\n"
		o = o .. "\t\t<dict>\n"
		o = o .. "\t\t\t<key>format</key>\n"
		o = o .. "\t\t\t<integer>3</integer>\n"
		o = o .. "\t\t\t<key>pixelFormat</key>\n"
		o = o .. "\t\t\t<string>RGBA8888</string>\n"
		o = o .. "\t\t\t<key>premultiplyAlpha</key>\n"
		o = o .. "\t\t\t<false/>\n"
		o = o .. "\t\t\t<key>realTextureFileName</key>\n"
		o = o .. "\t\t\t<string>" .. a_name .. "</string>\n"
		o = o .. "\t\t\t<key>size</key>\n"
		o = o .. "\t\t\t<string>" .. size .. "</string>\n"
		o = o .. "\t\t\t<key>textureFileName</key>\n"
		o = o .. "\t\t\t<string>" .. a_name .. "</string>\n"
		o = o .. "\t\t</dict>\n"
		o = o .. "\t</dict>\n"
		o = o .. "</plist>\n"
	
		return o
	end
	
	local function split_atlas(t)
		local atlases = {}
		local names = {}
		for k, v in pairs(t) do
			if not table.contains(names, v.a_name) then
				table.insert(names, v.a_name)
				local newAtlas = {}
				newAtlas.size = "{" .. v.a_size[1] .. "," .. v.a_size[2] .. "}"
				atlases[v.a_name] = newAtlas
			end
			local atlas = atlases[v.a_name]
			local newTable = {}
			local spriteWidth, spriteHeight, spriteSourceWidth, spriteSourceHeight, spriteOffsetX, spriteOffsetY
			spriteWidth = v.f_quad[3]
			spriteHeight = v.f_quad[4]
			spriteSourceWidth = v.size[1]
			spriteSourceHeight = v.size[2]
			spriteOffsetX = math.ceil(v.trim[1] - (spriteSourceWidth - spriteWidth) / 2)
			spriteOffsetY = math.floor((spriteSourceHeight - spriteHeight) / 2 - v.trim[2])
			newTable.spriteOffset = "{" .. tostring(spriteOffsetX) .. "," .. tostring(spriteOffsetY) .. "}"
			newTable.spriteSize = "{" .. tostring(spriteWidth) .. "," .. tostring(spriteHeight) .. "}"
			newTable.spriteSourceSize = "{" .. tostring(spriteSourceWidth) .. "," .. tostring(spriteSourceHeight) .. "}"
			newTable.textureRect = "{{" .. tostring(v.f_quad[1]) .. "," .. tostring(v.f_quad[2]) .. "}," .. newTable.spriteSize .. "}"
			newTable.textureRotated = v.textureRotated or false
			atlas[k .. ".png"] = newTable
			if v.alias and #v.alias > 0 then
				for i, alias in ipairs(v.alias) do
					atlas[alias .. ".png"] = newTable
				end
			end
		end
		return atlases
	end
	
	local fs = love.filesystem
	print(love.filesystem.getSaveDirectory())
	local inputPath = "atlas/input/"
	local outputPath = "atlas/output/"
	local toPlist = true
	if not fs.exists(inputPath) or not fs.exists(outputPath) then
		toPlist = nil
	end
	local inputFiles
	if toPlist then
		inputFiles = fs.getDirectoryItems(inputPath)
		if not inputFiles or #inputFiles == 0 then
			toPlist = nil
		end
	end
	if toPlist then
		inputFiles = table.filter(inputFiles, function(k, v)
			return string.match(v, "[^.]-%.lua$")
		end)
		if not inputFiles or #inputFiles == 0 then
			toPlist = nil
		end
	end
	if toPlist then
		for i, v in ipairs(inputFiles) do
			local inputFile = inputPath .. v
			if fs.isFile(inputFile) then
				local chunk = fs.load(inputFile)
				local atlases = split_atlas(chunk())
				for a_name, atlas in pairs(atlases) do
					local size = atlas.size
					atlas.size = nil
					local startPos = string.find(a_name, "%.png$")
					if not startPos then
						startPos = string.find(a_name, "%.dds$")
						if not startPos then
							startPos = string.find(a_name, "%.pkm$")
							if not startPos then
								startPos = string.find(a_name, "%.pkm.lz4$")
								if not startPos then
									break
								end
							end
						end
					end
					local fileName = outputPath .. string.sub(a_name, 1, startPos - 1) .. ".plist"
					local data = to_plist(atlas, a_name, size)
					local success, message = fs.write(fileName, data)
					if not success then
						log.error("file not created: " .. message)
					end
				end
			end
		end
	end
	
	inputPath = "animations/immutable/"
	outputPath = "animations/alterable/"
	local removeAnimations = true
	if not fs.exists(inputPath) or not fs.exists(outputPath) then
		removeAnimations = nil
	end
	local outputFiles
	if removeAnimations then
		inputFiles = fs.getDirectoryItems(inputPath)
		outputFiles = fs.getDirectoryItems(outputPath)
		if not inputFiles or #inputFiles == 0 or not outputFiles or #outputFiles == 0 then
			removeAnimations = nil
		end
	end
	if removeAnimations then
		inputFiles = table.filter(inputFiles, function(k, v)
			return string.match(v, "[^.]-%.lua$")
		end)
		outputFiles = table.filter(outputFiles, function(k, v)
			return string.match(v, "[^.]-%.lua$")
		end)
		if not inputFiles or #inputFiles == 0 or not outputFiles or #outputFiles == 0 then
			removeAnimations = nil
		end
	end
	local outputFile
	if removeAnimations then
		outputFile = outputPath .. outputFiles[1]
		if not fs.isFile(outputFile) then
			removeAnimations = nil
		end
	end
	
	local function value_to_string(t, level, key)
		local function indent(l)
			local v = ""
	
			for i = 1, l do
				v = v .. "\t"
			end
	
			return v
		end
	
		local o = indent(level) .. (key and (key .. " = ") or "")
	
		if type(t) == "table" then
			if #t > 0 then
				o = o .. "{\n"
	
				for i, v in ipairs(t) do
					o = o .. value_to_string(v, level + 1)
				end
	
				o = o .. indent(level) .. "},\n"
			else
				o = o .. "{\n"
	
				for k, v in pairs(t) do
					o = o .. value_to_string(v, level + 1, k)
				end
	
				o = o .. indent(level) .. "},\n"
			end
		elseif type(t) == "boolean" then
			o = o .. (t and "true" or "false") .. ",\n"
		elseif type(t) == "number" then
			o = o .. tostring(t) .. ",\n"
		elseif type(t) == "string" then
			o = o .. "\"" .. t .. "\",\n"
		else
			return ""
		end
	
		return o
	end
	
	if removeAnimations then
		local chunk = fs.load(outputFile)
		local output_animations = chunk()
		local animations = {}
		for i, v in ipairs(inputFiles) do
			local inputFile = inputPath .. v
			if fs.isFile(inputFile) then
				local chunk = fs.load(inputFile)
				table.merge(animations, chunk())
			end
		end
		for key, value in pairs(output_animations) do
			for k, v in pairs(animations) do
				if key == k then
					output_animations[key] = nil
					break
				end
			end
		end
	
		local o = "return {\n"
		for k, v in pairs(output_animations) do
			o = o .. value_to_string(v, 1, k)
		end
		o = o .. "}"
		local success, message = fs.write(outputFile, o)
		if not success then
			log.error("file not created: " .. message)
		end
	end
	
	inputPath = "dds2pkm_lz4/"
	local dds2pkm = true
	if not fs.exists(inputPath) then
		dds2pkm = nil
	end
	if dds2pkm then
		inputFiles = fs.getDirectoryItems(inputPath)
		if not inputFiles or #inputFiles == 0 then
			dds2pkm = nil
		end
	end
	if dds2pkm then
		inputFiles = table.filter(inputFiles, function(k, v)
			return string.match(v, "[^.]-%.lua$")
		end)
		if not inputFiles or #inputFiles == 0 then
			dds2pkm = nil
		end
	end
	if dds2pkm then
		for i, v in ipairs(inputFiles) do
			local inputFile = inputPath .. v
			if fs.isFile(inputFile) then
				local chunk = fs.load(inputFile)
				local atlas = chunk()
				local o = "return {\n"
				local keys = {}
				for k, v in pairs(atlas) do
					table.insert(keys, k)
				end
				table.sort(keys, function(e1, e2)
					return tostring(e1) < tostring(e2)
				end)
				for i, k in ipairs(keys) do
					local v = atlas[k]
					v.a_name = string.gsub(v.a_name, "%.dds$", "%.pkm.lz4", 1)
					o = o .. value_to_string(v, 1, "[\"" .. k .. "\"]")
				end
				o = o .. "}"
				local success, message = fs.write(inputFile, o)
				if not success then
					log.error("file not created: " .. message)
				end
			end
		end
	end
end
