-- chunkname: @./all/render_utils.lua

local log = require("klua.log"):new("render_utils")
local I = require("klove.image_db")
local EXO = require("exoskeleton")
local G = love.graphics
local RU = {}

RU.BATCHES_COUNT = 30
RU.BATCH_SIZE = 50
RU.batches = {}
RU.bi = 1

function RU.init()
	local temp_canvas = G.newCanvas(2, 2)

	for i = 1, RU.BATCHES_COUNT do
		table.insert(RU.batches, G.newSpriteBatch(temp_canvas, RU.BATCH_SIZE, "stream"))
	end

	RU.bi = 1
	RU.last_texture = nil
end

function RU.destroy()
	RU.batches = {}
	RU.last_texture = nil
end

function RU.frame_draw_params(f)
	local ss = f.ss
	local x = f.pos.x + f.offset.x
	local y = REF_H - (f.pos.y + f.offset.y)
	local r = -f.r
	local ref_scale = ss.ref_scale or 1
	local sy = (f.flip_y and -1 or 1) * ref_scale
	local sx = (f.flip_x and -1 or 1) * ref_scale

	if f.scale then
		sy = sy * f.scale.y
		sx = sx * f.scale.x
	end

	local ox = f.anchor.x * ss.size[1] - ss.trim[1]
	local oy = (1 - f.anchor.y) * ss.size[2] - ss.trim[2]

	if ss.textureRotated then
		r = r - math.pi / 2 * (f.flip_x and -1 or 1)
		ox = f.anchor.y * ss.size[2] - ss.trim[4]
		oy = f.anchor.x * ss.size[1] - ss.trim[1]
		if f.scale then
			sy = (f.flip_y and -1 or 1) * ref_scale * f.scale.x
			sx = (f.flip_x and -1 or 1) * ref_scale * f.scale.y
		end
	end

	return ss.quad, x, y, r, sx, sy, ox, oy
end

local function krflapk_android_direct_draw_enabled()
	-- The Android/Harmony LÖVE runtime accepts the atlas Images, but its
	-- SpriteBatch path drops normal world sprites while GUI/direct draws keep
	-- working. Bypass SpriteBatch only on Android; desktop keeps the faster
	-- batched renderer.
	return IS_ANDROID == true
end

local function krflapk_apply_shader(f, current_shader)
	if f.shader ~= current_shader then
		G.setShader(f.shader)

		if f.shader and f.shader_args then
			for k, v in pairs(f.shader_args) do
				f.shader:send(k, v)
			end
		end

		current_shader = f.shader
	end

	return current_shader
end

local krflapk_love_major = love.getVersion and select(1, love.getVersion()) or love._version_major
local krflapk_needs_batch_color_compat = (love.system and love.system.getOS and love.system.getOS() == "Android") or (krflapk_love_major and krflapk_love_major >= 11)

local function krflapk_color_channel(v, default)
	if v == nil then
		return default
	end

	if krflapk_needs_batch_color_compat and v > 1 then
		return v / 255
	end

	return v
end

local function krflapk_set_draw_color(color, alpha)
	if color then
		G.setColor(krflapk_color_channel(color[1], 1), krflapk_color_channel(color[2], 1), krflapk_color_channel(color[3], 1), krflapk_color_channel(alpha, 1))
	else
		G.setColor(1, 1, 1, krflapk_color_channel(alpha, 1))
	end
end

local function krflapk_batch_set_color(batch, r, g, b, a)
	batch:setColor(krflapk_color_channel(r, 1), krflapk_color_channel(g, 1), krflapk_color_channel(b, 1), krflapk_color_channel(a, 1))
end

local krflapk_missing_texture_logged = {}

local function krflapk_log_missing_texture(atlas)
	if not IS_ANDROID or not atlas or krflapk_missing_texture_logged[atlas] then
		return
	end

	krflapk_missing_texture_logged[atlas] = true
	log.error("KRFLAPK render texture missing for atlas=%s", tostring(atlas))
end

