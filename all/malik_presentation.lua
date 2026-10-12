-- Malik's dialogue and visual timing, shared by the enemy and playable form.
local E = require("entity_db")
local A = require("animation_db")
local V = require("klua.vector")
local I = require("klove.image_db")
local i18n = require("i18n")
local M = {}

local vietnamese = {
	INTRO = {"Ta rất mừng vì ngươi đã nhận lời thách đấu...", "Sự ngạo mạn sẽ khiến ngươi phải trả giá!"},
	BATTLE = {"Ngươi trông chẳng khác nào một cái đinh!", "Ngươi đã lọt giữa búa và đe!", "Ngươi nghĩ ta đang đùa sao?", "Vì sức mạnh và danh dự!", "Ta ở đây, và sẽ không lùi bước!"},
	PRE_FIGHT = {"Đủ rồi! Ta nắm giữ Búa Thời Đại!", "Ta sẽ dùng nó để kết liễu ngươi!"},
	END = {"Ngươi đã chiến đấu rất kiên cường, nhưng...", "phía trước vẫn còn nhiều thử thách đang chờ ngươi."}
}

local function insert(e) require("simulation"):queue_insert_entity(e) end
local function remove(e) require("simulation"):queue_remove_entity(e) end

function M.finish(this, store)
	local ending = store.tick_ts
	for _, s in ipairs(this.render.sprites) do
		if s.animated and not s.ignore_start then
			local name = s.prefix and s.prefix .. "_" .. s.name or s.name
			ending = math.max(ending, s.ts + (A:duration(name) or 0))
		end
	end
	while store.tick_ts < ending do
		if this.health and this.health.dead or this.unit and this.unit.is_stunned then return false end
		coroutine.yield()
	end
	return not (this.health and this.health.dead or this.unit and this.unit.is_stunned)
end

function M.fx(store, name, pos)
	local e = E:create_entity(name)
	e.pos = V.vclone(pos)
	for _, s in ipairs(e.render.sprites) do s.ts = store.tick_ts; s.loop = false end
	insert(e)
	return e
end

function M.tower_impact(store, pos)
	M.fx(store, "fx_branch_malik_tower_ray", pos)
	M.fx(store, "fx_branch_malik_tower_explosion", pos)
end

local function load_dialogue_images()
	for _, name in ipairs({"taunt_orange", "taunt_orange_arrow"}) do
		local key = "krfl_malik_" .. name
		if not I:s(key, true) then
			I:add_image(key, love.graphics.newImage((KR_PATH_GAME or "kr3") .. "/data/malik/" .. name .. ".png"), "runtime_malik_dialogue", 1)
		end
	end
end

function M.clear(this, store)
	local old = this._malik_dialogue
	if old then
		if store.entities[old.id] then remove(old) end
		old.owner = nil
		this._malik_dialogue = nil
	end
end

local function place(e)
	local pos = e.owner.pos
	e.pos.x = math.max(125, math.min(899, pos.x + 85))
	e.pos.y = math.min(704, pos.y + 100)
	e.render.sprites[2].offset.x = math.max(-104, math.min(104, pos.x - e.pos.x))
end

function M.say(this, store, kind, index, duration)
	M.clear(this, store)
	load_dialogue_images()
	local e = E:create_entity("decal_malik_dialogue")
	local key = "ENEMY_MALIK_" .. kind .. "_TAUNT_" .. index
	local locale = i18n.current_locale or "en"
	local text = _(key)
	-- This project's Vietnamese translation uses the zh-Hans locale slot.
	if locale == "vi" or locale == "zh-Hans" or text == key then text = vietnamese[kind][index] end
	e.texts.list[1].text = text
	e.owner, e.duration, e.start_ts = this, duration or 4, store.tick_ts
	this._malik_dialogue = e
	place(e)
	insert(e)
	return e
end

function M.update_dialogue(this, store)
	while this.owner and store.entities[this.owner.id] and store.tick_ts - this.start_ts < this.duration do
		place(this)
		coroutine.yield()
	end
	if this.owner and this.owner._malik_dialogue == this then this.owner._malik_dialogue = nil end
	this.owner = nil
	remove(this)
end

return M
