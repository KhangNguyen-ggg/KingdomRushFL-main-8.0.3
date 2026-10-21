-- Playable Set: configuration, render binding, skills and two life phases.
local C,E,U,V
local A,I
local state,alive,copy,animate,summon,insert,remove
local M={name = "hero_allied_set", title = "Set", source = "enemy_set", icon = "encyclopedia_creep_thumbs_0265", textures = {"go_enemy_set", "go_enemies_hammerhold", "go_enemies_desert", "go_stages_hammerhold", "go_stage89_rebborn", "go_allied_set_visuals"}, sounds = {"HammerholdEnemySounds"}}
M.kind="set"
M.skill={label="Trụ",cooldown=10,range=450,description="Trụ gọi Fallen mỗi 10 giây. Gồng 10 giây tăng gấp đôi sát thương lính, sau đó nâng Fallen thành Immortal; hồi 30 giây. Lửa quanh Set: bán kính 128, gây 9 sát thương chuẩn/giây. Chết lần đầu hồi đầy máu sang phase 2: đánh 160–240 thay cho 100–150, lửa 24/giây, hồi xác trong tầm 200 (tối đa 15 lính); trụ gọi thêm Immortal, gồng nâng được Immortal thành Primordial, hồi 40 giây. Primordial cũng hồi xác cho đội Set."}
local function stop_channel(this)
	if this._set_channel_sound then
		require("sound_db"):stop(this._set_channel_sound)
		this._set_channel_sound=nil
	end
end
function M.remove(this)
	stop_channel(this)
	return true
end
local function duration(this,name)
	local sprite=this.render.sprites[1]
	-- Set plays at 15 FPS; animation_db durations otherwise assume the global 30 FPS.
	return (A:duration(sprite.prefix.."_"..name) or 0)*A.fps/(sprite.fps or A.fps)
end
local function register_fire_visual()
	if E.entities.allied_set_fire_visual then return end
	local t=E:register_t("allied_set_fire_visual","decal_scripted")
	t.render=table.deepclone(E:get_template("aura_set").render)
	t.render.sprites[1].name="allied_set_ground_aura"
	t.main_script.insert=function(e,store)
		local owner=store.entities[e.owner_id]
		if owner then owner._set_fire_pending=nil end
		return alive(owner)
	end
	t.main_script.update=function(e,store)
		local owner=store.entities[e.owner_id]
		while alive(owner) do
			e.pos=owner.pos
			coroutine.yield()
			owner=store.entities[e.owner_id]
		end
		if owner and owner._set_fire_visual==e.id then owner._set_fire_visual=nil end
		remove(e)
	end
end
function M.register()
	C=require("allied_boss_common");E=require("entity_db");U=require("utils");V=require("klua.vector")
	A=require("animation_db");I=require("klove.image_db")
	state,alive,copy,animate,summon,insert,remove=C.state,C.alive,C.copy,C.animate,C.summon,C.insert,C.remove
	local t=C.create(M)
	register_fire_visual()
	t.main_script.remove=M.remove
	return t
end
local function normalized(name) return name:lower():gsub("[^%w]", "") end

