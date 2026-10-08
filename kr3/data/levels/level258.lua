-- chunkname: @./kr6/data/levels/level258.lua

local log = require("klua.log"):new("level258")
local signal = require("hump.signal")
local E = require("entity_db")
local S = require("sound_db")
local U = require("utils_6")
local LU = require("level_utils_6")
local V = require("klua.vector")
local P = require("path_db")
local GR = require("grid_db")
local storage = require("storage")

require("constants")

local function fts(v)
	return v / FPS
end

local level = {}

level.skippable_cutscenes = true

local function set_terrain(cells, terrain)
	for _, cell in ipairs(cells) do
		GR:set_cell(cell[1], cell[2], terrain)
	end
end

local blocked_cells_phase_1 = {
	{
		26,
		37
	},
	{
		27,
		37
	},
	{
		28,
		37
	},
	{
		29,
		37
	},
	{
		30,
		37
	},
	{
		31,
		37
	},
	{
		32,
		37
	},
	{
		33,
		37
	},
	{
		26,
		36
	},
	{
		27,
		36
	},
	{
		28,
		36
	},
	{
		29,
		36
	},
	{
		30,
		36
	},
	{
		31,
		36
	},
	{
		32,
		36
	},
	{
		33,
		36
	},
	{
		26,
		35
	},
	{
		27,
		35
	},
	{
		28,
		35
	},
	{
		29,
		35
	},
	{
		30,
		35
	},
	{
		31,
		35
	},
	{
		32,
		35
	},
	{
		33,
		35
	},
	{
		27,
		34
	},
	{
		28,
		34
	},
	{
		29,
		34
	},
	{
		30,
		34
	},
	{
		31,
		34
	},
	{
		32,
		34
	},
	{
		33,
		34
	},
	{
		27,
		33
	},
	{
		28,
		33
	},
	{
		29,
		33
	},
	{
		30,
		33
	},
	{
		31,
		33
	},
	{
		32,
		33
	},
	{
		33,
		33
	},
	{
		35,
		21
	},
	{
		36,
		21
	},
	{
		37,
		21
	},
	{
		38,
		21
	},
	{
		39,
		21
	},
	{
		40,
		21
	},
	{
		41,
		21
	},
	{
		42,
		21
	},
	{
		43,
		21
	},
	{
		44,
		21
	},
	{
		36,
		20
	},
	{
		37,
		20
	},
	{
		38,
		20
	},
	{
		39,
		20
	},
	{
		40,
		20
	},
	{
		41,
		20
	},
	{
		42,
		20
	},
	{
		43,
		20
	},
	{
		44,
		20
	},
	{
		36,
		19
	},
	{
		37,
		19
	},
	{
		38,
		19
	},
	{
		39,
		19
	},
	{
		40,
		19
	},
	{
		41,
		19
	},
	{
		42,
		19
	},
	{
		43,
		19
	},
	{
		44,
		19
	},
	{
		36,
		18
	},
	{
		37,
		18
	},
	{
		38,
		18
	},
	{
		39,
		18
	},
	{
		40,
		18
	},
	{
		41,
		18
	},
	{
		42,
		18
	},
	{
		43,
		18
	},
	{
		44,
		18
	},
	{
		36,
		17
	},
	{
		37,
		17
	},
	{
		38,
		17
	},
	{
		39,
		17
	},
	{
		40,
		17
	},
	{
		41,
		17
	},
	{
		42,
		17
	},
	{
		43,
		17
	},
	{
		44,
		17
	}
}

function level:preprocess(store)
	if store.level_mode_6 == GAME_MODE_CAMPAIGN then
		level.show_comic_idx = 53
	end
end

