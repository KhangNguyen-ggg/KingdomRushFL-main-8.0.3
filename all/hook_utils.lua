local log = require("klua.log"):new("hook_utils")
local hook_utils = {}

hook_utils.auto_table_mt = {
	__index = function(t, key)
		local value = {}

		setmetatable(value, hook_utils.auto_table_mt)
		rawset(t, key, value)

		return value
	end
}

function hook_utils:new()
	local value = {}

	setmetatable(value, self.auto_table_mt)

	return value
end

local function rebuild_chain(obj, fn_name)
	local hook_info = obj.__hooks[fn_name]
	local next_fn = hook_info.original

	for i = #hook_info.hooks, 1, -1 do
		local handler = hook_info.hooks[i].handler
		local following = next_fn

		next_fn = function(...)
			return handler(following, ...)
		end
	end

	obj[fn_name] = next_fn
end

function hook_utils.HOOK(obj, fn_name, handler, priority)
	if not obj or type(obj[fn_name]) ~= "function" or type(handler) ~= "function" then
		log.error("invalid hook target or handler for %s", tostring(fn_name))

		return false
	end

	priority = priority or 0
	obj.__hooks = obj.__hooks or {}
	obj.__hooks[fn_name] = obj.__hooks[fn_name] or {
		original = obj[fn_name],
		hooks = {}
	}

	for _, item in ipairs(obj.__hooks[fn_name].hooks) do
		if item.handler == handler then
			return false
		end
	end

	table.insert(obj.__hooks[fn_name].hooks, {
		handler = handler,
		priority = priority
	})
	table.sort(obj.__hooks[fn_name].hooks, function(a, b)
		return a.priority < b.priority
	end)
	rebuild_chain(obj, fn_name)

	return true
end

function hook_utils.UNHOOK(obj, fn_name, handler_to_remove)
	local hook_info = obj and obj.__hooks and obj.__hooks[fn_name]

	if not hook_info then
		return false
	end

	if handler_to_remove == nil then
		obj[fn_name] = hook_info.original
		obj.__hooks[fn_name] = nil

		return true
	end

	local removed = false

	for i = #hook_info.hooks, 1, -1 do
		if hook_info.hooks[i].handler == handler_to_remove then
			table.remove(hook_info.hooks, i)
			removed = true
		end
	end

	if removed then
		if #hook_info.hooks == 0 then
			obj[fn_name] = hook_info.original
			obj.__hooks[fn_name] = nil
		else
			rebuild_chain(obj, fn_name)
		end
	end

	return removed
end

function hook_utils.CALL_ORIGINAL(obj, fn_name, ...)
	local hook_info = obj and obj.__hooks and obj.__hooks[fn_name]
	local fn = hook_info and hook_info.original or obj[fn_name]

	return fn(obj, ...)
end

return hook_utils
