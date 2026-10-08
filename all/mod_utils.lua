-- chunkname: @./all/mod_utils.lua

local log = require("klua.log"):new("mod_utils")
local A = require("animation_db")

require("klua.table")

local mod_utils = {}
local MISSING_VALUE = {}

mod_utils.auto_table_mt = {
	__index = function(t, key)
		local new = {}

		setmetatable(new, mod_utils.auto_table_mt)
		rawset(t, key, new)

		return new
	end
}

mod_utils.original_animations = {}

local function capture_original_animation(name)
	if mod_utils.original_animations[name] ~= nil then
		return
	end

	local original = A.db[name]

	mod_utils.original_animations[name] = original == nil and MISSING_VALUE or table.deepclone(original)
end

local function table_count(t)
	local count = 0

	for _ in pairs(t) do
		count = count + 1
	end

	return count
end

function mod_utils.a_db_reset(t)
	local added_a = {}
	local deleted_k = {}

	for k, v in pairs(t) do
		if v.removed then
			table.insert(deleted_k, k)
		elseif v.layer_from and v.layer_to and v.layer_prefix then
			for i = v.layer_from, v.layer_to do
				local nk = string.gsub(k, "layerX", "layer" .. i)
				local nv = {
					fps = v.fps,
					group = v.group,
					pre = v.pre,
					post = v.post,
					from = v.from,
					to = v.to,
					ranges = v.ranges,
					frames = v.frames,
					prefix = string.format(v.layer_prefix, i)
				}

				added_a[nk] = nv
				table.insert(deleted_k, k)
			end
		else
			added_a[k] = v
		end
	end

	for k, v in pairs(added_a) do
		capture_original_animation(k)

		if not A.db[k] then
			A.db[k] = v
		else
			table.merge(A.db[k], v)
		end
	end

	for _, v in ipairs(deleted_k) do
		capture_original_animation(v)
		A.db[v] = nil
	end

	log.debug("applied UH animation patch: added=%s deleted=%s", table_count(added_a), #deleted_k)

	return added_a, deleted_k
end

function mod_utils.restore_a_db_reset()
	for k, v in pairs(mod_utils.original_animations) do
		if v == MISSING_VALUE then
			A.db[k] = nil
		else
			A.db[k] = table.deepclone(v)
		end
	end
end

return mod_utils
