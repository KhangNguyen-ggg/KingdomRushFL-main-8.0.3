local task=[[D:/CodexTemp/KRFL_Voli_8Huong_20261025]]
local pack=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3/Z_Mod/Volibear/FL803_Volibear_Full_8Huong_VFX_20261025]]
local dirs={'e','ne','n','nw','w','sw','s','se'}
local configs={{'walk8',24},{'qrun8',20},{'rrun8',24},{'idle8',24}}
local rows={};local total=0
local function write(path,s)local f=assert(io.open(path,'wb'));f:write(s);f:close()end
local function power2(n)local v=1;while v<n do v=v*2 end;return v end
function love.load()
 local ok,err=xpcall(function()
  local sum_bytes=0
  for _,cfg in ipairs(configs)do
   local tag,count=unpack(cfg);local frames={}
   for _,dir in ipairs(dirs)do for index=1,count do
    local name=string.format('%s_%s_%04d',tag,dir,index)
    local data=love.image.newImageData('frames/'..tag..'/'..dir..'/'..name..'.png')
    local w,h=data:getDimensions();assert(w==256 and h==256)
    local left,top,right,bottom=256,256,0,0
    for y=0,255 do for x=0,255 do
     local _,_,_,a=data:getPixel(x,y)
     if a>2 then left=math.min(left,x);right=math.max(right,x+1);top=math.min(top,y);bottom=math.max(bottom,y+1)end
     if a>16 then assert(x>0 and x<255 and y>0 and y<255,'Clipped pose: '..name)end
    end end
    assert(right>left and bottom>top,'Empty pose '..name)
    left,top,right,bottom=math.max(0,left-2),math.max(0,top-2),math.min(256,right+2),math.min(256,bottom+2)
    local crop=love.image.newImageData(right-left,bottom-top);crop:paste(data,0,0,left,top,right-left,bottom-top)
    frames[#frames+1]={name='volibear_'..name,w=right-left,h=bottom-top,trim={left,top,256-right,256-bottom},data=crop}
   end end
   table.sort(frames,function(a,b)return a.h>b.h or a.h==b.h and (a.w>b.w or a.w==b.w and a.name<b.name)end)
   local best
   for _,width in ipairs({512,1024,2048,4096})do
    local x,y,rowh=2,2,0;local locations={}
    for _,f in ipairs(frames)do
     if x+f.w+2>width then x=2;y=y+rowh+4;rowh=0 end
     locations[#locations+1]={x,y};x=x+f.w+4;rowh=math.max(rowh,f.h)
    end
    local height=power2(y+rowh+2)
    if height<=4096 and (not best or width*height<best.width*best.height)then best={width=width,height=height,locations=locations}end
   end
   assert(best,'Atlas too large '..tag)
   local atlas=love.image.newImageData(best.width,best.height)
   local lines={'-- Genuine 3D eight-direction Volibear poses; fixed ground anchor at (128,222).','return {'}
   for i,f in ipairs(frames)do
    local x,y=unpack(best.locations[i]);atlas:paste(f.data,x,y,0,0,f.w,f.h)
    lines[#lines+1]=string.format(' %s={a_name="go_volibear_%s.png",size={256,256},trim={%d,%d,%d,%d},a_size={%d,%d},f_quad={%d,%d,%d,%d},alias={}},',f.name,tag,f.trim[1],f.trim[2],f.trim[3],f.trim[4],best.width,best.height,x,y,f.w,f.h)
   end
   lines[#lines+1]='}'
   local dest=pack..'/CAP_NHAT/kr3-desktop/assets/images/fullhd/go_volibear_'..tag
   write(dest..'.png',atlas:encode('png'):getString());write(dest..'.lua',table.concat(lines,'\n'))
   local bytes=best.width*best.height*4;sum_bytes=sum_bytes+bytes;total=total+#frames
   rows[#rows+1]=string.format('PASS %s: %d real frames, %dx%d atlas, %.1f MiB RGBA, no clipped/empty poses',tag,#frames,best.width,best.height,bytes/1048576)
   frames=nil;atlas=nil;collectgarbage();collectgarbage()
  end
  assert(total==736);rows[#rows+1]=string.format('PASS all 736 rendered poses packed; total new movement texture memory %.1f MiB',sum_bytes/1048576)
 end,debug.traceback)
 if not ok then rows[#rows+1]='FAIL '..err end
 write(task..'/pack_result.txt',table.concat(rows,'\n'));love.event.quit()
end
