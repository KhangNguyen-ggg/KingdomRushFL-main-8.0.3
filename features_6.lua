-- chunkname: @./features.lua

local _ft = {
	ingame_fit_width_mode = "zoom-ui",
	no_gems = true,
	asset_game_fallback_for_texture_size = {
		uhd_bc3 = {
			{
				texture_size = "ipadhd_bc3",
				path = "kr6-desktop"
			}
		}
	},
	ingame_fit_width_targets = {
		"tablet",
		"desktop"
	},
	libs = {
		"libcurl-x64",
		"khttps",
		"ksystem",
		"steam_api"
	},
	main_params = {
		image_db_uses_canvas = true,
		texture_size = "fullhd_bc3",
		skip_settings_dialog = true,
		first_launch_fullscreen = true,
		texture_size_list = {
			{
				"UHD",
				"uhd_bc3",
				1000000000
			},
			{
				"FullHD",
				"fullhd_bc3",
				1201
			},
			{
				"XGA",
				"ipad",
				700
			}
		}
	},
	platform_services = {
		achievements = {
			src = "platform_services_steam",
			name = "steam_ach",
			enabled = true,
			order = 41
		},
		goliath = {
			src = "platform_services_mc_goliath",
			name = "goliath",
			enabled = true,
			order = 90,
			params = {
				game_id = "2479",
				platform = "steam",
				production = {
					api_url = "https://ed847542-0599-44a1-a111-501850fe8f94.goliath.atlas.bi.miniclippt.com",
					shared_secret = "0e63a418-8509-446e-9ebd-81059d35053e",
					api_key = "ed847542-0599-44a1-a111-501850fe8f94"
				},
				staging = {
					api_url = "https://ef32efc9-50c9-4a19-9ed0-719d409e457f.goliath.atlas.bi.miniclippt.com",
					shared_secret = "6a629836-67a4-4a25-8248-05c56235b54a",
					api_key = "ef32efc9-50c9-4a19-9ed0-719d409e457f"
				}
			}
		},
		http = {
			src = "platform_services_http",
			essential = true,
			enabled = true,
			name = "http"
		},
		iap = {
			src = "platform_services_steam",
			name = "steam_iap",
			enabled = true,
			order = 40,
			params = {
				app_id = 4259190,
				dlcs = {}
			}
		},
		news = {
			src = "platform_services_news_ih_https",
			name = "news_ih",
			enabled = true,
			order = 50,
			params = {
				news_store = "steam",
				news_id = "kr-genesis"
			}
		}
	}
}

return _ft
