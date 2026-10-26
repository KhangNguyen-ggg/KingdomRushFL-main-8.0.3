
local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_LoadAudit_20261024]]
function love.load()
 local rows={};local function note(s)rows[#rows+1]=s end
 local ok,err=xpcall(function()
  package.path=root..'/lib/?.lua;'..root..'/all/?.lua;'..root..'/kr3/?.lua;'..package.path
  love.filesystem.setRequirePath('game/lib/?.lua;game/all/?.lua;game/kr3/?.lua;?.lua')
  KR_PATH_GAME='game/kr3';require('constants');require('klua.table');require('klua.log').level=100
  local G=love.graphics;local I=require('klove.image_db');I:setMaxThreads(8)
  for _,name in ipairs({'go_stage56','go_stage56_bg','go_enemies_wastelands','encyclopedia_thumbs'})do I:queue_load_atlas(1,'assets',name)end
  local start=love.timer.getTime();while not I:queue_load_done()do love.event.pump();love.timer.sleep(.001)end
  note('queue seconds '..(love.timer.getTime()-start))
  local function save(c,name)local d=c:newImageData():encode('png');local f=assert(io.open(task..'/'..name,'wb'));f:write(d:getString());f:close()end
  local names={'boss_veznan_taunts_love_0001','stage_12_0009','boss_veznan_0001'}
  for _,name in ipairs(names)do
   local ss=assert(I:s(name));local im=assert(I:i(ss.atlas));note(name..' '..ss.atlas..' '..im:getWidth()..'x'..im:getHeight())
   local x,y,w,h=ss.quad:getViewport();local c=G.newCanvas(w,h);G.push('all');G.setCanvas(c);G.clear();G.origin();G.setColor(255,255,255);G.draw(im,ss.quad,0,0);G.pop();save(c,name..'.png')
   local src=love.image.newImageData('assets/'..ss.a_name);local got=c:newImageData();local diffs=0
   for yy=0,h-1 do for xx=0,w-1 do local r,g,b,a=src:getPixel(x+xx,y+yy);local r2,g2,b2,a2=got:getPixel(xx,yy);if a>254 and (math.abs(r-r2)>1 or math.abs(g-g2)>1 or math.abs(b-b2)>1)then diffs=diffs+1 end end end
   assert(diffs==0,name..' wrong pixels '..diffs)
  end
  note('PASS PNG/canvas pixels and quads: taunt/throne/boss')
 end,debug.traceback)
 if not ok then note('FAIL '..tostring(err))end
 local f=assert(io.open(task..'/native.txt','wb'));f:write(table.concat(rows,'\n'));f:close();love.event.quit()
end
