-- Standalone Sett roster; the author's heroes and enemy bosses are unchanged.
local M={list=require("allied_sett").list}
local by_name={}
for _,hero in ipairs(M.list) do
 hero.portrait=hero.icon:gsub("encyclopedia_creep_thumbs_","encyclopedia_creeps_")
 by_name[hero.name]=hero
end
function M.get(name) return by_name[name] end
function M.register(name) return assert(M.get(name),"Unknown Sett: "..tostring(name)).register() end
return M
