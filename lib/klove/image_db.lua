-- chunkname: @./lib/klove/image_db.lua

local log = require("klua.log"):new("image_db")
local G = love.graphics
local FS = love.filesystem

require("klua.table")
require("klua.dump")

local km = require("klua.macros")

local function is_file(path)
	if FS.getInfo then
		local info = FS.getInfo(path)

		return info and info.type == "file"
	end

	return FS.isFile and FS.isFile(path)
end

local function krflapk_supported_image_formats()
	if G.getCompressedImageFormats then
		local ok, formats = pcall(G.getCompressedImageFormats)

		if ok and formats then
			return formats
		end
	end

	if G.getImageFormats then
		local ok, formats = pcall(G.getImageFormats)

		if ok and formats then
			return formats
		end
	end

	return {}
end

local image_db = {}

local persistent_textures = {}

for _, name in ipairs({
	-- These atlases are needed by almost every in-game load and always use the
	-- same game/game_gui scale in this project. Keep them resident like Dove
	-- does, so restarting/changing levels does not re-parse and re-upload them.
	"go_decals",
	"go_enemies_common",
	"go_towers",
	"go_towers_1",
	"go_towers_2",
	"go_towers_44",
	"go_towers_1-galaxy",
	"go_towers_special",
	"go_barrack_pirates",
	"gui_common_123mod",
	"kr4_sapos",
	"kr4_hero_power",
	"kr5_hero_power",
	"gui_common_v",
	"gui_portraits_v",
	"go_towers_v",
	"terrains_5",
	"terrains_4",
	"terrains_6",
	"go_commons"
}) do
	persistent_textures[name] = true
end

image_db.db_images = {}
image_db.db_atlas = {}
image_db.db_atlas_shadow = {}
image_db.atlas_uses = {}
image_db.load_queue = {}
image_db.load_queue_current = nil
image_db.progress = 0
image_db.groups_total = 0
image_db.groups_done = 0
image_db.missing_images = {}
image_db.missing_sprites = {}
image_db.threads = {}
image_db.image_name_queue = {}
image_db.queue_load_total_images = 0
image_db.queue_load_done_images = 0
image_db.use_canvas = true
image_db.release_compressed_data = false
image_db.queue_preload_groups_per_frame = 9999
image_db.unload_queue = {}
image_db.unload_queue_total = 0
image_db.unload_queue_done = 0
image_db.queue_unload_groups_per_frame = 1
image_db.supportedformats = krflapk_supported_image_formats()

local function calculate_image_thread_count()
	local cpu_count = love.system and love.system.getProcessorCount and love.system.getProcessorCount() or 4

	cpu_count = tonumber(cpu_count) or 4

	if cpu_count <= 1 then
		return 2
	elseif cpu_count <= 2 then
		return 4
	elseif cpu_count <= 4 then
		return 6
	elseif cpu_count <= 8 then
		return 8
	elseif cpu_count <= 16 then
		return 12
	else
		return 16
	end
	return 16
end

local _MAX_THREADS = calculate_image_thread_count()
local _LOAD_IMAGE_THREAD_CODE = [[
local cin,cout,th_i = ...
require 'love.filesystem'
require 'love.image'
require 'love.timer'

local function is_file(path)
	local info = love.filesystem.getInfo and love.filesystem.getInfo(path)

	if info then
		return info.type == 'file'
	end

	return love.filesystem.isFile and love.filesystem.isFile(path)
end

-- KRFLAPK_THREAD_FILESYSTEM_COMPAT
local file_count = 0
while true do
	local fn = cin:demand()

	if fn == 'QUIT' then
		goto quit
	end

	local path = cin:demand()
	local f = path .. '/' .. fn

	if not is_file(f) then
		cout:push({'ERROR','Not a file',f})
	else
		local data

		if string.match(fn, '%.pkm%.lz4$') or string.match(fn, '%.ktx%.lz4$') or string.match(fn, '%.ktx$') or string.match(fn, '%.pkm$') or string.match(fn, '%.astc$') or string.match(fn, '%.dds$') then
			data = love.image.newCompressedData(f)
		else
			data = love.image.newImageData(f)
		end

		if not data then
			cout:push({'ERROR','Image could not be loaded',f})
		else
			file_count = file_count + 1

			local w,h = data:getDimensions()
			local key = string.gsub(fn, '%.png$', '')

			key = string.gsub(key, '%.lz4$', '')
			key = string.gsub(key, '%.jpg$', '')
			key = string.gsub(key, '%.pkm$', '')
			key = string.gsub(key, '%.ktx$', '')
			key = string.gsub(key, '%.astc$', '')
			key = string.gsub(key, '%.dds$', '')

			cout:push({'OK',key,data,w,h})
		end
	end
end

::quit::
cout:supply({'DONE'})
]]

