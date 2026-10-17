local log = require("klua.log"):new("krfl_features")
local M = {}
M.REN = "hero_jade_ren"
M.RALLY8 = "hero_rally_8"
M.RALLY8_SIZE = 8
M.REN_START_XP = 26000
CAMPAIGN_VARIANT_HERO_RALLY_8 = M.RALLY8
local function is_vi()
local i18n = package.loaded["i18n"]
return not i18n or i18n.current_locale == "vi"
end
local function tr(vi, en)
return is_vi() and vi or en
end
M.variants = {
CAMPAIGN_VARIANT_REGULAR,
CAMPAIGN_VARIANT_SPELL_RAID,
CAMPAIGN_VARIANT_HERO_RALLY,
M.RALLY8,
CAMPAIGN_VARIANT_NOSTALGIC_CLASSIC
}
function M.variant_label(variant)
if variant == M.RALLY8 then
return "8 Hero"
end
end
local RULES = {
[CAMPAIGN_VARIANT_SPELL_RAID] = {
vi = {"Đột kích phép", "Không có hero.", "Chỉ dùng tháp và phép của bạn.", "Bộ phép chọn ở Chọn phép trên bản đồ."},
en = {"Spell Raid", "No heroes.", "Only your towers and spells.", "Pick spells in Spell selection on the map."}
},
[CAMPAIGN_VARIANT_HERO_RALLY] = {
vi = {"4 Hero", "Mang 4 hero cùng lúc: hàng trên của Bộ bài 4/8 Hero trong Phòng anh hùng.", "Không dùng phép.", "Chiêu cuối của hero tự tung khi hồi xong."},
en = {"4 Heroes", "Bring 4 heroes at once: top row of the 4/8 Hero deck in the Hero room.", "No spells.", "Hero ultimates cast automatically."}
},
[M.RALLY8] = {
vi = {"8 Hero", "Mang 8 hero cùng lúc: cả 8 ô của Bộ bài 4/8 Hero trong Phòng anh hùng.", "Không dùng phép.", "Chiêu cuối của hero tự tung khi hồi xong.", "Nặng máy hơn các chế độ khác."},
en = {"8 Heroes", "Bring 8 heroes at once: all 8 slots of the 4/8 Hero deck in the Hero room.", "No spells.", "Hero ultimates cast automatically.", "Heavier on performance."}
},
[CAMPAIGN_VARIANT_NOSTALGIC_CLASSIC] = {
vi = {"Cổ điển", "Chơi kiểu Kingdom Rush cũ: 1 hero.", "Chỉ tháp của KR1–3.", "Phép mặc định: thiên tai và tiếp viện.", "Tắt gian lận và triệu hồi thêm hero."},
en = {"Nostalgic", "Classic Kingdom Rush: 1 hero.", "Only KR1–3 towers.", "Default spells: cataclysm and reinforcements.", "Cheats and extra hero summons are off."}
}
}
function M.mode_rules(variant)
local r = RULES[variant]
if not r then
return nil
end
local lines = is_vi() and r.vi or r.en
local body = {}
for i = 2, #lines do
body[#body + 1] = "• " .. lines[i]
end
return lines[1], table.concat(body, "\n"), tr("Cách chơi", "How to play")
end
function M.game_variant(variant)
if variant == M.RALLY8 then
return CAMPAIGN_VARIANT_HERO_RALLY, M.RALLY8_SIZE
end
return variant, nil
end
function M.rally_size(store)
return store and store.krfl_rally_size or 4
end
local function hero_data()
return require("data.map_data").hero_data
end
function M.hero_index(name)
for i, hd in ipairs(hero_data()) do
if hd.name == name then
return i
end
end
end
function M.install_hero_list()
local map = require("data.map_data")
if not map._krfl_ren_version then
map._krfl_ren_version = true
local original_version = map.hero_game_ver
map.hero_game_ver = function(name) if name == M.REN then return 3 end;return original_version(name) end
end
local list = hero_data()
if not M.hero_index(M.REN) then
list[#list + 1] = {
name = M.REN,
portrait = 970,
thumb = 970,
icon = 970,
generation = 7,
available_level = 0,
starting_level = 10
}
end
M.ren_index = M.hero_index(M.REN)
end
function M.display_order(n)
local order = {}
if M.ren_index and M.ren_index <= n then
order[1] = M.ren_index
end
for i = 1, n do
if i ~= M.ren_index then
order[#order + 1] = i
end
end
return order
end
function M.display_pos(i)
if not M.ren_index then
return i
end
if i == M.ren_index then
return 1
elseif i < M.ren_index then
return i + 1
end
return i
end
M.default_rally_names = {
"hero_gerald",
"hero_alric",
"hero_elves_archer",
"hero_orc",
"hero_malik",
"hero_denas",
"hero_arivan",
"hero_magnus"
}
function M.ensure_rally_list(user_data)
if not user_data then
return
end
user_data.liuhui_hero = user_data.liuhui_hero or {}
local list = user_data.liuhui_hero.rallylist or {}
user_data.liuhui_hero.rallylist = list
for i = 1, M.RALLY8_SIZE do
if not list[i] or not hero_data()[list[i]] then
list[i] = M.hero_index(M.default_rally_names[i]) or i
end
end
return list
end
function M.rally_names(user_data, count)
local list = M.ensure_rally_list(user_data) or {}
local names = {}
for i = 1, count do
local hd = hero_data()[list[i]]
names[i] = hd and hd.name or M.default_rally_names[i]
end
return names
end
local function insert_rally_8(LU, store, names)
local V = require("klua.vector")
if store.main_heroes and #store.main_heroes >= M.RALLY8_SIZE then
store._campaign_heroes_initialized = true
return store.main_heroes
end
store._campaign_heroes_initialized = true
store._inserting_hero_rally = true
local exits = store.level.locations and store.level.locations.exits or {}
local first = exits[1] and exits[1].pos or V.v(512, 384)
local second = exits[2] and exits[2].pos or first
local heroes = {}
for pair = 0, M.RALLY8_SIZE / 2 - 1 do
local dy = (pair - 1.5) * 30
local h1, h2 = LU.insert_double_hero_return2(store, names[pair * 2 + 1], names[pair * 2 + 2],
V.v(first.x, first.y + dy), V.v(second.x, second.y + dy))
heroes[#heroes + 1] = h1
heroes[#heroes + 1] = h2
end
store._inserting_hero_rally = nil
store.main_heroes = heroes
store.main1_hero = heroes[1]
store.main_hero = heroes[2]
return heroes
end
local function hook_level_utils()
local LU = require("level_utils")
if LU._krfl_hooked then
return
end
LU._krfl_hooked = true
local raw_ensure = LU.ensure_hero_rally
LU.ensure_hero_rally = function(store)
if M.rally_size(store) ~= M.RALLY8_SIZE then
return raw_ensure(store)
end
if store.main_heroes and #store.main_heroes >= M.RALLY8_SIZE then
return store.main_heroes
end
if store.level.locked_hero then
return
end
local user_data = store.user_data or require("storage"):load_slot()
return insert_rally_8(LU, store, M.rally_names(user_data, M.RALLY8_SIZE))
end
end
local registering = false
function M.ensure_ren()
if registering then
return
end
local E = require("entity_db")
local A = require("animation_db")
if E.entities[M.REN] and A.db.jade_ren_idle then
return
end
registering = true
local ok, err = pcall(function()
require("jade_actors").install_ren()
end)
registering = false
if not ok then
log.error("could not register %s: %s", M.REN, tostring(err))
end
end
local function hook_entity_db()
local E = require("entity_db")
if E._krfl_hooked then
return
end
E._krfl_hooked = true
local raw_get, raw_create = E.get_template, E.create_entity
local function wants_ren(t)
return t == M.REN or t == "arrow_jade_ren"
end
E.get_template = function(self, t)
if wants_ren(t) then
M.ensure_ren()
end
return raw_get(self, t)
end
E.create_entity = function(self, t)
if wants_ren(t) then
M.ensure_ren()
end
return raw_create(self, t)
end
end
local SPRITE_ALIAS = {
power_button_icons_jade_ren="jade_ren_skill_ultimate",
portraits_power_hero_jade_ren="jade_ren_skill_ultimate",
pointer_hero_power_jade_ren="pointer_hero_power_0001",
pointer_power_jade_ren="pointer_hero_power_0001",
hero_room_portraits_small_thumb_hero_jade_ren_0001 = "jade_ren_ui_thumb",
hero_room_portraits_small_button_hero_jade_ren_0001 = "jade_ren_ui_thumb",
hero_room_portraits_big_hero_jade_ren_0001 = "jade_ren_ui_portrait",
hero_room_skill_icons_hero_jade_ren_0001 = "jade_ren_skill_multishot",
hero_room_skill_icons_hero_jade_ren_0002 = "jade_ren_skill_porcupine",
hero_room_skill_icons_hero_jade_ren_0003 = "jade_ren_skill_nimble_fencer",
hero_room_skill_icons_hero_jade_ren_0004 = "jade_ren_skill_double_strike",
hero_room_skill_icons_hero_jade_ren_0005 = "jade_ren_skill_ultimate"
}
local function hook_image_db()
local I = require("klove.image_db")
if I._krfl_hooked then
return
end
I._krfl_hooked = true
local raw_s = I.s
I.s = function(self, name, optional)
if type(name) == "string" and name:find("jade_ren",1,true) and not self.db_atlas.jade_ren_ui_portrait then
self:load_atlas(1, KR_PATH_GAME_TARGET .. "/assets/images/fullhd", "go_jade_ren_ui")
end
if name == "jade_sword_fx" or name == "jade_qi_fx" then require("jade_ren_skills").ensure_visuals(self) end
local source = name and SPRITE_ALIAS[name]
if source and not self.db_atlas[name] then
local frame = self.db_atlas[source]
if frame then
self.db_atlas[name] = frame
self.missing_sprites[name] = nil
return frame
end
end
return raw_s(self, name, optional)
end
end
local function hook_i18n()
if _G._krfl_i18n_hooked or type(_G._) ~= "function" then
return
end
_G._krfl_i18n_hooked = true
local raw = _G._
local prefix = "HERO_JADE_REN_"
_G._ = function(s, default)
local out = raw(s, default)
if type(s) == "string" and out == s and string.sub(s, 1, #prefix) == prefix then
local rest = string.sub(s, #prefix + 1)
if rest == "CLASS" then
return tr("KIẾM SƯ", "SWORDMASTER")
elseif rest == "NAME" then
return "Ren"
elseif rest == "DESCRIPTION" then
return tr("Kiếm sĩ hộ vệ rừng tre của Jade Empire (KR7).", "Bamboo forest swordsman of the Jade Empire (KR7).")
end
local sword_text = require("jade_ren_skills").text(rest, is_vi())
if sword_text then return sword_text end
local eridan = raw("HERO_ELVES_ARCHER_" .. rest, default)
if eridan ~= "HERO_ELVES_ARCHER_" .. rest then
return eridan
end
end
return out
end
end
local function ren_status()
return {
xp = M.REN_START_XP,
skills = {
double_strike = 0,
nimble_fencer = 0,
multishot = 0,
porcupine = 0,
ultimate = 0
}
}
end
local function hook_storage()
local storage = require("storage")
if storage._krfl_features_hooked then
return
end
storage._krfl_features_hooked = true
local raw_load = storage.load_slot
storage.load_slot = function(self, idx, force)
local data = raw_load(self, idx, force)
if type(data) == "table" then
if data.heroes and data.heroes.status and not data.heroes.status[M.REN] then
data.heroes.status[M.REN] = ren_status()
end
if data.liuhui_hero then
M.ensure_rally_list(data)
end
end
return data
end
end
function M.hero_textures(name)
if name == M.REN then
return {"go_jade_actors", "go_hero_elves_archer"}
end
end
function M.install()
if M.installed then
return
end
M.installed = true
KRFL_FEATURES = M
M.install_hero_list()
require("ren_music").install()
hook_level_utils()
hook_entity_db()
hook_image_db()
hook_i18n()
hook_storage()
log.info("KRFL features installed (Ren index %s)", tostring(M.ren_index))
end
return M
