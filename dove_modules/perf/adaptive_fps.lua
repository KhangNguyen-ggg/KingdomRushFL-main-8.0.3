local M = {
	max_fps = 60,
	min_fps = 30,
	counter = 0,
	scene = nil
}

local A = require("klove.animation_db")

local function configured_fps(scene)
	local fps = scene and tonumber(scene.max_fps) or nil

	if not fps then
		fps = tonumber(rawget(_G, "DRAW_FPS")) or 60
	end

	return math.max(M.min_fps, fps)
end

-- Called once on game init to bind to the game scene
function M:set_scene(scene)
	self.scene = scene
	self.counter = 0
	-- The configured draw rate is the highest useful simulation rate.  Game
	-- scenes normally rely on vsync and therefore do not have max_fps set.
	self.max_fps = configured_fps(scene)
	self.fps = self.max_fps
	self.tick_length = 1 / self.fps

	if scene and scene.simulation and scene.simulation.store then
		scene.simulation.store.tick_length = self.tick_length
	end

	A.tick_length = self.tick_length
end

function M:destroy()
	self.scene = nil
	self.counter = 0
	A.tick_length = TICK_LENGTH
end

function M:set_fps(fps)
	if not self.scene or not self.scene.simulation or not self.scene.simulation.store then
		return
	end

	self.fps = math.max(self.min_fps, math.min(self.max_fps, fps))
	self.tick_length = 1 / self.fps
	self.scene.simulation.store.tick_length = self.tick_length
	self.scene.limit_fps = self.fps
	A.tick_length = self.tick_length
end

function M:update(dt)
	if not self.scene or type(dt) ~= "number" or dt <= 0 then
		return dt
	end

	if dt > self.tick_length * 1.1 then
		self.counter = self.counter + 1

		if self.counter > 5 then
			self.counter = 0

			if self.fps > self.min_fps then
				self:set_fps(math.max(self.min_fps, 1 / dt))
			end
		end

		-- Do not let a single suspended or exceptionally slow frame create an
		-- unbounded catch-up loop.  At 60 Hz this still permits two simulation
		-- steps, which is enough to preserve real-time speed at 30 rendered FPS.
		return math.min(dt, 1 / self.min_fps)
	elseif self.max_fps > self.fps then
		self.counter = self.counter - 1

		if self.counter < -5 then
			self.counter = 0

			if self.max_fps > self.fps then
				self:set_fps(math.floor(self.fps + 1))
			end
		end

		return dt
	end

	self.counter = 0

	return dt
end

return M
