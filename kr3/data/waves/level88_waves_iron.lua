-- chunkname: @kr1/data/waves/level88_waves_iron.lua

return {
	cash = 5000,
	groups = {
		{
			interval = 1,
			waves = {
				{
					delay = 0,
					path_index = 5,
					spawns = {
						{
							interval = 1,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 3600,
							path = 1
						},
						{
							interval = 1,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 5400,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 60,
							path = 1
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 0,
							path = 2
						},
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 0,
							path = 3
						}
					}
				},
				{
					delay = 0,
					path_index = 1,
					spawns = {
						{
							interval = 11701,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_fremen",
							max = 1,
							interval_next = 0,
							path = 1
						}
					}
				},
				{
					delay = 0,
					path_index = 3,
					spawns = {
						{
							interval = 11701,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_fremen",
							max = 1,
							interval_next = 0,
							path = 1
						}
					}
				}
			}
		}
	}
}
