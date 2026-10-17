local S=require('sound_db')
S.sounds.MusicBattlePrep_92=S.sounds.MusicBattlePrep_01
S.sounds.MusicBattle_92=S.sounds.MusicBattle_01
S.sound_extras.MusicBattlePrep_92=S.sound_extras.MusicBattlePrep_92 or {}
S.sound_extras.MusicBattle_92=S.sound_extras.MusicBattle_92 or {}
require('jade_actors').install()
local E=require('entity_db')
local LU=require('level_utils')
local V=require('klua.vector')
local signal=require('hump.signal')
local level={manual_hero_insertion=true}
function level:update(store)
    -- Entity DB is rebuilt after level metadata loads; register at simulation start.
    require('jade_actors').install(store.level_difficulty)
    store._campaign_heroes_initialized=true
    store.selected_hero='hero_jade_ren'
    local hero=E:create_entity('hero_jade_ren')
    hero.pos=V.vclone(self.custom_spawn_pos)
    hero.nav_rally.center=V.vclone(hero.pos);hero.nav_rally.pos=V.vclone(hero.pos)
    store.main_hero=hero
    LU.queue_insert(store,hero);signal.emit('hero-added',hero)
    while not store.waves_finished or LU.has_alive_enemies(store) do
        for _,enemy in pairs(store.entities) do
            if enemy.template_name=='enemy_jade_lion' and not enemy.jade_enraged and not enemy.health.dead and enemy.health.hp<=enemy.health.hp_max*.5 then
                enemy.jade_enraged=true;enemy.motion.max_speed=32
                enemy.melee.attacks[1].cooldown=1
                enemy.melee.attacks[1].damage_min=150;enemy.melee.attacks[1].damage_max=210
                enemy.health.armor=.3
            end
        end
        coroutine.yield()
    end
end
return level
