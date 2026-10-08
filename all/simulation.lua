-- chunkname: @./all/simulation.lua

local log = require("klua.log"):new("simulation")
local km = require("klua.macros")
local S = require("systems")

require("constants")

simulation = {}

function simulation:init(store, system_names)
	self.store = store

	local d = store

	d.tick_length = TICK_LENGTH
	d.tick = 0
	d.tick_ts = 0
	d.ts = 0
	d.to = 0
	d.paused = false
	d.step = false
	d.entities = {}
	d.pending_inserts = {}
	d.pending_removals = {}
	d.entity_count = 0
	d.entity_max = 0
	self.systems_on_queue = {}
	self.systems_on_dequeue = {}
	self.systems_on_insert = {}
	self.systems_on_insert_unconditional = {}
	self.systems_on_remove = {}
	self.systems_on_remove_unconditional = {}
	self.systems_on_update = {}
	self.systems_on_render_update = {}
	self.systems_on_queue_count = 0
	self.systems_on_dequeue_count = 0
	self.systems_on_insert_count = 0
	self.systems_on_insert_unconditional_count = 0
	self.systems_on_remove_count = 0
	self.systems_on_remove_unconditional_count = 0
	self.systems_on_update_count = 0
	self.systems_on_render_update_count = 0
	self.render_system = nil

	local systems_order = {}

	for _, name in ipairs(system_names) do
		if not S[name] then
			log.error("System named %s not found", name)
		else
			table.insert(systems_order, S[name])
		end
	end

	if DEBUG then
		-- block empty
	end

	for _, s in ipairs(systems_order) do
		if not s then
			log.error("system %s could not be found", s)
		
		elseif s.init and s:init(self.store) == "skip" then
			--block
		else
			if s.name == "render" and s.prepare_frame then
				self.render_system = s
			end

			--if s.init then
			--	s:init(self.store)
			--end

			if s.on_queue then
				table.insert(self.systems_on_queue, s)
				self.systems_on_queue_count = #self.systems_on_queue
			end

			if s.on_dequeue then
				table.insert(self.systems_on_dequeue, s)
				self.systems_on_dequeue_count = #self.systems_on_dequeue
			end

			if s.on_insert then
				table.insert(self.systems_on_insert, s)
				self.systems_on_insert_count = #self.systems_on_insert
			end

			if s.on_insert_unconditional then
				table.insert(self.systems_on_insert_unconditional, s)
				self.systems_on_insert_unconditional_count = #self.systems_on_insert_unconditional
			end

			if s.on_remove then
				table.insert(self.systems_on_remove, s)
				self.systems_on_remove_count = #self.systems_on_remove
			end

			if s.on_remove_unconditional then
				table.insert(self.systems_on_remove_unconditional, s)
				self.systems_on_remove_unconditional_count = #self.systems_on_remove_unconditional
			end

			if s.on_update then
				table.insert(self.systems_on_update, s)
				self.systems_on_update_count = #self.systems_on_update
			end

			if s.on_render_update then
				table.insert(self.systems_on_render_update, s)
				self.systems_on_render_update_count = #self.systems_on_render_update
			end
		end
	end

	self.systems_on_queue_count = #self.systems_on_queue
	self.systems_on_dequeue_count = #self.systems_on_dequeue
	self.systems_on_insert_count = #self.systems_on_insert
	self.systems_on_insert_unconditional_count = #self.systems_on_insert_unconditional
	self.systems_on_remove_count = #self.systems_on_remove
	self.systems_on_remove_unconditional_count = #self.systems_on_remove_unconditional
	self.systems_on_update_count = #self.systems_on_update
	self.systems_on_render_update_count = #self.systems_on_render_update
end

function simulation:update(dt)
	local d = self.store

	if d.paused and not d.step then
		self:flush_pending_entities()

		return
	end

	d.dt = dt
	d.ts = d.ts + dt
	d.to = d.to + dt

	if d.realtime_accumulator then
		local tick_length = d.tick_length or TICK_LENGTH

		while d.to >= tick_length do
			d.to = d.to - tick_length

			self:do_tick(tick_length)

			d.step = false
		end
	elseif d.to > TICK_LENGTH then
		d.to = km.clamp(0, TICK_LENGTH, d.to - TICK_LENGTH)

		self:do_tick(TICK_LENGTH)

		d.step = false
	end
end


function simulation:prepare_render(dt)
	local d = self.store

	if d.paused and not d.step then
		return
	end

	for i = 1, self.systems_on_render_update_count do
		self.systems_on_render_update[i]:on_render_update(dt or 0, d.tick_ts or 0, d)
	end

	if self.render_system then
		self.render_system:prepare_frame(dt or 0, d.tick_ts or 0, d)
	end
