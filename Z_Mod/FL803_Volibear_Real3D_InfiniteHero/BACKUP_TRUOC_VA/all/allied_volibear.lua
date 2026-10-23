-- Volibear V2 (Prestige Duality Dragon) for KR FL 8.0.3: 50+ interpolated alpha frames.
-- Self-contained allied hero: never alters enemy_set, saves, or existing heroes.
 -- Frames are AI-reconstructed + optical flow; NOT a rip of original Riot 3D animations.
local C,E,A,U,V,bit
local M={
 name="hero_allied_volibear_prestige",kind="volibear_prestige",
 title="Volibear Long Trảo - Hàng Hiệu",source="enemy_set",
 icon="volibear_prestige_icon",custom_portrait=true,
 hero_class="Đấu sĩ - Lôi Long",
 textures={"go_volibear_prestige","ui_sett_spirit"},
 sounds={},
 preview_stats={health={hp_max=2800,armor=0.35,magic_armor=0.18},melee={attacks={{damage_min=120,damage_max=160}}}},
 skill={label="R",cooldown=21,range=220,description="Thần Lôi Giáng Thế: nhảy tới điểm chọn, gây sát thương diện rộng và làm choáng. P/Q/W/E tự dùng khi giao chiến."},
 skill_cards={
  {key="P",icon="volibear_prestige_icon",title="P - Lôi Điện Cuồng Nộ",description="Mỗi lần đánh thường tăng tích điện. Đạt 5 cộng dồn: tạo sét lan lên tới 4 kẻ địch trong bán kính 110, hồi 3 giây. Cơ chế chuyển thể KR FL, không phải số liệu gốc Liên Minh."},
  {key="Q",icon="volibear_prestige_icon",title="Q - Sấm Sét Truy Kích",description="Tự tung đòn vào một mục tiêu trong tầm 100, gây 210-260 sát thương vật lý và choáng 0,8 giây. Hồi chiêu 7 giây."},
  {key="W",icon="volibear_prestige_icon",title="W - Vuốt Rồng Cuồng Nộ",description="Xé mục tiêu gây 240-320 sát thương vật lý và đánh dấu 12 giây. Tái trúng cùng mục tiêu hồi máu. Hồi chiêu 9 giây."},
  {key="E",icon="volibear_prestige_icon",title="E - Thiên Lôi Giáng Hạ",description="Gọi lôi điện quanh mục tiêu trong tầm 190, gây 180-260 sát thương phép lên tối đa 8 kẻ địch. Tự hồi tối đa 120 HP nếu trúng địch. Hồi chiêu 12 giây."},
  {key="R",icon="volibear_prestige_icon",title="R - Thần Lôi Giáng Thế",description="Chỉ định điểm đến tối đa 220. Sau khi nhảy 0,5 giây, gây 420-560 sát thương vật lý và choáng 1 giây, bán kính 140. Tăng tốc đánh trong 8 giây, hồi chiêu 21 giây."}
 }
}
local function effect_damage(this,store,target,value,dtype)
 if not target or not C.alive(target) then return end
 local d=E:create_damage()
 d.source_id,d.target_id,d.value,d.damage_type=this.id,target.id,value*(this.unit.damage_factor or 1),dtype or DAMAGE_PHYSICAL
 store.damage_queue[#store.damage_queue+1]=d
end
local function current_target(this,targets)
 local target=targets and targets[1]
 if target and C.alive(target) then return target end
 return nil
end
local function charged_hit(this,store,attack,target)
 local s=C.state(this,store)
 s.voli_stacks=math.min(5,(s.voli_stacks or 0)+1)
 if s.voli_stacks>=5 and C.ready(this,store,"volibear_passive",3) then
  C.stamp(this,store,"volibear_passive")
  C.area(store,this,target.pos,110,48,70,DAMAGE_MAGICAL,nil,4,false)
 end
 return math.random(attack.damage_min,attack.damage_max)*(this.unit.damage_factor or 1)
end
local function prepare(t)
 local p=t.render.sprites[1].prefix
 -- V2: optical-flow inbetween frames; single correctly registered texture atlas.
 A.db[p.."_idle"]={prefix="volibear_prestige",frames={1,17,18,2,19,20,3,21,22,4,22,21,3,20,19,2,18,17}}
 A.db[p.."_walk"]={prefix="volibear_prestige",frames={5,23,24,6,25,26,7,27,28,8,28,27,7,26,25,6,24,23}}
 A.db[p.."_attack"]={prefix="volibear_prestige",frames={9,29,30,10,31,32,11,33,34,12,35,36,13,37,38,14,39,40,15,41,42,16}}
 A.db[p.."_q"]={prefix="volibear_prestige",frames={9,29,30,10,31,32,11,33,34,12}}
 A.db[p.."_w"]={prefix="volibear_prestige",frames={13,37,38,14,39,40,15,41,42,16}}
 A.db[p.."_e"]={prefix="volibear_prestige",frames={3,21,22,4,43,44,9,29,30,10,31,32,11}}
 A.db[p.."_jump"]={prefix="volibear_prestige",frames={4,43,44,9,29,30,10,31,32,11,33,34,12,35,36,13}}
 A.db[p.."_land"]={prefix="volibear_prestige",frames={13,37,38,14,39,40,15,41,42,16,46,45,1}}
 A.db[p.."_death"]={prefix="volibear_prestige",frames={49,50,51,52,53,54,55,56}}
 A.db[p.."_respawn"]={prefix="volibear_prestige",frames={56,55,54,53,52,51,50,49,1,2}}
 A.db[p.."_levelup"]={prefix="volibear_prestige",frames={4,43,44,9,29,30,10,31,32,11,33,34,12,35,36,13,47,48,16,46,45,1}}
 for _,name in ipairs({"walkUp","walkDown"}) do A.db[p.."_"..name]=A.db[p.."_walk"] end
 local sp=E:clone_c("sprite")
 sp.prefix=p;sp.name="idle";sp.anchor=V.v(0.5,0.13)
 sp.scale=V.v(0.35,0.35);sp.angles={walk={"walk","walkUp","walkDown"}}
 t.render.sprites={sp}
 t.health.hp_max,t.health.hp,t.health.armor,t.health.magic_armor=2800,2800,0.35,0.18
 t.health.dead_lifetime=20;t.health_bar.offset=V.v(0,67)
 t.regen.health,t.regen.cooldown=10,1
 t.motion.max_speed=80;t.unit.size=UNIT_SIZE_MEDIUM
 t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=V.v(0,33),V.v(0,33),V.v(0,0)
 t.ui.click_rect={pos=V.v(-28,0),size=V.v(56,65)}
 t.unit.death_animation="death";t.soldier.melee_slot_offset=V.v(28,0)
 t.melee.range=90;t.melee.attacks={}
 local a=E:clone_c("melee_attack")
 a.damage_min,a.damage_max=120,160
 a.damage_type=DAMAGE_PHYSICAL;a.cooldown=1;a.hit_time=8/FPS
 a.animation="attack";a.fn_damage=charged_hit
 a.vis_flags,a.vis_bans=F_BLOCK,bit.bor(F_FLYING,F_CLIFF)
 a.xp_gain_factor=0;a.sound="MeleeSword"
 t.melee.attacks[1]=a
 t.info.i18n_key="HERO_ALLIED_VOLIBEAR_PRESTIGE"
 t.info.portrait="info_portrait_volibear_prestige"
 t.info.hero_portrait="volibear_prestige_icon"
end
function M.register()
 C,E,A,U,V,bit=require("allied_boss_common"),require("entity_db"),require("animation_db"),require("utils"),require("klua.vector"),require("bit")
 local t=C.create(M)
 for _,msgs in pairs(require("i18n").msgs) do
  msgs.HERO_ALLIED_VOLIBEAR_PRESTIGE_NAME=M.title
  msgs.HERO_ALLIED_VOLIBEAR_PRESTIGE_DESCRIPTION=M.skill.description
 end
 return t
end
M.prepare=prepare
M.respawn=function(this) if this.render and this.render.sprites[1] then this.render.sprites[1].offset.y=0 end end
function M.passive(this,store)
 local s=C.state(this,store)
 -- Never permanently mutate shared melee templates; this entity owns its cloned attack.
 local a=this.melee.attacks[1]
 a.cooldown=store.tick_ts<(s.voli_ult_end or 0) and 0.62 or 1
end
function M.automatic(this,store,targets)
 local target=current_target(this,targets)
 if not target then return false end
 local d=C.dist(this.pos,target.pos)
 if d<=100 and C.ready(this,store,"volibear_q",7) then
  C.stamp(this,store,"volibear_q")
  this.render.sprites[1].flip_x=target.pos.x<this.pos.x
  if C.cast(this,store,"q",0.35,"MeleeSword") and C.alive(target) then
   effect_damage(this,store,target,235,DAMAGE_PHYSICAL)
   C.area(store,this,target.pos,20,0,0,DAMAGE_PHYSICAL,0.8,1,true)
  end
  return true
 end
 if d<=95 and C.ready(this,store,"volibear_w",9) then
  C.stamp(this,store,"volibear_w")
  this.render.sprites[1].flip_x=target.pos.x<this.pos.x
  if C.cast(this,store,"w",0.38,"MeleeSword") and C.alive(target) then
   effect_damage(this,store,target,270,DAMAGE_PHYSICAL)
   local s=C.state(this,store)
   if s.voli_mark_id==target.id and store.tick_ts<(s.voli_mark_until or 0) then
    this.health.hp=math.min(this.health.hp_max,this.health.hp+180)
   end
   s.voli_mark_id,s.voli_mark_until=target.id,store.tick_ts+12
  end
  return true
 end
 if d<=190 and C.ready(this,store,"volibear_e",12) then
  C.stamp(this,store,"volibear_e")
  this.render.sprites[1].flip_x=target.pos.x<this.pos.x
  if C.cast(this,store,"e",0.55) then
   C.area(store,this,target.pos,95,180,260,DAMAGE_MAGICAL,nil,8,true)
   this.health.hp=math.min(this.health.hp_max,this.health.hp+120)
  end
  return true
 end
 return false
end
function M.active(this,store,pos)
 if C.dist(this.pos,pos)>M.skill.range then return end
 pos=C.copy(pos)
 local origin=C.copy(this.pos)
 local old_bans=this.vis.bans
 this.vis.bans=bit.bor(old_bans,F_STUN)
 local sprite=this.render.sprites[1]
 local old_y=sprite.offset.y
 local began=store.tick_ts
 C.animate(this,"jump",store,false)
 -- Vertical jump arc is animated on the sprite only. Restore on interruption.
 local completed=C.wait(this,store,0.5,function()
  local t=math.min(1,(store.tick_ts-began)/0.5)
  sprite.offset.y=old_y+70*math.sin(math.pi*t)
  return this.nav_rally.new
 end)
 sprite.offset.y=old_y
 this.vis.bans=old_bans
 if not completed or this.nav_rally.new or not C.alive(this) then return end
 -- Land only on checked walkable points; if interrupted, original position is kept.
 C.land(this,pos)
 C.animate(this,"land",store,false)
 C.area(store,this,pos,140,420,560,DAMAGE_PHYSICAL,1,8,true)
 local s=C.state(this,store);s.voli_ult_end=store.tick_ts+8
 C.wait(this,store,0.25)
end
return M
