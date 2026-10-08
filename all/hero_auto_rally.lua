local hook_utils = require("hook_utils")
local HOOK = hook_utils.HOOK
local hook = hook_utils:new()

local simulation = require("simulation")
local game_gui = require("game_gui")
local V = require("klua.vector")
local U = require("utils")
local P = require("path_db")
local GR = require("grid_db")
local log = require("klua.log"):new("hero_auto_rally")
local bit = require("bit")
local storage = require("storage")
require("constants")

--- 返回插件配置
local function cfg(name)
	return hook.cfg[name]
end

function hook:is_enabled()
	return self.enabled == true
end

local _aspect_inv = 1.0 / ASPECT
local function fts(n)
	return n / FPS
end

-- 椭圆距离
local function e_dist2(x1, y1, x2, y2)
	local dx = x1 - x2
	local dy = (y1 - y2) * _aspect_inv
	return dx * dx + dy * dy
end

-- DOVE exposes this through utils via its seek module. This project does not
-- package seek, so keep the small prediction helper local to auto rally.
local function calculate_enemy_ffe_pos(enemy, prediction_time)
	if not prediction_time then
		return V.vclone(enemy.pos)
	end

	if enemy.motion.forced_waypoint then
		local dt = prediction_time == true and 1 or prediction_time

		return V.v(enemy.pos.x + dt * enemy.motion.speed.x, enemy.pos.y + dt * enemy.motion.speed.y)
	end

	return P:predict_enemy_pos(enemy, prediction_time)
end

local function first_enemy_in_range(pos, range, flags, bans, filter_fn)
	local enemies = U.find_enemies_in_range(hook.store.entities, pos, 0, range, flags or F_NONE, bans or F_NONE, filter_fn)

	return enemies and enemies[1]
end

--- 只要玩家手动选中英雄，就记录，暂时禁用自动调集
function hook.PickView.on_down(next, self, button, x, y)
	if hook:is_enabled() and button == 1 and game_gui.mode == GUI_MODE_RALLY_HERO then
		local e = game_gui.selected_entity
		if e and e.id then
			hook.last_manual_rally_ts[e.id] = hook.store.tick_ts
		end
	end
	return next(self, button, x, y)
end

--- 计算英雄的时间槽位（基于英雄ID的哈希值，确保稳定分布）
local function get_hero_time_slot(hero_id)
	-- 使用简单的哈希函数将 hero_id 映射到 [0, 1) 范围
	-- 确保相同 ID 总是得到相同的槽位
	local hash = hero_id * 2654435761 -- 使用一个大质数
	hash = hash % 4294967296 -- 模 2^32
	return (hash / 4294967296) -- 归一化到 [0, 1)
end

-- 英雄类型定义
local HERO_PURE_MELEE = 1 -- 纯近战（只有melee）
local HERO_PURE_RANGED = 2 -- 纯远程（只有ranged，无melee）
local HERO_MELEE_RANGED = 3 -- 近战主远程辅（melee优先，ranged辅助）
local HERO_RANGED_MELEE = 4 -- 远程主近战辅（ranged优先，melee辅助）
local DEFAULT_COOLDOWN = 999

--- 检查攻击是否可以攻击飞行单位
local function can_attack_flying(attack)
	return bit.band(attack.vis_bans or 0, F_FLYING) == 0
end

--- 检查近战攻击是否是远程攻击（可以打空军）
local function is_ranged_melee_attack(attack)
	return bit.band(attack.vis_flags or 0, F_RANGED) ~= 0 and can_attack_flying(attack)
end

