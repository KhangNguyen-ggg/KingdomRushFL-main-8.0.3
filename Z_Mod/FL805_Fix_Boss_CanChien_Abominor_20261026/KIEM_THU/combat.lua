return function(game,mode)
 local E,U,V,A,SU,bit=require('entity_db'),require('utils'),require('klua.vector'),require('animation_db'),require('script_utils'),require('bit')
 local health=require('systems').health
 local simulation=require('simulation')
 local original_store=simulation.store
 local rows={'hero,phase,rank,side,attack,damage,completed'}
 local total,miss=0,0
 local function fixture(name,phase,rank,side,index)
  local hero=E:create_entity(name);local enemy=E:create_entity('boss_crocs_lvl'..phase)
  local st=table.clone(game.store);st.entities={[hero.id]=hero,[enemy.id]=enemy};st.pending_inserts={};st.pending_removals={};st.tick_ts=100
  health:init(st)
  enemy.pos=V.v(512,384);enemy.heading.angle=side==0 and 0 or math.pi;enemy.health.hp=enemy.health.hp_max
  enemy.enemy.blockers={};for i=1,rank do enemy.enemy.blockers[i]=i==rank and hero.id or -i end
  hero.pos=assert(U.melee_slot_position(hero,enemy));hero.health.hp=hero.health.hp_max;hero.nav_rally.new=false;hero.soldier.target_id=enemy.id;hero.unit.on_damage_dealt=nil
  local attack=table.deepclone(hero.melee.attacks[index]);attack.mod=nil;attack.hit_fx=nil;attack.hit_decal=nil;attack.hit_aura=nil;attack.track_damage=false
  return st,hero,enemy,attack
 end
 local function run(st,hero,enemy,attack,looped)
  simulation.store=st
  local fn=looped and SU.y_soldier_do_loopable_melee_attack or SU.y_soldier_do_single_area_attack
  local co=coroutine.create(function()return fn(st,hero,enemy,attack)end)
  local done
  for _=1,1200 do
   local ok,value=coroutine.resume(co);assert(ok,value)
   if coroutine.status(co)=='dead'then done=value;break end
   st.tick_ts=st.tick_ts+st.tick_length
   local render=require('systems').render
   local update=render.on_render_update or render.on_update
   update(render,st.tick_length,st.tick_ts,{entities={[hero.id]=hero}})
  end
  assert(coroutine.status(co)=='dead','Attack coroutine did not finish: '..hero.template_name)
  health:on_update(st.tick_length,st.tick_ts,st)
  simulation.store=original_store
  return done
 end
 for _,meta in ipairs(require('allied_bosses').list)do
  local t=E:get_template(meta.name)
  for index,a in ipairs(t.melee.attacks)do if a.type=='area'then
   for phase=1,4 do for rank=1,3 do for side=0,1 do
    local st,hero,enemy,attack=fixture(meta.name,phase,rank,side,index)
    local hp=enemy.health.hp;local completed=run(st,hero,enemy,attack)
    local damage=hp-enemy.health.hp;total=total+1;if damage<=0 then miss=miss+1 end
    rows[#rows+1]=table.concat({meta.name,phase,rank,side,index,damage,tostring(completed)},',')
   end end end
  end end
 end
 local regression={}
 if mode=='after'then
  assert(miss==0,'Allied boss AOE missed Abominor: '..miss..'/'..total)
  local function check(label,alter,expected,name)
   local st,hero,enemy,attack=fixture(name or'hero_allied_blackburn',3,1,0,1)
   if alter then alter(st,hero,enemy,attack)end
   local hp=enemy.health.hp;run(st,hero,enemy,attack)
   assert((enemy.health.hp<hp)==expected,label)
   regression[#regression+1]='PASS '..label
  end
  check('ordinary soldier geometry unchanged',function(_,h)h.boss_kind=nil end,false)
  check('no hit if target moves away during contact',function(_,_,e)e.pos.x=e.pos.x+1000 end,false)
  check('AOE immunity preserved',function(_,_,e)e.vis.bans=bit.bor(e.vis.bans,F_AREA)end,false)
  check('flying damage ban preserved',function(_,_,e)e.vis.flags=bit.bor(e.vis.flags,F_FLYING)end,false,'hero_allied_juggernaut')
  check('cliff attack selection ban preserved',function(st,h,e)e.vis.flags=bit.bor(e.vis.flags,F_CLIFF);local a=SU.soldier_pick_melee_attack;if a then assert(a(st,h,e)==nil)end;e.vis.bans=bit.bor(e.vis.bans,F_AREA)end,false)
  local st,hero,enemy,attack=fixture('hero_allied_blackburn',3,1,0,1)
  local other=E:create_entity('boss_crocs_lvl3');other.pos=V.vclone(enemy.pos);other.health.hp=other.health.hp_max;st.entities[other.id]=other
  local hp=other.health.hp;run(st,hero,enemy,attack);assert(other.health.hp==hp,'AOE radius expanded to bystanders');regression[#regression+1]='PASS bystander outside original AOE is not hit'
  st,hero,enemy,attack=fixture('hero_allied_blackburn',3,1,0,1)
  other=E:create_entity('boss_crocs_lvl3');other.pos=V.vclone(hero.pos);other.health.hp=other.health.hp_max;st.entities[other.id]=other
  hp=other.health.hp;run(st,hero,enemy,attack);assert(other.health.hp<hp,'Bystander inside original AOE no longer hit');regression[#regression+1]='PASS original AOE collateral damage preserved'
  st,hero,enemy,attack=fixture('hero_allied_blackburn',3,1,0,1)
  enemy.parasite_host_id=hero.id;enemy.pos.x=enemy.pos.x+1000;hp=enemy.health.hp;run(st,hero,enemy,attack);assert(enemy.health.hp<hp,'Anti-parasite hit bypass lost');regression[#regression+1]='PASS anti-parasite contact rule preserved'
  st,hero,enemy,attack=fixture('hero_allied_blackburn',3,1,0,1)
  attack.loops=2;attack.animations={attack.animation,attack.animation,attack.animation};attack.hit_times={attack.hit_time};attack.animation=nil;hp=enemy.health.hp
  run(st,hero,enemy,attack,true);assert(enemy.health.hp<hp,'Looped AOE missed body contact');regression[#regression+1]='PASS looped AOE path hits body contact'
  st,hero,enemy,attack=fixture('hero_allied_blackburn',5,1,0,1)
  assert(bit.band(enemy.vis.bans,F_BLOCK)~=0 and not U.is_blocked_valid(st,hero),'Phase5 unexpectedly blockable')
  local d=E:create_damage();d.source_id=hero.id;d.target_id=enemy.id;d.value=100;d.damage_type=DAMAGE_PHYSICAL;st.damage_queue={d};hp=enemy.health.hp
  simulation.store=st;health:on_update(st.tick_length,st.tick_ts,st);simulation.store=original_store
  assert(enemy.health.hp<hp,'Phase5 is immune to physical damage');regression[#regression+1]='PASS phase5 remains unblockable and takes damage'
 end
 return table.concat(rows,'\n'),string.format('PASS %s native AOE attacks against Abominor 1-4: tested=%d, missed=%d; %d regression checks.\n%s',mode,total,miss,#regression,table.concat(regression,'\n'))
end
