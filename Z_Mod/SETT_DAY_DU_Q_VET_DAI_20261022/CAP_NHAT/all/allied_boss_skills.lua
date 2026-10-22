-- Compatibility metadata for the existing map/HUD; skills live in each boss file.
local B=require("allied_bosses")
local V=require("klua.vector")
local bit=require("bit")
local M={skills={}}
for _,boss in ipairs(B.list) do M.skills[boss.kind]=boss.skill end
function M.kind(name) return name and name:match("^hero_allied_(.+)$") end
function M.can_fire(hero,x,y,store)
	local C=require("allied_boss_common")
	local skill=M.skills[M.kind(hero and hero.template_name)]
	if not skill then return true end
	if not C.alive(hero) or hero.unit.is_stunned or hero.boss_command or hero.boss_form or hero.boss_casting then return false end
	if C.dist(hero.pos,V.v(x,y))>skill.range then return false end
	if hero.boss_kind=="blackburn" then return true end
	return require("path_db"):valid_node_nearby(x,y,nil,NF_RALLY) and require("grid_db"):cell_is_only(x,y,bit.bor(TERRAIN_LAND,TERRAIN_ICE))
end
return M
