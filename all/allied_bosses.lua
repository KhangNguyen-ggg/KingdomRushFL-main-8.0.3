-- Independent allied boss modules; metadata remains safe to load before the game.
local M={list={
	(require("allied_blackburn")),
	(require("allied_juggernaut")),
	(require("allied_set")),
	(require("allied_navira")),
	(require("allied_mirage")),
	(require("allied_alric")),
	(require("allied_malik")),
	(require("allied_godieth")),
	(require("allied_navira").blue)
}}
for _,hero in ipairs(require("allied_sett").list) do M.list[#M.list+1]=hero end
M.list[#M.list+1]=require("allied_lich_king")
local by_name={}
for _,boss in ipairs(M.list) do
	boss.portrait=boss.icon:gsub("encyclopedia_creep_thumbs_","encyclopedia_creeps_")
	by_name[boss.name]=boss
end
function M.get(name) return by_name[name] end
function M.register(name)
	local boss=assert(M.get(name),"Unknown allied boss: "..tostring(name))
	return boss.register()
end
return M
