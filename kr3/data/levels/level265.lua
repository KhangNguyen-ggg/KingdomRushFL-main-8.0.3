-- chunkname: @./kr6/data/levels/level265.lua

local log = require("klua.log"):new("level265")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local V = require("klua.vector")
local P = require("path_db")
local W = require("wave_db")
local storage = require("storage")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

level.skippable_cutscenes = true

function level:init(store)
	self.manual_hero_insertion = store.level_mode_6 == GAME_MODE_IRON
end

function level:update(store)
	local function corrupt_black_burn(bb)
		if bb.health and bb.health.dead then
			bb.force_respawn = true
		end

		bb.corrupt = true
		bb.unit.is_stunned = true
	end

	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		local aux = E:create_entity("controller_stage_15_wave_report")

		LU.queue_insert(store, aux)

		local bb = E:create_entity("hero_stage_15_lord_blackburn")

		bb = LU.insert_hero(store, bb, V.v(850, 324))

		local witch = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_15_witch"
		end)[1]
		local cauldron = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_15_cauldron"
		end)[1]
		local bb_idle = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_15_lord_blackburn_corrupt_level_1_idle"
		end)[1]

		LU.queue_remove(store, bb_idle)

		if not store.restarted and not main.params.skip_cutscenes and store.level_mode_6 ~= GAME_MODE_KR1 and store.level_mode_6 ~= GAME_MODE_NO_HEROES then
			local cinematic_time = witch.cinematic_time or fts(230)

			if witch then
				witch.cinematic_start = true
			end

			signal.emit("pan-zoom-camera", 0, {
				x = 700,
				y = 400
			}, 2)
			U.y_wait(store, fts(1))

			local player_heroes = {}

			if store.main_heroes then
				for _, hero in ipairs(store.main_heroes) do
					table.insert(player_heroes, hero)
				end
			else
				if store.main1_hero then
					table.insert(player_heroes, store.main1_hero)
				end

				if store.main_hero and store.main_hero ~= store.main1_hero then
					table.insert(player_heroes, store.main_hero)
				end
			end

			local previous_stun = {}

			for _, hero in ipairs(player_heroes) do
				if hero.render and hero.render.sprites and hero.render.sprites[1] then
					hero.render.sprites[1].flip_x = true
				end

				if hero.unit then
					table.insert(previous_stun, {hero = hero, value = hero.unit.is_stunned})
					hero.unit.is_stunned = true
				end
			end

			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
			U.y_wait(store, 0.5)

			local balloon_pos = V.v(bb.pos.x - 6, bb.pos.y + 60)

			signal.emit("show-balloon_tutorial-pos", "S15_INTRO_01", false, balloon_pos)
			U.y_wait(store, 3)

			balloon_pos = witch.dialog_pos

			signal.emit("show-balloon_tutorial-pos", "S15_INTRO_02", false, balloon_pos)
			U.y_wait(store, 3)

			balloon_pos = V.v(bb.pos.x - 6, bb.pos.y + 60)

			signal.emit("show-balloon_tutorial-pos", "S15_INTRO_03", false, balloon_pos)
			U.y_wait(store, 3)

			bb.start_intro = true

			U.animation_start(bb, "intro", nil, store.tick_ts, false, 1)
			U.y_wait(store, cinematic_time)
			signal.emit("hide-curtains")
			signal.emit("show-gui")
			signal.emit("end-cinematic")
			signal.emit("pan-zoom-camera", 1, {
				x = 650,
				y = 425
			}, 1.3)

			for _, state in ipairs(previous_stun) do
				state.hero.unit.is_stunned = state.value
			end
		else
			bb.skip_cutscene = true

			U.animation_start(cauldron, "idle", nil, store.tick_ts, true, 1)

			witch.render.sprites[1].hidden = true
		end

		while store.wave_group_number < 10 do
			coroutine.yield()
		end

		corrupt_black_burn(bb)

		while store.wave_group_number ~= 14 or not aux.no_more_enemies or LU.has_alive_enemies(store) or not not bb.corrupting do
			coroutine.yield()
		end

		local bbb

		signal.emit("show-curtains")
		signal.emit("hide-gui")
		signal.emit("start-cinematic")
		signal.emit("pan-zoom-camera", 2, {
			x = bb.pos.x,
			y = bb.pos.y + 0
		}, OVm(1, 1.5))
		U.y_wait(store, 2.25)
		corrupt_black_burn(bb)

		if bb.sound_events then
			bb.sound_events.change_rally_point = nil
		end

		bb.nav_rally.new = true
		bb.nav_rally.pos = V.vclone(bb.pos)
		bb.nav_rally.center = V.vclone(bb.pos)

		U.y_wait(store, 1e+99, function()
			return not store.entities[bb.id]
		end)
		U.y_wait(store, fts(52))

		bbb = table.filter(store.entities, function(k, v)
			return v.template_name == "enemy_boss_stage_15"
		end)[1]

		local start_pos = P:node_pos(bbb.start_path, 1, bbb.start_node)

		if not bbb.final_cinematic_skip_jump then
			signal.emit("pan-zoom-camera", 1, {
				x = start_pos.x,
				y = start_pos.y + 0
			}, OVm(1, 1.5))
		end

		local sub = bbb.final_cinematic_skip_jump and 3 or 0

		U.y_wait(store, fts(13) + fts(30) + 0.6 + 3 - sub)
		signal.emit("hide-curtains")
		signal.emit("show-gui")
		signal.emit("end-cinematic")
		signal.emit("boss_fight_start", bbb)
		W:start_manual_wave("BOSS1")
		W:start_manual_wave("BOSS_BUBBLES")
		U.y_wait(store, 1e+99, function()
			return bbb.bossfight_ended
		end)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			store.custom_game_outcome = {
				postpone_unload = true,
				after_victory_screen = true,
				next_item_name = "level_265_end"
			}
		end
	elseif store.level_mode_6 == GAME_MODE_IRON then
		local bb = E:create_entity("hero_stage_15_lord_blackburn")

		bb.skip_cutscene = true
		bb.corrupt_count = 3
		bb = LU.insert_hero(store, bb, V.v(850, 324))

		local bb_idle = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_15_lord_blackburn_corrupt_level_3_idle"
		end)[1]

		LU.queue_remove(store, bb_idle)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	elseif store.level_mode_6 == GAME_MODE_KR1 then
		local aux = E:create_entity("controller_stage_15_wave_report")

		LU.queue_insert(store, aux)

		local bb = E:create_entity("hero_stage_15_lord_blackburn")

		bb.skip_cutscene = true
		bb = LU.insert_hero(store, bb, V.v(850, 324))

		local bb_idle = table.filter(store.entities, function(k, v)
			return v.template_name == "decal_stage_15_lord_blackburn_corrupt_level_1_idle"
		end)[1]

		LU.queue_remove(store, bb_idle)

		while store.wave_group_number < 6 do
			coroutine.yield()
		end

		corrupt_black_burn(bb)

		while store.wave_group_number < 10 do
			coroutine.yield()
		end

		corrupt_black_burn(bb)

		while store.wave_group_number ~= 14 or not aux.no_more_enemies or LU.has_alive_enemies(store) or not not bb.corrupting do
			coroutine.yield()
		end

		corrupt_black_burn(bb)

		local bbb

		U.y_wait(store, 1e+99, function()
			return not store.entities[bb.id]
		end)
		U.y_wait(store, fts(52))

		bbb = table.filter(store.entities, function(k, v)
			return v.template_name == "enemy_boss_stage_15"
		end)[1]

		U.y_wait(store, fts(13) + fts(30) + 0.6 + 3)
		signal.emit("boss_fight_start", bbb)
		W:start_manual_wave("BOSS1")
		W:start_manual_wave("BOSS_BUBBLES")
		U.y_wait(store, 1e+99, function()
			return bbb.bossfight_ended
		end)
	else
		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end

	signal.emit("game-of-crowns-stage15")
	log.debug("-- WON")
end

return level

