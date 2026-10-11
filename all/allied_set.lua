-- Playable Set: configuration, render binding, skills and two life phases.
local C,E,U,V
local A,I
local state,alive,copy,animate,summon,insert,remove
local M={name = "hero_allied_set", title = "Set", source = "enemy_set", icon = "encyclopedia_creep_thumbs_0265", textures = {"go_enemy_set", "go_enemies_hammerhold", "go_enemies_desert", "go_stages_hammerhold"}, sounds = {"HammerholdEnemySounds"}}
M.kind="set"
M.skill={label="Trụ",cooldown=10,range=450,description="Dựng trụ gọi Fallen; cường hóa Fallen thành Immortal rồi Primordial. Hào quang lửa, hồi sinh và hình thái thứ hai."}
function M.register()
	C=require("allied_boss_common");E=require("entity_db");U=require("utils");V=require("klua.vector")
	A=require("animation_db");I=require("klove.image_db")
	state,alive,copy,animate,summon,insert,remove=C.state,C.alive,C.copy,C.animate,C.summon,C.insert,C.remove
	return C.create(M)
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
	local s=state(this,store);s.obelisk=s.obelisk+1
	local native=C.native(this).timed_attacks.list[2]
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


function M.owner_alive(this) return this.boss_state and this.boss_state.phase==1 end
function M.summon_passive(this,store)
	if this.summon_source=="enemy_primordial" then C.raise(this,store,"enemy_fallen",200,0.5,15) end
end
function M.passive(this,store)
	local s=state(this,store)
	if C.ready(this,store,"fire",1) then
		C.stamp(this,store,"fire")
		C.area(store,this,this.pos,128,s.phase==2 and 24 or 9,nil,DAMAGE_TRUE,nil,nil,true)
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
			if C.cast(this,store,a.animations[1],a.cast_time,a.sound) then
				animate(this,a.animations[2],store,true)
				for _,e in ipairs(candidates) do e.unit.damage_factor=e.unit.damage_factor+1 end
				local completed=C.wait(this,store,a.cast_time_2)
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
					C.cast(this,store,a.animations[3],0.5,a.sound2)
				end
			end
			return true
		end
	end
	return false
end
function M.dead(this,store)
	local s=state(this,store)
	if s.phase~=1 then return false end
	animate(this,"death",store,false)
	local start=store.tick_ts
	while store.tick_ts-start<3 do coroutine.yield() end
	s.phase=2;this.health.dead=false;this.health.hp=this.health.hp_max
	this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=160,240
	C.cast(this,store,"raise",1)
	return true
end
function M.respawn(this)
	this.melee.attacks[1].damage_min,this.melee.attacks[1].damage_max=100,150
end
return M
