-- Bind only allied Set to the frame names actually present in the loaded atlas.
local A = require("animation_db")
local I = require("klove.image_db")
local M = {}
local function normalized(name) return name:lower():gsub("[^%w]", "") end

function M.bind(template)
	local sprite = template.render.sprites[1]
	local prefix = sprite.prefix .. "_"
	local available
	local function resolve(animation)
		local first = animation.frames and animation.frames[1] or animation.from or 1
		if I:s(string.format("%s_%04i", animation.prefix, first), true) then return animation end
		if not available then
			available = {}
			for name in pairs(I.db_atlas or {}) do
				local frame_prefix, frame = name:match("^(.-)_(%d+)$")
				if frame_prefix then
					local key = normalized(frame_prefix)
					if key:sub(1, 3) == "set" then
						local entry = available[key]
						if not entry then entry = {prefix=frame_prefix, frames={}}; available[key]=entry end
						entry.frames[tonumber(frame)] = true
					end
				end
			end
		end
		local found = available[normalized(animation.prefix)]
		if not found then return nil end
		local remapped = {}
		for k,v in pairs(animation) do remapped[k]=v end
		remapped.prefix = found.prefix
		-- Keep the original frame order/timing; every requested frame must exist.
		local frames = animation.frames
		if not frames then
			frames = {}
			for _,frame in ipairs(animation.pre or {}) do frames[#frames+1]=frame end
			if animation.from and animation.to then
				for frame=animation.from,animation.to,animation.from>animation.to and -1 or 1 do frames[#frames+1]=frame end
			end
			for _,frame in ipairs(animation.post or {}) do frames[#frames+1]=frame end
		end
		for _,frame in ipairs(frames) do if not found.frames[frame] then return nil end end
		remapped.frames = frames
		return remapped
	end
	for key,animation in pairs(A.db) do
		if key:sub(1,#prefix)==prefix and type(animation)=="table" and animation.prefix then
			local resolved=resolve(animation)
			if resolved then A.db[key]=resolved end
		end
	end
	sprite.hidden, sprite.alpha = false, 255
	local idle = A.db[prefix.."idle"]
	local frame = idle and string.format("%s_%04i",idle.prefix,idle.frames and idle.frames[1] or idle.from or 1)
	if not frame or not I:s(frame,true) then
		-- Record missing assets rather than replacing Set with an unrelated hero.
		local names={}
		for name in pairs(I.db_atlas or {}) do if normalized(name):sub(1,3)=="set" then names[#names+1]=name end end
		table.sort(names)
		local lines={"Set idle frame missing: "..tostring(frame), "Loaded Set frames:",table.concat(names,"\n")}
		pcall(function()
			local file=io.open("KRFL_Set_Render.txt","w")
			if file then file:write(table.concat(lines,"\n"));file:close() end
		end)
	end
end
return M
