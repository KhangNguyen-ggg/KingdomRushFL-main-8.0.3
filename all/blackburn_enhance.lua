-- Shared Blackburn tiers. Runtime work starts only when a powered Blackburn spawns.
local M = {}
local E, U, SU, C, V, P, bit
local profiles = {
    [1] = {name="Hiệp sĩ bất khuất", hp=1.2, armor=0.75, magic=0.1, damage={140,220}, cooldown=1.3+40/30,
        stomp={60,90}, radius=120, knight_hp=1.25, knight_damage=1.1},
    [2] = {name="Lãnh chúa tử sĩ", hp=1.4, armor=0.75, magic=0.2, damage={180,280}, cooldown=2.4,
        stomp={180,240}, radius=140, knight_hp=1.5, knight_damage=1.35, judgment=4,
        cry=1.15, cry_duration=5, cry_radius=180, wave={120,180}, wave_cooldown=8},
    [3] = {name="Lời thề vĩnh cửu", hp=1.8, armor=0.8, magic=0.3, damage={260,360}, cooldown=2.2,
        stomp={350,450}, radius=160, knight_hp=1.5, knight_damage=1.75, judgment=3,
        cry=1.25, cry_duration=6, cry_radius=200, wave={220,320}, wave_cooldown=6}
}

function M.level(slot)
    if slot == nil then
        local storage=require("storage")
        slot=storage.slot
        if not slot and storage.active_slot_idx then slot=storage:load_slot(nil,true) end
    end
    local value = slot and slot.liuhui and slot.liuhui.blackburn_level
    if type(value) ~= "number" or value ~= value then return 0 end
    return math.max(0, math.min(3, math.floor(value)))
end

function M.label(slot)
    local level = M.level(slot)
    return level == 0 and "Blackburn: Gốc" or "Blackburn: "..level
end

function M.profile(level) return profiles[level] end

function M.description(level)
    local p = profiles[level]
    if not p then return "Bản gốc. Đánh được mục tiêu bay, đạp đất gây choáng và gọi tối đa 15 Skeleton Knight từ xác địch." end
    local text = "Mức "..level.." — "..p.name..". Giáp phép "..math.floor(p.magic*100).."%. Đạp "..p.stomp[1].."–"..p.stomp[2].." sát thương chuẩn, choáng 4 giây, hồi 5 giây."
    if level >= 2 then
        text = text.." Mỗi đòn thứ "..p.judgment.." gây chuẩn. Sóng chém "..p.wave[1].."–"..p.wave[2].." chuẩn. Chiến lệnh tăng "..math.floor((p.cry-1)*100+0.5).."% sát thương tháp và quân triệu hồi."
    end
    if level == 3 then
        text = text.." Gọi Fallen Knight; chết hóa Spectral Knight một lần. Tổng 15 quân, cùng hạn 60 giây. Tái hợp sau đòn chí tử: 3 giây, hồi 35% máu, hồi chiêu 90 giây."
    else
        text = text.." Gọi tối đa 15 Skeleton Knight, mỗi quân tồn tại 60 giây."
    end
    return text.." Cùng mức cho đồng minh và boss KR1."
end

local function bind()
    E, U, SU = require("entity_db"), require("utils"), require("script_utils")
    C, V, P, bit = require("allied_boss_common"), require("klua.vector"), require("path_db"), require("bit")
end

local function alive(e)
    return e and not e.pending_removal and e.health and not e.health.dead and (e.health.hp or 0)>0
end

local function state(this, store)
    if not this.blackburn_state then
        this.blackburn_state = {born=store.tick_ts, next_raise=store.tick_ts+0.5,
            next_cry=store.tick_ts+15, next_wave=store.tick_ts+(profiles[this.blackburn_level].wave_cooldown or 8),
            summons={}, swings=0}
    end
    return this.blackburn_state
end

local function queue_remove(store, e)
    require("simulation"):queue_remove_entity(e)
end

local function queue_insert(store, e)
    require("simulation"):queue_insert_entity(e)
end

