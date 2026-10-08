local log = require("klua.log"):new("animations_UH")
local mod_utils = require("mod_utils")

local animations_UH = {}

function animations_UH.a1()
	mod_utils.a_db_reset({
		-- 波林
		hero_bolin_mine = {
			fps = 35
		},

		-- 电击手
		hero_voltaire_toss = {
			fps = 40
		},
	})
end

function animations_UH.a2()
	mod_utils.a_db_reset({
		-- 大法师
		hero_wizard_shoot = {
			fps = 40
		},
		hero_wizard_teleport_out = {
			fps = 40
		},
		hero_wizard_teleport_in = {
			fps = 40
		},
		hero_wizard_missile_start = {
			fps = 40
		},
		hero_wizard_disintegrate = {
			fps = 50
		},
		hero_wizard_twister = {
			prefix = "hero_mage",
			to = 202,
			from = 162
		},

		-- 螃蟹
		hero_crab_burrow_in = {
			fps = 35
		},
		hero_crab_burrow_out = {
			fps = 35
		},
		hero_crab_pincer = {
			fps = 35
		},
		hero_crab_cannon_start = {
			prefix = "hero_crabman",
			to = 88,
			from = 69,
			fps = 20
		},
		hero_crab_cannon_loop = {
			prefix = "hero_crabman",
			to = 110,
			from = 88,
			fps = 40
		},
		hero_crab_cannon_end = {
			prefix = "hero_crabman",
			to = 118,
			from = 110,
			fps = 15
		},

		-- 库绍
		hero_monk_dragon = {
			to = 325,
			from = 264,
			fps = 40
		},
		hero_monk_crane = {
			fps = 40
		},
		hero_monk_leopard_start = {
			fps = 40
		},
		hero_monk_leopard_hit1 = {
			fps = 40
		},
		hero_monk_leopard_hit2 = {
			fps = 40
		},
		hero_monk_leopard_hit3 = {
			fps = 40
		},
		hero_monk_leopard_hit4 = {
			fps = 40
		},
		hero_monk_leopard_end = {
			fps = 40
		},
	})
end

function animations_UH.a3()
	mod_utils.a_db_reset({
		-- 艾莉丹
		hero_elves_archer_walk = {
			fps = 26
		},
		hero_elves_archer_shoot = {
			fps = 34
		},
		hero_elves_archer_nimble_fencer = {
			fps = 40
		},

		-- 大瑞格
		hero_rag_layerX_shoot = {
			fps = 35
		},
		hero_rag_layerX_throw_bolso = {
			fps = 35
		},
		hero_rag_layerX_throw_anchor = {
			fps = 35
		},
		hero_rag_layerX_throw_fungus = {
			fps = 35
		},
		hero_rag_layerX_throw_pan = {
			fps = 35
		},
		hero_rag_layerX_throw_chair = {
			fps = 35
		},

		-- 莉恩
		hero_lynn_hexfury = {
			fps = 40
		},
		hero_lynn_teleport_out = {
			prefix = "lynn_hero",
			to = 187,
			from = 145,
			fps = 45
		},
		hero_lynn_curseOfDespair = {
			fps = 40
		},
		hero_lynn_weakeningCurse = {
			fps = 40
		},

		-- 堕天使
		hero_lilith_throw = {
			fps = 40
		},
	})
end

function animations_UH.a4()
	mod_utils.a_db_reset({
		-- 杰克
		hero_jack_o_lantern_teleportIn = {
			fps = 35
		},
		hero_jack_o_lantern_teleportOut = {
			fps = 35
		},
		hero_jack_o_lantern_attack = {
			fps = 35
		},
		hero_jack_o_lantern_hauntedBlade = {
			fps = 35
		},
		hero_jack_o_lantern_spawnGhouls = {
			fps = 35
		},
		hero_jack_o_lantern_explosiveHead = {
			fps = 35
		}
	})
end

function animations_UH.a5()
	mod_utils.a_db_reset({
		-- 维斯珀
		hero_vesper_vesper_melee_attack_1 = {
			fps = 35
		},
		hero_vesper_vesper_melee_attack_2 = {
			fps = 35
		},
		hero_vesper_vesper_ranged_attack = {
			fps = 37
		},
		hero_vesper_vesper_arrow_to_the_knee = {
			fps = 36
		},
		hero_vesper_vesper_ricochet = {
			fps = 40
		},
		hero_vesper_vesper_martial_flourish = {
			fps = 37
		},
		hero_vesper_vesper_disengage = {
			fts = 40
		},

		-- 毒液
		hero_venom_ultimate_attack = {
			to = 78,
			from = 40
		},
		hero_venom_hero_spikes_in = {
			fps = 35
		},
		hero_venom_hero_spikes_out = {
			fps = 35
		},

		-- 狮鹫
		gryph_character_stun = {
			fps = 45
		},

		-- 蛛后
		hero_spider_05_hero_teleport_in = {
			fps = 35
		},
		hero_spider_05_hero_teleport_out = {
			fps = 50
		},
		hero_spider_05_hero_ability1 = {
			fps = 38
		},
	})
end

return animations_UH