--- 分析英雄的攻击能力
local function analyze_hero_attacks(hero)
	local result = {
		has_melee = false,
		has_ranged = false,
		has_timed = false,
		can_block = false,
		-- can_hit_ground_melee = false,
		-- can_hit_air_melee = false,
		-- can_hit_ground_ranged = false,
		can_hit_air_ranged = false,
		melee_attacks = {},
		ranged_attacks = {},
		timed_attacks = {},
		primary_range = 0,
		primary_cooldown = math.huge, -- 最短的远程攻击冷却时间
		melee_range = 0
	}

	-- 分析近战攻击
	if hero.melee then
		result.melee_range = hero.melee.range or 0
		result.has_melee = true
		for i, a in ipairs(hero.melee.attacks) do
			if not a.disabled then
				local info = {
					id = i,
					cooldown = a.cooldown or DEFAULT_COOLDOWN,
					-- can_hit_air = is_ranged_melee_attack(a),
					can_hit_air = false, -- 所有近战攻击必然只能主动攻击地面单位
					-- can_block = bit.band(a.vis_flags or 0, F_BLOCK) ~= 0,
					can_block = true, -- 所有近战攻击都以拦截作为必要条件
					is_skill = a.cooldown and a.cooldown > cfg("melee_skill_cooldown_min") -- 技能判断阈值
				}
				result.melee_attacks[#result.melee_attacks + 1] = info
			end
		end
		result.can_block = true
	end

	-- 分析远程攻击，找到冷却最短的作为主要攻击
	if hero.ranged then
		for i, a in ipairs(hero.ranged.attacks) do
			if not a.disabled then
				local max_range = a.max_range or DEFAULT_COOLDOWN
				local cooldown = a.cooldown or DEFAULT_COOLDOWN

				-- 选择冷却最短的远程攻击作为主攻击
				if type(cooldown) == "number" and cooldown < result.primary_cooldown and type(max_range) == "number" then
					result.primary_cooldown = cooldown
					result.primary_range = max_range
				end

				local info = {
					id = i,
					cooldown = cooldown,
					max_range = max_range,
					can_hit_air = can_attack_flying(a),
					is_skill = a.cooldown and a.cooldown > cfg("ranged_skill_cooldown_min")
				}
				result.ranged_attacks[#result.ranged_attacks + 1] = info

				if info.can_hit_air then
					result.can_hit_air_ranged = true
				-- else
				-- result.can_hit_ground_ranged = true
				end
				result.has_ranged = true
			end
		end
	end

	-- 分析定时攻击（只考虑远程类型的）
	if hero.timed_attacks then
		for i, a in ipairs(hero.timed_attacks.list) do
			if not a.disabled then
				local max_range = a.max_range or DEFAULT_COOLDOWN
				local cooldown = a.cooldown or DEFAULT_COOLDOWN
				local is_ranged = bit.band(a.vis_flags or 0, F_RANGED) ~= 0

				-- 如果是远程定时攻击，也考虑其冷却时间
				if is_ranged and type(cooldown) == "number" and cooldown < result.primary_cooldown and type(max_range) == "number" then
					result.primary_cooldown = cooldown
					result.primary_range = max_range
				end

				local info = {
					id = i,
					cooldown = cooldown,
					max_range = max_range,
					can_hit_air = can_attack_flying(a),
					is_ranged = is_ranged,
					is_skill = a.cooldown and a.cooldown > cfg("timed_skill_cooldown_min") -- timed_attacks 通常都是技能
				}
				result.timed_attacks[#result.timed_attacks + 1] = info

				if info.is_ranged then
					if info.can_hit_air then
						result.can_hit_air_ranged = true
					-- else
					-- result.can_hit_ground_ranged = true
					end
				end
				result.has_timed = true
			end
		end
	end

	return result
end

--- 判断英雄类型
local function classify_hero_type(hero, attacks)
	if not attacks.has_melee then
		-- print("Hero " .. hero.template_name .. " classified as pure ranged (no melee attacks)")
		return HERO_PURE_RANGED
	end

	if not attacks.has_ranged and not attacks.has_timed then
		-- print("Hero " .. hero.template_name .. " classified as pure melee (no ranged or timed attacks)")
		return HERO_PURE_MELEE
	end

	-- 优先考虑英雄信息函数提供的攻击类型判断，因为它可能基于更全面的数据（如技能伤害、动画等）进行综合评估
	if hero.info.fn then
		local ranged_dps = nil
		local melee_dps = nil
		local info = hero.info.fn(hero)
		if not info.no_ranged and info.ranged_damage_min and info.ranged_damage_max and info.ranged_cooldown then
			ranged_dps = (info.ranged_damage_min + info.ranged_damage_max) / 2 / info.ranged_cooldown
		end
		if info.damage_min and info.damage_max and info.cooldown then
			melee_dps = (info.damage_min + info.damage_max) / 2 / info.cooldown
		end
		if ranged_dps and melee_dps then
			if ranged_dps >= melee_dps then
				return HERO_RANGED_MELEE
			else
				return HERO_MELEE_RANGED
			end
		end
	end

	-- 有近战也有远程，需要判断优先级
	-- 根据 primary_cooldown 判断：冷却快说明是主要攻击手段
	-- 如果远程攻击冷却 < 4秒，说明远程是主攻击手段，视为远程为主
	if attacks.primary_cooldown < cfg("ranged_fast_cooldown") then
		return HERO_RANGED_MELEE
	else
		return HERO_MELEE_RANGED
	end
end

--- 获取攻击的关键时间点（伤害/子弹打出的时刻）
local function get_attack_hit_time(attack)
	-- hit_time: 近战攻击伤害生效时间
	-- shoot_time: 远程攻击子弹发射时间
	-- 返回时间（秒），如果没有则返回一个保守的默认值

	if type(attack.hit_time) == "number" then
		return attack.hit_time
	elseif type(attack.hit_time) == "table" and #attack.hit_time > 0 then
		return attack.hit_time[#attack.hit_time]
	elseif attack.shoot_time then
		return attack.shoot_time
	elseif attack.hit_times and #attack.hit_times > 0 then
		-- 多段攻击，取最后一段
		return attack.hit_times[#attack.hit_times]
	elseif attack.shoot_times and #attack.shoot_times > 0 then
		-- 多次射击，取最后一次
		return attack.shoot_times[#attack.shoot_times]
	else
		-- 没有定义时间点，不思考了
		return 0
	end
end

--- 检查英雄是否正在释放技能
--- 判断依据：从技能触发(ts)到伤害/子弹打出(hit_time/shoot_time)的这段时间内
local function is_hero_in_skill_animation(hero, attacks)
	local now = hook.store.tick_ts

	-- 检查近战技能
	if hero.melee then
		for _, info in ipairs(attacks.melee_attacks) do
			if info.is_skill then
				local a = hero.melee.attacks[info.id]
				if a and not a.disabled then
					local time_since_cast = now - a.ts
					local hit_time = get_attack_hit_time(a)
					-- 从释放到伤害打出的时间内，不要移动
					-- 再加0.3秒缓冲，避免过早打断
					if time_since_cast < hit_time + fts(1) then
						return true
					end
				end
			end
		end
	end

	-- 检查远程技能
	if hero.ranged then
		for _, info in ipairs(attacks.ranged_attacks) do
			if info.is_skill then
				local a = hero.ranged.attacks[info.id]
				if a and not a.disabled then
					local time_since_cast = now - a.ts
					local shoot_time = get_attack_hit_time(a)
					-- 从释放到子弹打出的时间内，不要移动
					if time_since_cast < shoot_time + fts(1) then
						return true
					end
				end
			end
		end
	end

	-- 检查定时技能
	if hero.timed_attacks then
		for _, info in ipairs(attacks.timed_attacks) do
			local a = hero.timed_attacks.list[info.id]
			local boars_at_cap = (hero.template_name == "hero_beastmaster" or hero.template_name == "hero_beastmaster_2")
				and info.id == 2 and hero.boars and a and a.max and #hero.boars >= a.max
			if a and not a.disabled and not boars_at_cap then
				local time_since_cast = now - a.ts
				local action_time = get_attack_hit_time(a)
				-- 技能执行时间内，不要移动
				if time_since_cast < action_time + fts(1) then
					return true
				end
			end
		end
	end

	return false
end

--- 获取英雄信息
local function get_hero_info(hero)
	local attacks = analyze_hero_attacks(hero)
	local hero_type = classify_hero_type(hero, attacks)

	return {
		hero_type = hero_type,
		attacks = attacks,
		-- can_hit_air = attacks.can_hit_air_melee or attacks.can_hit_air_ranged,
		can_hit_air = attacks.can_hit_air_ranged, -- 只有远程攻击能打空军，所以以远程攻击的对空能力为准
		can_block = attacks.can_block,
		primary_range = attacks.primary_range,
		melee_range = attacks.melee_range,
		time_slot = get_hero_time_slot(hero.id),
		level = hero.hero.level
	}
end

--- 每隔一定时间，检查场上的英雄
local function check_heroes()
	if hook.store.tick_ts - hook.last_check_hero_ts < cfg("hero_scan_interval") then
		return
	end
	hook.last_check_hero_ts = hook.store.tick_ts

	local to_remove = {}

	for _, e in pairs(hook.heroes) do
		if not e.hero then
			to_remove[#to_remove + 1] = e.id
		else
			if hook.hero_info[e.id].level ~= e.hero.level then
				hook.hero_info[e.id] = get_hero_info(e)
			end
		end
	end

	for i = 1, #to_remove do
		log.error(hook.heroes[to_remove[i]].template_name .. "动态删除了 hero 字段！")
		hook.heroes[to_remove[i]] = nil
		hook.hero_info[to_remove[i]] = nil
		hook.hero_count = math.max(0, hook.hero_count - 1)
	end
end

--- 判断英雄是否能够前往指定位置
local function is_destination_reachable(hero, x, y)
	return (not hero.nav_rally.requires_node_nearby or P:valid_node_nearby(x, y, nil, NF_RALLY) and GR:cell_is_only(x, y, hero.nav_grid.valid_terrains_dest)) and (hero.teleport and not hero.teleport.disabled and V.dist(x, y, hero.pos.x, hero.pos.y) > hero.teleport.min_distance or hero.nav_grid.ignore_waypoints or GR:find_waypoints(hero.pos, hero.nav_rally.pos, V.v(x, y), hero.nav_grid.valid_terrains))
end

--- 让英雄前往指定位置
local function set_destination(hero, x, y)
	if not hero.nav_grid.ignore_waypoints then
		local waypoints = GR:find_waypoints(hero.pos, hero.nav_rally.pos, V.v(x, y), hero.nav_grid.valid_terrains)

		if waypoints then
			hero.nav_grid.waypoints = waypoints
			hero.nav_rally.new = true
			hero.nav_rally.pos = V.v(x, y)
			hero.nav_rally.center = V.v(x, y)
		end
	else
		hero.nav_rally.new = true
		hero.nav_rally.pos = V.v(x, y)
		hero.nav_rally.center = V.v(x, y)
	end
end

--- 判断英雄是否处于危险中，危险定义为当前生命值比例低于某个阈值
local function is_hero_in_danger(hero)
	if hero.selfdestruct then
		return false
	end
	return hero.health.hp / hero.health.hp_max < cfg("in_danger_hp")
end

--- 获取英雄正在拦截的敌人
local function get_blocked_enemy(hero)
	if not hero.soldier or not hero.soldier.target_id then
		return nil
	end
	return hook.store.entities[hero.soldier.target_id]
end

local function is_hero_regening(hero)
	return get_blocked_enemy(hero) == nil and hero.health.hp < hero.health.hp_max * cfg("resume_hp") and not hero.selfdestruct
end

--- 计算敌人到家的节点数
local function enemy_nodes_to_goal(enemy)
	return P:nodes_to_goal(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni)
end

--- 检查位置范围内是否有敌人
local function has_enemy_in_range(pos, range, must_be_flying)
	local flags = F_BLOCK
	local bans = F_NONE

	if must_be_flying then
		-- 只找飞行单位
		flags = F_RANGED
		bans = F_NONE
		for _, enemy in pairs(hook.store.entities) do
			if enemy.enemy and enemy.health and not enemy.health.dead and enemy.vis and bit.band(enemy.vis.flags, F_FLYING) ~= 0 then
				local dist2 = e_dist2(pos.x, pos.y, enemy.pos.x, enemy.pos.y)
				if dist2 <= range * range then
					return true
				end
			end
		end
		return false
	else
		-- 找任意敌人
		return first_enemy_in_range(pos, range, F_NONE, F_NONE) ~= nil
	end
end

--- 获得最近的敌人
local function find_nearest_enemy(hero, filter_fn)
	local min_dist2 = math.huge
	local nearest
	for _, enemy in pairs(hook.store.entities) do
		if enemy.enemy and enemy.health and not enemy.health.dead and enemy.pos and (not filter_fn or filter_fn(enemy)) then
			local dist2 = e_dist2(hero.pos.x, hero.pos.y, enemy.pos.x, enemy.pos.y)
			if dist2 < min_dist2 then
				min_dist2 = dist2
				nearest = enemy
			end
		end
	end
	return nearest
end

--- 寻找候选的敌人
--- 根据英雄类型和能力选择合适的敌人
---@param hero table 英雄实体
---@param hero_info table 英雄信息
---@param prefer_ground boolean 是否优先地面单位
---@return table 按优先级排序的敌人列表
local function select_enemy_candidates(hero, hero_info, prefer_ground)
	local limit = cfg("target_candidate_limit")
	local out = {}
	-- local high_threat_extra = {} -- 高威胁敌人额外列表

	for _, enemy in pairs(hook.store.entities) do
		if enemy.enemy and enemy.health and not enemy.health.dead and enemy.nav_path and enemy.vis and P:is_node_valid(enemy.nav_path.pi, enemy.nav_path.ni) then
			local is_flying = bit.band(enemy.vis.flags, F_FLYING) ~= 0

			-- 根据英雄类型判断是否可以攻击这个敌人
			local can_attack = false

			if is_flying then
				-- 空军敌人
				can_attack = hero_info.can_hit_air
			else
				-- 地面敌人
				if hero_info.hero_type == HERO_PURE_MELEE or hero_info.hero_type == HERO_MELEE_RANGED then
					-- 近战型英雄，检查敌人是否可被拦截
					can_attack = bit.band(enemy.vis.bans, F_BLOCK) == 0
				else
					-- 远程型英雄，检查敌人是否可被远程攻击
					can_attack = bit.band(enemy.vis.bans, F_RANGED) == 0
				end
			end

			if can_attack then
				local dist2 = e_dist2(enemy.pos.x, enemy.pos.y, hero.pos.x, hero.pos.y)
				local score = enemy_nodes_to_goal(enemy)
				-- local threat = get_enemy_threat_level(enemy)

				-- 如果优先地面单位，给空军单位增加惩罚分
				if prefer_ground and is_flying then
					score = score * 2
				end

				local candidate = {
					enemy = enemy,
					score = score,
					dist2 = dist2,
					is_flying = is_flying
				-- threat = threat
				}

				local inserted = false
				for i = 1, #out do
					local slot = out[i]
					if score < slot.score or (score == slot.score and dist2 < slot.dist2) then
						table.insert(out, i, candidate)
						inserted = true
						break
					end
				end

				if not inserted and #out < limit then
					out[#out + 1] = candidate
				-- elseif not inserted and threat <= 2 and #high_threat_extra < cfg("high_threat_candidate_limit") then
				-- 	-- 高威胁敌人（召唤类、buff类）即使不在主列表中也要记录
				-- 	high_threat_extra[#high_threat_extra + 1] = candidate
				end

				if #out > limit then
					out[#out] = nil
				end
			end
		end
	end

	-- -- 将高威胁额外敌人合并到候选列表
	-- for i = 1, #high_threat_extra do
	-- 	out[#out + 1] = high_threat_extra[i]
	-- end

	return out
end

--- 在英雄不安全时触发撤退
local function hero_escape_from_battle(hero, hero_info)
	local safe_distance = cfg("safe_distance")

	-- 找到周围真正威胁到英雄的敌人
	local threat_enemies = {}

	for _, e in pairs(hook.store.entities) do
		if e.enemy and e.health and not e.health.dead and e.pos and e.vis then
			local dist = V.dist(hero.pos.x, hero.pos.y, e.pos.x, e.pos.y)
			local threat_range = 0

			-- 检查近战威胁
			if e.melee and e.melee.attacks then
				for _, a in ipairs(e.melee.attacks) do
					local melee_threat = (a.max_range or 40) + safe_distance
					if bit.band(hero.vis.flags, a.vis_bans) == 0 and dist < melee_threat then
						threat_range = math.max(threat_range, melee_threat)
					end
				end
			end

			-- 检查远程威胁
			if e.ranged and e.ranged.attacks then
				for _, a in ipairs(e.ranged.attacks) do
					if a.max_range and bit.band(hero.vis.flags, a.vis_bans) == 0 then
						local ranged_threat = a.max_range + safe_distance
						if dist < ranged_threat then
							threat_range = math.max(threat_range, ranged_threat)
						end
					end
				end
			end

			if threat_range > 0 then
				threat_enemies[#threat_enemies + 1] = {
					enemy = e,
					dist = dist,
					threat_range = threat_range
				}
			end
		end
	end

	-- 没有真正的威胁，不需要撤退
	if #threat_enemies == 0 then
		return
	end

	-- 计算撤退方向（远离威胁敌人的质心）
	local threat_center_x, threat_center_y = 0, 0
	for i = 1, #threat_enemies do
		threat_center_x = threat_center_x + threat_enemies[i].enemy.pos.x
		threat_center_y = threat_center_y + threat_enemies[i].enemy.pos.y
	end
	threat_center_x = threat_center_x / #threat_enemies
	threat_center_y = threat_center_y / #threat_enemies

	-- 计算撤退方向向量
	local escape_dx = hero.pos.x - threat_center_x
	local escape_dy = hero.pos.y - threat_center_y
	local escape_len = math.sqrt(escape_dx * escape_dx + escape_dy * escape_dy)

	if escape_len < 0.01 then
		-- 英雄在敌人中心，随机选择方向
		escape_dx, escape_dy = 1, 0
		escape_len = 1
	end

	-- 归一化方向向量
	escape_dx = escape_dx / escape_len
	escape_dy = escape_dy / escape_len

	-- 计算需要撤退的距离：要退到最近威胁敌人的攻击范围 + safe_distance 之外
	-- 再额外增加 safe_distance 作为滞后缓冲，避免敌人稍微靠近就再次触发撤退
	local min_escape_dist = 0
	for i = 1, #threat_enemies do
		-- 计算当前位置到安全位置的距离
		-- 安全位置 = 敌人位置 + (threat_range + safe_distance)
		local safe_dist_from_enemy = threat_enemies[i].threat_range + safe_distance
		local need_dist = safe_dist_from_enemy - threat_enemies[i].dist
		if need_dist > 0 then
			min_escape_dist = math.max(min_escape_dist, need_dist)
		end
	end

	-- 如果已经在安全位置，不需要撤退
	if min_escape_dist <= 0 then
		return
	end

	-- 尝试寻找撤退点
	local retreat_x = hero.pos.x + escape_dx * min_escape_dist
	local retreat_y = hero.pos.y + escape_dy * min_escape_dist

	-- 检查撤退点是否可达
	if is_destination_reachable(hero, retreat_x, retreat_y) then
		set_destination(hero, retreat_x, retreat_y)
		return
	end

	-- 如果直线撤退不可达，尝试基于路径节点向后退
	local nodes = P:nearest_nodes(hero.pos.x, hero.pos.y, nil, {1}, true, NF_RALLY)
	if #nodes == 0 then
		return
	end

	local pi, spi, ni = nodes[1][1], nodes[1][2], nodes[1][3]
	local retreat_steps = math.floor(min_escape_dist / P.average_node_dist)
	local target_ni = ni + retreat_steps

	-- 限制不要超出路径范围
	if target_ni > #P.paths[pi][spi] then
		target_ni = #P.paths[pi][spi]
	end

	local node_pos = P:node_pos(pi, spi, target_ni)
	set_destination(hero, node_pos.x, node_pos.y)
end

--- 预测近战英雄前往拦截敌人时应该前往的位置
local function predict_enemy_position_melee(enemy, hero, melee_range)
	-- 敌人静止，直接传送到脸上就好
	local enemy_speed = V.len(enemy.motion.speed.x, enemy.motion.speed.y)
	if enemy_speed <= 0.01 then
		return V.vclone(enemy.pos)
	end

	-- 判断可不可以传送过去
	if hero.teleport and not hero.teleport.disabled then
		local predict_pos = calculate_enemy_ffe_pos(enemy, 0.5)
		local dx = predict_pos.x - hero.pos.x
		local dy = predict_pos.y - hero.pos.y
		if dx * dx + dy * dy > hero.teleport.min_distance * hero.teleport.min_distance then
			return predict_pos
		end
	end

	local delta_nodes = math.floor(melee_range / (P.average_node_dist * 1.414))
	local predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)
	local range2 = melee_range * melee_range

	while e_dist2(enemy.pos.x, enemy.pos.y, predict_pos.x, predict_pos.y) <= range2 and enemy.nav_path.ni + delta_nodes < #P.paths[enemy.nav_path.pi][enemy.nav_path.spi] do
		delta_nodes = delta_nodes + 1
		predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)
	end

	while e_dist2(enemy.pos.x, enemy.pos.y, predict_pos.x, predict_pos.y) > range2 and enemy.nav_path.ni + delta_nodes > 1 do
		delta_nodes = delta_nodes - 1
		predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)
	end

	return predict_pos
end

--- 预测远程英雄前往阻击敌人时应该前往的位置
local function predict_enemy_position_ranged(enemy, hero, range)
	local range2 = range * range
	local delta_nodes = math.floor(range / (P.average_node_dist * 1.414))
	local predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)

	while e_dist2(enemy.pos.x, enemy.pos.y, predict_pos.x, predict_pos.y) <= range2 and enemy.nav_path.ni + delta_nodes < #P.paths[enemy.nav_path.pi][enemy.nav_path.spi] do
		delta_nodes = delta_nodes + 1
		predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)
	end

	while e_dist2(enemy.pos.x, enemy.pos.y, predict_pos.x, predict_pos.y) > range2 and enemy.nav_path.ni + delta_nodes > 1 do
		delta_nodes = delta_nodes - 1
		predict_pos = P:node_pos(enemy.nav_path.pi, enemy.nav_path.spi, enemy.nav_path.ni + delta_nodes)
	end

	return predict_pos
end

--- 纯近战英雄的调集逻辑
--- 策略：优先拦截紧急敌人（离家近），其次拦截最近敌人
local function rally_pure_melee_hero(hero, hero_info)
	-- 检查是否正在释放技能
	if is_hero_in_skill_animation(hero, hero_info.attacks) then
		return
	end

	local blocked_enemy = get_blocked_enemy(hero)
	local home_urgent_nodes = cfg("home_urgent_nodes_melee")

	-- 如果正在拦截紧急敌人，继续拦截
	if blocked_enemy then
		local nodes = enemy_nodes_to_goal(blocked_enemy)
		if nodes <= home_urgent_nodes then
			return
		end
	end

	-- 获取候选敌人（纯近战只能攻击地面可拦截敌人）
	local candidates = select_enemy_candidates(hero, hero_info, true)
	if #candidates == 0 then
		return
	end

	-- 优先处理紧急敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_urgent_nodes then
			if candidates[i].dist2 <= hero_info.melee_range * hero_info.melee_range then
				return -- 已在攻击范围内
			end
		else
			break
		end
	end

	for i = 1, #candidates do
		if candidates[i].score <= home_urgent_nodes then
			local predict_pos = predict_enemy_position_melee(candidates[i].enemy, hero, hero_info.melee_range)
			if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
				set_destination(hero, predict_pos.x, predict_pos.y)
				return
			end
		else
			break
		end
	end

	-- 如果已经在拦截，继续
	if blocked_enemy then
		return
	end

	-- 如果周围有敌人，不移动（正在战斗）
	if has_enemy_in_range(hero.pos, hero_info.melee_range, false) then
		return
	end

	-- -- 综合考虑威胁等级和距离，避免追逐过远的高威胁敌人
	-- -- 策略：高威胁敌人可以适当远一些，但不能无限远
	-- table.sort(candidates, function(a, b)
	-- 	local a_threat = get_enemy_threat_level(a.enemy)
	-- 	local b_threat = get_enemy_threat_level(b.enemy)

	-- 	-- 威胁等级差距大（>=2级），优先高威胁
	-- 	if math.abs(a_threat - b_threat) >= 2 then
	-- 		return a_threat < b_threat
	-- 	end

	-- 	-- 威胁等级相近，综合考虑威胁和距离
	-- 	-- 计算综合评分：threat_score = threat_level * 1000 + sqrt(dist2)
	-- 	-- 这样高1级威胁的敌人可以远约1000像素
	-- 	local a_score = a_threat * 250 + math.sqrt(a.dist2)
	-- 	local b_score = b_threat * 250 + math.sqrt(b.dist2)
	-- 	return a_score < b_score
	-- end)

	for i = 1, #candidates do
		local predict_pos = predict_enemy_position_melee(candidates[i].enemy, hero, hero_info.melee_range)
		if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
			set_destination(hero, predict_pos.x, predict_pos.y)
			return
		end
	end
end

--- 纯远程英雄的调集逻辑
--- 策略：保持安全距离，优先阻击紧急敌人
local function rally_pure_ranged_hero(hero, hero_info)
	-- 检查是否正在释放技能
	if is_hero_in_skill_animation(hero, hero_info.attacks) then
		return
	end

	local home_urgent_nodes = cfg("home_urgent_nodes_ranged")
	local home_guard_nodes = cfg("home_guard_nodes")

	-- 检查是否有紧急敌人在攻击范围内
	local enemy = first_enemy_in_range(hero.pos, hero_info.primary_range, F_RANGED, F_NONE, function(e)
		return enemy_nodes_to_goal(e) <= home_urgent_nodes
	end)
	if enemy then
		return -- 继续攻击
	end

	local candidates = select_enemy_candidates(hero, hero_info, false)
	if #candidates == 0 then
		return
	end

	-- 检查警戒区内的敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_guard_nodes then
			if candidates[i].dist2 <= hero_info.primary_range * hero_info.primary_range then
				return -- 在攻击范围内，继续攻击
			end
		else
			break
		end
	end

	-- 前往阻击警戒区敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_guard_nodes then
			local predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
			if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
				set_destination(hero, predict_pos.x, predict_pos.y)
				return
			end
		else
			break
		end
	end

	-- 检查是否在攻击状态
	if has_enemy_in_range(hero.pos, hero_info.primary_range, false) then
		return
	end

	-- 阻击最近的敌人
	table.sort(candidates, function(a, b)
		return a.dist2 < b.dist2
	end)

	for i = 1, #candidates do
		local predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
		if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
			set_destination(hero, predict_pos.x, predict_pos.y)
			return
		end
	end
end

--- 近战主远程辅英雄的调集逻辑
--- 策略：优先拦截地面敌人，有对空能力时也会攻击空军
local function rally_melee_ranged_hero(hero, hero_info)
	-- 检查是否正在释放技能
	if is_hero_in_skill_animation(hero, hero_info.attacks) then
		return
	end

	local blocked_enemy = get_blocked_enemy(hero)
	local home_urgent_nodes = cfg("home_urgent_nodes_melee")

	-- 如果正在拦截紧急敌人，继续
	if blocked_enemy then
		local nodes = enemy_nodes_to_goal(blocked_enemy)
		if nodes <= home_urgent_nodes then
			return
		end
	end

	-- 优先地面敌人（因为近战为主）
	local candidates = select_enemy_candidates(hero, hero_info, true)
	if #candidates == 0 then
		return
	end

	-- 处理紧急敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_urgent_nodes then
			-- 如果是地面敌人且在近战范围内
			if not candidates[i].is_flying and candidates[i].dist2 <= hero_info.melee_range * hero_info.melee_range then
				return
			end
			-- 如果是空军且在远程范围内
			if candidates[i].is_flying and candidates[i].dist2 <= hero_info.primary_range * hero_info.primary_range then
				return
			end
		else
			break
		end
	end

	-- 前往拦截/阻击紧急敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_urgent_nodes then
			local predict_pos
			if candidates[i].is_flying then
				-- 空军用远程范围
				predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
			else
				-- 地面用近战范围
				predict_pos = predict_enemy_position_melee(candidates[i].enemy, hero, hero_info.melee_range)
			end
			if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
				set_destination(hero, predict_pos.x, predict_pos.y)
				return
			end
		else
			break
		end
	end

	-- 如果正在拦截，继续
	if blocked_enemy then
		return
	end

	-- 检查是否在战斗中
	if has_enemy_in_range(hero.pos, hero_info.melee_range, false) then
		return
	end

	-- 如果有对空能力且周围有空军
	if hero_info.can_hit_air and has_enemy_in_range(hero.pos, hero_info.primary_range, true) then
		return
	end

	-- -- 按威胁等级排序，地面敌人优先（近战为主）
	-- table.sort(candidates, function(a, b)
	-- 	local a_threat = get_enemy_threat_level(a.enemy)
	-- 	local b_threat = get_enemy_threat_level(b.enemy)

	-- 	-- 威胁等级差距大（>=2级），优先高威胁
	-- 	if math.abs(a_threat - b_threat) >= 2 then
	-- 		return a_threat < b_threat
	-- 	end

	-- 	-- 威胁等级相近，综合考虑威胁和距离
	-- 	-- 计算综合评分：threat_score = threat_level * 1000 + sqrt(dist2)
	-- 	-- 这样高1级威胁的敌人可以远约1000像素
	-- 	local a_score = a_threat * 250 + math.sqrt(a.dist2)
	-- 	local b_score = b_threat * 250 + math.sqrt(b.dist2)
	-- 	return a_score < b_score
	-- end)

	for i = 1, #candidates do
		local predict_pos
		if candidates[i].is_flying then
			predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
		else
			predict_pos = predict_enemy_position_melee(candidates[i].enemy, hero, hero_info.melee_range)
		end
		if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
			set_destination(hero, predict_pos.x, predict_pos.y)
			return
		end
	end
end

--- 远程主近战辅英雄的调集逻辑
--- 策略：优先远程阻击，必要时近战拦截
local function rally_ranged_melee_hero(hero, hero_info)
	-- 检查是否正在释放技能
	if is_hero_in_skill_animation(hero, hero_info.attacks) then
		return
	end

	local blocked_enemy = get_blocked_enemy(hero)
	local home_urgent_nodes = cfg("home_urgent_nodes_ranged")
	local home_guard_nodes = cfg("home_guard_nodes")

	-- 如果正在拦截紧急敌人，继续
	if blocked_enemy then
		local nodes = enemy_nodes_to_goal(blocked_enemy)
		if nodes <= home_urgent_nodes then
			return
		end
	end

	-- 检查是否有紧急敌人在远程范围内
	local enemy = first_enemy_in_range(hero.pos, hero_info.primary_range, F_RANGED, F_NONE, function(e)
		return enemy_nodes_to_goal(e) <= home_urgent_nodes
	end)
	if enemy then
		return
	end

	local candidates = select_enemy_candidates(hero, hero_info, false)
	if #candidates == 0 then
		return
	end

	-- 检查警戒区敌人
	local has_enemy_in_ranged_range = false
	local has_enemy_in_melee_range = false

	for i = 1, #candidates do
		if candidates[i].score <= home_guard_nodes then
			if candidates[i].dist2 <= hero_info.primary_range * hero_info.primary_range then
				has_enemy_in_ranged_range = true
			end
			if candidates[i].dist2 <= hero_info.melee_range * hero_info.melee_range then
				has_enemy_in_melee_range = true
			end
		else
			break
		end
	end

	-- 如果在远程范围内但不在近战范围内，继续远程攻击
	if has_enemy_in_ranged_range and not has_enemy_in_melee_range then
		return
	end

	-- 前往阻击警戒区敌人
	for i = 1, #candidates do
		if candidates[i].score <= home_guard_nodes then
			local predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
			if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
				set_destination(hero, predict_pos.x, predict_pos.y)
				return
			end
		else
			break
		end
	end

	-- 如果正在拦截，检查是否该脱战
	if blocked_enemy then
		-- 等待近战技能释放完毕
		local has_melee_skill_ready = false
		for _, info in pairs(hero_info.attacks.melee_attacks) do
			if info.is_skill then
				local a = hero.melee.attacks[info.id]
				if a and not a.disabled then
					local time_since_cast = hook.store.tick_ts - a.ts
					if a.cooldown and time_since_cast >= a.cooldown then
						has_melee_skill_ready = true
						break
					end
				end
			end
		end

		if not has_melee_skill_ready then
			-- 脱战，前往远程位置
			for i = 1, #candidates do
				local predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
				if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
					set_destination(hero, predict_pos.x, predict_pos.y)
					return
				end
			end
		end
		return
	end

	-- 检查是否在远程攻击状态
	if has_enemy_in_range(hero.pos, hero_info.primary_range, false) then
		return
	end

	-- 阻击最近的敌人
	table.sort(candidates, function(a, b)
		return a.dist2 < b.dist2
	end)

	for i = 1, #candidates do
		local predict_pos = predict_enemy_position_ranged(candidates[i].enemy, hero, hero_info.primary_range)
		if is_destination_reachable(hero, predict_pos.x, predict_pos.y) then
			set_destination(hero, predict_pos.x, predict_pos.y)
			return
		end
	end
end

--- 对单个英雄进行自动调集
local function rally_hero(hero)
	if hero.health.dead then
		return
	end

	if (hero.template_name == "hero_space_elf" or hero.template_name == "hero_space_elf_2")
		and hero.health.ignore_damage then
		return
	end

	if hook.store.tick_ts - (hook.last_manual_rally_ts[hero.id] or -math.huge) < cfg("manual_pause_seconds") then
		if hero.sound_events then
			hero.sound_events.change_rally_point = hero.sound_events._hero_auto_rally_change_rally_point
		end
		return
	end

	if hero.sound_events then
		hero.sound_events.change_rally_point = nil
	end

	local hero_info = hook.hero_info[hero.id]

	-- 英雄很危险，撤退！
	if is_hero_in_danger(hero) then
		hero_escape_from_battle(hero, hero_info)
		return
	end

	-- 英雄还在回血，不打扰
	if is_hero_regening(hero) then
		return
	end

	-- 根据英雄类型选择调集策略
	if hero_info.hero_type == HERO_PURE_MELEE then
		rally_pure_melee_hero(hero, hero_info)
	elseif hero_info.hero_type == HERO_PURE_RANGED then
		rally_pure_ranged_hero(hero, hero_info)
	elseif hero_info.hero_type == HERO_MELEE_RANGED then
		rally_melee_ranged_hero(hero, hero_info)
	elseif hero_info.hero_type == HERO_RANGED_MELEE then
		rally_ranged_melee_hero(hero, hero_info)
	end
end

--- 每隔一定时间，尝试自动调集所有英雄
--- 使用时间分片技术，将英雄调集任务均匀分布在整个周期内，避免单帧卡顿
local function rally_heroes()
	local auto_rally_interval = cfg("auto_rally_interval")
	local now = hook.store.tick_ts

	-- 检查是否需要开始新的调集周期
	if now - hook.last_auto_rally_cycle_ts >= auto_rally_interval then
		hook.last_auto_rally_cycle_ts = now
		hook.last_rally_check_ts = now -- 重置上次检查时间
	end

	-- 如果还没有英雄，跳过
	if hook.hero_count == 0 then
		return
	end

	-- 计算当前周期的进度 [0, 1]
	local cycle_progress = (now - hook.last_auto_rally_cycle_ts) / auto_rally_interval
	-- 计算上次检查时的进度
	local last_cycle_progress = (hook.last_rally_check_ts - hook.last_auto_rally_cycle_ts) / auto_rally_interval

	-- 遍历所有英雄，检查哪些英雄的时间槽位在这个时间段内
	for hero_id, hero in pairs(hook.heroes) do
		if hero_id ~= hook.ban_hero_id then
			local hero_slot = hook.hero_info[hero_id].time_slot

			-- 如果英雄的槽位在 [last_cycle_progress, cycle_progress] 范围内，调集该英雄
			if hero_slot >= last_cycle_progress and hero_slot < cycle_progress then
				rally_hero(hero)
			end
		end
	end

	-- 更新上次检查时间
	hook.last_rally_check_ts = now
end

function hook:init(game_instance)
	if rawget(self, "installed") then
		return
	end

	self.cfg = require("hero_auto_rally_config")

	local systems = require("systems")

	local hero_auto_rally = {}
	systems.hero_auto_rally = hero_auto_rally
	hero_auto_rally.name = "hero_auto_rally"

	function hero_auto_rally:init(store)
		local slot = storage:load_slot(nil, true)
		hook.enabled = slot and slot.liuhui and slot.liuhui.hero_auto_rally == true
		hook.store = store
		hook.last_manual_rally_ts = {}
		hook.last_auto_rally_cycle_ts = -math.huge
		hook.last_rally_check_ts = -math.huge
		hook.hero_info = {}
		hook.last_check_hero_ts = -math.huge
		hook.heroes = {}
		hook.hero_count = 0
		hook.ban_hero_id = -1
		if not hook.enabled then
			return "skip"
		end
	end

	function hero_auto_rally:on_update(dt, ts, store)
		if not hook:is_enabled() then
			return
		end

		check_heroes()
		rally_heroes()
	end

	function hero_auto_rally:on_insert_unconditional(e, store)
		if e.hero then
			hook.heroes[e.id] = e
			if cfg("ban_first") and hook.hero_count == 0 then
				hook.ban_hero_id = e.id
			end
			hook.hero_count = hook.hero_count + 1
			hook.last_manual_rally_ts[e.id] = -math.huge
			hook.hero_info[e.id] = get_hero_info(e)
			if e.sound_events then
				e.sound_events._hero_auto_rally_change_rally_point = e.sound_events.change_rally_point
			end
		end
	end

	function hero_auto_rally:on_remove_unconditional(e, store)
		if e.hero then
			hook.heroes[e.id] = nil
			hook.hero_count = hook.hero_count - 1
			hook.last_manual_rally_ts[e.id] = nil
			hook.hero_info[e.id] = nil
			if e.sound_events then
				e.sound_events._hero_auto_rally_change_rally_point = nil
			end
		end
	end

	HOOK(PickView, "on_down", self.PickView.on_down)

	if not table.contains(game_instance.simulation_systems, "hero_auto_rally") then
		table.insert(game_instance.simulation_systems, "hero_auto_rally")
	end
	self.game = game_instance
	self.installed = true
end

function hook:on_config_change(new_cfg)
	self.cfg = new_cfg
end

function hook:unload()
	hook_utils.UNHOOK(PickView, "on_down", self.PickView.on_down)

	if self.game then
		table.removeobject(self.game.simulation_systems, "hero_auto_rally")
	end

	self.installed = false
end

hook.reload = hook.init

return hook
