-- Volibear Prestige Duality Dragon: independent allied hero prototype.
-- Visual assets are concept art, NOT extracted League of Legends animations.
local C,E,A,V,bit
local M={
 name="hero_allied_volibear_prestige",kind="volibear_prestige",source="enemy_set",
 title="Volibear Long Trảo - Hàng Hiệu",
 icon="volibear_prestige_icon",custom_portrait=true,
 textures={"go_volibear_prestige","ui_volibear_prestige"},sounds={},
 hero_class="Đấu sĩ - Lôi Long",
 preview_stats={health={hp_max=2800,armor=0.35},melee={attacks={{damage_min=120,damage_max=160}}}},
 skill={label="R",cooldown=21,range=220,description="P sét lan, Q gây choáng, W cào và hồi máu, E lôi điện diện rộng; R nhảy dậm đất. Kỹ năng chuyển thể riêng cho KR FL."},
 skill_cards={
 {key="P",icon="volibear_prestige_icon",title="P - Lôi điện",description="Mỗi đòn thường tích một cộng dồn, đạt năm cộng dồn kích hoạt sét lan lên bốn mục tiêu gần."},
 {key="Q",icon="volibear_prestige_icon",title="Q - Sấm sét truy kích",description="Đập một mục tiêu 235 sát thương vật lý và choáng 0,8 giây. Hồi chiêu 7s."},
 {key="W",icon="volibear_prestige_icon",title="W - Vuốt rồng",description="Đánh mục tiêu 270 sát thương, tái trúng trong 12s hồi 180 HP. Hồi chiêu 9s."},
 {key="E",icon="volibear_prestige_icon",title="E - Thiên lôi",description="Gây 180–260 sát thương phép diện rộng, hồi 120 HP. Hồi chiêu 12s."},
 {key="R",icon="volibear_prestige_icon",title="R - Thần lôi giáng thế",description="Nhảy 220 đơn vị, gây 420–560 sát thương diện rộng và choáng 1s. Tăng tốc đánh 8s. Hồi chiêu 21s."}
 }
}
local function damage(hero,store,target,value,kind)
 if not C.alive(target) then return end
 local d=E:create_damage()
 d.source_id,d.target_id,d.value,d.damage_type=hero.id,target.id,value*(hero.unit.damage_factor or 1),kind
 store.damage_queue[#store.damage_queue+1]=d
end
local function hit(hero,store,attack,target)
 local s=C.state(hero,store)
 s.voli_stacks=math.min(5,(s.voli_stacks or 0)+1)
 if s.voli_stacks>=5 and C.ready(hero,store,"passive",3) then
  C.stamp(hero,store,"passive")
  C.area(store,hero,target.pos,110,48,70,DAMAGE_MAGICAL,nil,4,false)
 end
 return math.random(attack.damage_min,attack.damage_max)*(hero.unit.damage_factor or 1)
end
local function prepare(t)
 local prefix=t.render.sprites[1].prefix
 local function anim(key,frames,multiple)
  local result={}
  for _,f in ipairs(frames) do
   for i=1,(multiple or 1) do result[#result+1]=f end
  end
  A.db[prefix.."_"..key]={prefix="volibear_prestige",frames=result}
 end
 anim("idle",{1,12,1,12},4)
 for _,key in ipairs({"walk","walkUp","walkDown"}) do anim(key,{1,2,11,12},3) end
 anim("attack",{2,3,4,5},3)
 anim("q",{2,3,4,5},3)
 anim("w",{7,8,9,10},3)
 anim("e",{3,4,5,6},3)
 anim("jump",{3,3,6,6,9},3)
 anim("land",{6,9,10},3)
 anim("death",{10,12,12},5)
 anim("respawn",{12,1,1},4)
 anim("levelup",{3,6,1},3)
 local sp=E:clone_c("sprite")
 sp.prefix=prefix;sp.name="idle";sp.anchor=V.v(0.5,0.13)
 sp.scale=V.v(0.19,0.19);sp.angles={walk={"walk","walkUp","walkDown"}}
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
 a.animation="attack";a.fn_damage=hit
 a.vis_flags,a.vis_bans=F_BLOCK,bit.bor(F_FLYING,F_CLIFF)
 a.xp_gain_factor=0;a.sound="MeleeSword"
 t.melee.attacks[1]=a
 t.info.i18n_key="HERO_ALLIED_VOLIBEAR_PRESTIGE"
 t.info.portrait="info_portrait_volibear_prestige"
 t.info.hero_portrait="volibear_prestige_icon"
end
M.prepare=prepare
function M.register()
 C,E,A,V,bit=require("allied_boss_common"),require("entity_db"),require("animation_db"),require("klua.vector"),require("bit")
 local hero=C.create(M)
 for _,messages in pairs(require("i18n").msgs) do
  messages.HERO_ALLIED_VOLIBEAR_PRESTIGE_NAME=M.title
  messages.HERO_ALLIED_VOLIBEAR_PRESTIGE_DESCRIPTION=M.skill.description
 end
 return hero
end
function M.passive(hero,store)
 local state=C.state(hero,store)
 hero.melee.attacks[1].cooldown=store.tick_ts<(state.voli_ult_end or 0) and 0.62 or 1
end
function M.automatic(hero,store,targets)
 local enemy
 for _,target in ipairs(targets or {}) do
  if C.alive(target) and C.dist(hero.pos,target.pos)<=190 then enemy=target;break end
 end
 if not enemy then return false end
 local distance=C.dist(hero.pos,enemy.pos)
 hero.render.sprites[1].flip_x=enemy.pos.x<hero.pos.x
 if distance<=100 and C.ready(hero,store,"q",7) then
  C.stamp(hero,store,"q")
  if C.cast(hero,store,"q",0.35,"MeleeSword") and C.alive(enemy) then
   damage(hero,store,enemy,235,DAMAGE_PHYSICAL)
   C.area(store,hero,enemy.pos,20,0,0,DAMAGE_PHYSICAL,0.8,1,true)
  end
  return true
 end
 if distance<=95 and C.ready(hero,store,"w",9) then
  C.stamp(hero,store,"w")
  if C.cast(hero,store,"w",0.38,"MeleeSword") and C.alive(enemy) then
   damage(hero,store,enemy,270,DAMAGE_PHYSICAL)
   local state=C.state(hero,store)
   if state.voli_mark_id==enemy.id and store.tick_ts<(state.voli_mark_until or 0) then
    hero.health.hp=math.min(hero.health.hp_max,hero.health.hp+180)
   end
   state.voli_mark_id,state.voli_mark_until=enemy.id,store.tick_ts+12
  end
  return true
 end
 if distance<=190 and C.ready(hero,store,"e",12) then
  C.stamp(hero,store,"e")
  if C.cast(hero,store,"e",0.55) then
   C.area(store,hero,enemy.pos,95,180,260,DAMAGE_MAGICAL,nil,8,true)
   hero.health.hp=math.min(hero.health.hp_max,hero.health.hp+120)
  end
  return true
 end
 return false
end
function M.active(hero,store,pos)
 if C.dist(hero.pos,pos)>M.skill.range then return end
 pos=C.copy(pos)
 local previous=hero.vis.bans
 hero.vis.bans=bit.bor(previous,F_STUN)
 C.animate(hero,"jump",store,false)
 local completed=C.wait(hero,store,0.5,function() return hero.nav_rally.new end)
 hero.vis.bans=previous
 if not completed or hero.nav_rally.new or not C.alive(hero) then return end
 C.land(hero,pos)
 C.animate(hero,"land",store,false)
 C.area(store,hero,pos,140,420,560,DAMAGE_PHYSICAL,1,8,true)
 C.state(hero,store).voli_ult_end=store.tick_ts+8
 C.wait(hero,store,0.25)
end
return M
