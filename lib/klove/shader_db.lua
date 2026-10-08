-- chunkname: @./lib/klove/shader_db.lua

local log = require("klua.log"):new("shader_db")
local FS = love.filesystem
local shader_db = {}

function shader_db:init(shader_path, preload)
	self.path = shader_path
	self.shaders = {}

	if preload then
		local files = FS.getDirectoryItems(self.path)

		for i = 1, #files do
			local name = files[i]
			local f = self.path .. "/" .. name

			if FS.isFile(f) and string.match(f, ".c$") then
				self:get(string.gsub(name, ".c$", ""))
			end
		end
	end
end

function shader_db:get(name)
	if not self.shaders[name] then
		local filename = self.path .. "/" .. name .. ".c"
		local start_ts = love.timer.getTime()

		log.debug("loading shader:%s from file %s", name, filename)

		local ok, sh = pcall(love.graphics.newShader, filename)

		if not ok then
			log.error("error loading shader:%s from file:%s\n%s", name, filename, tostring(sh))

			return nil
		end

		self.shaders[name] = sh

		log.debug("    time:%s", love.timer.getTime() - start_ts)
	end

	return self.shaders[name]
end

function shader_db:clone(name, new_name)
	if self.shaders[new_name] then
		return self.shaders[new_name]
	end

	local filename = self.path .. "/" .. name .. ".c"
	local start_ts = love.timer.getTime()

	log.debug("cloning shader:%s as %s from file %s", name, new_name, filename)

	local ok, sh = pcall(love.graphics.newShader, filename)

	if not ok then
		log.error("error cloning shader:%s from file:%s\n%s", name, filename, tostring(sh))

		return nil
	end

	self.shaders[new_name] = sh
	log.debug("    time:%s", love.timer.getTime() - start_ts)

	return sh
end

return shader_db
