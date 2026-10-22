-- chunkname: @./kr3-desktop/assets/strings/zh-Hans.lua

local z1 = require("assets.strings." .. "zh-Hant_1")
local z2 = require("assets.strings." .. "zh-Hant_2")
local z3 = require("assets.strings." .. "zh-Hant_3")
--local z4 = require("assets.strings." .. "zh-Hant_4")
local z5 = require("assets.strings." .. "zh-Hant_5")
local z={}
local count = 0

for k, v in pairs(z5) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z1) do
	z[k] = v
end

for k, v in pairs(z2) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

for k, v in pairs(z3) do
	if z[k] and z[k] ~=v then
		count=count+1
	end
	z[k] = v
end

z["BUTTON_NEXT_PAGE"] = "下一頁"
z["BUTTON_PREV_PAGE"] = "上一頁"
z["Rush"] = "守衛軍"
z["Frontier"] = "前線"
z["Origin"] = "起源"
z["SETTINGS_MAX_THREADS"] = "最大綫程數"
z["TOWER_G45_PICK"] = "pick=%i"
z["HERO_ENHANCE_MODE"] = "英雄補強"
z["HERO_ENHANCE_ON"] = "已開啟補強"
z["HERO_ENHANCE_OFF"] = "已關閉補強"

z["TIP_CRYSTAL_ALTAR_TITLE"] = "魔晶祭壇"
z["TIP_CRYSTAL_ALTAR_DESC_1"] = "祭壇每秒對所有我方單位造成10 + 2 x 當前波次點物理傷害。"
z["TIP_CRYSTAL_ALTAR_DESC_2"] = "生命低於75% x (1 - 護甲值)的我方單位會被直接斬殺。"
z["TIP_CRYSTAL_ALTAR_DESC_3"] = "祭壇存在時，我方單位復活時間延長3秒。擊敗魔晶恐魔後祭壇失效。"

require("legacy_upgrade_strings").apply(z, {z1, z2, z3})

local zkr6 = require("assets.strings.zh-Hant_6")

for key, value in pairs(zkr6) do
	if z[key] == nil then
		z[key] = value
	end
end

return z
