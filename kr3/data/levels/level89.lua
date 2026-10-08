-- chunkname: @kr1/data/levels/level89.lua

local log = require("klua.log"):new("level89")
local signal = require("hump.signal")
local AC = require("achievements")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils")
local LU = require("level_utils")
local V = require("klua.vector")
local P = require("path_db")
local km = require("klua.macros")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {
	update = function(self, store)
		if store.level_mode == GAME_MODE_IRON then
			store.lives = 1

			local gold_factor_enemy = 1

			signal.emit("wave-notification", "icon", "TIP_SPHINX_IRON")

			for _, t in pairs(E:filter_templates("enemy")) do
				if t.enemy.gold and gold_factor_enemy then
					t.enemy.gold = math.floor(t.enemy.gold * gold_factor_enemy)
				end
			end

			while not store.waves_finished or LU.has_alive_enemies(store) do
				coroutine.yield()
			end

			U.y_wait(store, 2)

			while not store.waves_finished or LU.has_alive_enemies(store) do
				coroutine.yield()
			end

			AC:got("DEFEAT_SET")
		elseif store.level_mode == GAME_MODE_HEROIC then
			local ts = store.tick_ts
			local heroic_ts = store.tick_ts
			local w = store.wave_group_number
			local s = E:get_template("enemy_set").timed_attacks.list[2]
			local c = 1

			signal.emit("wave-notification", "icon", "TIP_SPHINX_HEROIC")

			while store.wave_group_number < 1 do
				coroutine.yield()
			end

			local seconds_passed = 0

			while not store.waves_finished or LU.has_alive_enemies(store) and store.wave_group_number > 0 do
				if store.send_next_wave then
					seconds_passed = 0
					store.nobelisk = false
				else
					seconds_passed = seconds_passed + store.tick_length
				end

				local enemies_killed = true

				for i, e in pairs(store.entities) do
					if e.template_name ~= "enemy_fallen" then
						enemies_killed = false

						break
					end
				end

				if seconds_passed > 150 and enemies_killed and store.wave_group_number == 6 then
					store.nobelisk = true
					seconds_passed = 0
				end

				if store.nobelisk ~= true and store.tick_ts - ts > s.cooldown then
					ts = store.tick_ts
					c = c + 1
					x_pos = table.clone(s.x_locations)
					y_pos = table.clone(s.y_locations)

					for i = 1, s.loops[km.zmod(c, #s.loops)] do
						local roll = math.random(1, #x_pos)
						local nearest = P:nearest_nodes(x_pos[roll], y_pos[roll], nil, nil, true)
						local pi, spi, ni = unpack(nearest[1])
						local e = E:create_entity("set_obelisk")

						e.pos.x = x_pos[roll]
						e.pos.y = y_pos[roll]
						e.spawner.pi = pi
						e.spawner.ni = ni
						e.spawner.duration = s.duration

						LU.queue_insert(store, e)
						log.debug("Spawning obelisk")
						table.remove(x_pos, roll)
						table.remove(y_pos, roll)
					end
				end

				coroutine.yield()
			end
		else
			signal.emit("wave-notification", "icon", "TIP_SPHINX")

			while not store.waves_finished or LU.has_alive_enemies(store) do
				coroutine.yield()
			end
		end
	end
}

return level
