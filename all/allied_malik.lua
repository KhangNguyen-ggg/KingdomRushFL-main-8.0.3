-- Playable Malik: both native visual layers, hammer throw and rocket jump.
local C,bit
local M={name="hero_allied_malik",title="Malik",kind="malik",source="enemy_malik",
	icon="encyclopedia_creep_thumbs_0393",scaled=true,textures={"go_stage186","kr4_level36_malik"},
	unscaled_textures={"encyclopedia_creeps","rebborn_enemy_icons"},sounds={"branch_campaigns"},
	skill={label="Nhảy",cooldown=12,range=450,
		description="Tự nhảy tới địch và gây sát thương khi đáp đất, hồi 12 giây. Ném búa sét, hồi 4,5 giây. Chiêu phá tháp chuyển thành đập đất gây sát thương phép và choáng địch 3 giây, hồi 13 giây."}}
function M.register()
	C,bit=require("allied_boss_common"),require("bit")
	return C.create(M)
end
function M.active(this,store,pos)
	local a=C.native(this).branch.rocket_jump
	if not C.cast(this,store,a.animation_out,0.4,a.sound) then return end
	local from,start=C.copy(this.pos),store.tick_ts
	local completed=C.move_form(this,store,0.6,1,a.animation,function()
		local f=math.min(1,(store.tick_ts-start)/0.6)
		this.pos.x=from.x+(pos.x-from.x)*f
		this.pos.y=from.y+(pos.y-from.y)*f+math.sin(math.pi*f)*80
	end,true)
	-- A death/stun midair must not leave the hero suspended above the path.
	C.land(this,completed and pos or from)
	if completed and C.cast(this,store,a.animation_in,0.3,a.hit_sound) then
		C.area(store,this,this.pos,a.radius,a.damage_min,a.damage_max,DAMAGE_PHYSICAL,nil,nil,true)
	end
end
function M.automatic(this,store,targets)
	if #targets==0 then return false end
	local n=C.native(this).branch
	local a=n.tower_destroy
	if C.ready(this,store,"smash",a.cooldown) then
		for _,target in ipairs(targets) do
			if bit.band(target.vis.flags,F_FLYING)==0 and C.dist(this.pos,target.pos)<=a.range then
				C.stamp(this,store,"smash")
				if C.cast(this,store,a.animation,a.cast_time,a.sound) then
					C.area(store,this,this.pos,a.range,n.rocket_jump.damage_min,n.rocket_jump.damage_max,DAMAGE_MAGICAL,3,nil,true)
				end
				return true
			end
		end
	end
	a=n.ranged
	if C.ready(this,store,"ranged",a.cooldown) then
		for _,target in ipairs(targets) do
			local d=C.dist(this.pos,target.pos)
			if d>=a.min_range and d<=a.max_range then
				C.stamp(this,store,"ranged")
				if C.cast(this,store,a.animation,a.hit_time,a.sound) then
					C.projectile(this,a.projectile,target,target.pos,store,{lo=a.damage_min,hi=a.damage_max,kind=a.damage_type,flight=a.flight_time})
				end
				return true
			end
		end
	end
	return false
end
return M
