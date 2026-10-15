-- Playable Juggernaut: configuration and autonomous skills.
local C
local E
local A
local U
local M={name = "hero_allied_juggernaut", title = "Juggernaut", source = "eb_juggernaut", icon = "encyclopedia_creep_thumbs_0132", textures = {"go_stage50"}}
M.kind="juggernaut"
M.skill={label="Golem",cooldown=10,range=700,description="Bắn tên lửa tự động. Ném bom gọi 7 Golem Head tại mục tiêu gần nhất, hồi chiêu 10 giây."}
function M.register()
	C=require("allied_boss_common");E=require("entity_db");A=require("animation_db");U=require("utils")
	return C.create(M)
end
function M.prepare(t)
	local prefix=t.render.sprites[1].prefix
	-- shortcut: no native downward frames; reuse side steps until a downward atlas is available.
	A.db[prefix.."_walkDown"]=A.db[prefix.."_walk"]
end
local function shoot(this,store,a,target,pos,spec)
	local _,flip=U.animation_name_facing_point(this,a.animation,pos)
	this.render.sprites[1].flip_x=flip
	if not C.cast(this,store,a.animation,a.shoot_time) then return false end
	local offset=a.bullet_start_offset
	spec.height,spec.offset_x=offset.y,(flip and -1 or 1)*offset.x
	C.projectile(this,a.bullet,target,pos,store,spec)
	if spec.summon then C.stamp(this,store,"active") end
	local sprite=this.render.sprites[1]
	-- Release at the native frame, then finish the recovery before another action.
	C.wait(this,store,math.max(0,sprite.ts+A:duration(sprite.prefix.."_"..a.animation)-store.tick_ts))
	return true
end
function M.active(this,store,pos)
	local a=C.native(this).timed_attacks.list[2]
	shoot(this,store,a,nil,pos,{summon="enemy_golem_head",count=7,arc=100,flight=1.5})
end
function M.automatic(this,store,targets)
	local a=C.native(this).timed_attacks.list[1]
	if #targets>0 and C.ready(this,store,"missile",a.cooldown) then
		for _,target in ipairs(targets) do
			if C.dist(target.pos,this.pos)>=a.min_range then
				C.stamp(this,store,"missile")
				local b=E.entities[a.bullet].bullet
				shoot(this,store,a,target,target.pos,{lo=b.damage_min,hi=b.damage_max,kind=b.damage_type,radius=b.damage_radius,arc=40,fx=b.hit_fx,rotate=true})
				return true
			end
		end
	end
	return false
end
return M
