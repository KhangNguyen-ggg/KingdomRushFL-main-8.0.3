local jade = {active=false, level_idx=92}
local V = require('klua.vector')
local G = love.graphics
local S = require('sound_db')
local storage = require('storage')
local F = require('klove.font_db')
local GS = require('game_settings')
if not GS._jade_stars_added then
    GS.max_stars=GS.max_stars+3
    GS._jade_stars_added=true
end
local function label(parent,text,x,y,w,h,size)
    local l=GGLabel:new(V.v(w,h))
    l.pos=V.v(x,y); l.text=text; l.font_name='body'; l.font_size=size or 24
    l.text_align='center'; l.fit_lines=3; l.colors.text={255,244,200,255}
    parent:add_child(l); return l
end
local function nav_button(parent,text,x,y,w,on_click)
    local b=GGButton:new('heroroom_btnDone_large_0001','heroroom_btnDone_large_0002')
    b.anchor=V.v(0,0);b.pos=V.v(x,y);b.scale=V.v(w/b.size.x,64/b.size.y)
    b.label.pos=V.v(15,14);b.label.size=V.v(b.size.x-30,40);b.label.text_size=b.label.size
    b.label.text=text;b.label.font_name='body_bold';b.label.font_size=22;b.label.fit_lines=1
    b.on_click=function(...) S:queue('GUIButtonCommon');on_click(...) end
    parent:add_child(b);return b
end
function jade:decorate_selector(button)
    button._jade_icon=true
    local original=button._draw_self
    function button:_draw_self()
        original(self)
        if not jade.icon then jade.icon=G.newImage('jade_empire/jade_campaign_icon.png') end
        G.setColor(255,255,255,255)
        G.draw(jade.icon,self.size.x/2-62,0,0,124/jade.icon:getWidth(),124/jade.icon:getHeight())
    end
end
function jade:install(map,w,h)
    -- The prototype uses a separate progression key, never aliases a campaign level.
    map.user_data.levels[self.level_idx]=map.user_data.levels[self.level_idx] or {}
    local status=map.user_data.heroes.status
    local ren=status.hero_jade_ren
    -- Migrate only the old demo allocation; preserve player-created builds.
    local skills=ren and ren.skills
    local old_demo=skills and ren.xp==28000 and skills.double_strike==3 and
        skills.nimble_fencer==3 and skills.multishot==0 and
        skills.porcupine==0 and skills.ultimate==0
    if not ren or old_demo then
        status.hero_jade_ren={xp=28000,skills={double_strike=3,nimble_fencer=3,
            multishot=3,porcupine=3,ultimate=3}}
    end
    storage:save_slot(map.user_data)
    S.sounds.MusicBattlePrep_92=S.sounds.MusicBattlePrep_01
    S.sounds.MusicBattle_92=S.sounds.MusicBattle_01
    S.sound_extras.MusicBattlePrep_92=S.sound_extras.MusicBattlePrep_92 or {}
    S.sound_extras.MusicBattle_92=S.sound_extras.MusicBattle_92 or {}
    local panel=KView:new(V.v(w,h-190))
    panel.hidden=true; panel.pos=V.v(0,0)
    function panel:_draw_self()
        if not jade.image then
            jade.image=G.newImage('jade_empire/bamboo_gate.png')
        end
        G.setColor(255,255,255,255)
        G.draw(jade.image,0,0,0,self.size.x/jade.image:getWidth(),self.size.y/jade.image:getHeight())
        G.setColor(9,27,19,210)
        G.rectangle('fill',0,0,self.size.x,145)
        G.rectangle('fill',self.size.x*0.57,175,self.size.x*0.39,self.size.y-210)
        G.setColor(255,255,255,255)
    end
    label(panel,'JADE EMPIRE',w*0.26,24,w*0.48,48,40)
    label(panel,'KR7 • Châu Á giả tưởng',w*0.26,80,w*0.48,45,24)
    map.jade_back=nav_button(panel,'Quay lại',20,24,190,function() jade:hide(map) end)
    map.jade_exit=nav_button(panel,'Menu chính',w-210,24,190,function()
        jade:hide(map);storage:save_slot(map.user_data)
        map.done_callback({next_item_name='slots'})
    end)
    local flag=GGButton:new('mapButtons-notxt_0017','mapButtons-notxt_0018')
    flag.pos=V.v(w*0.26,h*0.36)
    flag.label.pos=V.v(50,121); flag.label.size=V.v(126,30)
    flag.label.text_size=flag.label.size; flag.label.fit_lines=1
    flag.label.text='Màn 1'; flag.label.font_size=18
    jade:decorate_selector(flag)
    panel:add_child(flag)
    label(panel,'Bamboo Gate',w*0.57+10,190,w*0.39-20,46,32)
    label(panel,'Bảo vệ làng bên rừng tre.\n18 đợt quân tinh nhuệ, boss 2 giai đoạn.\n1.500 vàng khởi đầu • 20 mạng',w*0.59,255,w*0.35,140,24)
    local progress=map.user_data.levels[self.level_idx]
    label(panel,'Tiến độ: '..tostring(progress.stars or 0)..'/3 sao\nHero Ren • 4 loại địch mới • Celestial Lion',w*0.59,405,w*0.35,95,22)
    local play=GGButton:new('mapButtons-notxt_0017','mapButtons-notxt_0018')
    play.pos=V.v(w*0.7, h*0.57)
    play.label.pos=V.v(50,121); play.label.size=V.v(126,30)
    play.label.text_size=play.label.size; play.label.fit_lines=1
    play.label.text='Chơi'; play.label.font_size=20
    jade:decorate_selector(play)
    local function start()
        storage:save_slot(map.user_data)
        map.done_callback({next_item_name='game',level_idx=jade.level_idx,
            level_mode=GAME_MODE_CAMPAIGN,level_difficulty=map.user_data.difficulty,
            campaign_variant=CAMPAIGN_VARIANT_REGULAR})
    end
    flag.on_click=start; play.on_click=start
    panel:add_child(play)
    map.window:add_child(panel); map.jade_panel=panel
    if self.active then self:show(map) end
end
function jade:show(map)
    self.active=true
    if map.jade_panel then map.jade_panel.hidden=false end
    if map.map_view and map.map_view.flags_layer then map.map_view.flags_layer.hidden=true end
end
function jade:hide(map)
    local was_active=self.active or (map.jade_panel and not map.jade_panel.hidden)
    self.active=false
    if map.jade_panel then map.jade_panel.hidden=true end
    if map.map_view and map.map_view.flags_layer then map.map_view.flags_layer.hidden=false end
    if was_active and map.jade_refresh_switcher then map.jade_refresh_switcher() end
end
return jade