end

function simulation:do_tick(tick_length)
	local d = self.store
	local tl = tick_length or d.tick_length or TICK_LENGTH
	local perf = _G.KR_PERFORMANCE_MONITOR
	local started = perf and love.timer.getTime()

	d.tick = d.tick + 1
	d.tick_ts = d.tick_ts + tl

	self:flush_pending_entities()
	if started then
		perf.record("simulation.flush_pending", love.timer.getTime() - started)
		started = love.timer.getTime()
	end
	for i = 1, self.systems_on_update_count do
		local system = self.systems_on_update[i]
		local system_started = started and love.timer.getTime()
		system:on_update(tl, d.tick_ts, d)
		if system_started then
			perf.record(system.name .. ".on_update", love.timer.getTime() - system_started)
		end
	end
	if started then
		perf.record("simulation.systems_total", love.timer.getTime() - started)
	end
end

function simulation:flush_pending_entities()
	local d = self.store
	local flushed = false

	local pending_inserts = d.pending_inserts
	local i = 1

	while i <= #pending_inserts do
		self:insert_entity(pending_inserts[i])
		i = i + 1
		flushed = true
	end

	for j = 1, i - 1 do
		pending_inserts[j] = nil
	end

	local pending_removals = d.pending_removals
	i = 1

	while i <= #pending_removals do
		self:remove_entity(pending_removals[i])
		i = i + 1
		flushed = true
	end

	for j = 1, i - 1 do
		pending_removals[j] = nil
	end

	return flushed
end

function simulation:queue_insert_entity_exit(e)
	if not e then
		return
	end

	local d = self.store

	if not self.store or not self.store.level_idx or self.store.level_idx <= 100 then
		return
	end

	for i = 1, self.systems_on_queue_count do
		self.systems_on_queue[i]:on_queue(e, d, true)
	end

	e.pending_removal = nil

	d.pending_inserts[#d.pending_inserts + 1] = e
end

function simulation:queue_insert_entity(e)
	if not e then
		return
	end

	local d = self.store

	for i = 1, self.systems_on_queue_count do
		self.systems_on_queue[i]:on_queue(e, d, true)
	end

	e.pending_removal = nil

	d.pending_inserts[#d.pending_inserts + 1] = e
end

function simulation:queue_remove_entity(e)
	if not e then
		return
	end

	local d = self.store

	if e.pending_removal then
		log.debug("prevented double remove of (%s) %s", e.id, e.template_name)

		return
	end

	for i = 1, self.systems_on_queue_count do
		self.systems_on_queue[i]:on_queue(e, d, false)
	end

	e.pending_removal = true

	self.store.pending_removals[#self.store.pending_removals + 1] = e
end

function simulation:insert_entity(e)
	local d = self.store

	for i = 1, self.systems_on_insert_count do
		local sys = self.systems_on_insert[i]

		if not sys:on_insert(e, d) then
			for j = 1, self.systems_on_dequeue_count do
				self.systems_on_dequeue[j]:on_dequeue(e, d, true)
			end

			log.debug("entity %s %s NOT added by sys %s", e.id, e.template_name, sys.name)

			return
		end
	end

	if (e.id == nil) then
		e.id = #d.entities + 1
	end

	for i = 1, self.systems_on_insert_unconditional_count do
		self.systems_on_insert_unconditional[i]:on_insert_unconditional(e, d)
	end

	e.pending_removal = nil
	d.entities[e.id] = e

	d.entity_count = d.entity_count + 1
	d.entity_max = d.entity_count >= d.entity_max and d.entity_count or d.entity_max

	log.debug("entity (%s) %s added", e.id, e.template_name)
end

function simulation:remove_entity(e)
	local d = self.store

	if d.entities[e.id] == nil then
		return
	end

	for i = 1, self.systems_on_remove_count do
		local sys = self.systems_on_remove[i]

		if not sys:on_remove(e, d) then
			for j = 1, self.systems_on_dequeue_count do
				self.systems_on_dequeue[j]:on_dequeue(e, d, false)
			end

			log.debug("entity %s %s NOT removed by sys %s", e.id, e.template_name, sys.name)

			return
		end
	end

	for i = 1, self.systems_on_remove_unconditional_count do
		self.systems_on_remove_unconditional[i]:on_remove_unconditional(e, d)
	end

	e.pending_removal = nil
	d.entities[e.id] = nil
	d.entity_count = d.entity_count - 1

	log.debug("entity (%s) %s removed", e.id, e.template_name)
end

return simulation
