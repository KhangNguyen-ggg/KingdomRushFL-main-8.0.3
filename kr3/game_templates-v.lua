-- chunkname: @./kr1/game_templates.lua

local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_x, image_y, tt = 0
local scripts = require("game_scripts_v1")
--local scripts_c = require("game_scripts_conquest")
local scripts_c = require("game_scripts-v")
local scripts2 = require("game_scripts-2")
local mylua = require("my_lua")

require("templates")

local IS_PHONE = KR_TARGET == "phone"
local IS_PHONE_OR_TABLET = KR_TARGET == "phone" or KR_TARGET == "tablet"
local IS_CONSOLE = KR_TARGET == "console"

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

local function fts(v)
	return v / FPS
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

local function d2r(d)
	return d * math.pi / 180
end

local function RT(name, ref)
	return E:register_t(name, ref)
end

local function AC(tpl, ...)
	return E:add_comps(tpl, ...)
end

local function CC(comp_name)
	return E:clone_c(comp_name)
end
---偷猎者箭塔
tt = RT("tower_build_archer_v", "tower_build")
tt.build_name = "tower_archer_1_v"
tt.render.sprites[2].name = "tower_archer_construct_0001"
tt.render.sprites[2].offset = v(0, 29)

tt = RT("tower_archer_1_v", "tower")

AC(tt, "attacks")

tt.tower.type = "archer_v"
tt.tower.level = 1
tt.tower.price = 70
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_" or "info_portraits_sc_") .. "0025"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_archer_1_base_0001"
tt.render.sprites[2].offset = v(0, 27)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_archer_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(9, 55)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "tower_archer_1_shooter"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].angles = {}
tt.render.sprites[4].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[4].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[4].offset = v(-9, 51)
tt.main_script.insert = scripts_c.tower_archer_v.insert
tt.main_script.update = scripts_c.tower_archer_v.update
tt.main_script.remove = scripts_c.tower_archer_v.remove
tt.attacks.range = 150
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "arrow_1_v"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(10, 54),
	v(-10, 54)
}
tt.sound_events.insert = "ArcherVTaunt"
tt.render.sid_tower = 2
tt.render.sids_shooter = {
	3,
	4
}

tt = RT("tower_archer_2_v", "tower_archer_1_v")
tt.info.enc_icon = 5
tt.tower.level = 2
tt.tower.price = 110
tt.render.sprites[2].name = "tower_archer_2_base_0001"
tt.render.sprites[3].prefix = "tower_archer_2_shooter"
tt.render.sprites[3].offset = v(14, 55)
tt.render.sprites[4].prefix = "tower_archer_2_shooter"
tt.render.sprites[4].offset = v(-4, 51)
tt.attacks.range = 170
tt.attacks.list[1].bullet = "arrow_2_v"
tt.attacks.list[1].cooldown = 0.6

tt = RT("tower_archer_3_v", "tower_archer_1_v")
tt.info.enc_icon = 9
tt.tower.level = 3
tt.tower.price = 150
tt.render.sprites[2].name = "tower_archer_3_base_0001"
tt.render.sprites[3].prefix = "tower_archer_3_shooter"
tt.render.sprites[3].offset = v(14, 58)
tt.render.sprites[4].prefix = "tower_archer_3_shooter"
tt.render.sprites[4].offset = v(-4, 54)
tt.attacks.range = 190
tt.attacks.list[1].bullet = "arrow_3_v"
tt.attacks.list[1].cooldown = 0.5
tt.attacks.list[1].bullet_start_offset = {
	v(10, 57),
	v(-10, 57)
}

tt = RT("arrow_1_v", "arrow")
tt.main_script.update = scripts_c.arrow_v.update
tt.bullet.armor_damage_max = 0.3
tt.bullet.armor_damage_inc = 0.05
tt.bullet.can_split = true
tt.bullet.damage_min = 3
tt.bullet.damage_max = 5
tt.bullet.seen_targets = {}
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_shunt_violet"
}

tt = RT("arrow_2_v", "arrow_1_v")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 10

tt = RT("arrow_3_v", "arrow_1_v")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 15

tt = RT("tower_build_barrack_v", "tower_build_archer")
tt.build_name = "tower_barrack_1_v"
tt.render.sprites[2].name = "tower_barrack_construct_0001"
tt.render.sprites[2].offset = v(0, 33)

tt = RT("ps_dark_shard_trail", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.track_rotation = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 50
tt.particle_system.name = "arrow_shadow_mark_smoke"
tt.particle_system.particle_lifetime = {
	0.2,
	0.3
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("fx_dark_shard_hit", "fx")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].name = "bolt_magnus_hit"
tt.sound_events.insert = "DarkShardHit"

tt = RT("dark_shard", "arrow_1_v")
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.hit_fx = "fx_dark_shard_hit"
tt.bullet.g = 0
tt.bullet.flight_time = 0.2
tt.bullet.hit_blood_fx = nil
tt.bullet.particles_name = "ps_dark_shard_trail"
tt.render.sprites[1].name = "proy_dark_shard_0001"

---盗贼公会
tt = RT("tower_barrack_1_v", "tower")

AC(tt, "barrack")

tt.tower.type = "barrack_v"
tt.tower.level = 1
tt.tower.price = 70
tt.tower.menu_offset = v(0, 10)
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0019" or "info_portraits_sc_0019"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_barrack_1_base_0001"
tt.render.sprites[2].offset = v(-2, 33)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 13)
tt.barrack.soldier_type = "soldier_thug"
tt.barrack.rally_range = 145
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts_c.tower_barrack.insert
tt.main_script.update = scripts_c.tower_barrack.update
tt.main_script.remove = scripts_c.tower_barrack.remove
tt.sound_events.insert = "BarrackVTaunt"
tt.sound_events.change_rally_point = "BarrackVTaunt"

tt = RT("tower_barrack_2_v", "tower_barrack_1_v")
tt.info.enc_icon = 6
tt.tower.level = 2
tt.tower.price = 120
tt.barrack.rally_range = 150
tt.render.sprites[2].name = "tower_barrack_2_base_0001"
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.barrack.soldier_type = "soldier_bandit"

tt = RT("tower_barrack_3_v", "tower_barrack_1_v")
tt.info.enc_icon = 10
tt.tower.level = 3
tt.tower.price = 170
tt.barrack.rally_range = 160
tt.render.sprites[2].name = "tower_barrack_3_base_0001"
tt.render.sprites[3].prefix = "tower_barrack_door"
tt.barrack.soldier_type = "soldier_brigand"

tt = RT("mod_life_drain_v", "modifier")

tt.heal_factor = 0.1
tt.heal_remove_modifiers = {}
tt.main_script.insert = scripts_c.mod_heal_on_damage.insert
tt.main_script.update = scripts_c.mod_heal_on_damage.update
tt.modifier.use_mod_offset = false

tt = E:register_t("soldier_thug", "soldier")

E:add_comps(tt, "melee", "pickpocket", "track_damage")

image_y = 52
anchor_y = 0.17
tt.health.dead_lifetime = 10
tt.health.hp_max = 60
tt.health_bar.offset = v(0, ady(38))
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.pickpocket.chance = 0
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 1
tt.pickpocket.steal_min = 1
tt.track_damage.mod = "mod_life_drain_v"
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0027" or IS_KR1 and "info_portraits_enemies_0001" or "info_portraits_enemies_0001"
tt.info.random_name_count = 15
tt.info.random_name_format = "SOLDIER_V_RANDOM_%i_NAME"
tt.main_script.insert = scripts_c.soldier_barrack.insert
tt.main_script.remove = scripts_c.soldier_barrack.remove
tt.main_script.update = scripts_c.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 5
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, -3)
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].prefix = "enemy_desertthug"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = IS_PHONE_OR_TABLET and r(-20, -5, 40, 40) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))

tt = E:register_t("soldier_bandit", "soldier_thug")

E:add_comps(tt, "dodge")

tt.dodge.chance = 0.25
tt.dodge.silent = true
tt.dodge.pop = {
	"pop_miss_v"
}
tt.dodge.pop_offset = 40
tt.health_bar.offset = v(0, 30)
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0008" or IS_KR1 and "info_portraits_sc_0008" or "info_portraits_sc_0008"
tt.render.sprites[1].prefix = "enemy_bandit"
tt.health.hp_max = 94
tt.health.armor = 0
tt.regen.health = 7
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.range = 60

tt = E:register_t("soldier_brigand", "soldier_thug")

tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0018" or IS_KR1 and "info_portraits_sc_0018" or "info_portraits_sc_0018"
tt.render.sprites[1].prefix = "enemy_brigand"
tt.regen.health = 10
tt.health.hp_max = 160
tt.health.armor = 0.3
tt.health_bar.offset = v(0, 31)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 60

tt = RT("tower_build_mage_v", "tower_build_archer")
tt.build_name = "tower_mage_1_v"
tt.render.sprites[2].name = "tower_mage_construct"
tt.render.sprites[2].offset = v(0, 30)
---恶魔法师

tt = RT("mod_slow_curse_v", "mod_slow")
tt.main_script.insert = scripts_c.mod_slow_curse.insert
tt.modifier.excluded_templates = {
	"enemy_demon_cerberus"
}

tt = RT("mod_v_shatter", "mod_damage")
tt.damage_min = 0.1
tt.damage_max = 0.1
tt.damage_type = bor(DAMAGE_MAGICAL_ARMOR, DAMAGE_NO_SHIELD_HIT)

tt = E.register_t(E, "pop_crit_v", "pop")
tt.render.sprites[1].name = "elven_pops_0024"

tt = E:register_t("mage_slow_aura_v", "aura")

tt.main_script.insert = scripts_c.aura_apply_mod.insert
tt.main_script.update = scripts_c.aura_apply_mod.update
tt.aura.mod = "mod_slow_v"
tt.aura.cycle_time = fts(10)
tt.aura.duration = -1
tt.aura.radius = nil
tt.aura.vis_flags = F_MOD
tt.aura.vis_bans = F_FRIEND

tt = RT("mod_slow_v", "mod_slow")
tt.modifier.duration = 1
tt.modifier.duplicates_by_id = true
tt.slow.factor = 0.95

tt = RT("tower_mage_1_v", "tower")

AC(tt, "attacks", "auras")

tt.tower.type = "mage_v"
tt.tower.level = 1
tt.tower.price = 100
tt.tower.menu_offset = v(0, 10)
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "slow_aura_v"
tt.auras.list[1].cooldown = 0
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0049" or "info_portraits_sc_0049"
tt.info.enc_icon = 3
tt.auras = {}
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.remove = scripts_c.tower_mage_v.remove
tt.main_script.insert = scripts_c.tower_mage_v.insert
tt.main_script.update = scripts_c.tower_mage_v.update
tt.attacks.range = 140
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_1_v"
tt.attacks.list[1].cooldown = 1 + fts(20)
tt.attacks.list[1].shoot_time = fts(15)
tt.attacks.list[1].bullet_start_offset = {
	v(6, 63),
	v(-7, 63)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "tower_mage_1_v"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_mage_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(0, 50)
tt.render.sid_tower = 2
tt.render.sid_shooter = 3
tt.sound_events.insert = "MageVTaunt"

tt = RT("tower_mage_2_v", "tower_mage_1_v")
tt.info.enc_icon = 7
tt.tower.level = 2
tt.tower.price = 160
tt.attacks.range = 160
tt.attacks.list[1].bullet = "bolt_2_v"
tt.attacks.list[1].bullet_start_offset = {
	v(6, 66),
	v(-7, 66)
}
tt.render.sprites[2].prefix = "tower_mage_2_v"
tt.render.sprites[3].prefix = "tower_mage_2_shooter"
tt.render.sprites[3].scale = v(0.7, 0.7)
tt.render.sprites[3].offset = v(0, 53)

tt = RT("tower_mage_3_v", "tower_mage_1_v")
tt.info.enc_icon = 11
tt.tower.level = 3
tt.tower.price = 220
tt.attacks.range = 180
tt.attacks.list[1].bullet = "bolt_3_v"
tt.attacks.list[1].bullet_start_offset = {
	v(6, 69),
	v(-7, 69)
}
tt.render.sprites[2].prefix = "tower_mage_3_v"
tt.render.sprites[3].prefix = "tower_mage_3_shooter"
tt.render.sprites[3].offset = v(0, 56)

tt = RT("bolt_1_v", "bolt")
tt.bullet.damage_min = 7
tt.bullet.damage_max = 15
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit_v"
tt.bullet.max_speed = 300
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.bullet.particles_name = "ps_bolt_infernal_mage_v"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.sound_events.insert = "MageVAttack"

tt = RT("bolt_2_v", "bolt_1_v")
tt.bullet.damage_min = 15
tt.bullet.damage_max = 30

tt = RT("bolt_3_v", "bolt_1_v")
tt.bullet.damage_min = 30
tt.bullet.damage_max = 75

tt = RT("ps_bolt_infernal_mage_v", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "infernal_mage_bolt_particle"
tt.particle_system.particle_lifetime = {
	fts(7),
	fts(10)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	1,
	0.8
}
tt.particle_system.scales_x = {
	1,
	1
}
tt.particle_system.scales_y = {
	1,
	1
}

tt = RT("fx_bolt_infernal_mage_hit_v", "fx")
tt.render.sprites[1].prefix = "infernal_mage_bolt"
tt.render.sprites[1].name = "explosion"

tt = RT("tower_build_engineer_v", "tower_build_archer")
tt.build_name = "tower_artillery_1"
tt.render.sprites[2].name = "tower_artillery_construct"
tt.render.sprites[2].offset = v(0, 30)
---哥布林投弹手
tt = RT("tower_artillery_1", "tower")

AC(tt, "attacks")

tt.tower.type = "artillery"
tt.tower.level = 1
tt.tower.price = 125
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0061" or "info_portraits_sc_0061"
tt.info.enc_icon = 4
tt.main_script.insert = scripts_c.tower_artillery.insert
tt.main_script.update = scripts_c.tower_artillery.update
tt.attacks.range = 165
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bomb_v"
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].cooldown = 1.8
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 50),
	v(0, 50)
}
tt.attacks.list[1].node_prediction = true
tt.render.sid_shooter = 3
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_artillery_1_base_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_artillery_1_shooter"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].angles = {}
tt.render.sprites[3].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[3].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[3].offset = v(0, 46)
tt.sound_events.insert = "ArtilleryTaunt"
tt.render.sid_tower = 2
tt.render.sid_shooter = 3

tt = RT("tower_artillery_2", "tower_artillery_1")
tt.info.enc_icon = 8
tt.tower.level = 2
tt.tower.price = 225
tt.attacks.range = 175
tt.attacks.list[1].bullet = "bomb_dynamite_v"
tt.attacks.list[1].cooldown = 1.6
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 53),
	v(0, 53)
}
tt.render.sprites[2].name = "tower_artillery_2_base_0001"
tt.render.sprites[3].prefix = "tower_artillery_2_shooter"
tt.render.sprites[3].offset = v(0, 53)

tt = RT("tower_artillery_3", "tower_artillery_1")
tt.info.enc_icon = 12
tt.tower.level = 3
tt.tower.price = 325
tt.attacks.range = 185
tt.attacks.list[1].bullet = "bomb_black_v"
tt.attacks.list[1].cooldown = 1.4
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 57),
	v(0, 57)
}
tt.render.sprites[2].name = "tower_artillery_3_base_0001"
tt.render.sprites[3].prefix = "tower_artillery_3_shooter"
tt.render.sprites[3].offset = v(0, 64)

tt= E:register_t("bomb_v", "bullet")

E:add_comps(tt, "sound_events")

tt.bullet.flight_time = fts(25)
tt.bullet.rotation_speed = 20 * FPS * math.pi / 180
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 4
tt.bullet.damage_max = 7
tt.bullet.damage_radius = 65.5
tt.bullet.can_do_mini = true
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.render.sprites[1].name = "bombs_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bomb_v.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"

tt = E:register_t("bomb_dynamite_v", "bomb_v")

tt.render.sprites[1].name = "v_artillery_2_bomb_0001"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.bullet.damage_min = 10
tt.bullet.damage_max = 20
tt.bullet.damage_radius = 66.5

tt = E:register_t("bomb_black_v", "bomb_v")

tt.render.sprites[1].name = "zapperbomb"
tt.render.sprites[1].scale = v(1, 1)
tt.bullet.damage_min = 15
tt.bullet.damage_max = 30
tt.bullet.damage_radius = 67.5

tt = E:register_t("fx_explosion_tiny", "fx")

tt.render.sprites[1].prefix = "explosion"
tt.render.sprites[1].name = "fragment"
tt.render.sprites[1].anchor.y = 0.13
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].scale = v(0.5, 0.5)

---蜥蜴人狙击塔
tt = RT("tower_deathcoil", "tower")

AC(tt, "attacks", "powers")

