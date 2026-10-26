
local root=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local task=[[D:/CodexTemp/KRFL_LoadAudit_20261024]]
local out={};local function note(s)out[#out+1]=s end
function love.load()
 local ok,err=xpcall(function()
  package.path=root..'/lib/?.lua;'..root..'/all/?.lua;'..root..'/kr3/?.lua;'..package.path
  love.filesystem.setRequirePath('game/lib/?.lua;game/all/?.lua;game/kr3/?.lua;?.lua')
  KR_PATH_GAME='game/kr3';require('constants');require('klua.table');require('klua.log').level=0
  local G=love.graphics;local I=require('klove.image_db')
  for _,file in ipairs({'lib/klove/image_db.lua','all/render_utils.lua'})do assert(loadfile(task..'/candidate/'..file))end
  note('PASS 2 candidate Lua files compile')
  local d=love.image.newImageData(1,1);d:setPixel(0,0,255,0,0,255);I:add_image('probe-red',G.newImage(d),'probe',1)
  local ss=I:s('probe-red');local missing=table.deepclone(ss);missing.atlas='probe-missing';I.db_atlas['probe-missing']=missing
  for _,source in ipairs({root,task..'/candidate'})do
   local RU=assert(loadfile(source..'/all/render_utils.lua'))()
   for _,draw in ipairs({'draw_frames_range','draw_frames_range_5'})do
    RU.init();local c=G.newCanvas(100,40)
    local function frame(ss,x)return {ss=ss,z=1,pos={x=x,y=REF_H-5},offset={x=0,y=0},anchor={x=0,y=1},scale={x=20,y=20},r=0,alpha=255}end
    G.push('all');G.setCanvas(c);G.clear(0,0,0,0);G.origin();RU[draw]({frame(ss,5),frame(missing,50)},1,100);G.pop()
    local pix=c:newImageData();local rr,_,_,aa=pix:getPixel(55,10)
    assert(select(1,pix:getPixel(10,10))>200,'Good frame disappeared')
    if source==root then assert(rr>200 and aa>200,'Old renderer did not reproduce stale atlas')else assert(aa==0,'Missing texture reused previous image')end
    note((source==root and 'REPRO old' or 'PASS patched')..' '..draw..': missing texture alpha='..aa)
    RU.destroy()
   end
  end
  for _,source in ipairs({root,task..'/candidate'})do
   local img=assert(loadfile(source..'/lib/klove/image_db.lua'))()
   img.queue_load_total_images=1
   img.threads={{isRunning=function()return false end,getError=function()return 'PNG decode: memory allocation failed' end}}
   -- A thread entry normally contains the thread plus its two channels.
   img.threads={{img.threads[1],{push=function()end}, {}}}
   local success,ready=pcall(img.queue_load_done,img)
   if source==root then assert(success and ready==true,'Old loader no longer reproduces incomplete stage entry')
   else assert(not success and tostring(ready):find('memory allocation failed',1,true),'Decode error silently ignored')end
   note((source==root and 'REPRO old' or 'PASS patched')..' failed worker: incomplete stage entry '..tostring(success))
  end
  -- Keep a live heap similar in size to the real map/template state.
  local heap={};for i=1,550000 do heap[i]={id=i,pos={x=i,y=i},status={true,false,i},name='fixture'..i}end
  note(string.format('heap fixture %.1f MiB',collectgarbage('count')/1024))
  local groups={'go_stage56','go_stage56_bg','go_enemies_wastelands','go_enemy_set','go_enemies_blackburn','go_towers','go_towers_1','go_towers_2'}
  local realgc=collectgarbage
  for cycle=1,3 do for _,source in ipairs({root,task..'/candidate'})do
   local img=assert(loadfile(source..'/lib/klove/image_db.lua'))();img:setMaxThreads(8)
   local full,seconds,calls,maxworkers=0,0,0,0
   collectgarbage=function(mode,...)local t=love.timer.getTime();local v=realgc(mode,...);if not mode or mode=='collect'then full=full+1;seconds=seconds+love.timer.getTime()-t end;return v end
   local start=love.timer.getTime()
   for _,group in ipairs(groups)do img:queue_load_atlas(1,'assets',group)end
   while not img:queue_load_done()do calls=calls+1;maxworkers=math.max(maxworkers,#img.threads);love.event.pump();love.timer.sleep(.001);assert(love.timer.getTime()-start<60)end
   collectgarbage=realgc
   assert(img:s('boss_veznan_taunts_love_0001') and img:i('go_stage12-1-1'))
   note(string.format('BENCH %s cycle%d load=%.3fs GC=%d/%.3fs polls=%d workers=%d texture=%.1fMiB',source==root and 'old' or 'new',cycle,love.timer.getTime()-start,full,seconds,calls,maxworkers,G.getStats().texturememory/1048576))
   for _,group in ipairs(groups)do img:queue_unload_atlas(group,1)end
   while not img:queue_unload_done()do end
   assert(not next(img.db_images) and not next(img.db_atlas));img=nil;realgc()
  end end
  assert(#heap==550000);note('PASS 3 load/unload cycles per variant with 8 workers; no user save/game files changed')
 end,debug.traceback)
 if not ok then note('FAIL '..tostring(err))end
 local f=assert(io.open(task..'/checks.txt','wb'));f:write(table.concat(out,'\n'));f:close();love.event.quit()
end
