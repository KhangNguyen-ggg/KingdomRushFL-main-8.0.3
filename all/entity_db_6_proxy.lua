local real = require("entity_db")

require("klua.table")

local shadow = {}
local proxy = {}

local function mark_kr6_template(template)
	if template then
		-- The merged animation database keeps other generations' names intact.
		-- Render lookup uses this template-level suffix only when a matching
		-- KR6 alias actually exists.
		template.animation_suffix = "_g6"
	end

	return template
end

setmetatable(proxy, {
	__index = function(_, key)
		local value = real[key]

		if type(value) == "function" then
			return function(_, ...)
				return value(real, ...)
			end
		end

		return value
	end
})

function proxy:register_t(name, base)
	local local_base = base

	if type(base) == "string" then
		local_base = shadow[base] or real.entities[base]
	end

	if real.entities[name] then
		-- Enemy names are used by waves and E:create_entity at runtime. Keeping
		-- a colliding KR6 enemy only in shadow would silently spawn the older
		-- generation's template instead. Base templates are never spawned.
		if name:match("^enemy_") and name ~= "enemy_KR5" then
			error("KR6 enemy template collides with an earlier generation: " .. name .. " (use a _g6 name)")
		end

		local template = table.deepclone(local_base or real.entities[name])

		template.template_name = name
		shadow[name] = template

		return mark_kr6_template(template)
	end

	local template = real:register_t(name, local_base or base)

	shadow[name] = template

	return mark_kr6_template(template)
end

function proxy:get_template(name)
	return shadow[name] or real:get_template(name)
end

function proxy:set_template(name, template)
	mark_kr6_template(template)

	if real.entities[name] then
		shadow[name] = template
	else
		real:set_template(name, template)
		shadow[name] = template
	end
end

return proxy