image_y = 0
tt.tower.type = "deathcoil"
tt.tower.level = 1
tt.tower.price = 240
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "info_portraits_enemies_0041" or "info_portraits_enemies_0041"
tt.info.enc_icon = 1
tt.info.fn = scripts_c.tower_deathcoil.get_info
tt.powers.charged = E:clone_c("power")
tt.powers.charged.price_base = 300
tt.powers.charged.price_inc = 200
tt.powers.charged.enc_icon = 8
tt.powers.charged.id = 1
tt.powers.charged.charged_damage = 0
tt.powers.charged.factor = {
	1,
	1.5,
	2
}
tt.powers.stun = E:clone_c("power")
tt.powers.stun.price_base = 200
tt.powers.stun.price_inc = 160
tt.powers.stun.id = 2
tt.powers.stun.enc_icon = 9
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_deathcoil_base_0001"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[2].scale = v(1.1, 1.1)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].random_ts = fts(10)
tt.render.sprites[3].loop = true
tt.render.sprites[3].prefix = "tower_deathcoil_base"
tt.render.sprites[3].name = "flash"
tt.render.sprites[3].animated = true
tt.render.sprites[3].offset = v(-1, 82)
tt.render.sprites[3].scale = v(1.1, 1.1)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].random_ts = fts(7)
tt.render.sprites[4].loop = true
tt.render.sprites[4].amimated = true
tt.render.sprites[4].prefix = "tower_deathcoil_base"
tt.render.sprites[4].name = "flash"
tt.render.sprites[4].offset = v(22, 50)
tt.render.sprites[4].scale = v(1.1, 1.1)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "enemy_sniper"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].scale = v(0.85, 0.85)
tt.render.sprites[5].angles = {}
tt.render.sprites[5].angles.idle = {
	"idle",
	"idle",
	"idle"
}
tt.render.sprites[5].angles.shoot_start = {
	"ranged_start_side",
	"ranged_start_up",
	"ranged_start_down"
}
tt.render.sprites[5].angles.shoot_loop = {
	"ranged_loop_side",
	"ranged_loop_up",
	"ranged_loop_down"
}
tt.render.sprites[5].angles.shoot_end = {
	"ranged_end_side",
	"ranged_end_up",
	"ranged_end_down"
}
tt.render.sprites[5].angles.shoot_aim = {
	"ranged_aim_side",
	"ranged_aim_up",
	"ranged_aim_down"
}
tt.render.sprites[5].angles_flip_vertical = {
	shoot_start = true,
	shoot_loop = true,
	shoot_end = true,
	shoot_aim = true
}
tt.render.sprites[5].angles_custom = {
	ranged = {
		35,
		145,
		210,
		335
	}
}
tt.render.sprites[5].offset = v(0, 71)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].loop = true
tt.render.sprites[6].amimated = true
tt.render.sprites[6].prefix = "tower_deathcoil_base"
tt.render.sprites[6].name = "charged"
tt.render.sprites[6].hidden = true
tt.render.sprites[6].offset = v(0, 37)
tt.render.sprites[6].scale = v(1.1, 1.1)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].loop = true
tt.render.sprites[7].amimated = true
tt.render.sprites[7].prefix = "tower_deathcoil_shooter"
tt.render.sprites[7].name = "fx"
tt.render.sprites[7].hidden = true
tt.render.sprites[7].offset = v(0, 71)
tt.render.sprites[7].scale = v(1.1, 1.1)
tt.main_script.insert = scripts_c.tower_archer_v.insert
tt.main_script.update = scripts_c.tower_deathcoil.update
tt.main_script.remove = scripts_c.tower_deathcoil.remove
tt.attacks.range = 450
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].bullet = "bolt_sniper_deathcoil"
tt.attacks.list[1].cooldown = 2
tt.attacks.list[1].crosshair_name = "mod_deathcoil_crosshair"
tt.attacks.list[1].ray = "ray_deathcoil"
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].charge_tick = fts(10)
tt.attacks.list[1].bullet_start_offset = {
	v(6, ady(70)),
	v(8, ady(76)),
	v(3, ady(67)),
	v(-6, ady(70)),
	v(-8, ady(76)),
	v(-3, ady(67))	
}
--[[
tt.attacks.list[1].bullet_start_offset = {
	v(6, ady(104)),
	v(8, ady(110)),
	v(3, ady(101)),
	v(-6, ady(104)),
	v(-8, ady(110)),
	v(-3, ady(101))

	v(6, ady(79)),
	v(10, ady(85)),
	v(3, ady(76)),
	v(-6, ady(79)),
	v(-10, ady(85)),
	v(-3, ady(76))	
}
]]--
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "bolt_sniper_stun"
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].shoot_time = fts(5)
tt.attacks.list[2].aim_time = 1
tt.attacks.list[2].vis_flags = 0--bor(F_MOD, F_STUN)
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.attacks.list[2].bullet_start_offset = {
	v(6, ady(70)),
	v(8, ady(76)),
	v(3, ady(67)),
	v(-6, ady(70)),
	v(-8, ady(76)),
	v(-3, ady(67))		
}
tt.sound_events.insert = "TowerDeathcoilTaunt"
tt.tower.long_idle_cooldown = 3
tt.render.sid_tower = 2
tt.render.sid_shooter = 5

tt = E.register_t(E, "mod_deathcoil_crosshair", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].prefix = "tower_deathcoil_crosshair"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.render.sprites[1].loop = false
tt.finished = nil
tt.modifier.duration = -1
tt.main_script.update = scripts_c.mod_deathcoil_crosshair.update

tt = E:register_t("bolt_sniper_deathcoil", "bolt")
tt.bullet.armor_damage_max = 0.3
tt.bullet.armor_damage_inc = 0.05
tt.bullet.can_split = true
tt.bullet.seen_targets = {}
tt.render.sprites[1].prefix = "bolt_sniper_deathcoil"
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 75 * 2
tt.bullet.damage_min = 22 * 2
tt.bullet.max_speed = 30 * FPS
tt.bullet.hit_fx = "fx_deathcoil_hit"
tt.main_script.update = scripts_c.bolt_deathcoil.update
tt.bullet.damage_type = bor(DAMAGE_PHYSICAL)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSniperBullet"

tt = E:register_t("bolt_sniper_stun", "bolt")
tt.bullet.armor_damage_max = 0
tt.bullet.armor_damage_inc = 0
tt.bullet.can_split = nil
tt.bullet.seen_targets = {}
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun"
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 0 + 150
tt.bullet.damage_min = 0 + 44
tt.bullet.mod = "mod_deathcoil_stun"
tt.bullet.max_speed = 30 * FPS
tt.bullet.hit_fx = "fx_deathcoil_charged_hit"
tt.bullet.miss_decal = nil
tt.main_script.update = scripts_c.bolt_deathcoil.update
tt.bullet.damage_type = bor(DAMAGE_PHYSICAL)--bor(DAMAGE_NONE)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSniperStunBullet"

tt = RT("mod_deathcoil_stun", "mod_stun")

E.add_comps(E, tt, "render")

tt.modifier.duration = 4
tt.modifier.vis_bans = bor(F_BOSS, F_MINIBOSS, F_FLYING)
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.range = 150
tt.ray_id = nil
tt.bind_id = nil
tt.modifier.ray = "ray_deathcoil_stun"
tt.modifier.bind = "deathcoil_bind"
tt.duplicate = nil
tt.main_script.insert = scripts_c.mod_deathcoil_stun.insert
tt.main_script.update = scripts_c.mod_deathcoil_stun.update
tt.main_script.remove = scripts_c.mod_deathcoil_stun.remove
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun_fx"
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.15),
	vv(1.25)
}
tt.modifier.use_mod_offset = true

tt = RT("ray_deathcoil_stun", "bullet")
tt.bullet.damage_type = bor(DAMAGE_NONE)
tt.bullet.hit_time = 10--fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.ignore_hit_offset = nil
tt.image_width = 80
tt.main_script.update = scripts_c.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "tower_deathcoil_stun_ray"
tt.render.sprites[1].loop = true
tt.sound_events.insert = nil
tt.track_target = true
tt.looping = true
tt.bullet.max_track_distance = 1e+99
tt.ray_duration = nil

tt = E:register_t("deathcoil_bind", "bullet")
tt.main_script.update = scripts_c.deathcoil_bind.update
tt.bullet.particles_name = nil
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 300
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 5
tt.bullet.damage_max = 5
tt.bullet.damage_every = 0.2
tt.radius = 30
tt.bullet.max_speed = 300
tt.bullet.damage_type = DAMAGE_TRUE
tt.bounces_max = 1e+99
tt.bounce_range = 150
tt.render.sprites[1].prefix = "tower_deathcoil_proj_stun"
tt.render.sprites[1].hidden = true
tt.sound_events.insert = nil
tt.sound_events.bounce = nil

tt = RT("fx_deathcoil_hit", "fx")
tt.render.sprites[1].name = "bolt_sniper_hit"

tt = RT("fx_deathcoil_charged_hit", "fx")
tt.render.sprites[1].name = "tower_deathcoil_charged_hit"

tt = RT("ray_deathcoil", "bullet")
tt.bullet.damage_type = bor(DAMAGE_NONE)
tt.bullet.hit_time = 10--fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.image_width = 60
tt.main_script.update = scripts_c.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "tower_deathcoil_aim_ray"
tt.render.sprites[1].loop = true
tt.sound_events.insert = nil
tt.track_target = true
tt.looping = true
tt.bullet.max_track_distance = 1e+99
tt.ray_duration = nil
---腐毒菇林
tt = RT("tower_rotshroom", "tower")

AC(tt, "attacks", "powers", "auras")

tt.tower.type = "rotshroom"
tt.tower.level = 1
tt.tower.price = 345
tt.tower.menu_offset = v(0, 10)
tt.info.portrait = IS_PHONE_OR_TABLET and "info_portraits_sc_0082" or "info_portraits_sc_0082"
tt.info.enc_icon = 2
tt.info.fn = scripts_c.tower_rotshroom.get_info
tt.main_script.insert = scripts_c.tower_rotshroom.insert
tt.main_script.update = scripts_c.tower_rotshroom.update
tt.main_script.remove = scripts_c.tower_rotshroom.remove
tt.powers.rot = E:clone_c("power")
tt.powers.rot.price_base = 200
tt.powers.rot.price_inc = 180
tt.powers.rot.id = 1
tt.powers.rot.enc_icon = 6
tt.powers.rot.damage_min = {
	5,
	10,
	15
}
tt.powers.rot.damage_max = {
	14,
	18,
	22
}
tt.powers.punch = E:clone_c("power")
tt.powers.punch.price_base = 240
tt.powers.punch.price_inc = 180
tt.powers.punch.id = 2
tt.powers.punch.enc_icon = 7
tt.powers.punch.offsets = {
	v(36, 25),
	v(-33, 25),
	v(40, 25),
	v(-37, 25),
}
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "rotshroom_aura"
tt.auras.list[1].cooldown = 0
tt.attacks.range = 165
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].mine = "decal_rotshroom_mine"
tt.attacks.list[1].offset_min = -7
tt.attacks.list[1].offset_max = 7
tt.attacks.list[1].count = 3
tt.attacks.list[1].max_count = 12
tt.attacks.list[1].interval = 0.5
tt.attacks.list[1].shrooms = {}
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].cooldown = 5
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[2] = E:clone_c("custom_attack")
tt.attacks.list[2].animation = "punch"
tt.attacks.list[2].cooldown = 30
tt.attacks.list[2].damage_min = 0
tt.attacks.list[2].damage_max = 50
tt.attacks.list[2].damage_inc = 50
tt.attacks.list[2].damage_type = DAMAGE_PHYSICAL
tt.attacks.list[2].mod_throw = "mod_rotshroom_throw"
tt.attacks.list[2].mod_kill = "mod_rotshroom_kill"
tt.attacks.list[2].shoot_time = fts(50)
tt.attacks.list[2].node_offset = -20
tt.attacks.list[2].disabled = true
tt.attacks.list[2].sound = "RotshroomPunch"
tt.attacks.list[2].vis_bans = bor(F_BOSS, F_FLYING, F_MINIBOSS)
tt.attacks.list[2].vis_flags = bor(F_STUN)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "tower_rotshroom_layer_1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 42)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_rotshroom_layer_2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(2, 24)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].prefix = "tower_rotshroom_layer_3"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(0, 30)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "tower_rotshroom_layer_4"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(0, 20)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "tower_rotshroom_layer_5"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].offset = v(0, 30)
tt.render.sprites[6].scale = v(1.2, 1.2)
tt.sound_events.insert = "TowerRotshroomTaunt"
tt.tower.long_idle_cooldown = 3
tt.tower.long_idle_cooldown_secondary = 6

tt = E.register_t(E, "rotshroom_aura", "aura")
tt.main_script.update = scripts_c.rotshroom_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.mini_shrooms = {}

tt = RT("mod_rotshroom_kill", "modifier")
tt.main_script.update = scripts_c.mod_rotshroom_kill.update

tt = RT("mod_rotshroom_throw", "modifier")
tt.main_script.update = scripts_c.mod_rotshroom_throw.update
tt.modifier.mod = "mod_rotshroom_stun"
tt.modifier.bans = {
	"mod_slow",
	"mod_goblin_leap_slow",
	"mod_slow_v"
}
tt.modifier.remove_banned = true

tt = RT("mod_rotshroom_stun", "mod_stun")

tt.modifier.use_mod_offset = true
tt.modifier.duration = 2
tt.modifier.vis_bans = bor(F_BOSS)

tt= E:register_t("bullet_rotshroom_throw", "bullet")

E:add_comps(tt, "sound_events")

tt.bullet.flight_time = fts(25)
tt.bullet.rotation_speed = 30 * FPS * math.pi / 180
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = nil
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_small = 40
tt.bullet.damage_big = 80
tt.bullet.big = nil
tt.bullet.damage_radius_big = 60
tt.bullet.damage_radius_small = 40
tt.bullet.pop = nil
tt.bullet.damage_flags = F_AREA
tt.bullet.hide_radius = 8
tt.bullet.arrived = nil
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bullet_rotshroom_throw.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil

tt= E:register_t("bullet_rotshroom_kill", "bullet")

E:add_comps(tt, "sound_events", "tween")

tt.bullet.flight_time = fts(25)
tt.bullet.g = -2 / (fts(1) * fts(1))
tt.bullet.rotation_speed = 30 * FPS * math.pi / 180
tt.bullet.hit_fx = nil
tt.bullet.hit_decal =  nil
tt.bullet.hit_fx_water = nil
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 0
tt.bullet.pop = nil
tt.bullet.damage_flags = F_NONE
tt.bullet.hide_radius = 8
tt.bullet.arrived = nil
tt.tween.run_once = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(0),
		255
	},
	{
		fts(5),
		255
	},
	{
		fts(10),
		0
	}
}
tt.bullet.can_do_mini = nil
tt.main_script.insert = scripts_c.bomb.insert
tt.main_script.update = scripts_c.bomb_v.update
tt.sound_events.insert = "AxeSound"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil

tt = RT("decal_rotshroom_mine", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.check_interval = fts(3)
tt.damage_max = 45
tt.damage_min = 30
tt.damage_type = DAMAGE_PHYSICAL
tt.duration = 1e+99
tt.hit_decal = nil
tt.mod = "mod_rotshroom_poison"
tt.hit_fx = "fx_explosion_shroom"
tt.main_script.update = scripts_c.decal_rotshroom_mine.update
tt.damage_radius = 47
tt.radius = 32
tt.render.sprites[1].loop = false
tt.render.sprites[1].prefix = "mushroom_mine"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[1].z = Z_OBJECTS
tt.sound = "EnemyMushroomDeath"
tt.sound_events.insert = "EnemyMushroomBorn"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_bans2 = bor(F_FRIEND)
tt.vis_flags = bor(F_ENEMY)

tt = RT("decal_rotshroom_mine_mini", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.check_interval = fts(3)
tt.damage_max = 23
tt.damage_min = 15
tt.damage_type = DAMAGE_PHYSICAL
tt.duration = 1e+99
tt.hit_decal = nil
tt.mod = "mod_rotshroom_poison"
tt.hit_fx = "fx_explosion_shroom"
tt.main_script.update = scripts_c.decal_rotshroom_mine.update
tt.damage_radius = 37
tt.radius = 22
tt.render.sprites[1].loop = false
tt.render.sprites[1].prefix = "mushroom_mine_small"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[1].z = Z_OBJECTS
tt.sound = "EnemyMushroomDeath"
tt.sound_events.insert = "EnemyMushroomBorn"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_bans2 = bor(F_FRIEND)
tt.vis_flags = bor(F_ENEMY)

tt = E:register_t("mod_rotshroom_poison", "mod_poison")
tt.dps.damage_every = fts(8)
tt.dps.damage_max = 1
tt.dps.damage_min = 1
tt.modifier.duration = 2
tt.modifier.use_mod_offset = true
tt.render.sprites[1].prefix = "poison_violet"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"small"
}
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.25),
	vv(1.5)
}

tt = E:register_t("fx_explosion_shroom", "fx")

tt.render.sprites[1].prefix = "mushroom_mine"
tt.render.sprites[1].name = "explode"
tt.render.sprites[1].z = Z_OBJECTS
---红帽地精
tt = RT("tower_redcap", "tower")

AC(tt, "barrack", "powers")

tt.tower.type = "redcap"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.menu_offset = v(0, 10)
tt.powers.reap = E:clone_c("power")
tt.powers.reap.price_base = 300
tt.powers.reap.price_inc = 200
tt.powers.reap.id = 1
tt.powers.reap.max_level = 2
tt.powers.reap.enc_icon = 5
tt.powers.dodge = E:clone_c("power")
tt.powers.dodge.price_base = 150
tt.powers.dodge.price_inc = 150
tt.powers.dodge.id = 2
tt.powers.dodge.enc_icon = 16
tt.powers.harvest = E:clone_c("power")
tt.powers.harvest.price_base = 150
tt.powers.harvest.price_inc = 150
tt.powers.harvest.id = 3
tt.powers.harvest.enc_icon = 15
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0024" or "portraits_sc_0024"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_redcap_base_0001"
tt.render.sprites[2].offset = v(-2, 36)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].prefix = "tower_redcap_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(-1, 12)
tt.barrack.soldier_type = "soldier_redcap"
tt.barrack.rally_range = 160
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts_c.tower_barrack.insert
tt.main_script.update = scripts_c.tower_barrack.update
tt.main_script.remove = scripts_c.tower_barrack.remove
tt.sound_events.insert = "TowerRedcapTaunt"
tt.sound_events.change_rally_point = "TowerRedcapTaunt"

tt = E:register_t("soldier_redcap", "soldier_thug")

E:add_comps(tt, "melee", "pickpocket", "track_damage", "dodge", "powers")

tt.dodge.chance = 0.3
tt.dodge.chance_inc = 0.1
tt.dodge.power_name = "dodge"
tt.dodge.silent = true
tt.dodge.ranged = true
tt.dodge.pop = {
	"pop_miss_v"
}
tt.dodge.pop_offset = 40
image_y = 52
anchor_y = 0.17
tt.powers.dodge = E:clone_c("power")
tt.powers.reap = E:clone_c("power")
tt.powers.harvest = E:clone_c("power")
tt.powers.harvest.mod = "mod_redcap_heal_v"
tt.health.dead_lifetime = 10
tt.health.hp_max = 200
tt.health_bar.offset = v(0, 28)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.pickpocket.chance = 0
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 1
tt.pickpocket.steal_min = 1
tt.track_damage.mod = "mod_life_drain_v"
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0024" or IS_KR1 and "portraits_sc_0024" or "portraits_sc_0024"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_REDCAP_RANDOM_%i_NAME"
tt.main_script.insert = scripts_c.soldier_barrack.insert
tt.main_script.remove = scripts_c.soldier_barrack.remove
tt.main_script.update = scripts_c.soldier_redcap.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].order_id = 3
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].pop = {
	"pop_bladesinger_v"
}
tt.melee.attacks[2] = E:clone_c("melee_attack")
tt.melee.attacks[2].animation = "special"
tt.melee.attacks[2].power_name = "reap"
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].max_chance = 0.5--0.1
tt.melee.attacks[2].level = 0
tt.melee.attacks[2].pop = {
	"pop_splat"
}
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].hit_fx = "fx_redcap_death_blow_v"
tt.melee.attacks[2].use_target_pos = true
tt.melee.attacks[2].flip_fx = true
tt.melee.attacks[2].percentage = 5
tt.melee.attacks[2].vis_bans = bor(F_CLIFF, F_BOSS, F_MINIBOSS)
tt.melee.attacks[2].order_id = 2
tt.melee.attacks[2].fn_can = function(t, s, a, target)
	return band(target.vis.flags, a.vis_bans) == 0
