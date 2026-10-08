-- chunkname: @kr1/data/levels/level90.lua

local log = require("klua.log"):new("level21")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

function level:fn_can_power(store, power_id, pos)
	return V.is_inside(pos, V.r(95, 318, 117, 58))
end

function level:update(store)
	if store.level_mode == GAME_MODE_CAMPAIGN then
		local boss = E:create_entity("eb_malagar")
		local spawned_waves = {}

		boss.pos = V.vclone(boss.pos_castle)

		LU.queue_insert(store, boss)

		self.boss = boss

		U.mark_seen(store, boss.template_name)
		coroutine.yield()
		U.y_wait(store, 1)

		self.boss.phase_signal = "welcome"

		while self.boss.phase ~= "rest" do
			coroutine.yield()
		end

		while not store.waves_finished or LU.has_alive_enemies(store, {
			"eb_malagar"
		}) do
			if table.contains(boss.mid_level.waves, store.wave_group_number) and boss.phase == "rest" and not table.contains(spawned_waves, store.wave_group_number) then
				table.insert(spawned_waves, store.wave_group_number)

				self.boss.phase_signal = "fight"
			end

			coroutine.yield()
		end

		S:queue("MusicBossFightReBBBornHammerhold")

		self.boss.phase_signal = "descend"

		while self.boss.phase ~= "death" do
			coroutine.yield()
		end

		log.debug("asakdkasdk")

		while self.boss.phase ~= "death-end" do
			coroutine.yield()
		end

		log.debug("here")

		local store_enemies = table.filter(store.entities, function(_, e)
			return e.template_name == "eb_malagar_clone" and not e.health.dead == true
		end)

		log.debug(#store_enemies)

		while #store_enemies > 0 do
			store_enemies = table.filter(store.entities, function(_, e)
				return e.template_name == "eb_malagar_clone" and not e.health.dead == true
			end)

			coroutine.yield()
		end

	else
		while store.wave_group_number < 1 do
			coroutine.yield()
		end

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end
end

return level
