-- Playable Malik: both native visual layers, hammer throw and rocket jump.
local C,bit
local A = require("animation_db")
local SPEED = 1.5
local MP = require("malik_presentation")
local finish = MP.finish
local M={name="hero_allied_malik",title="Malik",kind="malik",source="enemy_malik",
	icon="encyclopedia_creep_thumbs_0393",scaled=true,textures={"go_stage186","kr4_level36_malik"},
	unscaled_textures={"encyclopedia_creeps","rebborn_enemy_icons"},sounds={"branch_campaigns"},
	skill={label="Nhảy",cooldown=12/SPEED,range=200,
		description="Tự nhảy tới địch trong tầm 200 và gây sát thương khi đáp đất, hồi 8 giây. Ném búa sét, hồi 3 giây. Đập đất gây sát thương phép và choáng địch 3 giây, hồi khoảng 8,67 giây. Tốc độ ra đòn và tung chiêu tăng 50%."}}
function M.prepare(t)
	local native = require("entity_db"):get_template(M.source).melee.attacks[1]
	t.melee.attacks[1].cooldown = native.cooldown / SPEED
	t.melee.attacks[1].hit_time = native.hit_time / SPEED
	for i = 1, 2 do
		A.db[t.render.sprites[i].prefix .. "_death"] = A.db["malik_layer" .. i .. "_allyDeath"]
		-- Clone only allied combat aliases so the enemy, walking and death keep their timing.
		for _, name in ipairs({"attack", "melee", "range", "special", "jumpLaunch", "jumpTravel", "jumpLand"}) do
			local key = t.render.sprites[i].prefix .. "_" .. name
			A.db[key] = table.clone(A.db[key])
			A.db[key].fps = A.fps * SPEED
		end
	end
end
function M.register()
	C,bit=require("allied_boss_common"),require("bit")
	return C.create(M)
end
function M.active(this,store,pos)
	if C.dist(this.pos,pos)>M.skill.range then return end
	pos=C.copy(pos)
	local a=C.native(this).branch.rocket_jump
	if not C.cast(this,store,a.animation_out,0.4/SPEED,a.sound) or
		not finish(this,store) then return end
	if C.dist(this.pos,pos)>M.skill.range then return end
	local from,start=C.copy(this.pos),store.tick_ts
	local old_z={}
	for sid,sprite in ipairs(this.render.sprites) do
		old_z[sid]=sprite.z
		if sprite.animated then sprite.z=Z_OBJECTS_COVERS+1 end
	end
	local completed=C.move_form(this,store,0.6/SPEED,1,a.animation,function()
		local f=math.min(1,(store.tick_ts-start)/(0.6/SPEED))
		this.pos.x=from.x+(pos.x-from.x)*f
		this.pos.y=from.y+(pos.y-from.y)*f+math.sin(math.pi*f)*80
	end,true)
	-- A death/stun midair must not leave the hero suspended above the path.
	C.land(this,completed and pos or from)
	for sid,sprite in ipairs(this.render.sprites) do sprite.z=old_z[sid] end
	if completed and C.cast(this,store,a.animation_in,0.3/SPEED) then
		if a.hit_sound then require("sound_db"):queue(a.hit_sound) end
		C.visual("fx_branch_malik_jump_decal",this.pos,store,18/30)
		C.area(store,this,this.pos,a.radius,a.damage_min,a.damage_max,DAMAGE_PHYSICAL,nil,nil,true)
		finish(this,store)
	end
end
function M.automatic(this,store,targets)
	if #targets==0 then return false end
	local n=C.native(this).branch
	local a=n.tower_destroy
	if C.ready(this,store,"smash",a.cooldown/SPEED) then
		for _,target in ipairs(targets) do
			if bit.band(target.vis.flags,F_FLYING)==0 and C.dist(this.pos,target.pos)<=a.range then
				C.stamp(this,store,"smash")
				if C.cast(this,store,a.animation,a.cast_time/SPEED,a.sound) then
					MP.tower_impact(store,target.pos)
					C.area(store,this,this.pos,a.range,n.rocket_jump.damage_min,n.rocket_jump.damage_max,DAMAGE_MAGICAL,3,nil,true)
					finish(this,store)
				end
				return true
			end
		end
	end
	a=n.ranged
	if C.ready(this,store,"ranged",a.cooldown/SPEED) then
		for _,target in ipairs(targets) do
			local d=C.dist(this.pos,target.pos)
			if d>=a.min_range and d<=a.max_range then
				C.stamp(this,store,"ranged")
				for _, sprite in ipairs(this.render.sprites) do
					if sprite.animated and not sprite.ignore_start then sprite.flip_x=target.pos.x<this.pos.x end
				end
				if C.cast(this,store,a.animation,a.hit_time/SPEED,a.sound) then
					if C.alive(target) then
						-- Let the native 20-frame bolt play once instead of cutting it at six frames.
						local ray=C.projectile(this,a.projectile,target,target.pos,store,{lo=a.damage_min,hi=a.damage_max,kind=a.damage_type,flight=A:duration("malik_attack_ray_travel"),height=this.unit.hit_offset.y,offset_x=this.render.sprites[1].flip_x and -25 or 25,rotate=true,hit_offset=true,fx_duration=A:duration("malik_attack_ray_modifier_run")})
						ray.render.sprites[1].loop=false
					end
					finish(this,store)
				end
				return true
			end
		end
	end
	return false
end
return M

