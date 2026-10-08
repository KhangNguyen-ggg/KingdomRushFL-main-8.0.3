local bit = require("bit")
local V = require("klua.vector")

require("constants")

local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

local M = {}

local current_context
local clear_virtual_blocker

local utility_modules = {
	"utils",
	"utils_4",
	"utils_5",
	"utils_57",
	"utils_123",
	"utils_pld",
	"utils_v",
	"utils_lh"
}

local function swap_faction_flags(value)
	if type(value) ~= "number" then
		return value
	end

	local has_enemy = band(value, F_ENEMY) ~= 0
	local has_friend = band(value, F_FRIEND) ~= 0

	value = band(value, bnot(bor(F_ENEMY, F_FRIEND)))

	if has_enemy then
		value = bor(value, F_FRIEND)
	end

	if has_friend then
		value = bor(value, F_ENEMY)
	end

	return value
end

local function combine_filter(filter_func, faction_filter)
	return function(entity, origin)
		return faction_filter(entity) and (not filter_func or filter_func(entity, origin))
	end
end

local function is_hostile_enemy(entity)
	return entity and entity.enemy and not entity._possession_skill_active
end

local function is_possessed_friend(entity)
	return entity and entity._possession_skill_active
end

local function possession_enemy(entity)
	local state = entity and entity._possession_skill_state

	return entity and entity.enemy or state and state.enemy
end

local function attach_possession_enemy(entity)
	local state = entity and entity._possession_skill_state

	if not state or entity.enemy or not state.enemy then
		return false
	end

	entity.enemy = state.enemy

	return true
end

local function detach_possession_enemy(entity, attached)
	local state = entity and entity._possession_skill_state

	if not attached or not state then
		return
	end

	if entity.enemy then
		state.enemy = entity.enemy
	end

	entity.enemy = nil
end

local function attach_context_enemies(entity, store)
	local attached = {}
	local seen = {}

	local function attach(target)
		if not target or seen[target] then
			return
		end

		seen[target] = true

		if attach_possession_enemy(target) then
			table.insert(attached, target)
		end
	end

	local function attach_id(id)
		if id and store and store.entities then
			attach(store.entities[id])
		end
	end

	attach(entity)
	attach_id(entity and entity.target_id)
	attach_id(entity and entity.source_id)
	attach_id(entity and entity.owner_id)

	for _, component_name in ipairs({"modifier", "bullet", "aura", "spell", "spawner"}) do
		local component = entity and entity[component_name]

		if component then
			attach_id(component.target_id)
			attach_id(component.source_id)
			attach_id(component.owner_id)
		end
	end

	return attached
end

local function detach_context_enemies(attached)
	for i = #attached, 1, -1 do
		detach_possession_enemy(attached[i], true)
	end
end

