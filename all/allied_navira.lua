-- Allied Navira: alternating punches, true-damage strike, terrain travel and red soul magic.
local C,E,A,U,I,SH,SU,GR,bit,balance
local STACK_HEAL=true
local M={
	name="hero_allied_navira",title="Navira",kind="navira",source="boss_navira",
	icon="encyclopedia_creep_thumbs_0554",textures={"encyclopedia_creeps","rebborn_enemy_icons","go_stage119"},sounds={"stage_19"},
	scaled=false,melee_damage=280,
	skill={label="Chuẩn",cooldown=10,range=450,
		description="Chiến đấu mặt đất, lướt nhanh gấp đôi khi vượt địa hình. Miễn khống chế và kén nhện. Đánh 280 luân phiên vật lý/phép. Mỗi 10 giây đấm chuẩn 560, bán kính gấp đôi, gồng lâu hơn 30%, hiệu ứng đấm gốc lớn hơn 50%. Giữ 3 tia choáng. Hút mọi xác hai phe trong tầm 250, cộng 5% HP tối đa mỗi xác trong 10 giây rồi hồi; đủ 10% HP tối đa Navira thì hồi ngay. Mỗi lần tối đa 10%, không hồi chiêu, gom tiếp ngay."}
}

function M.portrait_draw(this)
	local G=love.graphics
	local previous=G.getShader()
	G.setShader(require("klove.shader_db"):get("p_navira_ember"))
	KImageView._draw_self(this)
	G.setShader(previous)
end

local function red(render)
	for _,sprite in ipairs(render.sprites) do
		if not sprite.is_shadow then
			sprite.shader="p_navira_ember"
			sprite.shader_args=nil
		end
	end
end

local function control_flags()
	return bit.bor(F_STUN,F_FREEZE,F_SLOW,F_NET,F_THORN,F_TELEPORT,F_POLYMORPH,F_DRIDER_POISON)
end

function M.allow_modifier(mod)
	local m,script=mod.modifier,mod.main_script or {}
	if mod.slow and mod.slow.factor and mod.slow.factor>=1 and m.type==MOD_TYPE_SLOW and
		bit.band(m.vis_flags or 0,bit.band(control_flags(),bit.bnot(F_SLOW)))==0 then return true end
	if bit.band(m.vis_flags or 0,control_flags())~=0 or m.type==MOD_TYPE_STUN or m.type==MOD_TYPE_FREEZE or
		m.type==MOD_TYPE_SLOW or m.type==MOD_TYPE_TELEPORT or m.type==MOD_TYPE_POLYMORPH or m.type==MOD_TYPE_TIMELAPSE or
		mod.slow and mod.slow.factor and mod.slow.factor<1 then return false end
	local scripts=require("scripts")
	-- Spider cocoons reuse stun callbacks without always declaring a stun type or flag.
	for _,name in ipairs({"mod_stun","mod_freeze"}) do
		local native=scripts[name]
		if native and (native.insert and script.insert==native.insert or native.update and script.update==native.update) then return false end
	end
	return true
end

local function normal_ready(this,store,attack)
	local state=C.state(this,store)
	if attack.damage_type~=(state.next_damage_type or bit.bor(DAMAGE_PHYSICAL,DAMAGE_NO_DODGE)) then return false end
	state.pending_melee_ts=attack.ts
	return true
end

