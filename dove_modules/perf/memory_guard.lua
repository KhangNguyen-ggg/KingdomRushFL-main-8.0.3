-- chunkname: @./dove_modules/perf/memory_guard.lua
--
-- Memory guard for Kingdom Rush FL 8.0.3
--
-- Purpose: keep the game's resident set close to steady while playing, without
-- changing any gameplay, graphics, audio or save behaviour. Everything here is
-- housekeeping only:
--
--   1. Runs a paced incremental collection during play so short-lived garbage
--      (damage events, expired entities, transient render frames) is reclaimed
--      instead of waiting for a full collection that may never be triggered.
--   2. Runs one full collection when a level ends, right after the level data
--      and cached textures have been dropped.
--   3. Exposes a live readout so RAM can be verified on the user's machine
--      without guessing (the previous work had no measurement at all).
--
-- The guard never caps entities, never changes tick length, never unloads an
-- atlas on its own and never touches the save files.

local log = require("klua.log"):new("memory_guard")

local M = {}

-- Pacing. A full incremental "step" is cheap; doing one every ~2 seconds keeps
-- the Lua heap from ballooning between levels without adding measurable frame
-- cost. Full collection happens only on level transitions.
M.step_interval = 2.0
M.step_mul = 200
M.full_mul = 400

M._acc = 0
M._last_lua_kb = 0
M._peak_lua_kb = 0
M._full_collections = 0
M._step_collections = 0
M._enabled = true
M._show = false

local function lua_kb()
	return collectgarbage("count")
end

function M:init()
	log.info("memory_guard: initial Lua heap %.1f MB", lua_kb() / 1024)
	self._last_lua_kb = lua_kb()
	self._peak_lua_kb = self._last_lua_kb
	self._acc = 0
end

function M:set_enabled(v)
	self._enabled = v and true or false
end

function M:is_enabled()
	return self._enabled
end

function M:toggle_show()
	self._show = not self._show
end

-- Called every frame from director:update. Cheap by design: one subtraction and
-- one comparison when the accumulator has not elapsed yet.
function M:update(dt)
	if not self._enabled then
		return
	end

	if type(dt) ~= "number" then
		dt = 0
	end

	self._acc = self._acc + dt

	if self._acc < self.step_interval then
		return
	end

	self._acc = 0

	local prev = collectgarbage("setstepmul")

	collectgarbage("step")

	collectgarbage("setstepmul", prev)

	self._step_collections = self._step_collections + 1

	local kb = lua_kb()

	self._last_lua_kb = kb

	if kb > self._peak_lua_kb then
		self._peak_lua_kb = kb
	end

	if self._show then
		log.info("memory_guard: step #%d | lua %.1f MB | peak %.1f MB",
			self._step_collections, kb / 1024, self._peak_lua_kb / 1024)
	end
end

-- Called from game:destroy() after the level data, exoskeletons and cached
-- text textures have been released. This is the point where a full collection
-- actually pays off, because the bulk of the garbage became unreachable just
-- now rather than gradually during play.
function M:collect_full()
	if not self._enabled then
		return
	end

	local step_mul = collectgarbage("setstepmul")

	collectgarbage("setstepmul", self.full_mul)
	collectgarbage("collect")

	collectgarbage("setstepmul", self.step_mul or step_mul)

	self._full_collections = self._full_collections + 1

	local kb = lua_kb()

	self._last_lua_kb = kb
	self._peak_lua_kb = math.max(kb, self._peak_lua_kb)

	log.info("memory_guard: full collect #%d | lua %.1f MB (was %.1f MB)",
		self._full_collections, kb / 1024, kb / 1024)
end

function M:stats()
	return {
		lua_kb = self._last_lua_kb,
		peak_lua_kb = self._peak_lua_kb,
		step_collections = self._step_collections,
		full_collections = self._full_collections
	}
end

-- Small on-screen readout, toggled from the debug key handler. Kept opt-in so it
-- never changes what a normal session looks like.
function M:draw()
	if not self._show then
		return
	end

	local G = love.graphics

	local s = self:stats()
	local lines = {
		string.format("lua %.1f MB / peak %.1f MB", s.lua_kb / 1024, s.peak_lua_kb / 1024),
		string.format("step #%d  full #%d", s.step_collections, s.full_collections)
	}

	G.setColor(0, 0, 0, 160)
	G.rectangle("fill", 8, 8, 250, 46, 6, 6)
	G.setColor(255, 255, 255, 255)
	G.print(lines[1], 16, 14)
	G.print(lines[2], 16, 30)

	G.setColor(255, 255, 255)
end

return M