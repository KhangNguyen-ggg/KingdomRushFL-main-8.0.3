-- Allied adaptations of FL 8.0.3 boss skills. Never execute enemy boss scripts.
local E = require("entity_db")
local A = require("animation_db")
local U = require("utils")
local SU = require("script_utils")
local V = require("klua.vector")
local bit = require("bit")
local M = {}
local function insert(e) require("simulation"):queue_insert_entity(e) end
local function remove(e) require("simulation"):queue_remove_entity(e) end
local function sound(name) if name then require("sound_db"):queue(name) end end
local function copy(p) return V.vclone(p) end
local function dist(a, b) return math.sqrt((a.x-b.x)^2+(a.y-b.y)^2) end
local function alive(e) return e and not e.pending_removal and e.health and not e.health.dead and (e.health.hp or 0) > 0 end
local function owner_alive(e)
	return alive(e) or e and e.boss_kind=="set" and e.boss_state and e.boss_state.phase==1
end
local function enemies(store, p, radius, ground)
	local out = {}
	for _, e in pairs(store.entities) do
		if e.enemy and alive(e) and (not ground or bit.band(e.vis.flags, F_FLYING) == 0) and U.is_inside_ellipse(e.pos, p, radius) then out[#out+1] = e end
	end
	table.sort(out, function(a,b) return dist(a.pos,p) < dist(b.pos,p) end)
	return out
end
local function damage(store, owner, e, lo, hi, kind)
	if not e.enemy or not alive(e) then return end
	local d = E:create_entity("damage")
	d.source_id, d.target_id = owner.id, e.id
	local factor=owner.unit and owner.unit.damage_factor or 1
	d.value, d.damage_type = math.floor(math.random(math.floor(lo),math.floor(hi or lo))*factor), kind or DAMAGE_PHYSICAL
	store.damage_queue[#store.damage_queue+1] = d
end
local function animate(e, name, store, loop)
	for i,s in ipairs(e.render.sprites) do
		if s.animated and not s.ignore_start then
			local selected=s.prefix and (A.db[s.prefix.."_"..name] and name or "idle") or s.name
			U.animation_start(e, selected, nil, store.tick_ts, loop, i)
		end
	end
end
local function state(e, store)
	if not e.boss_state then e.boss_state = {born=store.tick_ts,last={},summons={},phase=1,obelisk=0,threshold=1} end
	return e.boss_state
end
local function ready(e, store, key, cd)
	local s = state(e,store)
	return store.tick_ts-(s.last[key] or s.born) >= cd
end
local function stamp(e,store,key) state(e,store).last[key]=store.tick_ts end

-- Visual-only effects get their own lifetime: no spawners or enemy callbacks.
local function visual(source, pos, store, duration, animation)
	local native = E.entities[source]
	if not native or not native.render then return end
	local name = "allied_visual_"..source
	if not E.entities[name] then
		local t = E:register_t(name,"decal_scripted")
		t.render = table.deepclone(native.render)
		t.main_script.insert = nil
		t.main_script.update = function(this,st)
			local start=st.tick_ts
			while st.tick_ts-start < this.life do coroutine.yield() end
			remove(this)
		end
	end
	local e = E:create_entity(name)
	e.pos, e.life = copy(pos), duration or 1
	if animation then animate(e,animation,store,true) end
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts; s.hidden=false end
	insert(e)
	return e
end
local function stun(store, owner, target, duration)
	if not alive(target) or not target.enemy or bit.band(target.vis.bans,F_STUN) ~= 0 then return end
	local m = E:create_entity("mod_stun")
	m.modifier.source_id, m.modifier.target_id, m.modifier.duration = owner.id,target.id,duration
	insert(m)
end
local function area(store,owner,pos,radius,lo,hi,kind,duration,count,ground)
	for i,e in ipairs(enemies(store,pos,radius,ground)) do
		if count and i>count then break end
		if bit.band(e.vis.bans,F_AREA)==0 then
			if lo and lo>0 then damage(store,owner,e,lo,hi,kind) end
			if duration then stun(store,owner,e,duration) end
		end
	end
end

-- Summons are soldiers, not enemy templates with an allegiance flag changed.
local function summon(owner, source, pos, store, lifetime)
	local native = assert(E.entities[source], "Missing allied summon: "..source)
	local name = "allied_summon_"..source
	if not E.entities[name] then
		local t = E:register_t(name,"soldier")
		E:add_comps(t,"melee","nav_rally","nav_grid")
		t.render, t.health_bar = table.deepclone(native.render),table.deepclone(native.health_bar)
		for _,s in ipairs(t.render.sprites) do
			if s.animated and not s.ignore_start then
				local prefix = s.prefix
				s.name="idle"
				s.angles={walk={A.db[prefix.."_walk"] and "walk" or "walkingRightLeft", A.db[prefix.."_walkUp"] and "walkUp" or "walkingUp", A.db[prefix.."_walkDown"] and "walkDown" or "walkingDown"}}
				for i,a in ipairs(s.angles.walk) do if not A.db[prefix.."_"..a] then s.angles.walk[i]=s.angles.walk[1] end end
			end
		end
		t.health.hp_max = type(native.health.hp_max)=="table" and native.health.hp_max[1] or native.health.hp_max
		t.health.hp, t.health.armor, t.health.magic_armor = t.health.hp_max,native.health.armor or 0,native.health.magic_armor or 0
		t.motion.max_speed = 60
		t.unit.size = native.unit.size
		t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=copy(native.unit.hit_offset),copy(native.unit.mod_offset),copy(native.unit.marker_offset)
		t.unit.death_animation = native.unit.death_animation or "death"
		t.ui.click_rect=table.deepclone(native.ui.click_rect)
		t.info=table.deepclone(native.info);t.info.fn=require("scripts").hero_basic.get_info_melee
		t.soldier.melee_slot_offset=V.v(10,0)
		t.melee.range=90
		local a = E:clone_c("area_attack")
		local n = native.melee.attacks[1]
		for _,key in ipairs({"damage_min","damage_max","damage_type","cooldown","hit_time","animation","hit_fx"}) do if n[key]~=nil then a[key]=n[key] end end
		a.hit_offset=V.v(10,0);a.count=n.count or n.max_count or 1;a.damage_radius=n.damage_radius or 25
		a.vis_flags,a.vis_bans,a.damage_bans,a.damage_flags=F_BLOCK,bit.bor(F_FLYING,F_CLIFF),F_FLYING,F_AREA
		t.melee.attacks[1]=a
		t.main_script.insert=nil
		t.main_script.update=function(this,st)
			while true do
				if this.health.dead then
					if this.death_summon and owner_alive(this.boss_owner) then summon(this.boss_owner,this.death_summon,this.pos,st,math.max(1,this.expires-st.tick_ts)) end
					SU.y_soldier_death(st,this);remove(this);return
				end
				if st.tick_ts>=this.expires or not owner_alive(this.boss_owner) then
					U.unblock_target(st,this);remove(this);return
				end
				if this.summon_source=="enemy_primordial" then M.raise(this,st,"enemy_fallen",200,0.5,15) end
				if this.unit.is_stunned then SU.soldier_idle(st,this)
				elseif this.nav_rally.new then SU.y_soldier_new_rally(st,this)
				else
					local interrupted,result=SU.y_soldier_melee_block_and_attacks(st,this)
					if not interrupted and result==A_NO_TARGET and not SU.soldier_go_back_step(st,this) then SU.soldier_idle(st,this) end
				end
				coroutine.yield()
			end
		end
	end
	local e = E:create_entity(name)
	e.pos, e.boss_owner, e.summon_source, e.expires = copy(pos),owner,source,store.tick_ts+(lifetime or 60)
	e.death_summon = native.death_spawns and native.death_spawns.name
	e.nav_rally.pos,e.nav_rally.center,e.nav_rally.new=copy(pos),copy(pos),true
	e.health.hp=e.health.hp_max
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts end
	local s=state(owner,store)
	for i=#s.summons,1,-1 do
		local old=s.summons[i]
		if not alive(old) or old._replaced or store.tick_ts>=old.expires then table.remove(s.summons,i) end
	end
	s.summons[#s.summons+1]=e
	insert(e)
	return e
end
local function living_summons(owner,store)
	local out={}
	for _,e in ipairs(state(owner,store).summons) do
		if alive(e) and store.tick_ts<e.expires and not e._replaced then out[#out+1]=e end
	end
	state(owner,store).summons=out
	return out
end
local function group(owner,source,pos,count,store,life)
	for i=1,count do
		local angle=2*math.pi*(i-1)/count
		summon(owner,source,V.v(pos.x+18*math.cos(angle),pos.y+12*math.sin(angle)),store,life)
	end
end
function M.raise(owner,store,source,radius,cd,cap)
	if not ready(owner,store,"raise",cd) then return end
	stamp(owner,store,"raise")
	if #living_summons(owner,store)>=cap then return end
	for _,e in pairs(store.entities) do
		if e.enemy and e.health and e.health.dead and not e._allied_corpse_claimed and e.unit and bit.band(e.vis.flags,bit.bor(F_FLYING,F_BOSS,F_MINIBOSS))==0 and U.is_inside_ellipse(e.pos,owner.pos,radius) then
			e._allied_corpse_claimed=true
			summon(owner,source,e.pos,store,60)
			return
		end
	end
end

-- Same native projectile graphics; target/damage lifecycle belongs to allies.
local function projectile(owner, source, target, pos, store, spec)
	local native=assert(E.entities[source],"Missing allied projectile: "..source)
	local name="allied_projectile_"..source
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		t.render=table.deepclone(native.render)
		t.main_script.update=function(this,st)
			local start=st.tick_ts
			local from=copy(this.pos)
			while st.tick_ts-start<this.flight do
				if alive(this.target) then this.destination=copy(this.target.pos) end
				local f=math.min(1,(st.tick_ts-start)/this.flight)
				if this.spec.beam then
					local sprite=this.render.sprites[1]
					local dx,dy=this.destination.x-from.x,this.destination.y-from.y
					sprite.r=(math.atan2 or math.atan)(dy,dx)
					sprite.scale=V.v(dist(from,this.destination)/186,1)
				else
					this.pos.x=from.x+(this.destination.x-from.x)*f
					this.pos.y=from.y+(this.destination.y-from.y)*f+math.sin(f*math.pi)*this.arc
				end
				coroutine.yield()
			end
			if this.spec.summon then group(this.boss_owner,this.spec.summon,this.destination,this.spec.count,st,45)
			elseif this.spec.radius then area(st,this.boss_owner,this.destination,this.spec.radius,this.spec.lo,this.spec.hi,this.spec.kind,this.spec.stun,nil,false)
			elseif alive(this.target) then
				if (this.spec.lo or 0)>0 then damage(st,this.boss_owner,this.target,this.spec.lo,this.spec.hi,this.spec.kind) end
				if this.spec.stun then stun(st,this.boss_owner,this.target,this.spec.stun) end
			end
			if this.spec.fx then visual(this.spec.fx,this.destination,st,1) end
			if this.spec.decal then visual(this.spec.decal,this.destination,st,2) end
			sound(this.hit_sound)
			remove(this)
		end
	end
	local e=E:create_entity(name)
	e.pos=V.v(owner.pos.x,owner.pos.y+(source=="bomb_juggernaut" and 82 or 40))
	e.target,e.destination,e.boss_owner,e.spec=target,copy(pos),owner,table.deepclone(spec)
	e.spec.fx=e.spec.fx or native.bullet.hit_fx
	e.spec.decal=native.bullet.decal_fx
	e.hit_sound=native.sound_events and native.sound_events.hit
	sound(native.sound_events and native.sound_events.insert)
	e.flight,e.arc=spec.flight or math.max(0.2,dist(e.pos,pos)/350),spec.arc or 0
	for _,s in ipairs(e.render.sprites) do
		s.ts=store.tick_ts
		if s.animated and s.prefix then
			if A.db[s.prefix.."_flying"] then s.name="flying"
			elseif A.db[s.prefix.."_run"] then s.name="run" end
		end
	end
	insert(e)
	return e
end

-- Enemy spell sealing stacks correctly and restores original flags on removal.
local function seal(store,owner,target,duration)
	if bit.band(target.vis.bans,F_MOD)~=0 then return end
	local name="allied_boss_spell_seal"
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		t.render.sprites[1].hidden=true
		t.main_script.insert=function(this,st)
			local e=st.entities[this.target_id]
			if not e or not e.enemy or not alive(e) then return false end
			if not e._allied_seal then e._allied_seal={count=0,magic=e.enemy.can_do_magic,accept=e.enemy.can_accept_magic} end
			e._allied_seal.count=e._allied_seal.count+1
			e.enemy.can_do_magic,e.enemy.can_accept_magic=false,false
			this.target=e
			return true
		end
		t.main_script.update=function(this,st)
			local start=st.tick_ts
			while alive(this.target) and st.tick_ts-start<this.life do coroutine.yield() end
			remove(this)
		end
		t.main_script.remove=function(this)
			local e=this.target
			if e and e._allied_seal then
				local s=e._allied_seal;s.count=s.count-1
				if s.count<=0 then e.enemy.can_do_magic,e.enemy.can_accept_magic=s.magic,s.accept;e._allied_seal=nil end
			end
			return true
		end
	end
	local e=E:create_entity(name);e.target_id,e.life=target.id,duration;insert(e)
	stun(store,owner,target,duration)
end

local function passive(this,store)
	local id=this.boss_kind
	local s=state(this,store)
	if id=="blackburn" then M.raise(this,store,"enemy_skeleton_big",106.383,0.5,15)
	elseif id=="set" then
		if ready(this,store,"fire",1) then
			stamp(this,store,"fire")
			area(store,this,this.pos,128,s.phase==2 and 24 or 9,nil,DAMAGE_TRUE,nil,nil,true)
		end
		if s.phase==2 then M.raise(this,store,"enemy_fallen",200,0.5,15) end
	elseif id=="navira" and this.health.hp<this.health.hp_max and ready(this,store,"heal",this.boss_native.corruption_kr5.cooldown) then
		for _,e in pairs(store.entities) do
			if e.enemy and e.health and e.health.dead and not e._allied_corpse_claimed and e.template_name and e.template_name:find("specter",1,true) and dist(e.pos,this.pos)<=250 then
				e._allied_corpse_claimed=true
				this.health.hp=math.min(this.health.hp_max,this.health.hp+this.boss_native.corruption_kr5.hp)
				stamp(this,store,"heal");break
			end
		end
	end
end
local function wait(this,store,duration,step)
	local start=store.tick_ts
	while store.tick_ts-start<duration do
		if not alive(this) or this.unit.is_stunned then return false end
		passive(this,store)
		if step then step() end
		coroutine.yield()
	end
	return alive(this) and not this.unit.is_stunned
end
local function cast(this,store,animation,time,sound_name)
	U.unblock_target(store,this)
	sound(sound_name)
	animate(this,animation,store,false)
	return wait(this,store,time or 0.5)
end
local function land(this,pos)
	this.pos=copy(pos)
	this.nav_rally.pos,this.nav_rally.center,this.nav_rally.new=copy(pos),copy(pos),false
	this.nav_grid.waypoints=nil
	U.set_destination(this,this.pos)
	this.motion.arrived=true
	this.motion.speed.x,this.motion.speed.y=0,0
end
local function move_form(this,store,duration,speed,animation,step,shield)
	local old_speed,old_bans,old_ignore=this.motion.max_speed,this.vis.bans,this.health.ignore_damage
	this.motion.max_speed=old_speed*speed
	this.vis.bans=bit.bor(old_bans,F_BLOCK,F_STUN)
	if shield~=false then this.health.ignore_damage=true end
	this.boss_form=true
	this.nav_grid.waypoints=nil
	animate(this,animation,store,true)
	local result=wait(this,store,duration,function()
		if this.nav_rally.new then
			this.nav_rally.new=false;U.set_destination(this,this.nav_rally.pos)
		end
		if not this.motion.arrived and this.motion.dest then U.walk(this,store.tick_length) end
		if step then step() end
	end)
	this.motion.max_speed,this.vis.bans,this.health.ignore_damage=old_speed,old_bans,old_ignore
	this.boss_form=nil
	return result
end
local function rays(this,store,count)
	local targets=enemies(store,this.pos,450,false)
	for i=1,math.min(count,#targets) do
		projectile(this,this.boss_native.fire_ball_bullet_t,targets[i],targets[i].pos,store,{lo=0,hi=0,stun=5,flight=0.8,beam=true})
	end
end
local function navira_tornado(this,store,pos)
	if not cast(this,store,"tornadoin",0.5,this.boss_native.sound_transform_in) then return end
	if pos then this.nav_rally.pos=copy(pos);this.nav_rally.center=copy(pos);this.nav_rally.new=true end
	local last=store.tick_ts
	local completed=move_form(this,store,this.boss_native.tornado_duration,this.boss_native.tornado_speed_mult,"tornadoloop",function()
		if store.tick_ts-last>=0.25 then last=store.tick_ts;area(store,this,this.pos,40,15,15,DAMAGE_MAGICAL,nil,nil,false) end
	end,false)
	if completed and cast(this,store,"tornadoend",0.5,this.boss_native.sound_transform_out) then rays(this,store,this.boss_native.tornado_balls_count[math.min(state(this,store).threshold,#this.boss_native.tornado_balls_count)] or 3) end
end
local function fog(this,pos,store)
	local name="allied_spectro_fog"
	local function leave(e,target)
		if not target._allied_fogs or not target._allied_fogs[e.id] then return end
		target._allied_fogs[e.id]=nil
		if next(target._allied_fogs)==nil then
			target.unit.damage_factor=target.unit.damage_factor/0.7
			target._allied_fogs=nil
		end
	end
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		local native=assert(E.entities.pirates_fog_2,"Spectro fog missing")
		t.render=table.deepclone(native.render)
		t.main_script.update=function(e,st)
			local start=st.tick_ts
			e.touched={}
			while alive(e.boss_owner) and st.tick_ts-start<18 do
				for _,target in pairs(st.entities) do
					if target.enemy and alive(target) and target.unit and U.is_inside_ellipse(target.pos,e.pos,e.allied_fog_radius) then
						e.touched[target.id]=target
						if not target._allied_fogs then target._allied_fogs={};target.unit.damage_factor=target.unit.damage_factor*0.7 end
						target._allied_fogs[e.id]=true
					end
				end
				for id,target in pairs(e.touched) do
					if not alive(target) or not U.is_inside_ellipse(target.pos,e.pos,e.allied_fog_radius) then leave(e,target);e.touched[id]=nil end
				end
				coroutine.yield()
			end
			remove(e)
		end
		t.main_script.remove=function(e)
			for _,target in pairs(e.touched or {}) do leave(e,target) end
			return true
		end
	end
	local e=E:create_entity(name);e.pos,e.boss_owner,e.allied_fog_radius=copy(pos),this,70
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts;s.hidden=false end
	insert(e)
end
local function obelisk(this,pos,store)
	local s=state(this,store);s.obelisk=s.obelisk+1
	local native=this.boss_native.timed_attacks.list[2]
	local loops=native.loops[(s.obelisk-1)%#native.loops+1]
	local name="allied_set_obelisk"
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		t.render=table.deepclone(assert(E.entities.set_obelisk).render)
		t.main_script.update=function(e,st)
			animate(e,"start",st,false)
			local start=st.tick_ts;local next_spawn=start
			while alive(e.boss_owner) and st.tick_ts-start<e.life do
				if st.tick_ts>=next_spawn then
					local source=e.phase==2 and next_spawn==start and "enemy_immortal" or "enemy_fallen"
					summon(e.boss_owner,source,e.pos,st,60);next_spawn=next_spawn+1
				end
				if st.tick_ts-start>=0.5 and e.render.sprites[1].name~="loop" then animate(e,"loop",st,true) end
				coroutine.yield()
			end
			animate(e,"end",st,false)
			local finish=st.tick_ts
			while st.tick_ts-finish<0.5 do coroutine.yield() end
			remove(e)
		end
	end
	for i=1,loops do
		local e=E:create_entity(name)
		e.pos=V.v(pos.x+(i-(loops+1)/2)*25,pos.y)
		e.boss_owner,e.life,e.phase=this,native.duration,s.phase
		for _,sp in ipairs(e.render.sprites) do sp.ts=store.tick_ts end
		insert(e)
	end
end

-- Public metadata is shared by the map and skill buttons.
M.skills = {
	blackburn={label="Đạp",cooldown=5,range=284,description="Đạp đất gây choáng. Tự gọi Skeleton Knight từ xác địch gần đó (tối đa 15 lính)."},
	juggernaut={label="Golem",cooldown=4,range=700,description="Bắn tên lửa tự động. Ném bom gọi 7 Golem Head tại vị trí chọn."},
	set={label="Trụ",cooldown=10,range=450,description="Dựng trụ gọi Fallen; cường hóa Fallen thành Immortal rồi Primordial. Hào quang lửa, hồi sinh và hình thái thứ hai."},
	navira={label="Lốc",cooldown=25,range=450,description="Hóa lốc theo vị trí chọn hoặc khi mất máu. Bắn 3 tia linh hồn gây choáng; hấp thụ linh hồn Specter để hồi máu."},
	spectro={label="Sương",cooldown=18,range=500,description="Pháo linh hồn bắn loạt 7 phát. Khóa phép địch. Sương giảm 30% sát thương địch và giúp Spectro bất tử trong vùng sương."},
	mirage={label="Ảnh",cooldown=8,range=350,description="Phi dao từ xa, tạo bản sao Nomad. Dịch chuyển đến vị trí chọn và để lại phân thân."},
	alric={label="Cát",cooldown=16,range=350,description="Đòn Flurry diện rộng; tự hóa lốc cát tăng tốc, tránh sát thương. Gọi 3 Sand Warrior tại vị trí chọn."},
	malik={label="Nhảy",cooldown=12,range=600,description="Ném búa sét từ xa. Đập đất gây choáng thay cho phá tháp. Nhảy tới vị trí chọn và gây sát thương khi đáp đất."}
}
function M.kind(name) return name and name:match("^hero_allied_(.+)$") end
function M.can_fire(hero,x,y,store)
	local skill=M.skills[M.kind(hero and hero.template_name)]
	if not skill then return true end
	if not alive(hero) or hero.unit.is_stunned or hero.boss_command or hero.boss_form or hero.boss_casting then return false end
	if dist(hero.pos,V.v(x,y))>skill.range then return false end
	if hero.boss_kind=="blackburn" then return true end
	return require("path_db"):valid_node_nearby(x,y,nil,NF_RALLY) and require("grid_db"):cell_is_only(x,y,bit.bor(TERRAIN_LAND,TERRAIN_ICE))
end
local function active(this,store,pos)
	local id=this.boss_kind;local native=this.boss_native
	if id=="blackburn" then
		local a=native.timed_attacks.list[1]
		-- Stomp is centered on Blackburn, like the enemy skill.
		if cast(this,store,a.animation,a.hit_time,a.sound) then
			area(store,this,this.pos,a.damage_radius,a.damage_min,a.damage_max,a.damage_type,4,nil,true)
			visual(a.fx,this.pos,store,1);visual(a.hit_decal,this.pos,store,2)
		end
	elseif id=="juggernaut" then
		local a=native.timed_attacks.list[2]
		if cast(this,store,a.animation,a.shoot_time) then projectile(this,a.bullet,nil,pos,store,{summon="enemy_golem_head",count=7,arc=100,flight=1.5}) end
	elseif id=="set" then obelisk(this,pos,store)
	elseif id=="navira" then navira_tornado(this,store,pos)
	elseif id=="spectro" then if cast(this,store,"ability",0.3333) then fog(this,pos,store) end
	elseif id=="mirage" then
		local a=native.branch.shadow_jump
		if cast(this,store,a.animation_out,0.3,a.sound) then
			summon(this,a.leave_copy,this.pos,store,20)
			land(this,pos)
			cast(this,store,a.animation_in,0.3)
		end
	elseif id=="alric" then
		local a=native.branch.spawn
		if cast(this,store,a.animation,a.cast_time) then group(this,a.template,pos,a.count,store,45) end
	elseif id=="malik" then
		local a=native.branch.rocket_jump
		if cast(this,store,a.animation_out,0.4,a.sound) then
			local from=copy(this.pos)
			this.boss_jump_ts=store.tick_ts
			move_form(this,store,0.6,1,a.animation,function()
				local f=math.min(1,(store.tick_ts-this.boss_jump_ts)/0.6)
				this.pos.x=from.x+(pos.x-from.x)*f;this.pos.y=from.y+(pos.y-from.y)*f+math.sin(math.pi*f)*80
			end)
			if alive(this) then
				land(this,pos)
				if cast(this,store,a.animation_in,0.3,a.hit_sound) then area(store,this,pos,a.radius,a.damage_min,a.damage_max,DAMAGE_PHYSICAL,nil,nil,true) end
			end
		end
	end
end

local function automatic(this,store)
	local id,n,s=this.boss_kind,this.boss_native,state(this,store)
	local targets=enemies(store,this.pos,500,false)
	if id=="navira" then
		local threshold=n.tornado_hp_trigger[s.threshold]
		if threshold and this.health.hp/this.health.hp_max<=threshold then
			s.threshold=s.threshold+1;navira_tornado(this,store);return true
		elseif #targets>0 and ready(this,store,"rays",25) then stamp(this,store,"rays");rays(this,store,3);return true end
	elseif id=="juggernaut" and #targets>0 and ready(this,store,"missile",n.timed_attacks.list[1].cooldown) then
		local target
		for _,e in ipairs(targets) do if dist(e.pos,this.pos)>=n.timed_attacks.list[1].min_range then target=e;break end end
		if target then
			local a=n.timed_attacks.list[1];stamp(this,store,"missile")
			if cast(this,store,a.animation,a.shoot_time) then
				local b=E.entities[a.bullet].bullet
				projectile(this,a.bullet,target,target.pos,store,{lo=b.damage_min,hi=b.damage_max,kind=b.damage_type,radius=b.damage_radius,arc=40,fx=b.hit_fx})
			end
			return true
		end
	elseif id=="set" and ready(this,store,"channel",s.phase==2 and 40 or 30) then
		local units=living_summons(this,store);local candidates={}
		for _,e in ipairs(units) do if e.summon_source=="enemy_fallen" or s.phase==2 and e.summon_source=="enemy_immortal" then candidates[#candidates+1]=e end end
		if #candidates>0 then
			stamp(this,store,"channel");local a=n.timed_attacks.list[1]
			if cast(this,store,a.animations[1],a.cast_time,a.sound) then
				animate(this,a.animations[2],store,true)
				for _,e in ipairs(candidates) do e.unit.damage_factor=e.unit.damage_factor+1 end
				local completed=wait(this,store,a.cast_time_2)
				for _,e in ipairs(candidates) do e.unit.damage_factor=e.unit.damage_factor-1 end
				if completed then
					for _,e in ipairs(candidates) do
						if alive(e) then
							local next_source=e.summon_source=="enemy_fallen" and "enemy_immortal" or "enemy_primordial"
							local upgraded=summon(this,next_source,e.pos,store,math.max(1,e.expires-store.tick_ts))
							upgraded.health.hp=math.ceil(upgraded.health.hp_max*e.health.hp/e.health.hp_max)
							e._replaced=true;U.unblock_target(store,e);remove(e)
						end
					end
					cast(this,store,a.animations[3],0.5,a.sound2)
				end
			end
			return true
		end
	elseif id=="spectro" and #targets>0 then
		local seal_skill=n.pirate.disable_power
		if ready(this,store,"seal",seal_skill.cooldown) then
			stamp(this,store,"seal")
			if cast(this,store,seal_skill.animation,seal_skill.cast_time,"krv_sfx_ghost_captain_power_block") then seal(store,this,targets[1],math.random(seal_skill.duration_min,seal_skill.duration_max)) end
			return true
		end
		local a=n.pirate.ghost_barrage
		if ready(this,store,"barrage",a.cooldown) then
			local rounds=enemies(store,this.pos,a.max_range,false)
			if #rounds>0 then
				stamp(this,store,"barrage");animate(this,a.animation,store,false)
				for i=1,math.min(#rounds,a.max_rounds) do
					local pos=copy(rounds[i].pos)
					for shot=1,a.shots do
						area(store,this,pos,a.radius,a.damage_min,a.damage_max,DAMAGE_MAGICAL,nil,nil,false)
						visual("fx_enemy_ghost_barrage",pos,store,0.6)
						if not wait(this,store,0.08) then return true end
					end
				end
				return true
			end
		end
	elseif id=="mirage" and #targets>0 and ready(this,store,"copies",n.branch.clone.cooldown) then
		local a=n.branch.clone;stamp(this,store,"copies")
		if cast(this,store,a.animation,a.cast_time,a.sound) then group(this,a.template,this.pos,a.max_targets,store,30) end
		return true
	elseif id=="alric" and #targets>0 then
		local a=n.branch.buried
		if ready(this,store,"buried",a.cooldown) then
			stamp(this,store,"buried")
			if cast(this,store,a.animation_in,0.3,a.sound) then
				this.nav_rally.pos=copy(targets[1].pos);this.nav_rally.new=true
				if move_form(this,store,a.duration,a.factor,a.animation) then cast(this,store,a.animation_out,0.3) end
			end
			return true
		end
		a=n.melee.attacks[1].area_attack
		if #enemies(store,this.pos,a.radius,true)>0 and ready(this,store,"flurry",a.cooldown) then
			stamp(this,store,"flurry")
			if cast(this,store,a.animation,a.hit_time,a.sound) then area(store,this,this.pos,a.radius,a.damage_min,a.damage_max,DAMAGE_PHYSICAL,nil,a.max_count,true) end
			return true
		end
	elseif id=="malik" and #targets>0 and ready(this,store,"smash",n.branch.tower_destroy.cooldown) then
		local a=n.branch.tower_destroy
		if #enemies(store,this.pos,a.range,true)>0 then
			stamp(this,store,"smash")
			if cast(this,store,a.animation,a.cast_time,a.sound) then area(store,this,this.pos,a.range,274,328,DAMAGE_MAGICAL,3,nil,true) end
			return true
		end
	end
	-- Hammerhold ranged attacks retain their native stats and projectiles.
	local ranged=n.branch and n.branch.ranged
	if ranged and ready(this,store,"ranged",ranged.cooldown) then
		for _,e in ipairs(targets) do
			local d=dist(this.pos,e.pos)
			if d>=ranged.min_range and d<=ranged.max_range then
				stamp(this,store,"ranged")
				if cast(this,store,ranged.animation,ranged.hit_time,ranged.sound) then projectile(this,ranged.projectile,e,e.pos,store,{lo=ranged.damage_min,hi=ranged.damage_max,kind=ranged.damage_type,flight=ranged.flight_time}) end
				return true
			end
		end
	end
	return false
end

function M.decorate(t,native,def)
	local kind=M.kind(def.name);local skill=assert(M.skills[kind])
	-- Special animations are copied as aliases; enemy animation entries stay intact.
	local aliases={}
	for i,sp in ipairs(native.render.sprites) do
		local dst=t.render.sprites[i]
		if sp.animated and dst and sp.prefix and dst.prefix then
			local prefix=sp.prefix.."_"
			for key,a in pairs(A.db) do if key:sub(1,#prefix)==prefix then aliases[dst.prefix.."_"..key:sub(#prefix+1)]=a end end
		end
	end
	for key,a in pairs(aliases) do if not A.db[key] then A.db[key]=a end end
	if t.boss_kind then return t end
	t.boss_kind,t.boss_native=kind,table.deepclone(native)
	t.hero.skills.ultimate={level=1,controller_name="controller_"..def.name.."_ultimate",cooldown=skill.cooldown}
	local controller=E:register_t(t.hero.skills.ultimate.controller_name,"decal_scripted")
	controller.render.sprites[1].hidden=true
	controller.cooldown=skill.cooldown
	controller.main_script.insert=function(this,store)
		local owner=this.owner
		if owner and M.can_fire(owner,this.pos.x,this.pos.y,store) then
			owner.boss_command=copy(this.pos)
			-- The native rally coroutine exits when a new rally request arrives.
			-- Keep its destination so non-movement skills resume the previous order.
			if not owner.motion.arrived then owner.nav_rally.new=true end
		end
		return false
	end
	controller.main_script.update=nil
			if kind=="spectro" then
		t.health.on_damage=function(this,store)
			for _,e in pairs(store.entities) do
				local native_fog=e.template_name and e.template_name:match("^pirates_fog") and (e.active or e.from_skill)
				if not e.pending_removal and (e.allied_fog_radius or native_fog) and U.is_inside_ellipse(this.pos,e.pos,e.allied_fog_radius or e.radius or 70) then return false end
			end
			return true
		end
	end
	t.main_script.update=function(this,store)
		while true do
			local s=state(this,store)
			if this.health.dead then
				this.boss_command=nil
				if kind=="set" and s.phase==1 then
					animate(this,"death",store,false)
					local start=store.tick_ts
					while store.tick_ts-start<3 do coroutine.yield() end
					s.phase=2;this.health.dead=false;this.health.hp=this.health.hp_max
					this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=160,240
					cast(this,store,"raise",1)
				else
					SU.y_hero_death_and_respawn(store,this)
					this.boss_state=nil
					if kind=="set" then this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=100,150 end
				end
			elseif this.unit.is_stunned then SU.soldier_idle(store,this)
			else
				passive(this,store)
				if this.boss_command then
					local pos=this.boss_command;this.boss_command=nil;this.boss_casting=true
					this.boss_jump_ts=store.tick_ts+0.4
					active(this,store,pos);this.boss_casting=nil
				elseif this.nav_rally.new then SU.y_hero_new_rally(store,this)
				else
					this.boss_casting=true
					local used=automatic(this,store)
					this.boss_casting=nil
					if not used then
						if kind=="spectro" then SU.soldier_idle(store,this);SU.soldier_regen(store,this)
						else
							local interrupted,result=SU.y_soldier_melee_block_and_attacks(store,this)
							if not interrupted and result==A_NO_TARGET and not SU.soldier_go_back_step(store,this) then SU.soldier_idle(store,this);SU.soldier_regen(store,this) end
						end
					end
				end
			end
			this.hero.xp_queued=0
			coroutine.yield()
		end
	end
	return t
end
return M