end
tt.melee.attacks[2].fn_chance =  scripts_c.soldier_redcap.fn_chance_instakill
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].hit_offset = v(24, 10)
tt.melee.attacks[2].instakill = true
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[2])
tt.melee.attacks[3].damage_max = 100
tt.melee.attacks[3].damage_min = 100
tt.melee.attacks[3].order_id = 1
tt.melee.attacks[3].level = 0
tt.melee.attacks[3].hit_fx = "fx_redcap_death_blow_v"
tt.melee.attacks[3].use_target_pos = true
tt.melee.attacks[3].flip_fx = true
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].power_name = "reap"
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].flags = bor(F_BOSS, F_MINIBOSS)
tt.melee.attacks[3].vis_bans = F_CLIFF
tt.melee.attacks[3].fn_can = function(t, s, a, target)
	return band(target.vis.flags, a.flags) ~= 0
end
tt.melee.attacks[3].fn_chance =  scripts_c.soldier_redcap.fn_chance_antiboss
tt.melee.attacks[3].instakill = nil
tt.melee.cooldown = 1.2
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 25
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].angles = {}
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].anchor = v(0.5, 0.20833333333333334)
tt.render.sprites[1].prefix = "redcap"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = IS_PHONE_OR_TABLET and r(-20, -5, 40, 40) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)

tt = E:register_t("fx_redcap_death_blow_v", "fx")
tt.render.sprites[1].name = "fx_redcap_death_blow"
tt.render.sprites[1].z = Z_EFFECTS

tt = E:register_t("mod_redcap_heal_v", "modifier")

E:add_comps(tt, "hps", "render")

tt.main_script.insert = scripts_c.mod_redcap_heal.insert
tt.main_script.update = scripts_c.mod_hps.update
tt.hps.heal_min = 25
tt.hps.heal_max = 25
tt.hps.heal_every = fts(30)
tt.modifier.duration = 0
tt.modifier.duration_inc = 2
tt.modifier.keep_on_max = true
tt.render.sprites[1].name = "fx_twilight_heretic_consume"
tt.render.sprites[1].animated = true
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].loop = true

tt = E:register_t("pop_miss_v", "pop")
tt.render.sprites[1].name = "pop_conquest_0001"
tt.pop_y_offset = 40

tt = E:register_t("pop_bladesinger_v", "pop")
tt.render.sprites[1].name = "elven_pops_0014"
---哥布林萨满
tt = RT("tower_shaman", "tower")

AC(tt, "attacks", "auras", "powers")

tt.tower.type = "shaman"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.menu_offset = v(0, 10)
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "slow_aura_v"
tt.auras.list[1].cooldown = 0
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0009" or "info_portraits_sc_0009"
tt.info.enc_icon = 3
tt.auras = {}
tt.powers.healing = E:clone_c("power")
tt.powers.healing.price_base = 180
tt.powers.healing.price_inc = 150
tt.powers.healing.id = 1
tt.powers.healing.enc_icon = 1
tt.powers.speed = E:clone_c("power")
tt.powers.speed.price_base = 250
tt.powers.speed.price_inc = 220
tt.powers.speed.id = 2
tt.powers.speed.enc_icon = 2
tt.info.fn = scripts_c.tower_shaman.get_info
tt.main_script.remove = scripts_c.tower_mage_v.remove
tt.main_script.insert = scripts_c.tower_mage_v.insert
tt.main_script.update = scripts_c.tower_shaman.update
tt.attacks.range = 200
tt.attacks.list[1] = E:clone_c("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "aura_shaman_damage"
tt.attacks.list[1].cooldown = 12
tt.attacks.list[1].spawn_offset_nodes = 5
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.list[2] = E:clone_c("bullet_attack")
tt.attacks.list[2].bullet = "aura_shaman_healing"
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].animation = "heal"
tt.attacks.list[2].disabled = true
tt.attacks.list[2].threshold = 0.75
tt.attacks.list[2].shoot_time = fts(14)
tt.attacks.list[3] = E:clone_c("bullet_attack")
tt.attacks.list[3].bullet = "aura_shaman_speed"
tt.attacks.list[3].disabled = true
tt.attacks.list[3].animation = "buff"
tt.attacks.list[3].cooldown = 12
tt.attacks.list[3].max_range = 200
tt.attacks.list[3].shoot_time = fts(14)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"--"terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "tower_shaman_base_0001"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[2].animated = false
tt.render.sprites[2].scale = v(1.1, 1.1)
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].prefix = "tower_shaman_layer2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 30)
tt.render.sprites[3].scale = v(1.1, 1.1)
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = false
tt.render.sprites[4].prefix = "tower_shaman_layer3"
tt.render.sprites[4].name = "light"
tt.render.sprites[4].offset = v(-37, 19)
tt.render.sprites[4].scale = v(1.1, 1.1)
tt.render.sprites[5] = E:clone_c("sprite")
tt.render.sprites[5].prefix = "tower_shaman_layer4"
tt.render.sprites[5].name = "light"
tt.render.sprites[5].hidden = true
tt.render.sprites[5].loop = false
tt.render.sprites[5].offset = v(35, 21)
tt.render.sprites[5].scale = v(1.1, 1.1)
tt.render.sprites[6] = E:clone_c("sprite")
tt.render.sprites[6].prefix = "enemy_shaman"
tt.render.sprites[6].name = "idle"
tt.render.sprites[6].angles = {}
tt.render.sprites[6].angles.idle = {
	"idle",
	"idle"
}
tt.render.sprites[6].angles.shoot = {
	"shoot",
	"shoot"
}
tt.render.sprites[6].offset = v(0, 60)
tt.render.sprites[7] = E:clone_c("sprite")
tt.render.sprites[7].prefix = "tower_shaman_fire"
tt.render.sprites[7].name = "idle"
tt.render.sprites[7].loop = true
tt.render.sprites[7].offset = v(30, 39)
tt.render.sprites[7].random_ts = fts(1)
tt.render.sprites[7].ignore_start = true
tt.render.sprites[7].scale = v(1.1, 1.1)
tt.render.sprites[8] = E:clone_c("sprite")
tt.render.sprites[8].prefix = "tower_shaman_fire"
tt.render.sprites[8].name = "idle"
tt.render.sprites[8].loop = true
tt.render.sprites[8].offset = v(22, 60)
tt.render.sprites[8].random_ts = fts(7)
tt.render.sprites[8].scale = v(1.1, 1.1)
tt.render.sprites[8].ignore_start = true
tt.render.sprites[9] = E:clone_c("sprite")
tt.render.sprites[9].prefix = "tower_shaman_fire"
tt.render.sprites[9].name = "idle"
tt.render.sprites[9].loop = true
tt.render.sprites[9].offset = v(-28, 38)
tt.render.sprites[9].random_ts = fts(13)
tt.render.sprites[9].ignore_start = true
tt.render.sprites[9].scale = v(1.1, 1.1)
tt.render.sprites[10] = E:clone_c("sprite")
tt.render.sprites[10].prefix = "tower_shaman_fire"
tt.render.sprites[10].name = "idle"
tt.render.sprites[10].loop = true
tt.render.sprites[10].offset = v(-19, 61)
tt.render.sprites[10].random_ts = fts(19)
tt.render.sprites[10].ignore_start = true
tt.render.sprites[10].scale = v(1.1, 1.1)
tt.render.sid_tower = 3
tt.render.sid_shooter = 6
tt.sound_events.insert = "TowerShamanTaunt"

tt = RT("mod_shaman_tower_heal", "mod_shaman_heal")
tt.hps.heal_min = 7
tt.hps.heal_max = 8

tt = RT("mod_shaman_speed", "modifier")

AC(tt, "render", "tween")

tt.boost_factor = {
	0.8,
	0.7,
	0.6
}
tt.main_script.insert = scripts_c.mod_shrine_denas_tower.insert
tt.main_script.remove = scripts_c.mod_shrine_denas_tower.remove
tt.main_script.update = scripts_c.mod_shrine_bolin.update
tt.modifier.duration = 0.5
tt.modifier.use_mod_offset = false
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "totem_groundeffect-lightBlue_0002"
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(0.64, 0.64)
	},
	{
		fts(15),
		v(1, 1)
	},
	{
		fts(30),
		v(1.6, 1.6)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		50
	},
	{
		fts(10),
		255
	},
	{
		fts(20),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[2].loop = true

tt = RT("aura_shaman_healing", "aura")

AC(tt, "render", "tween")

tt.aura.mod = "mod_shaman_tower_heal"
tt.aura.cycle_time = 0.5
tt.aura.duration = {
	6,
	8,
	10
}
tt.aura.radius = 95
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = F_MOD
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "totem_groundeffect-orange_0002"
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "totem_groundeffect-orange_0001"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E:clone_c("sprite")
tt.render.sprites[3].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "start"
tt.render.sprites[3].prefix = "elder_shaman_totem_orange"
tt.render.sprites[4] = E:clone_c("sprite")
tt.render.sprites[4].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = true
tt.render.sprites[4].name = "elder_shaman_totem_orange_fx"
tt.main_script.update = scripts_c.aura_totem_shaman.update
tt.sound_events.insert = "EndlessOrcsTotemHealing"
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(0.64, 0.64)
	},
	{
		fts(15),
		v(1, 1)
	},
	{
		fts(30),
		v(1.6, 1.6)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E:clone_c("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		50
	},
	{
		fts(10),
		255
	},
	{
		fts(20),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[2].loop = true

tt = RT("aura_shaman_damage", "aura_shaman_healing")
tt.aura.cycle_time = 0.25
tt.aura.shooter = true
tt.aura.bullet = "bolt_shaman_totem"
tt.aura.duration = {
	10,
	10,
	10
}
tt.bullet_start_offset = v(0, 30)
tt.aura.radius = 120
tt.aura.vis_bans = bor(F_FRIEND)
tt.render.sprites[1].name = "totem_groundeffect-red_0002"
tt.render.sprites[2].name = "totem_groundeffect-red_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_red"
tt.render.sprites[4].name = "elder_shaman_totem_red_fx"
tt.sound_events.insert = "EndlessOrcsTotemDamage"

tt = RT("aura_shaman_speed", "aura_shaman_healing")
tt.aura.target_towers = true
tt.aura.mod = "mod_shaman_speed"
tt.aura.cycle_time = 0.2
tt.aura.radius = 200
tt.render.sprites[1].name = "totem_groundeffect-lightBlue_0002"
tt.render.sprites[2].name = "totem_groundeffect-lightBlue_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_blue"
tt.render.sprites[4].name = "elder_shaman_totem_blue_fx"
tt.sound_events.insert = "EndlessOrcsTotemSpeed"

tt = RT("bolt_shaman_totem", "bolt")
tt.bullet.damage_max = 15
tt.bullet.damage_min = 5
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_infernal_mage_hit_v"
tt.bullet.max_speed = 300
tt.bullet.pop_chance = 0.1
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.bullet.particles_name = "ps_bolt_infernal_mage_v"
tt.render.sprites[1].prefix = "demon_flareon_flare"
tt.render.sprites[1].animated = true
tt.sound_events.insert = "ElvesHeroVeznanDemonFireballThrow"
tt.sound_events.insert_args = {
	gain = 0.6
}
tt.sound_events.hit = "ElvesHeroVeznanDemonFireballHit"

-- Rebborn: Hammerhold Guards
tt = RT("tower_hammerhold_guard", "tower_barrack_1")
AC(tt, "powers")
tt.info.i18n_key = "TOWER_HAMMERHOLD_GUARD"
tt.info.portrait = "rebborn_info_portraits_hammerhold"
tt.info.enc_icon = 901
tt.tower.type = "hammerhold_guard"
tt.tower.price = 280
tt.powers.intimidation = CC("power")
tt.powers.intimidation.price_base = 250
tt.powers.intimidation.max_level = 1
tt.powers.intimidation.name = "INTIMIDATION"
tt.powers.intimidation.enc_icon = 951
tt.powers.shrugitoff = CC("power")
tt.powers.shrugitoff.armor = {5, 10, 15}
tt.powers.shrugitoff.price_base = 120
tt.powers.shrugitoff.price_inc = 120
tt.powers.shrugitoff.name = "SHRUGITOFF"
tt.powers.shrugitoff.enc_icon = 950
tt.powers.guillotine = CC("power")
tt.powers.guillotine.price_base = 180
tt.powers.guillotine.price_inc = 180
tt.powers.guillotine.name = "GUILLOTINE"
tt.powers.guillotine.enc_icon = 952
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_hammerhold_guard"
tt.barrack.rally_angle_offset = math.pi / 3
tt.barrack.rally_range = 160
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2].name = "tower_hammerhold_guard_0001"
tt.render.sprites[2].offset = v(0, 39)
tt.render.sprites[3].prefix = "tower_hammerhold_guard_door"
tt.render.sprites[3].offset = v(0, 39)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].prefix = "tower_hammerhold_guard_flag"
tt.render.sprites[4].offset = v(0, 47)
tt.sound_events.insert = "HammerholdGuardRally"
tt.sound_events.change_rally_point = "HammerholdGuardRally"

tt = RT("soldier_hammerhold_guard", "soldier_militia")
AC(tt, "powers")
anchor_y = 0.19
image_y = 42
tt.health.armor = 0.3
tt.health.flat_damage_reduction = 0
tt.health.dead_lifetime = 13
tt.health.hp_max = 350
tt.health_bar.offset = v(0, ady(40))
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0004" or "info_portraits_rebborn_sc_0120"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_HAMMERHOLD_GUARD_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "guillotine_slam"
tt.melee.attacks[2].chance = 1
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].damage_inc = 100
tt.melee.attacks[2].damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_DODGE)
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(16)
tt.melee.attacks[2].power_name = "guillotine"
tt.melee.attacks[2].cooldown = 5
tt.melee.attacks[2].sound = "guillotineslam"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.arrived_slot_animation = "idle"
tt.melee.range = 65
tt.motion.max_speed = 60
tt.main_script.update = scripts_c.soldier_hammerhold_guard.update
tt.powers.shrugitoff = CC("power")
tt.powers.guillotine = CC("power")
tt.powers.intimidation = CC("power")
tt.regen.health = 50
tt.render.sprites[1].prefix = "soldier_hammerhold_guard"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, -27)
tt.render.sprites[1].scale = v(1.05, 1.05)
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))

tt = RT("mod_intimidate", "modifier")
AC(tt, "render")
tt.inflicted_damage_factor = 0.75
tt.received_damage_factor = 1.25
tt.modifier.resets_same = true
tt.modifier.use_mod_offset = false
tt.modifier.health_bar_offset = v(0, -15)
tt.modifier.duration = 1.5
tt.main_script.insert = scripts.mod_damage_factors.insert
tt.main_script.remove = scripts.mod_damage_factors.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "hammerhold_guard_intimidation"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.custom_offsets = {
	enemy_wolf = v(0, -4),
	enemy_spider_big = v(0, -5),
	enemy_slayer = v(0, -4),
	enemy_lava_elemental = v(-5, -5),
	enemy_sarelgaz_small = v(5, -5),
	eb_sarelgaz = v(20, -20),
	enemy_forest_troll = v(3, -10),
	eb_gulthak = v(-4, -2),
	enemy_troll_brute = v(0, -5),
	eb_ulgukhai = v(0, -8),
	enemy_swamp_thing = v(2, -3),
	eb_greenmuck = v(0, -5),
	eb_myconid = v(0, -5),
	enemy_fallen_knight = v(0, -5),
	enemy_spectral_knight = v(0, -5),
	eb_blackburn = v(0, -15),
	enemy_cursed_shaman = v(0, -3),
	enemy_hobgoblin_shield = v(0, -8),
	eb_hobgoblin = v(0, -5),
	enemy_cursed_golem = v(0, -6),
	enemy_executioner = v(0, -4),
	enemy_umbral_acolyte = v(0, -5),
	enemy_primordial = v(0, -4)
}

-- Rebborn: Sand Mystic
tt = RT("tower_sandmystic_polarity_ray", "ray_arcane_disintegrate")
tt.bullet.mod = "mod_ray_arcane_disintegrate"
tt.image_width = 166
tt.render.sprites[1].name = "tower_sandmystic_polarity_ray"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "DesintegrateSound"

