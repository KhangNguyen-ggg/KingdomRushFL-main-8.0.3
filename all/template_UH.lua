local log = require("klua.log"):new("template_UH")
local bit = require("bit")
local bor = bit.bor
local E = require("entity_db")
local scripts = require("scripts")
local scripts4 = require("scripts_4")
local scripts5 = require("scripts_5")
local GS = require("game_settings")
local copy = table.deepclone
--local utils_UH = require("utils_UH")
--local hero_buy_template_set = utils_UH.hero_buy_template_set

local ok_rebbborn, scripts_rebbborn = pcall(require, "game_scripts-1-rebbborn")

if ok_rebbborn and scripts_rebbborn.hero_voltaire and not scripts4.hero_voltaire then
    scripts4.hero_voltaire = scripts_rebbborn.hero_voltaire
end

scripts4.hero_voltaire = scripts4.hero_voltaire or {}

require("constants")

local anchor_x, anchor_y = 0, 0
local image_x, image_y, tt = 0, 0, nil

local function T(name)
    return E:get_template(name)
end

local function fts(v)
    return v / FPS
end

local function d2r(d)
    return d * math.pi / 180
end

local function RT(name, ref)
    return E.entities[name] or E:register_t(name, ref)
end

local function AC(tpl, ...)
    return E:add_comps(tpl, ...)
end

local function CC(comp_name)
    return E:clone_c(comp_name)
end

local function hero_buy_template_set(t)
    if type(t) == "string" then
        local nt = string.gsub(t, "_2$", "")

        E.entities[t] = copy(T(nt))

        local hero = T(t).hero

        T(t).hero_insert = false
        hero.level = 10

        for _, v in pairs(hero.skills) do
            if v.xp_level_steps then
                v.xp_level_steps = {
                    [8] = 1,
                    [9] = 2,
                    [10] = 3
                }
            end
            if v.level then
                v.level = 3
            end
        end
    end

    return true
end

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end
local function vv(v1)
	return {
		x = v1,
		y = v1
	}
end
local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end
local function adx(v)
	return v - anchor_x * image_x
end
local function ady(v)
	return v - anchor_y * image_y
end
local function np(pi, spi, ni)
	return {
		dir = 1,
		pi = pi,
		spi = spi,
		ni = ni
	}
end
local function ST(name, t)
	return E:set_template(name, t)
end
local function tcopy(name, t)
	return ST(name, copy(T(t)))
end

local template_UH = {}

