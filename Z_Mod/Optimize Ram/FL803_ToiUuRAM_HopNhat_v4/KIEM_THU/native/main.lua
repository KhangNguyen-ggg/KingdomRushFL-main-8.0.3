local ROOT=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3]]
local TASK=[[D:/CodexTemp/KRFL_RAM_v4_20261023]]
local results={}
local function write(name,s)local f=assert(io.open(TASK..'/'..name,'wb'));f:write(s);f:close()end
local function pass(s)results[#results+1]='PASS '..s;write('native-progress.txt',table.concat(results,'\n'))end
local function gc()collectgarbage();collectgarbage()end
local function count(t)local n=0;for _ in pairs(t)do n=n+1 end;return n end
function love.load()
 local ok,err=xpcall(function()
  package.path=ROOT..'/lib/?.lua;'..ROOT..'/all/?.lua;'..ROOT..'/kr3/?.lua;'..ROOT..'/kr3-desktop/?.lua;'..ROOT..'/?.lua;'..package.path
  require('klua.table');require('klua.dump')
  local clear_ok,clear=pcall(require,'table.clear');write('table-clear.txt',tostring(clear_ok)..' '..tostring(clear))
  require('klua.log').level=require('klua.log').OFF_LEVEL
  for _,f in ipairs({'lib/klove/sso.lua','lib/klove/font_db.lua','lib/klove/image_db.lua'})do assert(loadfile(TASK..'/candidate/'..f))end
  pass('3 changed Lua modules compile')
  local original=assert(loadfile(ROOT..'/lib/klove/sso.lua'))()
  local patched=assert(loadfile(TASK..'/candidate/lib/klove/sso.lua'))()
  local entities={};for i=1,1200 do entities[i]={id=i,x=(i*7919)%1800-250,y=(i*3929)%1200-100}end
  local function populate(s,frame)
   s:reset(entities);local g=s:create('targets',-100,-100,1600,1100)
   for _,e in ipairs(entities)do if e.id%7~=frame%7 then s:insert(g,e.x+frame%130,e.y-frame%40,e)end end
   return g
  end
  for frame=1,60 do
   populate(original,frame);populate(patched,frame)
   for q=1,20 do
    local a,b={},{};local x=(q*137)%1700-300;local y=(q*103)%1300-100
    local filter=function(_,e)return e.id%3~=0 end
    original:filter(a,'targets',x,y,100+q*10,filter);patched:filter(b,'targets',x,y,100+q*10,filter)
    assert(#a==#b,'Target count changed');for i=1,#a do assert(a[i].id==b[i].id,'Target order changed')end
   end
  end
  pass('1200 target queries match original IDs and order, including moving units, negative coordinates and filters')
  local cell=patched.bb_grids.targets.grid
  populate(patched,61);assert(patched.bb_grids.targets.grid==cell,'Cell grid not reused')
  local weak=setmetatable({},{__mode='v'})
  do local e={id=99999};weak[1]=e;patched:insert(patched.bb_grids.targets,10,10,e)end
  patched:reset(entities);gc();assert(not weak[1],'Old cell retains removed target')
  patched:reset();assert(next(patched.bb_grids)==nil and not patched.bb_all_entities,'Stage teardown retains grid')
  pass('Reuse within stage, release removed targets and clear complete grid on teardown')
  local rows={'version,run,updates,entities,milliseconds,allocated_kib'}
  for run=1,5 do
   for _,pair in ipairs({{'original',original},{'patched',patched}})do
    local s=pair[2];s:reset();for f=1,50 do populate(s,f)end
    gc();collectgarbage('stop');local before=collectgarbage('count');local t=love.timer.getTime()
    for f=1,500 do populate(s,f)end
    local ms=(love.timer.getTime()-t)*1000;local allocated=collectgarbage('count')-before
    collectgarbage('restart');gc()
    rows[#rows+1]=string.format('%s,%d,500,1200,%.3f,%.3f',pair[1],run,ms,allocated)
   end
  end
  write('sso-benchmark.csv',table.concat(rows,'\n'));pass('5 paired native SSO allocation/time benchmarks completed')
  local heap={};for i=1,300000 do heap[i]={i,i+1,i+2}end
  local gcrows={'version,run,updates,entities,milliseconds,heap_growth_kib'}
  for run=1,5 do
   for _,pair in ipairs({{'original',original},{'patched',patched}})do
    local s=pair[2];s:reset();for f=1,50 do populate(s,f)end
    gc();local before=collectgarbage('count');local t=love.timer.getTime()
    for f=1,3000 do populate(s,f);collectgarbage('step',20)end
    gcrows[#gcrows+1]=string.format('%s,%d,3000,1200,%.3f,%.3f',pair[1],run,(love.timer.getTime()-t)*1000,collectgarbage('count')-before)
   end
  end
  write('sso-gc-benchmark.csv',table.concat(gcrows,'\n'));assert(#heap==300000);heap=nil;gc()
  local font=assert(loadfile(TASK..'/candidate/lib/klove/font_db.lua'))()
  font:init('fonts');font.font_files.test='fixture'
  local newFont=love.graphics.newFont;local sizes={}
  love.graphics.newFont=function(_,size)assert(size>=1 and size==math.floor(size));sizes[#sizes+1]=size;return {getHeight=function()return size end}end
  for size=0.1,6,0.05 do font:f('test',size)end
  love.graphics.newFont=newFont
  assert(#sizes==6,'Tiny font cache is unbounded');pass('Fractional tiny sizes share 6 valid font sizes rather than creating one cache entry per request')
  local G=love.graphics;local large=os.getenv('KRFL_LARGE_ATLAS')=='1'
  local data=love.image.newImageData(large and 2048 or 32,large and 2048 or 16);data:mapPixel(function(x,y)return x%256,y%256,99,255 end)
  local f=assert(io.open(TASK..'/native/fixtures/shared.png','wb'));f:write(data:encode('png'):getString());f:close()
  local I=assert(loadfile(TASK..'/candidate/lib/klove/image_db.lua'))();I:setMaxThreads(2)
  local texture_baseline=G.getStats().texturememory
  for cycle=1,12 do
   for _,group in ipairs({'go_towers','go_enemies_common'})do I:queue_load_atlas(1,'fixtures',group)end
   local deadline=love.timer.getTime()+10
   while not I:queue_load_done()do assert(love.timer.getTime()<deadline);love.timer.sleep(.001)end
   assert(I.db_images.shared and I.atlas_uses['go_towers-1.000000']==1)
   I:queue_load_atlas(1,'fixtures','go_towers');while not I:queue_load_done()do love.timer.sleep(.001)end
   assert(I.atlas_uses['go_towers-1.000000']==2,'Duplicate atlas owner count lost')
   I:unload_atlas('go_towers',1);assert(I.db_images.shared and I:s('tower',true))
   I:unload_atlas('go_towers',1);assert(I.db_images.shared and not I:s('tower',true),'Shared texture dropped before last owner')
   I:unload_atlas('go_enemies_common',1);gc()
   assert(not I.db_images.shared and next(I.atlas_uses)==nil and next(I.db_atlas)==nil)
   assert(G.getStats().texturememory==texture_baseline,'Textures accumulate across stage cycles')
  end
  pass('12 real '..(large and '2048x2048' or '32x16')..' upload/unload cycles: formerly permanent groups release last texture, preserve shared and duplicate owners, texture memory returns to baseline')
  write('native-result.txt',table.concat(results,'\n'))
 end,debug.traceback)
 if not ok then write('native-result.txt',table.concat(results,'\n')..'\nFAIL '..tostring(err))end
 love.event.quit()
end