function image_db:setMaxThreads(value)
	-- max_threads is optional on the mobile configuration.  Do not replace the
	-- automatically detected value with nil when director:init forwards the
	-- unset parameter.
	local thread_count = tonumber(value)

	if thread_count then
		_MAX_THREADS = math.max(1, math.floor(thread_count))
	end
end

function image_db:get_short_stats()
	local count_frames = 0
	local o = ""
	local list = {}

	o = o .. "Atlas frames count: "

	for k, v in pairs(self.db_atlas) do
		count_frames = count_frames + 1
	end

	o = o .. count_frames .. "\n"
	o = o .. "Loaded images: "

	for k, v in pairs(self.db_images) do
		if v[1] then
			table.insert(list, k)
		end
	end

	table.sort(list)

	o = o .. table.concat(list, ", ")
	o = o .. "\nTexture memory (MB): " .. love.graphics.getStats().texturememory / 1048576

	return o
end

function image_db:get_stats(detailed)
	local count_images = 0
	local count_images_MB = 0
	local count_frames = 0
	local count_images_deferred = 0
	local o = ""

	o = o .. "Loaded images ------------------\n"

	local list = {}

	for k, v in pairs(self.db_images) do
		if v[1] then
			count_images = count_images + 1
			count_images_MB = count_images_MB + v[2] * v[3] * 4 / 1048576

			local line = k .. "    " .. v[2]

			if detailed then
				line = line .. "x" .. v[3] .. " (" .. mb .. ")"
			end

			line = line .. "\n"

			table.insert(list, line)
		else
			count_images_deferred = count_images_deferred + 1
		end
	end

	table.sort(list)

	for _, row in pairs(list) do
		o = o .. row
	end

	o = o .. "\n"
	o = o .. "Atlas usage---------------------\n"

	for k, v in pairs(self.atlas_uses) do
		o = o .. k .. ":" .. v .. "\n"
	end

	for k, v in pairs(self.db_atlas) do
		count_frames = count_frames + 1
	end

	o = o .. "\n"
	o = o .. "Counts---------------------\n"
	o = o .. "Total images: " .. count_images .. " (" .. count_images_MB .. " MB)\n"
	o = o .. "Total deferred images: " .. count_images_deferred .. "\n"
	o = o .. "Total frames: " .. count_frames .. "\n"
	o = o .. "\n"
	o = o .. "love.graphics.getStats()---\n"
	o = o .. getdump(love.graphics.getStats())

	return o
end

