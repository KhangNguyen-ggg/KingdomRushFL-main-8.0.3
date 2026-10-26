local task=[[D:/CodexTemp/KRFL_Voli_FullVFX_20261025]]
local pack=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3/Z_Mod/Volibear/FL803_Volibear_Full_VFX_HoanThien_20261025]]
local selections={
 {'orb','volibear_skin09_aura_self.png',64,64},
 {'spiral','volibear_skin09_idle_backpiece06.png',128,128},
 {'ring_flame','volibear_skin09_grounddecal03.png',128,128},
 {'ring_fine','volibear_skin09_grounddecal04.png',128,128},
 {'energy','volibear_skin09_flameenergy01_01.png',128,128},
 {'energy_gold','volibear_skin09_flameenergy01.png',128,128},
 {'smoke_lick','volibear_skin09_idle_smokeylicks.png',64,128},
 {'vbeam','volibear_skin09_beamtexture01.png',64,128},
 {'crack_ring','volibear_skin09_z_crater_cracks_1.png',192,192},
 {'ground_hole','volibear_skin09_e_ground_hole.png',128,128,raw=true},
 {'shield_edge','volibear_skin09_shield02.png',128,128},
 {'blowback','volibear_skin09_r_landing_blowback.png',128,64},
 {'cylinder','volibear_skin09_r_up_cylinder.png',128,128},
 {'ray','volibear_skin09_r_energy_ray.png',64,128},
 {'smoke','volibear_skin09_sl_dust_01.png',64,64,cols=2,rows=2},
 {'blast','volibear_skin09_e_blastshapes.png',64,64,cols=2,rows=2},
 {'paw_spark','volibear_skin09_pawspark_02.png',64,64,cols=2,rows=2},
 {'bolt','volibear_skin09_e_skybolt_hit_01.png',256,64,rotate=true},
 {'scratch','indicator_straightline01.png',8,96},
}
local function write(p,s)local f=assert(io.open(p,'wb'));f:write(s);f:close()end
function love.load()
 local ok,err=xpcall(function()
  local frames,report={},{}
  for _,s in ipairs(selections)do
   local src=love.image.newImageData('particles/'..s[2]);local sw,sh=src:getDimensions();local cols,rows=s.cols or 1,s.rows or 1
   local cw,ch=sw/cols,sh/rows
   for n=1,cols*rows do
    local data=love.image.newImageData(s[3],s[4]);local cx,cy=((n-1)%cols)*cw,math.floor((n-1)/cols)*ch
    data:mapPixel(function(x,y)
     local fx,fy=(x+.5)/s[3],(y+.5)/s[4];if s.rotate then fx,fy=fy,1-fx end
     local r,g,b,a=src:getPixel(cx+math.min(cw-1,math.floor(fx*cw)),cy+math.min(ch-1,math.floor(fy*ch)))
     if s.raw then return r,g,b,a end
     local bright=math.max(r,g,b);if bright==0 then return 255,255,255,0 end
     local edge=math.min(1,fx/.06,(1-fx)/.06,fy/.06,(1-fy)/.06)
     return r*255/bright,g*255/bright,b*255/bright,a*bright/255*edge*edge*(3-2*edge)
    end)
    frames[#frames+1]={name=string.format('voli_original_%s_%04d',s[1],n),data=data,w=s[3],h=s[4]}
   end
   report[#report+1]=s[1]..'\t'..s[2]..'\t'..(s.raw and 'RGBA' or 'black additive -> straight alpha; hue preserved')
  end
  for _,tag in ipairs({'bear','dragon'})do for n=1,8 do
   local data=love.image.newImageData(string.format('meshes/%s_%04d.png',tag,n))
   frames[#frames+1]={name=string.format('voli_original_%s_%04d',tag,n),data=data,w=192,h=192}
  end end
  table.sort(frames,function(a,b)return a.h>b.h or a.h==b.h and a.w>b.w end)
  local x,y,rh=2,2,0
  for _,f in ipairs(frames)do
   if x+f.w+2>1024 then x,y,rh=2,y+rh+4,0 end
   f.x,f.y=x,y;x=x+f.w+4;rh=math.max(rh,f.h)
  end
  local height=y+rh+2<=1024 and 1024 or 2048;assert(y+rh+2<=height,'Atlas overflow')
  local atlas=love.image.newImageData(1024,height);local lines={'-- Original skin09 texture tiles and original mesh renders.','return {'}
  for _,f in ipairs(frames)do
   atlas:paste(f.data,f.x,f.y,0,0,f.w,f.h)
   lines[#lines+1]=string.format(' %s={a_name="go_volibear_vfx_complete.png",size={%d,%d},trim={0,0,0,0},a_size={1024,%d},f_quad={%d,%d,%d,%d},alias={}},',f.name,f.w,f.h,height,f.x,f.y,f.w,f.h)
  end
  lines[#lines+1]='}'
  local dest=pack..'/CAP_NHAT/kr3-desktop/assets/images/fullhd/'
  write(dest..'go_volibear_vfx_complete.lua',table.concat(lines,'\n'));write(dest..'go_volibear_vfx_complete.png',atlas:encode('png'):getString())
  write(pack..'/NGUON_VFX_BO_SUNG.tsv','key\tsource\tconversion\n'..table.concat(report,'\n'))
  write(task..'/build_result.txt',string.format('PASS %d frames, 1024x%d RGBA (%d MiB uncompressed)',#frames,height,1024*height*4/1048576))
 end,debug.traceback)
 if not ok then write(task..'/build_result.txt','FAIL '..err)end
 love.event.quit()
end