function M.prepare(template)
	local sprite = template.render.sprites[1]
	local prefix = sprite.prefix .. "_"
	local available
	local function resolve(animation)
		local first = animation.frames and animation.frames[1] or animation.from or 1
		if I:s(string.format("%s_%04i", animation.prefix, first), true) then return animation end
		if not available then
			available = {}
			for name in pairs(I.db_atlas or {}) do
				local frame_prefix, frame = name:match("^(.-)_(%d+)$")
				if frame_prefix then
					local key = normalized(frame_prefix)
					if key:sub(1, 3) == "set" then
						local entry = available[key]
						if not entry then entry = {prefix=frame_prefix, frames={}}; available[key]=entry end
						entry.frames[tonumber(frame)] = true
					end
				end
			end
		end
		local found = available[normalized(animation.prefix)]
		if not found then return nil end
		local remapped = {}
		for k,v in pairs(animation) do remapped[k]=v end
		remapped.prefix = found.prefix
		-- Keep the original frame order/timing; every requested frame must exist.
		local frames = animation.frames
		if not frames then
			frames = {}
			for _,frame in ipairs(animation.pre or {}) do frames[#frames+1]=frame end
			if animation.from and animation.to then
				for frame=animation.from,animation.to,animation.from>animation.to and -1 or 1 do frames[#frames+1]=frame end
			end
			for _,frame in ipairs(animation.post or {}) do frames[#frames+1]=frame end
		end
		for _,frame in ipairs(frames) do if not found.frames[frame] then return nil end end
		remapped.frames = frames
		return remapped
	end
	for key,animation in pairs(A.db) do
		if key:sub(1,#prefix)==prefix and type(animation)=="table" and animation.prefix then
			local resolved=resolve(animation)
			if resolved then A.db[key]=resolved end
		end
	end
	A.db[prefix.."respawn"]=A.db[prefix.."raise"]
	sprite.hidden, sprite.alpha = false, 255
	local idle = A.db[prefix.."idle"]
	local frame = idle and string.format("%s_%04i",idle.prefix,idle.frames and idle.frames[1] or idle.from or 1)
	if not frame or not I:s(frame,true) then
		-- Record missing assets rather than replacing Set with an unrelated hero.
		local names={}
		for name in pairs(I.db_atlas or {}) do if normalized(name):sub(1,3)=="set" then names[#names+1]=name end end
		table.sort(names)
		local lines={"Set idle frame missing: "..tostring(frame), "Loaded Set frames:",table.concat(names,"\n")}
		pcall(function()
			local file=io.open("KRFL_Set_Render.txt","w")
			if file then file:write(table.concat(lines,"\n"));file:close() end
		end)
	end
end
function M.active(this,store,pos)
	if not C.cast(this,store,"skill_start",duration(this,"skill_start")) then return end
	animate(this,"skill",store,true)
	local s=state(this,store);s.obelisk=s.obelisk+1
	local native=C.native(this).timed_attacks.list[2]
	local loops=native.loops[(s.obelisk-1)%#native.loops+1]
	local name="allied_set_obelisk"
	if not E.entities[name] then
		local t=E:register_t(name,"decal_scripted")
		E:add_comps(t,"tween")
		t.render=table.deepclone(assert(E.entities.set_obelisk).render)
		t.tween=table.deepclone(E.entities.set_obelisk.tween)
		t.main_script.update=function(e,st)
			e.tween.ts=st.tick_ts
			U.animation_start(e,"start",nil,st.tick_ts,false,1)
			U.animation_start(e,"fx_xerxes_obelisk",nil,st.tick_ts,true,3)
			local start=st.tick_ts
			while st.tick_ts-start<duration(e,"start") do coroutine.yield() end
			U.animation_start(e,"loop",nil,st.tick_ts,true,1)
			local next_spawn=st.tick_ts
			start=st.tick_ts
			while alive(e.boss_owner) and st.tick_ts-start<e.life do
				if st.tick_ts>=next_spawn then
					local source=e.phase==2 and next_spawn==start and "enemy_immortal" or "enemy_fallen"
					summon(e.boss_owner,source,e.pos,st,60);next_spawn=next_spawn+1
				end
				coroutine.yield()
			end
			U.animation_start(e,"end",nil,st.tick_ts,false,1)
			e.tween.ts,e.tween.reverse=st.tick_ts,true
			local finish=st.tick_ts
			while st.tick_ts-finish<duration(e,"end") do coroutine.yield() end
			remove(e)
		end
	end
	for i=1,loops do
		local e=E:create_entity(name)
		e.pos=V.v(pos.x+(i-(loops+1)/2)*25,pos.y)
		e.boss_owner,e.life,e.phase=this,native.duration,s.phase
		for _,sp in ipairs(e.render.sprites) do sp.ts=store.tick_ts end
		insert(e)
		require("sound_db"):queue(E.entities.set_obelisk.sound_events.insert)
	end
	C.wait(this,store,A:duration("xerxes_obelisk_start"),function() return this.nav_rally.new end)
	C.cast(this,store,"skill_end",duration(this,"skill_end"))
end


function M.owner_alive(this) return this.boss_state and this.boss_state.phase==1 end
function M.summon_passive(this,store)
	if this.summon_source=="enemy_primordial" then C.raise(this,store,"enemy_fallen",200,0.5,15) end
end
function M.passive(this,store)
	local s=state(this,store)
	if not this._set_fire_pending and not store.entities[this._set_fire_visual] then
		local visual=E:create_entity("allied_set_fire_visual")
		visual.owner_id,visual.pos=this.id,copy(this.pos)
		this._set_fire_visual,this._set_fire_pending=visual.id,true
		insert(visual)
	end
	if C.ready(this,store,"fire",1) then
		C.stamp(this,store,"fire")
		local name=s.phase==2 and "mod_set_fire_2" or "mod_set_fire"
		local template=E:get_template(name)
		for _,target in ipairs(U.find_enemies_in_range(store.entities,this.pos,0,128,template.modifier.vis_flags,template.modifier.vis_bans) or {}) do
			local mod=E:create_entity(name)
			mod.modifier.source_id,mod.modifier.target_id=this.id,target.id
			insert(mod)
		end
	end
	if s.phase==2 then C.raise(this,store,"enemy_fallen",200,0.5,15) end
end
function M.automatic(this,store)
	local s,n=state(this,store),C.native(this)
	if C.ready(this,store,"channel",s.phase==2 and 40 or 30) then
		local units=C.living_summons(this,store);local candidates={}
		for _,e in ipairs(units) do if e.summon_source=="enemy_fallen" or s.phase==2 and e.summon_source=="enemy_immortal" then candidates[#candidates+1]=e end end
		if #candidates>0 then
			C.stamp(this,store,"channel");local a=n.timed_attacks.list[1]
			if C.cast(this,store,a.animations[1],math.max(a.cast_time,duration(this,a.animations[1]))) then
				animate(this,a.animations[2],store,true)
				this._set_channel_sound=a.sound
				require("sound_db"):queue(a.sound)
				for _,e in ipairs(candidates) do e.unit.damage_factor=e.unit.damage_factor+1 end
				local completed=C.wait(this,store,a.cast_time_2,function() return this.nav_rally.new end) and not this.nav_rally.new
				stop_channel(this)
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
					C.cast(this,store,a.animations[3],duration(this,a.animations[3]),a.sound2)
				end
			end
			stop_channel(this)
			return true
		end
	end
	return false
end
function M.dead(this,store)
	stop_channel(this)
	local s=state(this,store)
	if s.phase~=1 then return false end
	U.unblock_target(store,this)
	local can_click,bar_hidden=this.ui.can_click,this.health_bar.hidden
	this.ui.can_click,this.health_bar.hidden=false,true
	require("sound_db"):queue(C.native(this).sound_events.firstdeath)
	animate(this,"death",store,false)
	local start=store.tick_ts
	while store.tick_ts-start<duration(this,"death")+3 do coroutine.yield() end
	s.phase=2;this.health.dead=false;this.health.hp=this.health.hp_max
	this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=160,240
	local ignore,bans=this.health.ignore_damage,this.vis.bans
	this.health.ignore_damage,this.vis.bans=true,F_ALL
	require("sound_db"):queue(C.native(this).sound_events.revive)
	animate(this,"raise",store,false)
	C.wait(this,store,duration(this,"raise"))
	this.health.ignore_damage,this.vis.bans=ignore,bans
	this.ui.can_click,this.health_bar.hidden=can_click,bar_hidden
	return true
end
function M.respawn(this)
	this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=100,150
end
return M
