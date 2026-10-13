-- Godieth (eb_balrog): allied melee, toxic spit, pools and Shadow Spawn conversion.
local C,E,U,A,P,bit
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
				coroutine.yield()
				coroutine.yield()
				-- One corpse may be used by only one allied summoner.
				if target.health.dead and not target.pending_removal and C.alive(this.boss_owner) and
					not target._allied_corpse_claimed and target.unit and
					not (native.excluded_templates and table.contains(native.excluded_templates,target.template_name)) and
					bit.band(target.vis.flags,bit.bor(F_FLYING,F_BOSS,F_MINIBOSS))==0 and
					P:valid_node_nearby(target.pos.x,target.pos.y,nil,NF_RALLY) then
					target._allied_corpse_claimed=true
					U.sprites_hide(target)
					C.visual(native.explode_fx,target.pos,store,1)
					C.summon(this.boss_owner,native.spawn_entity,target.pos,store,45)
				end
				break
			end
			if m.use_mod_offset and target.unit and target.unit.mod_offset then
				local offset=this.render.sprites[1].offset
				offset.x=target.unit.mod_offset.x*(target.render and target.render.sprites[1].flip_x and -1 or 1)
				offset.y=target.unit.mod_offset.y
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
	t.main_script.insert=function(this,store)
		this.tween.ts=store.tick_ts
		for _,s in ipairs(this.render.sprites) do s.ts=store.tick_ts end
		return true
	end
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
							-- Reserve before queueing: overlapping pools run before modifier insertion.
							target._allied_godieth_poison=m
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
local function pool(owner,pos)
	local e=E:create_entity("allied_godieth_pool")
	e.pos,e.boss_owner=C.copy(pos),owner
	return e
end
function M.register()
	C,E,U,A,P,bit=require("allied_boss_common"),require("entity_db"),require("utils"),require("animation_db"),require("path_db"),require("bit")
	local t=C.create(M)
	register_poison();register_pool()
	return t
end
function M.summon_passive(this,store)
	if this._godieth_raised then return end
	this._godieth_raised=true
	local sounds=E:get_template(this.summon_source).sound_events
	require("sound_db"):queue(sounds.raise,sounds.raise_args)
	C.animate(this,"raise",store,false)
	local ending=store.tick_ts+A:duration(this.render.sprites[1].prefix.."_raise")
	while store.tick_ts<ending and C.alive(this) and not this.unit.is_stunned do coroutine.yield() end
end
function M.automatic(this,store,targets)
	local a=C.native(this).timed_attacks.list[1]
	local cd=type(a.cooldown)=="table" and (a.cooldown[store.level_difficulty or 1] or a.cooldown[1]) or a.cooldown
	if not C.ready(this,store,"spit",cd) then return false end
	for _,target in ipairs(targets) do
		local nodes=bit.band(target.vis.flags,F_FLYING)==0 and
			P:nearest_nodes(target.pos.x,target.pos.y,nil,nil,true,NF_RALLY)
		if nodes and #nodes>0 then
			local pi,_,ni=unpack(nodes[1])
			local destination=P:node_pos(pi,1,ni)
			local _,flip=U.animation_name_facing_point(this,a.animation,destination)
			for _,s in ipairs(this.render.sprites) do
				if s.animated and not s.ignore_start then s.flip_x=flip end
			end
			C.stamp(this,store,"spit")
			if C.cast(this,store,a.animation,a.shoot_time,a.sound) then
				-- Reuse the native bomb for its parabola, particle trail and impact; replace its enemy pool.
				local b=E:create_entity(a.bullet)
				local offset=a.bullet_start_offset[1]
				b.bullet.from={x=this.pos.x+(flip and -1 or 1)*offset.x,y=this.pos.y+offset.y}
				b.bullet.to,b.bullet.source_id=destination,this.id
				b.bullet.hit_decal=nil
				b.bullet.hit_payload=pool(this,destination)
				b.pos=C.copy(b.bullet.from)
				C.insert(b)
				C.stamp(this,store,"spit")
				local s=this.render.sprites[1]
				local duration=A:duration(s.prefix.."_"..a.animation)
				C.wait(this,store,math.max(0,s.ts+duration-store.tick_ts))
			end
			return true
		end
	end
	return false
end
return M