tt = RT("tower_sandmystic", "tower")
AC(tt, "attacks", "powers")
tt.tower.type = "sandmystic"
tt.tower.kind = TOWER_KIND_ENGINEER
tt.tower.level = 1
tt.tower.price = 450
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 902
tt.info.fn = scripts_c.tower_sandmystic.get_info
tt.info.i18n_key = "TOWER_SAND_MYSTIC"
tt.info.portrait = "rebborn_info_portraits_sandmystic"
tt.powers.polarity = CC("power")
tt.powers.polarity.price_base = 300
tt.powers.polarity.price_inc = 200
tt.powers.polarity.max_level = 3
tt.powers.polarity.enc_icon = 953
tt.powers.polarity.name = "CHARGED_BOLT"
tt.powers.attraction = CC("power")
tt.powers.attraction.price_base = 500
tt.powers.attraction.price_inc = 300
tt.powers.attraction.max_level = 1
tt.powers.attraction.enc_icon = 954
tt.powers.attraction.name = "FATAL_ATTRACTION"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_tesla_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "SandMystic_0001"
tt.render.sprites[2].offset = v(3, 50)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "shooter_sandmystic"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(4, 52)
tt.render.sprites[3].fps = 15
tt.main_script.update = scripts_c.tower_sandmystic.update
tt.main_script.remove = scripts_c.tower_sandmystic.remove
tt.sound_events.insert = "SandMysticTauntIntro"
tt.attacks.min_cooldown = 2
tt.attacks.range = 190
tt.attacks.range_check_factor = 1.1
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "ray_sandmystic"
tt.attacks.list[1].bullet_start_offset = v(2, 88)
tt.attacks.list[1].cooldown = 2.2
tt.attacks.list[1].decay_cooldown = 3
tt.attacks.list[1].node_prediction = fts(6)
tt.attacks.list[1].range = 190
tt.attacks.list[1].damage_min = 44
tt.attacks.list[1].damage_max = 88
tt.attacks.list[1].shoot_time = fts(22)
tt.attacks.list[1].sound_shoot = "SandMysticSFXAttack"
tt.attacks.list[1].payload_name = "aura_sandmystic_shockwave"
tt.attacks.list[1].max_charge = 5
tt.attacks.list[1].vis_bans = bor(F_FRIEND)
tt.attacks.list[1].vis_flags = bor(F_AREA, F_RANGED)
tt.attacks.list[2] = CC("aura_attack")
tt.attacks.list[2].radius = 40
tt.attacks.list[2].aoe_inc = 10
tt.attacks.list[2].fx_ramp_size_factor = 0.5
tt.attacks.list[2].damage_per_armor_point = 1
tt.attacks.list[2].cooldown = 10
tt.attacks.list[2].bullet_start_offset = v(0, 88)
tt.attacks.list[2].payload_name = "tower_sandmystic_polarity_ray_payload"
tt.attacks.list[2].animation = "polarity"
tt.attacks.list[2].node_prediction = fts(1)
tt.attacks.list[2].shoot_time = fts(26)
tt.attacks.list[3] = CC("aura_attack")
tt.attacks.list[3].animation = "attraction"
tt.attacks.list[3].aura = "aura_sandmystic_attraction"
tt.attacks.list[3].cooldown = 24
tt.attacks.list[3].shoot_time = fts(28)
tt.attacks.list[3].sound = "SandMysticSFXAttraction"
tt.attacks.list[3].vis_bans = F_FRIEND
tt.attacks.list[3].vis_flags = bor(F_MOD, F_AREA)

tt = RT("aura_sandmystic_shockwave", "aura_tesla_overcharge")
tt.fx = "fx_sandmystic_ray_explosion"
tt.aura.duration = fts(3)
tt.aura.aoe_level = 0
tt.aura.aoe_inc = 20
tt.aura.radius = 52.5
tt.aura.reduce_armor = 0.5
tt.main_script.update = scripts_c.aura_sandmystic_shockwave.update

tt = RT("ray_sandmystic", "bullet")
tt.bullet.payload = "aura_sandmystic_shockwave"
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = 0
tt.image_width = 150
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].anchor = v(0.1, 0.5)
tt.render.sprites[1].name = "sandmystic_ray"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "ArcaneRaySound"

tt = RT("sandmystic_bolt", "bullet")
tt.bullet.payload = "aura_sandmystic_shockwave"
tt.bullet.damage_type = DAMAGE_ELECTRICAL
tt.bullet.acceleration_factor = 0.3
tt.bullet.hit_fx = "fx_sandmystic_ray_explosion"
tt.bullet.max_speed = 450
tt.bullet.min_speed = 150
tt.bullet.pop = nil
tt.bullet.hit_time = fts(7)
tt.render.sprites[1].name = "sandmystic_ray"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.sound_events.insert = "TeslaAttack"

tt = RT("fx_sandmystic_ray_explosion", "fx")
tt.render.sprites[1].name = "tower_sandmystic_ray_payload"
tt.render.sprites[1].fps = 20
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(0, 20)

tt = RT("fx_sandmystic_polarity_ray_explosion", "fx")
tt.render.sprites[1].name = "tower_sandmystic_polarity_ray_payload"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(0, 20)

tt = RT("aura_sandmystic_attraction", "aura")
AC(tt, "render", "tween")
tt.aura.mod = "mod_slow_sandmystic"
tt.aura.duration = 6
tt.aura.duration_inc = 0
tt.aura.cycle_time = 0.3
tt.aura.radius = 51.2
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "FatalAttraction_0001"
tt.render.sprites[1].alpha = 100
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].offset = v(0, 22)
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{0, 0},
	{0.75, 120},
	{1.5, 40},
	{2.25, 120},
	{3, 40},
	{3.75, 120},
	{4.5, 40},
	{5.25, 120},
	{6, 0}
}
tt.tween.props[2] = CC("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{0, v(0.6, 0.6)},
	{0.3, v(1, 1)}
}
tt.tween.remove = false

tt = RT("mod_slow_sandmystic", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.25


-- Rebborn 2 heroes and Hammerhold campaign dependencies
tt = E:register_t("decal_ka_hor", "decal_scripted")

AC(tt, "ui", "render", "editor")

tt.main_script.update = scripts.decal_ka_hor.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "kahor_tomb"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "kahor_tomb_glow"
tt.render.sprites[2].offset = v(0, 44)
tt.render.sprites[2].name = "start"
tt.render.sprites[2].alpha = 0
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "kahor_guy"
tt.render.sprites[3].offset = v(0, 25)
tt.render.sprites[3].name = "start"
tt.render.sprites[3].alpha = 0
tt.render.sprites[3].fps = 15
tt.achievement_id = "KA_HOR"
tt.excluded_templates = {
	"tower_barrack_1",
	"tower_barrack_2",
	"tower_barrack_3",
	"tower_barbarian",
	"tower_paladin",
	"tower_assassin",
	"tower_templar",
	"tower_forest",
	"tower_blade",
	"tower_elf_kr1",
	"tower_imperial_patrol",
	"tower_barrack_pirate_captain",
	"tower_barrack_pirate_captain_2",
	"tower_barrack_pirate_flamer_2",
	"tower_barrack_pirate_anchor_2",
	"tower_barrack_amazonas_re",
	"tower_barrack_dwarf",
	"tower_ewok_rework",
	"tower_drow",
	"tower_orc_warriors_den",
	"tower_dark_knights",
	"tower_elven_barrack_1",
	"tower_elven_barrack_2",
	"tower_elven_barrack_3",
	"tower_sasquash_rework",
	"tower_pixie",
	"tower_barrack_1_krf",
	"tower_barrack_2_krf",
	"tower_barrack_3_krf",
	"tower_elite_harassers",
	"tower_steam_troop",
	"tower_hammerhold_guard",
	"tower_grim_cemetery",
	"tower_barrack_1_v",
	"tower_barrack_2_v",
	"tower_barrack_3_v",
	"tower_sandmystic",
	"tower_crossbow",
	"tower_eldritch_mage_1",
	"tower_eldritch_mage_2",
	"tower_eldritch_mage_3",
	"tower_wild_magus",
	"tower_bfg"
}
tt.ui.click_rect = r(-35, -30, 70, 60)
tt.mod = "mod_ka_hor"
tt.loop_times = 10
tt = E:register_t("decal_sphinx", "decal_scripted")
tt.main_script.update = scripts.decal_sphinx.update
tt.render.sprites[1].name = "sphinx_body"
tt.render.sprites[1].animated = false
tt.render.sprites[1].r = 0.15
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "sphinx"
tt.render.sprites[2].r = tt.render.sprites[1].r
tt.idle_cooldown = 4
tt.reward = 100
tt.gold_multiplier = 1.5
tt.heroic_multiplier = 4
tt.heroic_obelisk_ready = false
tt.iron_multiplier = 8
tt.iron_cooldown_ready = false
tt.iron_cooldown = 15
tt.achievement_id = "SPHINX_ALL"
tt.achievement_id2 = "SPHINX_NONE"
tt.count = 3
tt.draft = {
	8,
	8,
	8
}
tt = E:register_t("decal_sphinx_item", "decal_scripted")

E:add_comps(tt, "ui")

tt.main_script.update = scripts.decal_sphinx_item.update
tt.price = 100
tt.iron_price = 0
tt.render.sprites[1].prefix = "sphinx_bowl"
tt.render.sprites[1].offset = v(0, 38)
tt.render.sprites[1].fps = 20
tt.motion_max_speed = 1.5
tt.hypotenuse = 0.44
tt.size_x = 30
tt.size_y = tt.size_x
tt.offset_x = -150
tt.offset_y = 10
tt.ui.click_rect = r(-15, -9, 30, 25)
tt = E.register_t(E, "decal_ramses", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "ramses"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].fps = 20
tt.main_script.update = scripts.decal_ramses.update
tt.idle_cooldown = fts(300)
tt.ui.can_click = true
tt.ui.click_rect = r(-15, -30, 30, 60)
tt.achievement_id = "RETURN_THE_SLAB"
tt = E.register_t(E, "decal_shockidy", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "shockidy"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = v(1, 1)
tt.render.sprites[1].fps = 15
tt.main_script.update = scripts.decal_shockidy.update
tt.ui.can_click = true
tt.ui.click_rect = r(6, -10, 25, 25)
tt = RT("enemy_fremen", "enemy")

AC(tt, "melee")

image_y = 32
image_x = 46
anchor_y = 0.2
anchor_x = 0.5
tt.enemy.gold = 12
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	240,
	280,
	320,
	320,
	360
}
tt.health_bar.offset = v(0, 35)
tt.info.enc_icon = 261
tt.info.i18n_key = "ENEMY_FREMEN"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0006" or "info_portraits_rebborn_sc_0107"
tt.melee.attacks[1].cooldown = 0.5
tt.melee.attacks[1].damage_max = 35
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(7)
tt.motion.max_speed = {
	FPS * 1.8,
	FPS * 1.8,
	FPS * 1.8,
	FPS * 1.8,
	FPS * 1.8
}
tt.render.sprites[1].anchor = v(0.5, 0.23)
tt.render.sprites[1].prefix = "enemy_fremen"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].angles.walk = {
	"walk",
	"walkUp",
	"walkDown"
}
tt.sound_events.raise = "FremenSpawnSFX"
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 8)
tt.unit.mod_offset = v(adx(22), ady(20))
tt.unit.marker_offset = v(0, 2)
tt.vis.flags = F_ENEMY
tt = RT("enemy_sand_monk", "enemy")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.23
anchor_x = 0.5
image_x = 68
image_y = 88
tt.enemy.gold = 50
tt.enemy.melee_slot = v(23, 0)
tt.health.magic_armor = 0.75
tt.health.armor = 0
tt.health.hp_max = {
	800,
	1000,
	1200,
	1600,
	2000
}
tt.health_bar.offset = v(0, 55)
tt.info.i18n_key = "ENEMY_SAND_MONK"
tt.info.enc_icon = 262
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0007" or "info_portraits_rebborn_sc_0105"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_sand_monk.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "skill"
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].mod = "mod_sand_monk"
tt.timed_attacks.list[1].range = 200
tt.timed_attacks.list[1].shoot_time = fts(11)
tt.timed_attacks.list[1].sound = "SandMonkSpell"
tt.timed_attacks.list[1].allowed_templates = {
	"tower_necromancer",
	"tower_sorcerer",
	"tower_time_wizard",
	"tower_frankenstein",
	"tower_druid",
	"tower_bone_flingers",
	"tower_spectres_mausoleum"
}
tt.motion.max_speed = FPS * 0.8
tt.ui.click_rect.size = v(32, 44)
tt.ui.click_rect.pos.x = -16
tt.render.sprites[1].anchor = v(0.5, 0.25)
tt.render.sprites[1].prefix = "enemy_sand_monk"
tt.sound_events.death = "DeathHuman"
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(33), ady(40))
tt.vis.flags = bor(F_ENEMY, F_SPELLCASTER)
tt = RT("mod_sand_monk", "modifier")

AC(tt, "render", "tween")

tt.range_factor = 0.6666666666666666
tt.cooldown_factor = 1
tt.main_script.insert = scripts.mod_sand_monk.insert
tt.main_script.remove = scripts.mod_sand_monk.remove
tt.main_script.update = scripts.mod_sand_monk.update
tt.modifier.duration = 7.9
tt.modifier.allows_duplicates = false
tt.modifier.use_mod_offset = false
tt.render.sprites[1].draw_order = 11
tt.render.sprites[1].prefix = "enemy_sand_monk_mod"
tt.render.sprites[1].scale = v(1.3, 1.3)
tt.render.sprites[1].anchor = v(0.5, 0)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset.x = 14
tt.render.sprites[1].offset.y = -25
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.remove = false
tt = E.register_t(E, "enemy_umbral_acolyte", "enemy")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "count_group")

anchor_y = 0.28
image_y = 44
tt.count_group.name = "enemy_umbral_acolyte"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.enemy.gold = 60
tt.enemy.melee_slot = v(19, -5)
tt.health.hp_max = {
	500,
	600,
	700,
	800,
	1000
}
tt.health_bar.offset = v(0, ady(50))
tt.health.magic_armor = {
	0.85,
	0.85,
	0.85,
	0.85,
	0.85
}
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0007" or "info_portraits_rebborn_sc_0106"
tt.info.enc_icon = 263
tt.info.i18n_key = "ENEMY_UMBRAL_ACOLYTE"
tt.main_script.insert = scripts2.enemy_basic.insert
tt.main_script.update = scripts_c.enemy_umbral_acolyte.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = {
	FPS * 0.512 * 1.28,
	FPS * 0.512 * 1.28,
	FPS * 0.512 * 1.28,
	FPS * 0.512 * 1.28,
	FPS * 0.512 * 1.28
}
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "ray_rebborn_umbral_acolyte"
tt.ranged.attacks[1].bullet_start_offset = {
	v(11, ady(44))
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 180
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(11)
tt.ranged.attacks[1].vis_bans = 0
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_umbral_acolyte"
tt.sound_events.death = "DeathHuman"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "skill"
tt.timed_attacks.list[1].aura = "enemy_umbral_acolyte_teleport_aura"
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].shoot_time = 2
tt.timed_attacks.list[1].excluded_templates = {
	"enemy_wasp",
	"enemy_wasp_queen",
	"enemy_munra",
	"enemy_umbral_acolyte",
	"enemy_tremor"
}
tt.timed_attacks.list[1].nodes_offset = 0
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_TELEPORT)
tt.timed_attacks.list[1].path_margins = {
	1,
	30
}
tt.timed_attacks.list[1].range = 180
tt.timed_attacks.list[1].sound = "UmbralAcolyteOpenPortal"
tt.timed_attacks.list[1].spawn_time = fts(6)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 9)
tt.unit.marker_offset = v(0, -5)
tt.unit.mod_offset = v(0, ady(25))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_SPELLCASTER, F_RANGED)
tt = E.register_t(E, "ray_rebborn_umbral_acolyte", "bullet")
tt.image_width = 238
tt.main_script.update = scripts2.ray_enemy.update
tt.render.sprites[1].name = "ray_umbra_guy"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 60
tt.bullet.damage_max = 90
tt.bullet.damage_radius = 60
tt.bullet.max_track_distance = 50
tt.bullet.vis_bans = bor(F_ENEMY)
tt.bullet.vis_flags = bor(F_RANGED, F_AREA)
tt.bullet.hit_time = fts(7)
tt.bullet.hit_fx = "fx_rebborn_ray_umbra_explosion"
tt.sound_events.insert = "TeslaAttack"
tt = E.register_t(E, "fx_rebborn_ray_umbra_explosion", "fx")
tt.render.sprites[1].name = "ray_umbra_guy_explosion"
tt = E:register_t("enemy_umbral_acolyte_teleport_aura", "aura")

E:add_comps(tt, "render")

tt.main_script.update = scripts.enemy_umbral_acolyte_teleport_aura.update
tt.aura.mod = "mod_enemy_umbral_acolyte_teleport"
tt.render.sprites[1].prefix = "umbra_portal"
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].z = Z_DECALS
tt.aura.radius = 75
tt.aura.duration = {
	4,
	4,
	4,
	6,
	6
}
tt.excluded_templates = {
	"enemy_wasp",
	"enemy_wasp_queen",
	"enemy_munra",
	"enemy_umbral_acolyte",
	"enemy_tremor"
}
tt = E.register_t(E, "mod_enemy_umbral_acolyte_teleport", "mod_teleport")
tt.delay_end = fts(11)
tt.delay_start = fts(1)
tt.modifier.vis_bans = bor(F_FLYING)
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.nodes_offset = 30
tt.boss_nodes_offset = 30
tt.max_times_applied = 3
tt.fx_start = "fx_rebborn_xerxes_teleport_start"
tt.fx_end = "fx_rebborn_xerxes_teleport_end"
tt.modifier.use_mod_offset = false
tt = E.register_t(E, "fx_rebborn_xerxes_teleport_start", "fx")
tt.render.sprites[1].prefix = "fx_xerxes_teleport_start"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].anchor.y = 0.22727272727272727
tt = E.register_t(E, "fx_rebborn_xerxes_teleport_end", "fx")
tt.render.sprites[1].name = "fx_xerxes_teleport_end"
tt.render.sprites[1].anchor.y = 0.16666666666666666
tt = RT("fx_spawn_fallen", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_spawn_fallen"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"small"
}
tt = RT("enemy_primordial", "enemy")

AC(tt, "melee", "auras")

tt.main_script.insert = scripts.enemy_primordial.insert
anchor_y = 0.32
anchor_x = 0.5
image_y = 118
image_x = 154
tt.enemy.gold = 300
tt.primordial_immortality = false
tt.enemy.lives_cost = {
	5,
	5,
	5,
	5,
	20
}
tt.enemy.melee_slot = v(33, 0)
tt.health.hp_max = {
	6000,
	7000,
	8000,
	9000,
	10000
}
tt.health.magic_armor = 0.4
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.health_bar.offset = v(0, 69)
tt.info.i18n_key = "ENEMY_PRIMORDIAL"
tt.info.enc_icon = 264
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0103" or "info_portraits_rebborn_sc_0103"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 55
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].dodge_time = fts(10)
tt.motion.max_speed = {
	FPS * 0.6,
	FPS * 0.6,
	FPS * 0.6,
	FPS * 0.6,
	FPS * 0.6
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_primordial"
tt.render.sprites[1].name = "raise"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(44, 58)
tt.ui.click_rect.pos.x = -22
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 40)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(75), ady(60))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_DRILL, F_EAT, F_STUN)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt = E:register_t("aura_primordial", "aura")

E:add_comps(tt, "render")

