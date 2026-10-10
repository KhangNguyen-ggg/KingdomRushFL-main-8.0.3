-- Playable Blackburn: a separate hero template, never an enemy boss instance.
local M = {
	name = "hero_allied_blackburn",
	portrait = "info_portraits_sc_0092",
	texture = "go_stage70"
}

function M.register()
	local E = require("entity_db")
	local A = require("animation_db")
	local SU = require("script_utils")
	local scripts = require("scripts")
	local GS = require("game_settings")
	local V = require("klua.vector")
	local bit = require("bit")
	local boss = assert(E:get_template("eb_blackburn"), "Blackburn boss template missing")

	-- A distinct animation prefix adds hero respawn without changing the enemy boss.
	local prefix = M.name
	for _, name in ipairs({"idle", "attack", "death", "walkingRightLeft", "walkingUp", "walkingDown"}) do
		A.db[prefix .. "_" .. name] = assert(A.db["eb_blackburn_" .. name], "Blackburn animation missing: " .. name)
	end
	A.db[prefix .. "_respawn"] = A.db.eb_blackburn_idle
	if E.entities[M.name] then return E.entities[M.name] end

	local t = E:register_t(M.name, "hero")
	E:add_comps(t, "melee")
	t.render = table.deepclone(boss.render)
	t.render.sprites[1].prefix = prefix
	t.render.sprites[1].name = "idle"
	t.health.hp_max = boss.health.hp_max
	t.health.hp = t.health.hp_max
	t.health.armor = boss.health.armor
	t.health.dead_lifetime = 20
	t.health_bar = table.deepclone(boss.health_bar)
	t.health_bar.hidden = false
	t.motion.max_speed = 60
	t.regen.cooldown = 1
	t.regen.health = 90
	t.info.fn = scripts.hero_basic.get_info_melee
	t.info.i18n_key = "ENEMY_BOSS_BLACKBURN"
	t.info.portrait = M.portrait
	t.info.hero_portrait = M.portrait
	t.ui.click_rect = table.deepclone(boss.ui.click_rect)
	t.unit.size = boss.unit.size
	t.unit.hit_offset = V.vclone(boss.unit.hit_offset)
	t.unit.mod_offset = V.vclone(boss.unit.mod_offset)
	t.unit.marker_offset = V.vclone(boss.unit.marker_offset)
	t.soldier.melee_slot_offset = V.v(25, 0)
	t.melee.range = 100
	t.melee.attacks[1] = table.deepclone(boss.melee.attacks[1])
	local attack = t.melee.attacks[1]
	attack.vis_flags = F_BLOCK
	attack.vis_bans = bit.bor(F_FLYING, F_CLIFF)
	attack.damage_bans = F_FLYING
	attack.damage_flags = F_AREA
	attack.xp_gain_factor = 0
	attack.sound_hit = "MeleeSword"
	-- No boss aura, tower sabotage, enemy pathing or boss-death callback is inherited.
	t.hero.skills = {}
	t.hero.fn_level_up = function(this, store, initial)
		this.hero.level = 10
		this.hero.xp = GS.hero_xp_thresholds[9]
		this.hero.xp_queued = 0
		if initial then this.health.hp = this.health.hp_max end
	end
	t.main_script.insert = scripts.hero_basic.insert
	t.main_script.update = function(this, store)
		while true do
			if this.health.dead then
				SU.y_hero_death_and_respawn(store, this)
			elseif this.unit.is_stunned then
				SU.soldier_idle(store, this)
			elseif this.nav_rally.new then
				SU.y_hero_new_rally(store, this)
			else
				local interrupted, state = SU.y_soldier_melee_block_and_attacks(store, this)
				if not interrupted and state == A_NO_TARGET and not SU.soldier_go_back_step(store, this) then
					SU.soldier_idle(store, this)
					SU.soldier_regen(store, this)
				end
			end
			this.hero.xp_queued = 0
			coroutine.yield()
		end
	end
	return t
end

return M