function template_UH:enhance1()
	-- 1. 爵士
	T("hero_gerald").hero.level_stats.regen_health = {
		40,
		42,
		44,
		46,
		48,
		50,
		52,
		54,
		56,
		58
	}

	T("hero_gerald").dodge.counter_attack.reflected_damage_factor = 1
	T("hero_gerald").motion.max_speed = 2.6 * FPS

	T("hero_gerald").melee.attacks[1].xp_gain_factor = 0.6

	T("mod_gerald_courage").courage.damage_min_inc = 5
	T("mod_gerald_courage").courage.damage_max_inc = 5
	T("mod_gerald_courage").courage.magic_armor_inc = 0.05
	T("mod_gerald_courage").modifier.duration = 8

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_gerald_2")
	end

	-- 2. 小公主
	T("hero_alleria").hero.level_stats.regen_health = {
		25,
		27,
		29,
		31,
		33,
		35,
		37,
		39,
		41,
		43
	}

	T("hero_alleria").motion.max_speed = 3.5 * FPS

	T("hero_alleria").melee.range = 25
	T("hero_alleria").melee.attacks[1].xp_gain_factor = 0.6

	T("hero_alleria").ranged.attacks[1].cooldown = 0.5
	T("g1_arrow_hero_alleria").bullet.xp_gain_factor = 0.4
	T("hero_alleria").hero.level_stats.ranged_damage_max = {
		18,
		21,
		24,
		27,
		30,
		33,
		36,
		38,
		39,
		41
	}
	T("hero_alleria").hero.level_stats.ranged_damage_min = {
		13,
		15,
		17,
		19,
		22,
		25,
		28,
		30,
		32,
		33
	}
	T("hero_alleria").ranged.attacks[1].max_range = 170

	T("hero_alleria").ranged.attacks[2].cooldown = 3
	T("hero_alleria").hero.skills.multishot.count_base = 5 -- 初始增加箭矢
	T("hero_alleria").hero.skills.multishot.count_inc = 3 -- 增加箭矢数量=等级乘这个数
	T("g1_arrow_multishot_hero_alleria").bullet.xp_gain_factor = 0.4
	T("g1_arrow_multishot_hero_alleria").bullet.damage_type = DAMAGE_MAGICAL

	T("hero_alleria").timed_attacks.list[1].cooldown = 8
	T("soldier_alleria_wildcat").melee.attacks[1].mod = "mod_alleria_wildcat_poison"
	tt = RT("mod_alleria_wildcat_poison", "mod_poison")
	tt.modifier.duration = 30
	tt.dps.damage_max = 2
	tt.dps.damage_min = 2
	tt.dps.damage_every = fts(5)

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_alleria_2")
	end

	-- 3. 大锤
	T("hero_malik").main_script.update = scripts.hero_malik.update

	T("hero_malik").hero.level_stats.regen_health = {
		45,
		48,
		51,
		54,
		58,
		61,
		64,
		68,
		71,
		75
	}

	T("hero_malik").motion.max_speed = 2.5 * FPS

	T("hero_malik").melee.attacks[1].xp_gain_factor = 0.4
	T("hero_malik").melee.attacks[1].mod = "mod_malik_stun_melee"

	T("hero_malik").melee.attacks[3].cooldown = 3
	T("hero_malik").melee.attacks[3].min_count = 1
	T("hero_malik").melee.attacks[3].mod = "mod_malik_stun_short"

	T("hero_malik").melee.attacks[4].cooldown = 15
	T("hero_malik").hero.skills.fissure.damage_min = {
		20,
		40,
		60
	}
	T("hero_malik").hero.skills.fissure.damage_max = {
		40,
		60,
		80
	}
	T("mod_malik_stun").modifier.duration = 4
	T("aura_malik_fissure").aura.spread_nodes = 6

	AC(T("hero_malik"), "timed_attacks")
	T("hero_malik").timed_attacks.list[1] = CC("spawn_attack")
	T("hero_malik").timed_attacks.list[1].animation = "fissure"
	T("hero_malik").timed_attacks.list[1].cooldown = 15
	T("hero_malik").timed_attacks.list[1].entity = "tower_holder_grass"
	T("hero_malik").timed_attacks.list[1].spawn_time = fts(17)
	T("hero_malik").timed_attacks.list[1].fx = "decal_malik_earthquake"
	T("hero_malik").timed_attacks.list[1].sound = "HeroReinforcementJump"
	tt = RT("mod_malik_stun_short", "mod_stun")
	tt.modifier.vis_flags = bor(F_MOD, F_STUN)
	tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
	tt.modifier.duration = 1
	tt = RT("mod_malik_stun_melee", "mod_stun")
	tt.modifier.vis_flags = bor(F_MOD, F_STUN)
	tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
	tt.modifier.duration = 0.75

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_malik_2")
	end

	-- 4. 波林
	T("hero_bolin").hero.fn_level_up = scripts.hero_bolin.level_up
	T("hero_bolin").main_script.update = scripts.hero_bolin.update

	T("hero_bolin").hero.level_stats.regen_health = {
		40,
		43,
		46,
		50,
		53,
		56,
		60,
		63,
		66,
		70
	}

	T("hero_bolin").motion.max_speed = 2.5 * FPS

	T("hero_bolin").melee.range = 30
	T("hero_bolin").melee.attacks[1].xp_gain_factor = 0.6

	T("hero_bolin").timed_attacks.list[1].cooldown = 3
	T("hero_bolin").timed_attacks.list[1].shoot_times = {
		fts(8),
		fts(6),
		fts(6),
		fts(6),
		fts(6),
		fts(6),
		fts(6),
		fts(6),
	}
	T("shotgun_bolin").bullet.xp_gain_factor = 0.3
	T("shotgun_bolin").bullet.damage_type = DAMAGE_EXPLOSION

	T("hero_bolin").timed_attacks.list[3].count = 30
	T("hero_bolin").timed_attacks.list[3].cooldown = 4
	T("hero_bolin").timed_attacks.list[3].shoot_time = fts(2.5)
	T("decal_bolin_mine").duration = 150
	T("decal_bolin_mine").radius = 35

	T("hero_bolin").hero.skills.tar.duration = {
		30,
		50,
		70
	}
	T("aura_bolin_tar").aura.duration = 30
	T("mod_bolin_slow").slow.factor = 0.65

	T("hero_bolin").hero.skills.grenade = CC("hero_skill")
	T("hero_bolin").hero.skills.grenade.xp_level_steps = {
		nil,
		1,
		1,
		1,
		2,
		2,
		2,
		3,
		3,
		3
	}
	T("hero_bolin").hero.skills.grenade.xp_gain = {
		25,
		50,
		75
	}
	T("hero_bolin").hero.skills.grenade.damage_min = {
		20,
		30,
		40
	}
	T("hero_bolin").hero.skills.grenade.damage_max = {
		40,
		50,
		60
	}
	T("hero_bolin").timed_attacks.list[4] = copy(T("hero_bolin").timed_attacks.list[3])
	T("hero_bolin").timed_attacks.list[4].bullet = "grenade_bolin"
	T("hero_bolin").timed_attacks.list[4].cooldown = 5
	T("hero_bolin").timed_attacks.list[4].disabled = true
	T("hero_bolin").timed_attacks.list[4].max_range = 130
	T("hero_bolin").timed_attacks.list[4].node_offset = {
		-12,
		12
	}
	T("hero_bolin").timed_attacks.list[4].vis_bans = F_FLYING
	T("hero_bolin").timed_attacks.list[4].vis_flags = F_RANGED
	tt = RT("grenade_bolin", "bomb_mine_bolin")
	tt.bullet.damage_bans = 0
	tt.bullet.damage_flags = F_RANGED
	tt.bullet.damage_max = nil
	tt.bullet.damage_min = nil
	tt.bullet.damage_radius = 55
	tt.bullet.flight_time = fts(24)
	tt.bullet.hit_payload = nil
	tt.bullet.hit_fx = "fx_explosion_small"
	tt.bullet.hit_decal = "decal_bomb_crater"
	tt.bullet.hit_fx_water = "fx_explosion_water"

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_bolin_2")
	end

	-- 5. 小马哥
	T("hero_magnus").hero.fn_level_up = scripts.hero_magnus.level_up
	T("hero_magnus").main_script.update = scripts.hero_magnus.update

	T("hero_magnus").hero.level_stats.regen_health = {
		17,
		20,
		22,
		24,
		26,
		28,
		30,
		32,
		35,
		37
	}

	T("hero_magnus").teleport.min_distance = 45

	T("hero_magnus").melee.range = 25
	T("hero_magnus").melee.attacks[1].xp_gain_factor = 0.5
	T("hero_magnus").melee.attacks[2] = copy(T("hero_magnus").melee.attacks[1])
	T("hero_magnus").melee.attacks[2].chance = 0.5
	T("hero_magnus").melee.attacks[2].mod = "mod_teleport_hero_magnus"
	tt = RT("mod_teleport_hero_magnus", "mod_teleport_mage")
	tt.nodes_offset = -15

	T("hero_magnus").ranged.attacks[1].min_range = 0
	T("bolt_magnus").bullet.xp_gain_factor = 0.41

	T("bolt_magnus_illusion").render.sprites[1].alpha = 180
	T("soldier_magnus_illusion").reinforcement.duration = 20
	T("hero_magnus").hero.skills.mirage.health_factor = 0.3
	T("hero_magnus").hero.skills.mirage.damage_factor = 0.3
	T("soldier_magnus_illusion").melee.range = 0
	T("hero_magnus").timed_attacks.list[1].rotation_angle = d2r(60)

	T("hero_magnus").hero.skills.mirage_big = CC("hero_skill")
	T("hero_magnus").hero.skills.mirage_big.count = {
		1,
		1,
		1
	}
	T("hero_magnus").hero.skills.mirage_big.health_factor = 0.5
	T("hero_magnus").hero.skills.mirage_big.damage_factor = 0.5
	T("hero_magnus").hero.skills.mirage_big.xp_level_steps = {
		nil,
		1,
		nil,
		nil,
		2,
		nil,
		nil,
		3,
		---
		[3] = 1,
		[4] = 1,
		[6] = 2,
		[7] = 2,
		[9] = 3,
		[10] = 3
	}
	T("hero_magnus").hero.skills.mirage_big_arcane_rain = CC("hero_skill")
	T("hero_magnus").hero.skills.mirage_big_arcane_rain.count = {
		6,
		12,
		18
	}
	T("hero_magnus").hero.skills.mirage_big_arcane_rain.damage = {
		10,
		10,
		10
	}
	T("hero_magnus").timed_attacks.list[3] = copy(T("hero_magnus").timed_attacks.list[1])
	T("hero_magnus").timed_attacks.list[3].entity = "soldier_magnus_illusion_big"
	tt = RT("soldier_magnus_illusion_big", "soldier_magnus_illusion")
	AC(tt, "timed_attacks", "render")
	anchor_x, anchor_y = 0.5, 0.14
	tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
	tt.render.sprites[1].name = "raise"
	tt.render.sprites[1].alpha = 180
	tt.render.sprites[1].prefix = "hero_magnus"
	tt.render.sprites[1].scale = vv(1.25)
	tt.render.sprites[1].angles = {}
	tt.render.sprites[1].angles.walk = {
		"running"
	}
	tt.main_script.update = scripts.soldier_magnus_illusion_big.update
	tt.melee.range = 10
	tt.ranged.attacks[1].bullet = "bolt_magnus_illusion_big"
	tt.ranged.attacks[1].bullet_start_offset = {
		v(0, 28.75)
	}
	tt.timed_attacks.list[1] = CC("spawn_attack")
	tt.timed_attacks.list[1].animation = "arcaneRain"
	tt.timed_attacks.list[1].entity = "magnus_arcane_rain_controller_big"
	tt.timed_attacks.list[1].cooldown = 14 + fts(25)
	tt.timed_attacks.list[1].cast_time = fts(15)
	tt.timed_attacks.list[1].disabled = true
	tt.timed_attacks.list[1].max_range = 200
	tt.timed_attacks.list[1].min_range = 50
	tt.timed_attacks.list[1].sound = "HeroMageRainCharge"
	tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND, F_FLYING)
	tt.timed_attacks.list[1].vis_flags = F_RANGED
	tt = RT("bolt_magnus_illusion_big", "bolt_magnus_illusion")
	tt = RT("magnus_arcane_rain_controller_big", "magnus_arcane_rain_controller")
	tt.render.sprites[1].alpha = 100
	tt.entity = "magnus_arcane_rain_big"
	tt = RT("magnus_arcane_rain_big", "magnus_arcane_rain")
	tt.render.sprites[1].alpha = 100

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_magnus_2")
	end

	-- 6. 火男
	T("hero_ignus").main_script.update = scripts.hero_ignus.update

	T("hero_ignus").hero.level_stats.regen_health = {
		38,
		40,
		45,
		47,
		49,
		52,
		54,
		55,
		57,
		60
	}
	T("hero_ignus").hero.level_stats.hp_max = {
		380,
		400,
		450,
		470,
		490,
		520,
		540,
		550,
		570,
		600
	}

	T("hero_ignus").motion.max_speed = 3.4 * FPS

	T("hero_ignus").melee.attacks[1].xp_gain_factor = 0.4
	T("hero_ignus").melee.attacks[1].mod = "mod_lava_ignus"

	T("hero_ignus").timed_attacks.list[1].mod = "mod_lava_ignus"

	T("hero_ignus").timed_attacks.list[2].max_range = 170
	T("aura_ignus_surge_of_flame").main_script.update = scripts.aura_ignus_surge_of_flame.update
	T("aura_ignus_surge_of_flame").aura.mod = "mod_lava_ignus"
	T("aura_ignus_surge_of_flame").aura.radius = 30

	tt = RT("mod_lava_ignus", "mod_lava")
	tt.dps.damage_inc = 2

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_ignus_2")
	end

	-- 7. 迪纳斯
	T("hero_denas").hero.level_stats.regen_health = {
		30,
		32,
		34,
		36,
		38,
		40,
		42,
		44,
		46,
		48
	}

	T("hero_denas").main_script.insert = scripts.hero_denas.insert

	T("hero_denas").melee.range = 10
	T("projectile_denas_melee").bullet.xp_gain_factor = 0.5

	T("projectile_denas").bullet.xp_gain_factor = 0.5

	tcopy("projectile_denas_barrell", "projectile_denas")
	tcopy("projectile_denas_chicken", "projectile_denas")
	tcopy("projectile_denas_bottle", "projectile_denas")
	tcopy("projectile_denas_melee_barrell", "projectile_denas")
	tcopy("projectile_denas_melee_chicken", "projectile_denas")
	tcopy("projectile_denas_melee_bottle", "projectile_denas")

	T("hero_denas").hero.skills.catapult.count = {
		6,
		10,
		14
	}
	T("denas_catapult_controller").angle_increment = d2r(30)

	T("hero_denas").hero.skills.tower_buff.duration = {
		8,
		13,
		17
	}
	T("hero_denas").timed_attacks.list[2].max_range = 180
	T("hero_denas").timed_attacks.list[2].cooldown = 9
	T("mod_denas_tower").range_factor = 1.25
	T("mod_denas_tower").cooldown_factor = 0.75

	T("hero_denas").sale = 20

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_denas_2")
	end

	-- 8. 冰女
	T("hero_elora").hero.level_stats.armor = {
		0,
		0,
		0.1,
		0.1,
		0.1,
		0.2,
		0.2,
		0.2,
		0.3,
		0.3
	}
	T("hero_elora").hero.level_stats.regen_health = {
		27,
		29,
		31,
		34,
		36,
		38,
		40,
		42,
		44,
		47
	}

	T("hero_elora").melee.range = 30
	T("hero_elora").melee.attacks[1].xp_gain_factor = 0.4
	T("hero_elora").melee.attacks[1].mod = "mod_elora_melee_freeze"
	tt = RT("mod_elora_melee_freeze", "mod_elora_bolt_freeze")
	tt.modifier.duration = 0.75
	tt.modifier.vis_bans = bor(F_BOSS, F_MINIBOSS)

	T("hero_elora").ranged.attacks[1].cooldown = 1.65
	T("bolt_elora_freeze").bullet.xp_gain_factor = 0.4

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_elora_2")
	end

	-- 9. 熊人
	T("hero_ingvar").hero.level_stats.regen_health = {
		43,
		46,
		50,
		53,
		56,
		59,
		63,
		66,
		69,
		73
	}

	T("hero_ingvar").melee.attacks[1] = CC("area_attack")
	T("hero_ingvar").melee.attacks[1].cooldown = 1.5
	T("hero_ingvar").melee.attacks[1].damage_radius = 25
	T("hero_ingvar").melee.attacks[1].damage_type = DAMAGE_PHYSICAL
	T("hero_ingvar").melee.attacks[1].hit_time = fts(12)
	T("hero_ingvar").melee.attacks[1].sound_hit = "HeroVikingAttackHit"
	T("hero_ingvar").melee.attacks[1].hit_decal = "decal_ingvar_attack"
	T("hero_ingvar").melee.attacks[1].hit_offset = v(48, -1)
	T("hero_ingvar").melee.attacks[1].shared_cooldown = true
	T("hero_ingvar").melee.attacks[1].xp_gain_factor = 0.18

	T("hero_ingvar").melee.attacks[2] = copy(T("hero_ingvar").melee.attacks[1])
	T("hero_ingvar").melee.attacks[2].animation = "attack2"
	T("hero_ingvar").melee.attacks[2].chance = 0.5
	T("hero_ingvar").melee.attacks[2].hit_time = fts(20)
	T("hero_ingvar").melee.attacks[2].hit_offset = v(0, 2)
	T("hero_ingvar").melee.attacks[2].damage_radius = 40
	T("hero_ingvar").melee.attacks[2].min_count = 3
	T("hero_ingvar").melee.attacks[2].xp_gain_factor = 0.13

	T("hero_ingvar").hero.skills.ancestors_call.count = {
		2,
		3,
		4
	}
	T("soldier_ingvar_ancestor").reinforcement.duration = 15

	T("hero_ingvar").melee.attacks[3].damage_type = DAMAGE_TRUE
	T("hero_ingvar").melee.attacks[3].hit_times = {
		fts(10),
		fts(13),
		fts(15),
		fts(17),
		fts(21),
	}
	T("hero_ingvar").timed_attacks.list[2].transform_health_factor = 0.25

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_ingvar_2")
	end

	-- 10. 钢锯
	T("hero_hacksaw").hero.level_stats.armor = {
		0.4,
		0.4,
		0.4,
		0.5,
		0.5,
		0.5,
		0.6,
		0.6,
		0.6,
		0.65
	}
	T("hero_hacksaw").hero.level_stats.regen_health = {
		42,
		44,
		46,
		48,
		51,
		53,
		55,
		57,
		60,
		62
	}

	T("hero_hacksaw").motion.max_speed = 2.3 * FPS

	T("hero_hacksaw").melee.attacks[1].xp_gain_factor = 0.5

	T("hero_hacksaw").hero.skills.sawblade.bounces = {
		5,
		7,
		10
	}

	T("hero_hacksaw").hero.skills.timber.cooldown = {
		30,
		26,
		22
	}
	T("hero_hacksaw").melee.attacks[2].trigger_min_hp = 300
	T("hero_hacksaw").melee.attacks[2].fn_can = scripts.hero_hacksaw.fn_can_timber

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_hacksaw_2")
	end

	-- 11. 鬼侍
	T("hero_oni").hero.level_stats.regen_health = {
		42,
		45,
		47,
		50,
		52,
		55,
		57,
		60,
		62,
		65
	}

	T("hero_oni").melee.attacks[1].xp_gain_factor = 0.5

	T("hero_oni").timed_attacks.list[1].cooldown = 10 + fts(48)
	T("hero_oni").timed_attacks.list[1].torment_swords = {
		{
			0.01,
			20,
			8
		},
		{
			0.2,
			37.5,
			8
		},
		{
			0.3,
			55,
			8
		},
		{
			0.4,
			72.5,
			8
		}
	}

	T("hero_oni").hero.skills.death_strike.damage = {
		230,
		310,
		400
	}
	T("hero_oni").hero.skills.death_strike.chance = {
		0.25,
		0.35,
		1
	}
	T("hero_oni").melee.attacks[2].trigger_instakill_max_hp = 2000
	T("hero_oni").melee.attacks[2].trigger_min_hp = 150
	T("hero_oni").melee.attacks[2].fn_can = scripts.hero_oni.fn_can_death_strike_instakill
	T("hero_oni").melee.attacks[3].trigger_min_hp = 150
	T("hero_oni").melee.attacks[3].fn_can = scripts.hero_oni.fn_can_death_strike

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_oni_2")
	end

	-- 12. 雷神
	T("hero_thor").hero.level_stats.regen_health = {
		38,
		41,
		45,
		48,
		51,
		54,
		58,
		61,
		64,
		68
	}

	T("hero_thor").melee.attacks[1].xp_gain_factor = 0.4
	T("hero_thor").melee.cooldown = 1

	T("mod_hero_thor_chainlightning").chainlightning.damage = 80

	T("mod_hero_thor_thunderclap").thunderclap.secondary_damage_type = DAMAGE_TRUE
	T("hero_thor").hero.skills.thunderclap.stun_duration = {
		5,
		6,
		7.3
	}

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_thor_2")
	end

	-- 13. 天十
	T("hero_10yr").hero.level_stats.armor = {
		0,
		0.1,
		0.1,
		0.1,
		0.2,
		0.2,
		0.2,
		0.3,
		0.3,
		0.38
	}
	T("hero_10yr").hero.level_stats.regen_health_normal = {
		38,
		40,
		42,
		44,
		47,
		49,
		51,
		53,
		55,
		57
	}

	T("hero_10yr").teleport.min_distance = 45

	T("hero_10yr").melee.attacks[1].xp_gain_factor = 0.5

	T("hero_10yr").motion.max_speed_buffed = 2.8 * FPS

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_10yr_2")
	end

	-- 14. 毒蛇
	T("hero_viper").melee.attacks[1].xp_gain_factor = 0.7

	T("hero_viper").ranged.attacks[1].cooldown = 3

	T("hero_viper").hero.skills.curse.cooldown = {
		12,
		10,
		8
	}

	AC(T("hero_viper"), "dodge")
	T("hero_viper").dodge.silent = true
	T("hero_viper").dodge.chance = 0.25

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_viper_2")
	end

	-- 15. 电击手
	T("hero_voltaire").hero.fn_level_up = scripts4.hero_voltaire.level_up
	T("hero_voltaire").health.armor = 0.3
	T("hero_voltaire").hero.level_stats.regen_health = {
		27,
		30,
		32,
		35,
		37,
		40,
		42,
		45,
		47,
		50
	}
	T("hero_voltaire").motion.max_speed = FPS * 2.5

	T("hero_voltaire").ranged.attacks[1].shoot_time = fts(19)
	T("hero_voltaire").ranged.attacks[2] = copy(T("hero_voltaire").ranged.attacks[1])
	T("hero_voltaire").ranged.attacks[2].bullet = "b_volt_2"
	T("hero_voltaire").ranged.attacks[2].cooldown = 6
	tt = RT("b_volt_2", "b_volt")
	tt.bullet.damage_min = 30
	tt.bullet.damage_max = 40
	tt.bullet.damage_radius = 75
	tt.bullet.mod = "mod_stun_volt_2"
	tt.bullet.hit_fx = "fx_b_volt_hit_2"
	tt.render.sprites[1].shader = "p_tint"
	tt.render.sprites[1].shader_args = {
		tint_factor = 0.4,
		tint_color = {
			0,
			0.85,
			1,
			1
		}
	}
	tt = RT("mod_stun_volt_2", "mod_stun_volt")
	tt.modifier.duration = 2
	tt = RT("fx_b_volt_hit_2", "fx_b_volt_hit")
	tt.render.sprites[1].shader = "p_tint"
	tt.render.sprites[1].shader_args = {
		tint_factor = 0.4,
		tint_color = {
			0,
			0.85,
			1,
			1
		}
	}

	T("hero_voltaire").melee.attacks[1].xp_gain_factor = 0.7

	if T("tower_hero_buy_b") then
		hero_buy_template_set("hero_voltaire_2")
	end
end