local function krflapk_frame_is_visible(x, y, ss, sx, sy, ox, oy, cull_bounds)
	if not cull_bounds then
		return true
	end

	-- x/y is the sprite anchor, not necessarily its centre.  Use the furthest
	-- possible corner from that anchor so rotated and unusually anchored
	-- sprites are never clipped at the edge of the screen.
	local w = ss.size and ss.size[1] or 0
	local h = ss.size and ss.size[2] or 0
	local rx = math.max(math.abs(ox or 0), math.abs(w - (ox or 0))) * math.abs(sx or 1)
	local ry = math.max(math.abs(oy or 0), math.abs(h - (oy or 0))) * math.abs(sy or 1)
	local radius = math.sqrt(rx * rx + ry * ry)

	return x + radius >= cull_bounds.left and x - radius <= cull_bounds.right and y + radius >= cull_bounds.top and y - radius <= cull_bounds.bottom
end

function RU.draw_exo_frame_direct(f, cull_bounds)
	if not f.exo_frame or not f.exo or not f.exo.parts then
		return
	end

	for part_idx, part in ipairs(f.exo_frame) do
		local part_type, part_name_idx, alpha, x, y, sx, sy, r, kx, ky = unpack(part)

		if not part.hidden then
			local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)

			if part_type == 8 then
				sy = sy * (f.flip_y and -1 or 1)
				sx = sx * (f.flip_x and -1 or 1)

				local f_sx = f.flip_x and -1 or 1
				local f_sy = f.flip_y and -1 or 1

				if f.scale then
					sy = sy * f.scale.y
					sx = sx * f.scale.x
					f_sx = f_sx * f.scale.x
					f_sy = f_sy * f.scale.y
				end

				local p_x_s = x * f_sx
				local p_y_s = y * f_sy

				r = -f.r * flipf + r

				if f.r ~= 0 then
					local cr = math.cos(-f.r)
					local sr = math.sin(-f.r)
					local p_x = p_x_s * cr - p_y_s * sr
					local p_y = p_x_s * sr + p_y_s * cr

					x = p_x + f.pos.x + f.offset.x
					y = -p_y + f.pos.y + f.offset.y
				else
					x = p_x_s + f.pos.x + f.offset.x
					y = -p_y_s + f.pos.y + f.offset.y
				end

				if not f.last_attach_point_xform then
					f.last_attach_point_xform = {}
				end

				if not f.last_attach_point_xform[part_name_idx] then
					f.last_attach_point_xform[part_name_idx] = {}
				end

				local l = f.last_attach_point_xform[part_name_idx]

				l.x, l.y = x, y
				l.r = r * flipf
				l.sx, l.sy = sx, sy
			else
				local exo_part = f.exo.parts[part_name_idx]

				if exo_part then
					local part_name, pox, poy = unpack(exo_part)
					local ss = I:s(part_name, true)

					if ss and ss.atlas then
							local quad = ss.quad
							local ref_scale = ss.ref_scale or 1
							local raw_sx, raw_sy = sx, sy

							sy = sy * (f.flip_y and -1 or 1) * ref_scale
							sx = sx * (f.flip_x and -1 or 1) * ref_scale

							local f_sx = f.flip_x and -1 or 1
							local f_sy = f.flip_y and -1 or 1

							if f.scale then
								sy = sy * f.scale.y
								sx = sx * f.scale.x
								f_sx = f_sx * f.scale.x
								f_sy = f_sy * f.scale.y
							end

							local ox = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
							local oy = 0.5 * ss.size[2] - ss.trim[2] - poy / ref_scale

							if ss.textureRotated then
								r = r - math.pi / 2
								ox = 0.5 * ss.size[2] - ss.trim[4] + poy / ref_scale
								oy = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
								sy = raw_sx * (f.flip_y and -1 or 1) * ref_scale
								sx = raw_sy * (f.flip_x and -1 or 1) * ref_scale

								if f.scale then
									sy = sy * f.scale.x
									sx = sx * f.scale.y
								end
							end

							local p_x_s = x * f_sx
							local p_y_s = y * f_sy

							r = -f.r * flipf + r

							if f.r ~= 0 then
								local cr = math.cos(-f.r)
								local sr = math.sin(-f.r)
								local p_x = p_x_s * cr - p_y_s * sr
								local p_y = p_x_s * sr + p_y_s * cr

								x = p_x + f.pos.x + f.offset.x
								y = REF_H - (-p_y + f.pos.y + f.offset.y)
							else
								x = p_x_s + f.pos.x + f.offset.x
								y = REF_H - (-p_y_s + f.pos.y + f.offset.y)
							end

							if krflapk_frame_is_visible(x, y, ss, sx, sy, ox, oy, cull_bounds) then
								local im = I:i(ss.atlas)

								if im then
									krflapk_set_draw_color(f.color, (f.alpha or 255) * (alpha or 1))
									G.draw(im, quad, x, y, r * flipf, sx, sy, ox, oy, kx, ky)
								else
									krflapk_log_missing_texture(ss.atlas)
								end
							end
					end
				end
			end
		end
	end