function M.prepare(t)
	local attack=t.melee.attacks[1]
	attack.damage_min,attack.damage_max=M.melee_damage,M.melee_damage
	attack.damage_type=bit.bor(DAMAGE_PHYSICAL,DAMAGE_NO_DODGE)
	attack.shared_cooldown,attack.fn_can,attack.hit_fx=true,normal_ready,nil
	t.melee.attacks[2]=table.deepclone(attack)
	t.melee.attacks[2].damage_type=bit.bor(DAMAGE_MAGICAL,DAMAGE_NO_DODGE)
	t.melee.order={1,2}
	-- Hovering across terrain must not exclude Navira from bosses' ground attacks.
	t.vis.flags=bit.band(t.vis.flags,bit.bnot(F_FLYING))
	t.vis.bans=bit.bor(t.vis.bans,control_flags())
	t.unit.ignore_stun,t.unit.modifier_filter=true,M.allow_modifier
	t.nav_rally.requires_node_nearby=true
	t.nav_grid.ignore_waypoints=false
	t.nav_grid.valid_terrains=bit.band(TERRAIN_ALL_MASK,bit.bnot(TERRAIN_FLYING_NOWALK))
	t.nav_grid.valid_terrains_dest=bit.bor(TERRAIN_LAND,TERRAIN_ICE)
	t.render.sprites[1].angles={walk={"idle","idle","idle"}}
	t.render.sprites[1].z=Z_OBJECTS
	red(t.render)
	local prefix=t.render.sprites[1].prefix
	A:duration(prefix.."_attack")
	local native=A.db[prefix.."_attack"]
	local charged=table.clone(native)
	charged.frames={}
	local windup=math.floor(attack.hit_time*A.fps+0.5)
	-- Stretch only the windup; both animation databases support explicit frame lists.
	for frame=1,math.floor(windup*1.3+0.5) do charged.frames[#charged.frames+1]=native.frames[math.ceil(frame/1.3)] end
	for frame=windup+1,#native.frames do charged.frames[#charged.frames+1]=native.frames[frame] end
	A.db[prefix.."_charged_attack"]=charged
	A.db.allied_navira_punch_run={prefix="allied_navira_punch",from=201,to=213}
end

function M.rally(this,store)
	local sprite=this.render.sprites[1]
	local speed,z=this.motion.max_speed,sprite.z
	local ground=bit.bor(TERRAIN_LAND,TERRAIN_ICE)
	if not GR:find_line_waypoints(this.pos,this.nav_rally.pos,ground) then
		this.motion.max_speed,sprite.z=speed*2,Z_FLYING_HEROES
	end
	local interrupted=SU.y_hero_new_rally(store,this)
	this.motion.max_speed,sprite.z=speed,z
	return interrupted
end

local function register_effects()
	if not E.entities.allied_navira_punch_fx then
		local t=E:register_t("allied_navira_punch_fx","decal_scripted")
		t.render=table.deepclone(C.native(E.entities[M.name]).render)
		t.render.sprites[1].prefix="allied_navira_punch"
		t.render.sprites[1].name="run"
		t.render.sprites[1].anchor={x=275/428,y=1-245/524}
		t.render.sprites[1].z=Z_FLYING_HEROES+1
		red(t.render)
		t.render.sprites[1].shader="p_navira_punch"
	end
	if not E.entities.allied_navira_heal_fx then
		local t=E:register_t("allied_navira_heal_fx",C.native(E.entities[M.name]).mod_heal)
		red(t.render)
	end
	if not E.entities.allied_navira_absorb_aura then
		local t=E:register_t("allied_navira_absorb_aura","decal_scripted")
		t.render=nil
		t.main_script.update=function(this,store)
			while true do
				local owner=store.entities[this.owner_id]
				if not owner or owner.pending_removal then C.remove(this);return end
				M.absorb(owner,store)
				coroutine.yield()
			end
		end
	end
end

local function register_ray()
	local native=E:get_template(C.native(E.entities[M.name]).fire_ball_bullet_t)
	local mod=E:get_template(native.bullet.mod)
	if not E.entities.allied_navira_soul_stun then
		local t=E:register_t("allied_navira_soul_stun","mod_stun")
		t.render=table.deepclone(mod.render)
		red(t.render)
		t.render.sprites[1].name="start"
		t.modifier.animation_phases=true
		t.modifier.duration=mod.modifier.duration
		t.modifier.vis_flags=bit.bor(F_MOD,F_STUN)
		t.modifier.use_mod_offset=true
		t.sound_events=table.deepclone(mod.sound_events)
	end
	if E.entities.allied_navira_soulray then return end
	local t=E:register_t("allied_navira_soulray","decal_scripted")
	t.render=table.deepclone(native.render)
	red(t.render)
	t.render.sprites[1].name="run"
	t.main_script.insert=nil
	t.main_script.update=function(this,store)
		local start,hit=store.tick_ts,false
		while store.tick_ts-start<this.life do
			if not hit and store.tick_ts-start>=this.hit_time then
				hit=true
				local target=store.entities[this.target_id]
				if C.alive(target) and target.enemy then
					local m=E:create_entity("allied_navira_soul_stun")
					m.modifier.source_id,m.modifier.target_id=this.source_id,target.id
					C.insert(m)
				end
			end
			coroutine.yield()
		end
		C.remove(this)
	end
end

function M.register()
	C=require("allied_boss_common")
	E,A,U,I,bit=require("entity_db"),require("animation_db"),require("utils"),require("klove.image_db"),require("bit")
	SH=require("klove.shader_db")
	SU,GR=require("script_utils"),require("grid_db")
	balance=require("balance/balance").enemies.undying_hatred.boss_navira
	local t=C.create(M)
	register_effects();register_ray()
	return t
end

local function punch_effect(this,store)
	if not I:s("allied_navira_punch_0201",true) then
		local boxes,masks={},{}
		for frame=201,213 do
			local native=I:s(string.format("navira_navira_%04d",frame))
			local quad=native.f_quad
			-- shortcut: native fist bounds are calibrated to this atlas; update them if its frames change.
			local sx,sy=native.size[1]/428,native.size[2]/524
			local left,top=math.max(math.floor(210*sx),native.trim[1]),math.max(math.floor(175*sy),native.trim[2])
			local right,bottom=math.min(math.floor(350*sx),native.trim[1]+quad[3]),math.min(math.floor(320*sy),native.trim[2]+quad[4])
			local sprite=table.clone(native)
			sprite.trim={left,top,native.size[1]-right,native.size[2]-bottom}
			sprite.f_quad={quad[1]+left-native.trim[1],quad[2]+top-native.trim[2],right-left,bottom-top}
			sprite.quad=love.graphics.newQuad(sprite.f_quad[1],sprite.f_quad[2],sprite.f_quad[3],sprite.f_quad[4],native.a_size[1],native.a_size[2])
			I.db_atlas[string.format("allied_navira_punch_%04d",frame)]=sprite
			local q,w,h=sprite.f_quad,native.a_size[1],native.a_size[2]
			boxes[#boxes+1]={q[1]/w,q[2]/h,(q[1]+q[3])/w,(q[2]+q[4])/h}
			masks[#masks+1]={(quad[1]+275*sx-native.trim[1])/w,(quad[2]+245*sy-native.trim[2])/h,60*sx/w,65*sy/h}
		end
		-- Every punch shares these atlas masks, so batched copies need no per-unit uniforms.
		local shader=SH:get("p_navira_punch")
		if shader then
			-- LÖVE 0.10.2 counts array arguments one short; duplicate the last value.
			boxes[14],masks[14]=boxes[13],masks[13]
			shader:send("punch_boxes",unpack(boxes))
			shader:send("punch_masks",unpack(masks))
		end
	end
	local native=I:s("navira_navira_0201")
	local body=this.render.sprites[1]
	local pos=C.copy(this.pos)
	pos.x=pos.x+(body.flip_x and -1 or 1)*(275/428-body.anchor.x)*native.size[1]*native.ref_scale
	pos.y=pos.y+((1-body.anchor.y)-245/524)*native.size[2]*native.ref_scale
	local visual=C.visual("allied_navira_punch_fx",pos,store,(A:duration("allied_navira_punch_run")),"run")
	local sprite=visual.render.sprites[1]
	sprite.flip_x,sprite.scale,sprite.loop=body.flip_x,{x=1.5,y=1.5},false
end

local function rays(this,store)
	local targets=U.find_enemies_in_range(store.entities,this.pos,0,M.skill.range,F_STUN,0) or {}
	local valid={}
	for _,target in ipairs(targets) do
		if target.enemy and C.alive(target) and bit.band(target.vis.bans,F_STUN)==0 then valid[#valid+1]=target end
	end
	table.sort(valid,function(a,b) return C.target_before(a,b,this.pos) end)
	local native=E:get_template(C.native(this).fire_ball_bullet_t)
	for i=1,math.min(3,#valid) do
		local target=valid[i]
		local e=E:create_entity("allied_navira_soulray")
		e.pos=C.copy(this.pos);e.pos.y=e.pos.y+80
		e.source_id,e.target_id=this.id,target.id
		e.hit_time=native.bullet.hit_time
		e.life=math.max(e.hit_time+1/30,(A:duration(native.render.sprites[1].prefix.."_run")))
		local dx,dy=target.pos.x-e.pos.x,target.pos.y-e.pos.y
		local sprite=e.render.sprites[1]
		sprite.r=(math.atan2 or math.atan)(dy,dx)
		sprite.scale={x=math.sqrt(dx*dx+dy*dy)/native.image_width,y=1}
		sprite.ts=store.tick_ts
		C.insert(e)
	end
end

function M.passive(this,store)
	local state=C.state(this,store)
	local last=this.melee.last_attack
	if last and state.pending_melee_ts and last.attack.ts~=state.pending_melee_ts then
		state.next_damage_type=bit.bor(bit.band(last.attack.damage_type,DAMAGE_MAGICAL)~=0 and DAMAGE_PHYSICAL or DAMAGE_MAGICAL,DAMAGE_NO_DODGE)
		state.pending_melee_ts=nil
	end
	if not this._navira_absorb_aura then
		local aura=E:create_entity("allied_navira_absorb_aura")
		aura.owner_id=this.id
		this._navira_absorb_aura=aura.id
		C.insert(aura)
	end
end

local function heal(this,store,amount)
	local hp=this.health.hp
	this.health.hp=math.min(this.health.hp_max,hp+amount)
	if this.health.hp>hp then
		local fx=E:create_entity("allied_navira_heal_fx")
		fx.modifier.source_id,fx.modifier.target_id=this.id,this.id
		C.insert(fx)
	end
end

function M.absorb(this,store)
	if not C.alive(this) then
		if this.boss_state then this.boss_state.heal_pool,this.boss_state.heal_started=nil,nil end
		return
	end
	local state=C.state(this,store)
	local cap=this.health.hp_max*0.1
	if STACK_HEAL and state.heal_started and store.tick_ts-state.heal_started>=10 then
		heal(this,store,math.min(state.heal_pool,cap))
		state.heal_pool,state.heal_started=nil,nil
	end
	local immediate=0
	for _,target in ipairs(C.corpses(store)) do
		if target~=this and target.unit and target.health and target.health.dead and not target.pending_removal and
			(target.enemy or target.soldier) and not target._allied_corpse_claimed and target.pos and
			type(target.health.hp_max)=="number" and target.health.hp_max>0 and C.dist(target.pos,this.pos)<=250 then
			target._allied_corpse_claimed=true
			local amount=target.health.hp_max*0.05
			if STACK_HEAL then
				state.heal_started=state.heal_started or store.tick_ts
				state.heal_pool=(state.heal_pool or 0)+amount
				if state.heal_pool>=cap then
					heal(this,store,cap)
					state.heal_pool,state.heal_started=nil,nil
				end
			else immediate=immediate+amount end
		end
	end
	if immediate>0 then heal(this,store,immediate) end
end

function M.automatic(this,store,targets)
	if C.ready(this,store,"punch",M.skill.cooldown) then
		local attack=this.melee.attacks[1]
		for _,target in ipairs(targets) do
			if C.alive(target) and C.dist(this.pos,target.pos)<=attack.damage_radius*2 and bit.band(target.vis.flags,F_FLYING)==0 then
				local flip=target.pos.x<this.pos.x
				this.render.sprites[1].flip_x=flip
				if C.cast(this,store,"charged_attack",attack.hit_time*1.3) then
					local pos=C.copy(this.pos)
					pos.x,pos.y=pos.x+(flip and -1 or 1)*attack.hit_offset.x,pos.y+attack.hit_offset.y
					C.area(store,this,pos,attack.damage_radius*2,M.melee_damage*2,M.melee_damage*2,DAMAGE_TRUE,nil,attack.count,true)
					C.stamp(this,store,"punch")
					punch_effect(this,store)
					local sprite=this.render.sprites[1]
					C.wait(this,store,math.max(0,sprite.ts+A:duration(sprite.prefix.."_charged_attack")-store.tick_ts))
				end
				return true
			end
		end
	end
	if C.ready(this,store,"rays",balance.fire_balls.cooldown) then
		for _,target in ipairs(targets) do
			if C.dist(this.pos,target.pos)<=M.skill.range and bit.band(target.vis.bans,F_STUN)==0 then
				C.stamp(this,store,"rays")
				rays(this,store)
				return true
			end
		end
	end
	return false
end
return M
