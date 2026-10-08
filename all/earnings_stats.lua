local M = {}

M.sources = {
	{id = "early_wave", label = "Gọi đợt quái sớm"},
	{id = "hero_pirate", label = "Anh hùng - Blackthorne"},
	{id = "hero_lucerna", label = "Anh hùng - Lucerna"},
	{id = "hero_beresad", label = "Anh hùng - Beresad"},
	{id = "hero_dianyun", label = "Anh hùng - Dianyun"},
	{id = "hero_deadeye", label = "Anh hùng - Johnny"},
	{id = "tower_sand", label = "Tháp - Dune Sentinels"},
	{id = "tower_assassin", label = "Tháp - Sát thủ"},
	{id = "tower_shaolin", label = "Tháp - Thiếu Lâm Tự"},
	{id = "tower_miners", label = "Tháp - Người lùn đào vàng"},
	{id = "tower_alchemist", label = "Tháp - Lều giả kim"},
	{id = "spell_fateful_bond", label = "Phép - Nhân duyên hội ngộ"},
	{id = "spell_hand_midas", label = "Phép - Bàn tay Midas"},
	{id = "spell_royal_edict", label = "Phép - Sắc lệnh hoàng gia"}
}

function M.record(store, source, amount)
	if not store or not source or type(amount) ~= "number" or amount <= 0 then
		return
	end

	local stats = store.earnings_stats

	if not stats then
		stats = {by_source = {}, total = 0}
		store.earnings_stats = stats
	end

	stats.by_source[source] = (stats.by_source[source] or 0) + amount
	stats.total = stats.total + amount
end

function M.adjust_enemy_bonus(enemy, source, delta)
	if not enemy or not source or type(delta) ~= "number" or delta == 0 then
		return
	end

	local bonuses = enemy.earnings_bonuses

	if not bonuses then
		if delta < 0 then
			return
		end

		bonuses = {}
		enemy.earnings_bonuses = bonuses
	end

	bonuses[source] = math.max(0, (bonuses[source] or 0) + delta)
end

function M.record_enemy_payout(store, enemy, amount)
	local bonuses = enemy and enemy.earnings_bonuses

	if not bonuses or type(amount) ~= "number" or amount <= 0 then
		return
	end

	local enemy_data = enemy.enemy or enemy._original_enemy
	local raw_gold = enemy_data and enemy_data.gold or 0
	local factor = raw_gold > 0 and amount / raw_gold or 1
	local bonus_total = 0

	for _, source in ipairs(M.sources) do
		bonus_total = bonus_total + (bonuses[source.id] or 0)
	end

	if bonus_total > 0 then
		factor = math.min(factor, amount / bonus_total)

		for _, source in ipairs(M.sources) do
			M.record(store, source.id, (bonuses[source.id] or 0) * factor)
		end
	end

	enemy.earnings_bonuses = nil
end

return M
