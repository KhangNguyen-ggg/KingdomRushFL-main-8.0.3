local task=[[D:/CodexTemp/KRFL_Voli_OriginalVFX_20261025]]
local pack=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3/Z_Mod/Volibear/FL803_Volibear_VFXGoc_20261025]]
local selections={
 {'claw','samira_base_ba_outer_flare.png',160,160},
 {'trail','volibear_skin09_egosofttrail.png',224,112},
 {'flare','volibear_skin09_basicattack_flarediamond.png',96,96},
 {'chain','volibear_skin09_q_wisptrail_add.png',256,64},
 {'paw','volibear_skin07_pawprints01.png',96,96},
 {'mark','volibear_skin09_w_debufficon01.png',96,96},
 {'w_bite','volibear_skin09_w_debufficon_dissolve.png',128,128},
 {'e_ring','volibear_skin09_grounddecal01.png',192,192},
 {'e_bolt','volibear_skin09_e_skybolt_01.png',96,384},
 {'e_hit','volibear_skin09_e_skybolt_hit_01.png',64,256},
 {'shield','volibear_skin09_e_shieldring.png',192,192},
 {'r_warning','volibear_skin09_r_aoe_warning.png',192,192},
 {'r_crater','volibear_skin09_r_groud01.png',192,192,raw=true},
 {'r_cracks','volibear_skin09_r_groud02.png',192,192},
 {'r_trail','volibear_skin09_r_smoke_trail.png',192,96},
 {'r_ring','volibear_skin09_grounddecal09_01.png',192,192},
 {'spark','volibear_skin09_star_flash.png',64,64},
 {'impact','volibear_skin09_impact01.png',80,80,cols=2,rows=2},
 {'flame','volibear_skin09_idle_flamefb_4x2.png',64,64,cols=4,rows=2},
 {'cloud','volibear_skin09_e_clouds.png',80,80,cols=2,rows=2,raw=true}
}
local function write(path,value)local f=assert(io.open(path,'wb'));f:write(value);f:close()end
function love.load()
 local ok,err=xpcall(function()
  local frames={};local report={}
  for _,s in ipairs(selections)do
   local source=love.image.newImageData('particles/'..s[2]);local sw,sh=source:getDimensions()
   local cols,rows=s.cols or 1,s.rows or 1;local cw,ch=sw/cols,sh/rows
   assert(cw%1==0 and ch%1==0)
   report[#report+1]=string.format('%s\t%s\t%dx%d\t%s',s[1],s[2],s[3],s[4],s.raw and 'original RGBA' or 'luminance to alpha; preserve hue')
   for n=1,cols*rows do
    local cx,cy=((n-1)%cols)*cw,math.floor((n-1)/cols)*ch
    local cropped=love.image.newImageData(cw,ch);cropped:paste(source,0,0,cx,cy,cw,ch)
    if not s.raw then cropped:mapPixel(function(x,y,r,g,b,a)
     local brightness=math.max(r,g,b)
     if brightness==0 then return 255,255,255,0 end
     return r*255/brightness,g*255/brightness,b*255/brightness,a*brightness/255
    end)end
    local data=love.image.newImageData(s[3],s[4])
    data:mapPixel(function(x,y)
     local fx,fy=(x+.5)*cw/s[3]-.5,(y+.5)*ch/s[4]-.5
     local x0,y0=math.floor(fx),math.floor(fy);local dx,dy=fx-x0,fy-y0
     local out={0,0,0,0}
     for j=0,1 do for i=0,1 do
      local weight=(i==0 and 1-dx or dx)*(j==0 and 1-dy or dy)
      local r,g,b,a=cropped:getPixel(math.max(0,math.min(cw-1,x0+i)),math.max(0,math.min(ch-1,y0+j)))
      out[1]=out[1]+r*weight;out[2]=out[2]+g*weight;out[3]=out[3]+b*weight;out[4]=out[4]+a*weight
     end end
     return unpack(out)
    end)
    frames[#frames+1]={name='voli_original_'..s[1]..'_'..string.format('%04d',n),data=data,w=s[3],h=s[4]}
   end
  end
  table.sort(frames,function(a,b)return a.h>b.h or a.h==b.h and a.w>b.w end)
  local x,y,rowh=2,2,0
  for _,f in ipairs(frames)do
   if x+f.w+2>1024 then x=2;y=y+rowh+4;rowh=0 end
   f.x,f.y=x,y;x=x+f.w+4;rowh=math.max(rowh,f.h)
  end
  assert(y+rowh+2<=1024,'Atlas does not fit 1024x1024: '..(y+rowh+2))
  local atlas=love.image.newImageData(1024,1024);local lines={'-- Original particle textures repacked for KR_FL; no procedural replacement art.','return {'}
  for _,f in ipairs(frames)do
   atlas:paste(f.data,f.x,f.y,0,0,f.w,f.h)
   lines[#lines+1]=string.format(' %s={a_name="go_volibear_original_vfx.png",size={%d,%d},trim={0,0,0,0},a_size={1024,1024},f_quad={%d,%d,%d,%d},alias={}},',f.name,f.w,f.h,f.x,f.y,f.w,f.h)
  end
  lines[#lines+1]='}'
  local dest=pack..'/CAP_NHAT/kr3-desktop/assets/images/fullhd/'
  write(dest..'go_volibear_original_vfx.lua',table.concat(lines,'\n'))
  write(dest..'go_volibear_original_vfx.png',atlas:encode('png'):getString())
  write(pack..'/NGUON_TEXTURE.tsv','key\tsource\tsize_per_frame\tconversion\n'..table.concat(report,'\n'))
  write(task..'/build_result.txt',string.format('PASS %d original textures / %d frames packed into one 1024x1024 RGBA atlas (4 MiB uncompressed)',#selections,#frames))
 end,debug.traceback)
 if not ok then write(task..'/build_result.txt','FAIL '..err)end
 love.event.quit()
end