function level:update(store)
	local function intro_text_key(hero, suffix)
		local template_name = hero and hero.template_name

		if template_name and i18n and i18n.exists then
			local hero_name = string.gsub(template_name, "^hero_", "")

			hero_name = string.gsub(hero_name, "_g6$", "")
			hero_name = string.gsub(hero_name, "_kr6$", "")

			local key = string.upper(hero_name) .. "_TAUNT_STAGE_08_INTRO"

			if i18n:exists(key) then
				return key
			end
		end

		return "DEFAULT_TAUNT_STAGE_08_INTRO" .. suffix
	end

	local function show_intro_balloon(hero, id, suffix)
		if not hero or not hero.pos then
			return
		end

		local balloon_pos = V.vclone(hero.pos)
		local offset = hero.text_balloon_offset
		local height = hero.health_bar and hero.health_bar.offset and hero.health_bar.offset.y or 40

		if offset then
			balloon_pos.x = balloon_pos.x + offset.x
			balloon_pos.y = balloon_pos.y + offset.y
		end

		if height > 100 then
			id = id .. "_TALL"
		else
			id = id .. "_NORMAL"
			balloon_pos.y = balloon_pos.y + height + 15
		end

		signal.emit("show-balloon_tutorial-pos", id, false, balloon_pos, intro_text_key(hero, suffix))
	end

	for i = 1, 7 do
		if i == 2 then
			P:add_invalid_range(i, P:get_end_node(i) - 12, P:get_end_node(i), NF_RANGE)
			P:add_invalid_range(i, P:get_end_node(i) - 4, P:get_end_node(i))
		else
			P:add_invalid_range(i, P:get_end_node(i) - 8, P:get_end_node(i), NF_RANGE)
			P:add_invalid_range(i, P:get_end_node(i) - 4, P:get_end_node(i))
		end
	end

	local hero_1, hero_2

	if store.level_mode_6 == GAME_MODE_CAMPAIGN or store.level_mode_6 == GAME_MODE_KR1 then
		-- The level coroutine runs before heroes are inserted on the first tick.
		coroutine.yield()

		if store.main_heroes then
			hero_1 = store.main_heroes[1]
			hero_2 = store.main_heroes[2]
		else
			hero_1 = store.main1_hero or store.main_hero
			hero_2 = store.main_hero ~= hero_1 and store.main_hero or nil
		end

		if hero_1 then
			local spawn = store.level.custom_spawn_pos[1].pos

			hero_1.pos = V.vclone(spawn)
			hero_1.nav_rally.center = V.vclone(spawn)
			hero_1.nav_rally.pos = V.vclone(spawn)
		end
	end

	if store.level_mode_6 == GAME_MODE_CAMPAIGN or store.level_mode_6 == GAME_MODE_KR1 then
		local cont_phases, citizens_1_cont, citizens_2_cont

		for k, v in pairs(store.entities) do
			if v.template_name == "controller_stage_08_phases" then
				cont_phases = v
			end

			if v.template_name == "controller_stage_08_citizens_1" then
				citizens_1_cont = v
			end

			if v.template_name == "controller_stage_08_citizens_2" then
				citizens_2_cont = v
			end

		end

		set_terrain(blocked_cells_phase_1, bit.bor(TERRAIN_LAND, TERRAIN_NOWALK))

		local camera_end_position = {
			x = 345,
			y = 400
		}

		if not store.restarted and not main.params.skip_cutscenes and store.level_mode_6 == GAME_MODE_CAMPAIGN then
			signal.emit("pan-zoom-camera", 2, {
				x = 500,
				y = 450
			}, 1.3)
			signal.emit("show-curtains")
			signal.emit("hide-gui")
			signal.emit("start-cinematic")
			U.y_wait(store, 2)
			show_intro_balloon(hero_2 or hero_1, "S08_INTRO_01", "_0001")
			U.y_wait(store, 2)
			show_intro_balloon(hero_1, "S08_INTRO_02", "_0002")
			U.y_wait(store, 1.5)
			signal.emit("pan-zoom-camera", 2, camera_end_position, 1.3)

			for _, hero in ipairs({hero_1, hero_2}) do
				if hero and hero.render and hero.render.sprites and hero.render.sprites[1] then
					hero.render.sprites[1].flip_x = true
				end
			end

			citizens_1_cont.trigger_run = true
			citizens_2_cont.trigger_run = true

			S:queue("Stage08ScaredCrowd")

			U.y_wait(store, 1)

			cont_phases.current_phase = 1

			U.y_wait(store, 1)

			signal.emit("hide-curtains")
			signal.emit("pan-zoom-camera", 2, camera_end_position, OVm(1, 1.3))
			signal.emit("show-gui")
			signal.emit("end-cinematic")
		else
			if store.level_mode_6 == GAME_MODE_CAMPAIGN then
				signal.emit("pan-zoom-camera", 0, camera_end_position, 1.3)
			end

			citizens_1_cont.trigger_run = true
			citizens_1_cont.restarted = true
			citizens_2_cont.trigger_run = true
			citizens_2_cont.restarted = true

			S:queue("Stage08ScaredCrowd")

			cont_phases.current_phase = 1
			cont_phases.restarted = true
		end

		while store.wave_group_number < 4 do
			coroutine.yield()
		end

		citizens_1_cont.trigger_end = true
		citizens_2_cont.trigger_end = true

		while store.wave_group_number < 5 do
			coroutine.yield()
		end

		set_terrain(blocked_cells_phase_1, bit.bor(TERRAIN_LAND))

		cont_phases.current_phase = 2

		local cont_tower_stun = E:create_entity("controller_stage_08_tower_stun")

		LU.queue_insert(store, cont_tower_stun)

		local strike_1 = E:create_entity("controller_stage_08_tower_stun_moment")

		strike_1.skip_goblin_anim = true

		LU.queue_insert(store, strike_1)
		U.y_wait(store, 0.7)

		local strike_2 = E:create_entity("controller_stage_08_tower_stun_moment")

		strike_2.skip_goblin_anim = true

		LU.queue_insert(store, strike_2)

		while store.wave_group_number < 15 do
			coroutine.yield()
		end

		S:stop_group("MUSIC")
		S:queue("MusicBossFight_8")

		local boss = E:create_entity("enemy_boss_stage_08")

		boss.nav_path.pi = 6
		boss.nav_path.spi = 3
		boss.nav_path.ni = 1
		boss.pos = P:node_pos(6, 3, 1)

		LU.queue_insert(store, boss)
		P:activate_path(6)
		P:add_invalid_range(6, 1)

		local function leave()
			return boss.enraged
		end

		local shake_camera = true
		local i = 1

		while not boss.enraged do
			U.y_wait(store, fts(37), leave)

			for j = 1, 4 do
				if shake_camera then
					local shake = E:create_entity("aura_screen_shake")

					shake.aura.amplitude = math.max(0.8 - i * 0.2, 0.2)
					shake.aura.duration = 0.2
					shake.aura.freq_factor = math.max(0.8 - i * 0.2, 0.1)

					LU.queue_insert(store, shake)
				end

				if boss.enraged then
					goto label_4_0
				end

				if j ~= 4 then
					U.y_wait(store, fts(56), leave)
				end
			end

			U.y_wait(store, fts(16), leave)

			if i == 4 then
				shake_camera = false
			end

			i = i + 1
		end

		::label_4_0::

		while not boss.triggered_explosion do
			coroutine.yield()
		end

		U.y_wait(store, fts(60))

		cont_phases.current_phase = 3
		boss.ready_to_get_up = true

		local cont_templars = E:create_entity("controller_stage_08_templar_swordsmen")

		cont_templars.path_id = boss.nav_path.pi

		LU.queue_insert(store, cont_templars)

		while not boss.health.dead do
			coroutine.yield()
		end

		signal.emit("boss_fight_end")
		U.y_wait(store, 1)
		signal.emit("acaroth-still-stands-stage08")
		U.y_wait(store, 3)

		if store.level_mode_6 == GAME_MODE_CAMPAIGN then
			store.custom_game_outcome = {
				postpone_unload = true,
				after_victory_screen = true,
				next_item_name = "level_258_end"
			}
		end
	else
		local cont_phases, citizens_1, citizens_2

		for k, v in pairs(store.entities) do
			if v.template_name == "controller_stage_08_phases" then
				cont_phases = v
			end

			if v.template_name == "decal_stage_08_citizens_1" then
				citizens_1 = v
			end

			if v.template_name == "decal_stage_08_citizens_2" then
				citizens_2 = v
			end

		end

		citizens_1.render.sprites[1].hidden = true
		citizens_2.render.sprites[1].hidden = true

		local cont_tower_stun = E:create_entity("controller_stage_08_tower_stun")

		LU.queue_insert(store, cont_tower_stun)

		while not store.waves_finished or LU.has_alive_enemies(store) do
			coroutine.yield()
		end
	end
end

return level