end

function RU.draw_frame_direct(f, cull_bounds)
	if f.exo then
		RU.draw_exo_frame_direct(f, cull_bounds)

		return
	end

	local ss = f.ss

	if not ss or not ss.atlas then
		return
	end

	local quad, x, y, r, sx, sy, ox, oy = RU.frame_draw_params(f)

	if not krflapk_frame_is_visible(x, y, ss, sx, sy, ox, oy, cull_bounds) then
		return
	end

	local im = I:i(ss.atlas)

	if not im then
		krflapk_log_missing_texture(ss.atlas)

		return
	end

	krflapk_set_draw_color(f.color, f.alpha)
	G.draw(im, quad, x, y, r, sx, sy, ox, oy)
end

function RU.draw_frames_range_direct(frames, start_idx, max_z, cull_bounds)
	local last_idx = start_idx - 1
	local current_shader

	for i = start_idx, #frames do
		local f = frames[i]

		if not f then
			f = {
				z = -math.huge,
				hidden = true
			}
		end

		if max_z <= (f.z or math.huge) then
			break
		end

		if frames[i] then
			last_idx = i
		end

		if not f.hidden and not f.marked_to_remove then
			current_shader = krflapk_apply_shader(f, current_shader)

			RU.draw_frame_direct(f, cull_bounds)
		end
	end

	if current_shader then
		G.setShader()
	end

	G.setColor(1, 1, 1, 1)

	return last_idx
end

function RU.add_batches(count)
	if #RU.batches > 1000 and not RU.too_many_batches then
		log.error("1000 sprite batches per frame exceeded! Way too many batches!")

		RU.too_many_batches = true
	end

	local temp_canvas = G.newCanvas(2, 2)

	for i = 1, count do
		table.insert(RU.batches, G.newSpriteBatch(temp_canvas, RU.BATCH_SIZE, "stream"))
	end
end

