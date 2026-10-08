-- chunkname: @./kr3-desktop/map_decos_functions.lua

local km = require("klua.macros")
local V = require("klua.vector")
local S = require("sound_db")
local kui_db = require("klove.kui_db")
local v = V.v
local deco_fn = {}

deco_fn.ani_seq = {}

function deco_fn.ani_seq:prepare()
	local d = self.ctx.data
	local timer = self.ctx.timer
	local seq_idx = 1

	self.loop = false

	timer.script(function(wait)
		while true do
			local ani_name, wait_min, wait_max = unpack(d.sequence[seq_idx])

			self.animation = d.animations[ani_name]
			self.ts = 0

			wait((self.animation.to - self.animation.from + 1) / 30)
			wait(math.random(wait_min, wait_max))

			seq_idx = km.zmod(seq_idx + 1, #d.sequence)
		end
	end)
end

deco_fn.md_ft_mountain = {}

function deco_fn.md_ft_mountain.unlock(this, wait)
	if wait then
		this.ctx.timer.tween(2, this, {
			alpha = 0
		}, "out-quad")
		wait(1)
	else
		this.alpha = 0
	end
end

deco_fn.ma_waterfall1_barrel = {}

function deco_fn.ma_waterfall1_barrel:prepare()
	local d = self.ctx.data
	local timer = self.ctx.timer

	timer.script(function(wait)
		while true do
			wait(math.random(d.wait_out[1], d.wait_out[2]))

			local ani_name, pos_to = unpack(d.sequence[1])

			self.animation = d.animations[ani_name]
			self.ts = 0
			self.loop = true
			self.pos.x, self.pos.y = d.pos.x, d.pos.y

			local dx = pos_to.x - self.pos.x

			timer.tween(dx / d.speed_x, self.pos, {
				x = pos_to.x
			})
			timer.tween(dx / d.speed_x, self.pos, {
				y = pos_to.y
			}, "in-quad")
			wait(dx / d.speed_x)

			ani_name, pos_to = unpack(d.sequence[2])
			self.animation = d.animations[ani_name]
			self.ts = 0
			self.loop = false

			local dx = pos_to.x - self.pos.x

			timer.tween(dx / d.speed_x, self.pos, {
				x = pos_to.x
			})
			timer.tween(dx / d.speed_x, self.pos, {
				y = pos_to.y
			}, "in-quad")
			wait(dx / d.speed_x)

			ani_name, pos_to = unpack(d.sequence[3])
			self.animation = d.animations[ani_name]
			self.ts = 0

			wait((self.animation.to - self.animation.from + 1) / 30)
		end
	end)
end

deco_fn.ma_ship = {}

function deco_fn.ma_ship:prepare()
	local d = self.ctx.data
	local timer = self.ctx.timer
	local v_ship_in = KImageView(d.animations.in_sail.prefix .. "_0001")
	local v_ship_out = KImageView(d.animations.out_sail.prefix .. "_0001")
	local v_trail_in = KImageView(d.animations.in_trail.prefix .. "_0001")
	local v_trail_out = KImageView(d.animations.out_trail.prefix .. "_0001")

	v_ship_in.animation = d.animations.in_sail
	v_ship_out.animation = d.animations.out_sail
	v_trail_in.animation = d.animations.in_trail
	v_trail_out.animation = d.animations.out_trail
	v_ship_out.alpha = 1
	v_trail_out.alpha = 0
	v_ship_out.pos = V.v(0, -8)
	v_trail_in.pos = V.v(-20, 10)
	v_trail_out.pos = V.v(40, 38)
	v_ship_in.loop = true
	v_ship_out.loop = true
	v_trail_in.loop = true
	v_trail_out.loop = true

	self:add_child(v_trail_out)
	self:add_child(v_trail_in)
	self:add_child(v_ship_out)
	self:add_child(v_ship_in)
	timer.script(function(wait)
		while true do
			self.pos.x, self.pos.y = d.pos_out.x, d.pos_out.y

			wait(d.wait_out)

			v_ship_in.alpha = 1
			v_ship_out.alpha = 0
			v_trail_out.alpha = 0
			v_trail_in.alpha = 1
			v_ship_in.animation = d.animations.in_sail

			timer.tween(d.sail_time, self.pos, {
				x = d.pos_in.x,
				y = d.pos_in.y
			}, "out-quad")
			wait(0.8 * d.sail_time)
			timer.tween(0.2 * d.sail_time, v_trail_in, {
				alpha = 0
			}, "out-quad")

			v_ship_in.animation = d.animations.in_idle
			v_ship_out.animation = d.animations.out_idle

			wait(d.wait_in)

			v_ship_out.ts = 0

			timer.tween(1, v_ship_in, {
				alpha = 0
			})
			timer.tween(1, v_ship_out, {
				alpha = 1
			})
			wait(d.wait_in)

			v_ship_out.ts = 0
			v_ship_out.animation = d.animations.out_sail

			timer.tween(0.2 * d.sail_time, v_trail_out, {
				alpha = 1
			}, "in-quad")
			timer.tween(d.sail_time, self.pos, {
				x = d.pos_out.x,
				y = d.pos_out.y
			}, "in-quad")
			wait(d.sail_time)
		end
	end)
end

function deco_fn.ma_ship:update(dt)
	KView.update(self, dt)
end
--2代
deco_fn.m1 = {}

function deco_fn.m1.unlock(this, wait)
	if wait then
		this.ctx.timer.tween(1, this, {
			alpha = 0
		}, "out-quad")
		wait(1)
	else
		this.alpha = 0
	end
end

deco_fn.m2 = {}

function deco_fn.m2.unlock(this, wait)
	if wait then
		this.ctx.timer.tween(1, this, {
			alpha = 0
		}, "out-quad")
		wait(1)
	else
		this.alpha = 0
	end
end

deco_fn.gate = {}

function deco_fn.gate.unlock(this, wait)
	if wait then
		this.animation = {
			to = 128,
			prefix = "ma_gate",
			from = 1
		}
		this.ts = 0

		wait(4.266666666666667)
	else
		this.animation = nil

		this:set_image("ma_gate_0128")
	end
end

deco_fn.ship = {}

function deco_fn.ship.prepare(this)
	local point = this.ctx.screen_map.map_points.points[6][1]

	this.pos.x, this.pos.y = point.pos.x, point.pos.y
	this.animation = this.animations.down_stopped
	this.ts = 0
	this.anchor = v(this.size.x / 2, 2 * this.size.y / 3)
	this.speed = 50
end

function deco_fn.ship.unlock(this, wait)
	if wait then
		this.last_idx = 1
		this.move_ship = true
	else
		this.animation = this.animations.side_stopped

		local points = this.ctx.screen_map.map_points.points[6]
		local point

		for _, p in pairs(points) do
			if p.water then
				point = p
			end
		end

		this.pos = V.vclone(point.pos)
	end
end

function deco_fn.ship:update(dt)
	KView.update(self, dt)

	if self.move_ship then
		local points = self.ctx.screen_map.map_points.points[6]
		local last_point = points[self.last_idx]
		local next_point = points[self.last_idx + 1]

		if not next_point or not next_point.water then
			self.move_ship = false
			self.animation = self.animations.side_stopped

			return
		end

		local next_pos = next_point.pos
		local last_pos = last_point.pos
		local vel = v(0, 0)

		vel.x, vel.y = V.mul(self.speed, V.normalize(next_pos.x - last_pos.x, next_pos.y - last_pos.y))
		self.pos.x, self.pos.y = self.pos.x + vel.x * dt, self.pos.y + vel.y * dt

		if V.dist(self.pos.x, self.pos.y, next_pos.x, next_pos.y) < self.speed * dt then
			self.last_idx = self.last_idx + 1
		end

		local angle = km.unroll(V.angleTo(V.sub(next_pos.x, next_pos.y, last_pos.x, last_pos.y)))
		local pi_8 = math.pi / 8

		if angle > 1 * pi_8 and angle <= 3 * pi_8 then
			self.animation = self.animations.down_side
		elseif angle > 3 * pi_8 and angle <= 5 * pi_8 then
			self.animation = self.animations.down
		else
			self.animation = self.animations.side
		end
	end
end
--1代
deco_fn.ani_seq1 = {}

function deco_fn.ani_seq1:prepare()
	local d = self.ctx.data
	local timer = self.ctx.timer
	local seq_idx = 1

	self.loop = false

	timer.script(function(wait)
		while true do
			local ani_name, wait_min, wait_max = unpack(d.sequence[seq_idx])

			self.animation = d.animations[ani_name]
			self.ts = 0

			wait((self.animation.to - self.animation.from + 1) / 30)
			wait(math.random(wait_min, wait_max))

			seq_idx = km.zmod(seq_idx + 1, #d.sequence)
		end
	end)
end

deco_fn.path_open = {}

function deco_fn.path_open.unlock(this, wait)
	this.hidden = nil

	if wait then
		this.ts = 0
		this.animation = this.animations

		wait(this.animation.to / 30)
	else
		this.ts = 99
	end
end

deco_fn.kr4_map_status = {}

local function kr4_map_level_completed(screen_map, level_index)
	if not screen_map or not screen_map.user_data or not screen_map.user_data.levels then
		return false
	end

	local campaign_mode = rawget(_G, "GAME_MODE_CAMPAIGN") or 1
	local level = screen_map.user_data.levels[150 + level_index]

	return level and (level[campaign_mode] or type(level.stars) == "number" and level.stars > 0)
end

local function kr4_map_set_animation(this, name, loop)
	local data = this.ctx.data
	local animation = data.animations and data.animations[name]

	if not animation then
		return false
	end

	this.animation = animation
	this.loop = loop or false
	this.ts = 0

	return true
end

function deco_fn.kr4_map_status.prepare(this)
	local data = this.ctx.data
	local screen_map = this.ctx.screen_map
	local timer = this.ctx.timer
	local completed = kr4_map_level_completed(screen_map, data.status_level)
	local unlock_data = screen_map and screen_map.unlock_data
	local fresh_level = unlock_data and unlock_data.show_stars_level == 150 + data.status_level and (unlock_data.star_count_before or 0) == 0

	if fresh_level and data.unlock_animation and kr4_map_set_animation(this, data.unlock_animation, data.unlock_loop) then
		local transition = this.animation
		local duration = (transition.to - transition.from + 1) / 30

		timer.after(duration, function()
			kr4_map_set_animation(this, data.completed_animation, data.completed_loop)
		end)
	elseif completed then
		kr4_map_set_animation(this, data.completed_animation, data.completed_loop)
	else
		kr4_map_set_animation(this, data.default_animation or "default", data.default_loop)
	end
end

deco_fn.ma_big_boat = {}

function deco_fn.ma_big_boat:prepare()
	local d = self.ctx.data
	local timer = self.ctx.timer
	local v_ship_in = KImageView(d.animations.in_sail.prefix .. "_0001")
	local v_ship_out = KImageView(d.animations.out_sail.prefix .. "_0001")

	v_ship_in.animation = d.animations.in_sail
	v_ship_out.animation = d.animations.out_sail
	v_ship_out.alpha = 1
	v_ship_out.pos = V.v(0, -8)
	v_ship_in.loop = true
	v_ship_out.loop = true

	self:add_child(v_ship_out)
	self:add_child(v_ship_in)
	timer.script(function(wait)
		while true do
			self.pos.x, self.pos.y = d.pos_out.x, d.pos_out.y

			wait(d.wait_out)

			v_ship_in.alpha = 1
			v_ship_out.alpha = 0
			v_ship_in.animation = d.animations.in_sail

			timer.tween(d.sail_time, self.pos, {
				x = d.pos_in.x,
				y = d.pos_in.y
			}, "out-quad")
			wait(0.8 * d.sail_time)

			v_ship_in.animation = d.animations.in_idle
			v_ship_out.animation = d.animations.out_idle

			wait(d.wait_in)

			v_ship_out.ts = 0

			timer.tween(1, v_ship_in, {
				alpha = 0
			})
			timer.tween(1, v_ship_out, {
				alpha = 1
			})
			wait(d.wait_in)

			v_ship_out.ts = 0
			v_ship_out.animation = d.animations.out_sail

			timer.tween(d.sail_time, self.pos, {
				x = d.pos_out.x,
				y = d.pos_out.y
			}, "in-quad")
			wait(d.sail_time)
		end
	end)
end

deco_fn.kr5_map_paths = {}

function deco_fn.kr5_map_paths.prepare(this)
	local paths = KView:new_from_table(kui_db:get_table("group_map_paths"))

	paths.id = "group_map_paths"
	paths.pos = v(0, 0)
	paths.propagate_on_click = true
	paths.propagate_on_down = true
	paths.propagate_on_up = true

	this:add_child(paths)
end

deco_fn.kr5_map_state = {}

local function kr5_map_level_id(data, rank)
	return (data.level_offset or 100) + rank
end

local function kr5_map_after_level(data, screen_map, rank)
	local unlock_data = screen_map and screen_map.unlock_data
	local user_data = screen_map and screen_map.user_data
	local levels = user_data and user_data.levels
	local next_level = kr5_map_level_id(data, rank + 1)

	if not unlock_data or not levels then
		return false
	end

	if #(unlock_data.unlocked_levels or {}) > 1 then
		if table.contains(unlock_data.unlocked_levels, next_level) then
			return false
		end

		return levels[next_level] ~= nil
	end

	return levels[next_level] ~= nil
end

local function kr5_map_find(paths, id)
	return paths and paths.ci and paths:ci(id)
end

local function kr5_map_set_timeline(timeline, mode)
	if not timeline then
		return
	end

	timeline.hidden = false
	timeline.ts = 0

	if mode == "end" then
		timeline:jump(1e+99, true)
	elseif mode == "start" then
		timeline:start()
	else
		timeline:jump(0, true)
	end
end

local function kr5_map_each_child(root, fn)
	if not root or not root.children then
		return
	end

	for _, c in pairs(root.children) do
		fn(c)
		kr5_map_each_child(c, fn)
	end
end

function deco_fn.kr5_map_state.prepare(this)
	local data = this.ctx.data
	local screen_map = this.ctx.screen_map
	local timer = this.ctx.timer
	local map_view = this.ctx.map_view
	local unlock_data = screen_map and screen_map.unlock_data
	local paths = map_view and map_view:ci("group_map_paths")

	if not map_view or not paths then
		return
	end

	for _, c in pairs(paths.children) do
		c.hidden = true
	end

	local after_level_06 = kr5_map_after_level(data, screen_map, 6)
	local after_level_07 = kr5_map_after_level(data, screen_map, 7)
	local after_level_11 = kr5_map_after_level(data, screen_map, 11)
	local after_level_15 = kr5_map_after_level(data, screen_map, 15)
	local sword = kr5_map_find(paths, "image_sword")
	local sword_exo = map_view:ci("map_deco_sword")

	if after_level_06 then
		if sword then
			sword.hidden = true
		end

		if sword_exo then
			sword_exo.hidden = true
		end
	elseif sword then
		sword.hidden = false
	end

	local temple = kr5_map_find(paths, "timeline_portal_t2")
	local flames = kr5_map_find(paths, "timeline_flames")

	if after_level_07 then
		if unlock_data and unlock_data.new_level == kr5_map_level_id(data, 8) then
			kr5_map_set_timeline(temple)
		else
			kr5_map_set_timeline(temple, "end")

			if flames then
				flames.hidden = false
				flames:start()
			end
		end
	else
		kr5_map_set_timeline(temple)
	end

	local clouds = map_view:ci("decos_map_clouds")
	local thunder = map_view:ci("decos_map_thunder")

	if after_level_11 then
		kr5_map_set_timeline(kr5_map_find(paths, "timeline_portal_1"), "start")
		kr5_map_set_timeline(kr5_map_find(paths, "timeline_portal_2"), "start")
		kr5_map_set_timeline(kr5_map_find(paths, "timeline_stones_portal_t3"), "start")

		if clouds then
			clouds.hidden = not (unlock_data and unlock_data.new_level == kr5_map_level_id(data, 12))
		end

		if thunder then
			thunder.hidden = true
		end
	else
		if clouds then
			clouds.hidden = false
		end

		if thunder then
			thunder.hidden = false
		end
	end

	if after_level_15 then
		local overseer = map_view:ci("decos_map_overseer")

		if overseer then
			overseer.exo_animation = "loop_active"
			overseer.ts = 0
			overseer.loop = true
		end
	end

	local features = rawget(_G, "features")

	if features and features.only_dlc_1 then
		kr5_map_each_child(map_view, function(c)
			if c.exo_name and string.sub(c.exo_name, 1, 9) == "DLCWukong" then
				c.hidden = true
			end
		end)
	end

	timer.script(function(wait)
		if not unlock_data or not unlock_data.new_level then
			return
		end

		wait(1)

		local paths_after_wait = map_view:ci("group_map_paths")

		if not paths_after_wait then
			return
		end

		local rank

		for i = 2, 41 do
			if unlock_data.new_level == kr5_map_level_id(data, i) then
				rank = i
				break
			end
		end

		if not rank then
			return
		end

		local path = paths_after_wait:ci(string.format("path_%02i", rank))
		local fps = path and path.fps or FPS

		if path and path.hidden then
			path.hidden = false
			path:start()

			local anim_delay = 0

			if rank == 8 then
				local timeline_temple = paths_after_wait:ci("timeline_portal_t2")

				if timeline_temple then
					timeline_temple.hidden = false
					timeline_temple:start()
				end

				S:queue("GUIMapCultistBridgeAppear")

				anim_delay = 50

				wait(anim_delay / fps)

				local timeline_flames = paths_after_wait:ci("timeline_flames")

				if timeline_flames then
					timeline_flames.hidden = false
					timeline_flames:start()
				end
			elseif rank == 12 then
				S:queue("GUIMapCloudRemoval")
				wait(50 / fps)

				local clouds = map_view:ci("decos_map_clouds")

				if clouds then
					clouds.exo_animation = "out"
					clouds.ts = 0
					clouds.loop = false
				end
			end

			wait((path.frame_duration - anim_delay) / fps)
		end
	end)
end
return deco_fn