tt.main_script.update = scripts.aura_primordial.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "TotemTower_GroundEffect-Red_0001"
tt.render.sprites[1].z = Z_DECALS
tt.delay = 0.1
tt.range = 128
tt.entity_name = "enemy_immortal"
tt.summon_name = "enemy_fallen"
tt.excluded_templates = {
	"enemy_wasp",
	"enemy_wasp_queen",
	"enemy_skeleton",
	"enemy_skeleton_big",
	"enemy_tremor",
	"enemy_scorpion",
	"enemy_desert_wolf_small",
	"enemy_desert_wolf",
	"enemy_sheep",
	"enemy_sheep_fly",
	"enemy_rabbit"
}
tt = RT("enemy_set", "enemy")

AC(tt, "melee", "auras", "timed_attacks")

tt.main_script.insert = scripts.enemy_set.insert
tt.main_script.update = scripts.enemy_set.update
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_set_fire"
tt.auras.list[1].cooldown = 0
anchor_y = 0.32
anchor_x = 0.5
image_y = 118
image_x = 154
tt.phase = 1
tt.enemy.gold = 2500
tt.enemy.lives_cost = 20
tt.health.hp_max = {
	8000,
	9000,
	10000,
	12000,
	15000
}
tt.health.armor = 0
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, 110)
tt.enemy.melee_slot = v(30, -5)
tt.health.dead_lifetime = 5
tt.info.i18n_key = "ENEMY_SET"
tt.info.enc_icon = 265
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0103" or "info_portraits_rebborn_sc_0108"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_radius = 57.5
tt.melee.attacks[1].hit_offset = v(20, 0)
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].dodge_time = fts(10)
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animations = {
	"skill_start",
	"skill",
	"skill_end"
}
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].cooldown = 30
tt.timed_attacks.list[1].max_range = 2000
tt.timed_attacks.list[1].cast_time_2 = 10
tt.timed_attacks.list[1].glow_mod = "mod_set_glow"
tt.timed_attacks.list[1].mod = "mod_set_polymorph"
tt.timed_attacks.list[1].sound = "SetSpellChannel"
tt.timed_attacks.list[1].sound2 = "SetSpellChannelFinish"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_fallen"
}
tt.timed_attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[2].cooldown = 10
tt.timed_attacks.list[2].entity = "set_obelisk"
tt.timed_attacks.list[2].sound = "EnemyHealing"
tt.timed_attacks.list[2].loops = {
	1,
	1,
	2,
	3
}
tt.timed_attacks.list[2].allowed_templates = {
	"enemy_fallen"
}
tt.timed_attacks.list[2].duration = 8
tt.timed_attacks.list[2].x_locations = {
	596,
	65,
	360,
	75,
	190,
	12,
	115,
	514
}
tt.timed_attacks.list[2].y_locations = {
	521,
	450,
	525,
	517,
	520,
	362,
	197,
	100
}
tt.motion.max_speed = {
	FPS * 0.45,
	FPS * 0.45,
	FPS * 0.45,
	FPS * 0.45,
	FPS * 0.45
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_set"
tt.render.sprites[1].fps = 15
tt.render.sprites[1].offset = v(0, 40)
tt.sound_events.insert = "MusicBossFightReBBBornHammerhold"
tt.sound_events.firstdeath = "SetResurrection"
tt.sound_events.revive = "SetResurrection2"
tt.sound_events.death = "SetResurrection"
tt.ui.click_rect.size = v(60, 110)
tt.ui.click_rect.pos.x = -22
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 40)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(75), ady(90))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL, F_DRILL, F_EAT, F_STUN)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt = RT("enemy_set_2", "enemy_set")
tt.death_spawns = nil
tt.health.dead_lifetime = 10
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_set_fire_2"
tt.auras.list[1].cooldown = 0
tt.melee.attacks[1].damage_max = 240
tt.melee.attacks[1].damage_min = 160
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_fallen",
	"enemy_fallen",
	"enemy_immortal"
}
tt.timed_attacks.list[1].cooldown = 40
tt.timed_attacks.list[2].entity = "set_obelisk_2"
tt.sound_events.insert = "MusicBossFightReBBBornHammerhold2"
tt.sound_events.death = "DeathBig"
tt = E.register_t(E, "aura_set_fire", "aura")

E.add_comps(E, tt)

tt.aura.mod = "mod_set_fire"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 128
tt.aura.track_source = true
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt = RT("aura_set_fire_2", "aura_set_fire")
tt.aura.mod = "mod_set_fire_2"
tt = E.register_t(E, "set_obelisk", "decal_scripted")

E.add_comps(E, tt, "render", "tween", "spawner", "sound_events")

tt.main_script.update = scripts.set_obelisk.update
tt.render.sprites[1].prefix = "xerxes_obelisk"
tt.render.sprites[1].anchor.y = 0.17105263157894737
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "cementery_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "fx_xerxes_obelisk"
tt.render.sprites[3].offset.y = 30
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	}
}
tt.tween.props[2].sprite_id = 3
tt.tween.remove = false
tt.sound_events.insert = "EndlessDesertPowerObelysk"
tt.spawner.cycle_time_min = 1
tt.spawner.cycle_time_max = 1
tt.spawner.node_range = 8
tt.spawner.entities = {
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen"
}
tt = RT("set_obelisk_2", "set_obelisk")
tt.spawner.entities = {
	"enemy_immortal",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen",
	"enemy_fallen"
}
tt = RT("stage31_heroic_obelisk", "set_obelisk")
tt.spawner.entities = {
	"enemy_immortal",
	"enemy_immortal",
	"enemy_immortal",
	"enemy_immortal",
	"enemy_immortal",
	"enemy_immortal",
	"enemy_fallen"
}
tt = E:register_t("aura_set", "aura_primordial")
tt.range = 200
tt = RT("mod_set_glow", "modifier")

AC(tt, "render")

tt.damage_factor_increase = 1
tt.main_script.insert = scripts.mod_spectral_knight.insert
tt.main_script.remove = scripts.mod_spectral_knight.remove
tt.main_script.update = scripts.mod_track_target.update
tt.max_times_applied = 1
tt.modifier.duration = 11
tt.modifier.use_mod_offset = false
tt.modifier.vis_flags = bor(F_MOD)
tt.render.sprites[1].anchor = v(0, 0)
tt.render.sprites[1].name = "fx_xerxes_obelisk"
tt.render.sprites[1].offset = v(-32, -4)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].color = {
	255,
	0,
	0,
	0
}
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "fx_xerxes_obelisk"
tt.render.sprites[2].color = {
	255,
	0,
	0,
	0
}
tt = RT("mod_set_fire", "mod_lava")
tt.dps.damage_min = 3
tt.dps.damage_max = 3
tt.dps.damage_inc = 0
tt.dps.damage_every = fts(10)
tt.dps.damage_type = DAMAGE_TRUE
tt.modifier.duration = fts(30)
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.modifier.vis_bans = bor(F_FLYING)
tt = RT("mod_set_fire_2", "mod_set_fire")
tt.dps.damage_min = 8
tt.dps.damage_max = 8
tt = E.register_t(E, "aura_empty_nil", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = nil
tt.aura.cycle_time = 10000000
tt.aura.duration = 0
tt.aura.radius = 0
tt.aura.track_source = true
tt.aura.allowed_templates = {}
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt = RT("mod_set_polymorph", "mod_polymorph")
tt.modifier.use_mod_offset = true
tt.modifier.remove_banned = true
tt.modifier.ban_types = {
	MOD_TYPE_FAST
}
tt.main_script.insert = scripts.mod_set_polymorph.insert
tt.polymorph.custom_entity_names.default = "enemy_immortal"
tt.polymorph.custom_entity_names.enemy_immortal = "enemy_primordial"
tt.polymorph.hit_fx_sizes = {
	"fx_mod_polymorph_sorcerer_small",
	"fx_mod_polymorph_sorcerer_big",
	"fx_mod_polymorph_sorcerer_big"
}
tt.polymorph.pop = {
	"pop_puff"
}
tt = RT("eb_malagar", "boss")

AC(tt, "timed_attacks", "taunts", "ranged", "auras")

tt.last_wave = 15
anchor_y = 0.17010309278350516
anchor_x = 0.5
image_y = 194
image_x = 214
tt.firsttime = false
tt.enemy.gold = 350
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = {
	5999,
	6999,
	7999,
	8999,
	9999
}
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_empty_nil"
tt.auras.list[1].cooldown = 0
tt.health.ignore_damage = true
tt.health_bar.hidden = true
tt.health_bar.z = Z_OBJECTS + 1
tt.health_bar.offset = v(0, 0)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.i18n_key = "EB_MALAGAR"
tt.info.enc_icon = 266
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0056" or "info_portraits_rebborn_sc_0109"
tt.health.on_damage = scripts.eb_malagar.on_damage
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_malagar.update
tt.motion.max_speed = {
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4
}
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_malagar"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = v(1.75, 1.75)
tt.sound_events.death = "TeleporthSound"
tt.render.sprites[1].offset = v(0, 0)
tt.ui.click_rect = r(-18, 0, 32, 36)
tt.unit.hit_offset = v(0, 0)
tt.unit.mod_offset = v(0, 0)
tt.unit.marker_offset = v(0, 0)
tt.health.immune_to = bor(DAMAGE_EAT)
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_ALL, F_EAT, F_NET)
tt.vis_bans_rest = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_ALL, F_EAT)
tt.vis_bans = bor(F_BLOCK, F_POLYMORPH, F_TELEPORT, F_THORN, F_NET)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_FLYING)
tt.pos_castle = v(527, 525)
tt.souls_aura = "veznan_souls_aura"
tt.white_circle = "decal_eb_veznan_white_circle"
tt.taunts.animation = "idle"
tt.taunts.delay_min = fts(400)
tt.taunts.delay_max = fts(700)
tt.taunts.duration = 4
tt.taunts.decal_name = "decal_malagar_shoutbox"
tt.taunts.offset = v(0, 46)
tt.taunts.pos = v(593, 625)
tt.taunts.sets.welcome = CC("taunt_set")
tt.taunts.sets.welcome.format = "MALAGAR_TAUNT_%04d"
tt.taunts.sets.welcome.end_idx = 2
tt.taunts.sets.welcome.delays = {
	fts(60),
	fts(60)
}
tt.taunts.sets.rest = CC("taunt_set")
tt.taunts.sets.rest.format = "MALAGAR_TAUNT_%04d"
tt.taunts.sets.rest.start_idx = 3
tt.taunts.sets.rest.end_idx = 24
tt.taunts.sets.damage = CC("taunt_set")
tt.taunts.sets.damage.format = "MALAGAR_TAUNT_%04d"
tt.taunts.sets.damage.start_idx = 25
tt.taunts.sets.damage.end_idx = 30
tt.taunts.sets.wait = CC("taunt_set")
tt.taunts.sets.wait.format = "MALAGAR_TAUNT_%04d"
tt.taunts.sets.wait.start_idx = 31
tt.taunts.sets.wait.end_idx = 59
tt.taunts.sets.wait.delay_min = fts(300)
tt.taunts.sets.wait.delay_max = fts(600)
tt.taunts.sets.pre_battle = CC("taunt_set")
tt.taunts.sets.pre_battle.format = "MALAGAR_TAUNT_%04d"
tt.taunts.sets.pre_battle.start_idx = 60
tt.taunts.sets.pre_battle.end_idx = 60
tt.ranged.attacks[1].bullet = "ray_malagar_boss"
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, 90)
}
tt.ranged.attacks[1].vis_bans = F_FLYING
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_AREA)
tt.ranged.attacks[1].hold_advance = false
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].animation = "idle_tower_skill"
tt.timed_attacks.list[1].hit_time = fts(18)
tt.timed_attacks.list[1].mod = "mod_malagar_tower"
tt.timed_attacks.list[1].sound = "VeznanHoldCast"
tt.timed_attacks.list[1].attack_duration = fts(24)
tt.timed_attacks.list[1].data = {
	[5] = {
		30,
		2
	},
	[6] = {
		30,
		2
	},
	[7] = {
		30,
		2
	},
	[8] = {
		30,
		2
	},
	[9] = {
		25,
		2
	},
	[10] = {
		25,
		2
	},
	[11] = {
		25,
		2
	},
	[12] = {
		25,
		2
	},
	[13] = {
		20,
		2
	},
	[14] = {
		20,
		2
	},
	[15] = {
		20,
		2
	}
}
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 15
tt.timed_attacks.list[2].animation = "idle_shield_skill"
tt.timed_attacks.list[2].max_range = 400
tt.timed_attacks.list[2].max_count = 100
tt.timed_attacks.list[2].hit_time = fts(14)
tt.timed_attacks.list[2].entities = {
	"mod_malagar_shield_physical",
	"mod_malagar_shield_magical"
}
tt.timed_attacks.list[2].sound = "VeznanHoldCast"
tt.timed_attacks.list[2].attack_duration = fts(24)
tt.teleport_fx = "fx_teleport_orange"
tt.teleport_sound = "MalagarTeleport"
tt.mid_level = {
	sa_max_count = 100,
	ba_cooldown = 15,
	sa_animation = "shield_skill",
	sa_cooldown = 15,
	ba_count = 3,
	ranged_bullet = "ray_malagar_mid",
	ba_animation = "tower_skill",
	pi = {
		7,
		8,
		7,
		8
	},
	waves = {
		4,
		8,
		12
	}
}
tt.battle = {
	sa_cooldown = 15,
	sa_max_count = 100,
	ba_cooldown = 5,
	sa_animation = "shield_skill",
	ranged_bullet = "ray_malagar_boss",
	ba_animation = "tower_skill"
}
tt = RT("eb_malagar_clone", "boss")

AC(tt, "timed_attacks", "ranged")

anchor_y = 0.17010309278350516
anchor_x = 0.5
image_y = 194
image_x = 214
tt.enemy.gold = 350
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = {
	2666,
	3000,
	3333,
	3666,
	4000
}
tt.health_bar.offset = v(0, 78)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.i18n_key = "EB_MALAGAR_CLONE"
tt.info.enc_icon = 100
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0056" or "info_portraits_rebborn_sc_0109"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_malagar_clone.update
tt.motion.max_speed = {
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4,
	FPS * 0.4
}
tt.render.sprites[1].offset.y = 34
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_malagar"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].scale = v(1.75, 1.75)
tt.sound_events.death = "TeleporthSound"
tt.ui.click_rect = r(-14, 34, 28, 30)
tt.unit.hit_offset = v(0, 54)
tt.unit.mod_offset = v(0, 54)
tt.unit.marker_offset = v(0, 0)
tt.health.immune_to = bor(DAMAGE_EAT)
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_BLOCK, F_NET)
tt.vis.flags = bor(F_ENEMY, F_MINIBOSS, F_BOSS, F_FLYING)
tt.ranged.attacks[1].bullet = "ray_malagar_mid"
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "shield_skill"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-5, 65)
}
tt.ranged.attacks[1].vis_bans = F_FLYING
tt.ranged.attacks[1].vis_flags = bor(F_RANGED, F_AREA)
tt.ranged.attacks[1].hold_advance = false
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].animation = "tower_skill"
tt.timed_attacks.list[1].hit_time = fts(18)
tt.timed_attacks.list[1].mod = "mod_malagar_tower"
tt.timed_attacks.list[1].sound = "VeznanHoldCast"
tt.timed_attacks.list[1].attack_duration = fts(24)
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 15
tt.timed_attacks.list[2].animation = "shield_skill"
tt.timed_attacks.list[2].max_range = 400
tt.timed_attacks.list[2].max_count = 50
tt.timed_attacks.list[2].hit_time = fts(18)
tt.timed_attacks.list[2].entities = {
	"mod_malagar_shield_physical",
	"mod_malagar_shield_magical"
}
tt.timed_attacks.list[2].sound = "VeznanHoldCast"
tt.timed_attacks.list[2].attack_duration = fts(24)
tt = E.register_t(E, "ray_malagar_boss", "ray_rebborn_umbral_acolyte")
tt.main_script.update = scripts2.ray_enemy.update
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 666
tt.bullet.damage_max = 999
tt.bullet.damage_radius = 60
tt.bullet.damage_bans = bor(F_ENEMY)
tt = E.register_t(E, "ray_malagar_mid", "ray_malagar_boss")
tt.bullet.damage_min = 100
tt.bullet.damage_max = 200
tt = E:register_t("mod_malagar_shield_physical", "modifier")

AC(tt, "render")

tt.modifier.remove_on_entry = "mod_malagar_shield_magical"
tt.modifier.allows_duplicates = false
tt.modifier.duration = 16
tt.modifier.protected_flags = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)
tt.modifier.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.mod_malagar_shield.insert
tt.main_script.remove = scripts.mod_malagar_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].prefix = "malagar_shield_physical"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(0, -5)
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].size_scales = {
	vv(0.75, 0.75),
	vv(1, 1),
	vv(1.25, 1.25)
}
tt.render.sprites[1].alpha = 67
tt = E:register_t("mod_malagar_shield_magical", "modifier")

AC(tt, "render")

tt.modifier.remove_on_entry = "mod_malagar_shield_physical"
tt.modifier.allows_duplicates = false
tt.modifier.remove_banned = true
tt.modifier.duration = 16
tt.modifier.protected_flags = bor(DAMAGE_MAGICAL)
tt.modifier.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts.mod_malagar_shield.insert
tt.main_script.remove = scripts.mod_malagar_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].prefix = "malagar_shield_magical"
tt.render.sprites[1].alpha = 67
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(0, -5)
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].size_scales = {
	vv(0.75, 0.75),
	vv(1, 1),
	vv(1.25, 1.25)
}
tt = E.register_t(E, "mod_malagar_tower", "modifier")

E.add_comps(E, tt, "render", "ui")

tt.twin = 0
tt.freed = false
tt.click_time = 4
tt.duration = 6
tt.main_script.update = scripts.mod_malagar_tower.update
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset.y = 36
tt.render.sprites[1].prefix = "malagar_tower_hold"
tt.render.sprites[1].name = "appear"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "decal_veznan_tap"
tt.render.sprites[2].offset = v(10, 20)
tt.render.sprites[2].random_ts = fts(7)
tt.render.sprites[2].draw_order = 11
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.required_clicks = 1
tt.sound_blocked = "VeznanHoldTrap"
tt.sound_click = "VeznanHoldHit"
tt.sound_released = "VeznanHoldDissipate"
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect = r(-40, 0, 80, 60)
tt.ui.z = 1
tt = RT("hero_oberon", "hero")