function template_UH:enhance2()
	-- 1. 沙王
	T("hero_alric").main_script.insert = scripts.hero_alric.insert
	T("hero_alric").hero.fn_level_up = scripts.hero_alric.level_up

	T("hero_alric").motion.max_speed = 2.5 * FPS

	T("hero_alric").timed_attacks.list[1].range_nodes = 999
	T("hero_alric").hero.skills.sandwarriors.lifespan = {
		11,
		13,
		15
	}

	tt = RT("death_rider_aura_alric", "death_rider_aura")
	tt.aura.use_mod_offset = nil

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_alric_2")
	end

	-- 2. 幻影
	T("hero_mirage").melee.range = 100

	T("hero_mirage").melee.attacks[1].mod = "mod_mirage_poison"
	T("bullet_mirage").bullet.mod = "mod_mirage_poison"

	T("hero_mirage").hero.skills.shadowdodge.dodge_chance = {
		0.4,
		0.6,
		0.8
	}
	T("soldier_mirage_illusion").lifespan.duration = 2
	T("soldier_mirage_illusion").melee.attacks[1].mod = "mod_mirage_poison"
	tt = RT("mod_mirage_poison", "mod_poison")
	tt.modifier.duration = 2
	tt.dps.damage_max = 3
	tt.dps.damage_min = 3
	tt.dps.damage_every = fts(5)

	T("hero_mirage").hero.skills.swiftness.max_speed_factor = {
		1.4,
		1.8,
		2
	}

	T("hero_mirage").timed_attacks.list[1].cooldown = 4

	T("hero_mirage").hero.skills.lethalstrike.instakill_chance = {
		0.4,
		0.7,
		0.9
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_mirage_2")
	end

	-- 3. 船长
	T("hero_pirate").hero.fn_level_up = scripts.hero_pirate.level_up

	T("hero_pirate").motion.max_speed = 3 * FPS
	T("hero_pirate").hero.level_stats.armor = {
		0.01,
		0.06,
		0.11,
		0.17,
		0.22,
		0.26,
		0.31,
		0.33,
		0.37,
		0.42
	}

	T("hero_pirate").melee.attacks[1].mod = "mod_pirate_loot_c"

	T("hero_pirate").pickpocket.chance = 1
	T("hero_pirate").pickpocket.steal_max = 6
	T("hero_pirate").pickpocket.steal_min = 4

	T("pirate_loot_aura").aura.radius = 200
	AC(T("mod_pirate_loot"), "render")
	T("mod_pirate_loot").render.sprites[1].name = "NecromancerSkeletonAura"
	T("mod_pirate_loot").render.sprites[1].animated = false
	T("mod_pirate_loot").render.sprites[1].z = Z_DECALS
	T("mod_pirate_loot").modifier.use_mod_offset = false
	T("mod_pirate_loot").main_script.update = scripts.mod_pirate_loot.update
	T("mod_pirate_loot").main_script.remove = scripts.mod_pirate_loot.remove

	T("hero_pirate").hero.skills.looting.mod_extra_gold = {
		1,
		1.5,
		2
	}
	tt = RT("mod_pirate_loot_c", "mod_pirate_loot")
	AC(tt, "render")
	tt.extra_gold = 1
	tt.render.sprites[1].name = "NecromancerSkeletonAura"
	tt.render.sprites[1].animated = false
	tt.render.sprites[1].z = Z_DECALS
	tt.modifier.use_mod_offset = false
	tt.main_script.insert = scripts.mod_pirate_loot_c.insert
	tt.main_script.update = scripts.mod_pirate_loot_c.update

	T("hero_pirate").hero.skills.scattershot.fragments = {
		7,
		11,
		15
	}
	T("barrel_fragment").bullet.mod = "mod_pirate_loot_c"

	T("hero_pirate").timed_attacks.list[1].cooldown = 13
	T("kraken_aura").aura.mods = {
		"mod_stun_kraken",
		"mod_pirate_loot_c"
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_pirate_2")
	end

	-- 4. 兽王
	T("hero_beastmaster").hero.level_stats.armor = {
		0,
		0.1,
		0.1,
		0.2,
		0.2,
		0.25,
		0.25,
		0.3,
		0.35,
		0.35
	}

	T("hero_beastmaster").melee.attacks[1].mod = "mod_beastmaster_lash"

	T("hero_beastmaster").timed_attacks.list[2].cooldown = 10
	T("hero_beastmaster").hero.skills.boarmaster.boars = {
		1,
		1,
		2
	}
	T("beastmaster_boar").melee.attacks[1].cooldown = 1
	T("beastmaster_boar").melee.attacks[1].damage_max = 10
	T("beastmaster_boar").melee.attacks[1].damage_min = 0
	T("beastmaster_boar").melee.attacks[1].mod = "mod_beastmaster_lash"

	T("hero_beastmaster").hero.skills.stampede.duration = {
		30,
		30,
		30
	}
	T("hero_beastmaster").timed_attacks.list[1].range_nodes_max = 999
	T("hero_beastmaster").hero.skills.stampede.stun_chance = {
		0.5,
		0.75,
		1
	}

	T("hero_beastmaster").hero.skills.falconer.max_range = {
		110,
		220,
		400
	}
	T("beastmaster_falcon").custom_attack.mod = "mod_beastmaster_lash"
	T("beastmaster_falcon").main_script.update = scripts.beastmaster_falcon.update

	T("hero_beastmaster").hero.skills.deeplashes.damage = {
		30,
		40,
		50
	}
	T("hero_beastmaster").melee.attacks[2].cooldown = 2

	T("mod_beastmaster_lash").modifier.duration = 6

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_beastmaster_2")
	end

	-- 5. 女巫
	T("hero_voodoo_witch").hero.skills.bonedance.skull_count = {
		4,
		5,
		6
	}

	T("voodoo_witch_death_aura").aura.radius = 140
	T("voodoo_witch_death_aura").aura.damage = 3

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_voodoo_witch_2")
	end

	-- 6. 大法师
	T("hero_wizard").hero.fn_level_up = scripts.hero_wizard.level_up
	T("hero_wizard").main_script.update = scripts.hero_wizard.update

	T("hero_wizard").teleport.min_distance = 75

	T("hero_wizard").melee.range = 10

	T("hero_wizard").ranged.attacks[1].shoot_time = fts(14.25)

	T("hero_wizard").hero.skills.magicmissile.count = {
		6,
		10,
		14
	}
	T("hero_wizard").timed_attacks.list[2].shoot_times = {
		fts(2)
	}

	T("hero_wizard").ranged.attacks[2].shoot_time = fts(14.25)
	T("hero_wizard").ranged.attacks[2].cooldown = 4
	T("hero_wizard").hero.skills.arcanefocus.extra_damage = {
		4,
		12,
		24
	}

	T("hero_wizard").timed_attacks.list[1].cooldown = 4

	T("hero_wizard").hero.skills.disintegrate.total_damage = {
		40,
		50,
		75
	}
	T("hero_wizard").timed_attacks.list[1].max_range = 190
	T("hero_wizard").timed_attacks.list[1].damage_radius = 190
	T("hero_wizard").timed_attacks.list[1].hit_time = fts(11.25)
	T("hero_wizard").hero.skills.disintegrate.twister_enemies_max = {
		4,
		5,
		6
	}
	T("hero_wizard").timed_attacks.list[3] = CC("spawn_attack")
	T("hero_wizard").timed_attacks.list[3].entity = "twister_hero_wizard"
	T("hero_wizard").timed_attacks.list[3].cooldown = 15
	T("hero_wizard").timed_attacks.list[3].spawn_time = fts(11.25)
	T("hero_wizard").timed_attacks.list[3].animation = "twister"
	T("hero_wizard").timed_attacks.list[1].sound = "HeroWizardDesintegrate"
	T("hero_wizard").timed_attacks.list[3].vis_flags = bor(F_RANGED, F_TWISTER)
	T("hero_wizard").timed_attacks.list[3].vis_bans = bor(F_CLIFF, F_BOSS)
	T("hero_wizard").timed_attacks.list[3].min_range = 0
	T("hero_wizard").timed_attacks.list[3].max_range = 190
	T("hero_wizard").timed_attacks.list[3].disabled = true
	T("hero_wizard").timed_attacks.list[3].node_prediction = fts(15)
	tt = RT("twister_hero_wizard", "twister")
	tt.motion.max_speed = 23.04
	tt.aura.level = 0
	tt.damage_min = 50
	tt.damage_max = 50

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_wizard_2")
	end

	-- 7. 女祭司
	T("hero_priest").melee.attacks[1].xp_gain_factor = 1.7

	T("bolt_priest").bullet.xp_gain_factor = 1.5

	T("hero_priest").hero.skills.consecrate.duration = {
		10,
		20,
		30
	}

	T("hero_priest").teleport.min_distance = 0

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_priest_2")
	end

	-- 8. 石头人
	T("hero_giant").render.sprites[1].scale = vv(1.15)

	T("hero_giant").hero.level_stats.regen_health = {
		44,
		46,
		49,
		52,
		55,
		58,
		61,
		64,
		67,
		70
	}

	T("hero_giant").melee.range = 85

	T("giant_boulder").render.sprites[1].scale = size_scales
	T("hero_giant").ranged.attacks[1].max_range = 400
	T("hero_giant").hero.skills.boulderthrow.damage_min = {
		60,
		120,
		180
	}
	T("hero_giant").hero.skills.boulderthrow.damage_max = {
		120,
		180,
		300
	}

	T("hero_giant").hero.skills.stomp.loops = {
		3,
		4,
		5
	}

	T("hero_giant").hero.skills.bastion.max_damage = {
		6,
		12,
		18
	}

	T("hero_giant").hero.skills.bastion.max_damage = {
		12,
		18,
		24
	}

	T("hero_giant").hero.skills.massivedamage.chance = {
		1,
		1,
		1
	}
	T("hero_giant").hero.skills.massivedamage.extra_damage = {
		100,
		180,
		240
	}

	T("hero_giant").hero.skills.hardrock.extra_hp = {
		100,
		200,
		400
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_giant_2")
	end

	-- 9. 沙塔
	T("hero_alien").hero.fn_level_up = scripts.hero_alien.level_up
	T("hero_alien").main_script.insert = scripts.hero_alien.insert
	T("hero_alien").main_script.update = scripts.hero_alien.update

	T("hero_alien").health.dead_lifetime = 10

	T("hero_alien").hero.level_stats.hp_max = {
		100,
		110,
		120,
		130,
		140,
		150,
		160,
		170,
		180,
		190
	}

	T("hero_alien").hero.skills.energyglaive.bounce_chance = {
		0.7,
		0.8,
		0.85
	}

	T("hero_alien").hero.skills.purificationprotocol.damage = {
		2,
		4,
		4.5
	}
	AC(T("hero_alien"), "auras")
	T("hero_alien").auras.list[1] = CC("aura_attack")
	T("hero_alien").auras.list[1].aura = "alien_purification_drone_cursor_aura"
	tt = RT("alien_purification_drone_cursor_aura", "decal_scripted")
	AC(tt, "aura", "sound_events")
	tt.render.sprites[1].name = "alien_drone_attack_beam"
	tt.render.sprites[1].hidden = true
	tt.render.sprites[1].anchor.y = 0.08
	tt.render.sprites[2] = CC("sprite")
	tt.render.sprites[2].prefix = "alien_drone"
	tt.render.sprites[2].name = "appear_long"
	tt.render.sprites[2].anchor.y = 0.08
	tt.render.sprites[3] = CC("sprite")
	tt.render.sprites[3].name = "alien_drone_attack_decal"
	tt.render.sprites[3].hidden = true
	tt.render.sprites[3].anchor.y = 0.17
	for i = 1, 3 do
		tt.render.sprites[i].shader = "p_tint"
		tt.render.sprites[i].shader_args = {
			tint_color = {
				0.8,
				0,
				1,
				1
			}
		}
	end
	tt.sound_events.insert = "HeroAlienDrone"
	tt.sound_events.finish = "HeroAlienDroneLeave"
	tt.sound_events.loop = "HeroAlienDroneLoop"
	tt.main_script.update = scripts.alien_purification_drone_cursor_aura.update
	tt.aura.vis_flags = bor(F_RANGED)
	tt.aura.radius = 25
	tt.aura.cycle_time = 0.1
	tt.aura.damage_type = DAMAGE_TRUE
	tt.aura.damage = nil

	T("alien_abduction_ship").main_script.update = scripts.alien_abduction_ship.update
	T("alien_abduction_ship").render.sprites[3].offset.y = 0
	T("alien_abduction_ship").render.sprites[3].scale = vv(2)
	T("hero_alien").timed_attacks.list[1].cooldown = 40
	T("hero_alien").timed_attacks.list[1].attack_radius = 66

	T("hero_alien").hero.skills.finalcountdown.damage = {
		150,
		200,
		300
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_alien_2")
	end

	-- 10. 火龙
	T("hero_dragon").hero.fn_level_up = scripts.hero_dragon.level_up
	T("hero_dragon").main_script.update = scripts.hero_dragon.update

	T("hero_dragon").motion.max_speed = 3.3 * FPS

	T("hero_dragon").ranged.attacks[1].max_range = 170

	T("breath_dragon").bullet.damage_radius = 90
	T("breath_dragon").render.sprites[1].scale = vv(1.5)

	T("aura_fierymist_dragon").aura.mods = {
		"mod_slow_fierymist",
		"mod_dragon_reign"
	}

	T("hero_dragon").timed_attacks.list[1].cooldown = 35
	T("hero_dragon").hero.skills.feast.devour_chance = {
		0.25,
		0.6,
		1
	}

	T("wildfirebarrage_dragon").bullet.damage_max = 60
	T("wildfirebarrage_dragon").bullet.damage_min = 60

	tt = RT("mod_dragon_reign_2", "mod_dragon_reign")
	tt.modifier.duration = 3
	tt.modifier.spread_time = 1
	tt.modifier.spread_range = 100
	tt.modifier.spread_ts = 0
	tt.modifier.remove_banned = true
	tt.mod = "mod_dragon_reign"
	tt.main_script.update = scripts.mod_dragon_reign.update
	tt.render.sprites[1].scale = vv(1.2)
	tcopy("mod_dragon_reign", "mod_dragon_reign_2")

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_dragon_2")
	end

	-- 11. 螃蟹
	T("hero_crab").hero.fn_level_up = scripts.hero_crab.level_up
	T("hero_crab").main_script.update = scripts.hero_crab.update

	T("hero_crab").hero.level_stats.armor = {
		0.17,
		0.17,
		0.21,
		0.23,
		0.35,
		0.37,
		0.49,
		0.41,
		0.53,
		0.65
	}

	T("hero_crab").hero.skills.hookedclaw.extra_damage = {
		15,
		25,
		35
	}

	T("hero_crab").timed_attacks.list[1].vis_bans = bor(F_BOSS, F_FLYING)
	T("hero_crab").timed_attacks.list[1].cooldown = 5
	T("hero_crab").timed_attacks.list[1].min_count = 1
	T("hero_crab").timed_attacks.list[1].damage_size = v(120, 40)

	T("hero_crab").ranged.attacks[1] = nil
	T("hero_crab").hero.skills.shouldercannon.loops = {
		6,
		9,
		12
	}
	T("hero_crab").timed_attacks.list[2] = E:clone_c("bullet_attack")
	T("hero_crab").timed_attacks.list[2].disabled = true
	T("hero_crab").timed_attacks.list[2].animations = {
		"cannon_start",
		"cannon_loop",
		"cannon_end"
	}
	T("hero_crab").timed_attacks.list[2].bullet = "crab_water_bomb"
	T("hero_crab").timed_attacks.list[2].bullet_start_offset = {
		v(9, 50)
	}
	T("hero_crab").timed_attacks.list[2].cooldown = 20
	T("hero_crab").timed_attacks.list[2].min_count = 2
	T("hero_crab").timed_attacks.list[2].max_range = 256
	T("hero_crab").timed_attacks.list[2].min_range = 19.2
	T("hero_crab").timed_attacks.list[2].shoot_times = {
		fts(9.9),
		fts(9)
	}
	T("hero_crab").timed_attacks.list[2].loops = nil
	T("hero_crab").timed_attacks.list[2].vis_bans = 0
	T("hero_crab").timed_attacks.list[2].vis_flags = F_RANGED
	T("hero_crab").timed_attacks.list[2].xp_from_skill = "shouldercannon"
	T("hero_crab").timed_attacks.list[2].node_prediction = fts(42)
	T("hero_crab").timed_attacks.list[2].offset_cooldown = 5
	T("crab_water_bomb").bullet.damage_max = 40
	T("crab_water_bomb").bullet.damage_min = 25
	T("crab_water_bomb").bullet.flight_time = fts(18)
	T("crab_water_bomb").bullet.damage_type = DAMAGE_MAGICAL
	T("mod_slow_water_bomb").modifier.duration = 3
	T("mod_slow_water_bomb").slow.factor = 0.6

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_crab_2")
	end

	-- 12. 库绍
	T("hero_monk").main_script.update = scripts.hero_monk.update

	T("hero_monk").hero.level_stats.hp_max = {
		370,
		390,
		410,
		430,
		450,
		470,
		490,
		510,
		530,
		550
	}
	T("hero_monk").hero.level_stats.regen_health = {
		38,
		39,
		41,
		42,
		44,
		45,
		47,
		48,
		50,
		51
	}
	T("hero_monk").motion.max_speed = 3.7 * FPS

	T("hero_monk").melee.attacks[1].mod = "mod_monk_damage_reduction_1"
	T("hero_monk").melee.attacks[2].mod = "mod_monk_damage_reduction_1"
	T("hero_monk").melee.attacks[3].mod = "mod_monk_damage_reduction_1"

	T("hero_monk").timed_attacks.list[1].mod = "mod_monk_damage_reduction_2"
	T("hero_monk").timed_attacks.list[1].damage_radius = 75
	T("hero_monk").timed_attacks.list[1].hit_time = fts(19.5)
	T("hero_monk").hero.skills.dragonstyle.damage_max = {
		90,
		160,
		240
	}
	T("hero_monk").hero.skills.dragonstyle.damage_min = {
		50,
		80,
		120
	}

	T("hero_monk").melee.attacks[5].mod = "mod_monk_damage_reduction_2"
	T("hero_monk").melee.attacks[5].cooldown = 3
	T("hero_monk").melee.attacks[5].limit_damage_factor = 0.07

	T("hero_monk").timed_attacks.list[2].mod = "mod_monk_damage_reduction_1"
	T("hero_monk").hero.skills.leopardstyle.loops = {
		6,
		9,
		12
	}
	T("hero_monk").timed_attacks.list[2].hit_times = {
		fts(4.5),
		fts(4.5),
		fts(4.5),
		fts(4.5)
	}
	T("hero_monk").timed_attacks.list[2].range = 150

	T("hero_monk").dodge.hit_time = fts(13.5)

	tt = RT("mod_monk_damage_reduction_1", "mod_monk_damage_reduction")
	tt.reduction_factor = 0.085
	tt = RT("mod_monk_damage_reduction_2", "mod_monk_damage_reduction")
	tt.reduction_factor = 0.125

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_monk_2")
	end

	-- 13. 但丁
	T("hero_van_helsing").hero.level_stats.armor = {
		0.05,
		0.05,
		0.1,
		0.1,
		0.15,
		0.2,
		0.25,
		0.3,
		0.35,
		0.4
	}

	T("hero_van_helsing").timed_attacks.list[1].cooldown = 10

	T("hero_van_helsing").timed_attacks.list[3].max_range = 300
	T("hero_van_helsing").timed_attacks.list[3].min_range = 0
	T("hero_van_helsing").hero.skills.holygrenade.silence_duration = {
		15,
		25,
		9999
	}

	T("hero_van_helsing").melee.attacks[2].cooldown = 15

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_van_helsing_2")
	end

	-- 14. 骨龙
	T("hero_dracolich").main_script.update = scripts.hero_dracolich.update

	T("hero_dracolich").motion.max_speed = 3.3 * FPS

	T("hero_dracolich").ranged.attacks[1].max_range = 160
	T("hero_dracolich").ranged.attacks[1].min_range = 25

	T("hero_dracolich").hero.skills.unstabledisease.spread_damage = {
		20,
		50,
		80
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_dracolich_2")
	end

	-- 15. 米偌陶
	T("hero_minotaur").hero.level_stats.armor = {
		0.20,
		0.22,
		0.26,
		0.30,
		0.33,
		0.36,
		0.40,
		0.44,
		0.47,
		0.55
	}
	T("hero_minotaur").motion.max_speed = 3.5 * FPS

	T("hero_minotaur").timed_attacks.list[3].max_range = 200
	T("hero_minotaur").hero.skills.bullrush.run_damage_min = {
		20,
		30,
		40
	}
	T("hero_minotaur").hero.skills.bullrush.run_damage_max = {
		40,
		70,
		100
	}

	T("hero_minotaur").melee.attacks[2].chance = 0.4
	T("hero_minotaur").hero.skills.bloodaxe.damage_factor = {
		1.25,
		1.5,
		2
	}

	T("hero_minotaur").timed_attacks.list[4].cooldown = 7
	T("hero_minotaur").timed_attacks.list[4].nodes_limit = 40

	T("hero_minotaur").timed_attacks.list[1].cooldown = 8

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_minotaur_2")
	end

	-- 16. 猴神
	T("hero_monkey_god").info.fn = scripts.hero_monkey_god.get_info
	T("hero_monkey_god").hero.fn_level_up = scripts.hero_monkey_god.level_up
	T("hero_monkey_god").main_script.update = scripts.hero_monkey_god.update

	T("hero_monkey_god").melee.attacks[1].mod = "mod_monkey_god_shatter"
	T("hero_monkey_god").melee.attacks[2].mod = "mod_monkey_god_shatter"
	tt = RT("mod_monkey_god_shatter", "mod_damage")
	tt.damage_min = 0.02
	tt.damage_max = 0.02
	tt.damage_type = bor(DAMAGE_ARMOR, DAMAGE_NO_SHIELD_HIT)

	T("hero_monkey_god").melee.attacks[3].cooldown = 13
	T("hero_monkey_god").melee.attacks[3].mod = "mod_monkey_god_shatter"

	T("hero_monkey_god").melee.attacks[4].cooldown = 13
	T("hero_monkey_god").melee.attacks[4].mod = "mod_monkey_god_shatter"

	T("hero_monkey_god").hero.skills.monkeypalm.stun_duration = {
		5,
		6,
		7
	}
	T("hero_monkey_god").hero.skills.monkeypalm.xp_gain_factor = 12

	T("hero_monkey_god").timed_attacks.list[1].cooldown = 40

	T("hero_monkey_god").hero.skills.divinenature.duration = {
		40,
		50,
		60
	}
	T("hero_monkey_god").timed_attacks.list[2] = CC("spawn_attack")
	T("hero_monkey_god").timed_attacks.list[2].animation = "angry_start"
	T("hero_monkey_god").timed_attacks.list[2].cooldown = 55
	T("hero_monkey_god").timed_attacks.list[2].disabled = true
	T("hero_monkey_god").timed_attacks.list[2].entity = "monkey_god_illusion"
	T("hero_monkey_god").timed_attacks.list[2].spawn_time = fts(19)
	T("hero_monkey_god").timed_attacks.list[2].spawn_offset = v(0, 30)
	T("hero_monkey_god").timed_attacks.list[2].nodes_offset = {
		5,
		14
	}

	tt = RT("monkey_god_illusion", "hero_monkey_god")
	AC(tt, "tween")
	tt.clone = {}
	tt.clone.duration = nil
	tt.info.i18n_key = "HERO_MONKEY_GOD"
	tt.render.sprites[1].shader = "p_tint"
	tt.render.sprites[1].shader_args = {
		tint_factor = 0.25,
		tint_color = {
			0,
			0.85,
			1,
			1
		}
	}
	tt.tween.disabled = true
	tt.tween.props[1].keys = {
		{
			2,
			255
		},
		{
			3,
			0
		}
	}

	if T("tower_hero_buy_a") then
		hero_buy_template_set("hero_monkey_god_2")
	end
end

function template_UH:enhance3()
	-- 1. 艾莉丹
	T("hero_elves_archer").hero.fn_level_up = scripts.hero_elves_archer.level_up
	T("hero_elves_archer").main_script.update = scripts.hero_elves_archer.update

	T("hero_elves_archer").motion.max_speed = 3.5 * FPS

	T("hero_elves_archer").melee.range = 30

	T("hero_elves_archer").ranged.attacks[1].cooldown = 0.5
	T("hero_elves_archer").ranged.attacks[1].min_range = 0

	T("arrow_hero_elves_archer").bullet.limit_p = 0

	T("hero_elves_archer").hero.skills.multishot.loops = {
		11,
		15,
		18
	}
	T("hero_elves_archer").ranged.attacks[2].bullet = "arrow_hero_elves_archer_s"
	T("hero_elves_archer").ranged.attacks[2].shoot_times = {
		fts(1.5)
	}
	T("hero_elves_archer").ranged.attacks[2].min_range = 0
	tt = RT("arrow_hero_elves_archer_s", "arrow_hero_elves_archer")
	tt.bullet.damage_min = 10
	tt.bullet.damage_max = 14

	T("hero_elves_archer").hero.skills.porcupine.max = {
		10,
		15,
		25
	}
	T("hero_elves_archer").hero.skills.porcupine.damage_inc = {
		1,
		1.25,
		1.5
	}
	T("hero_elves_archer").hero.skills.porcupine.damage_type = DAMAGE_TRUE

	T("hero_elves_archer").dodge.counter_attack.hit_time = fts(6)

	T("hero_elves_archer").melee.attacks[2].damage_type = bor(DAMAGE_TRUE, DAMAGE_FX_EXPLODE)

	T("hero_elves_archer_ultimate").cooldown = 25

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_elves_archer_2")

		tt = T("hero_elves_archer_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_elves_archer"
		}
		tt.melee.attacks[1].pop_chance = 0.09
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
	end

	-- 2. 埃里汎
	T("hero_arivan").main_script.insert = scripts.hero_arivan.insert
	T("hero_arivan").main_script.update = scripts.hero_arivan.update

	T("hero_arivan").melee.range = 25

	T("hero_arivan").hero.level_stats.ranged_damage_min = {
		24,
		27,
		31,
		32,
		34,
		35,
		36,
		37,
		38,
		39
	}
	T("hero_arivan").hero.level_stats.ranged_damage_max = {
		57,
		60,
		64,
		67,
		71,
		74,
		77,
		81,
		84,
		87
	}

	T("hero_arivan").timed_attacks.list[1].cooldown = 15
	T("fireball_arivan").mod = "mod_lava_arivan"
	tt = RT("mod_lava_arivan", "mod_lava")
	tt.modifier.duration = 7.5
	tt.dps.damage_inc = 1
	tt.main_script.update = scripts.fireball_arivan.update

	T("hero_arivan").ranged.attacks[2].cooldown = 12
	T("hero_arivan").hero.skills.lightning_rod.damage_max = {
		100,
		220,
		400
	}
	T("hero_arivan").hero.skills.lightning_rod.damage_min = {
		60,
		140,
		240
	}

	T("hero_arivan").hero.skills.icy_prison.duration = {
		4,
		6,
		8
	}

	T("hero_arivan").hero.skills.stone_dance.count = {
		2,
		4,
		5
	}
	T("hero_arivan").hero.skills.stone_dance.damage = {
		7,
		8,
		9
	}
	T("hero_arivan").timed_attacks.list[2].cooldown = 4
	T("aura_arivan_stone_dance").rot_speed = 7 * FPS * math.pi / 180
	T("aura_arivan_stone_dance").aura.cycle_time = 1.4
	T("aura_arivan_stone_dance").aura.radius = 45
	T("aura_arivan_stone_dance").aura.damage_type = DAMAGE_PHYSICAL
	T("aura_arivan_stone_dance").main_script.update = scripts.aura_arivan_stone_dance.update

	T("hero_arivan_ultimate").cooldown = 60
	T("hero_arivan").hero.skills.ultimate.duration = {
		[0] = 5,
		8,
		10,
		12
	}

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_arivan_2")

		tt = T("hero_arivan_2")
		tt.ranged.attacks[1].bullet = "ray_arivan_simple_2"
		tt.ranged.attacks[2].bullet = "lightning_arivan_2"

		tcopy("ray_arivan_simple_2", "ray_arivan_simple")
		tt = T("ray_arivan_simple_2")
		tt.bullet.pop = {
			"ultimate_hero_arivan"
		}
		tt.bullet.pop_chance = 0.03
		tt.bullet.pop_conds = DR_DAMAGE

		tcopy("lightning_arivan_2", "lightning_arivan")
		tt = T("lightning_arivan_2")
		tt.bullet.pop = {
			"ultimate_hero_arivan"
		}
		tt.bullet.pop_chance = 0.03
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 3. 仙子
	T("hero_catha").hero.level_stats.armor = {
		0,
		0.05,
		0.1,
		0.15,
		0.15,
		0.15,
		0.20,
		0.20,
		0.25,
		0.25
	}

	T("hero_catha").melee.range = 30

	T("hero_catha").hero.level_stats.ranged_damage_min = {
		14,
		15,
		16,
		16,
		17,
		18,
		18,
		19,
		20,
		21
	}
	T("hero_catha").hero.level_stats.ranged_damage_max = {
		18,
		19,
		20,
		22,
		23,
		24,
		26,
		27,
		28,
		30
	}

	T("soldier_catha").melee.range = 30

	T("hero_catha").hero.skills.fury.damage_min = {
		18,
		22,
		34
	}
	T("hero_catha").hero.skills.fury.damage_max = {
		56,
		76,
		96
	}

	T("hero_catha").hero.skills.curse.chance = {
		0.3,
		0.4,
		0.6
	}

	T("hero_catha_ultimate").cooldown = 15
	T("hero_catha").hero.skills.ultimate.range = {
		[0] = 70,
		80,
		90,
		100
	}

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_catha_2")

		tt = T("hero_catha_2")
		tt.ranged.attacks[1].bullet = "knife_catha_2"

		tcopy("knife_catha_2", "knife_catha")
		tt = T("knife_catha_2")
		tt.bullet.pop = {
			"ultimate_hero_catha"
		}
		tt.bullet.pop_chance = 0.05
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 4. 雷格森
	T("hero_regson").hero.fn_level_up = scripts.hero_regson.level_up

	T("hero_regson").hero.level_stats.armor = {
		0,
		0.1,
		0.1,
		0.1,
		0.2,
		0.2,
		0.2,
		0.3,
		0.3,
		0.3
	}

	T("hero_regson").hero.level_stats.melee_damage_max = {
		19,
		20,
		21,
		22,
		24,
		25,
		26,
		27,
		28,
		30
	}
	T("hero_regson").hero.level_stats.melee_damage_min = {
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19,
		20
	}

	T("hero_regson").blade_cooldown = 20
	T("aura_regson_blade").blade_duration = 10
	T("aura_regson_blade").main_script.update = scripts.aura_regson_blade.update
	T("hero_regson").melee.attacks[4].cooldown = 0.6

	T("hero_regson").melee.attacks[6].cooldown = 10
	T("hero_regson").melee.attacks[7] = copy(T("hero_regson").melee.attacks[6])
	T("hero_regson").melee.attacks[7].mod = "mod_regson_slash_2"
	tt = RT("mod_regson_slash_2", "mod_regson_slash")
	tt.damage_type = DAMAGE_TRUE

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_regson_2")

		tt = T("hero_regson_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_regson"
		}
		tt.melee.attacks[1].pop_chance = 0.03
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
		tt.melee.attacks[4].pop = {
			"ultimate_hero_regson"
		}
		tt.melee.attacks[4].pop_chance = 0.05
		tt.melee.attacks[4].pop_conds = DR_DAMAGE
	end

	-- 5. 迪纳斯王子
	T("hero_elves_denas").wealthy.gold = 35

	T("hero_elves_denas").timed_attacks.list[2].cooldown = 15
	T("hero_elves_denas").timed_attacks.list[2].lost_health = 200

	T("hero_elves_denas").timed_attacks.list[1].cooldown = 18
	T("hero_elves_denas").timed_attacks.list[1].range = 150

	T("hero_elves_denas").melee.attacks[3].cooldown = 12

	T("soldier_elves_denas_guard").reinforcement.duration = 40
	T("soldier_elves_denas_guard").health.hp_max = 500
	T("soldier_elves_denas_guard").regen.health = 50

	T("soldier_elves_denas_guard").melee.attacks[1].damage_max = 18
	T("soldier_elves_denas_guard").melee.attacks[1].damage_min = 10
	T("soldier_elves_denas_guard").melee.range = 90

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_elves_denas_2")

		tt = T("hero_elves_denas_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_elves_denas"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
	end

	-- 6. 大瑞格
	T("hero_rag").main_script.update = scripts.hero_rag.update

	T("hero_rag").ranged.attacks[1].shoot_time = fts(4.25)

	T("hero_rag").timed_attacks.list[4].cooldown = 10
	T("soldier_rag").melee.range = 75
	T("soldier_rag").motion.max_speed = 3 * FPS

	T("hero_rag").timed_attacks.list[1].cooldown = 8
	T("hero_rag").timed_attacks.list[1].shoot_time = fts(17)

	T("hero_rag").timed_attacks.list[3].cooldown = 23

	T("hero_rag_ultimate").cooldown = 45
	T("hero_rag_ultimate").range = 50
	T("hero_rag_ultimate").doll_duration = 15

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_rag_2")

		tt = T("hero_rag_2")
		tt.ranged.attacks[1].bullet = "bullet_rag_2"
		tt.timed_attacks.list[4].bullet = "ray_rag_2"

		tcopy("bullet_rag_2", "bullet_rag")
		tt = T("bullet_rag_2")
		tt.bullet.pop = {
			"ultimate_hero_rag"
		}
		tt.bullet.pop_chance = 0.03
		tt.bullet.pop_conds = DR_DAMAGE

		tcopy("ray_rag_2", "ray_rag")
		tt = T("ray_rag_2")
		tt.bullet.pop = {
			"ultimate_hero_rag"
		}
		tt.bullet.pop_chance = 0.03
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 7. 树人
	T("hero_bravebark").hero.fn_level_up = scripts.hero_bravebark.level_up

	T("hero_bravebark").hero.skills.rootspikes.damage_max = {
		70,
		90,
		300
	}
	T("hero_bravebark").hero.skills.rootspikes.damage_min = {
		90,
		120,
		200
	}

	T("hero_bravebark").timed_attacks.list[2].cooldown = 6
	T("hero_bravebark").timed_attacks.list[2].max_range = 9999
	T("hero_bravebark").hero.skills.oakseeds.soldier_hp_max = {
		40,
		60,
		80
	}
	T("hero_bravebark").hero.skills.oakseeds.soldier_damage_max = {
		2,
		6,
		8
	}
	T("hero_bravebark").hero.skills.oakseeds.soldier_damage_min = {
		2,
		4,
		6
	}
	T("soldier_bravebark").main_script.update = scripts.soldier_bravebark.update
	T("soldier_bravebark").gold = 1

	T("hero_bravebark").hero.skills.branchball.trigger_min_hp = {
		300,
		350,
		400
	}
	T("hero_bravebark").melee.attacks[2].fn_can = scripts.hero_bravebark.fn_can_branchball

	T("hero_bravebark").springsap.cooldown = 20
	T("hero_bravebark").hero.skills.springsap.hp_per_cycle = {
		3,
		6,
		9
	}

	T("hero_bravebark_ultimate").main_script.update = scripts.hero_bravebark_ultimate.update
	T("hero_bravebark_ultimate").entity = "soldier_bravebark"

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_bravebark_2")

		tt = T("hero_bravebark_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_bravebark"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
	end

	-- 8. 维兹南
	T("hero_veznan").main_script.update = scripts.hero_veznan.update

	T("hero_veznan").teleport.min_distance = 55

	T("hero_veznan").melee.range = 35

	T("hero_veznan").hero.skills.soulburn.total_hp = {
		500,
		750,
		1000
	}
	T("hero_veznan").timed_attacks.list[1].trigger_min_total_hp = 0.4

	T("mod_veznan_shackles_dps").dps.damage_inc = 3

	T("hero_veznan").timed_attacks.list[3].cooldown = 14
	T("mod_veznan_arcanenova").modifier.duration = 4

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_veznan_2")

		tt = T("hero_veznan_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_veznan"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
	end

	-- 9. 熊猫
	AC(T("hero_xin"), "teleport")
	T("hero_xin").teleport.min_distance = 125
	T("hero_xin").teleport.delay = 0
	T("hero_xin").teleport.sound = "ElvesHeroXinAfterTeleportOut"

	T("hero_xin").hero.level_stats.armor = {
		0,
		0.5,
		0.1,
		0.15,
		0.2,
		0.25,
		0.3,
		0.35,
		0.4,
		0.4
	}

	T("hero_xin").hero.level_stats.melee_damage_max = {
		21,
		25,
		30,
		31,
		37,
		42,
		46,
		49,
		54,
		60
	}
	T("hero_xin").hero.level_stats.melee_damage_min = {
		15,
		18,
		19,
		23,
		25,
		28,
		30,
		33,
		36,
		38
	}

	T("hero_xin").timed_attacks.list[1].cooldown = 11

	T("hero_xin").hero.skills.inspire.duration = {
		7,
		10,
		13
	}

	T("hero_xin").hero.skills.mind_over_body.duration = {
		8,
		12,
		18
	}

	T("hero_xin").melee.attacks[3].cooldown = 17
	T("hero_xin").hero.skills.panda_style.damage_max = {
		120,
		200,
		300
	}
	T("hero_xin").hero.skills.panda_style.damage_min = {
		80,
		120,
		230
	}

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_xin_2")

		tt = T("hero_xin_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_xin"
		}
		tt.melee.attacks[1].pop_chance = 0.06
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
		tt.melee.attacks[3].pop = {
			"ultimate_hero_xin"
		}
		tt.melee.attacks[3].pop_chance = 0.03
		tt.melee.attacks[3].pop_conds = DR_DAMAGE
	end

	-- 10. 凤凰
	T("hero_phoenix").main_script.insert = scripts.hero_phoenix.insert
	T("hero_phoenix").hero.fn_level_up = scripts.hero_phoenix.level_up

	T("hero_phoenix").hero.level_stats.hp_max = {
		250,
		260,
		270,
		290,
		310,
		320,
		340,
		360,
		380,
		400
	}

	T("hero_phoenix").hero.skills.inmolate.every_damage = {
		fts(3),
		fts(2),
		fts(1)
	}
	T("hero_phoenix").timed_attacks.list[1].cooldown = 30

	T("hero_phoenix").timed_attacks.list[2].cooldown = 18

	AC(T("hero_phoenix"), "auras")
	T("hero_phoenix").auras.list[1] = E:clone_c("aura_attack")
	T("hero_phoenix").auras.list[1].name = "inmolate_aura_phoenix"
	T("hero_phoenix").auras.list[1].disabled = true
	tt = RT("inmolate_aura_phoenix", "aura")
	tt.every_damage = fts(3)
	tt.damage = 1
	tt.main_script.update = scripts.inmolate_aura_phoenix.update

	T("hero_phoenix_ultimate").cooldown = 15

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_phoenix_2")

		tt = T("hero_phoenix_2")
		tt.ranged.attacks[2].bullet = "missile_phoenix_2"

		tcopy("missile_phoenix_2", "missile_phoenix")
		tt = T("missile_phoenix_2")
		tt.bullet.pop = {
			"ultimate_hero_phoenix"
		}
		tt.bullet.pop_chance = 0.15
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 11. 水晶人
	T("hero_durax").hero.level_stats.armor = {
		0.15,
		0.2,
		0.23,
		0.27,
		0.3,
		0.33,
		0.37,
		0.40,
		0.43,
		0.45
	}

	T("hero_durax").timed_attacks.list[2].cooldown = 37.5

	T("hero_durax").hero.skills.ultimate.damage = {
		[0] = 800,
		1000,
		1200,
		1400
	}

	tcopy("hero_durax_clone", "hero_durax")
	tt = T("hero_durax_clone")
	AC(tt, "tween")
	tt.clone = {}
	tt.clone.duration = nil
	tt.render.sprites[1].shader = "p_tint"
	tt.render.sprites[1].shader_args = {
		tint_factor = 0.25,
		tint_color = {
			0,
			0.75,
			1,
			1
		}
	}
	tt.health.dead_lifetime = 3
	tt.sound_events.change_rally_point = "ElvesHeroDuraxTaunt"
	tt.sound_events.death = "ElvesHeroDuraxDeath"
	tt.sound_events.insert = nil
	tt.ranged.attacks[1].bullet = "spear_durax_clone"
	tt.health.ignore_delete_after = nil
	tt.tween.disabled = true
	tt.tween.props[1].keys = {
		{
			2,
			255
		},
		{
			3,
			0
		}
	}
	tt.transfer.particles_name = "ps_durax_clone_transfer"

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_durax_2")

		tt = T("hero_durax_2")
		tt.timed_attacks.list[1].bullet = "ray_durax_2"
		tt.melee.attacks[1].pop = {
			"ultimate_hero_durax"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE

		tcopy("ray_durax_2", "ray_durax")
		tt = T("ray_durax_2")
		tt.bullet.pop = {
			"ultimate_hero_durax"
		}
		tt.bullet.pop_chance = 0.05
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 12. 莉恩
	T("hero_lynn").hero.fn_level_up = scripts.hero_lynn.level_up
	T("hero_lynn").main_script.update = scripts.hero_lynn.update

	AC(T("hero_lynn"), "teleport")
	T("hero_lynn").teleport.min_distance = 125
	T("hero_lynn").teleport.delay = 0
	T("hero_lynn").teleport.animations = {
		"teleport_out",
		"idle"
	}
	T("hero_lynn").teleport.sound = "ElvesHeroLynnCurseDespair"

	T("hero_lynn").melee.attacks[1].cooldown = 0.75
	tt = RT("mod_lynn_ultimate_s", "mod_lynn_ultimate")
	tt.dps.damage_min = 7.5
	tt.dps.damage_max = 7.5
	tt.explode_damage = 20
	T("hero_lynn").melee.attacks[4] = copy(T("hero_lynn").melee.attacks[1])
	T("hero_lynn").melee.attacks[4].disabled = true
	T("hero_lynn").melee.attacks[4].mod = "mod_lynn_weakening_s"
	T("hero_lynn").melee.attacks[5] = copy(T("hero_lynn").melee.attacks[4])
	T("hero_lynn").melee.attacks[5].animation = "attack2"
	T("hero_lynn").melee.attacks[5].chance = 0.5
	tt = RT("mod_lynn_weakening_s", "mod_lynn_weakening")
	tt.modifier.duration = 5
	tt.armor_reduction = 0.35
	tt.magic_armor_reduction = 0.4
	T("hero_lynn").melee.attacks[6] = copy(T("hero_lynn").melee.attacks[1])
	T("hero_lynn").melee.attacks[6].disabled = true
	T("hero_lynn").melee.attacks[6].mod = "mod_lynn_despair_s"
	T("hero_lynn").melee.attacks[7] = copy(T("hero_lynn").melee.attacks[6])
	T("hero_lynn").melee.attacks[7].animation = "attack2"
	T("hero_lynn").melee.attacks[7].chance = 0.5
	tt = RT("mod_lynn_despair_s", "mod_lynn_despair")
	tt.modifier.duration = 5

	T("hero_lynn").melee.attacks[3].cooldown = 14
	T("hero_lynn").melee.attacks[3].xp_gain_factor = 1
	T("hero_lynn").melee.attacks[3].hit_times = {
		fts(10),
		fts(16)
	}
	T("hero_lynn").melee.attacks[3].fn_damage = scripts.hero_lynn.fn_damage_melee

	T("hero_lynn").hero.skills.despair.duration = {
		7,
		9,
		11
	}
	T("hero_lynn").timed_attacks.list[1].hit_time = fts(16)

	T("hero_lynn").hero.skills.weakening.armor_reduction = {
		0.6,
		0.8,
		1
	}
	T("hero_lynn").timed_attacks.list[2].hit_time = fts(21)

	T("mod_lynn_ultimate").explode_range = 133

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_lynn_2")

		tt = T("hero_lynn_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_lynn"
		}
		tt.melee.attacks[1].pop_chance = 0.03
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
		tt.melee.attacks[3].pop = {
			"ultimate_hero_lynn"
		}
		tt.melee.attacks[3].pop_chance = 0.03
		tt.melee.attacks[3].pop_conds = DR_DAMAGE
	end

	-- 13. 狮王
	T("hero_bruce").hero.fn_level_up = scripts.hero_bruce.level_up
	T("hero_bruce").main_script.insert = scripts.hero_bruce.insert
	T("hero_bruce").main_script.update = scripts.hero_bruce.update

	T("hero_bruce").health.dead_lifetime = 13

	T("hero_bruce").hero.level_stats.armor = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	T("hero_bruce").hero.level_stats.regen_health = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	T("hero_bruce").melee.attacks[3].trigger_hp = 0.5
	T("hero_bruce").melee.attacks[3].fn_chance = scripts.hero_bruce.fn_chance_sharp_claws
	T("mod_bruce_sharp_claws").main_script.insert = scripts.mod_bruce_sharp_claws.insert
	T("mod_bruce_sharp_claws").heal_hp = 25

	T("hero_bruce").hero.skills.lions_fur.extra_hp = {
		150,
		190,
		230
	}
	T("hero_bruce").hero.skills.lions_fur.heal_every = {
		fts(5),
		fts(2),
		fts(1)
	}

	T("hero_bruce").hero.skills.kings_roar.every_hp = {
		400,
		350,
		250
	}
	T("hero_bruce").hero.skills.kings_roar.damage = {
		100,
		150,
		200
	}
	T("hero_bruce").hero.skills.kings_roar.heal_hp = {
		0.1,
		0.2,
		0.3
	}
	T("hero_bruce").hero.skills.kings_roar.stun_duration = {
		1,
		2,
		2
	}
	T("hero_bruce").timed_attacks.list[1].min_count = 1
	AC(T("hero_bruce"), "auras")
	T("hero_bruce").auras.list[1] = E:clone_c("aura_attack")
	T("hero_bruce").auras.list[1].name = "aura_bruce_every_hp"
	tt = RT("aura_bruce_every_hp", "aura")
	tt.aura.duration = -1
	tt.aura.every_hp = 400
	tt.aura.every_tick = 13
	tt.main_script.update = scripts.aura_bruce_every_hp.update

	T("hero_bruce").melee.attacks[4].cooldown = 14

	T("lion_bruce").custom_attack.range = 60
	T("lion_bruce").custom_attack.vis_bans = 0
	T("hero_bruce_ultimate").cooldown = 39

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_bruce_2")

		tt = T("hero_bruce_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_bruce"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
	end

	-- 14. 堕天使
	T("hero_lilith").motion.max_speed = 3.4 * FPS

	T("hero_lilith").ranged.attacks[1].shoot_time = fts(21)
	T("hero_lilith").ranged.attacks[1].node_prediction = fts(21)

	T("aura_lilith_soul_eater").limit_min_damage = 15
	T("aura_lilith_soul_eater").main_script.update = scripts.aura_lilith_soul_eater.update

	T("hero_lilith_ultimate").angel_range = 225
	T("hero_lilith").hero.skills.ultimate.angel_damage = {
		[0] = 40,
		50,
		60,
		70
	}
	T("mod_lilith_angel_stun").modifier.duration = 3
	T("hero_lilith").hero.skills.ultimate.angel_count = {
		[0] = 4,
		5,
		6,
		7
	}

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_lilith_2")

		tt = T("hero_lilith_2")
		tt.melee.attacks[1].pop = {
			"ultimate_hero_lilith"
		}
		tt.melee.attacks[1].pop_chance = 0.08
		tt.melee.attacks[1].pop_conds = DR_DAMAGE
		tt.ranged.attacks[1].bullet = "bullet_lilith_2"

		tcopy("bullet_lilith_2", "bullet_lilith")
		tt = T("bullet_lilith_2")
		tt.bullet.pop = {
			"ultimate_hero_lilith"
		}
		tt.bullet.pop_chance = 0.03
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 15. 飞机
	T("hero_wilbur").motion.max_speed = 2 * FPS

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_wilbur_2")

		tt = T("hero_wilbur_2")
		tt.ranged.attacks[1].bullet = "shot_wilbur_2"

		tcopy("shot_wilbur_2", "shot_wilbur")
		tt = T("shot_wilbur_2")
		tt.bullet.pop = {
			"ultimate_hero_wilbur"
		}
		tt.bullet.pop_chance = 0.08
		tt.bullet.pop_conds = DR_DAMAGE
	end

	-- 16. 浮士德
	T("hero_faustus").info.fn = scripts.hero_faustus.get_info
	T("hero_faustus").hero.fn_level_up = scripts.hero_faustus.level_up

	T("hero_faustus").motion.max_speed = 4.5 * FPS

	T("hero_faustus").hero.level_stats.ranged_damage_min = {
		10,
		11,
		12,
		14,
		15,
		16,
		17,
		19,
		20,
		22
	}
	T("hero_faustus").hero.level_stats.ranged_damage_max = {
		14,
		16,
		19,
		22,
		24,
		27,
		30,
		31,
		33,
		35
	}
	T("hero_faustus").ranged.attacks[1].bullet_count = 4
	T("bolt_faustus").alter_reality_chance = 0.05
	T("bolt_faustus").alter_reality_mod = "mod_teleport_mage"

	T("aura_teleport_faustus").aura.mods = {
		"mod_teleport_faustus",
		"mod_enervation_faustus",
		"mod_liquid_fire_faustus_l"
	}

	T("aura_enervation_faustus").aura.mods = {
		"mod_enervation_faustus",
		"mod_liquid_fire_faustus_l"
	}
	T("hero_faustus").hero.skills.enervation.mod_damage = {
		3,
		4,
		5
	}
	tt = RT("mod_liquid_fire_faustus_l", "mod_liquid_fire_faustus")
	tt.dps.damage_every = fts(9)

	T("hero_faustus_ultimate").cooldown = 33

	if T("tower_hero_buy") then
		hero_buy_template_set("hero_faustus_2")

		tt = T("hero_faustus_2")
		tt.ranged.attacks[1].bullet = "bolt_faustus_2"

		tcopy("bolt_faustus_2", "bolt_faustus")
		tt = T("bolt_faustus_2")
		tt.bullet.pop = {
			"ultimate_hero_faustus"
		}
		tt.bullet.pop_chance = 0.02
		tt.bullet.pop_conds = DR_DAMAGE
		tt.bullet.pop_mage_el_empowerment = nil
	end
end

function template_UH:enhance4()
	-- 1. 电云
	T("hero_dianyun").motion.max_speed = 2.3 * FPS

	T("hero_dianyun").ranged.attacks[1].max_range = 250

	-- 2. 杰克
	T("hero_jack_o_lantern").hero.level_stats.regen_health = {
		30,
		32,
		34,
		36,
		38,
		40,
		44,
		46,
		48,
		50
	}
	T("hero_jack_o_lantern").motion.max_speed = 95

	T("hero_jack_o_lantern").melee.attacks[1].hit_time = fts(6)

	T("hero_jack_o_lantern").timed_attacks.list[1].cast_time = fts(12)

	T("hero_jack_o_lantern").melee.attacks[2].hit_time = fts(12)

	T("hero_jack_o_lantern").hero.skills.hero_jacko_melee.accumulated_damage_factor = {
		0.3,
		0.5,
		0.75
	}

	T("hero_jacko_horse").motion.max_speed = 85

	-- 3. 熔岩龙
	T("bolt_murglun").bullet.damage_type = DAMAGE_EXPLOSION

	T("aura_murglun_firestorm").aura.mods = { "mod_murglun_firestorm", "hero_murglun_slow_mod" }

	tt = RT("hero_murglun_slow_mod", "mod_slow")
	tt.modifier.duration = 1
	tt.slow.factor = 0.70

	-- 4. 黑龙
	T("hero_beresad").ranged.attacks[1].cooldown = 1.15

	T("hero_beresad").hero.skills.conflagration.cooldown = {
		25,
		22,
		19
	}

	T("hero_beresad").hero.skills.fear_dragon.duration = {
		3,
		4,
		5
	}
	T("hero_beresad").timed_attacks.list[1].max_target = 3
	T("hero_beresad").timed_attacks.list[1].cooldown = 14

	T("hero_beresad").timed_attacks.list[2].cooldown = 38
	T("hero_beresad_golem_lvl1").melee.range = 75
	T("hero_beresad_golem_lvl2").melee.range = 75
	T("hero_beresad_golem_lvl3").melee.range = 75

	-- 5. 维鲁克
	T("hero_orc").hero.skills.ultimate.cooldown = {[0]=16,16,16,16}
	T("hero_orc_ultimate").cooldown = 16
	T("hero_veruk_spear_lvl1").reinforcement.duration = 12
	T("hero_veruk_spear_lvl2").reinforcement.duration = 16
	T("hero_veruk_spear_lvl3").reinforcement.duration = 20
	T("hero_veruk_spear_lvl4").reinforcement.duration = 24
	T("hero_orc").hero.level_stats.armor = {0.13,0.17,0.21,0.25,0.29,0.33,0.37,0.41,0.45,0.49}

	-- 6. 阿斯拉
	T("hero_asra").hero.skills.spider_bite.cooldown = {45,35,25}
	T("hero_asra").hero.skills.quiver_of_sorrow.damage_armor = {0.04,0.08,0.16}
	T("hero_asra").hero.skills.ultimate.damage_config = {[0]=10,20,40,80}
	T("hero_asra").timed_attacks.list[1].cooldown = 18

	--7. 奥洛克
	T("hero_oloch").selfdestruct.damage_radius = 9999
	T("hero_oloch").selfdestruct.damage_type = DAMAGE_TRUE
	T("hero_oloch").selfdestruct.damage_max = 450
	T("hero_oloch").selfdestruct.damage_min = 450
	T("range_mod_oloch").modifier.duration = 20
	T("hero_oloch").motion.max_speed = 3 * FPS

	--8. 特拉敏
	T("bullet_tramin").bullet.damage_type = DAMAGE_EXPLOSION
	T("bullet_tramin").bullet.damage_radius = 45
	T("bullet_tramin_flashlight").bullet.damage_min = 100
	T("bullet_tramin_flashlight").bullet.damage_max = 100
	T("bullet_tramin_flashlight").bullet.damage_radius = 50
	T("hero_tramin").auras.list[1] = E:clone_c("aura_attack")
	T("hero_tramin").auras.list[1].name = "tramin_shield_aura"
	T("hero_tramin").auras.list[1].cooldown = 0

	--9. 格洛什
	T("hero_mammoth").hero.skills.ultimate.damage = {[0]=30,70,120,180}
	T("hero_mammoth").mammoth_lone_wolf = {
	range = 67.5,
	health_factor = 2,
	damage_factor = 3,
	check_time = 0.15,
	controller = "controller_mammoth_lone_wolf"
}
end

function template_UH:enhance5()
	-- 1. 维斯珀
	T("hero_vesper").hero.fn_level_up = scripts5.hero_vesper.level_up
	T("hero_vesper").main_script.insert = scripts5.hero_vesper.insert

	T("hero_vesper").motion.max_speed = 3.3 * FPS

	T("hero_vesper").melee.range = 40
	T("hero_vesper").melee.attacks[1].hit_time = fts(8.5)
	T("hero_vesper").melee.attacks[2].hit_time = fts(13.6)

	T("hero_vesper").melee.attacks[3].hit_times = {
		fts(6.5),
		fts(12),
		fts(18.6)
	}

	T("hero_vesper").ranged.attacks[1].shoot_time = fts(6.5)
	T("hero_vesper").ranged.attacks[1].cooldown = 0.4
	T("hero_vesper").ranged.attacks[1].node_prediction = fts(18)
	T("arrow_hero_vesper_short_arrow").bullet.flight_time = fts(15)

	T("hero_vesper").ranged.attacks[2].animation = "ranged_attack_2"
	T("hero_vesper").ranged.attacks[2].shoot_time = fts(16)
	T("hero_vesper").ranged.attacks[2].node_prediction = fts(18) + fts(8)
	T("arrow_hero_vesper_long_arrow").bullet.flight_time = fts(15)
	T("hero_vesper").ranged.attacks[2].cooldown = 2.75
	T("hero_vesper").hero.level_stats.ranged_long_damage_max = {
		88,
		89,
		90,
		90,
		92,
		94,
		95,
		97,
		99,
		100
	}
	T("hero_vesper").hero.level_stats.ranged_long_damage_min = {
		65,
		66,
		67,
		67,
		68,
		70,
		71,
		72,
		73,
		74
	}
	T("hero_vesper").ranged.attacks[2].max_range = 240

	T("hero_vesper").hero.skills.arrow_to_the_knee.stun_duration = {
		1,
		2,
		3
	}
	T("hero_vesper_arrow_to_the_knee_arrow").bullet.damage_type = DAMAGE_TRUE
	T("hero_vesper").ranged.attacks[3].shoot_time = fts(13)
	T("hero_vesper").ranged.attacks[3].node_prediction = fts(7.2)

	T("hero_vesper").timed_attacks.list[1].cooldown = {
		17,
		15,
		12
	}
	T("hero_vesper").timed_attacks.list[1].shoot_time = fts(14.2)

	T("hero_vesper").hero.skills.martial_flourish.damage_min = {
		60,
		90,
		125
	}
	T("hero_vesper").hero.skills.martial_flourish.damage_max = {
		60,
		90,
		113
	}

	T("hero_vesper").dodge.hp_to_trigger = 1

	T("hero_vesper").hero.skills.ultimate.arrows_aura_damage = {
		2.5,
		5,
		7.5
	}
	AC(T("hero_vesper"), "auras")
	T("hero_vesper").auras.list[1] = CC("aura_attack")
	T("hero_vesper").auras.list[1].aura = "vesper_arrows_aura"
	tt = RT("vesper_arrows_aura")
	AC(tt, "main_script", "aura")
	tt.bullet = "vesper_arrows_aura_arrow"
	tt.main_script.update = scripts5.vesper_arrow_aura.update
	tt.aura.cycle_time = 0.5
	tt.arrow_count = 4
	tt.duration = -1
	tt.vis_flags = F_RANGED
	tt.vis_bans = 0
	tt.delay = 0.1
	tt.sound = "HeroVesperUltimateLvl3"

	tt = RT("vesper_arrows_aura_arrow", "hero_vesper_ultimate_arrow")
	tt.bullet.damage_radius = 30
	tt.bullet.damage_max = nil
	tt.bullet.damage_min = nil

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_vesper_2")
	end

	-- 2. 蕾琳
	T("hero_raelyn").motion.max_speed = 2.1 * FPS

	T("hero_raelyn").hero.skills.unbreakable.duration = {
		6,
		8,
		10
	}

	T("hero_raelyn").hero.skills.inspire_fear.damage_duration = {
		6,
		7,
		9
	}

	T("hero_raelyn").hero.skills.ultimate.cooldown = {
		[0] = 60,
		55,
		50,
		40
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_raelyn_2")
	end

	-- 3. 尼鲁
	T("hero_muyrn").hero.fn_level_up = scripts5.hero_muyrn.level_up
	T("hero_muyrn").main_script.update = scripts5.hero_muyrn.update

	T("hero_muyrn").melee.range = 35

	T("hero_muyrn").hero.skills.sentinel_wisps.wisp_duration = {
		8,
		11,
		14
	}
	T("hero_muyrn_sentinel_wisps_entity").ranged.attacks[1].max_range = 180

	T("hero_muyrn").hero.skills.verdant_blast.heal_live_cooldown = {
		275,
		245,
		210
	}
	T("hero_muyrn").timed_attacks.list[5] = E:clone_c("custom_attack")
	T("hero_muyrn").timed_attacks.list[5].animation = "fairy_dust"
	T("hero_muyrn").timed_attacks.list[5].cooldown = 275
	T("hero_muyrn").timed_attacks.list[5].disabled = true
	T("hero_muyrn").timed_attacks.list[5].heal_live = 1

	T("hero_muyrn").hero.skills.ultimate.damage_min = {
		[0] = 5,
		6,
		7,
		8
	}
	T("hero_muyrn").hero.skills.ultimate.damage_max = {
		[0] = 9,
		10,
		11,
		12
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_muyrn_2")
	end

	-- 4. 毒液
	T("hero_venom").hero.fn_level_up = scripts5.hero_venom.level_up
	T("hero_venom").main_script.insert = scripts5.hero_venom.insert
	T("hero_venom").main_script.update = scripts5.hero_venom.update

	T("hero_venom").health.dead_lifetime = 5

	T("hero_venom").melee.attacks[1].xp_gain_factor = 2.5

	T("bullet_hero_venom_ranged_tentacle").bullet.mods[3] = "mod_teleport_hero_venom"
	tt = RT("mod_teleport_hero_venom", "mod_teleport_mage")
	tt.nodes_offset = -30

	T("hero_venom").melee.attacks[3].xp_gain_factor = 1.5
	T("hero_venom").hero.skills.inner_beast.trigger_hp = 0.6

	T("hero_venom").hero.skills.floor_spikes.cooldown = {
		20,
		20,
		20
	}
	T("hero_venom").timed_attacks.list[3].min_targets = 2

	T("hero_venom").hero.skills.eat_enemy.cooldown = {
		20,
		20,
		20
	}

	T("aura_hero_venom_ultimate").aura.mod = nil
	T("aura_hero_venom_ultimate").render.sprites[1].alpha = 0
	T("controller_hero_venom_ultimate").main_script.update = scripts5.hero_venom_ultimate.update
	T("hero_venom").hero.skills.ultimate.cooldown = {
		[0] = 30,
		30,
		30,
		30
	}
	T("hero_venom").hero.skills.ultimate.duration = {
		[0] = 30,
		40,
		50,
		60
	}
	T("hero_venom").hero.skills.ultimate.damage_min = {
		[0] = 5,
		10,
		15,
		20
	}
	T("hero_venom").hero.skills.ultimate.damage_max = {
		[0] = 10,
		15,
		20,
		25
	}
	T("controller_hero_venom_ultimate").auras = {
		"venom_teleport_start_aura",
		"venom_teleport_end_aura"
	}
	T("controller_hero_venom_ultimate").compensate_cooldown = 10

	tt = RT("venom_teleport_start_aura", "aura")
	AC(tt, "render")
	tt.ts = 0
	tt.aura.duration = 30
	tt.aura.damage_type = DAMAGE_TRUE
	tt.aura.damage_min = nil
	tt.aura.damage_max = nil
	tt.aura.hit_time = fts(12)
	tt.aura.cycle_time = 3
	tt.aura.radius = 70
	tt.aura.vis_bans = bor(F_FLYING, F_BOSS, F_MINIBOSS)
	tt.aura.vis_flags = bor(F_MOD)
	tt.main_script.insert = scripts5.venom_teleport_start_aura.insert
	tt.main_script.update = scripts5.venom_teleport_start_aura.update
	tt.main_script.remove = scripts5.venom_teleport_start_aura.remove
	tt.render.sprites[1].prefix = "hero_venom_ultimate"
	tt.render.sprites[1].animated = true
	tt.render.sprites[1].z = Z_DECALS
	tt.render.sprites[1].loop = false

	tt = RT("venom_teleport_end_aura", "venom_teleport_start_aura")
	tt.main_script.insert = scripts5.venom_teleport_end_aura.insert
	tt.main_script.update = scripts5.venom_teleport_end_aura.update
	tt.main_script.remove = scripts5.venom_teleport_end_aura.remove

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_venom_2")
	end

	-- 5. 土木人
	T("hero_builder").hero.fn_level_up = scripts5.hero_builder.level_up
	T("hero_builder").main_script.insert = scripts5.hero_builder.insert
	T("hero_builder").main_script.update = scripts5.hero_builder.update

	T("hero_builder").motion.max_speed = 2.3 * FPS

	T("hero_builder").melee.attacks[1].xp_gain_factor = 4

	T("hero_builder").hero.skills.lunch_break.heal_hp = {
		0.25,
		0.3,
		0.4
	}
	T("mod_hero_builder_lunch_break").main_script.insert = scripts5.mod_hero_builder_lunch_break.insert
	AC(T("hero_builder"), "auras")
	T("hero_builder").auras.list[1] = CC("aura_attack")
	T("hero_builder").auras.list[1].aura = "hero_builder_extra_hp_max_aura"
	tt = RT("hero_builder_extra_hp_max_aura", "aura")
	AC(tt, "render")
	tt.render.sprites[1].name = "soldier_death_rider_aura"
	tt.render.sprites[1].loop = true
	tt.render.sprites[1].z = Z_DECALS
	tt.aura.use_mod_offset = nil
	tt.aura.radius = 200
	tt.aura.extra_hp_max = 0.15
	tt.aura.duration = 0
	tt.main_script.update = scripts5.hero_builder_extra_hp_max_aura.update

	T("aura_hero_builder_demolition_man").aura.mods[2] = "hero_builder_mod_stun"
	tt = RT("hero_builder_mod_stun", "mod_stun")
	tt.modifier.duration = 1.5

	T("hero_builder").hero.skills.defensive_turret.duration = {
		50,
		75,
		100
	}
	T("hero_builder").hero.skills.defensive_turret.damage_max = {
		6,
		12,
		18
	}
	T("hero_builder").hero.skills.defensive_turret.damage_min = {
		4,
		10,
		14
	}

	T("hero_builder").hero.skills.ultimate.stun_duration = {
		[0] = 2,
		3,
		4,
		5
	}
	T("aura_hero_builder_ultimate").main_script.update = scripts5.aura_hero_builder_ultimate.update
	T("aura_hero_builder_ultimate").aura.mods = {
		"mod_hero_builder_ultimate_stun",
		"mod_hero_builder_ultimate_stun_short"
	}
	T("aura_hero_builder_ultimate").aura.radius_long_inc = 2
	tt = RT("mod_hero_builder_ultimate_stun_short", "mod_hero_builder_ultimate_stun")
	tt.modifier.duration = 2

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_builder_2")
	end

	-- 6. 战争巨头
	T("hero_robot").hero.skills.jump.stun_duration = {
		2,
		3,
		4
	}

	T("hero_robot").timed_attacks.list[2].cooldown = {
		30,
		29,
		28
	}
	T("hero_robot").timed_attacks.list[2].min_targets = 2
	T("hero_robot").timed_attacks.list[2].vis_bans = 0
	T("hero_robot").timed_attacks.list[2].damage_bans = 0
	T("bullet_hero_robot_skill_fire").damage_bans = 0
	T("aura_hero_robot_skill_fire_slow").aura.mods = {
		"mod_hero_robot_skill_fire_slow",
		"mod_hero_robot_skill_explode"
	}

	T("hero_robot").timed_attacks.list[3].max_range = 110
	T("hero_robot").hero.skills.explode.burning_damage_min = {
		3,
		4,
		5
	}
	T("hero_robot").hero.skills.explode.burning_damage_max = {
		3,
		4,
		5
	}
	T("hero_robot").timed_attacks.list[3].min_targets = 2

	T("hero_robot").hero.skills.uppercut.life_threshold = {
		0.25,
		0.5,
		0.75
	}

	T("hero_robot").hero.skills.ultimate.burning_damage_min = {
		[0] = 2,
		3,
		4,
		6
	}
	T("hero_robot").hero.skills.ultimate.burning_damage_max = {
		[0] = 2,
		3,
		4,
		5
	}
	--T("aura_hero_robot_ultimate_train").aura.duration = 8

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_robot_2")
	end

	-- 7. 虚空法师
	T("hero_space_elf").teleport.min_distance = 80

	T("hero_space_elf").melee.range = 30

	T("soldier_hero_space_elf_astral_reflection").melee.range = 40

	T("hero_space_elf").hero.skills.black_aegis.cooldown = {
		18,
		14,
		10
	}

	T("hero_space_elf").hero.skills.spatial_distortion.duration = {
		8,
		10,
		12
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_space_elf_2")
	end

	-- 8. 哥布林机甲
	T("hero_mecha").ranged.attacks[1].max_range = 500
	T("hero_mecha").ranged.attacks[1].animations = {
		nil,
		"attack_1"
	}
	T("hero_mecha").ranged.attacks[1].shoot_times = {
		fts(1)
	}
	T("hero_mecha").ranged.attacks[1].loops = 2
	T("hero_mecha").ranged.attacks[1].cooldown = 1

	T("hero_mecha").ranged.attacks[2] = copy(T("hero_mecha").ranged.attacks[1])
	T("hero_mecha").ranged.attacks[2].animations = {
		nil,
		"attack_2"
	}
	T("hero_mecha").ranged.attacks[2].bullet_start_offset = {
		v(40, 26)
	}
	T("hero_mecha").ranged.attacks[2].disabled = true

	T("hero_mecha").timed_attacks.list[1].spawn_range = 500
	T("drone_hero_mecha").ranged.attacks[1].max_range = 500
	T("drone_hero_mecha").duration = {
		12,
		18,
		23
	}

	T("hero_mecha").timed_attacks.list[2].max_range = 500

	T("hero_mecha").timed_attacks.list[3].min_targets = 2
	T("hero_mecha").hero.skills.power_slam.cooldown = {
		20,
		17,
		14
	}

	T("hero_mecha").hero.skills.mine_drop.max_mines = {
		4,
		5,
		7
	}

	T("hero_mecha").hero.skills.ultimate.cooldown = {
		[0] = 70,
		65,
		60,
		55
	}
	T("zeppelin_hero_mecha").attack_radius = 700

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_mecha_2")
	end

	-- 9. 圣龙
	T("hero_lumenir").hero.skills.fire_balls.flames_count = {
		5,
		6,
		8
	}

	T("mod_hero_lumenir_sword_hit").main_script.update = scripts5.mod_hero_lumenir_sword_hit.update
	T("mod_hero_lumenir_sword_hit").stun_range = 55
	T("mod_hero_lumenir_sword_hit").aura_damage = 150
	T("mod_hero_lumenir_sword_hit").aura_damage_type = DAMAGE_MAGICAL

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_lumenir_2")
	end

	-- 10. 安雅
	T("hero_hunter").hero.level_stats.hp_max = {
		250,
		265,
		290,
		310,
		330,
		350,
		365,
		375,
		385,
		400
	}

	T("hero_hunter").melee.attacks[1].cooldown = 0.6

	T("hero_hunter").hero.skills.ricochet.damage_min = {
		55,
		75,
		105
	}
	T("hero_hunter").hero.skills.ricochet.damage_max = {
		75,
		100,
		130
	}
	T("hero_hunter").hero.skills.ricochet.bounces = {
		2,
		3,
		3
	}
	T("arrow_hero_hunter_ricochet").main_script.update = scripts5.arrow_hero_hunter_ricochet.update

	T("hero_hunter").timed_attacks.list[3].min_targets = 2
	T("aura_hero_hunter_shoot_around").aura.cycle_time = 0.04
	T("aura_hero_hunter_shoot_around").aura.radius = 100

	T("hero_hunter").hero.skills.beasts.duration = {
		8,
		13,
		18
	}
	T("hero_hunter").hero.skills.beasts.damage_min = {
		3,
		4,
		7
	}
	T("hero_hunter").hero.skills.beasts.damage_max = {
		6,
		8,
		12
	}
	T("hero_hunter").hero.skills.beasts.gold_to_steal = {
		1,
		2,
		2,
	}
	T("soldier_hero_hunter_beast").chance_to_steal = 100

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_hunter_2")
	end

	-- 11. 晶龙
	T("hero_dragon_gem").hero.skills.crystal_instakill.hp_max = {
		400,
		800,
		1500
	}

	T("hero_dragon_gem").hero.skills.crystal_totem.cooldown = {
		6,
		5,
		3
	}
	T("hero_dragon_gem").hero.skills.crystal_totem.damage_min = {
		6,
		10,
		10
	}
	T("hero_dragon_gem").hero.skills.crystal_totem.damage_max = {
		8,
		10,
		12
	}
	T("hero_dragon_gem").ranged.attacks[5].bullet_start_offset = v(0, T("hero_dragon_gem").flight_height + 15)

	T("hero_dragon_gem_ultimate").max_shards = {
		[0] = 5,
		7,
		9,
		11
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_dragon_gem_2")
	end

	-- 12. 狮鹫
	T("hero_bird").ranged.attacks[1].max_range = 150

	T("hero_bird").hero.skills.cluster_bomb.fire_duration = {
		16,
		32,
		40
	}

	T("hero_bird").hero.skills.shout_stun.cooldown = {
		12,
		9,
		6
	}
	T("hero_bird").hero.skills.shout_stun.stun_duration = {
		0.25,
		0.5,
		0.75
	}
	T("hero_bird").hero.skills.shout_stun.slow_duration = {
		1.25,
		1.25,
		1.5
	}
	T("hero_bird").timed_attacks.list[2].min_targets = 1

	T("hero_bird").hero.skills.gattling.cooldown = {
		0.75,
		0.75,
		0.75
	}
	T("hero_bird").timed_attacks.list[3].min_range = 140

	T("hero_bird").timed_attacks.list[4].max_range = 150

	T("hero_bird").hero.skills.ultimate.duration = {
		[0] = 15,
		17,
		19,
		22
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_bird_2")
	end

	-- 13. 骨龙
	T("hero_dragon_bone").main_script.insert = scripts5.hero_dragon_bone.insert

	T("hero_dragon_bone").spread_radius = 75
	T("hero_dragon_bone").spread_damage_min = 25
	T("hero_dragon_bone").spread_damage_max = 25

	T("hero_dragon_bone").ranged.attacks[3].vis_bans_target = 0

	T("hero_dragon_bone").hero.skills.burst.proj_count = {
		10,
		13,
		14
	}
	T("hero_dragon_bone").ranged.attacks[5].vis_bans = 0

	tt = RT("death_rider_aura_dragon_bone", "death_rider_aura")
	tt.main_script.update = scripts5.death_rider_aura_dragon_bone.update
	tt.aura.mod = "mod_death_rider_dragon_bone"
	tt.aura.use_mod_offset = nil
	tt.aura.allowed_templates = {
		"soldier_skeleton",
		"soldier_skeleton_knight",
		"soldier_sand_warrior",
		"soldier_dracolich_golem",
		"soldier_dragon_bone_ultimate_dog",
		"soldier_death_rider",
		"soldier_sand_warrior",
		"tower_necromancer",
		"hero_dracolich",
		"soldier_bone_golem",
		"soldier_flingers_skeleton_warrior",
		"soldier_flingers_skeleton"
	}
	for i = 1, 4 do
		table.insert(tt.aura.allowed_templates, "soldier_tower_necromancer_skeleton_golem_lvl" .. i)
		table.insert(tt.aura.allowed_templates, "soldier_tower_necromancer_skeleton_lvl" .. i)
		table.insert(tt.aura.allowed_templates, "tower_necromancer_lvl" .. i)
		table.insert(tt.aura.allowed_templates, "tower_bone_flingers_lvl" .. i)
	end
	tt = RT("mod_death_rider_dragon_bone", "mod_death_rider")
	tt.tower_inflicted_damage_factor = 1.25
	tt.main_script.insert = scripts5.mod_death_rider_dragon_bone.insert
	tt.main_script.remove = scripts5.mod_death_rider_dragon_bone.remove
	tt.main_script.update = scripts5.mod_death_rider_dragon_bone.update

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_dragon_bone_2")
	end

	-- 14. 女巫
	T("hero_witch").melee.range = 30

	T("hero_witch").ranged.attacks[1].cooldown = 1.1

	T("hero_witch").hero.skills.polymorph.cooldown = {
		8,
		8,
		8
	}
	T("mod_hero_witch_skill_polymorph").entity_hp = {
		1,
		0.9,
		0.75
	}
	T("enemy_pumpkin_witch").motion.max_speed = 10

	T("hero_witch").hero.skills.disengage.hp_max = {
		250,
		350,
		450
	}
	T("soldier_hero_witch_decoy").melee.attacks[1].cooldown = 0.7
	T("soldier_hero_witch_decoy").melee.range = 300

	T("hero_witch").timed_attacks.list[1].min_targets = 1
	T("hero_witch").hero.skills.soldiers.soldiers_amount = {
		4,
		6,
		8
	}
	T("hero_witch").timed_attacks.list[1].soldiers_offset = {
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20)),
		v(math.random(-20, 20), math.random(-20, 20))
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_witch_2")
	end

	-- 15. 木龙
	T("hero_dragon_arb").main_script.update = scripts5.hero_dragon_arb.update

	T("hero_dragon_arb").ranged.attacks[1].cooldown = 1.6
	T("hero_dragon_arb").ranged.attacks[1].min_range_dy = 140
	T("hero_dragon_arb").ranged.attacks[1].max_angle = 360

	T("hero_dragon_arb").hero.skills.tower_runes.cooldown = {
		35,
		32,
		27
	}

	T("hero_dragon_arb").hero.skills.ultimate.duration = {
		[0] = 13,
		16,
		19,
		22
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_dragon_arb_2")
	end

	-- 16. 岩浆怪
	T("hero_lava").motion.max_speed = 2.3 * FPS

	T("aura_hero_lava_death").aura.radius = 100
	T("aura_hero_lava_death").aura.cycle_time = 0.2

	T("hero_lava").ranged.attacks[1].cooldown = 15

	T("hero_lava").timed_attacks.list[2].min_targets = 2
	T("hero_lava").timed_attacks.list[2].vis_bans = F_FRIEND

	T("hero_lava")._combo_ultimate.min_radius = 50
	T("hero_lava")._combo_ultimate.max_radius = 250

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_dragon_arb_2")
	end

	-- 17. 蛛后
	T("hero_spider").teleport.delay = 0.2
	T("hero_spider").teleport.duration = 0.5
	T("hero_spider").teleport.min_distance = 80

	T("hero_spider").hero.level_stats.armor = {
		0.18,
		0.19,
		0.21,
		0.23,
		0.25,
		0.26,
		0.28,
		0.30,
		0.32,
		0.35
	}
	T("hero_spider").hero.level_stats.hp_max = {
		280,
		300,
		310,
		325,
		330,
		340,
		350,
		355,
		365,
		370
	}

	T("hero_spider").timed_attacks.list[2].min_targets = 1

	T("hero_spider").hero.skills.ultimate.duration = {
		[0] = 7,
		8,
		10,
		12
	}
	T("mod_soldier_hero_spider_ultimate_stun").stun_chance = 0.25

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_spider_2")
	end

	-- 18. 悟空
	T("hero_wukong").hero.level_stats.armor = {
		0.2,
		0.2,
		0.25,
		0.3,
		0.35,
		0.4,
		0.45,
		0.5,
		0.55,
		0.6
	}

	T("hero_wukong").hero.skills.hair_clones.cooldown = {
		21,
		19,
		17
	}
	T("soldier_hero_wukong_clone").health.armor = 0.4
	T("soldier_hero_wukong_clone_b").health.armor = 0.4

	T("hero_wukong").hero.skills.zhu_apprentice.hp_max = {
		140,
		200,
		300
	}

	T("hero_wukong").hero.skills.pole_ranged.pole_amounts = {
		6,
		10,
		14
	}
	T("hero_wukong").hero.skills.pole_ranged.damage_max = {
		10,
		15,
		20
	}
	T("hero_wukong").hero.skills.pole_ranged.damage_min = {
		6,
		8,
		11
	}
	T("hero_wukong").timed_attacks.list[3].max_range = 300

	T("hero_wukong").hero.skills.ultimate.slow_duration = {
		[0] = 6,
		7,
		8,
		10
	}

	if T("tower_hero_buy_c") then
		hero_buy_template_set("hero_wukong_2")
	end
end

return template_UH
