-- Playable Mirage: shadow dodge, Nomad copies and native throwing knives.
local C,bit
local U=require("utils")
local finish=require("malik_presentation").finish
local M={name="hero_allied_mirage",title="Mirage",kind="mirage",source="enemy_mirage_path",
	icon="encyclopedia_creep_thumbs_0411",scaled=true,
	textures={"kr4_sandstorm","kr4_sandstorm_mirage"},
	unscaled_textures={"encyclopedia_creeps","rebborn_enemy_icons"},sounds={"branch_campaigns"},
	skill={label="Ảnh",cooldown=8,range=350,
		description="Tự phi dao, né bằng dịch chuyển và để lại phân thân. Tạo tối đa 4 bản sao Nomad đồng minh. Né hồi 8 giây; bản sao hồi 14 giây, hai chiêu cách nhau ít nhất 8 giây."}}
function M.register()
	C,bit=require("allied_boss_common"),require("bit")
	local t=C.create(M)
	t.melee.attacks[1].count=1 -- Native basic attack hits one target; copies are a separate skill.
	return t
end
function M.prepare(t)
	t.render.sprites[1].angles.rangeAttack={"rangeAttack","rangeAttackUp","rangeAttack"}
end
local function shared_ready(this,store,a)
	return C.ready(this,store,"shared",a.shared_min_cooldown or 0)
end
function M.automatic(this,store,targets)
	if #targets==0 then return false end
	local n=C.native(this).branch
	local a=n.clone
	if C.ready(this,store,"copies",a.cooldown) and shared_ready(this,store,a) then
		C.stamp(this,store,"copies");C.stamp(this,store,"shared")
		if C.cast(this,store,a.animation,a.cast_time,a.sound) then
			-- Adapt native Nomad copying into an allied group, independent of enemy waves.
			for i=1,a.max_targets do
				local angle=2*math.pi*(i-1)/a.max_targets
				C.summon(this,a.template,{x=this.pos.x+18*math.cos(angle),y=this.pos.y+12*math.sin(angle)},store,30)
			end
			finish(this,store)
		end
		return true
	end
	a=n.shadow_jump
	if C.ready(this,store,"dodge",a.cooldown) and shared_ready(this,store,a) then
		for _,target in ipairs(targets) do
			if bit.band(target.vis.flags,F_FLYING)==0 and C.dist(this.pos,target.pos)<=125 then
				local dx,dy=this.pos.x-target.pos.x,this.pos.y-target.pos.y
				local length=math.sqrt(dx*dx+dy*dy)
				if length<1 then dx,dy,length=-1,0,1 end
				local pos={x=target.pos.x+dx/length*80,y=target.pos.y+dy/length*80}
				if require("path_db"):valid_node_nearby(pos.x,pos.y,nil,NF_RALLY) and
					require("grid_db"):cell_is_only(pos.x,pos.y,bit.bor(TERRAIN_LAND,TERRAIN_ICE)) then
					C.stamp(this,store,"dodge");C.stamp(this,store,"shared")
					if C.cast(this,store,a.animation_out,0,a.sound) and finish(this,store) then
						C.summon(this,a.leave_copy,this.pos,store,20)
						U.unblock_target(store,this)
						C.land(this,pos)
						if C.cast(this,store,a.animation_in,0) then finish(this,store) end
					end
					return true
				end
			end
		end
	end
	a=n.ranged
	if C.ready(this,store,"ranged",a.cooldown) then
		for _,target in ipairs(targets) do
			local d=C.dist(this.pos,target.pos)
			if d>=a.min_range and d<=a.max_range then
				C.stamp(this,store,"ranged")
				local animation,flip=U.animation_name_facing_point(this,a.animation,target.pos)
				this.render.sprites[1].flip_x=flip
				if C.cast(this,store,animation,a.hit_time,a.sound) then
					C.projectile(this,a.projectile,target,target.pos,store,{lo=a.damage_min,hi=a.damage_max,kind=a.damage_type,flight=a.flight_time,height=this.unit.hit_offset.y,rotate=true,hit_offset=true})
					finish(this,store)
				end
				return true
			end
		end
	end
	return false
end
return M