AC(tt, "melee", "timed_attacks", "auras", "transfer")

anchor_y = 0.17
anchor_x = 0.5
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].disabled = false
tt.auras.list[1].name = "aura_oberon_shield"
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 1
tt.hero.level_stats.armor = {
	0.3,
	0.3,
	0.4,
	0.4,
	0.4,
	0.5,
	0.5,
	0.5,
	0.6,
	0.6
}
tt.hero.level_stats.hp_max = {
	330,
	360,
	390,
	420,
	450,
	480,
	510,
	540,
	570,
	600
}
tt.hero.level_stats.melee_damage_max = {
	27,
	30,
	33,
	36,
	39,
	42,
	45,
	48,
	51,
	54
}
tt.hero.level_stats.melee_damage_min = {
	18,
	20,
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36
}
tt.hero.level_stats.regen_health = {
	107,
	115,
	122,
	130,
	137,
	145,
	152,
	160,
	167,
	175
}
tt.hero.skills.roots = CC("hero_skill")
tt.hero.skills.roots.slow_factor = {
	0.5,
	0.5,
	0.5
}
tt.hero.skills.roots.max_range = {
	60,
	75,
	90
}
tt.hero.skills.roots.count = {
	15,
	25,
	35
}
tt.hero.skills.roots.duration = {
	10,
	10,
	10
}
tt.hero.skills.roots.speed = {
	96,
	96,
	96
}
tt.hero.skills.roots.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.roots.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.roots.damage = {
	2,
	2,
	2
}
tt.hero.skills.roots.damage_every = {
	0.3,
	0.3,
	0.3
}
tt.hero.skills.roots.cooldown = {
	35,
	35,
	35
}
tt.hero.skills.roots.root_duration = {
	3,
	3,
	3
}
tt.hero.skills.roots.root_damage = {
	15,
	15,
	15
}
tt.hero.skills.roots.root_damage_every = {
	0.2,
	0.2,
	0.2
}
tt.hero.skills.roots.mod_damage = {
	20,
	20,
	20
}
tt.hero.skills.roots.mod_duration = {
	3,
	3,
	3
}
tt.hero.skills.enchant = CC("hero_skill")
tt.hero.skills.enchant.count = {
	4,
	5,
	6
}
tt.hero.skills.enchant.damage_max = {
	60,
	80,
	100
}
tt.hero.skills.enchant.damage_min = {
	60,
	80,
	100
}
tt.hero.skills.enchant.cooldown = {
	15,
	15,
	15
}
tt.hero.skills.enchant.xp_level_steps = {
	[10] = 3,
	[4] = 1,
	[7] = 2
}
tt.hero.skills.enchant.xp_gain = {
	25,
	50,
	75
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 46)
tt.transfer.disabled = true
tt.transfer.extra_speed = nil
tt.transfer.min_distance = 0
tt.transfer.sound_loop = "ElvesHeroDuraxWalkLoop"
tt.transfer.animations = {
	"surf_startEnd",
	"surf",
	"surf_startEnd"
}
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_oberon.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = "heroPortrait_portraits_rebborn_oberon"
tt.info.i18n_key = "HERO_OBERON"
tt.info.portrait = "info_portraits_hero_rebborn_oberon"
tt.main_script.update = scripts.hero_oberon.update
tt.main_script.insert = scripts.hero_oberon.insert
tt.motion.max_speed = 48
tt.regen.cooldown = 1
tt.info.fn = scripts.hero_basic.get_info_melee
tt.render.sprites[1].anchor = v(0.5, 0.17)
tt.render.sprites[1].prefix = "hero_oberon"
tt.render.sprites[1].offset = v(0, -13)
tt.soldier.melee_slot_offset = v(12, 0)
tt.sound_events.change_rally_point = "HeroOberonTaunt"
tt.sound_events.death = "HeroOberonDeath"
tt.sound_events.hero_room_select = "HeroOberonTauntSelect"
tt.sound_events.insert = "HeroOberonTauntIntro"
tt.sound_events.respawn = "HeroOberonTauntIntro"
tt.sound_slash = "HeroOberonSlash"
tt.ui.click_rect = r(-15, -5, 30, 40)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].mod = nil
tt.melee.range = 50
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].animation = "buff"
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].cooldown = nil
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].sound = "SylvanEnchantmentActivation"
tt.timed_attacks.list[1].count = nil
tt.timed_attacks.list[1].count_active = 0
tt.timed_attacks.list[1].active = nil
tt.timed_attacks.list[1].xp_from_skill = "enchant"
tt.timed_attacks.list[2] = CC("aura_attack")
tt.timed_attacks.list[2].animation = "roots"
tt.timed_attacks.list[2].bullet = "aura_roots_oberon"
tt.timed_attacks.list[2].cast_time = fts(5)
tt.timed_attacks.list[2].cooldown = nil
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].max_range = nil
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].sound = "ThornSound"
tt.timed_attacks.list[2].step = 1
tt.timed_attacks.list[2].nodes_offset = 6
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_FRIEND)
tt.timed_attacks.list[2].vis_flags = F_RANGED
tt.timed_attacks.list[2].xp_from_skill = "roots"
tt.timed_attacks.list[2].mod = "mod_thorn_oberon"
tt = E:register_t("aura_oberon_shield", "aura")

E:add_comps(tt, "render")

tt.aura.duration = -1
tt.aura.track_source = true
tt.main_script.update = scripts.aura_oberon_shield.update
tt.render.sprites[1].prefix = "oberon_shield_1"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].scale = v(1, 1)
tt.render.sprites[1].offset = v(0, 5)
tt.render.sprites[1].anchor.y = 0.19117647058823528
tt.max_distance = 50
tt.added_health = 0
tt.hit = nil
tt.tick_time = 3
tt.hp_per_tick = 25
tt.max_hp = 300
tt = E.register_t(E, "mod_sylvan_enchant", "mod_damage")
tt.damage_max = nil
tt.damage_min = nil
tt.xp_gain_factor = 1.25
tt.main_script.insert = scripts.mod_sylvan_enchant.insert
tt.damage_type = DAMAGE_MAGICAL
tt = RT("aura_roots_oberon", "aura")

AC(tt, "render")

tt.aura.cycle_time = fts(10)
tt.aura.duration = nil
tt.aura.duration_inc = nil
tt.aura.mods = {
	"mod_oberon_slow",
	"mod_oberon_dps"
}
tt.aura.radius = 40
tt.aura.hero_allowed_templates = {
	"hero_oberon"
}
tt.aura.hero_mod = "mod_oberon_sled"
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_ENEMY, F_AREA)
tt.aura.hero_vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.hero_vis_flags = bor(F_FRIEND)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_roots_oberon.update
tt.render.sprites[1].prefix = "oberon_roots"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.render.sprites[1].z = Z_DECALS
tt = RT("mod_oberon_slow", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = nil
tt = RT("mod_oberon_sled", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = 1
tt = RT("mod_oberon_dps", "modifier")

E.add_comps(E, tt, "dps")

tt.modifier.duration = 0.5
tt.dps.damage_max = nil
tt.dps.damage_min = nil
tt.dps.damage_every = nil
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_PHYSICAL)
tt = RT("mod_thorn_oberon", "modifier")

AC(tt, "render")

tt.animation_start = "thorn"
tt.animation_end = "thornFree"
tt.modifier.duration = 3
tt.modifier.type = MOD_TYPE_FREEZE
tt.modifier.vis_flags = bor(F_THORN, F_MOD)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.max_times_applied = 3
tt.damage_min = 20
tt.damage_max = 20
tt.damage_type = DAMAGE_PHYSICAL
tt.damage_every = 1
tt.render.sprites[1].prefix = "mod_thorn_small"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_prefixes = {
	"mod_thorn_small",
	"mod_thorn_big",
	"mod_thorn_big"
}
tt.render.sprites[1].size_scales = {
	vv(0.7),
	vv(0.8),
	vv(1)
}
tt.render.sprites[1].anchor.y = 0.22
tt.main_script.queue = scripts.mod_thorn.queue
tt.main_script.dequeue = scripts.mod_thorn.dequeue
tt.main_script.insert = scripts.mod_thorn.insert
tt.main_script.update = scripts.mod_thorn.update
tt.main_script.remove = scripts.mod_thorn.remove
tt = RT("hero_ember", "hero")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.17
anchor_x = 0.5
tt.hero.fixed_stat_attack = 6
tt.hero.fixed_stat_health = 6
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 6
tt.hero.level_stats.armor = {
	0.3,
	0.3,
	0.35,
	0.35,
	0.35,
	0.4,
	0.4,
	0.4,
	0.45,
	0.45
}
tt.hero.level_stats.hp_max = {
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	460,
	480,
	500
}
tt.hero.level_stats.regen_health = {
	80,
	85,
	90,
	95,
	100,
	105,
	110,
	115,
	120,
	125
}
tt.hero.level_stats.melee_damage_min = {
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	21
}
tt.hero.level_stats.melee_damage_max = {
	16,
	18,
	20,
	22,
	24,
	26,
	28,
	30,
	32,
	34
}
tt.hero.skills.crack = CC("hero_skill")
tt.hero.skills.crack.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.crack.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.crack.damage_max = {
	20,
	40,
	60
}
tt.hero.skills.crack.radius = {
	60,
	60,
	60
}
tt.hero.skills.crack.duration = {
	16,
	16,
	16
}
tt.hero.skills.crack.burn_damage = {
	3,
	4,
	5
}
tt.hero.skills.crack.burn_every = {
	fts(10),
	fts(10),
	fts(10)
}
tt.hero.skills.crack.buff_duration = {
	1,
	1,
	1
}
tt.hero.skills.crack.burn_radius = {
	40,
	40,
	40
}
tt.hero.skills.crack.extra_damage = {
	5,
	10,
	15
}
tt.hero.skills.crack.extra_armor = {
	0.2,
	0.2,
	0.2
}
tt.hero.skills.crack.steps = {
	15,
	15,
	15
}
tt.hero.skills.crack.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.crack.cooldown = {
	17,
	17,
	17
}
tt.hero.skills.volcano = CC("hero_skill")
tt.hero.skills.volcano.nodes_limit = 20
tt.hero.skills.volcano.nodes_offset = 5
tt.hero.skills.volcano.xp_level_steps = {
	[10] = 3,
	[4] = 1,
	[7] = 2
}
tt.hero.skills.volcano.attack_cooldown = {
	1,
	1,
	1
}
tt.hero.skills.volcano.bomb_damage = {
	40,
	80,
	120
}
tt.hero.skills.volcano.bullet_radius = {
	75,
	75,
	75
}
tt.hero.skills.volcano.self_damage = {
	20,
	20,
	20
}
tt.hero.skills.volcano.self_damage_every = {
	fts(10),
	fts(10),
	fts(10)
}
tt.hero.skills.volcano.xp_gain = {
	25,
	50,
	100
}
tt.hero.skills.volcano.cooldown = {
	35,
	35,
	35
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 46)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_ember.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = "heroPortrait_portraits_rebborn_ember"
tt.info.i18n_key = "HERO_EMBER"
tt.info.portrait = "info_portraits_hero_rebborn_ember"
tt.main_script.update = scripts.hero_ember.update
tt.motion.max_speed = 70
tt.regen.cooldown = 1
tt.info.fn = scripts.hero_basic.get_info_melee
tt.render.sprites[1].anchor = v(0.5, 0.17)
tt.render.sprites[1].prefix = "hero_ember"
tt.render.sprites[1].offset = v(0, -5)
tt.soldier.melee_slot_offset = v(12, 0)
tt.sound_events.change_rally_point = "HeroEmberTaunt"
tt.sound_events.death = "HeroEmberDeath"
tt.sound_events.hero_room_select = "HeroEmberTauntSelect"
tt.sound_events.insert = "HeroEmberTauntIntro"
tt.sound_events.respawn = "HeroEmberTaunt"
tt.ui.click_rect = r(-15, -5, 30, 40)
tt.unit.mod_offset = v(0, 15)
tt.vis.bans = bor(tt.vis.bans, F_BURN)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].mod = nil
tt.melee.attacks[1].sound_args = {
	delay = fts(15)
}
tt.melee.range = 50
tt.timed_attacks.list[1] = CC("area_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].animation = "ability_1"
tt.timed_attacks.list[1].cooldown = nil
tt.timed_attacks.list[1].count = 10
tt.timed_attacks.list[1].damage_max = nil
tt.timed_attacks.list[1].damage_min = nil
tt.timed_attacks.list[1].damage_radius = nil
tt.timed_attacks.list[1].damage_type = DAMAGE_EXPLOSION
tt.timed_attacks.list[1].entity = "hero_ember_magma"
tt.timed_attacks.list[1].hit_decal = "decal_ground_hit"
tt.timed_attacks.list[1].hit_fx = "fx_ground_hit"
tt.timed_attacks.list[1].hit_offset = v(0, 0)
tt.timed_attacks.list[1].hit_time = fts(20)
tt.timed_attacks.list[1].hit_aura = "aura_ember_crack"
tt.timed_attacks.list[1].min_count = 1
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].pop = {
	"pop_kapow",
	"pop_wham"
}
tt.timed_attacks.list[1].pop_chance = 0.3
tt.timed_attacks.list[1].pop_conds = DR_KILL
tt.timed_attacks.list[1].radius = 150
tt.timed_attacks.list[1].sound = "EmberCrackOfDoom"
tt.timed_attacks.list[1].step = 1
tt.timed_attacks.list[1].steps = nil
tt.timed_attacks.list[1].shoot_time = fts(14)
tt.timed_attacks.list[1].sound_short = "EmberCrackOfDoom"
tt.timed_attacks.list[1].sound_long = "EmberCrackOfDoom"
tt.timed_attacks.list[1].sound = tt.timed_attacks.list[1].sound_short
tt.timed_attacks.list[1].xp_from_skill = "crack"
tt.timed_attacks.list[1].vis_flags = bor(F_AREA)
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].animation = "volcano"
tt.timed_attacks.list[2].animation_2 = "ability_2"
tt.timed_attacks.list[2].cooldown = nil
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].cast_time = fts(3)
tt.timed_attacks.list[2].shoot_time = fts(21)
tt.timed_attacks.list[2].sound = "HeroEmberTauntSelect"
tt.timed_attacks.list[2].sound_cast = "EmberVolcanoRise"
tt.timed_attacks.list[2].sound_destroy = "EmberVolcanoSink"
tt.timed_attacks.list[2].entity = "decal_hero_ember_volcano"
tt.timed_attacks.list[2].min_targets = 1
tt.timed_attacks.list[2].spawn_offset = v(0, 0)
tt.timed_attacks.list[2].min_distance_from_border = 50
tt.timed_attacks.list[2].max_range = 150
tt.timed_attacks.list[2].volcano_range = 200
tt.timed_attacks.list[2].spawn_range = 150
tt.timed_attacks.list[2].xp_from_skill = "volcano"
tt.timed_attacks.list[2].vis_bans = F_FLYING
tt.timed_attacks.list[2].vis_flags = F_AREA
tt = RT("decal_hero_ember_volcano", "decal_scripted")

E:add_comps(tt, "bullet_attack")

tt.render.sprites[1].prefix = "hero_ember_volcano"
tt.render.sprites[1].offset = v(0, 28)
tt.can_shoot = 1
tt.bullet_start_offset = 30
tt.bullet_attack.range = 200
tt.bullet_attack.bullet = "bomb_ember_volcano"
tt.bullet_attack.shoot_time = fts(15)
tt.bullet_attack.cooldown = nil
tt.bullet_attack.node_prediction = true
tt.bullet_attack.bullet_start_offset = {
	v(10, 58),
	v(-10, 58)
}
tt.bullet_attack.animation = "attack"
tt.bullet_attack.vis_flags = bor(F_RANGED, F_AREA)
tt.bullet_attack.vis_bans = bor(F_FRIEND, F_FLYING)
tt.main_script.update = scripts.decal_hero_ember_volcano.update
tt.duration = nil
tt = RT("aura_ember_crack", "aura")

AC(tt, "render", "tween")

tt.render.sprites[1].animated = false
tt.aura.cycle_time = 0.1
tt.aura.vis_flags = bor(F_AREA)
tt.aura.vis_bans = bor(F_BURN)
tt.aura.aoe = 30
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].prefix = "hero_ember_rock"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.aura_ember_crack.update
tt.tween.remove = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(0),
		255
	},
	{
		16,
		255
	},
	{
		16.5,
		0
	}
}
tt = RT("mod_heal_ember", "modifier")

AC(tt, "hps")

tt.hps.heal_every = nil
tt.hps.heal_min = nil
tt.hps.heal_max = nil
tt.modifier.duration = 2
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt = RT("bomb_ember_volcano", "bomb")
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = nil
tt.bullet.particles_name = "ps_missile_mecha"
tt.bullet.xp_gain_factor = 1
tt.bullet.flight_time = fts(36)
tt.bullet.shoot_time = fts(15)
tt.bullet.ignore_hit_offset = true
tt.bullet.ignore_rotation = true
tt.bullet.hit_fx = "fx_explosion_big"
tt.render.sprites[1].name = "hero_ember_volcano_ball"
tt = RT("decal_ember_spike", "decal_bomb_crater")
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "dark_forge_coal_0001"
tt.render.sprites[2].hide_after_runs = 1
tt.render.sprites[2].anchor.y = 0.24
tt = RT("mod_ember_crack", "mod_lava")
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.kill = true
tt.modifier.duration = 1
tt.modifier.vis_flags = bor(F_MOD, F_AREA, F_BURN)
tt.modifier.vis_bans = bor(F_FLYING)
tt = E:register_t("ray_penumbra", "bullet")
tt.image_width = 190
tt.main_script.update = scripts2.ray_neptune.update
tt.render.sprites[1].name = "ray_umbra"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.damage_min_levels = {
	36,
	40,
	44,
	48,
	52,
	56,
	60,
	64,
	68,
	72
}
tt.bullet.damage_max_levels = {
	63,
	70,
	77,
	84,
	91,
	98,
	105,
	112,
	119,
	126
}
tt.bullet.damage_radius = 70
tt.bullet.max_track_distance = 50
tt.bullet.vis_flags = F_RANGED
tt.bullet.hit_time = fts(7)
tt.bullet.hit_fx = "fx_ray_umbra_explosion"
tt.bullet.xp_gain_factor = 1.75
tt = E:register_t("penumbra_bullet", "arrow")
tt.main_script.remove = scripts.penumbra_bullet.remove
tt.render.sprites[1].name = "penumbra_bullet"
tt.bullet.hit_scripted = "penumbra_blob"
tt.bullet.miss_decal = nil
tt.bullet.miss_fx_water = nil
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = fts(12)
tt.bullet.hit_blood_fx = nil
tt.sound_events.insert = nil
tt = E:register_t("penumbra_blob", "decal_scripted")
tt.main_script.update = scripts.penumbra_blob.update
tt.render.sprites[1].prefix = "penumbra_puddle"
tt.render.sprites[1].offset = v(2, 17)
tt.render.sprites[1].z = Z_DECALS
tt.duration = 3
tt.min_range = 0
tt.max_range = 60
tt.explosion = "penumbra_explosion"
tt.explosion_big = "penumbra_explosion_big"
tt = E:register_t("penumbra_explosion", "decal_scripted")

