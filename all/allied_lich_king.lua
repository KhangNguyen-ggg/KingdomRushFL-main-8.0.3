-- Appearance-first Lich King; combat and summons reuse the allied Blackburn foundation.
local C,E,A,U,V
local M={name="hero_allied_lich_king",kind="lich_king",title="Lich King",source="eb_blackburn",
 icon="encyclopedia_creep_thumbs_lich_king",custom_portrait=true,hero_class="Lãnh chúa băng giá",
 can_attack_air=true,textures={"go_stage70","go_enemies_common","go_lich_king","ui_lich_king"},sounds={"BlackburnSounds"}}
M.skill={label="Đạp",cooldown=5,range=284,
 description="Lich King — bản ngoại hình đầu tiên. Giáp đen xanh, mũ sừng, áo choàng và kiếm băng theo ảnh mẫu. Dùng chỉ số Blackburn gốc; chém diện rộng và đánh được mục tiêu bay. Giậm đất gây choáng 4 giây, tự gọi tối đa 15 Skeleton Knight từ xác địch. Chưa thêm bộ kỹ năng băng riêng."}
local function prepare(t)
 local prefix=t.render.sprites[1].prefix
 local function animation(name,frames,repeats)
  local list={}
  for _,frame in ipairs(frames) do for n=1,repeats or 1 do list[#list+1]=frame end end
  A.db[prefix.."_"..name]={prefix="lich_king",frames=list}
 end
 animation("idle",{1,2,3,4,3,2},6)
 for _,name in ipairs({"walk","walkUp","walkDown"}) do animation(name,{5,6,7,8},4) end
 local attack=t.melee.attacks[1]
 local hit=math.max(2,math.floor(attack.hit_time*FPS+0.5));local frames={}
 for n=1,hit do frames[#frames+1]=n<=hit/2 and 9 or 10 end
 for _,frame in ipairs({11,12}) do for n=1,6 do frames[#frames+1]=frame end end
 A.db[prefix.."_attack"]={prefix="lich_king",frames=frames}
 local impact=math.max(2,math.floor(E:get_template(M.source).timed_attacks.list[1].hit_time*FPS+0.5));frames={}
 for n=1,impact do frames[#frames+1]=n<=impact/2 and 13 or 14 end
 for _,frame in ipairs({15,16}) do for n=1,6 do frames[#frames+1]=frame end end
 A.db[prefix.."_stomp"]={prefix="lich_king",frames=frames}
 animation("death",{17,18,19,20},7)
 animation("respawn",{21,22,23,24},5)
 animation("levelup",{1,2,3,4},3)
 local sp=E:clone_c("sprite");sp.prefix=prefix;sp.name="idle";sp.anchor=V.v(0.5,0.15);sp.scale=V.v(0.7,0.7)
 sp.angles={walk={"walk","walkUp","walkDown"}};t.render.sprites={sp}
 t.health_bar.offset=V.v(0,103)
 t.ui.click_rect={pos=V.v(-37,0),size=V.v(74,100)}
 t.unit.hit_offset,t.unit.mod_offset,t.unit.marker_offset=V.v(0,47),V.v(0,47),V.v(0,0)
 t.motion.max_speed=60;t.regen.health=90
 t.info.i18n_key="HERO_ALLIED_LICH_KING";t.info.portrait="info_portrait_lich_king";t.info.hero_portrait="info_portrait_lich_king"
 attack.animation="attack";attack.sound_hit="EnemyBlackburnBossSwing"
end
M.prepare=prepare
function M.active_radius(native) return native.timed_attacks.list[1].damage_radius end
function M.passive(this,store) C.raise(this,store,"enemy_skeleton_big",106.383,0.5,15) end
function M.active(this,store)
 local a=C.native(this).timed_attacks.list[1]
 U.animation_start(this,"stomp",nil,store.tick_ts,1)
 require("sound_db"):queue(a.sound,a.sound_args)
 if C.wait(this,store,a.hit_time,function() return this.nav_rally.new end) and not this.nav_rally.new then
  C.area(store,this,this.pos,a.damage_radius,a.damage_min,a.damage_max,a.damage_type,4,nil,false)
  C.visual(a.fx,this.pos,store,1);C.visual(a.hit_decal,this.pos,store,2)
  C.wait(this,store,0.4,function() return this.nav_rally.new end)
 end
end
function M.register()
 C=require("allied_boss_common");E=require("entity_db");A=require("animation_db");U=require("utils");V=require("klua.vector")
 local t=C.create(M)
 for _,msgs in pairs(require("i18n").msgs) do
  msgs.HERO_ALLIED_LICH_KING_NAME="Lich King";msgs.HERO_ALLIED_LICH_KING_CLASS="Lãnh chúa băng giá"
 end
 return t
end
return M
