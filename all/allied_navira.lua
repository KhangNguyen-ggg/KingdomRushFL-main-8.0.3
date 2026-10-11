-- Playable Navira: autonomous allied skills, native visuals and hero life cycle.
local C,E,A,U,bit,balance
local M={
	name="hero_allied_navira", title="Navira", kind="navira", source="boss_navira",
	-- Preserve the exact resource path confirmed working in the basic build.
	icon="encyclopedia_creep_thumbs_0554", textures={"encyclopedia_creeps","rebborn_enemy_icons","go_stage119"}, sounds={"stage_19"},
	scaled=false,
	melee_damage=280,
	skill={label="Lốc",cooldown=25,range=450,
		description="Tự hóa lốc gây sát thương phép, tăng tốc và tránh bị chặn. Bắn tối đa 3 tia linh hồn gây choáng địch. Hấp thụ linh hồn Specter đã chết để hồi máu."}
}

local function register_ray()
	local native=E:get_template(C.native(E.entities[M.name]).fire_ball_bullet_t)
	local mod=E:get_template(native.bullet.mod)
	if not E.entities.allied_navira_soul_stun then
		local t=E:register_t("allied_navira_soul_stun","mod_stun")
		t.render=table.deepclone(mod.render)
		t.render.sprites[1].name="start"
		t.modifier.animation_phases=true
		t.modifier.duration=mod.modifier.duration
		t.modifier.vis_flags=bit.bor(F_MOD,F_STUN)
		t.modifier.use_mod_offset=true
		t.sound_events=table.deepclone(mod.sound_events)
		-- Keep mod_stun's enemy stun lifecycle, never the tower-blocking script.
	end
	if E.entities.allied_navira_soulray then return end
	local t=E:register_t("allied_navira_soulray","decal_scripted")
	t.render=table.deepclone(native.render)
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
	-- Load runtime only after the game has initialized its databases.
	C=require("allied_boss_common")
	E,A,U,bit=require("entity_db"),require("animation_db"),require("utils"),require("bit")
	balance=require("balance/balance").enemies.undying_hatred.boss_navira
	local t=C.create(M)
	local native=E:get_template(M.source)
	t.render.sprites[1].angles={walk={"idle","idle","idle"}}
	t.melee.attacks[1].damage_type=native.melee.attacks[1].damage_type
	t.melee.attacks[1].damage_min,t.melee.attacks[1].damage_max=M.melee_damage,M.melee_damage
	register_ray()
	return t
end

local function rays(this,store,count)
	local targets=U.find_enemies_in_range(store.entities,this.pos,0,M.skill.range,F_STUN,0) or {}
	local valid={}
	for _,target in ipairs(targets) do
		if target.enemy and C.alive(target) and bit.band(target.vis.bans,F_STUN)==0 then valid[#valid+1]=target end
	end
	table.sort(valid,function(a,b) return C.dist(this.pos,a.pos)<C.dist(this.pos,b.pos) end)
	local native=E:get_template(C.native(this).fire_ball_bullet_t)
	for i=1,math.min(count,#valid) do
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
	local n=C.native(this)
	if this.boss_form or this.health.hp>=this.health.hp_max or not C.ready(this,store,"heal",n.corruption_kr5.cooldown) then return end
	for _,e in pairs(store.entities) do
		if e.enemy and e.health and e.health.dead and not e.pending_removal and not e._allied_corpse_claimed and
			e.template_name and e.template_name:find("specter",1,true) and C.dist(e.pos,this.pos)<=250 then
			e._allied_corpse_claimed=true
			this.health.hp=math.min(this.health.hp_max,this.health.hp+n.corruption_kr5.hp)
			C.stamp(this,store,"heal")
			local fx=E:create_entity(n.mod_heal)
			fx.modifier.source_id,fx.modifier.target_id=this.id,this.id
			C.insert(fx)
			return
		end
	end
end

local function valid_destination(pos)
	return require("path_db"):valid_node_nearby(pos.x,pos.y,nil,NF_RALLY) and
		require("grid_db"):cell_is_only(pos.x,pos.y,bit.bor(TERRAIN_LAND,TERRAIN_ICE))
end

local function tornado(this,store,pos,phase)
	local n=C.native(this)
	local sprite=this.render.sprites[1]
	local function duration(name) return A:duration(sprite.prefix.."_"..name) end
	if not C.cast(this,store,"tornadoin",duration("tornadoin"),n.sound_transform_in) then return end
	local speed,bans,angles,bar_y=this.motion.max_speed,this.vis.bans,sprite.angles.walk,this.health_bar.offset.y
	this.motion.max_speed=speed*n.tornado_speed_mult
	this.vis.bans=bit.bor(bans,F_BLOCK,F_STUN)
	sprite.angles.walk={"tornadoloop","tornadoloop","tornadoloop"}
	this.health_bar.offset.y=115
	this.boss_form=true
	this.nav_grid.waypoints=nil
	if pos then this.nav_rally.pos,this.nav_rally.center,this.nav_rally.new=C.copy(pos),C.copy(pos),true end
	C.animate(this,"tornadoloop",store,true)
	local aura=E:get_template(n.tornado_aura_t).aura
	local last=store.tick_ts
	local completed=C.wait(this,store,n.tornado_duration,function()
		if this.nav_rally.new then
			this.nav_rally.new=false
			if valid_destination(this.nav_rally.pos) then U.set_destination(this,this.nav_rally.pos) end
		end
		if not this.motion.arrived and this.motion.dest then U.walk(this,store.tick_length) end
		if store.tick_ts-last>=aura.cycle_time then
			last=store.tick_ts
			C.area(store,this,this.pos,aura.radius,aura.damage_min,aura.damage_max,aura.damage_type,nil,nil,true)
		end
	end)
	-- Restore every temporary field even if killed or interrupted in tornado form.
	this.motion.max_speed,this.vis.bans,sprite.angles.walk,this.health_bar.offset.y=speed,bans,angles,bar_y
	this.boss_form=nil
	if completed and C.cast(this,store,"tornadoend",18/30,n.sound_transform_out) then
		rays(this,store,n.tornado_balls_count[phase] or balance.fire_balls.count)
		C.stamp(this,store,"rays")
		C.wait(this,store,math.max(0,duration("tornadoend")-18/30))
	end
	if C.alive(this) then C.animate(this,"idle",store,true) end
end

function M.automatic(this,store,targets)
	local n,s=C.native(this),C.state(this,store)
	local threshold=n.tornado_hp_trigger[s.threshold]
	if threshold and this.health.hp/this.health.hp_max<=threshold then
		local phase=s.threshold
		s.threshold=phase+1
		C.stamp(this,store,"active")
		tornado(this,store,nil,phase)
		return true
	end
	if C.ready(this,store,"active",M.skill.cooldown) then
		for _,target in ipairs(targets) do
			if C.dist(this.pos,target.pos)<=M.skill.range and bit.band(target.vis.flags,F_FLYING)==0 and valid_destination(target.pos) then
				C.stamp(this,store,"active")
				tornado(this,store,target.pos,math.min(s.threshold,#n.tornado_balls_count))
				return true
			end
		end
	end
	if C.ready(this,store,"rays",balance.fire_balls.cooldown) then
		for _,target in ipairs(targets) do
			if C.dist(this.pos,target.pos)<=M.skill.range and bit.band(target.vis.bans,F_STUN)==0 then
				C.stamp(this,store,"rays")
				rays(this,store,balance.fire_balls.count)
				return true
			end
		end
	end
	return false
end
return M