local function patch_direct_enemy_queries(U)
	if not U then
		return
	end

	if U.find_first_enemy and not U._possession_skill_find_first_enemy then
		U._possession_skill_find_first_enemy = U.find_first_enemy
		local raw_find_first = U.find_first_enemy

		U.find_first_enemy = function(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func)
			if current_context then
				return raw_find_first(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func)
			end

			return raw_find_first(entities, origin, min_range, max_range, prediction_time, flags, bans,
				combine_filter(filter_func, is_hostile_enemy))
		end
	end

	if U.find_custom_enemy and not U._possession_skill_find_custom_enemy then
		U._possession_skill_find_custom_enemy = U.find_custom_enemy
		local raw_find_custom = U.find_custom_enemy

		U.find_custom_enemy = function(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags, sort_func)
			if current_context then
				return raw_find_custom(entities, origin, min_range, max_range, prediction_time, flags, bans,
					filter_func, min_override_flags, sort_func)
			end

			return raw_find_custom(entities, origin, min_range, max_range, prediction_time, flags, bans,
				combine_filter(filter_func, is_hostile_enemy), min_override_flags, sort_func)
		end
	end

	if U.find_rearmost_enemy and not U._possession_skill_find_rearmost_enemy then
		U._possession_skill_find_rearmost_enemy = U.find_rearmost_enemy
		local raw_find_rearmost = U.find_rearmost_enemy

		U.find_rearmost_enemy = function(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
			if current_context then
				return raw_find_rearmost(entities, origin, min_range, max_range, prediction_time, flags, bans,
					filter_func, min_override_flags)
			end

			return raw_find_rearmost(entities, origin, min_range, max_range, prediction_time, flags, bans,
				combine_filter(filter_func, is_hostile_enemy), min_override_flags)
		end
	end
end

local function patch_blocking_helpers(U)
	if not U then
		return
	end

	if U.cleanup_blockers and not U._possession_skill_cleanup_blockers then
		U._possession_skill_cleanup_blockers = U.cleanup_blockers

		U.cleanup_blockers = function(store, blocked)
			if not blocked or not blocked._possession_skill_active then
				return U._possession_skill_cleanup_blockers(store, blocked)
			end

			local enemy = possession_enemy(blocked)
			local blockers = enemy and enemy.blockers

			if not blockers then
				return
			end

			for i = #blockers, 1, -1 do
				local blocker_id = blockers[i]
				local blocker = store and store.entities and store.entities[blocker_id]
				local reciprocal = false

				if blocker and blocker.enemy and blocker.enemy.blockers then
					for _, id in pairs(blocker.enemy.blockers) do
						if id == blocked.id then
							reciprocal = true
							break
						end
					end
				end

				if blocker_id ~= blocked._possession_skill_virtual_blocker or
						not is_hostile_enemy(blocker) or not blocker.health or blocker.health.dead or
						blocker.pending_removal or not reciprocal then
					table.remove(blockers, i)
				end
			end
		end
	end

	if U.unblock_all and not U._possession_skill_unblock_all then
		U._possession_skill_unblock_all = U.unblock_all

		U.unblock_all = function(store, blocked)
			if blocked and blocked._possession_skill_active then
				clear_virtual_blocker(blocked, store)
				return
			end

			return U._possession_skill_unblock_all(store, blocked)
		end
	end

	if U.unblock_target and not U._possession_skill_unblock_target then
		U._possession_skill_unblock_target = U.unblock_target

		U.unblock_target = function(store, blocker)
			if blocker and blocker._possession_skill_active then
				clear_virtual_blocker(blocker, store)
				return
			end

			if current_context and current_context._possession_skill_active and blocker and
					current_context._possession_skill_virtual_blocker == blocker.id and not blocker.soldier then
				clear_virtual_blocker(current_context, store)
				return
			end

			return U._possession_skill_unblock_target(store, blocker)
		end
	end
end
local function patch_utility(U)
	patch_direct_enemy_queries(U)
	patch_blocking_helpers(U)

	if not U or U._possession_skill_patched or not U.find_enemies_in_range or not U.find_soldiers_in_range then
		return
	end

	U._possession_skill_patched = true
	U._possession_skill_find_enemies_in_range = U.find_enemies_in_range
	U._possession_skill_find_soldiers_in_range = U.find_soldiers_in_range

	local raw_find_enemies = U._possession_skill_find_enemies_in_range
	local raw_find_soldiers = U._possession_skill_find_soldiers_in_range

	U.find_enemies_in_range = function(entities, origin, min_range, max_range, flags, bans, filter_func)
		if current_context then
			-- In an enemy script, "enemies" are its allies. Once possessed, that
			-- side becomes the player's soldiers and other possessed units.
			return raw_find_soldiers(entities, origin, min_range, max_range, flags, bans, filter_func)
		end

		return raw_find_enemies(entities, origin, min_range, max_range, flags, bans,
			combine_filter(filter_func, is_hostile_enemy))
	end

	U.find_soldiers_in_range = function(entities, origin, min_range, max_range, flags, bans, filter_func)
		if current_context then
			-- In an enemy script, "soldiers" are offensive targets. A possessed
			-- enemy must therefore search the still-hostile enemy side instead.
			return raw_find_enemies(entities, origin, min_range, max_range, flags, bans,
				combine_filter(filter_func, is_hostile_enemy))
		end

		return raw_find_soldiers(entities, origin, min_range, max_range, flags, bans, filter_func)
	end

	if U.find_foremost_enemy then
		U._possession_skill_find_foremost_enemy = U.find_foremost_enemy
		local raw_find_foremost = U.find_foremost_enemy

		U.find_foremost_enemy = function(entities, origin, min_range, max_range, prediction_time, flags, bans, filter_func, min_override_flags)
			if current_context then
				local targets = raw_find_soldiers(entities, origin, min_range, max_range, flags, bans, filter_func)

				if not targets or #targets == 0 then
					return nil, nil, nil
				end

				table.sort(targets, function(a, b)
					return V.dist2(a.pos.x, a.pos.y, origin.x, origin.y) < V.dist2(b.pos.x, b.pos.y, origin.x, origin.y)
				end)

				return targets[1], targets, V.vclone(targets[1].pos)
			end

			return raw_find_foremost(entities, origin, min_range, max_range, prediction_time, flags, bans,
				combine_filter(filter_func, is_hostile_enemy), min_override_flags)
		end
	end

	if U.find_enemies_in_paths then
		U._possession_skill_find_enemies_in_paths = U.find_enemies_in_paths
		local raw_find_paths = U.find_enemies_in_paths

		U.find_enemies_in_paths = function(entities, origin, min_node_range, max_node_range, max_path_dist, flags, bans, only_upstream, filter_func)
			local faction_filter = current_context and is_possessed_friend or is_hostile_enemy

			return raw_find_paths(entities, origin, min_node_range, max_node_range, max_path_dist,
				flags, bans, only_upstream,
				combine_filter(filter_func, faction_filter))
		end
	end
end

local function patch_loaded_utilities()
	for _, module_name in ipairs(utility_modules) do
		patch_utility(package.loaded[module_name])
	end
end

local function invert_attack_faction(attack)
	if not attack or attack._possession_skill_faction_state then
		return
	end

	attack._possession_skill_faction_state = {
		vis_bans = attack.vis_bans,
		vis_flags = attack.vis_flags,
		damage_bans = attack.damage_bans,
		damage_flags = attack.damage_flags
	}

	attack.vis_bans = swap_faction_flags(attack.vis_bans)
	attack.vis_flags = swap_faction_flags(attack.vis_flags)
	attack.damage_bans = swap_faction_flags(attack.damage_bans)
	attack.damage_flags = swap_faction_flags(attack.damage_flags)
end

local function restore_attack_faction(attack)
	local state = attack and attack._possession_skill_faction_state

	if not state then
		return
	end

	attack.vis_bans = state.vis_bans
	attack.vis_flags = state.vis_flags
	attack.damage_bans = state.damage_bans
	attack.damage_flags = state.damage_flags
	attack._possession_skill_faction_state = nil
end

local function each_attack(entity, fn)
	for _, component_name in ipairs({"melee", "ranged", "timed_attacks", "attacks"}) do
		local component = entity[component_name]
		local list = component and (component.attacks or component.list)

		if list then
			for _, attack in pairs(list) do
				fn(attack)
			end
		end
	end
end

local function source_parent_id(entity)
	if not entity then
		return nil
	end

	return entity.bullet and entity.bullet.source_id or
		entity.aura and entity.aura.source_id or
		entity.modifier and entity.modifier.source_id or
		entity.spell and entity.spell.source_id or
		entity.spawner and entity.spawner.owner_id or
		entity.source_id or entity.owner_id
end

local function is_friendly_source(store, source_id, target_id, seen)
	if type(source_id) == "table" then
		source_id = source_id.id
	end

	if not store or not source_id or source_id == target_id then
		return false
	end

	seen = seen or {}

	if seen[source_id] then
		return false
	end

	seen[source_id] = true

	local source = store.entities[source_id]

	if not source then
		return false
	end

	if source._possession_skill_active or source._possession_skill_effect or source.tower or source.hero or source.soldier and not source.enemy then
		return true
	end

	if source.enemy then
		return false
	end

	if source.vis and band(source.vis.flags or 0, F_FRIEND) ~= 0 and band(source.vis.flags or 0, F_ENEMY) == 0 then
		return true
	end

	return is_friendly_source(store, source_parent_id(source), target_id, seen)
end

local function is_friendly_damage(entity, store, damage)
	if not damage then
		return false
	end

	return is_friendly_source(store, damage.source_id, entity.id) or
		is_friendly_source(store, damage.combat_stats_source_id, entity.id) or
		is_friendly_source(store, damage.xp_dest_id, entity.id)
end

local function install_friendly_damage_guard(entity, state)
	if not entity.health then
		return
	end

	state.health_on_damage = entity.health.on_damage

	local function damage_guard(this, store, damage)
		if this._possession_skill_active and is_friendly_damage(this, store, damage) then
			return false
		end

		return not state.health_on_damage or state.health_on_damage(this, store, damage)
	end

	state.health_on_damage_guard = damage_guard
	entity.health.on_damage = damage_guard
end

local function restore_friendly_damage_guard(entity, state)
	if entity.health and entity.health.on_damage == state.health_on_damage_guard then
		entity.health.on_damage = state.health_on_damage
	end
end

local function invert_effect_faction(entity)
	for _, component_name in ipairs({"bullet", "aura", "modifier", "spell", "spawner"}) do
		local component = entity[component_name]

		if component then
			for _, field in ipairs({"vis_flags", "vis_bans", "damage_flags", "damage_bans"}) do
				component[field] = swap_faction_flags(component[field])
			end
		end
	end
end

local function blocker_list_contains(blockers, entity_id)
	if not blockers then
		return false
	end

	for _, blocker_id in pairs(blockers) do
		if blocker_id == entity_id then
			return true
		end
	end

	return false
end

local function remove_from_blocker_list(blockers, entity_id)
	if not blockers then
		return
	end

	for i = #blockers, 1, -1 do
		if blockers[i] == entity_id then
			table.remove(blockers, i)
		end
	end
end

clear_virtual_blocker = function(entity, store)
	local target_id = entity and entity._possession_skill_virtual_blocker

	if not target_id then
		return
	end

	local target = store and store.entities[target_id]

	if target and target.enemy then
		remove_from_blocker_list(target.enemy.blockers, entity.id)
	end

	local enemy = possession_enemy(entity)

	if enemy then
		remove_from_blocker_list(enemy.blockers, target_id)
	end

	if entity.soldier and entity.soldier.target_id == target_id then
		entity.soldier.target_id = nil
	end

	entity._possession_skill_virtual_blocker = nil
	entity._possession_skill_slot_ready = nil
end

local function stop_for_virtual_block(entity)
	if not entity or not entity.motion then
		return
	end

	entity.motion.arrived = true

	if entity.motion.speed then
		entity.motion.speed.x = 0
		entity.motion.speed.y = 0
	end
end

local function move_to_virtual_blocker_slot(entity, target, store)
	local U = package.loaded.utils_5 or package.loaded.utils_pld or package.loaded.utils_57 or
		package.loaded.utils_4 or package.loaded.utils_123 or package.loaded.utils

	if not U or not U.melee_slot_position or not U.set_destination or not U.walk or
			not entity.pos or not entity.motion or not target or not target.enemy then
		return false
	end

	local slot_pos = U.melee_slot_position(entity, target)

	if not slot_pos then
		return false
	end

	if V.veq(slot_pos, entity.pos) then
		entity.motion.arrived = true

		return false
	end

	U.set_destination(entity, slot_pos)

	if U.animation_name_facing_point and U.animation_start then
		local animation, flip_x = U.animation_name_facing_point(entity, "walk", slot_pos)

		U.animation_start(entity, animation, flip_x, store.tick_ts, -1)
	end

	local arrived = U.walk(entity, store.tick_length)

	if arrived and U.animation_name_facing_point and U.animation_start then
		local animation_name = entity.melee and entity.melee.arrived_slot_animation or "idle"
		local animation, flip_x = U.animation_name_facing_point(entity, animation_name, target.pos)

		U.animation_start(entity, animation, flip_x, store.tick_ts, -1)
	end

	-- Match soldier_move_to_slot_step: arriving consumes this tick, and the
	-- native combat coroutine resumes on the next tick without resetting idle.
	return true
end

local function bind_virtual_blocker(entity, target, store)
	local enemy = possession_enemy(entity)

	if not enemy then
		return false
	end

	if not blocker_list_contains(target.enemy.blockers, entity.id) then
		table.insert(target.enemy.blockers, entity.id)
	end

	remove_from_blocker_list(enemy.blockers, target.id)
	table.insert(enemy.blockers, 1, target.id)
	entity.soldier.target_id = target.id
	entity._possession_skill_virtual_blocker = target.id

	local moving_to_slot = false

	if entity._possession_skill_slot_ready ~= target.id then
		-- Slot movement belongs to the engagement phase. Once native combat has
		-- started, never overwrite an attack animation between coroutine yields.
		moving_to_slot = move_to_virtual_blocker_slot(entity, target, store)

		if not moving_to_slot then
			entity._possession_skill_slot_ready = target.id
		end
	end

	stop_for_virtual_block(target)

	return moving_to_slot
end

local function refresh_virtual_blocker(entity, store)
	local enemy = possession_enemy(entity)

	if not entity or not enemy or not enemy.blockers or not entity.soldier or not entity.melee then
		return false
	end

	if entity.health and entity.health.dead or entity.pending_removal or entity.unit and entity.unit.is_stunned then
		clear_virtual_blocker(entity, store)
		return false
	end

	local range = entity.melee.range or 45
	local range2 = range * range
	local target
	local target_dist2
	local current_target = store.entities[entity._possession_skill_virtual_blocker]

	if current_target and is_hostile_enemy(current_target) and current_target.health and
			not current_target.health.dead and not current_target.pending_removal and current_target.pos and
			current_target.vis and current_target.enemy and current_target.enemy.blockers and
			band(current_target.vis.bans or 0, F_BLOCK) == 0 then
		-- A valid melee slot can lie outside the nominal acquisition range.
		-- Once blocking is established, keep it until normal combat invalidates it.
		return bind_virtual_blocker(entity, current_target, store)
	end

	clear_virtual_blocker(entity, store)

	for _, candidate in pairs(store.entities) do
		if is_hostile_enemy(candidate) and candidate.health and not candidate.health.dead and candidate.pos and candidate.vis and
			candidate.enemy.blockers and not candidate.pending_removal and
			band(candidate.vis.bans or 0, F_BLOCK) == 0 and
			(not candidate.enemy.max_blockers or #candidate.enemy.blockers < candidate.enemy.max_blockers) then
			local dist2 = V.dist2(candidate.pos.x, candidate.pos.y, entity.pos.x, entity.pos.y)

			if dist2 <= range2 and (not target_dist2 or dist2 < target_dist2) then
				target = candidate
				target_dist2 = dist2
			end
		end
	end

	if target then
		return bind_virtual_blocker(entity, target, store)
	end

	return false
end

function M.contextual_update(this, store, script)
	local co = this._possession_skill_original_co

	if not co and this._possession_skill_original_update then
		co = coroutine.create(this._possession_skill_original_update)
		this._possession_skill_original_co = co
	end

	if not co then
		return
	end

	while coroutine.status(co) ~= "dead" do
		patch_loaded_utilities()
		local attached_enemies = attach_context_enemies(this, store)
		local previous_context = current_context
		current_context = this

		local protected_ok, resume_ok, err, moving_to_slot = pcall(function()
			if refresh_virtual_blocker(this, store) then
				return true, nil, true
			end

			local ok, resume_err = coroutine.resume(co, this, store, script)

			return ok, resume_err, false
		end)

		current_context = previous_context
		detach_context_enemies(attached_enemies)

		if not protected_ok then
			error(resume_ok)
		end

		if not resume_ok then
			error(err)
		end

		if not moving_to_slot and coroutine.status(co) == "dead" then
			return
		end

		coroutine.yield()
	end
end

function M.wrap_entity(entity)
	local script = entity and entity.main_script

	if not script or not script.update or script.update == M.contextual_update then
		return
	end

	entity._possession_skill_original_update = script.update
	entity._possession_skill_original_co = script.co
	entity._possession_skill_original_runs = script.runs
	script.update = M.contextual_update
	script.co = nil
	script.runs = 1
end

function M.unwrap_entity(entity)
	local script = entity and entity.main_script

	if not script or not entity._possession_skill_original_update then
		return
	end

	script.update = entity._possession_skill_original_update
	script.co = entity._possession_skill_original_co
	script.runs = entity._possession_skill_original_runs or 1
	entity._possession_skill_original_update = nil
	entity._possession_skill_original_co = nil
	entity._possession_skill_original_runs = nil
end

function M.convert_enemy(entity, permanent)
	if not entity or not entity.enemy or entity._possession_skill_active then
		return false
	end

	entity._possession_skill_active = true
	entity._possession_skill_permanent = permanent or nil
	local original_enemy = entity.enemy

	entity._possession_skill_state = {
		enemy = original_enemy,
		vis_flags = entity.vis and entity.vis.flags,
		nav_dir = entity.nav_path and entity.nav_path.dir,
		soldier = entity.soldier,
		nav_rally = entity.nav_rally,
		lives_cost = original_enemy.lives_cost
	}
	local state = entity._possession_skill_state

	if entity.vis then
		entity.vis.flags = swap_faction_flags(entity.vis.flags)
	end

	if entity.nav_path then
		entity.nav_path.dir = -1
	end

	original_enemy.lives_cost = 0

	if permanent then
		original_enemy.gold = 0
		original_enemy.gems = 0
	end

	entity.soldier = entity.soldier or {}
	entity.soldier.melee_slot_offset = entity.soldier.melee_slot_offset or V.v(
		original_enemy.melee_slot and original_enemy.melee_slot.x / 2 or 0,
		original_enemy.melee_slot and original_enemy.melee_slot.y or 0)
	entity.nav_rally = entity.nav_rally or {new = false}
	entity._blazing_deselect = true

	install_friendly_damage_guard(entity, state)
	each_attack(entity, invert_attack_faction)
	M.wrap_entity(entity)
	-- Match the legacy possession contract: outside the possessed unit's own
	-- coroutine it is a soldier, never an enemy target. Its native script gets
	-- the saved component back only while it is actively running.
	entity.enemy = nil

	return true
end

function M.restore_enemy(entity, store)
	local state = entity and entity._possession_skill_state

	if not entity or not state or entity._possession_skill_permanent then
		return
	end

	clear_virtual_blocker(entity, store)
	M.unwrap_entity(entity)
	entity.enemy = state.enemy

	if entity.vis and state.vis_flags ~= nil then
		entity.vis.flags = state.vis_flags
	end

	if entity.nav_path then
		entity.nav_path.dir = state.nav_dir or 1
	end

	if state.enemy then
		state.enemy.lives_cost = state.lives_cost
	end

	entity.soldier = state.soldier
	entity.nav_rally = state.nav_rally
	entity._blazing_deselect = false
	each_attack(entity, restore_attack_faction)
	restore_friendly_damage_guard(entity, state)

	-- Keep the tag until every original combat field has been restored. Tower
	-- queries may run between systems in the same tick.
	entity._possession_skill_active = nil
	entity._possession_skill_permanent = nil
	entity._possession_skill_state = nil
end

M.clear_virtual_blocker = clear_virtual_blocker

local function mark_spawned_entity(entity)
	if not entity or entity._possession_skill_effect then
		return
	end

	entity._possession_skill_effect = true
	invert_effect_faction(entity)

	if entity.enemy then
		M.convert_enemy(entity, true)
	elseif entity.main_script and entity.main_script.update then
		M.wrap_entity(entity)
	end
end

local function patch_simulation()
	if not simulation or simulation._possession_skill_patched then
		return
	end

	simulation._possession_skill_patched = true
	simulation._possession_skill_queue_insert_entity = simulation.queue_insert_entity

	function simulation:queue_insert_entity(entity)
		if current_context then
			mark_spawned_entity(entity)
		end

		return self:_possession_skill_queue_insert_entity(entity)
	end

	if simulation.queue_insert_entity_exit then
		simulation._possession_skill_queue_insert_entity_exit = simulation.queue_insert_entity_exit

		function simulation:queue_insert_entity_exit(entity)
			if current_context then
				mark_spawned_entity(entity)
			end

			return self:_possession_skill_queue_insert_entity_exit(entity)
		end
	end

	simulation._possession_skill_insert_entity = simulation.insert_entity

	function simulation:insert_entity(entity)
		if not entity or not (entity._possession_skill_active or entity._possession_skill_effect) then
			return self:_possession_skill_insert_entity(entity)
		end

		local previous_context = current_context
		current_context = entity
		local attached_enemies = attach_context_enemies(entity, self.store)
		local ok, err = pcall(self._possession_skill_insert_entity, self, entity)
		detach_context_enemies(attached_enemies)
		current_context = previous_context

		if not ok then
			error(err)
		end
	end

	simulation._possession_skill_remove_entity = simulation.remove_entity

	function simulation:remove_entity(entity)
		if not entity or not (entity._possession_skill_active or entity._possession_skill_effect) then
			return self:_possession_skill_remove_entity(entity)
		end

		if entity._possession_skill_active then
			clear_virtual_blocker(entity, self.store)
		end

		local previous_context = current_context
		current_context = entity
		local attached_enemies = attach_context_enemies(entity, self.store)
		local ok, err = pcall(self._possession_skill_remove_entity, self, entity)
		detach_context_enemies(attached_enemies)
		current_context = previous_context

		if not ok then
			error(err)
		end
	end
end

function M.install()
	patch_loaded_utilities()
	patch_simulation()
end

function M.mark_existing_children(store, source_id)
	if not store or not source_id then
		return
	end

	for _, entity in pairs(store.entities) do
		local child_source = entity.bullet and entity.bullet.source_id or
			entity.aura and entity.aura.source_id or
			entity.modifier and entity.modifier.source_id or
			entity.spell and entity.spell.source_id or
			entity.spawner and entity.spawner.owner_id or
			entity.source_id or entity.owner_id

		if child_source == source_id and entity.id ~= source_id then
			mark_spawned_entity(entity)
		end
	end
end

return M
