-- chunkname: @./kr6/data/levels/level261.lua

local log = require("klua.log"):new("level261")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local V = require("klua.vector")
local P = require("path_db")
local W = require("wave_db")
local balance = require("data.balance.balance_6")
local storage = require("storage")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

function level:update(store)
	if store.level_mode_6 ~= GAME_MODE_IRON and store.level_mode_6 ~= GAME_MODE_EXTRA_HEROES and store.level_mode_6 ~= GAME_MODE_BLITZ and store.level_mode_6 ~= GAME_MODE_NO_HEROES then
		local camp_level_ups = balance.specials.towers.stage_11_tower_camp.wave_level_up

		while store.wave_group_number < camp_level_ups[1] do
			coroutine.yield()
		end

		local old_camp = table.filter(store.entities, function(k, v)
			return v.template_name == "tower_stage_11_camp_lvl1"
		end)[1]

		old_camp.tower.upgrade_to = "tower_stage_11_camp_lvl2"

		while store.wave_group_number < camp_level_ups[2] do
			coroutine.yield()
		end

		local old_camp = table.filter(store.entities, function(k, v)
			return v.template_name == "tower_stage_11_camp_lvl2"
		end)[1]

		old_camp.tower.upgrade_to = "tower_stage_11_camp_lvl3"

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end

		local c = table.filter(store.entities, function(k, v)
			return v.template_name == "controller_stage_11_spider_block_and_spawn"
		end)[1]

		while c.in_use do
			coroutine.yield()
		end

		c._tower_block = false
		c._spawn_eggs = false
		c.eggs_queue = {}

		U.y_wait(store, 2)

		local g_spawn = V.v(42.6, 435.7)
		local node = 30
		local descent = E:create_entity("decal_stage_11_sarelgaz_descent")
		local dest = P:node_pos(1, 1, node)

		descent.pos.x = dest.x
		descent.target_pos = V.vclone(dest)

		LU.queue_insert(store, descent)

		while not descent.finished do
			coroutine.yield()
		end

		local boss = E:create_entity("enemy_boss_stage_11")

		boss.nav_path.pi = 1
		boss.nav_path.spi = 1
		boss.nav_path.ni = node
		boss.pos = V.vclone(dest)
		boss.lower_path_id = 1
		boss.lower_node_id = node

		LU.queue_insert(store, boss)
		coroutine.yield()
		signal.emit("boss_fight_start", boss)
		W:start_manual_wave("BOSS1")

		while not boss.health.dead do
			coroutine.yield()
		end

		signal.emit("boss_fight_end")
		U.y_wait(store, 3)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			store.custom_game_outcome = {
				postpone_unload = true,
				after_victory_screen = true,
				next_item_name = "level_261_end"
			}
		end
	else
		local camp

		if store.level_mode_6 ~= GAME_MODE_IRON then
			for k, v in pairs(store.entities) do
				if v.template_name == "decal_stage_11_torch" then
					v.skip_to_loop = true
					v.render.sprites[1].hidden = false
				end

				if v.template_name == "decal_stage_11_shadows_lvl1" or v.template_name == "decal_stage_11_shadows_lvl2" then
					v.render.sprites[1].hidden = true
				end

				if v.template_name == "controller_stage_11_spider_eyes_decos" then
					LU.queue_remove(store, v)
				end
			end
		else
			for k, v in pairs(store.entities) do
				if v.template_name == "decal_stage_11_torch" and v.camp_level == 2 then
					v.skip_to_loop = true
					v.render.sprites[1].hidden = false
				end

				if v.template_name == "decal_stage_11_shadows_lvl1" then
					v.render.sprites[1].hidden = true
				end

				if v.template_name == "decal_stage_11_shadows_lvl2" then
					v.render.sprites[1].hidden = false
				end
			end
		end

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	log.debug("-- WON")
end

return level

