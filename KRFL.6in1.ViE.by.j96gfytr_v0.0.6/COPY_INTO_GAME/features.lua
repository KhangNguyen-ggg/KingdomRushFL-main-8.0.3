-- chunkname: @./features.lua

return {
	default_locale = "vi",
	libs = {
		"steam_api"
	},
	platform_services = {
		achievements = {
			src = "platform_services_steam",
			name = "steam",
			enabled = false,
			params = {
				app_id = 816340
			}
		}
	}
}
