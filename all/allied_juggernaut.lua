-- Playable Juggernaut: configuration and autonomous skills.
local C
local E
local M={name = "hero_allied_juggernaut", title = "Juggernaut", source = "eb_juggernaut", icon = "encyclopedia_creep_thumbs_0132", textures = {"go_stage50"}}
M.kind="juggernaut"
M.skill={label="Golem",cooldown=10,range=700,description="Bắn tên lửa tự động. Ném bom gọi 7 Golem Head tại mục tiêu gần nhất, hồi chiêu 10 giây."}
function M.register()
	C=require("allied_boss_common");E=require("entity_db")
	return C.create(M)
end
function M.active(this,store,pos)
	local a=C.native(this).timed_attacks.list[2]
	if C.cast(this,store,a.animation,a.shoot_time) then
		C.projectile(this,a.bullet,nil,pos,store,{summon="enemy_golem_head",count=7,arc=100,flight=1.5,height=82})
		C.stamp(this,store,"active") -- Ten seconds from bomb release, per hero copy.
	end
end
function M.automatic(this,store,targets)
	local a=C.native(this).timed_attacks.list[1]
	if #targets>0 and C.ready(this,store,"missile",a.cooldown) then
		for _,target in ipairs(targets) do
			if C.dist(target.pos,this.pos)>=a.min_range then
				C.stamp(this,store,"missile")
				if C.cast(this,store,a.animation,a.shoot_time) then
					local b=E.entities[a.bullet].bullet
					C.projectile(this,a.bullet,target,target.pos,store,{lo=b.damage_min,hi=b.damage_max,kind=b.damage_type,radius=b.damage_radius,arc=40,fx=b.hit_fx})
				end
				return true
			end
		end
	end
	return false
end
return M