E:add_comps(tt, "sound_events")

tt.render.sprites[1].prefix = "penumbra_explosion_weak"
tt.render.sprites[1].offset = v(0, 62)
tt.main_script.update = scripts.penumbra_explosion.update
tt.sound_events.insert = "PenumbraPillarWeak"
tt.damage_type = DAMAGE_TRUE
tt.range = 70
tt.vis_flags = bor(F_AREA)
tt = E:register_t("penumbra_explosion_big", "penumbra_explosion")
tt.render.sprites[1].prefix = "penumbra_explosion_strong"
tt.render.sprites[1].scale = v(1, 1.1)
tt.sound_events.insert = "PenumbraPillarStrong"
tt.range = 80
tt = E:register_t("penumbra_missile", "missile_mecha")
tt.main_script.insert = nil
tt.main_script.update = scripts.penumbra_missile.update
tt.render.sprites[1].prefix = "penumbra_missile"
tt.render.sprites[1].scale = v(0.75, 0.75)
tt.bullet.particles_name = "ps_penumbra_missile_trail"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.vis_flags = bor(F_RANGED, F_AREA)
tt.bullet.hit_fx = "fx_ray_umbra_explosion_small"
tt.bullet.hit_fx_air = nil
tt.bullet.hit_fx_water = nil
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = E.register_t(E, "ps_penumbra_missile_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "penumbra_missile_trail_flying"
tt.particle_system.animated = true
tt.particle_system.particle_lifetime = {
	0.1,
	0.1
}
tt.particle_system.alphas = {
	150,
	0
}
tt.particle_system.emit_offset = v(0, -4)
tt.particle_system.scales_y = {
	0.8,
	0.05
}
tt.particle_system.emission_rate = 120
tt = E:register_t("fx_ray_umbra_explosion_small", "fx")
tt.render.sprites[1].name = "ray_umbra_explosion"
tt.render.sprites[1].scale = v(0.75, 0.75)
tt = E.register_t(E, "aura_world_eater", "aura")

E:add_comps(tt, "render")

tt.main_script.update = scripts.world_eater.update
tt.render.sprites[1] = E:clone_c("sprite")
tt.render.sprites[1].name = "penumbra_glow_effect_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.render.sprites[1].offset = v(5, 75)
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].prefix = "penumbra_glow_t1"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].offset = v(5, 75)
tt.render.sprites[2].z = Z_FLYING_HEROES + 1
tt.decal = "bullet_world_eater"
tt = E.register_t(E, "bullet_world_eater", "decal_scripted")

E:add_comps(tt, "force_motion")

tt.render.sprites[1].name = "penumbra_orb"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 371)
tt.force_motion.max_a = 5400
tt.force_motion.max_v = 180
tt.force_motion.a_step = 10
tt.force_motion.max_flight_height = 60
tt.main_script.update = scripts.decal_world_eater.update
tt = E:register_t("hero_penumbra", "hero")

E:add_comps(tt, "ranged", "timed_attacks")

image_y = 308
anchor_y = 0.12962962962962962
tt.hero.fixed_stat_attack = 0
tt.hero.fixed_stat_health = 4
tt.hero.fixed_stat_range = 8
tt.hero.fixed_stat_speed = 7
tt.hero.level_stats.hp_max = {
	220,
	240,
	260,
	280,
	300,
	320,
	340,
	360,
	380,
	400
}
tt.hero.level_stats.regen_health = {
	55,
	60,
	65,
	70,
	75,
	80,
	85,
	90,
	95,
	100
}
tt.hero.level_stats.armor = {
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
tt.world_eater_range = 200
tt.world_eater_factor_min = 1
tt.world_eater_factor_max = 1.5
tt.world_eater_factor_inc = 0.0125
tt.world_eater_delay = 0.1
tt.hero.skills.flap = E:clone_c("hero_skill")
tt.hero.skills.flap.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.flap.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.flap.counts = {
	6,
	9,
	12
}
tt.hero.skills.flap.explosion_damages = {
	40,
	60,
	80
}
tt.hero.skills.dive = E:clone_c("hero_skill")
tt.hero.skills.dive.xp_level_steps = {
	[10] = 3,
	[4] = 1,
	[7] = 2
}
tt.hero.skills.dive.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.dive.damages = {
	225,
	337,
	450
}
tt.hero.skills.dive.counts = {
	10,
	10,
	10
}
tt.hero.skills.dive.missile_scale = {
	1,
	2,
	3
}
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 157)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.draw_order = -1
tt.health_bar.sort_y_offset = -200
tt.health_bar.z = Z_FLYING_HEROES
tt.hero.fn_level_up = scripts.hero_penumbra.level_up
tt.hero.tombstone_show_time = nil
tt.idle_flip.cooldown = 10
tt.info.hero_portrait = "heroPortrait_portraits_rebborn_penumbra"
tt.info.portrait = "info_portraits_hero_rebborn_penumbra"
tt.info.i18n_key = "HERO_PENUMBRA"
tt.info.fn = scripts.hero_penumbra.get_info
tt.main_script.update = scripts.hero_penumbra.update
tt.motion.max_speed = 100
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "penumbra"
tt.render.sprites[1].fps = 26
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].sort_y_offset = -200
tt.render.sprites[1].offset = v(0, 47)
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "penumbra_shadow"
tt.render.sprites[2].z = Z_FLYING_HEROES
tt.render.sprites[2].anchor.y = 0.12962962962962962
tt.render.sprites[2].alpha = 100
tt.sound_events.change_rally_point = "HeroPenumbraTaunt"
tt.sound_events.death = "HeroPenumbraDeath"
tt.sound_events.respawn = "HeroPenumbraRespawn"
tt.sound_events.insert = "HeroPenumbraTauntIntro"
tt.sound_events.hero_room_select = "HeroPenumbraTauntSelect"
tt.ui.click_rect = IS_PHONE_OR_TABLET and r(-35, 50, 70, 70) or r(-35, 75, 75, 60)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 98)
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, -0.15)
tt.unit.mod_offset = v(0, 101)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_FREEZE)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = E:clone_c("bullet_attack")
tt.ranged.attacks[1].bullet = "ray_penumbra"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 120)
}
tt.ranged.attacks[1].cooldown = 2.25
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 228
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].estimated_flight_time = 1
tt.ranged.attacks[1].sound = "PenumbraAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].sound = "PenumbraBlackTide"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 120
tt.timed_attacks.list[1].bullet = "penumbra_bullet"
tt.timed_attacks.list[1].bullet_start_offset = v(30, 90)
tt.timed_attacks.list[1].shoot_time = 0.5
tt.timed_attacks.list[2] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[2].sound = "PenumbraShadowTsunami"
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].cooldown = 12
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 25
tt.timed_attacks.list[2].radius = 100
tt.timed_attacks.list[2].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[2].bullet = "penumbra_missile"
tt.timed_attacks.list[2].shoot_time = 0.95
tt.timed_attacks.list[2].respawn_delay = 0.2
tt.timed_attacks.list[2].offset = v(3, 50)
tt.timed_attacks.list[2].vis_flags = bor(F_AREA)
tt = RT("deadeye_revolver", "shotgun")
tt.bullet.damage_max = 6
tt.bullet.damage_min = 4
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.start_fx = nil
tt.bullet.min_speed = FPS * 20
tt.bullet.max_speed = FPS * 20
tt.bullet.xp_gain_factor = 2
tt.sound_events.insert = "ShotgunSound"
tt.render.sprites[1].name = "hero_deadeye_bullet"
tt = E.register_t(E, "bullet_deadeye_shotgun", "shotgun")
tt.bullet.damage_max = 80
tt.bullet.damage_min = 80
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.start_fx = nil
tt.bullet.min_speed = FPS * 20
tt.bullet.max_speed = FPS * 20
tt.bullet.xp_gain_factor = 1
tt.sound_events.insert = "DeadeyeShotgunSFX"
tt.bullet.mod = "mod_deadeye_stun"
tt.bullet.pop = nil
tt.render.sprites[1].prefix = "shotgun_bolin"
tt = RT("mod_deadeye_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt.modifier.duration = 0.5
tt = RT("hero_deadeye", "hero")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.24
anchor_x = 0.5
image_y = 82
image_x = 92
tt.test = 0
tt.hero.fixed_stat_attack = 3
tt.hero.fixed_stat_health = 3
tt.hero.fixed_stat_range = 7
tt.hero.fixed_stat_speed = 8
tt.hero.level_stats.armor = {
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
tt.hero.level_stats.hp_max = {
	300,
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	460,
	480
}
tt.hero.level_stats.melee_damage_max = {
	15,
	17,
	18,
	20,
	21,
	23,
	24,
	26,
	27,
	29
}
tt.hero.level_stats.melee_damage_min = {
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19
}
tt.hero.level_stats.ranged_damage_max = {
	9,
	10,
	10,
	11,
	12,
	12,
	13,
	14,
	14,
	15
}
tt.hero.level_stats.ranged_damage_min = {
	6,
	6,
	7,
	7,
	8,
	8,
	9,
	9,
	10,
	10
}
tt.hero.level_stats.regen_health = {
	75,
	80,
	85,
	90,
	95,
	100,
	105,
	110,
	115,
	120
}
tt.hero.skills.shotgun = CC("hero_skill")
tt.hero.skills.shotgun.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.shotgun.xp_gain_factor = {
	0.5,
	0.75,
	1
}
tt.hero.skills.shotgun.damage_min = {
	60,
	90,
	120
}
tt.hero.skills.shotgun.damage_max = {
	60,
	90,
	120
}
tt.hero.skills.shotgun.stun_duration = {
	0.2,
	0.3,
	0.4
}
tt.hero.skills.bounty = CC("hero_skill")
tt.hero.skills.bounty.duration = {
	6,
	6,
	6
}
tt.hero.skills.bounty.xp_level_steps = {
	[10] = 3,
	[4] = 1,
	[7] = 2
}
tt.hero.skills.bounty.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.bounty.max_targets = {
	3,
	5,
	7
}
tt.hero.skills.bounty.gold_factor = {
	1.5,
	1.5,
	1.5
}
tt.hero.skills.bounty.received_damage_factor = {
	1.1,
	1.2,
	1.3
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 40)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_deadeye.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.damage_icon = "shot"
tt.info.hero_portrait = "heroPortrait_portraits_rebborn_deadeye"
tt.info.fn = scripts.hero_deadeye.get_info
tt.info.i18n_key = "HERO_DEADEYE"
tt.info.portrait = "info_portraits_hero_rebborn_deadeye"
tt.melee.range = 40
tt.main_script.update = scripts.hero_deadeye.update
tt.motion.max_speed = FPS * 2.5
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0)
tt.render.sprites[1].offset = v(0, -8)
tt.render.sprites[1].prefix = "hero_deadeye"
tt.render.sprites[1].angles.shoot = {
	"shootRightLeft",
	"shootUp",
	"shootDown"
}
tt.render.sprites[1].angles_flip_vertical = {
	shotgunShoot = true,
	shoot = true,
	shootAim = true,
	shotgunShootAim = true
}
tt.render.sprites[1].angles.shootAim = {
	"shootAimRightLeft",
	"shootAimUp",
	"shootAimDown"
}
tt.render.sprites[1].angles.shotgunShoot = {
	"shotgunShootRightLeft",
	"shotgunShootUp",
	"shotgunShootDown"
}
tt.render.sprites[1].angles.shotgunShootAim = {
	"shotgunShootAimRightLeft",
	"shotgunShootAimUp",
	"shotgunShootAimDown"
}
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].hidden = true
tt.render.sprites[2].name = "TotemTower_GroundEffect-Red_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].scale = v(0.01, 0.01)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].color = {
	255,
	255,
	0,
	0
}
tt.soldier.melee_slot_offset = v(3, 0)
tt.sound_events.change_rally_point = "HeroDeadeyeTaunt"
tt.sound_events.death = "HeroDeadeyeDeath"
tt.sound_events.hero_room_select = "HeroDeadeyeTauntSelect"
tt.sound_events.insert = "HeroDeadeyeTauntIntro"
tt.sound_events.respawn = "HeroDeadeyeTauntIntro"
tt.sound_events.horse_start = "HeroDeadeyeHorseStart"
tt.sound_events.horse_loop = "HeroDeadeyeHorseLoop"
tt.sound_events.horse_end = "HeroDeadeyeHorseEnd"
tt.sound_events.horse_end_args = {
	delay = fts(1)
}
tt.ui.click_rect = r(-15, -5, 35, 40)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.horseride = {}
tt.horseride.min_distance = 160
tt.horseride.extra_speed = FPS * 3.3
tt.horseride.animations = {
	"horse_start",
	"horse_loop",
	"horse_end"
}
tt.horseride.hit_offset = v(0, 25)
tt.horseride.mod_offset = v(0, 25)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].xp_gain_factor = 1
tt.timed_attacks.list[1] = CC("bullet_attack")
tt.timed_attacks.list[1].bullet = "deadeye_revolver"
tt.timed_attacks.list[1].aim_animation = "shootAim"
tt.timed_attacks.list[1].shoot_animation = "shoot"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(5, 20),
	v(0, 20),
	v(5, 20)
}
tt.timed_attacks.list[1].cooldown = 1.5
tt.timed_attacks.list[1].shoot_times = fts(6)
tt.timed_attacks.list[1].max_shoots = 6
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 170
tt.timed_attacks.list[1].shoot_time = fts(3)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].xp_gain_factor = 1.5
tt.timed_attacks.list[2] = CC("bullet_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].bullet = "bullet_deadeye_shotgun"
tt.timed_attacks.list[2].aim_animation = "shotgunShootAim"
tt.timed_attacks.list[2].shoot_animation = "shotgunShoot"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(0, 10),
	v(0, 10),
	v(0, 10)
}
tt.timed_attacks.list[2].hit_time = fts(0)
tt.timed_attacks.list[2].shoot_times = fts(4)
tt.timed_attacks.list[2].max_shoots = 5
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 100
tt.timed_attacks.list[2].shoot_time = fts(8)
tt.timed_attacks.list[2].vis_bans = 0
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].mod = "mod_shotgun_bullets"
tt.timed_attacks.list[2].mod_cooldown = 3
tt.timed_attacks.list[2].xp_gain_factor = 0.5
tt.timed_attacks.list[3] = CC("custom_attack")
tt.timed_attacks.list[3].animation = "most_wanted"
tt.timed_attacks.list[3].cast_range = 150
tt.timed_attacks.list[3].chain_time = fts(1)
tt.timed_attacks.list[3].cooldown = 18
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].hit_time = fts(15)
tt.timed_attacks.list[3].max_range = 140
tt.timed_attacks.list[3].min_count = 1
tt.timed_attacks.list[3].mod = "mod_gold_wanted"
tt.timed_attacks.list[3].radius = 150
tt.timed_attacks.list[3].sound = "DeadeyeWhistle"
tt.timed_attacks.list[3].vis_bans = bor(F_FRIEND, F_SKELETON)
tt.timed_attacks.list[3].vis_flags = bor(F_MOD)
tt = RT("mod_shotgun_bullets", "modifier")

AC(tt, "render")

tt.main_script.update = scripts.mod_shotgun_bullets.update
tt.max_bullets = 5
tt.lose_bullet = false
tt.bullet_count = 0
tt.bullet_size = 6
tt.bullet_max_width = tt.bullet_size * tt.max_bullets / 2

for i = 1, tt.max_bullets do
	if i > 1 then
		tt.render.sprites[i] = CC("sprite")
	end

	tt.render.sprites[i].prefix = "hero_deadeye"
	tt.render.sprites[i].name = "bullet"
	tt.render.sprites[i].draw_order = 2
	tt.render.sprites[i].loop = true
	tt.render.sprites[i].offset = v(tt.bullet_size * i - tt.bullet_max_width - tt.bullet_size / 2, -10)
end

