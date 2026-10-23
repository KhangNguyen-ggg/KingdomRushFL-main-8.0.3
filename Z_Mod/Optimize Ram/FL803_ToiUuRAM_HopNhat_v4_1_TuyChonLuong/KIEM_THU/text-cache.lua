sys.texts = {}
sys.texts.name = "texts"

local text_cache = {}
local text_cache_count, text_cache_bytes, text_serial = 0, 0, 0
local TEXT_CACHE_LIMIT, TEXT_CACHE_BYTES = 128, 8 * 1024 * 1024

local function text_cache_key(t, scale)
	local c = t.color
	return table.concat({string.format("%q", t.text), t.size.x, t.size.y,
		string.format("%q", t.alignment), string.format("%q", t.font_name), t.font_size,
		c[1], c[2], c[3], c[4] or 255, t.line_height or 1, scale or 1,
		tostring(t.fit_height), tostring(t.debug_bg)}, "|")
end

function sys.texts:clear_cache()
	for _, entry in pairs(text_cache) do I:remove_image(entry.name) end
	text_cache = {}
	text_cache_count, text_cache_bytes = 0, 0
end

function sys.texts:on_insert(entity, store)
	if entity.texts then
		for _, t in pairs(entity.texts.list) do
			local key = text_cache_key(t, store.screen_scale)
			local entry = text_cache[key]
			if not entry then
				-- Font rendering scales its size argument in place; keep entity data intact.
				local size = {x = t.size.x, y = t.size.y}
				local image = F:create_text_image(t.text, size, t.alignment, t.font_name, t.font_size, t.color, t.line_height, store.screen_scale, t.fit_height, t.debug_bg)
				local w, h = image:getDimensions()
				local bytes = w * h * 4
				if bytes <= TEXT_CACHE_BYTES then
					for old_key, old in pairs(text_cache) do
						if text_cache_count < TEXT_CACHE_LIMIT and text_cache_bytes + bytes <= TEXT_CACHE_BYTES then break end
						if old.refs == 0 then
							I:remove_image(old.name)
							text_cache[old_key] = nil
							text_cache_count = text_cache_count - 1
							text_cache_bytes = text_cache_bytes - old.bytes
						end
					end
				end
				text_serial = text_serial + 1
				entry = {name = "textcache_" .. text_serial, refs = 0, bytes = bytes}
				I:add_image(entry.name, image, "temp_game_texts", store.screen_scale)
				if text_cache_count < TEXT_CACHE_LIMIT and text_cache_bytes + bytes <= TEXT_CACHE_BYTES then
					text_cache[key] = entry
					text_cache_count = text_cache_count + 1
					text_cache_bytes = text_cache_bytes + bytes
				end
			end
			entry.refs = entry.refs + 1
			t.image_name = entry.name
			t.image_cache_key = text_cache[key] == entry and key or nil
			t.image_group = "texts"
			entity.render.sprites[t.sprite_id].name = entry.name
			entity.render.sprites[t.sprite_id].animated = false
		end
	end
	return true
end

function sys.texts:on_remove(entity, store)
	if entity.texts then
		for _, t in pairs(entity.texts.list) do
			local entry = t.image_cache_key and text_cache[t.image_cache_key]
			if entry and entry.name == t.image_name then
				entry.refs = math.max(0, entry.refs - 1)
			elseif t.image_name then
				I:remove_image(t.image_name)
			end
			t.image_name, t.image_cache_key = nil, nil
		end
	end
	return true
end

