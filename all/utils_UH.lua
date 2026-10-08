local bit = require("bit")
local band = bit.band
local E = require("entity_db")
local P = require("path_db")
local U = require("utils")
local V = require("klua.vector")
local game_gui = require("game_gui")
local storage = require("storage")

local copy = table.deepclone

local function T(name)
    return E:get_template(name)
end

local function v(v1, v2)
    return {
        x = v1,
        y = v2
    }
end
local utils_UH = {}

---设定局内召唤的英雄的模板
---@param t 模板
---@return boolean 是否成功
function utils_UH:hero_buy_template_set(t)
    if type(t) == "string" then
        local nt = string.gsub(t, "_2$", "")

        E.entities[t] = copy(T(nt))

        local hero = T(t).hero

        T(t).hero_insert = false
        hero.level = 10

        for _, v in pairs(hero.skills) do
            if v.xp_level_steps then
                v.xp_level_steps = {
                    [8] = 1,
                    [9] = 2,
                    [10] = 3
                }
            end
            if v.level then
                v.level = 3
            end
        end
    end

    return true
end

---设定实体位置并修改集结点
---@param store table game.store
---@param id integer 实体id
---@param pos table 位置
---@return boolean 是否成功, table 路径信息, table 节点位置
function utils_UH.set_entity_pos(store, id, pos)
    local e = store.entities[id]

    e.pos = V.vclone(pos)

    local nodes = P:nearest_nodes(pos.x, pos.y, nil,
        nil, true)

    if #nodes < 1 then
        return false
    end

    local pi, spi, ni = unpack(nodes[1])
    local npos = P:node_pos(pi, spi, ni)

    if e.nav_path then
        e.nav_path.pi = pi
        e.nav_path.spi = spi
        e.nav_path.ni = ni
    elseif e.nav_rally then
        e.nav_rally.new = true
        e.nav_rally.pos = v(npos.x, npos.y - 1)
        e.nav_rally.center = v(npos.x, npos.y - 1)
    end

    if e.enemy then
        U.unblock_all(store, e)
    elseif e.soldier then
        U.unblock_target(store, e)
    end

    return true, { pi, spi, ni }, npos
end

---设定能力时间戳
---@param ts number 时间戳
---@param power_idx integer 能力索引
---@param hero_idx integer 英雄索引
---@return boolean 是否成功
local function get_power_button(power_idx, hero_idx)
    if power_idx ~= 3 then
        return game_gui["power_" .. power_idx]
    end

    local user_data = storage:load_slot()
    local hero = user_data and user_data.liuhui_hero

    if hero and hero.usedoublehero and hero_idx then
        if hero.herolist and hero.herolist[1] == hero_idx then
            return game_gui.power_1
        elseif hero.herolist and hero.herolist[2] == hero_idx then
            return game_gui.power_3
        end

        return nil
    end

    return game_gui.power_3
end

function utils_UH.set_power_ts(ts, power_idx, hero_idx)
    local power = get_power_button(power_idx, hero_idx)

    if not power or not power.cooldown_view or power.cooldown_view.start_ts == nil then
        return false
    end

    power.cooldown_view.start_ts = ts

    return true
end

---获取能力时间戳
---@param store table game.store
---@param power_idx integer 能力索引
---@return number 时间戳
function utils_UH.get_power_ts(store, power_idx, hero_idx)
    local power = get_power_button(power_idx, hero_idx)

    if power and power.cooldown_view and power.cooldown_view.start_ts ~= nil then
        return power.cooldown_view.start_ts
    end

    return store.tick_ts or store.ts or 0
end

function utils_UH.find_entities_in_range(entities, origin, min_range, max_range, flags, bans, filter_func)
    local entities = table.filter(entities, function(k, v)
        return
            not v.pending_removal and
            (not v.vis or (band(v.vis.flags, bans) == 0 and band(v.vis.bans, flags) == 0)) and
            (v.pos and (U.is_inside_ellipse(v.pos, origin, max_range) and (min_range == 0 or not U.is_inside_ellipse(v.pos, origin, min_range)))) and
            (not filter_func or filter_func(v, origin))
    end)

    if not entities or #entities == 0 then
        return nil
    else
        return entities
    end
end

return utils_UH
