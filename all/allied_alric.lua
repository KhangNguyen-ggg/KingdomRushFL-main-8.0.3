-- Playable Alric: Sand Warriors, Flurry and protected sand travel.
local C,bit
local finish=require("malik_presentation").finish
local M={name="hero_allied_alric",title="Alric",kind="alric",source="enemy_alric",
	icon="encyclopedia_creep_thumbs_0413",scaled=true,textures={"kr4_level35_alric"},
	unscaled_textures={"encyclopedia_creeps","rebborn_enemy_icons"},sounds={"branch_campaigns"},
	skill={label="Cát",cooldown=16,range=350,
		description="Tự gọi 3 Sand Warrior mỗi 16 giây. Flurry đánh diện rộng, hồi 3 giây. Hóa lốc cát trong 3 giây, tăng tốc 6 lần và tránh sát thương, hồi 40 giây."}}
function M.register()
	C,bit=require("allied_boss_common"),require("bit")
	local t=C.create(M)
	t.melee.attacks[1].count=1 -- Only Flurry is an area attack.
	return t
end
function M.active(this,store,pos)
	local a=C.native(this).branch.spawn
	this.render.sprites[1].flip_x=pos.x<this.pos.x
	if C.cast(this,store,a.animation,a.cast_time) then
		for i=1,a.count do
			local angle=2*math.pi*(i-1)/a.count
			C.summon(this,a.template,{x=pos.x+18*math.cos(angle),y=pos.y+12*math.sin(angle)},store,45)
		end
		finish(this,store)
	end
end
function M.summon_passive(this,store)
	if this._alric_spawned then return end
	this._alric_spawned=true
	C.animate(this,"spawn",store,false)
	finish(this,store)
end
function M.automatic(this,store,targets)
	if #targets==0 then return false end
	local n=C.native(this)
	local a=n.branch.buried
	if C.ready(this,store,"buried",a.cooldown) then
		for _,target in ipairs(targets) do
			if bit.band(target.vis.flags,F_FLYING)==0 and
				require("path_db"):valid_node_nearby(target.pos.x,target.pos.y,nil,NF_RALLY) and
				require("grid_db"):cell_is_only(target.pos.x,target.pos.y,bit.bor(TERRAIN_LAND,TERRAIN_ICE)) then
				C.stamp(this,store,"buried")
				this.render.sprites[1].flip_x=target.pos.x<this.pos.x
				if C.cast(this,store,a.animation_in,0,a.sound) and finish(this,store) then
					this.nav_rally.pos=C.copy(target.pos);this.nav_rally.new=true
					if C.move_form(this,store,a.duration,a.factor,a.animation,nil,true) and C.cast(this,store,a.animation_out,0) then finish(this,store) end
				end
				return true
			end
		end
	end
	a=n.melee.attacks[1].area_attack
	if C.ready(this,store,"flurry",a.cooldown) then
		for _,target in ipairs(targets) do
			if bit.band(target.vis.flags,F_FLYING)==0 and C.dist(this.pos,target.pos)<=a.radius then
				C.stamp(this,store,"flurry")
				this.render.sprites[1].flip_x=target.pos.x<this.pos.x
				if C.cast(this,store,a.animation,a.hit_time,a.sound) then
					C.area(store,this,this.pos,a.radius,a.damage_min,a.damage_max,DAMAGE_PHYSICAL,nil,a.max_count,true)
					finish(this,store)
				end
				return true
			end
		end
	end
	return false
end
return M
