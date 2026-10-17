-- chunkname: @./all/i18n.lua

local i18n = {}

i18n.msgs = {}
i18n.default_locale = "en"
i18n.current_locale = "en"
i18n.supported_locales = {
	"vi",
	"de",
	"en",
	"es",
	"fr",
	"ja",
	"ko",
	"pt",
	"ru",
	"zh-Hans",
	"zh-Hant"
}
i18n.locale_names = {
	vi = "Tiếng Việt",
	ko = "한국어",
	de = "Deutsch",
	ru = "Русский",
	pt = "Português",
	["zh-Hant"] = "中文 (繁體)",
	fr = "Français",
	en = "English",
	ja = "日本語",
	["zh-Hans"] = "中文 (简体)",
	es = "Español"
}

function i18n.load_locale(locale)
	i18n.msgs[locale] = require("assets.strings." .. locale)
	i18n.current_locale = locale
end

-- KRFL v0.0.6: most languages only translate the Kingdom Rush Origins part of
-- the 6in1 pack, so a key missing from the current locale falls back to English
-- instead of showing the raw key.
local function fallback_msgs()
	if i18n.msgs[i18n.default_locale] == nil then
		local ok, msgs = pcall(require, "assets.strings." .. i18n.default_locale)

		i18n.msgs[i18n.default_locale] = ok and msgs or false
	end

	return i18n.msgs[i18n.default_locale] or nil
end

function _(s, default)
	local l = i18n.msgs[i18n.current_locale]

	l = l or fallback_msgs()

	local ts = l and l[s]

	if ts == nil and i18n.current_locale ~= i18n.default_locale then
		local fb = fallback_msgs()

		ts = fb and fb[s]
	end

	if ts then
		return ts
	elseif default then
		return default
	else
		return s
	end
end

function i18n:sw(default, ...)
	local args = {
		...
	}

	if #args > 0 then
		for i, a in ipairs(args) do
			if i % 2 == 1 and a == self.current_locale then
				return args[i + 1]
			end
		end
	end

	return default
end

function i18n:cjk(default, zh, ja, ko)
	local cl = self.current_locale

	if (cl == "zh-Hans" or cl == "zh-Hant") and zh then
		return zh
	end

	if cl == "ja" and ja then
		return ja
	end

	if cl == "ko" and ko then
		return ko
	end

	return default
end

function i18n:find_fallback_locale(lang, script)
	local l = lang or ""
	local s = script or ""
	local k1 = l
	local k2 = l .. "-" .. s

	if self.locale_names[k2] then
		return k2
	elseif self.locale_names[k1] then
		return k1
	else
		for _, sl in pairs(self.supported_locales) do
			local ssl = string.sub(sl, 1, string.len(l))

			if ssl == l then
				return sl
			end
		end
	end
end

return i18n