local function combat_damage(store, owner, target, lo, hi, kind)
    local d = E:create_damage()
    d.source_id, d.target_id = owner.id, target.id
    d.value = math.floor(math.random(lo,hi)*(owner.unit.damage_factor or 1))
    d.damage_type = kind
    store.damage_queue[#store.damage_queue+1] = d
end

local function clear_blockers(this, store)
    if this.soldier then
        U.unblock_target(store,this)
        this.nav_rally.new = true
    elseif this.enemy then
        local blockers = table.clone(this.enemy.blockers or {})
        for _, id in ipairs(blockers) do
            local soldier = store.entities[id]
            if soldier and soldier.soldier then U.unblock_target(store,soldier) end
        end
    end
end

function M.hold(this, store)
    local s = this.blackburn_state
    if not s or not s.reform_until then return false end
    if not this.health.dead and store.tick_ts < s.reform_until then return true end
    if not this.health.dead then this.health.hp = math.max(1,math.floor(this.health.hp_max*0.35)) end
    this.health.ignore_damage, this.vis.bans = s.old_ignore, s.old_bans
    for i,sprite in ipairs(this.render.sprites) do sprite.alpha=s.old_alpha[i] end
    this.boss_form, s.reform_until = nil,nil
    U.animation_start(this,"idle",nil,store.tick_ts,true)
    return false
end

local function on_damage(this, store, damage)
    local s = state(this,store)
    if s.previous_on_damage and not s.previous_on_damage(this,store,damage) then return false end
    if s.reform_until then return false end
    if store.tick_ts < (s.reform_ready or 0) or
        bit.band(damage.damage_type,bit.bor(DAMAGE_INSTAKILL,DAMAGE_EAT,DAMAGE_NO_KILL))~=0 or
        U.predict_damage(this,damage)<this.health.hp then return true end
    s.reform_ready, s.reform_until = store.tick_ts+90,store.tick_ts+3
    s.old_ignore, s.old_bans, s.old_alpha = this.health.ignore_damage,this.vis.bans,{}
    this.health.hp, this.health.ignore_damage, this.boss_form = 1,true,true
    this.vis.bans = bit.bor(this.vis.bans,F_BLOCK,F_STUN)
    for i,sprite in ipairs(this.render.sprites) do
        s.old_alpha[i]=sprite.alpha
        if not sprite.is_shadow then sprite.alpha=65 end
    end
    clear_blockers(this,store)
    U.animation_start(this,"idle",nil,store.tick_ts,true)
    C.visual("decal_blackburn_smash_ground",this.pos,store,3)
    return false
end

local function judgment(this,store,attack)
    local s=state(this,store)
    if s.reform_until then return false end
    s.swings=s.swings+1
    local charged=s.swings%profiles[this.blackburn_level].judgment==0
    attack.damage_type=charged and DAMAGE_TRUE or DAMAGE_EXPLOSION
    if charged then C.visual("fx_blackburn_smash",this.pos,store,0.7) end
    return true
end

function M.apply(this, level)
    local p=profiles[level]
    if not p or this.blackburn_level==level and this.blackburn_configured then return this end
    bind()
    this.blackburn_level, this.blackburn_configured = level,true
    local h=this.health
    local fraction=h.hp and h.hp/h.hp_max or 1
    h.hp_max=math.floor(h.hp_max*p.hp+0.5)
    h.hp=math.max(1,math.floor(h.hp_max*fraction+0.5))
    h.armor,h.magic_armor=p.armor,p.magic
    local attack=this.melee.attacks[1]
    attack.damage_min,attack.damage_max=p.damage[1],p.damage[2]
    attack.damage_type,attack.cooldown=DAMAGE_EXPLOSION,p.cooldown
    if p.judgment then attack.fn_can=judgment end
    if this.soldier then this.regen.health=math.ceil(h.hp_max/100) end
    if this.timed_attacks then
        local stomp=this.timed_attacks.list[1]
        stomp.damage_min,stomp.damage_max=p.stomp[1],p.stomp[2]
        stomp.damage_radius,stomp.cooldown,stomp.after_cooldown=p.radius,5,5
    end
    if level==3 then
        this.blackburn_previous_on_damage=h.on_damage
        h.on_damage=function(e,store,d)
            local s=state(e,store)
            s.previous_on_damage=e.blackburn_previous_on_damage
            return on_damage(e,store,d)
        end
    end
    return this
end

local function configure_knight(owner, e)
    local p=profiles[owner.blackburn_level]
    if not p then return end
    e.blackburn_owner, e.blackburn_level = owner,owner.blackburn_level
    local h=e.health
    h.hp_max=math.floor(h.hp_max*p.knight_hp+0.5)
    h.hp=h.hp_max
    local native=E:get_template(e.summon_source or e.blackburn_source)
    h.immune_to=native.health.immune_to
    for _,key in ipairs({"blood_color","can_explode","hide_after_death","show_blood_pool"}) do e.unit[key]=native.unit[key] end
    for _,a in ipairs(e.melee.attacks) do
        a.damage_min=math.floor(a.damage_min*p.knight_damage+0.5)
        a.damage_max=math.floor(a.damage_max*p.knight_damage+0.5)
    end
end
M.configure_summon=configure_knight

local function set_warcry_factor(mod,target,factor)
    local old=mod.applied_factor or 1
    local ratio=factor/old
    if target.tower then
        target.tower.damage_factor=target.tower.damage_factor*ratio
    elseif target.soldier then
        -- The KR1 allied area-attack helper reads raw attack damage, not unit.damage_factor.
        mod.base_damage=mod.base_damage or {}
        for i,a in ipairs(target.melee.attacks) do
            local base=mod.base_damage[i] or {a.damage_min,a.damage_max}
            mod.base_damage[i]=base
            a.damage_min=math.floor(base[1]*factor+0.5)
            a.damage_max=math.floor(base[2]*factor+0.5)
        end
    else
        target.unit.damage_factor=target.unit.damage_factor*ratio
    end
    mod.applied_factor=factor
end

local function warcry_insert(mod,store)
    local target=store.entities[mod.modifier.target_id]
    if not target or not (target.tower or alive(target)) then return false end
    set_warcry_factor(mod,target,mod.factor)
    return true
end

local function warcry_remove(mod,store)
    local target=store.entities[mod.modifier.target_id]
    if target and mod.applied_factor then set_warcry_factor(mod,target,1) end
    if target and target.blackburn_warcry==mod then target.blackburn_warcry=nil end
    return true
end

local function warcry_update(mod,store)
    while store.tick_ts<mod.expires do
        local target=store.entities[mod.modifier.target_id]
        if not target or target.health and target.health.dead then break end
        coroutine.yield()
    end
    queue_remove(store,mod)
end

local function buff(owner,target,store,p)
    local mod=target.blackburn_warcry
    if mod and not mod.pending_removal and store.tick_ts<mod.expires then
        if p.cry>=mod.factor then
            mod.factor,mod.expires=p.cry,store.tick_ts+p.cry_duration
            if mod.applied_factor then set_warcry_factor(mod,target,p.cry) end
        end
        return
    end
    if mod and mod.applied_factor then
        set_warcry_factor(mod,target,1)
        mod.applied_factor=nil
    end
    mod=E:create_entity("mod_blackburn_warcry")
    mod.modifier.source_id,mod.modifier.target_id=owner.id,target.id
    mod.factor,mod.expires=p.cry,store.tick_ts+p.cry_duration
    target.blackburn_warcry=mod
    queue_insert(store,mod)
end

local function wave_update(wave,store)
    local start=store.tick_ts
    local from=V.vclone(wave.pos)
    while store.tick_ts-start<0.35 do
        local f=math.min(1,(store.tick_ts-start)/0.35)
        wave.pos.x=from.x+(wave.destination.x-from.x)*f
        wave.pos.y=from.y+(wave.destination.y-from.y)*f
        coroutine.yield()
    end
    if alive(wave.owner) and not wave.owner.boss_form then
        local p=profiles[wave.owner.blackburn_level]
        for _,e in pairs(store.entities) do
            if alive(e) and (wave.owner.soldier and e.enemy or wave.owner.enemy and e.soldier) and
                bit.band(e.vis.bans,F_AREA)==0 and U.is_inside_ellipse(e.pos,wave.destination,75) then
                combat_damage(store,wave.owner,e,p.wave[1],p.wave[2],DAMAGE_TRUE)
            end
        end
        C.visual("fx_blackburn_smash",wave.destination,store,0.7)
    end
    queue_remove(store,wave)
end

local function register_effects()
    if not E.entities.mod_blackburn_warcry then
        local t=E:register_t("mod_blackburn_warcry","modifier")
        t.main_script.insert,t.main_script.update,t.main_script.remove=warcry_insert,warcry_update,warcry_remove
        t.modifier.duration=6
    end
    if not E.entities.blackburn_soul_wave then
        local t=E:register_t("blackburn_soul_wave","decal_scripted")
        t.render=table.deepclone(E:get_template("fx_blackburn_smash").render)
        for _,sprite in ipairs(t.render.sprites) do sprite.scale=V.v(0.65,0.65);sprite.alpha=180 end
        t.main_script.update=wave_update
    end
end

local function enemy_summon_update(this,store)
    local native=E:get_template(this.blackburn_source).main_script.update
    local co=coroutine.create(native)
    while true do
        if store.tick_ts>=this.expires or not alive(this.blackburn_owner) then
            clear_blockers(this,store)
            queue_remove(store,this)
            return
        end
        if this.health.dead and this.blackburn_source=="enemy_fallen_knight" and not this.blackburn_replaced then
            this.blackburn_replaced=true
            M.summon_enemy(this.blackburn_owner,"enemy_spectral_knight_spawn",this.pos,store,this.expires)
        end
        local ok,err=coroutine.resume(co,this,store)
        if not ok then error(err) end
        if coroutine.status(co)=="dead" then return end
        coroutine.yield()
    end
end

function M.summon_enemy(owner,source,pos,store,expires)
    local nodes=P:nearest_nodes(pos.x,pos.y,{owner.nav_path.pi})
    if not nodes or #nodes==0 then return end
    local pi,spi,ni=unpack(nodes[1])
    if not P:is_node_valid(pi,ni) then return end
    local name="blackburn_army_"..source
    if not E.entities[name] then
        local t=E:register_t(name,source)
        t.death_spawns,t.auras=nil,nil
        t.enemy.gold,t.enemy.gems=0,0
        t.main_script.update=enemy_summon_update
    end
    local e=E:create_entity(name)
    e.blackburn_owner,e.blackburn_source,e.expires=owner,source,expires or store.tick_ts+60
    e.nav_path.pi,e.nav_path.spi,e.nav_path.ni=pi,spi,ni
    e.pos=V.vclone(pos)
    if source~="enemy_fallen_knight" then e.render.sprites[1].name="raise" end
    configure_knight(owner,e)
    local s=state(owner,store)
    s.summons[#s.summons+1]=e
    queue_insert(store,e)
    return e
end

local function raise_enemy(this,store,s,p)
    for i=#s.summons,1,-1 do
        local e=s.summons[i]
        local pending=e.health.dead and e.blackburn_source=="enemy_fallen_knight" and not e.blackburn_replaced
        if e.expires<=store.tick_ts or not alive(e) and not pending then table.remove(s.summons,i) end
    end
    if #s.summons>=15 then return end
    for _,dead in ipairs(C.corpses(store)) do
        if dead.soldier and not dead.hero and not dead._allied_corpse_claimed and
            bit.band(dead.vis.bans or 0,F_SKELETON)==0 and U.is_inside_ellipse(dead.pos,this.pos,p.radius) then
            local source=this.blackburn_level==3 and "enemy_fallen_knight" or "enemy_skeleton_big"
            if M.summon_enemy(this,source,dead.pos,store) then
                dead._allied_corpse_claimed=true
                dead.vis.bans=bit.bor(dead.vis.bans or 0,F_SKELETON)
                return
            end
        end
    end
end

function M.tick(this,store)
    local p=profiles[this.blackburn_level]
    if not p or not alive(this) then return end
    local s=state(this,store)
    if s.reform_until then return end
    if store.tick_ts>=s.next_raise then
        s.next_raise=store.tick_ts+0.5
        if this.enemy then raise_enemy(this,store,s,p)
        else C.raise(this,store,this.blackburn_level==3 and "enemy_fallen_knight" or "enemy_skeleton_big",p.radius,0.5,15) end
    end
    if not p.cry or this.unit.is_stunned then return end
    if store.tick_ts>=s.next_cry then
        s.next_cry=store.tick_ts+15
        for _,e in pairs(store.entities) do
            if e.pos and U.is_inside_ellipse(e.pos,this.pos,p.cry_radius) and
                (this.soldier and (e.tower and not e.enemy or alive(e) and e.blackburn_owner==this) or
                this.enemy and e~=this and e.enemy and alive(e)) then buff(this,e,store,p) end
        end
        C.visual("decal_blackburn_smash_ground",this.pos,store,p.cry_duration)
    end
    if store.tick_ts>=s.next_wave then
        s.next_wave=store.tick_ts+0.25
        local target
        local nearest=240*240
        for _,e in pairs(store.entities) do
            if alive(e) and (this.soldier and e.enemy or this.enemy and e.soldier) and
                bit.band(e.vis.bans,F_AREA)==0 then
                local d=(this.pos.x-e.pos.x)^2+(this.pos.y-e.pos.y)^2
                if d>100*100 and d<=nearest then target,nearest=e,d end
            end
        end
        if target then
            s.next_wave=store.tick_ts+p.wave_cooldown
            local wave=E:create_entity("blackburn_soul_wave")
            wave.pos,wave.destination,wave.owner=V.vclone(this.pos),V.vclone(target.pos),this
            queue_insert(store,wave)
        end
    end
end

function M.prepare_ally(t,level)
    if not profiles[level] then return end
    M.apply(t,level)
    register_effects()
end

function M.install_enemy()
    local level=M.level()
    if level==0 then return end
    bind()
    register_effects()
    local t=E:get_template("eb_blackburn")
    local insert,update=t.main_script.insert,t.main_script.update
    t.main_script.insert=function(this,store,script)
        -- Replace the native raising aura so both forms share one bounded army.
        this.auras.list={}
        if insert and not insert(this,store,script) then return false end
        M.apply(this,level)
        return true
    end
    t.main_script.update=function(this,store)
        local co=coroutine.create(update)
        while true do
            if not M.hold(this,store) then
                M.tick(this,store)
                local ok,err=coroutine.resume(co,this,store)
                if not ok then error(err) end
                if coroutine.status(co)=="dead" then return end
            end
            coroutine.yield()
        end
    end
end

return M