function RU.draw_frames_range(frames, start_idx, max_z, cull_bounds)
	if krflapk_android_direct_draw_enabled() then
		return RU.draw_frames_range_direct(frames, start_idx, max_z, cull_bounds)
	end

	local current_atlas, lr, lg, lb, la
	local r, g, b, a = 255, 255, 255, 255
	local batch_count = 0
	local batches_count = 0
	local BATCH_SIZE = RU.BATCH_SIZE
	local last_idx = start_idx - 1
	local frame_draw_params = RU.frame_draw_params
	local batches = RU.batches
	local bi = RU.bi
	local bi_count = #RU.batches
	local batch = batches[bi]
	local last_texture = RU.last_texture
	local current_shader

	batch:clear()

	if last_texture then
		batch:setTexture(last_texture)
	end

	G.setColor(255, 255, 255, 255)

	for i = start_idx, #frames do
		local f = frames[i]

		if not f then
			f = {
				z = -math.huge,
				hidden = true
			}
		end

		if max_z <= (f.z or math.huge) then
			break
		end

		if frames[i] then
			last_idx = i
		end

		local ss = f.ss

		if f.hidden then
			-- block empty
		--[[
		elseif f.exo then
			for part_idx, part in ipairs(f.exo_frame.parts) do
				local ss = I:s(part.name)

				if part.hidden then
					-- block empty
				else
					if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
						if batch_count > 0 then
							G.draw(batch)

							bi = bi_count < bi + 1 and 1 or bi + 1
							batch = batches[bi]

							if last_texture then
								batch:setTexture(last_texture)
							end
						end

						batch:clear()

						lr, lg, lb, la = nil

						if ss.atlas then
							local im, w, h = I:i(ss.atlas)

							current_atlas = ss.atlas
							last_texture = im

							if im then
								batch:setTexture(im)
							else
								krflapk_log_missing_texture(ss.atlas)
							end
						end

						batch_count = 0
						batches_count = batches_count + 1

						if f.shader ~= current_shader then
							G.setShader(f.shader)

							if f.shader_args then
								for k, v in pairs(f.shader_args) do
									f.shader:send(k, v)
								end
							end

							current_shader = f.shader
						end
					end

					if f.color then
						r, g, b = f.color[1], f.color[2], f.color[3]
					else
						r, g, b = 255, 255, 255
					end

					a = f.alpha * (part.alpha or 1)

					if a ~= la or r ~= lr or g ~= lg or b ~= lb then
						krflapk_batch_set_color(batch, r, g, b, a)

						lr, lg, lb, la = r, g, b, a
					end

					local exo_part = f.exo.parts[part.name]
					local pox, poy = exo_part.offsetX, exo_part.offsetY
					local quad = ss.quad
					local ref_scale = ss.ref_scale or 1
					local xf = part.xform
					local x, y, r, sx, sy, kx, ky = xf.x, xf.y, xf.r, xf.sx, xf.sy, xf.kx, xf.ky

					r = -f.r + r
					sy = sy * (f.flip_y and -1 or 1) * ref_scale
					sx = sx * (f.flip_x and -1 or 1) * ref_scale

					local f_sx = f.flip_x and -1 or 1
					local f_sy = f.flip_y and -1 or 1

					if f.scale then
						sy = sy * f.scale.y
						sx = sx * f.scale.x
						f_sx = f_sx * f.scale.x
						f_sy = f_sy * f.scale.y
					end

					local ox = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
					local oy = 0.5 * ss.size[2] - ss.trim[2] - poy / ref_scale

					if ss.textureRotated then
						r = r - math.pi / 2
						ox = 0.5 * ss.size[2] - ss.trim[4] + poy / ref_scale
						oy = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
						sy = xf.sx * (f.flip_y and -1 or 1) * ref_scale
						sx = xf.sy * (f.flip_x and -1 or 1) * ref_scale
						if f.scale then
							sy = sy * f.scale.x
							sx = sx * f.scale.y
						end
					end

					x = x * f_sx + f.pos.x + f.offset.x
					y = REF_H - (-y * f_sy + f.pos.y - f.offset.y)

					batch:add(quad, x, y, r * f_sx, sx, sy, ox, oy, kx, ky)

					batch_count = batch_count + 1
				end
			end
		]]--
		elseif f.exo then
			for part_idx, part in ipairs(f.exo_frame) do
				do
					local part_type, part_name_idx, alpha, x, y, sx, sy, r, kx, ky = unpack(part)
					if part.hidden then
						-- block empty
					else
						if part_type == 8 then
							local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)

							sy = sy * (f.flip_y and -1 or 1)
							sx = sx * (f.flip_x and -1 or 1)

							local f_sx = f.flip_x and -1 or 1
							local f_sy = f.flip_y and -1 or 1

							if f.scale then
								sy = sy * f.scale.y
								sx = sx * f.scale.x
								f_sx = f_sx * f.scale.x
								f_sy = f_sy * f.scale.y
							end

							local p_x_s = x * f_sx
							local p_y_s = y * f_sy

							r = -f.r * flipf + r

							if f.r ~= 0 then
								local cr = math.cos(-f.r)
								local sr = math.sin(-f.r)
								local p_x = p_x_s * cr - p_y_s * sr
								local p_y = p_x_s * sr + p_y_s * cr

								x = p_x + f.pos.x + f.offset.x
								y = -p_y + f.pos.y + f.offset.y
							else
								x = p_x_s + f.pos.x + f.offset.x
								y = -p_y_s + f.pos.y + f.offset.y
							end

							if not f.last_attach_point_xform then
								f.last_attach_point_xform = {}
							end

							if not f.last_attach_point_xform[part_name_idx] then
								f.last_attach_point_xform[part_name_idx] = {}
							end

							local l = f.last_attach_point_xform[part_name_idx]

							l.x, l.y = x, y
							l.r = r * flipf
							l.sx, l.sy = sx, sy

							goto label_6_0
						end

						local part_name, pox, poy = unpack(f.exo.parts[part_name_idx])
						local ss = I:s(part_name)
						if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
							if batch_count > 0 then
								G.draw(batch)

								bi = bi + 1

								if bi_count < bi then
									RU.add_batches(10)

									bi_count = #RU.batches
								end

								batch = batches[bi]

								if last_texture then
									batch:setTexture(last_texture)
								end
							end

							batch:clear()

							lr, lg, lb, la = nil

							if ss.atlas then
								local im, w, h = I:i(ss.atlas)

								current_atlas = ss.atlas
								last_texture = im

								if im then
									batch:setTexture(im)
								else
									krflapk_log_missing_texture(ss.atlas)
								end
							end

							batch_count = 0
							batches_count = batches_count + 1

							if f.shader ~= current_shader then
								G.setShader(f.shader)

								if f.shader_args then
									for k, v in pairs(f.shader_args) do
										f.shader:send(k, v)
									end
								end

								current_shader = f.shader
							end
						end

						if f.color then
							cr, cg, cb = f.color[1], f.color[2], f.color[3]
						else
							cr, cg, cb = 255, 255, 255
						end

						ca = f.alpha * (alpha or 1)

						if ca ~= la or cr ~= lr or cg ~= lg or cb ~= lb then
							krflapk_batch_set_color(batch, cr, cg, cb, ca)

							lr, lg, lb, la = cr, cg, cb, ca
						end

						local quad = ss.quad
						local ref_scale = ss.ref_scale or 1
						local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)
						local raw_sx, raw_sy = sx, sy

						sy = sy * (f.flip_y and -1 or 1) * ref_scale
						sx = sx * (f.flip_x and -1 or 1) * ref_scale

						local f_sx = f.flip_x and -1 or 1
						local f_sy = f.flip_y and -1 or 1

						if f.scale then
							sy = sy * f.scale.y
							sx = sx * f.scale.x
							f_sx = f_sx * f.scale.x
							f_sy = f_sy * f.scale.y
						end

						local ox = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
						local oy = 0.5 * ss.size[2] - ss.trim[2] - poy / ref_scale

						if ss.textureRotated then
							r = r - math.pi / 2
							ox = 0.5 * ss.size[2] - ss.trim[4] + poy / ref_scale
							oy = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
							sy = raw_sx * (f.flip_y and -1 or 1) * ref_scale
							sx = raw_sy * (f.flip_x and -1 or 1) * ref_scale
							if f.scale then
								sy = sy * f.scale.x
								sx = sx * f.scale.y
							end
						end

						local p_x_s = x * f_sx
						local p_y_s = y * f_sy

						r = -f.r * flipf + r

						if f.r ~= 0 then
							local cr = math.cos(-f.r)
							local sr = math.sin(-f.r)
							local p_x = p_x_s * cr - p_y_s * sr
							local p_y = p_x_s * sr + p_y_s * cr

							x = p_x + f.pos.x + f.offset.x
							y = REF_H - (-p_y + f.pos.y + f.offset.y)
						else
							x = p_x_s + f.pos.x + f.offset.x
							y = REF_H - (-p_y_s + f.pos.y + f.offset.y)
						end

						batch:add(quad, x, y, r * flipf, sx, sy, ox, oy, kx, ky)

						batch_count = batch_count + 1
					end
				end

				::label_6_0::
			end
		elseif not ss then
			-- block empty
		else
			if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
				if batch_count > 0 then
					G.draw(batch)

					bi = bi_count < bi + 1 and 1 or bi + 1
					batch = batches[bi]

					if last_texture then
						batch:setTexture(last_texture)
					end
				end

				batch:clear()

				lr, lg, lb, la = nil

				if ss.atlas then
					local im, w, h = I:i(ss.atlas)

					current_atlas = ss.atlas
					last_texture = im

					if im then
						batch:setTexture(im)
					else
						krflapk_log_missing_texture(ss.atlas)
					end
				end

				batch_count = 0
				batches_count = batches_count + 1

				if f.shader ~= current_shader then
					G.setShader(f.shader)

					if f.shader_args then
						for k, v in pairs(f.shader_args) do
							f.shader:send(k, v)
						end
					end

					current_shader = f.shader
				end
			end

			if f.color then
				r, g, b = f.color[1], f.color[2], f.color[3]
			else
				r, g, b = 255, 255, 255
			end

			a = f.alpha

			if a ~= la or r ~= lr or g ~= lg or b ~= lb then
				krflapk_batch_set_color(batch, r, g, b, a)

				lr, lg, lb, la = r, g, b, a
			end

			batch:add(frame_draw_params(f))

			batch_count = batch_count + 1
		end
	end

	if batch_count > 0 then
		G.draw(batch)

		bi = bi_count < bi + 1 and 1 or bi + 1
		batch = batches[bi]
		batches_count = batches_count + 1
	end

	G.setColor(255, 255, 255, 255)

	if current_shader then
		G.setShader()
	end

	RU.bi = bi
	RU.last_texture = last_texture

	return last_idx
