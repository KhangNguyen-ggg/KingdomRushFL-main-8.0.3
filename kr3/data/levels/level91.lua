local E = require("entity_db")
local signal = require("hump.signal")
local LU = require("level_utils")
local P = require("path_db")
local U = require("utils")
local V = require("klua.vector")
local bit = require("bit")

require("constants")

local band = bit.band
local bor = bit.bor
local level = {}

local ALTAR_DAMAGE_BASE = 10
local ALTAR_DAMAGE_PER_WAVE = 2
local ALTAR_DAMAGE_INTERVAL = 1
local ALTAR_DEBUFF_INTERVAL = 0.2
local ALTAR_EXECUTE_BASE_THRESHOLD = 0.75

local function find_entity(store, template_name)
	for _, entity in pairs(store.entities) do
		if entity.template_name == template_name and not entity.pending_removal then
			return entity
		end
	end
end

local function is_allied_unit(entity)
	return not entity.pending_removal and (entity.soldier or entity.hero) and entity.health and entity.health.hp_max > 0
end

local function normalized_physical_armor(target)
	if band(target.health.immune_to or 0, DAMAGE_PHYSICAL) ~= 0 then
		return 1
	end

	local armor = target.health.armor or 0

	if armor > 1 then
		armor = armor / 100
	end

	return math.max(0, math.min(armor, 1))
end

local function altar_execute_threshold(target)
	return target.health.hp_max * ALTAR_EXECUTE_BASE_THRESHOLD * (1 - normalized_physical_armor(target))
end

local function altar_damage_value(store)
	return ALTAR_DAMAGE_BASE + ALTAR_DAMAGE_PER_WAVE * (store.wave_group_number or 0)
end

local function apply_altar_respawn_debuff(store, source)
	for _, target in pairs(store.entities) do
		if is_allied_unit(target) and not target.health.dead then
			local mod = E:create_entity("mod_stage91_altar_respawn_delay")

			mod.modifier.source_id = source and source.id
			mod.modifier.target_id = target.id
			LU.queue_insert(store, mod)
		end
	end
end

local function damage_allied_units(store, source)
	for _, target in pairs(store.entities) do
		if is_allied_unit(target) and not target.health.dead then
			local damage = E:create_entity("damage")

			damage.source_id = source and source.id
			damage.target_id = target.id

			if target.health.hp < altar_execute_threshold(target) then
				damage.value = target.health.hp + target.health.hp_max
				damage.damage_type = bor(DAMAGE_TRUE, DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS, DAMAGE_NO_DODGE, DAMAGE_IGNORE_SHIELD)
			else
				damage.value = altar_damage_value(store)
				damage.damage_type = bor(DAMAGE_PHYSICAL, DAMAGE_NO_DODGE)
			end

			store.damage_queue[#store.damage_queue + 1] = damage
		end
	end
end

local function activate_moloch(store)
	local moloch = find_entity(store, "eb_moloch")

	if not moloch then
		return
	end

	moloch.preserve_wave_on_death = true

	if moloch.phase == "sitting" and not moloch.phase_signal then
		moloch.phase_signal = true
	end
end

function level:update(store)
	while store.wave_group_number < 1 do
		coroutine.yield()
	end

    signal.emit("wave-notification", "view", "TIP_CRYSTAL_ALTAR")

    while store.paused do
        coroutine.yield()
    end

	local altar = find_entity(store, "stage91_crystal_altar")
	local horror = E:create_entity("enemy_crystal_horror")
	local node = P:get_start_node(1) + 40

	horror.nav_path.pi = 1
	horror.nav_path.spi = 1
	horror.nav_path.ni = node
	horror.pos = V.vclone(P:node_pos(1, 1, node))
	LU.queue_insert(store, horror)
	U.mark_seen(store, horror.template_name)

	local next_damage_ts = store.tick_ts + ALTAR_DAMAGE_INTERVAL
	local next_debuff_ts = store.tick_ts

	while not horror.pending_removal and horror.health and not horror.health.dead do
		if store.tick_ts >= next_debuff_ts then
			apply_altar_respawn_debuff(store, altar)
			next_debuff_ts = next_debuff_ts + ALTAR_DEBUFF_INTERVAL
		end

		if store.tick_ts >= next_damage_ts then
			damage_allied_units(store, altar)
			next_damage_ts = next_damage_ts + ALTAR_DAMAGE_INTERVAL
		end

		coroutine.yield()
	end

	if altar and not altar.pending_removal then
		altar.destroyed = true
	end

	while not store.waves_finished or LU.has_alive_enemies(store) do
		activate_moloch(store)
		coroutine.yield()
	end
end

return level