function image_db:queue_load_done()
	if #self.load_queue == 0 and #self.threads == 0 and #self.image_name_queue == 0 then
		self.progress = 1
		self.groups_total = 0

		return true
	end

	if not self.queue_load_start_time then
		self.queue_load_start_time = love.timer.getTime()
	end

	if #self.load_queue > 0 and #self.threads == 0 then
		local batch_count = math.min(#self.load_queue, self.queue_preload_groups_per_frame or #self.load_queue)

		for i = 1, batch_count do
			local item = table.remove(self.load_queue, 1)
			local ref_scale, path, name = unpack(item)
			local image_names = self:preload_atlas(ref_scale, path, name)

			self.groups_done = self.groups_done + 1

			if image_names then
				for n in pairs(image_names) do
					table.insert(self.image_name_queue, {
						n,
						path
					})

					self.queue_load_total_images = self.queue_load_total_images + 1
				end
			end
		end

		if #self.load_queue > 0 then
			self.progress = self.groups_total > 0 and 0.2 * self.groups_done / self.groups_total or 0

			return false
		end
	end

	if #self.image_name_queue == 0 and #self.threads == 0 then
		log.info("Done loading atlas queue. | time: %s", love.timer.getTime() - self.queue_load_start_time)

		self.queue_load_start_time = nil
		self.progress = 1
		self.groups_total = 0
		self.groups_done = 0
		self.queue_load_total_images = 0
		self.queue_load_done_images = 0
		self.image_name_queue = {}
		self.load_queue_quit_sent = nil

		return true
	end

	-- Keep this boundary defensive as old/mobile save settings may also contain
	-- a missing or non-numeric max_threads value.
	local queue_max_threads = tonumber(_MAX_THREADS) or calculate_image_thread_count()

	if #self.threads == 0 then
		for i = 1, math.min(#self.image_name_queue, queue_max_threads) do
			local th = love.thread.newThread(_LOAD_IMAGE_THREAD_CODE)
			local cin = love.thread.newChannel()
			local cout = love.thread.newChannel()

			th:start(cin, cout, i)

			if love.nx then
				th:setAffinity({
					false,
					true,
					true
				})
				log.paranoid(" ++++ IMAGE_DB THREAD %s AFFINITY %s", th, getdump(th:getAffinity()))
			end

			table.insert(self.threads, {
				th,
				cin,
				cout
			})
		end

		self.last_thread_used = 1
	end

	if #self.image_name_queue > 0 then
		for j = 1, #self.image_name_queue do
			local image_name, path = unpack(table.remove(self.image_name_queue, 1))
			local cin = self.threads[self.last_thread_used][2]

			cin:push(image_name)
			cin:push(path)

			self.last_thread_used = km.zmod(self.last_thread_used + 1, #self.threads)
		end
	end

	if not self.load_queue_quit_sent then
		for i = 1, #self.threads do
			self.threads[i][2]:push("QUIT")
		end

		self.load_queue_quit_sent = true
	end

	if not love.graphics.isActive() then
		return false
	end

	for i = #self.threads, 1, -1 do
		local th, cin, cout = unpack(self.threads[i])

		if th:isRunning() then
			while true do
				local result = cout:pop()

				if not result then
					break
				end

				local r1, r2, r3, r4, r5 = unpack(result)

				if r1 == "DONE" then
					table.remove(self.threads, i)

					break
				elseif r1 == "ERROR" then
					log.error("Failed to load image file: %s. Error: %s", r3, r2)
					self.queue_load_done_images = self.queue_load_done_images + 1
				elseif r1 == "OK" then
					local key, data, w, h = r2, r3, r4, r5
					local im = G.newImage(data)

					if not im then
						log.error("Image could not be created: %s", key)
					else
						if self.use_canvas and not im:isCompressed() and not IS_ANDROID then
							log.paranoid(" +++ creating canvas %s", im)

							-- KRFLAPK_IMAGE_CANVAS_FALLBACK: some Android GPUs reject creating
							-- canvases for large loaded atlases even when the Image itself was created.
							local ok_canvas, c = pcall(G.newCanvas, w, h)

							if not ok_canvas or not c then
								log.error("KRFLAPK image canvas fallback for %s (%s x %s): %s", tostring(key), tostring(w), tostring(h), tostring(c))

								self.db_images[key] = {
									im,
									w,
									h
								}
							else
								G.setCanvas(c)
								G.setBlendMode("replace", "premultiplied")
								G.draw(im)
								G.setBlendMode("alpha", "alphamultiply")
								G.setCanvas()

								self.db_images[key] = {
									c,
									w,
									h
								}
								im = nil
							end
						else
							log.paranoid(" +++ keeping image %s", im)

							self.db_images[key] = {
								im,
								w,
								h
							}

							if im:isCompressed() and self.release_compressed_data then
								im:kReleaseCompressedData()
							end
						end

						self.queue_load_done_images = self.queue_load_done_images + 1
					end
				end
			end
		else
			log.error("Thread %s error:%s", i, th:getError())
			table.remove(self.threads, i)
		end
	end

	if #self.threads > 0 then
		self.progress = self.queue_load_done_images / self.queue_load_total_images

		return false
	end

	log.info("Done loading atlas queue. | time: %s", love.timer.getTime() - self.queue_load_start_time)

	self.queue_load_start_time = nil
	self.progress = 1
	self.groups_total = 0
	self.groups_done = 0
	self.queue_load_total_images = 0
	self.queue_load_done_images = 0
	self.image_name_queue = {}
	self.load_queue_quit_sent = nil

	return true
end

function image_db:queue_load_atlas(ref_scale, path, name)
	ref_scale = ref_scale or 1

	local name_scale = string.format("%s-%.6f", name, ref_scale)

	if persistent_textures[name] and self.atlas_uses[name_scale] then
		log.debug("persistent atlas %s already loaded", name_scale)

		return
	end

	log.debug("queued %s/%s-%.6f", path, name, ref_scale)
	table.insert(self.load_queue, {
		ref_scale,
		path,
		name
	})

	self.groups_total = self.groups_total + 1

	if #self.load_queue == 1 and not self.load_queue_current then
		self.progress = 0
		self.groups_done = 0
	end
end

function image_db:unload_atlas(name, ref_scale, defer_purge)
	ref_scale = ref_scale or 1

	if persistent_textures[name] then
		log.debug("persistent atlas %s-%.6f kept loaded", name, ref_scale)

		return
	end

	local name_scale = string.format("%s-%.6f", name, ref_scale)

	if not self.atlas_uses[name_scale] then
		log.info("atlas %s does not exist", name_scale)

		return
	end

	self.atlas_uses[name_scale] = self.atlas_uses[name_scale] - 1

	if self.atlas_uses[name_scale] > 0 then
		log.debug("atlas %s still in use", name)

		return
	end

	log.debug("unloading atlas %s-%.6f", name, ref_scale)

	self.atlas_uses[name_scale] = nil

	local remove_frames = {}
	local remove_images = {}

	for k, f in pairs(self.db_atlas) do
		if f.group == name_scale then
			table.insert(remove_frames, k)

			remove_images[f.atlas] = true
		end
	end

	local removed_images_count = 0

	for _, k in pairs(remove_frames) do
		local restored = false
		local stack = self.db_atlas_shadow[k]

		while stack and #stack > 0 do
			local previous = table.remove(stack)

			if previous.group ~= name_scale then
				self.db_atlas[k] = previous
				restored = true

				break
			end
		end

		if stack and #stack == 0 then
			self.db_atlas_shadow[k] = nil
		end

		if not restored then
			self.db_atlas[k] = nil
		end
	end

	for frame_name, stack in pairs(self.db_atlas_shadow) do
		for i = #stack, 1, -1 do
			local frame = stack[i]

			if frame.group == name_scale then
				remove_images[frame.atlas] = true
				table.remove(stack, i)
			end
		end

		if #stack == 0 then
			self.db_atlas_shadow[frame_name] = nil
		end
	end

	-- Atlas groups may share one texture file. Remove this group's frames first,
	-- then release only textures that no remaining frame still references.
	for image_name, _ in pairs(remove_images) do
		local still_used = false

		for _, frame in pairs(self.db_atlas) do
			if frame.atlas == image_name then
				still_used = true

				break
			end
		end

		if not still_used then
			for _, stack in pairs(self.db_atlas_shadow) do
				for _, frame in pairs(stack) do
					if frame.atlas == image_name then
						still_used = true

						break
					end
				end

				if still_used then
					break
				end
			end
		end

		if not still_used then
			self.db_images[image_name] = nil
			removed_images_count = removed_images_count + 1
		end
	end

	log.debug(" removed #frames:%s #images:%s ", #remove_frames, removed_images_count)

	if not defer_purge then
		self:purge_atlas()
		collectgarbage()
	end
end

function image_db:queue_unload_atlas(name, ref_scale)
	log.debug("queued unload %s-%.6f", name, ref_scale or 1)
	table.insert(self.unload_queue, {
		name,
		ref_scale
	})

	self.unload_queue_total = self.unload_queue_total + 1

	if #self.unload_queue == 1 then
		self.unload_queue_done = 0
		self.unload_progress = 0
	end
end

function image_db:queue_unload_done()
	if #self.unload_queue == 0 then
		self.unload_progress = 1
		self.unload_queue_total = 0
		self.unload_queue_done = 0

		return true
	end

	if not self.unload_queue_start_time then
		self.unload_queue_start_time = love.timer.getTime()
	end

	local batch_count = math.min(#self.unload_queue, self.queue_unload_groups_per_frame or 1)

	for i = 1, batch_count do
		local item = table.remove(self.unload_queue, 1)
		local name, ref_scale = unpack(item)

		self:unload_atlas(name, ref_scale, true)

		self.unload_queue_done = self.unload_queue_done + 1
	end

	if #self.unload_queue > 0 then
		self.unload_progress = self.unload_queue_total > 0 and self.unload_queue_done / self.unload_queue_total or 0

		return false
	end

	self:purge_atlas()
	collectgarbage()
	log.info("Done unloading atlas queue. | time: %s", love.timer.getTime() - self.unload_queue_start_time)

	self.unload_queue_start_time = nil
	self.unload_progress = 1
	self.unload_queue_total = 0
	self.unload_queue_done = 0

	return true
end

function image_db:purge_atlas()
	local used_images = {}

	for k, f in pairs(self.db_atlas) do
		used_images[f.atlas] = true
	end

	for _, stack in pairs(self.db_atlas_shadow) do
		for _, f in pairs(stack) do
			used_images[f.atlas] = true
		end
	end

	local remove_images = {}

	for k, v in pairs(self.db_images) do
		if not used_images[k] then
			table.insert(remove_images, k)
		end
	end

	for _, v in pairs(remove_images) do
		self.db_images[v] = nil
	end

	log.debug("  purged #images:%s", #remove_images)
end

function image_db:preload_atlas(ref_scale, path, name)
	local name_scale = string.format("%s-%.6f", name, ref_scale)

	log.debug("load atlas: %s,%s-%.6f", path, name, ref_scale)

	if self.atlas_uses[name_scale] then
		self.atlas_uses[name_scale] = self.atlas_uses[name_scale] + 1

		log.debug("atlas %s already loaded", name)

		return
	end

	self.atlas_uses[name_scale] = 1
	self.progress = 0
	ref_scale = ref_scale or 1

	local group_file = path .. "/" .. name .. ".lua"

	if not FS.isFile(group_file) then
		log.error("atlas file %s not found for %s/%s", group_file, path, name)

		return
	end

	local frames = FS.load(group_file)()
	local unique_frames = {}
	local image_names = {}
	local deferred_image_names = {}

	for k, v in pairs(frames) do
		log.paranoid("loading atlas-frame: %s - %s", v.a_name, k)

		-- KRFLAPK_ANDROID_ATLAS_FALLBACK: the desktop project keeps DDS/PNG atlas
		-- entries, while the Android package uses same-name ASTC textures. Keep
		-- PNG as a compatibility fallback for old mobile packages.
		if IS_ANDROID and type(v.a_name) == "string" then
			local lower_name = string.lower(v.a_name)

			if string.match(lower_name, "%.dds$") then
				local astc_name = string.gsub(v.a_name, "%.[^%.]+$", ".astc")
				local png_name = string.gsub(v.a_name, "%.[^%.]+$", ".png")

				if is_file(path .. "/" .. astc_name) then
					v.a_name = astc_name
				elseif is_file(path .. "/" .. png_name) then
					v.a_name = png_name
				end
			elseif string.match(lower_name, "%.png$") then
				local astc_name = string.gsub(v.a_name, "%.[^%.]+$", ".astc")

				if is_file(path .. "/" .. astc_name) then
					v.a_name = astc_name
				end
			end
		end

		v.group = name_scale
		--v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
		if v.textureRotated then
			v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[4], v.f_quad[3], v.a_size[1], v.a_size[2])
		else
			v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
		end

		if v.defer then
			deferred_image_names[v.a_name] = true
		else
			image_names[v.a_name] = true
		end

		--print(v.a_name)

		v.atlas = string.gsub(v.a_name, ".png$", "")
		v.atlas = string.gsub(v.atlas, ".pkm$", "")
		v.atlas = string.gsub(v.atlas, ".astc$", "")
		v.atlas = string.gsub(v.atlas, ".dds", "")


		for _, a in ipairs(v.alias or {}) do
			unique_frames[a] = v
		end

		v.ref_scale = ref_scale
	end

	for k, v in pairs(unique_frames) do
		frames[k] = v
	end

	self:merge_atlas_frames(frames)

	for fn in pairs(deferred_image_names) do
		local key = string.gsub(fn, ".png$", "")

		key = string.gsub(key, ".jpg$", "")
		key = string.gsub(key, ".pkm$", "")
		key = string.gsub(key, ".astc$", "")
		key = string.gsub(key, ".dds$", "")
		self.db_images[key] = {
			[4] = fn,
			[5] = path
		}
	end
	return image_names
end

function image_db:merge_atlas_frames(frames)
	for k, v in pairs(frames) do
		local previous = self.db_atlas[k]

		if previous and previous ~= v and previous.group ~= v.group then
			local stack = self.db_atlas_shadow[k]

			if not stack then
				stack = {}
				self.db_atlas_shadow[k] = stack
			end

			table.insert(stack, previous)
		end

		self.db_atlas[k] = v
	end
end

function image_db:load_atlas(ref_scale, path, name, yielding)
	local rt_start = love.timer.getTime()
	local image_names = self:preload_atlas(ref_scale, path, name)

	if not image_names then
		return
	end

	local i = 0

	for fn in pairs(image_names) do
		i = i + 1

		local key, im, w, h = image_db:load_image_file(fn, path)

		self.db_images[key] = {
			im,
			w,
			h
		}

		if yielding then
			self.progress = i / #table.keys(image_names)

			coroutine.yield()
		end
	end

	self.progress = 1

	log.info("Finished loading atlas %s/%s at scale %s (time:%s)", path, name, ref_scale, love.timer.getTime() - rt_start)
end

function image_db:load(ref_scale, custom_paths)
	ref_scale = ref_scale or 1

	local paths = custom_paths or {
		"images/ipad"
	}
	local image_files = {}

	for _, path in pairs(paths) do
		local files = FS.getDirectoryItems(path)

		for i = 1, #files do
			local name = files[i]
			local f = path .. "/" .. name

			if FS.isFile(f) and (string.match(f, ".png$") or string.match(f, ".jpg$")) then
				local key = string.gsub(name, ".png$", "")

				key = string.gsub(key, ".jpg$", "")

				local im = G.newImage(f)

				if not im then
					log.error("Image %s could not be created", f)
				else
					local w, h = im:getDimensions()

					self.db_images[key] = {
						im,
						w,
						h
					}
				end
			end
		end
	end

	for _, path in pairs(paths) do
		local files = FS.getDirectoryItems(path)

		for i = 1, #files do
			local name = files[i]
			local f = path .. "/" .. name

			if FS.isFile(f) and string.match(f, ".lua$") then
				local file_basename = string.gsub(name, ".lua$", "")
				local frames = require(path .. "." .. file_basename)
				local queue = {}

				for k, v in pairs(frames) do
					--v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
					if v.textureRotated then
						v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[4], v.f_quad[3], v.a_size[1], v.a_size[2])
					else
						v.quad = G.newQuad(v.f_quad[1], v.f_quad[2], v.f_quad[3], v.f_quad[4], v.a_size[1], v.a_size[2])
					end
					v.atlas = string.gsub(v.a_name, ".png$", "")

					for _, a in ipairs(v.alias) do
						queue[a] = v
					end

					v.ref_scale = ref_scale
				end

				for k, v in pairs(queue) do
					frames[k] = v
				end

				self:merge_atlas_frames(frames)
			end
		end
	end

	log.debug("finished loading image_db")
end

function image_db:load_image_file(fn, path)
	local f = path .. "/" .. fn

	if not is_file(f) then
		log.error("not a valid file: %s", f)

		return
	end

	if string.match(f, ".png$") or string.match(f, ".jpg$") or string.match(f, ".pkm$") or string.match(f, ".astc$") or string.match(f, ".dds$") then
		log.paranoid("  loading image file %s", f)

		local compressed = false

		if string.match(f, ".pkm$") then
			compressed = true

			local supportedformats = krflapk_supported_image_formats()

			if not supportedformats.ETC1 then
				log.error("ETC1 not supported. Could not load %s", f)

				return nil
			end
		elseif string.match(f, ".astc$") then
			compressed = true

			local supportedformats = krflapk_supported_image_formats()

			if not supportedformats.ASTC4x4 then
				log.error("ASTC not supported. Could not load %s", f)

				return nil
			end
		elseif string.match(f, ".dds$") then
			compressed = true

			local supportedformats = krflapk_supported_image_formats()

			-- Android 端应该已在 preload_atlas 中转换为 .astc 或 .png，此处为容错
			if IS_ANDROID then
				local astc_fn = fn:gsub("%.dds$", ".astc")
				if is_file(path .. "/" .. astc_fn) then
					return self:load_image_file(astc_fn, path)
				end

				local png_fn = fn:gsub("%.dds$", ".png")
				if is_file(path .. "/" .. png_fn) then
					return self:load_image_file(png_fn, path)
				end

				log.error("No Android-compatible format found for %s (tried .astc, .png)", f)
				return nil
			end

			-- 检查 DXT3 和 BC7 是否都不支持
			if not self.supportedformats.DXT3 then
				log.error("DDS not supported (DXT3). Fallback to PNG for %s", f)

				return nil
			end

			if not supportedformats.DXT3 then
				log.error("DXT3 not supported. Could not load %s", f)

				return nil
			end
		end

		local im

		if compressed then
			local imd = love.image.newCompressedData(f)

			if not imd then
				log.error("Compressed image %s could not be loaded", f)

				return
			end

			im = G.newImage(imd)
		else
			im = G.newImage(f)
		end

		if not im then
			log.error("Image %s could not be created", f)
		else
			local w, h = im:getDimensions()
			local key = string.gsub(fn, ".png$", "")

			key = string.gsub(key, ".jpg$", "")
			key = string.gsub(key, ".pkm$", "")
			key = string.gsub(key, ".astc$", "")
			key = string.gsub(key, ".dds$", "")

			return key, im, w, h
		end
	end
end

function image_db:add_image(name, image, group, scale)
	scale = scale or 1

	local name_scale = string.format("%s-%.6f", group, scale)
	local w, h = image:getDimensions()

	v = {}
	v.size = {
		w,
		h
	}
	v.trim = {
		0,
		0,
		0,
		0
	}
	v.a_name = name
	v.a_size = {
		w,
		h
	}
	v.group = name_scale
	v.quad = G.newQuad(0, 0, w, h, w, h)
	v.atlas = name
	v.ref_scale = scale
	self.db_atlas[name] = v
	self.db_images[name] = {
		image,
		w,
		h
	}

	if not self.atlas_uses[name_scale] then
		self.atlas_uses[name_scale] = 1
	end
end

function image_db:remove_image(name)
	self.db_images[name] = nil
	self.db_atlas[name] = nil
end

function image_db:i(name, optional)
	local i = self.db_images[name]

	if self.db_images[name] then
		if i[1] == nil and i[4] and i[5] then
			local key, im, w, h = self:load_image_file(i[4], i[5])

			self.db_images[name] = {
				im,
				w,
				h
			}

			return im, w, h
		else
			return i[1], i[2], i[3]
		end
	else
		if not name and self.missing_images["nil"] or self.missing_images[name] then
			return nil
		end

		if not optional then
			log.error("Image %s not found in the images db\n%s", name, self:get_short_stats())
		end

		self.missing_images[name or "nil"] = true

		return nil
	end
end

function image_db:s(name, optional)
	local s = self.db_atlas[name]

	if not s then
		if not name and self.missing_sprites["nil"] or self.missing_sprites[name] then
			return nil
		end

		if name == "sprite_for_error_testing" then
			-- This test sprite is missing on desktop too and is not actionable.
			-- Avoid flooding the Android diagnostics with a huge atlas dump.
		elseif not optional then
			log.error("Sprite %s was not found in the atlas db.\n%s", name, self:get_short_stats())
		end

		self.missing_sprites[name or "nil"] = true

		return nil
	end

	return s
end

return image_db
