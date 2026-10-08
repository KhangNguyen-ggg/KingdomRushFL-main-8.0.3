-- chunkname: @kr1/data/waves/level90_waves_iron.lua

return {
	lives = 1,
	cash = 5000,
	groups = {
		{
			interval = 1,
			waves = {
				{
					delay = 1800,
					path_index = 4,
					some_flying = true,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "eb_malagar_clone",
							max = 1,
							interval_next = 0,
							path = 1
						},
						{
							interval = 3600,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "eb_malagar_clone",
							max = 2,
							interval_next = 3600,
							path = 1
						},
						{
							interval = 1800,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "eb_malagar_clone",
							max = 1,
							interval_next = 1800,
							path = 1
						}
					}
				},
				{
					delay = 14400,
					path_index = 1,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 3600,
							path = 1
						}
					}
				},
				{
					delay = 1500,
					path_index = 1,
					spawns = {
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 7,
							interval_next = 1800,
							path = 2
						},
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_scorpion",
							max = 6,
							interval_next = 2100,
							path = 2
						},
						{
							interval = 600,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_executioner",
							max = 3,
							interval_next = 5100,
							path = 2
						},
						{
							interval = 75,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 10,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					delay = 1500,
					path_index = 1,
					spawns = {
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 7,
							interval_next = 1800,
							path = 3
						},
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_scorpion",
							max = 6,
							interval_next = 2100,
							path = 3
						},
						{
							interval = 600,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_executioner",
							max = 3,
							interval_next = 5100,
							path = 3
						},
						{
							interval = 75,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 10,
							interval_next = 60,
							path = 3
						}
					}
				},
				{
					delay = 0,
					path_index = 3,
					some_flying = true,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "eb_malagar_clone",
							max = 1,
							interval_next = 0,
							path = 1
						},
						{
							interval = 3600,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "eb_malagar_clone",
							max = 4,
							interval_next = 3600,
							path = 1
						}
					}
				},
				{
					delay = 14400,
					path_index = 2,
					spawns = {
						{
							interval = 0,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_primordial",
							max = 1,
							interval_next = 3600,
							path = 1
						}
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 45,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_bouncer",
							max = 40,
							interval_next = 1800,
							path = 2
						},
						{
							interval = 90,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_desert_raider",
							max = 20,
							interval_next = 1845,
							path = 2
						},
						{
							interval = 400,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_sand_monk",
							max = 5,
							interval_next = 2200,
							path = 2
						},
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_munra",
							max = 4,
							interval_next = 3600,
							path = 2
						},
						{
							interval = 75,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 10,
							interval_next = 60,
							path = 2
						}
					}
				},
				{
					delay = 0,
					path_index = 2,
					spawns = {
						{
							interval = 45,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_bouncer",
							max = 40,
							interval_next = 1800,
							path = 3
						},
						{
							interval = 90,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_desert_raider",
							max = 20,
							interval_next = 1845,
							path = 3
						},
						{
							interval = 400,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_sand_monk",
							max = 5,
							interval_next = 2200,
							path = 3
						},
						{
							interval = 300,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_munra",
							max = 4,
							interval_next = 3600,
							path = 3
						},
						{
							interval = 75,
							max_same = 0,
							fixed_sub_path = 1,
							creep = "enemy_immortal",
							max = 10,
							interval_next = 60,
							path = 3
						}
					}
				}
			}
		}
	}
}
