-- Ren's own sword effects and skills; all templates are isolated from Eridan.
local M = {}
local E = require('entity_db')
local V = require('klua.vector')
local U = require('utils')
local SU = require('script_utils')
local function insert(store, e) require('simulation'):queue_insert_entity(e) end
local function remove(store, e) require('simulation'):queue_remove_entity(e) end

function M.ensure_visuals(I)
    local G = love.graphics
    if I.db_atlas.jade_sword_fx and I.db_atlas.jade_qi_fx then return end
    local old_canvas = G.getCanvas()
    local old_width = G.getLineWidth()
    local old_shader = G.getShader()
    G.setShader()
    local red,green,blue,alpha = G.getColor()
    G.push()
    for _, name in ipairs({'jade_sword_fx','jade_qi_fx'}) do
        local canvas = G.newCanvas(64,64)
        G.setCanvas(canvas);G.clear(0,0,0,0);G.origin()
        if name == 'jade_sword_fx' then
            G.setColor(40,210,185,90);G.polygon('fill',5,20,55,24,63,32,55,40,5,44,18,32)
            G.setColor(20,73,65,255);G.polygon('fill',19,25,51,25,61,32,51,39,19,39)
            G.setColor(213,245,237,255);G.polygon('fill',22,27,50,27,59,32,50,37,22,37)
            G.setColor(255,255,255,255);G.line(24,31,55,31)
            G.setColor(225,173,66,255);G.rectangle('fill',17,23,5,18)
            G.setColor(46,87,77,255);G.rectangle('fill',6,29,11,6)
            G.setColor(226,176,65,255);G.circle('fill',6,32,3)
        else
            local points={}
            for i=0,16 do
                local a=-1.4+i*2.8/16
                points[#points+1]=20+36*math.cos(a);points[#points+1]=32+29*math.sin(a)
            end
            for i=16,0,-1 do
                local a=-1.4+i*2.8/16
                points[#points+1]=19+22*math.cos(a);points[#points+1]=32+27*math.sin(a)
            end
            G.setColor(63,226,185,170);G.polygon('fill',unpack(points))
            G.setColor(218,255,236,255);G.setLineWidth(2)
            for i=0,15 do
                local a=-1.4+i*2.8/16;local b=-1.4+(i+1)*2.8/16
                G.line(20+36*math.cos(a),32+29*math.sin(a),20+36*math.cos(b),32+29*math.sin(b))
            end
        end
        G.setCanvas(old_canvas)
        I:add_image(name,canvas,'jade_ren_effects',1)
    end
    G.pop();G.setColor(red,green,blue,alpha);G.setLineWidth(old_width);G.setShader(old_shader)
end

local function hit(store,this,pos)
    local b=this.bullet
    if b.damage_max<=0 then return end
    local targets=U.find_targets_in_range(store.entities,pos,0,b.damage_radius or 24,F_AREA,F_FRIEND)
    if targets then
        for _,target in pairs(targets) do
            local d=E:create_damage()
            d.damage_type=b.damage_type or DAMAGE_PHYSICAL
            d.value=math.random(math.floor(b.damage_min),math.floor(b.damage_max))
            d.source_id=b.source_id or this.id;d.target_id=target.id
            d.combat_stats_source_id=b.source_id
            local source=b.source_id and store.entities[b.source_id]
            d.combat_stats_source_template=source and source.template_name or 'hero_jade_ren'
            store.damage_queue[#store.damage_queue+1]=d
        end
    end
end

function M.projectile_insert(this,store)
    -- Our ground-directed swords have no target_id. The inherited arrow insert
    -- rejects them, so use an insert handler that accepts an explicit position.
    M.ensure_visuals(require('klove.image_db'))
    local target=this.bullet.target_id and store.entities[this.bullet.target_id]
    if not this.bullet.to and target then this.bullet.to=V.vclone(target.pos) end
    this.render.sprites[1].hidden=false
    return this.bullet.to~=nil
end

function M.projectile(this,store)
    M.ensure_visuals(require('klove.image_db'))
    local b=this.bullet;local born=store.tick_ts
    while store.tick_ts-born<2 do
        local target=b.target_id and store.entities[b.target_id]
        if target and target.health and not target.health.dead then
            b.to=V.v(target.pos.x,target.pos.y+(target.unit.hit_offset.y or 0))
        end
        if not b.to then break end
        local dx,dy=b.to.x-this.pos.x,b.to.y-this.pos.y
        local distance=math.sqrt(dx*dx+dy*dy)
        local step=(b.max_speed or 520)*store.tick_length
        this.render.sprites[1].r=math.atan2(dy,dx)
        if distance<=step then
            this.pos=V.vclone(b.to)
            hit(store,this,target and target.pos or this.pos)
            break
        end
        this.pos.x=this.pos.x+step*dx/distance;this.pos.y=this.pos.y+step*dy/distance
        coroutine.yield()
    end
    remove(store,this)
end

function M.orbit(this,store)
    M.ensure_visuals(require('klove.image_db'))
    local born=store.tick_ts;local next_hit=born
    while store.tick_ts-born<(this.duration or 6) do
        local hero=store.entities[this.source_id]
        if not hero or hero.health.dead then break end
        this.pos=V.v(hero.pos.x,hero.pos.y+25)
        local angle=(store.tick_ts-born)*3.4
        for i,s in ipairs(this.render.sprites) do
            local a=angle+(i-1)*math.pi*2/3
            s.offset=V.v(48*math.cos(a),24*math.sin(a));s.r=a+math.pi/2
        end
        if store.tick_ts>=next_hit and not hero.unit.is_stunned then
            this.bullet.source_id=hero.id
            hit(store,this,hero.pos);next_hit=store.tick_ts+.75
        end
        coroutine.yield()
    end
    remove(store,this)
end

function M.ultimate(this,store)
    M.ensure_visuals(require('klove.image_db'))
    local source=store.entities[this.source_id]
    if source then
        source._ren_manual_cd=source._ren_manual_cd or {}
        if not this.manual_cast and (source._ren_manual_cd[5] or 0)>store.tick_ts then remove(store,this);return end
        source._ren_manual_cd[5]=store.tick_ts+35
    end
    local level=math.max(0,math.min(3,this.level or 0))
    local count=({[0]=12,18,24,30})[level]
    local damage=({[0]=90,120,165,210})[level]
    -- Fixed upper bound: 30 swords rather than hundreds of entities.
    for i=1,count do
        local angle=i*2.399963
        local radius=math.sqrt(i/count)*105
        local x=this.pos.x+math.cos(angle)*radius
        local y=this.pos.y+math.sin(angle)*radius*.65
        local b=E:create_entity('jade_ren_ultimate_blade')
        b.bullet.to=V.v(x,y);b.pos=V.v(x+math.cos(angle)*70,y+220)
        b.bullet.from=V.vclone(b.pos);b.bullet.source_id=this.source_id
        b.bullet.damage_min=damage;b.bullet.damage_max=damage
        insert(store,b);U.y_wait(store,.055)
    end
    remove(store,this)
end

function M.hero_update(this,store)
    -- Retain the engine's path finding, death/respawn and interrupt handling.
    local original=require('game_scripts').hero_elves_archer.update
    local co=coroutine.create(original)
    local last_twin,last_basic=0,0;local orbit_at=store.tick_ts+1
    while coroutine.status(co)~='dead' do
        local ok,err=coroutine.resume(co,this,store)
        if not ok then error(err) end
        if not this.health.dead and not this.unit.is_stunned then
            if this._ren_dodge_until and store.tick_ts>=this._ren_dodge_until then
                this.dodge.chance=this._ren_dodge_chance;this._ren_dodge_until=nil
            end
            local basic=this.melee.attacks[1]
            if basic.ts and basic.ts>last_basic then
                last_basic=basic.ts
                local target=SU.soldier_pick_melee_target(store,this)
                if target then
                    -- Visible blade for a melee swing. The melee attack already
                    -- applies damage; this flight must not add a second hit.
                    local blade=E:create_entity('arrow_jade_ren')
                    blade.pos=V.v(this.pos.x,this.pos.y+22)
                    blade.bullet.from=V.vclone(blade.pos)
                    local angle=math.atan2(target.pos.y-this.pos.y,target.pos.x-this.pos.x)
                    blade.bullet.to=V.v(this.pos.x+math.cos(angle)*105,this.pos.y+math.sin(angle)*105+22)
                    blade.bullet.damage_min=0;blade.bullet.damage_max=0
                    blade.bullet.source_id=this.id;blade.bullet.max_speed=260
                    insert(store,blade)
                end
            end
            local skill=this.hero.skills.porcupine
            orbit_at=math.max(orbit_at,this._ren_manual_cd and this._ren_manual_cd[2] or 0)
            if skill.level>0 and store.tick_ts>=orbit_at then
                local targets=U.find_targets_in_range(store.entities,this.pos,0,120,F_AREA,F_FRIEND)
                if targets and #targets>0 then
                    local e=E:create_entity('jade_ren_orbit');e.source_id=this.id
                    e.bullet.damage_min=20+skill.level*15;e.bullet.damage_max=35+skill.level*20
                    insert(store,e);orbit_at=store.tick_ts+14
                    this._ren_manual_cd=this._ren_manual_cd or {};this._ren_manual_cd[2]=orbit_at
                end
            end
            local a=this.melee.attacks[2]
            if not a.disabled and a.ts and a.ts>last_twin then
                last_twin=a.ts
                local targets=U.find_targets_in_range(store.entities,this.pos,0,100,F_AREA,F_FRIEND)
                if targets and targets[1] then
                    local target=targets[1]
                    local direction=math.atan2(target.pos.y-this.pos.y,target.pos.x-this.pos.x)
                    for j=-1,1 do
                        local b=E:create_entity('qi_jade_ren')
                        b.pos=V.v(this.pos.x,this.pos.y+22)
                        b.bullet.from=V.vclone(b.pos)
                        local angle=direction+j*.28
                        b.bullet.to=V.v(this.pos.x+math.cos(angle)*115,this.pos.y+math.sin(angle)*115)
                        b.bullet.source_id=this.id;b.bullet.damage_min=40;b.bullet.damage_max=70
                        insert(store,b)
                    end
                end
            end
        end
        coroutine.yield()
    end
end

M.manual_keys={'multishot','porcupine','nimble_fencer','double_strike','ultimate'}
M.manual_icons={'jade_ren_skill_multishot','jade_ren_skill_porcupine','jade_ren_skill_nimble_fencer','jade_ren_skill_double_strike','jade_ren_skill_ultimate'}
M.manual_names={'Tịch Tà','Tam Kiếm','Lăng Ba','Tố Tâm','Vạn Kiếm'}
M.manual_cooldowns={12,14,18,5,35}
function M.cast(hero,store,index)
    local key=M.manual_keys[index]
    if not key or not hero or hero.health.dead or hero.unit.is_stunned then return false end
    local skill=hero.hero.skills[key]
    if not skill or skill.level<=0 then return false end
    hero._ren_manual_cd=hero._ren_manual_cd or {}
    if (hero._ren_manual_cd[index] or 0)>store.tick_ts then return false end
    hero._ren_manual_cd[index]=store.tick_ts+M.manual_cooldowns[index]
    if index==1 then hero.ranged.attacks[2].ts=store.tick_ts end
    if index==4 then hero.melee.attacks[2].ts=store.tick_ts end
    local targets=U.find_targets_in_range(store.entities,hero.pos,0,260,F_AREA,F_FRIEND)
    local target=targets and targets[1]
    local distance=target and math.sqrt((target.pos.x-hero.pos.x)^2+(target.pos.y-hero.pos.y)^2) or 180
    local direction=target and math.atan2(target.pos.y-hero.pos.y,target.pos.x-hero.pos.x) or 0
    if index==5 then
        local e=E:create_entity('hero_jade_ren_ultimate')
        e.source_id=hero.id;e.owner=hero;e.level=skill.level;e.manual_cast=true
        e.pos=target and V.vclone(target.pos) or V.vclone(hero.pos)
        insert(store,e)
    elseif index==2 or index==3 then
        local e=E:create_entity('jade_ren_orbit');e.source_id=hero.id
        e.bullet.damage_min=index==2 and 20+skill.level*15 or 0
        e.bullet.damage_max=index==2 and 35+skill.level*20 or 0
        e.duration=index==3 and 3 or 6;insert(store,e)
        if index==3 then
            hero._ren_dodge_until=store.tick_ts+3
            hero._ren_dodge_chance=hero.dodge.chance;hero.dodge.chance=1
        end
    else
        local count=index==1 and ({3,5,7})[skill.level] or 3
        for j=1,count do
            local b=E:create_entity('qi_jade_ren')
            b.pos=V.v(hero.pos.x,hero.pos.y+22);b.bullet.from=V.vclone(b.pos)
            local angle=direction+(j-(count+1)/2)*.14
            b.bullet.to=V.v(hero.pos.x+math.cos(angle)*distance,hero.pos.y+22+math.sin(angle)*distance)
            b.bullet.source_id=hero.id;b.bullet.damage_min=85;b.bullet.damage_max=120
            insert(store,b)
        end
    end
    return true
end

function M.update_hud(gui)
    local store=gui.game and gui.game.store
    if not store or not gui.hud_bottom then return end
    require("ren_music").sync_battle(store)
    local hero=gui.selected_entity
    if not hero or hero.template_name~='hero_jade_ren' then
        hero=nil
        for _,h in pairs(store.entities) do
            if h.template_name=='hero_jade_ren' and h.hero and not h.health.dead then hero=h;break end
        end
    end
    if not hero then if gui._ren_bar then gui._ren_bar.hidden=true end;return end
    if not gui._ren_bar then
        local bar=KView:new(V.v(325,78));bar.pos=V.v(150,gui.layer_gui_hud.size.y-145)
        gui.hud_bottom:add_child(bar);gui._ren_bar=bar;bar.buttons={}
        for i=1,5 do
            local index=i
            local b=KImageButton:new(M.manual_icons[i]);b.pos=V.v((i-1)*65,0)
            b.scale=V.v(54/b.size.x,54/b.size.y)
            b.on_click=function() M.cast(gui._ren_hud_hero,gui.game.store,index) end
            bar:add_child(b);bar.buttons[i]=b
            local l=GGLabel:new(V.v(64,24));l.pos=V.v((i-1)*65,56)
            l.font_name='body';l.font_size=11;l.text_align='center';l.colors.text={255,244,200,255}
            bar:add_child(l);b._ren_label=l
        end
    end
    gui._ren_hud_hero=hero;gui._ren_bar.hidden=false
    for i,b in ipairs(gui._ren_bar.buttons) do
        local skill=hero.hero.skills[M.manual_keys[i]]
        local left=math.max(0,math.ceil((hero._ren_manual_cd and hero._ren_manual_cd[i] or 0)-store.tick_ts))
        b._ren_label.text=skill.level<=0 and 'Chưa nâng' or left>0 and tostring(left)..'s' or M.manual_names[i]
        b.alpha=(skill.level<=0 or left>0 or hero.health.dead or hero.unit.is_stunned) and .45 or 1
    end
end

function M.install(hero)
    local animation=require('animation_db')
    for _,name in ipairs({'double_strike','nimble_fencer','shoot_end'}) do
        if not animation.db['jade_ren_'..name] then
            animation.db['jade_ren_'..name]=animation.db.jade_ren_attack or animation.db.jade_ren_shoot
        end
    end
    if hero._krfl_swords_installed then return end
    hero._krfl_swords_installed = true
    local blade=E.entities.arrow_jade_ren
    blade.main_script.insert=M.projectile_insert
    blade.main_script.update=M.projectile
    blade.render.sprites[1].name='jade_sword_fx';blade.render.sprites[1].animated=false
    blade.render.sprites[1].anchor=V.v(.5,.5);blade.render.sprites[1].scale=V.v(1.15,1.15)
    blade.bullet.damage_radius=24;blade.bullet.max_speed=360
    blade.bullet.hit_fx=nil;blade.bullet.miss_decal=nil;blade.bullet.pop=nil
    local qi=E:register_t('qi_jade_ren','arrow_jade_ren')
    qi.render.sprites[1].name='jade_qi_fx';qi.render.sprites[1].scale=V.v(1.15,1.15)
    qi.bullet.max_speed=320;qi.bullet.damage_radius=38
    qi.bullet.damage_min=85;qi.bullet.damage_max=120
    local ultimate_blade=E:register_t('jade_ren_ultimate_blade','arrow_jade_ren')
    ultimate_blade.render.sprites[1].name='jade_sword_fx'
    ultimate_blade.render.sprites[1].scale=V.v(.75,.75)
    ultimate_blade.bullet.damage_radius=28;ultimate_blade.bullet.max_speed=700
    local orbit=E:register_t('jade_ren_orbit')
    E:add_comps(orbit,'pos','render','main_script','bullet')
    orbit.main_script.update=M.orbit;orbit.bullet.damage_radius=65
    for i=1,3 do
        orbit.render.sprites[i]=E:clone_c('sprite')
        local s=orbit.render.sprites[i];s.name='jade_sword_fx';s.animated=false;s.anchor=V.v(.5,.5);s.scale=V.v(.65,.65)
    end
    local ult=E:register_t('hero_jade_ren_ultimate','hero_elves_archer_ultimate')
    ult.main_script.update=M.ultimate;ult.cooldown=35
    ult.can_fire_fn=function(_,x,y) return type(x)=='number' and type(y)=='number' end
    hero.hero.skills.ultimate.controller_name='hero_jade_ren_ultimate'
    hero.info.ultimate_icon='jade_ren'
    hero.main_script.update=M.hero_update
    hero.ranged.attacks[2].bullet='qi_jade_ren'
    hero.hero.skills.multishot.loops={3,5,7}
    hero.hero.skills.porcupine.damage_inc={0,0,0}
    hero.hero.skills.double_strike.damage_min={150,220,300}
    hero.hero.skills.double_strike.damage_max={210,310,420}
end
function M.text(rest,vi)
    local titles={VOLLEY='Tịch Tà Kiếm Pháp',PORCUPINE='Tam Kiếm Hợp Nhất',NIMBLE='Lăng Ba Vi Bộ',DOUBLE='Tố Tâm Kiếm Pháp',HAIL='Vạn Kiếm Qui Tông'}
    local key=rest:match('^(%u+)_TITLE$') or rest:match('^(%u+)_MENUBOTTOM_NAME$')
    if key and titles[key] then return titles[key] end
    if rest=='HAIL_MENUBOTTOM_DESCRIPTION' then
        return vi and 'Vạn Kiếm Qui Tông: mưa kiếm đánh vào vùng chọn.' or 'Falling swords strike the selected area.'
    end
    local skill,rank=rest:match('^(%u+)_DESCRIPTION_(%d)$')
    local n=tonumber(rank)
    if not n or n<1 or n>3 or not titles[skill] then return end
    local texts
    if vi then
        texts={
            VOLLEY='Tung '..({3,5,7})[n]..' kiếm khí liên tiếp. Mỗi kiếm gây 85–120 sát thương vật lý trong vùng nhỏ.',
            PORCUPINE='Gọi 3 kiếm xoay quanh Ren trong 6 giây, gây '..(20+n*15)..'–'..(35+n*20)..' sát thương mỗi nhịp 0,75 giây. Hồi chiêu: 14 giây.',
            NIMBLE='Có '..({10,30,60})[n]..'% cơ hội né và phản đòn cận chiến.',
            DOUBLE='Song kiếm gây 300–420 sát thương và tung 3 kiếm khí, mỗi luồng gây 40–70 sát thương. Hồi chiêu: 5 giây.',
            HAIL='Vạn Kiếm Qui Tông: gọi '..({18,24,30})[n]..' kiếm rơi vào vùng chọn, mỗi kiếm gây '..({120,165,210})[n]..' sát thương vật lý. Hồi chiêu: 35 giây.'
        }
    else
        texts={
            VOLLEY='Fires '..({3,5,7})[n]..' sword-qi projectiles dealing 85–120 physical area damage each.',
            PORCUPINE='Three swords orbit Ren for 6 seconds, dealing '..(20+n*15)..'–'..(35+n*20)..' physical damage every 0.75 seconds. Cooldown: 14 seconds.',
            NIMBLE=({10,30,60})[n]..'% chance to dodge and counter melee attacks.',
            DOUBLE='Twin swords deal 300–420 damage and release three 40–70 damage qi waves. Cooldown: 5 seconds.',
            HAIL='Calls '..({18,24,30})[n]..' falling swords, dealing '..({120,165,210})[n]..' physical area damage each. Cooldown: 35 seconds.'
        }
    end
    return texts[skill]
end
return M