end

function RU.draw_frames_range_5(frames, start_idx, max_z)
	if krflapk_android_direct_draw_enabled() then
		return RU.draw_frames_range_direct(frames, start_idx, max_z)
	end

	local current_atlas, lr, lg, lb, la
	local cr, cg, cb, ca = 255, 255, 255, 255
	local batch_count = 0
	local batches_count = 0
	local BATCH_SIZE = RU.BATCH_SIZE
	local last_idx = start_idx - 1
	local frame_draw_params = RU.frame_draw_params
	local batches = RU.batches
	local bi = RU.bi
	local bi_count = #RU.batches
	local batch = batches[bi]
	local last_texture = RU.last_texture
	local current_shader

	batch:clear()

	if last_texture then
		batch:setTexture(last_texture)
	end

	G.setColor(255, 255, 255, 255)

	for i = start_idx, #frames do
		local f = frames[i]

		if not f then
			f = {
				z = -math.huge,
				hidden = true
			}
		end

		if max_z <= (f.z or math.huge) then
			break
		end

		if frames[i] then
			last_idx = i
		end

		local ss = f.ss

		if f.hidden then
			-- block empty
		elseif f.exo then
			for part_idx, part in ipairs(f.exo_frame) do
				do
					local part_type, part_name_idx, alpha, x, y, sx, sy, r, kx, ky = unpack(part)

					if part_type == 8 then
						local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)

						sy = sy * (f.flip_y and -1 or 1)
						sx = sx * (f.flip_x and -1 or 1)

						local f_sx = f.flip_x and -1 or 1
						local f_sy = f.flip_y and -1 or 1

						if f.scale then
							sy = sy * f.scale.y
							sx = sx * f.scale.x
							f_sx = f_sx * f.scale.x
							f_sy = f_sy * f.scale.y
						end

						local p_x_s = x * f_sx
						local p_y_s = y * f_sy

						r = -f.r * flipf + r

						if f.r ~= 0 then
							local cr = math.cos(-f.r)
							local sr = math.sin(-f.r)
							local p_x = p_x_s * cr - p_y_s * sr
							local p_y = p_x_s * sr + p_y_s * cr

							x = p_x + f.pos.x + f.offset.x
							y = -p_y + f.pos.y + f.offset.y
						else
							x = p_x_s + f.pos.x + f.offset.x
							y = -p_y_s + f.pos.y + f.offset.y
						end

						if not f.last_attach_point_xform then
							f.last_attach_point_xform = {}
						end

						if not f.last_attach_point_xform[part_name_idx] then
							f.last_attach_point_xform[part_name_idx] = {}
						end

						local l = f.last_attach_point_xform[part_name_idx]

						l.x, l.y = x, y
						l.r = r * flipf
						l.sx, l.sy = sx, sy

						goto label_6_0
					end

					local part_name, pox, poy = unpack(f.exo.parts[part_name_idx])
					local ss = I:s(part_name)

					if part.hidden then
						-- block empty
					else
						if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
							if batch_count > 0 then
								G.draw(batch)

								bi = bi + 1

								if bi_count < bi then
									RU.add_batches(10)

									bi_count = #RU.batches
								end

								batch = batches[bi]

								if last_texture then
									batch:setTexture(last_texture)
								end
							end

							batch:clear()

							lr, lg, lb, la = nil

							if ss.atlas then
								local im, w, h = I:i(ss.atlas)

								current_atlas = ss.atlas
								last_texture = im

								if im then
									batch:setTexture(im)
								else
									krflapk_log_missing_texture(ss.atlas)
								end
							end

							batch_count = 0
							batches_count = batches_count + 1

							if f.shader ~= current_shader then
								G.setShader(f.shader)

								if f.shader_args then
									for k, v in pairs(f.shader_args) do
										f.shader:send(k, v)
									end
								end

								current_shader = f.shader
							end
						end

						if f.color then
							cr, cg, cb = f.color[1], f.color[2], f.color[3]
						else
							cr, cg, cb = 255, 255, 255
						end

						ca = f.alpha * (alpha or 1)

						if ca ~= la or cr ~= lr or cg ~= lg or cb ~= lb then
							krflapk_batch_set_color(batch, cr, cg, cb, ca)

							lr, lg, lb, la = cr, cg, cb, ca
						end

						local quad = ss.quad
						local ref_scale = ss.ref_scale or 1
						local flipf = (f.flip_x and -1 or 1) * (f.flip_y and -1 or 1)

						sy = sy * (f.flip_y and -1 or 1) * ref_scale
						sx = sx * (f.flip_x and -1 or 1) * ref_scale

						local f_sx = f.flip_x and -1 or 1
						local f_sy = f.flip_y and -1 or 1

						if f.scale then
							sy = sy * f.scale.y
							sx = sx * f.scale.x
							f_sx = f_sx * f.scale.x
							f_sy = f_sy * f.scale.y
						end

						local ox = 0.5 * ss.size[1] - ss.trim[1] - pox / ref_scale
						local oy = 0.5 * ss.size[2] - ss.trim[2] - poy / ref_scale
						local p_x_s = x * f_sx
						local p_y_s = y * f_sy

						r = -f.r * flipf + r

						if f.r ~= 0 then
							local cr = math.cos(-f.r)
							local sr = math.sin(-f.r)
							local p_x = p_x_s * cr - p_y_s * sr
							local p_y = p_x_s * sr + p_y_s * cr

							x = p_x + f.pos.x + f.offset.x
							y = REF_H - (-p_y + f.pos.y + f.offset.y)
						else
							x = p_x_s + f.pos.x + f.offset.x
							y = REF_H - (-p_y_s + f.pos.y + f.offset.y)
						end

						batch:add(quad, x, y, r * flipf, sx, sy, ox, oy, kx, ky)

						batch_count = batch_count + 1
					end
				end

				::label_6_0::
			end
		elseif not ss then
			-- block empty
		else
			if batch_count == BATCH_SIZE or f.shader ~= current_shader or ss.atlas and ss.atlas ~= current_atlas then
				if batch_count > 0 then
					G.draw(batch)

					bi = bi + 1

					if bi_count < bi then
						RU.add_batches(10)

						bi_count = #RU.batches
					end

					batch = batches[bi]

					if last_texture then
						batch:setTexture(last_texture)
					end
				end

				batch:clear()

				lr, lg, lb, la = nil

				if ss.atlas then
					local im, w, h = I:i(ss.atlas)

					current_atlas = ss.atlas
					last_texture = im

					if im then
						batch:setTexture(im)
					else
						krflapk_log_missing_texture(ss.atlas)
					end
				end

				batch_count = 0
				batches_count = batches_count + 1

				if f.shader ~= current_shader then
					G.setShader(f.shader)

					if f.shader_args then
						for k, v in pairs(f.shader_args) do
							f.shader:send(k, v)
						end
					end

					current_shader = f.shader
				end
			end

			if f.color then
				cr, cg, cb = f.color[1], f.color[2], f.color[3]
			else
				cr, cg, cb = 255, 255, 255
			end

			ca = f.alpha

			if ca ~= la or cr ~= lr or cg ~= lg or cb ~= lb then
				krflapk_batch_set_color(batch, cr, cg, cb, ca)

				lr, lg, lb, la = cr, cg, cb, ca
			end

			batch:add(frame_draw_params(f))

			batch_count = batch_count + 1
		end
	end

	if batch_count > 0 then
		G.draw(batch)

		bi = bi + 1

		if bi_count < bi then
			RU.add_batches(10)

			bi_count = #RU.batches
		end

		batch = batches[bi]
		batches_count = batches_count + 1
	end

	G.setColor(255, 255, 255, 255)

	if current_shader then
		G.setShader()
	end

	RU.bi = bi
	RU.last_texture = last_texture

	return last_idx
end

return RU
