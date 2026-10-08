-- KRFLAPK_JNI_ANDROID_STUB
--
-- The FL APK is built from the desktop Lua tree on top of the KRDOve Android
-- shell. Some KR mobile startup paths expect Ironhide's native jni_android
-- module, but that module is not shipped by the shell. Provide a tiny Lua
-- compatibility layer so those paths can run on Android/Harmony without
-- crashing. Unknown JNI helpers intentionally become safe no-ops.

local M = {}

local properties = {
	HAS_PERMANENT_MENU_KEY = "true",
	API_LEVEL = "35",
	CURRENT_LOCALE = "zh_CN",
	PHONE_TYPE = "android",
	DENSITY_DPI = "320",
	X_DPI = "320",
	Y_DPI = "320",
	DIAGONAL_SIZE_INCHES = "6.5",
	DEVICE_MODEL = "KRFLAPK",
	DEVICE_CPU_CORES = "4",
	DEVICE_RAM = "2048"
}

function M.get_system_property(name)
	return properties[name] or ""
end

return setmetatable(M, {
	__index = function()
		return function()
			return nil
		end
	end
})
