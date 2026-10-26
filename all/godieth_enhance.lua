-- One burn modifier per target, shared by allied and enemy Godieth.
local M={}
local E,A,bit
function M.level(slot)
	if slot==nil then
		local storage=require("storage")
		slot=storage.slot
		if not slot and storage.active_slot_idx then slot=storage:load_slot(nil,true) end
	end
	local value=slot and slot.liuhui and slot.liuhui.godieth_level
	-- Existing slots keep the enhanced Godieth until the player chooses otherwise.
	if type(value)~="number" or value~=value then return 1 end
	return math.max(0,math.min(1,math.floor(value)))
end
function M.label(slot)
	return M.level(slot)==0 and "Godieth: Gốc" or "Godieth: Cường hóa"
end
function M.description(level)
	if level==0 then
		return "Bản gốc: cận chiến, phun độc mỗi 10 giây (Impossible: 9). Vùng độc 10 giây, bán kính 50, cơ bản 10 sát thương mỗi 11 khung hình; nạn nhân phù hợp chết hóa Shadow Spawn. Không có nội tại cường hóa. Lựa chọn áp dụng cho cả đồng minh và boss địch."
	end
	return "Bản cường hóa: miễn sát thương lửa và mọi thiêu đốt, kể cả đốt sát thương chuẩn. Xuyên 50% giáp hiện có. Đánh thường đốt 1% HP tối đa/giây trong 5 giây mỗi lớp; lính và miniboss tối đa 10 lớp, boss 1 lớp. Mỗi 1% máu thiếu: +1% hút máu thực gây, +2% tốc đánh, +3% sát thương đánh/độc (không nhân đốt theo HP). Giữ phun độc và Shadow Spawn của bản gốc. Áp dụng cho cả đồng minh và boss địch."
end
local function bind()
	E,A,bit=require("entity_db"),require("animation_db"),require("bit")
end
local function alive(e)
	return e and not e.pending_removal and e.health and not e.health.dead and (e.health.hp or 0)>0
end
local function hostile(a,b)
	return a.soldier and b.enemy or a.enemy and b.soldier
end
local function missing(this)
	return math.max(0,math.min(1,1-this.health.hp/this.health.hp_max))
end
local function fire_name(name)
	name=(name or ""):lower()
	return name:find("burn",1,true) or name:find("fire",1,true) or name:find("flam",1,true) or
		name:find("lava",1,true) or name:find("scorch",1,true) or name:find("immolat",1,true) or
		name:find("conflagration",1,true) or name:find("magma",1,true) or name:find("infernal",1,true) or
		name=="furnace_coal" or name=="mod_black_baby_dragon"
end
local function fire_modifier(mod)
	local flags=mod.modifier and mod.modifier.vis_flags or mod.aura and mod.aura.vis_flags or 0
	if bit.band(flags,F_BURN)~=0 or
		mod.dps and bit.band(mod.dps.damage_type or 0,DAMAGE_FIREBALL)~=0 then return true end
	if not (mod.dps or mod.aura) then return false end
	-- Older fire DOTs (including Faustus) carry neither F_BURN nor DAMAGE_FIREBALL.
	if fire_name(mod.template_name) then return true end
	for _,sprite in ipairs(mod.render and mod.render.sprites or {}) do
		if fire_name(sprite.prefix) or fire_name(sprite.name) then return true end
	end
	return false
