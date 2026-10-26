-- Volibear Prestige Duality Dragon: character animations rendered from Khada GLB.
-- Independent allied hero; does not modify enemy templates or existing save slots.
-- Riot ability VFX/particles are not included in GLB and are not replicated here.
local C,E,A,U,V,bit
local M={
 name="hero_allied_volibear_prestige",kind="volibear_prestige",
 title="Volibear Long Trảo - Hàng Hiệu",source="enemy_set",
 icon="volibear_prestige_icon",custom_portrait=true,
 hero_class="Đấu sĩ - Lôi Long",
 textures={"go_volibear_attack1","go_volibear_attack2","go_volibear_death","go_volibear_e_channel","go_volibear_e_idle","go_volibear_e_windup","go_volibear_idle","go_volibear_knockup","go_volibear_q_attack","go_volibear_q_intro","go_volibear_q_outro","go_volibear_r_cast","go_volibear_r_impact","go_volibear_r_outro","go_volibear_r_run","go_volibear_respawn","go_volibear_run","go_volibear_w_slash","ui_sett_spirit"},
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
local function attack_ready(this, store, attack)
 local s = C.state(this, store)
 return attack.voli_hand == (s.voli_hand or 1)
end
local function charged_hit(this,store,attack,target)
 local s=C.state(this,store)
 s.voli_hand=3-(attack.voli_hand or 1)
 s.voli_stacks=math.min(5,(s.voli_stacks or 0)+1)
 if s.voli_stacks>=5 and C.ready(this,store,"volibear_passive",3) then
  C.stamp(this,store,"volibear_passive")
  C.area(store,this,target.pos,110,48,70,DAMAGE_MAGICAL,nil,4,false)
 end
 return math.random(attack.damage_min,attack.damage_max)*(this.unit.damage_factor or 1)
end
local function prepare(t)
 local p=t.render.sprites[1].prefix
 require("volibear_animation_map").register(p,A)
 -- Engine advances sprite frames at fixed FPS. Condense attack clips so
 -- they can finish before the next melee cooldown while retaining ALL poses.
 local function compact(source, target, count)
  local a=assert(A.db[p.."_"..source],"Missing Volibear animation: "..source)
  local frames={}
  for i=1,count do
   local j=math.floor((i-1)*(#a.frames-1)/math.max(1,count-1)+0.5)+1
   frames[i]=a.frames[j]
  end
  A.db[p.."_"..target]={prefix=a.prefix,frames=frames}
 end
 A.db[p.."_walk"]=A.db[p.."_run"]
 A.db[p.."_walkUp"]=A.db[p.."_run"]
 A.db[p.."_walkDown"]=A.db[p.."_run"]
 compact("attack1","attack",26)
 compact("attack2","attack2",26)
 compact("q_intro","q_intro",7)
 compact("q_attack","q_attack",12)
 compact("q_outro","q_outro",7)
 compact("w_slash","w",19)
 compact("e_windup","e_windup",9)
 compact("e_channel","e_channel",11)
 compact("r_run","jump",21)
 compact("r_impact","land",14)
 compact("r_outro","r_outro",7)
 A.db[p.."_levelup"]=A.db[p.."_r_impact"]
 local sp=E:clone_c("sprite")
 sp.prefix=p;sp.name="idle";sp.anchor=V.v(0.5,0.13)
 sp.scale=V.v(0.37,0.37);sp.angles={walk={"walk","walkUp","walkDown"}}
 t.render.sprites={sp}
 t.health.hp_max,t.health.hp,t.health.armor,t.health.magic_armor=2800,2800,0.35,0.18
 t.health.dead_lifetime=20;t.health_bar.offset=V.v(0,67)
 t.regen.health,t.regen.cooldown=10,1
 t.motion.max_speed=80;t.unit.size=UNIT_SIZE_MEDIUM
 t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=V.v(0,33),V.v(0,33),V.v(0,0)
 t.ui.click_rect={pos=V.v(-28,0),size=V.v(56,65)}
 t.unit.death_animation="death";t.soldier.melee_slot_offset=V.v(28,0)
 t.melee.range=90;t.melee.attacks={}
 for hand=1,2 do
  local a=E:clone_c("melee_attack")
  a.damage_min,a.damage_max=120,160
  a.damage_type=DAMAGE_PHYSICAL;a.cooldown=1.0;a.hit_time=12/FPS
  a.animation=hand==1 and "attack" or "attack2";a.voli_hand=hand
  a.fn_can=attack_ready;a.fn_damage=charged_hit;a.shared_cooldown=true
  a.vis_flags,a.vis_bans=F_BLOCK,bit.bor(F_FLYING,F_CLIFF)
  a.xp_gain_factor=0;a.sound="MeleeSword"
  t.melee.attacks[hand]=a
 end
 t.melee.order={1,2}
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
 for _,a in ipairs(this.melee.attacks) do
  a.cooldown=store.tick_ts<(s.voli_ult_end or 0) and 0.68 or 1.0
 end
end
function M.automatic(this,store,targets)
 local target=current_target(this,targets)
 if not target then return false end
 local d=C.dist(this.pos,target.pos)
 if d<=100 and C.ready(this,store,"volibear_q",7) then
  C.stamp(this,store,"volibear_q")
  this.render.sprites[1].flip_x=target.pos.x<this.pos.x
  -- Q: real intro and swipe poses from the 3D model.
  if C.cast(this,store,"q_intro",0.20,"MeleeSword") then
   if C.cast(this,store,"q_attack",0.36,"MeleeSword") and C.alive(target) then
    effect_damage(this,store,target,235,DAMAGE_PHYSICAL)
    C.area(store,this,target.pos,20,0,0,DAMAGE_PHYSICAL,0.8,1,true)
   end
   C.animate(this,"q_outro",store,false)
   C.wait(this,store,0.20)
  end
  return true
 end
 if d<=95 and C.ready(this,store,"volibear_w",9) then
  C.stamp(this,store,"volibear_w")
  this.render.sprites[1].flip_x=target.pos.x<this.pos.x
  if C.cast(this,store,"w",0.57,"MeleeSword") and C.alive(target) then
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
  if C.cast(this,store,"e_windup",0.27) and C.cast(this,store,"e_channel",0.35) then
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
 local sprite=this.render.sprites[1]
 local original_y=sprite.offset.y
 this.render.sprites[1].flip_x=pos.x<this.pos.x
 -- R: actual cast and ground-pound from Khada GLB; 3D VFX is not supplied.
 if not C.cast(this,store,"r_cast",0.07) then return end
 local began=store.tick_ts
 local finished=C.move_form(this,store,0.70,1,"jump",function()
  local f=math.min(1,(store.tick_ts-began)/0.70)
  this.pos.x=origin.x+(pos.x-origin.x)*f
  this.pos.y=origin.y+(pos.y-origin.y)*f
  sprite.offset.y=original_y+76*math.sin(math.pi*f)
 end,true)
 sprite.offset.y=original_y
 -- Return to valid coordinates even if the cast was interrupted.
 C.land(this,finished and pos or origin)
 if not finished or not C.alive(this) then return end
 C.animate(this,"land",store,false)
 if not C.wait(this,store,0.19) then return end
 C.area(store,this,pos,140,420,560,DAMAGE_PHYSICAL,1,8,true)
 local s=C.state(this,store);s.voli_ult_end=store.tick_ts+8
 C.wait(this,store,0.25)
 C.animate(this,"r_outro",store,false)
 C.wait(this,store,0.20)
end
return M
