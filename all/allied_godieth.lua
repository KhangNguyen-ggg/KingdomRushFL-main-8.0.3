-- Godieth (eb_balrog): allied melee, toxic spit, pools and Shadow Spawn conversion.
local C,E,U,bit
local M={name="hero_allied_godieth",title="Godieth",kind="godieth",source="eb_balrog",
	icon="encyclopedia_creep_thumbs_0048",scaled=false,
	textures={"encyclopedia_creeps","rebborn_enemy_icons","go_enemies_forgotten_treasures","go_stage22"},
	sounds={"ElvesForgottenTreasureBalrogSounds","ElvesForgottenTreasureShadowSpawnSounds"},
	skill={label="Độc",cooldown=10,range=1e99,
		description="Tự phun độc vào địch trên bộ. Vùng độc tồn tại 10 giây, bán kính 50; gây 10 sát thương độc mỗi 11 khung hình. Địch chết khi nhiễm độc hóa thành Shadow Spawn đồng minh. Hồi chiêu 10 giây (Impossible: 9 giây)."}}

local function release_poison(this,store)
	this.finished=true
	local target=store.entities[this.modifier.target_id]
	if target and target._allied_godieth_poison==this then target._allied_godieth_poison=nil end
end
local function register_poison()
	if E.entities.allied_godieth_poison then return end
	local native=E:get_template("mod_balrog")
	local t=E:register_t("allied_godieth_poison","modifier")
	E:add_comps(t,"render","dps")
	t.render,t.dps,t.modifier=table.deepclone(native.render),table.deepclone(native.dps),table.deepclone(native.modifier)
	t.modifier.vis_bans=bit.bor(F_FRIEND,F_FLYING)
	t.main_script.insert=function(this,store)
		local target=store.entities[this.modifier.target_id]
		if not target or not target.enemy or not require("scripts").mod_dps.insert(this,store) then
			release_poison(this,store);return false
		end
		target._allied_godieth_poison=this
		return true
	end
	t.main_script.remove=release_poison
	t.main_script.update=function(this,store)
		local m,dps=this.modifier,this.dps
		while store.tick_ts-m.ts<m.duration do
			local target=store.entities[m.target_id]
			if not target or not target.enemy or target.pending_removal then break end
			this.pos=target.pos
			if target.health.dead then
				-- One corpse may be used by only one allied summoner.
				if C.alive(this.boss_owner) and not target._allied_corpse_claimed and target.unit and
					bit.band(target.vis.flags,bit.bor(F_FLYING,F_BOSS,F_MINIBOSS))==0 and
					require("path_db"):valid_node_nearby(target.pos.x,target.pos.y,nil,NF_RALLY) then
					target._allied_corpse_claimed=true
					C.summon(this.boss_owner,native.spawn_entity,target.pos,store,45)
				end
				break
			end
			if m.use_mod_offset and target.unit and target.unit.mod_offset then
				local offset=this.render.sprites[1].offset
				offset.x,offset.y=target.unit.mod_offset.x,target.unit.mod_offset.y
			end
			if store.tick_ts-dps.ts>=dps.damage_every then
				dps.ts=store.tick_ts
				local d=E:create_damage()
				d.source_id,d.target_id,d.value,d.damage_type=m.source_id,target.id,dps.damage_max,dps.damage_type
				store.damage_queue[#store.damage_queue+1]=d
			end
			coroutine.yield()
		end
		release_poison(this,store);C.remove(this)
	end
end
local function register_pool()
	if E.entities.allied_godieth_pool then return end
	local native=E:get_template("aura_bullet_balrog")
	local t=E:register_t("allied_godieth_pool","decal_scripted")
	E:add_comps(t,"tween")
	t.render,t.tween=table.deepclone(native.render),table.deepclone(native.tween)
	t.main_script.update=function(this,store)
		local start,last=store.tick_ts,store.tick_ts-native.aura.cycle_time
		while store.tick_ts-start<native.aura.duration+0.5 do
			if store.tick_ts-start<native.aura.duration and store.tick_ts-last>=native.aura.cycle_time then
				last=store.tick_ts
				local targets=U.find_enemies_in_range(store.entities,this.pos,0,native.aura.radius,
					E.entities.allied_godieth_poison.modifier.vis_flags,F_FLYING) or {}
				for _,target in ipairs(targets) do
					if target.enemy and C.alive(target) and U.flags_pass(target.vis,E.entities.allied_godieth_poison.modifier) then
						local m=target._allied_godieth_poison
						if m and not m.finished and not m.pending_removal then
							m.modifier.ts=store.tick_ts
						else
							m=E:create_entity("allied_godieth_poison")
							m.modifier.source_id,m.modifier.target_id=this.boss_owner.id,target.id
							m.boss_owner=this.boss_owner
							C.insert(m)
						end
					end
				end
			end
			coroutine.yield()
		end
		C.remove(this)
	end
end
local function pool(owner,pos,store)
	local e=E:create_entity("allied_godieth_pool")
	e.pos,e.boss_owner,e.tween.ts=C.copy(pos),owner,store.tick_ts
	for _,s in ipairs(e.render.sprites) do s.ts=store.tick_ts end
	C.insert(e)
end
function M.register()
	C,E,U,bit=require("allied_boss_common"),require("entity_db"),require("utils"),require("bit")
	local t=C.create(M)
	register_poison();register_pool()
	return t
end
function M.automatic(this,store,targets)
	local a=C.native(this).timed_attacks.list[1]
	local cd=type(a.cooldown)=="table" and (a.cooldown[store.level_difficulty or 1] or a.cooldown[1]) or a.cooldown
	if not C.ready(this,store,"spit",cd) then return false end
	for _,target in ipairs(targets) do
		if bit.band(target.vis.flags,F_FLYING)==0 and
			require("path_db"):valid_node_nearby(target.pos.x,target.pos.y,nil,NF_RALLY) then
			C.stamp(this,store,"spit")
			if C.cast(this,store,a.animation,a.shoot_time,a.sound) then
				local b=E:get_template(a.bullet).bullet
				local offset=a.bullet_start_offset[1]
				C.projectile(this,a.bullet,nil,target.pos,store,{lo=0,flight=b.flight_time_base+C.dist(this.pos,target.pos)*b.flight_time_factor,
					arc=45,height=offset.y,offset_x=offset.x,on_hit=pool})
				C.stamp(this,store,"spit")
			end
			return true
		end
	end
	return false
end
return M
