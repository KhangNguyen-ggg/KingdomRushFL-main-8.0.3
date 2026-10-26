local target=[[D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3/Z_Mod/Volibear/FL803_Volibear_LoL20_Real3D_20261023/CAP_NHAT/kr3-desktop/assets/images/fullhd/]]
function love.load()
 local g=love.graphics;local canvas=g.newCanvas(512,512);g.setCanvas(canvas);g.clear(0,0,0,0);g.setColor(255,255,255,255)
 local avatar=g.newImage('inputs/Avatar3.png');local w,h=avatar:getDimensions()
 local function crop(x,y,dw,dh,sx,sy,sw,sh)
  local q=g.newQuad(sx*w,sy*h,sw*w,sh*h,w,h);g.draw(avatar,q,x,y,0,dw/(sw*w),dh/(sh*h))
 end
 crop(0,0,84,84,0.20,0.12,0.62,0.62);crop(0,90,72,72,0.20,0.12,0.62,0.62)
 crop(100,0,224,280,0.10,0.02,0.80,0.88)
 for i,key in ipairs({'P','Q','W','E','R'})do
  local img=g.newImage('inputs/Volibear'..key..'.png');g.draw(img,100+(i-1)*56,312,0,56/img:getWidth(),56/img:getHeight())
 end
 g.setCanvas();local data=canvas:newImageData();local encoded=data:encode('png')
 local f=assert(io.open(target..'ui_volibear_lol20.png','wb'));f:write(encoded:getString());f:close()
 local entries={
  'encyclopedia_creep_thumbs_volibear_prestige={a_name="ui_volibear_lol20.png",size={84,84},trim={0,0,0,0},a_size={512,512},f_quad={0,0,84,84},alias={}},',
  'encyclopedia_creeps_volibear_prestige={a_name="ui_volibear_lol20.png",size={320,360},trim={48,40,48,40},a_size={512,512},f_quad={100,0,224,280},alias={}},',
  'info_portrait_volibear_lol20={a_name="ui_volibear_lol20.png",size={72,72},trim={0,0,0,0},a_size={512,512},f_quad={0,90,72,72},alias={}},'
 }
 for i,key in ipairs({'p','q','w','e','r'})do entries[#entries+1]=string.format('volibear_skill_%s={a_name="ui_volibear_lol20.png",size={56,56},trim={0,0,0,0},a_size={512,512},f_quad={%d,312,56,56},alias={}},',key,100+(i-1)*56)end
 f=assert(io.open(target..'ui_volibear_lol20.lua','wb'));f:write('return {\n'..table.concat(entries,'\n')..'\n}\n');f:close()
 love.event.quit()
end
