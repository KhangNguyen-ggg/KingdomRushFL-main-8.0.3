local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_Voli_SlotFix_20261024]]
local patch=root..'/Z_Mod/Volibear/FL803_Volibear_LoL20_FixMoSlot_20261024'
local function read(path)local f=assert(io.open(path,'rb'));local s=f:read('*a');f:close();return s end
function love.load()
 local ok,err=xpcall(function()
  package.path=root..'/lib/?.lua;'..root..'/all/?.lua;'..package.path
  require('klua.table');require('klua.log').level=100
  local I=require('klove.image_db');require('klove.kui')
  local old=read(patch..'/BACKUP_TRUOC_VA/all-desktop/screen_map.lua'):gsub('^'..string.char(239,187,191),'')
  local new=read(patch..'/CAP_NHAT/all-desktop/screen_map.lua')
  assert(loadstring(new),'Map syntax')
  local function textures(src)return assert(loadstring('return '..assert(src:match('screen_map.required_textures%s*=%s*(%b{})'))))()end
  local function contains(t,s)for _,v in ipairs(t)do if v==s then return true end end return false end
  assert(not contains(textures(old),'ui_volibear_lol20'))
  local before,msg=pcall(function()return KImageView:new('encyclopedia_creep_thumbs_volibear_prestige')end)
  assert(not before and tostring(msg):find("ss"), 'Expected missing sprite failure: '..tostring(msg))
  local result={'REPRODUCED before fix: '..tostring(msg)}
  assert(contains(textures(new),'ui_volibear_lol20'))
  assert(new:gsub('\n\t"ui_volibear_lol20",','',1)==old,'Only the required UI atlas may change')
  I:setMaxThreads(8)
  for cycle=1,3 do
   I:queue_load_atlas(1,'assets','ui_volibear_lol20')
   local deadline=love.timer.getTime()+15
   while not I:queue_load_done()do assert(love.timer.getTime()<deadline);love.event.pump();love.timer.sleep(0.002)end
   for _,name in ipairs({'encyclopedia_creep_thumbs_volibear_prestige','encyclopedia_creeps_volibear_prestige','info_portrait_volibear_lol20','volibear_skill_p','volibear_skill_q','volibear_skill_w','volibear_skill_e','volibear_skill_r'})do
    local view=KImageView:new(name);assert(view.size.x>0 and view.size.y>0 and view.image);view:draw();view:destroy()
   end
   I:unload_atlas('ui_volibear_lol20',1);collectgarbage('collect')
  end
  result[#result+1]='PASS: one-line map preload fix; actual KImageView creation/drawing for thumbnail, portrait, HUD and P/Q/W/E/R; 3 native atlas load/unload cycles at 8 workers. No game save writes. Full map and combat not tested.'
  return table.concat(result,'\n')
 end,debug.traceback)
 local f=assert(io.open(task..'/result.txt','wb'));f:write(ok and err or 'FAIL '..tostring(err));f:close();love.event.quit()
end
