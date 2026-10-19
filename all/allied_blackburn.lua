-- Playable Blackburn: a separate hero template, never an enemy boss instance.
local C
local enhance=require("blackburn_enhance")
local M = {name = "hero_allied_blackburn", title = "Blackburn", source = "eb_blackburn", icon = "encyclopedia_creep_thumbs_0169", textures = {"go_stage70", "go_enemies_common"}, sounds = {"BlackburnSounds"}}
M.kind="blackburn"
M.can_attack_air=true
M.texture="go_stage70"
M.portrait=M.icon:gsub("encyclopedia_creep_thumbs_","encyclopedia_creeps_")
M.skill={label="Đạp",cooldown=5,range=284,description="Đánh được mục tiêu bay. Đạp đất gây choáng cả trên không. Tự gọi Skeleton Knight từ xác địch gần đó (tối đa 15 lính)."}

function M.register()
	C=require("allied_boss_common")
	local E = require("entity_db")
	local A = require("animation_db")
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
    if E.entities[M.name] then
        local t=C.decorate(E.entities[M.name],boss,M)
        enhance.prepare_ally(t,enhance.level())
        return t
    end

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
	t.info.portrait = "info_portraits_sc_0092"
	t.info.hero_portrait = "info_portraits_sc_0092"
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

    C.decorate(t,boss,M)
    enhance.prepare_ally(t,enhance.level())
    return t
end

function M.active_radius(native)
    local template=require("entity_db").entities[M.name]
    local p=enhance.profile(template and template.blackburn_level)
    return p and p.radius or native.timed_attacks.list[1].damage_radius
end
function M.passive(this,store)
    if this.blackburn_level then enhance.tick(this,store)
    else C.raise(this,store,"enemy_skeleton_big",106.383,0.5,15) end
end
M.configure_summon=enhance.configure_summon
M.hold=enhance.hold
function M.active(this,store)
	local a=C.native(this).timed_attacks.list[1]
    local p=enhance.profile(this.blackburn_level)
    if C.cast(this,store,a.animation,a.hit_time,a.sound) and not this.boss_form then
        C.area(store,this,this.pos,p and p.radius or a.damage_radius,p and p.stomp[1] or a.damage_min,
            p and p.stomp[2] or a.damage_max,a.damage_type,4,nil,false)
		C.visual(a.fx,this.pos,store,1);C.visual(a.hit_decal,this.pos,store,2)
	end
end
return M