end
local function burn_tick(mod,store)
	local target=store.entities[mod.modifier.target_id]
	if not alive(target) or bit.band(target.vis.bans,F_BURN)~=0 then return false end
	mod.pos=target.pos
	local offset=target.unit and target.unit.mod_offset
	if offset then mod.render.sprites[1].offset.x,mod.render.sprites[1].offset.y=offset.x,offset.y end
	for i=#mod.stacks,1,-1 do
		local stack=mod.stacks[i]
		while stack.next_tick<=store.tick_ts+1e-7 and stack.next_tick<=stack.expires+1e-7 do
			local d=E:create_damage()
			d.source_id,d.target_id=stack.source_id,target.id
			d.value,d.damage_type=target.health.hp_max*0.01,bit.bor(DAMAGE_TRUE,DAMAGE_MODIFIER)
			d.godieth_burn=true
			store.damage_queue[#store.damage_queue+1]=d
			stack.next_tick=stack.next_tick+1
		end
		if store.tick_ts>=stack.expires-1e-7 and stack.next_tick>stack.expires then table.remove(mod.stacks,i) end
	end
	return #mod.stacks>0
end
local function burn_remove(mod,store)
	local target=store.entities[mod.modifier.target_id]
	if target and target._godieth_burn==mod then target._godieth_burn=nil end
	mod.finished=true
	return true
end
local function register_burn()
	if E.entities.mod_godieth_burn then return end
	local t=E:register_t("mod_godieth_burn","modifier")
	E:add_comps(t,"render")
	t.render=table.deepclone(E:get_template("mod_veznan_demon_fire").render)
	t.modifier.vis_flags=bit.bor(F_MOD,F_BURN)
	t.modifier.duration=5
	t.main_script.insert=function(mod,store)
		local target=store.entities[mod.modifier.target_id]
		if not alive(target) or bit.band(target.vis.bans,F_BURN)~=0 then burn_remove(mod,store);return false end
		return true
	end
	t.main_script.remove=burn_remove
	t.main_script.update=function(mod,store)
		while burn_tick(mod,store) do coroutine.yield() end
		burn_remove(mod,store)
		require("simulation"):queue_remove_entity(mod)
	end
end
function M.add_burn(this,target,store)
	if not alive(target) or not hostile(this,target) or bit.band(target.vis.bans,F_BURN)~=0 then return end
	local mod=target._godieth_burn
	if not mod or mod.finished or mod.pending_removal then
		mod=E:create_entity("mod_godieth_burn")
		mod.modifier.source_id,mod.modifier.target_id=this.id,target.id
		mod.pos,mod.stacks=target.pos,{}
		target._godieth_burn=mod
		require("simulation"):queue_insert_entity(mod)
	else burn_tick(mod,store) end
	local cap=target.boss_kind or bit.band(target.vis.flags,F_BOSS)~=0 and bit.band(target.vis.flags,F_MINIBOSS)==0
	cap=cap and 1 or 10
	if #mod.stacks<cap then
		mod.stacks[#mod.stacks+1]={source_id=this.id,expires=store.tick_ts+5,next_tick=store.tick_ts+1}
	else
		local oldest=mod.stacks[1]
		for _,stack in ipairs(mod.stacks) do if stack.expires<oldest.expires then oldest=stack end end
		-- Refreshing at the cap must not postpone the next damage tick.
		oldest.source_id,oldest.expires=this.id,store.tick_ts+5
	end
end
local function on_damage_dealt(this,target,store,damage,amount,direct)
	if not alive(this) or not hostile(this,target) then return end
	if bit.band(damage.damage_type,DAMAGE_NO_LIFESTEAL)==0 then
		this.health.hp=math.min(this.health.hp_max,this.health.hp+amount*missing(this))
	end
	if direct and damage.track_damage and bit.band(damage.damage_type,DAMAGE_MODIFIER)==0 then M.add_burn(this,target,store) end
end
local function prepare_damage(this,target,store,damage)
	-- Percent-HP burning keeps its advertised 1%/10% cap even while enraged.
	if damage.godieth_burn then return end
	damage.value=damage.value*(1+3*missing(this))
	if bit.band(damage.damage_type,bit.bor(DAMAGE_PHYSICAL,DAMAGE_SHOT,DAMAGE_EXPLOSION,DAMAGE_ELECTRICAL,DAMAGE_DWAARP))~=0 then
		local armor=math.max(0,(target.health.armor or 0)-(damage.reduce_armor or 0))
		damage.reduce_armor=(damage.reduce_armor or 0)+armor*0.5
	end
end
local function attack_start(this,store,attack,target)
	local s=this.godieth_power
	if s.previous_can and not s.previous_can(this,store,attack,target) then return false end
	local factor=1+2*missing(this)
	attack.hit_time=s.hit_time/factor
	for i,sprite in ipairs(this.render.sprites) do
		if sprite.animated and not sprite.ignore_start then sprite.fps=(s.sprite_fps[i] or A.fps)*factor end
	end
	return true
end
function M.tick(this,store)
	local s=this.godieth_power
	if not s then return end
	local active=alive(this)
	for i,sprite in ipairs(this.render.sprites) do
		if not active or sprite.name~="attack" then sprite.fps=s.sprite_fps[i] end
	end
	if not active then return end
	this.health.immune_to=bit.bor(this.health.immune_to or 0,DAMAGE_FIREBALL)
	this.vis.bans=bit.bor(this.vis.bans,F_BURN)
	this.melee.attacks[1].cooldown=s.cooldown/(1+2*missing(this))
end
function M.apply(t)
	if M.level()==0 or t.godieth_power then return t end
	bind();register_burn()
	local attack=t.melee.attacks[1]
	t.godieth_power={cooldown=attack.cooldown,hit_time=attack.hit_time,previous_can=attack.fn_can,sprite_fps={}}
	for i,sprite in ipairs(t.render.sprites) do t.godieth_power.sprite_fps[i]=sprite.fps end
	t.health.immune_to=bit.bor(t.health.immune_to or 0,DAMAGE_FIREBALL)
	t.vis.bans=bit.bor(t.vis.bans,F_BURN)
	local previous_filter=t.unit.modifier_filter
	t.unit.modifier_filter=function(mod,store)
		return not fire_modifier(mod) and (not previous_filter or previous_filter(mod,store))
	end
	local previous_damage=t.health.on_damage
	t.health.on_damage=function(this,store,damage)
		local source=store.entities[damage.source_id]
		if damage.godieth_burn or source and (source.modifier or source.aura or source.dps) and fire_modifier(source) then return false end
		return not previous_damage or previous_damage(this,store,damage)
	end
	t.unit.prepare_damage=prepare_damage
	t.unit.on_damage_dealt=on_damage_dealt
	attack.track_damage,attack.fn_can=true,attack_start
	local update=t.main_script.update
	t.main_script.update=function(this,store)
		local co=coroutine.create(update)
		while true do
			M.tick(this,store)
			local ok,err=coroutine.resume(co,this,store)
			if not ok then error(err) end
			if coroutine.status(co)=="dead" then return end
			coroutine.yield()
		end
	end
	return t
end
function M.install_enemy()
	if M.level()==0 then return end
	bind()
	M.apply(E:get_template("eb_balrog"))
end
return M