tt = RT("hero_zezitra", "hero")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.14
anchor_x = 0.5
image_y = 76
image_x = 60
tt.hero.fixed_stat_attack = 4
tt.hero.fixed_stat_health = 1
tt.hero.fixed_stat_range = 8
tt.hero.fixed_stat_speed = 3
tt.hero.level_stats.armor = {
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
tt.hero.level_stats.hp_max = {
	165,
	180,
	195,
	210,
	225,
	240,
	255,
	270,
	285,
	300
}
tt.hero.level_stats.melee_damage_max = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.level_stats.melee_damage_min = {
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
tt.hero.level_stats.ranged_damage_max = {
	45,
	50,
	55,
	60,
	65,
	70,
	75,
	80,
	85,
	90
}
tt.hero.level_stats.ranged_damage_min = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.level_stats.regen_health = {
	33,
	36,
	39,
	42,
	45,
	48,
	51,
	54,
	57,
	60
}
tt.hero.skills.double_shadow = CC("hero_skill")
tt.hero.skills.double_shadow.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.double_shadow.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.double_shadow.shield_ignore_hits = {
	2,
	3,
	4
}
tt.hero.skills.double_shadow.max_count = {
	3,
	4,
	5
}
tt.hero.skills.double_shadow.cooldown = {
	16,
	16,
	16
}
tt.hero.skills.wormtongue = CC("hero_skill")
tt.hero.skills.wormtongue.xp_level_steps = {
	[10] = 3,
	[4] = 1,
	[7] = 2
}
tt.hero.skills.wormtongue.pets_max = {
	1,
	2,
	3
}
tt.hero.skills.wormtongue.xp_from_skill = {
	100,
	200,
	300
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 37)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_zezitra.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = "heroPortrait_portraits_rebborn_zezitra"
tt.info.fn = scripts.hero_zezitra.get_info
tt.info.i18n_key = "HERO_ZEZITRA"
tt.info.portrait = "info_portraits_hero_rebborn_zezitra"
tt.main_script.update = scripts.hero_zezitra.update
tt.motion.max_speed = 60
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.17)
tt.render.sprites[1].prefix = "hero_zezitra"
tt.render.sprites[1].offset = v(0, -10)
tt.render.sprites[1].scale = v(1, 0.9)
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "hero_zezitra_skill_ready"
tt.render.sprites[2].scale = v(1.3, 1.3)
tt.render.sprites[2].loop = true
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].color = {
	255,
	255,
	255,
	0
}
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[2].hidden = true
tt.soldier.melee_slot_offset = v(4, 0)
tt.sound_events.death = "HeroZezitraDeath"
tt.sound_events.insert = "HeroZezitraTauntIntro"
tt.sound_events.respawn = "HeroZezitraTauntIntro"
tt.sound_events.change_rally_point = "HeroZezitraTaunt"
tt.sound_events.hero_room_select = "HeroZezitraTauntSelect"
tt.ui.click_rect = r(-13, -5, 26, 32)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.range = 45
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].xp_gain_factor = 1.5
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "skill1"
tt.melee.attacks[2].cooldown = 1
tt.melee.attacks[2].hit_time = fts(16)
tt.melee.attacks[2].damage_type = bor(DAMAGE_PHYSICAL, DAMAGE_NO_DODGE)
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].vis_flags = bor(F_MOD)
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_BOSS)
tt.melee.attacks[2].xp_from_skill = "wormtongue"
tt.melee.attacks[2].fn_damage = scripts.hero_zezitra.possession_damage
tt.melee.attacks[2].mod = "mod_possession_skill"
tt.melee.attacks[2].sound = "HeroZezitraHypnotize"
tt.melee.attacks[2].xp_gain_factor = 3
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "ray_zezitra"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 21)
}
tt.ranged.attacks[1].max_range = 210
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].cooldown = 1.8
tt.ranged.attacks[1].xp_gain_factor = 1
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "skill2"
tt.timed_attacks.list[1].cooldown = 16
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].max_count = 1
tt.timed_attacks.list[1].min_count = 1
tt.timed_attacks.list[1].mod = "mod_zezitra_shield"
tt.timed_attacks.list[1].range = 210
tt.timed_attacks.list[1].shoot_time = fts(18)
tt.timed_attacks.list[1].sound = "HeroZezitraShield"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(15)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_MOD)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt = E:register_t("ray_zezitra", "bullet")
tt.image_width = 238
tt.track_target = true
tt.sound_events.insert = "RayZezitraSound"
tt.main_script.update = scripts2.ray_neptune.update
tt.render.sprites[1].name = "ray_zezitra_guy"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.damage_min_levels = {
	33,
	36,
	39,
	42,
	45,
	48,
	51,
	54,
	57,
	60
}
tt.bullet.damage_max_levels = {
	45,
	50,
	55,
	60,
	65,
	70,
	75,
	80,
	85,
	90
}
tt.bullet.damage_radius = 50
tt.bullet.max_track_distance = 210
tt.bullet.vis_flags = bor(F_RANGED, F_AREA)
tt.bullet.hit_time = fts(42)
tt.bullet.hit_fx = "fx_zezitra_ray_explosion"
tt.bullet.xp_gain_factor = 1
tt = E:register_t("fx_zezitra_ray_explosion", "fx")
tt.render.sprites[1].name = "ray_zezitra_guy_explosion"
tt = E:register_t("mod_zezitra_shield", "modifier")

AC(tt, "render")

tt.modifier.bans = {
	"mod_drider_poison",
	"mod_son_of_mactans_poison",
	"mod_rotten_lesser_pestilence",
	"mod_poison_giant_rat",
	"mod_myconid_poison"
}
tt.modifier.remove_banned = true
tt.modifier.duration = 30
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.shield_ignore_hits = nil
tt.main_script.insert = scripts.mod_zezitra_shield.insert
tt.main_script.remove = scripts.mod_zezitra_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].prefix = "hero_zezitra_shield"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = false
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.5
tt = RT("soldier_possessed_pet", "soldier")

E:add_comps(tt, "soldier", "motion", "nav_grid", "main_script", "vis", "info", "lifespan", "melee", "sound_events", "nav_rally", "ranged", "dodge", "timed_attacks", "auras", "death_spawns", "moon")

anchor_y = 0.2
image_y = 36
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_hero_0007" or "info_portraits_hero_0007"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_empty_nuhuh"
tt.death_spawns.delay = 0.11
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_empty_nil"
tt.health.armor = 0
tt.health.hp_inc = 40
tt.health.hp_max = 20
tt.health.on_damage = scripts.soldier_possessed_pet.on_damage
tt.health_bar.offset = v(0, ady(39))
tt.dodge.chance = 0
tt.dodge.silent = true
tt.regen = nil
tt.info.fn = scripts.soldier_possessed_pet.get_info
tt.info.i18n_key = "SOLDIER_GARGOYLE"
tt.main_script.insert = scripts.soldier_possessed_pet.insert
tt.main_script.update = scripts.soldier_possessed_pet.update
tt.melee.attacks[1].cooldown = 900000
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "KRVGenericCombat"
tt.melee.attacks[2] = CC("area_attack")
tt.melee.attacks[2].cooldown = 900000
tt.melee.attacks[2].count = 9e+99
tt.melee.attacks[2].damage_inc = 150
tt.melee.attacks[2].damage_max = 200
tt.melee.attacks[2].damage_min = 150
tt.melee.attacks[2].damage_radius = 66.6
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].hit_decal = "decal_ground_hit"
tt.melee.attacks[2].hit_fx = "fx_ground_hit"
tt.melee.attacks[2].hit_offset = v(35, 0)
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[2].mod = nil
tt.melee.attacks[2].sound = "KRVGenericCombat"
tt.melee.range = 64
tt.ranged.attacks[1].bullet = nil
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].cooldown = 9999999
tt.ranged.attacks[1].max_range = 300
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet_start_offset = v(0, 0)
tt.ranged.attacks[1].vis_flags = F_RANGED
tt.ranged.attacks[1].vis_bans = 0
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].cooldown = 9000000
tt.timed_attacks.list[1].damage_max = 0
tt.timed_attacks.list[1].damage_min = 0
tt.timed_attacks.list[1].damage_type = DAMAGE_NONE
tt.timed_attacks.list[1].max_range = 0
tt.timed_attacks.list[1].hits = 0
tt.timed_attacks.list[1].min_count = 0
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_STUN)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(5)
tt.timed_attacks.list[1].sound = nil
tt.timed_attacks.list[2] = CC("spawn_attack")
tt.timed_attacks.list[2].animation = "summon"
tt.timed_attacks.list[2].cooldown = 9000000000
tt.timed_attacks.list[2].cast_time = fts(15)
tt.timed_attacks.list[2].entity = "soldier_skeleton"
tt.timed_attacks.list[2].sound = "HeroVikingCall"
tt.timed_attacks.list[2].sound_args = {
	delay = fts(5)
}
tt.timed_attacks.list[2].nodes_offset = {
	4,
	8
}
tt.motion.max_speed = 60
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "soldier_sand_warrior"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = 0.2
tt.render.sprites[2].animated = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].prefix = "spectres_possession_effect"
tt.render.sprites[2].scale = v(0.7, 0.7)
tt.render.sprites[2].offset = v(0, 10)
tt.render.sprites[2].color = {
	255,
	0,
	0
}
tt.render.sprites[2].alpha = 50
tt.render.sprites[2].ignore_start = true
tt.render.sprites[2].loop = true
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.flags = F_FRIEND
tt = RT("mod_possession_pet", "modifier")
AC(tt, "render")
tt.main_script.update = scripts.mod_possession_pet.update
tt.modifier.bans = {
	"mod_goblirang_slow",
	"mod_slow_dwaarp",
	"mod_slow_oil",
	"mod_forest_eerie_slow",
	"mod_slow_baby_ashbite",
	"mod_elora_bolt_slow",
	"mod_slow",
	"mod_shocking_impact",
	"mod_bolin_slow",
	"mod_slow_curse",
	"mod_elora_chill"
}
tt.modifier.ban_types = {
	MOD_TYPE_SLOW
}
tt.modifier.remove_banned = true
tt.modifier.use_mod_offset = nil
tt.entity_name = "soldier_possessed_pet"
tt.fx = "fx_zezitra_possession"
tt.doll_duration = 10
tt.render.sprites[1].prefix = "spectres_possession_effect"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[1].size_scales = {
	v(0.7, 0.7),
	v(1, 1),
	v(1, 1)
}
tt.render.sprites[1].color = {
	255,
	0,
	0
}
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].ignore_flip = true
tt.cooldown_factor = 0.05
tt.cooldown_base = 0
tt = RT("aura_possessed_pet_degeneration", "aura")

AC(tt, "regen")

tt.aura.duration = -1
tt.main_script.update = scripts.aura_possessed_pet_degeneration.update
tt.regen.cooldown = 2
tt.threshold = 0.1
tt.duration = 1
tt.factor_start = 0
tt.factor_end = 0
tt = E:register_t("tower_holder_blocked_sand", "tower_holder_blocked")
tt.tower.type = "holder_blocked_sand"
tt.render.sprites[1].name = "holder_blocked_sand_0001"
tt.tower_holder.unblock_price = 100
tt = E:register_t("tower_holder_blocked_sand_building", "tower_holder_blocked")
tt.render.sprites[1].name = "holder_blocked_buildings_0001"
tt.tower.type = "holder_blocked_sand_buildings"
tt.tower_holder.unblock_price = 200
tt.ui.click_rect = r(-72, -38, 144, 92)
tt = RT("decal_flag_hm", "decal_loop")
tt.render.sprites[1].anchor = v(0.5, 0.07)
tt.render.sprites[1].random_ts = fts(14)
tt.render.sprites[1].name = "flag_hm"
tt = RT("decal_smoke_hm", "decal_loop")
tt.render.sprites[1].anchor = v(0, 0)
tt.render.sprites[1].random_ts = fts(14)
tt.render.sprites[1].fps = 15
tt.render.sprites[1].name = "smoke_hm"
tt.render.sprites[1].alpha = 220
tt = E:register_t("decal_ra", "decal_scripted")

AC(tt, "ui", "render", "editor")

tt.main_script.update = scripts.decal_ra.update
tt.ui.click_rect = r(-17.5, -15, 35, 30)
tt.render.sprites[1].prefix = "eye_ra"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].scale = v(0.5, 0.5)
tt.achievement_id = "RAAAAHHH"
tt = RT("soldier_s32_hammerhold_guard", "soldier_militia")

AC(tt, "editor")

anchor_y = 0.19
image_y = 42
tt.health.armor = 0.6
tt.health.dead_lifetime = 3
tt.health.hp_max = 300
tt.health_bar.offset = v(0, ady(40))
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0004" or "info_portraits_rebborn_sc_0120"
tt.info.random_name_count = 9
tt.info.random_name_format = "SOLDIER_HAMMERHOLD_GUARD_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].cooldown = 1
tt.melee.cooldown = 1
tt.melee.range = 65
tt.motion.max_speed = 60
tt.regen.health = 30
tt.render.sprites[1].prefix = "soldier_city_guard"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].scale = v(1.05, 1.05)
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))
tt.editor.props = {
	{
		"editor.game_mode",
		PT_NUMBER
	}
}

-- Rebborn hero and Hammerhold runtime dependency closure.
tt = RT("aura_deadeye_wanted", "aura")
tt.aura.mod = "mod_gold_wanted"
tt.aura.max_count = 4
tt.aura.radius = 150
tt.aura.vis_flags = bor(F_RANGED, F_MOD)
tt.aura.vis_bans = bor(F_FRIEND, F_HERO)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update

tt = RT("mod_gold_wanted", "modifier")
AC(tt, "render")
tt.modifier.duration = 10 - fts(12)
tt.render.sprites[1].prefix = "hero_deadeye"
tt.render.sprites[1].name = "cash"
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].loop = true
tt.render.sprites[1].offset = v(0, 0)
tt.render.sprites[1].animated = true
tt.render.sprites[2] = E:clone_c("sprite")
tt.render.sprites[2].name = "hero_deadeye_glow"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].z = Z_DECALS
tt.main_script.insert = scripts.mod_gold_wanted.insert
tt.main_script.update = scripts.mod_gold_wanted.update
tt.main_script.remove = scripts.mod_gold_wanted.remove

local function malagar_spawn_data()
	return {
		{"enemy_desert_raider", 4, 0, 1, 2},
		{"enemy_desert_raider", 4, 0, 1, 3},
		{"enemy_desert_raider", 4, 0, 2, 2},
		{"enemy_desert_raider", 4, 0, 2, 3},
		{"enemy_sand_monk", 20, 20, 1, 1},
		{"enemy_sand_monk", 20, 20, 2, 1},
		{"enemy_umbral_acolyte", 60, 0, 3, 1},
		{"enemy_umbral_acolyte", 60, 0, 4, 1},
		{"enemy_executioner", 30, 30, 6, 2},
		{"enemy_executioner", 30, 30, 6, 3}
	}
end

tt = RT("malagar_spawner_aura", "aura")
tt.main_script.update = scripts.jt_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	malagar_spawn_data(),
	malagar_spawn_data(),
	malagar_spawn_data(),
	malagar_spawn_data(),
	malagar_spawn_data()
}

tt = E:register_t("mod_ka_hor", "modifier")
AC(tt, "render")
tt.extra_damage = 0.2
tt.duration = 10
tt.render.sprites[1].name = "dark_forge_sword_decal"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].offset = v(0, -10)
tt.render.sprites[1].draw_order = 5
tt.render.sprites[1].color = {0, 201, 87, 0}
tt.main_script.update = scripts.mod_ka_hor.update
tt.main_script.insert = scripts.mod_ka_hor.insert
tt.main_script.remove = scripts.mod_ka_hor.remove

tt = E:register_t("mod_lycanthropy_pos", "modifier")
AC(tt, "moon")
tt.moon.transform_name = "soldier_werewolf_pos"
tt.main_script.insert = scripts.mod_lycanthropy_pos.insert
tt.main_script.update = scripts.mod_lycanthropy_pos.update
tt.spawn_hp = nil
tt.active = false
tt.nodeslimit = 30
tt.extra_health = 700
tt.modifier.vis_flags = bor(F_MOD, F_LYCAN)
tt.modifier.vis_bans = bor(F_BOSS, F_SKELETON)
tt.sound_events.transform = "HWWerewolfTransformation"

tt = E:register_t("soldier_skeleton_rebborn_pos", "soldier_militia")
AC(tt, "count_group")
anchor_y = 0.18
anchor_x = 0.5
image_y = 38
tt.count_group.name = "skeletons_pos"
tt.health.dead_lifetime = 3
tt.health.hp_max = {96, 120, 144, 144, 144}
tt.health_bar.offset = v(0, ady(38))
tt.info.fn = scripts2.soldier_mercenary.get_info
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0052" or "info_portraits_sc_0052"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.range = 72.5
tt.motion.max_speed = {
	FPS * 0.6 * 1.28,
	FPS * 0.6 * 1.28,
	FPS * 0.6 * 1.28,
	FPS * 0.6 * 1.408,
	FPS * 0.6 * 1.536
}
tt.regen = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_skeleton"
tt.sound_events.insert = "NecromancerSummon"
tt.vis.bans = bor(F_POLYMORPH, F_CANNIBALIZE, F_POISON, F_LYCAN, F_SKELETON)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(18))

tt = E:register_t("soldier_werewolf_pos", "soldier_skeleton_rebborn_pos")
AC(tt, "count_group", "melee", "moon", "auras")
anchor_y = 0.18181818181818182
anchor_x = 0.5
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_werewolf_regen_pos"
tt.auras.list[1].cooldown = 0
tt.count_group.name = "werewolf_pos"
tt.health.magic_armor = 0.3
tt.health_bar.offset = v(0, 38)
tt.health.hp_max = {560, 700, 840, 840, 840}
tt.info.i18n_key = "ENEMY_HALLOWEEN_WEREWOLF"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0089" or "info_portraits_sc_0089"
tt.info.enc_icon = 67
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = {
	FPS * 1.3 * 1.28,
	FPS * 1.3 * 1.28,
	FPS * 1.3 * 1.28,
	FPS * 1.3 * 1.408,
	FPS * 1.3 * 1.536
}
tt.melee.range = 72.5
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_werewolf"
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.sound_events.insert = nil
tt.vis.bans = bor(F_CANNIBALIZE, F_LYCAN)

tt = E:register_t("aura_werewolf_regen_pos", "aura")
AC(tt, "regen")
tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = 0.25
tt.regen.health = 2
tt.regen.ignore_stun = false
tt.regen.ignore_freeze = false

tt = E:register_t("fx_zezitra_possession", "fx")
tt.render.sprites[1].name = "spectres_proy_decal"
tt.render.sprites[1].color = {255, 0, 0, 50}

tt = E:register_t("decal_malagar_shoutbox", "decal_s12_shoutbox")
tt.render.sprites[1].name = "Stage1_BossShoutBox_0001"
tt.render.sprites[1].offset = v(0, -8)
tt.render.sprites[2].offset = v(7, 6)
tt.texts.list[1].color = {180, 80, 0}
tt.tween.props[3].keys = {
	{0, v(1.11, 1.11)},
	{0.4, v(1.09, 1.09)},
	{0.8, v(1.11, 1.11)}
}

local function register_rebborn_summon_hero(name)
	local summon = RT(name .. "_2", name)

	summon.hero_insert = false
	summon.hero.level = 10

	for _, skill in pairs(summon.hero.skills) do
		if skill.xp_level_steps then
			skill.xp_level_steps = {
				[8] = 1,
				[9] = 2,
				[10] = 3
			}
		end

		if skill.level then
			skill.level = 3
		end
	end
end

register_rebborn_summon_hero("hero_oberon")
register_rebborn_summon_hero("hero_ember")
register_rebborn_summon_hero("hero_penumbra")
register_rebborn_summon_hero("hero_zezitra")
register_rebborn_summon_hero("hero_deadeye")
