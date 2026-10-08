local legacy_upgrade_strings = {}

local generation_keys = {
	[1] = {
		"archer_salvage", "archer_eagle_eye", "archer_piercing", "archer_far_shots", "archer_precision",
		"barrack_survival", "barrack_better_armor", "barrack_improved_deployment", "barrack_survival_2", "barrack_barbed_armor",
		"mage_spell_reach", "mage_arcane_shatter", "mage_hermetic_study", "mage_empowered_magic", "mage_slow_curse",
		"engineer_concentrated_fire", "engineer_range_finder", "engineer_field_logistics", "engineer_industrialization", "engineer_efficiency",
		"rain_blazing_skies", "rain_scorched_earth", "rain_bigger_and_meaner", "rain_blazing_earth", "rain_cataclysm",
		"reinforcement_level_1", "reinforcement_level_2", "reinforcement_level_3", "reinforcement_level_4", "reinforcement_level_5"
	},
	[2] = {
		"archer_improved_aim", "archer_lumbermill", "archer_focused_aim", "archer_master_marksmanship", "archer_twin_shot",
		"barrack_defensive_techniques", "barrack_boot_camp", "barrack_esprit_des_corps", "barrack_veteran_squad", "barrack_courage",
		"mage_rune_of_power", "mage_spell_of_penetration", "mage_eldrich_power", "mage_wizard_academy", "mage_brilliance",
		"engineer_smoothbore", "engineer_alchemical_powder", "engineer_improved_ordnance", "engineer_gnomish_tinkering", "engineer_shock_and_awe",
		"rain_blazing_skies", "rain_scorched_earth", "rain_bigger_and_meaner", "rain_blazing_earth", "rain_cataclysm",
		"reinforcement_level_1", "reinforcement_level_2", "reinforcement_level_3", "reinforcement_level_4", "reinforcement_level_5"
	},
	[3] = {
		"archer_el_master_shooter", "archer_el_treesinged_bow", "archer_el_obsidian_heads", "archer_el_elven_training", "archer_el_bloodletting_shoot",
		"barrack_el_elven_fencing", "barrack_el_expert_tactician", "barrack_el_enchanted_armor", "barrack_el_moon_forged_blades", "barrack_el_cheat_death",
		"mage_el_crystal_focus", "mage_el_bane_spell", "mage_el_crystal_gazing", "mage_el_empowerment", "mage_el_alter_reality",
		"stone_el_druid_hardened_boulders", "stone_el_druid_sharp_splinters", "stone_el_druid_earth_mastery", "stone_el_druid_heavy_load", "stone_el_druid_shocking_impact",
		"thunder_level_1", "thunder_level_2", "thunder_level_3", "thunder_level_4", "thunder_level_5",
		"reinforcement_level_1", "reinforcement_level_2", "reinforcement_level_3", "reinforcement_level_4", "reinforcement_level_5"
	}
}

local function split(value, separator)
	local values = {}
	local start = 1

	while true do
		local first, last = string.find(value, separator, start, true)

		if not first then
			table.insert(values, string.sub(value, start))
			break
		end

		table.insert(values, string.sub(value, start, first - 1))
		start = last + 1
	end

	return values
end

local function reinforcement_g3_parts(description)
	for line in string.gmatch(description or "", "[^\n]+") do
		local prefix = "3代-"
		local prefix_start, prefix_end = string.find(line, prefix, 1, true)

		if prefix_start then
			local separator_start, separator_end = string.find(line, ":", prefix_end + 1, true)

			if not separator_start then
				separator_start, separator_end = string.find(line, "：", prefix_end + 1, true)
			end

			if separator_start then
				local name = string.sub(line, prefix_end + 1, separator_start - 1)
				local body = string.sub(line, separator_end + 1)

				return name, body
			end
		end
	end
end

local function clean_value(generation, key, suffix, value, description)
	if not value then
		return nil
	end

	if generation == 3 and string.find(key, "reinforcement_level_", 1, true) == 1 then
		local name, body = reinforcement_g3_parts(description)

		if suffix == "NAME" and name then
			return name
		elseif suffix == "DESCRIPTION" and body then
			return body
		end
	end

	if suffix == "NAME" then
		local parts = split(value, "/")

		if #parts >= 3 then
			return parts[generation]
		elseif #parts == 2 and (string.find(key, "rain_", 1, true) == 1 or string.find(key, "thunder_", 1, true) == 1) then
			return generation == 3 and parts[1] or parts[2]
		end
	else
		local lines = split(value, "\n")

		if #lines >= 3 then
			return lines[generation]
		elseif #lines == 2 and (string.find(key, "rain_", 1, true) == 1 or string.find(key, "thunder_", 1, true) == 1) then
			return generation == 3 and lines[1] or lines[2]
		end
	end

	return value
end

local function source_value(sources, generation, key)
	local value = sources[generation] and sources[generation][key]

	if value ~= nil then
		return value
	end

	for _, source in ipairs(sources) do
		if source[key] ~= nil then
			return source[key]
		end
	end
end

function legacy_upgrade_strings.apply(target, sources)
	for generation, keys in ipairs(generation_keys) do
		for _, key in ipairs(keys) do
			local name_key = key .. "_NAME"
			local description_key = key .. "_DESCRIPTION"
			local raw_description = source_value(sources, generation, description_key)

			target[string.format("LEGACY_G%d_%s_NAME", generation, key)] = clean_value(generation, key, "NAME", source_value(sources, generation, name_key), raw_description)
			target[string.format("LEGACY_G%d_%s_DESCRIPTION", generation, key)] = clean_value(generation, key, "DESCRIPTION", raw_description, raw_description)
		end
	end

	return target
end

return legacy_upgrade_strings
