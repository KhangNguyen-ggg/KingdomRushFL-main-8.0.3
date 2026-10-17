local M={}
local E=require('entity_db')
local V=require('klua.vector')
local bit=require('bit')
local function names(key,name,description)
    for _,strings in pairs(require('i18n').msgs) do
        strings[key..'_NAME']=name;strings[key..'_DESCRIPTION']=description
    end
end
local specs={
    {id='ronin',name='Crimson Ronin',hp={420,490,615,790},armor=.45,magic=0,speed=43,gold=30,damage={20,28},description='Kiếm khách giáp đỏ. Dùng phép và lính chặn để phá đội hình.'},
    {id='sentinel',name='Terracotta Sentinel',hp={1250,1500,1680,2100},armor=.8,magic=.1,speed=28,gold=70,damage={45,65},description='Tượng chiến binh đất nung có giáp nặng. Ưu tiên tháp phép.'},
    {id='runner',name='Shadow Runner',hp={450,560,700,900},armor=.1,magic=.6,speed=72,gold=35,damage={14,22},description='Địch nhanh, kháng phép cao. Chặn đường và dùng sát thương vật lý.'},
    {id='weaver',name='Spirit Weaver',hp={900,1100,1375,1750},armor=.05,magic=.7,speed=32,gold=65,damage={18,26},description='Pháp sư linh hồn tấn công từ xa bằng ngọc chú. Kháng phép cao.'},
    {id='lion',name='Celestial Lion',hp={24000,28000,35000,44000},armor=.55,magic=.35,speed=20,gold=400,damage={100,140},description='Boss sư tử ngọc. Dưới nửa máu sẽ cuồng nộ: chạy nhanh và đánh mạnh hơn. Lọt qua cổng sẽ mất toàn bộ 20 mạng.'}
}
local function install_animations()
    -- PC animation_db loads the bundled game_animations table. Register the
    -- additional animations explicitly after it rebuilds its database.
    local A=require('animation_db')
    local frames=assert(love.filesystem.load(KR_PATH_GAME..'/data/animations/jade_empire.lua'))()
    for key,value in pairs(frames) do A.db[key]=value;A.missing_animations[key]=nil end
end
M.install_animations=install_animations
function M.install(difficulty)
    install_animations()
    if not E.entities.enemy_jade_ronin then M.install_enemies(difficulty) end
    M.install_ren()
end
function M.install_enemies(difficulty)
    for _,s in ipairs(specs) do
        local t=E:register_t('enemy_jade_'..s.id,'enemy_gnoll_reaver')
        t.health.hp_max=s.hp[difficulty or 2];t.health.armor=s.armor;t.health.magic_armor=s.magic
        t.enemy.gold=s.gold;t.motion.max_speed=s.speed
        t.melee.attacks[1].damage_min=s.damage[1];t.melee.attacks[1].damage_max=s.damage[2]
        t.melee.attacks[1].cooldown=s.id=='runner' and .8 or s.id=='lion' and 1.5 or 1.2
        t.render.sprites[1].prefix='jade_'..s.id;t.render.sprites[1].anchor=V.v(.5,.1)
        local scale=s.id=='lion' and 1.15 or s.id=='sentinel' and .72 or .62
        t.render.sprites[1].scale=V.v(scale,scale)
        t.render.sprites[1].angles.walk={'walkingRightLeft','walkingUp','walkingDown'}
        t.health_bar.offset=V.v(0,s.id=='lion' and 108 or s.id=='sentinel' and 66 or 57)
        t.unit.hit_offset=V.v(0,s.id=='lion' and 50 or 26);t.unit.mod_offset=V.v(0,s.id=='lion' and 50 or 26)
        t.ui.click_rect=V.r(-24,0,48,s.id=='lion' and 100 or 60)
        t.info.portrait='jade_'..s.id..'_portrait';t.info.i18n_key='ENEMY_JADE_'..s.id:upper()
        names(t.info.i18n_key,s.name,s.description)
        if s.id=='weaver' then
            E:add_comps(t,'ranged')
            local a=t.ranged.attacks[1]
            a.bullet='bolt_jade_weaver';a.hold_advance=true;a.shoot_time=7/FPS
            a.cooldown=3.5;a.max_range=180;a.min_range=40;a.bullet_start_offset={V.v(0,38)}
            a.vis_flags=F_RANGED;a.vis_bans=F_FLYING
        elseif s.id=='lion' then
            t.enemy.lives_cost=20;t.vis.flags=bit.bor(t.vis.flags,F_BOSS)
            t.health.immune_to=bit.bor(DAMAGE_INSTAKILL,DAMAGE_EAT)
            t.unit.size=UNIT_SIZE_LARGE;t.health_bar.type=HEALTH_BAR_SIZE_LARGE
        end
    end
    local bolt=E:register_t('bolt_jade_weaver','bullet_gnoll_blighter')
    bolt.bullet.damage_min=42;bolt.bullet.damage_max=62;bolt.bullet.damage_type=DAMAGE_MAGICAL
end
-- KRFL v0.0.6: Ren can be picked in the hero room and used in every level, so
-- his templates are registered on demand and safely more than once.
function M.install_ren()
    install_animations()
    if E.entities.hero_jade_ren then require('jade_ren_skills').install(E.entities.hero_jade_ren);return E.entities.hero_jade_ren end
    if not E.entities.arrow_jade_ren then E:register_t('arrow_jade_ren','arrow_hero_elves_archer') end
    local hero=E:register_t('hero_jade_ren','hero_elves_archer')
    hero.info.i18n_key='HERO_JADE_REN'
    names('HERO_JADE_REN','Ren','Ren - sản phẩm được truyền nhân Đạt Văn Tây nhào nặng :))')
    hero.info.hero_portrait='jade_ren_ui_hud';hero.info.portrait='jade_ren_ui_thumb'
    hero.render.sprites[1].prefix='jade_ren';hero.render.sprites[1].anchor=V.v(.5,.1)
    hero.render.sprites[1].scale=V.v(.62,.62)
    hero.health_bar.offset=V.v(0,58);hero.unit.hit_offset=V.v(0,27)
    hero.ranged.attacks[1].bullet='arrow_jade_ren';hero.motion.max_speed=95
    hero.hero.level=10;hero.hero.xp=28000
    hero.hero.skills.double_strike.level=3;hero.hero.skills.nimble_fencer.level=3
    hero.hero.skills.multishot.level=3;hero.hero.skills.porcupine.level=3;hero.hero.skills.ultimate.level=3
    local original=hero.hero.fn_level_up
    hero.hero.fn_level_up=function(this,store,initial)
        original(this,store,initial)
        this.hero.level=10;this.health.hp_max=1000;this.health.hp=1000;this.health.armor=.4
        this.regen.health=40;this.melee.attacks[1].damage_min=100;this.melee.attacks[1].damage_max=150
        this.melee.attacks[2].damage_min=300;this.melee.attacks[2].damage_max=420;this.melee.attacks[2].cooldown=5
        this.dodge.chance=({.1,.3,.6})[math.max(1,this.hero.skills.nimble_fencer.level)]
        local b=E:get_template('arrow_jade_ren');b.bullet.damage_min=85;b.bullet.damage_max=120
    end
    require('jade_ren_skills').install(hero)
    return hero
end
return M
