-- Allied variants use hero life cycles; enemy scripts never run on these units.
local blackburn = require("allied_blackburn")
local M = {}
M.list = {
	{name = blackburn.name, title = "Blackburn", source = "eb_blackburn", icon = "cheat_item_spell_summon_blackburn", textures = {"go_stage70", "go_enemies_common"}, sounds = {"BlackburnSounds"}},
	{name = "hero_allied_juggernaut", title = "Juggernaut", source = "eb_juggernaut", icon = "encyclopedia_creep_thumbs_0132", textures = {"go_stage50"}},
	{name = "hero_allied_set", title = "Set", source = "enemy_set", icon = "encyclopedia_creep_thumbs_0265", textures = {"go_enemies_hammerhold", "go_enemies_desert"}, sounds = {"HammerholdEnemySounds"}},
	{name = "hero_allied_navira", title = "Navira", source = "boss_navira", icon = "encyclopedia_creep_thumbs_0554", textures = {"go_stage119"}, sounds = {"stage_19"}},
	{name = "hero_allied_spectro", title = "Spectro", source = "enemy_flying_ghost_ship", icon = "encyclopedia_creep_thumbs_0397", textures = {"go_stage190_2", "go_stage190"}, sounds = {"enemies_pirates", "stage_190"}, scaled = true, bombardment = true},
	{name = "hero_allied_mirage", title = "Mirage", source = "enemy_mirage_path", icon = "encyclopedia_creep_thumbs_0411", textures = {"kr4_sandstorm", "kr4_sandstorm_mirage"}, scaled = true, sounds = {"branch_campaigns"}},
	{name = "hero_allied_alric", title = "Alric", source = "enemy_alric", icon = "encyclopedia_creep_thumbs_0413", textures = {"kr4_level35_alric"}, scaled = true, sounds = {"branch_campaigns"}},
	{name = "hero_allied_malik", title = "Malik", source = "enemy_malik", icon = "encyclopedia_creep_thumbs_0393", textures = {"go_stage186", "kr4_level36_malik"}, scaled = true, sounds = {"branch_campaigns"}}
}
local by_name = {}
for _, boss in ipairs(M.list) do by_name[boss.name] = boss end
function M.get(name) return by_name[name] end

function M.register(name)
	local def = assert(M.get(name), "Unknown allied boss: " .. tostring(name))
	if name == blackburn.name then
		return require("allied_boss_skills").decorate(blackburn.register(), require("entity_db"):get_template(def.source), def)
	end
	local E, A = require("entity_db"), require("animation_db")
	local scripts, GS = require("scripts"), require("game_settings")
	local V, bit = require("klua.vector"), require("bit")
	local boss = assert(E:get_template(def.source), "Boss template missing: " .. def.source)
	local render = table.deepclone(boss.render)
	-- Normalize names per visual layer, including bosses with no walking animation.
	for i, sprite in ipairs(render.sprites) do
		if sprite.animated and not sprite.ignore_start then
			local source, prefix = sprite.prefix, name .. "_layer" .. i
			local function alias(target, candidates)
				for _, candidate in ipairs(candidates) do
					local animation = A.db[source .. "_" .. candidate]
					if animation then A.db[prefix .. "_" .. target] = animation; return end
				end
				error("Boss animation missing: " .. source .. "_" .. target)
			end
			alias("idle", {"idle", "walk"})
			alias("attack", {boss.melee and boss.melee.attacks[1].animation or "attack", "attack", "melee"})
			alias("death", {boss.unit.death_animation or "death", "death", "deathIn"})
			alias("walk", {"walk", "walkingRightLeft", "idle"})
			alias("walkUp", {"walkUp", "walkingUp", "walk", "idle"})
			alias("walkDown", {"walkDown", "walkingDown", "walk", "idle"})
			alias("respawn", {"idle", "walk"})
			sprite.prefix, sprite.name = prefix, "idle"
			sprite.angles = {walk = {"walk", "walkUp", "walkDown"}}
			sprite.hidden = false
		end
	end
	-- Animation databases may reload independently of entity templates.
	if E.entities[name] then return require("allied_boss_skills").decorate(E.entities[name], boss, def) end
	local t = E:register_t(name, "hero")
	E:add_comps(t, "melee")
	t.render = render
	t.health.hp_max = type(boss.health.hp_max) == "table" and boss.health.hp_max[1] or boss.health.hp_max
	t.health.hp, t.health.armor, t.health.magic_armor = t.health.hp_max, boss.health.armor or 0, boss.health.magic_armor or 0
	t.health.dead_lifetime = 20
	t.health_bar = table.deepclone(boss.health_bar)
	t.health_bar.hidden = false
	t.motion.max_speed = 60
	t.regen.cooldown, t.regen.health = 1, math.ceil(t.health.hp_max / 100)
	t.info.fn, t.info.i18n_key = scripts.hero_basic.get_info_melee, boss.info.i18n_key
	t.info.portrait, t.info.hero_portrait = def.icon, def.icon
	t.ui.click_rect = table.deepclone(boss.ui.click_rect)
	t.unit.size = boss.unit.size
	t.unit.hit_offset, t.unit.mod_offset, t.unit.marker_offset = V.vclone(boss.unit.hit_offset), V.vclone(boss.unit.mod_offset), V.vclone(boss.unit.marker_offset)
	t.soldier.melee_slot_offset = V.v(25, 0)
	t.melee.range = 100
	local attack = E:clone_c("area_attack")
	local native = boss.melee and boss.melee.attacks[1]
	if native then
		attack.damage_min, attack.damage_max = native.damage_min, native.damage_max
		attack.damage_type, attack.cooldown, attack.hit_time = native.damage_type, native.cooldown, native.hit_time
		attack.damage_radius, attack.count = native.damage_radius or 45, native.count or native.max_count or 8
		attack.hit_offset = native.hit_offset and V.vclone(native.hit_offset) or V.v(25, 0)
	else
		local barrage = assert(boss.pirate.ghost_barrage)
		attack.damage_min, attack.damage_max = barrage.damage_min, barrage.damage_max
		attack.damage_type, attack.cooldown, attack.hit_time = DAMAGE_MAGICAL, barrage.cooldown, 0.5
		attack.damage_radius, attack.count = barrage.radius, 8
	end
	attack.animation, attack.vis_flags = "attack", F_BLOCK
	attack.vis_bans, attack.damage_bans, attack.damage_flags = bit.bor(F_FLYING, F_CLIFF), F_FLYING, F_AREA
	attack.xp_gain_factor = 0
	if native then attack.sound = native.sound or native.sound_hit; attack.hit_fx = native.hit_fx end
	t.melee.attacks[1] = attack
	if def.bombardment then
		-- Spectro's full barrage is driven by allied_boss_skills.
		t.vis.flags = bit.bor(t.vis.flags, F_FLYING)
		t.vis.bans = bit.bor(t.vis.bans, F_BLOCK)
		t.soldier.can_be_blocked = false
		attack.vis_flags, attack.vis_bans, attack.damage_bans = F_RANGED, 0, 0
	end
	t.hero.skills = {}
	t.hero.fn_level_up = function(this, store, initial)
		this.hero.level, this.hero.xp, this.hero.xp_queued = 10, GS.hero_xp_thresholds[9], 0
		if initial then this.health.hp = this.health.hp_max end
	end
	t.main_script.insert = scripts.hero_basic.insert
	return require("allied_boss_skills").decorate(t, boss, def)
end
return M
