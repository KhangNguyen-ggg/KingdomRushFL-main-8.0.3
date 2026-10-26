-- Eight real camera-space views; keep combat on its existing calibrated sprites.
local M={}
local A
local directions={"e","ne","n","nw","w","sw","s","se"}
local walking={walk=true,walkUp=true,walkDown=true}
local clips={walk8={poses=24,ticks=34},qrun8={poses=20,ticks=20},rrun8={poses=24,ticks=34},idle8={poses=24,ticks=90}}
function M.register(prefix,animations)
 A=animations
 for clip,info in pairs(clips)do
  local frames={}
  for i=0,info.ticks-1 do frames[#frames+1]=math.floor(i*info.poses/info.ticks)+1 end
  for _,direction in ipairs(directions)do
   local name="volibear_"..clip.."_"..direction
   A.db[prefix.."_"..clip.."_"..direction]={prefix=name,frames=frames}
  end
 end
end
function M.update(this,store,s)
 local sprite=this.render.sprites[1]
 local previous=sprite.animation
 local scale=s.ult_end and 1.25 or 1
 if walking[sprite.name] or sprite.name=="idle" then
  local moving=walking[sprite.name] and not this.unit.is_stunned and not this.health.dead
  if moving and this.motion.dest and not this.motion.arrived then
   local dx,dy=this.motion.dest.x-this.pos.x,this.motion.dest.y-this.pos.y
   if dx*dx+dy*dy>.0001 then
    local angle=math.atan2(dy,dx)
    s.move_direction=math.floor((angle+math.pi/8)/(math.pi/4))%8
   end
  end
  local clip=moving and (s.q_end and "qrun8" or s.ult_end and "rrun8" or "walk8") or "idle8"
  if s.move_clip~=clip then sprite.ts=store.tick_ts;sprite.runs=0;s.move_clip=clip end
  sprite.animation=A.db[sprite.prefix.."_"..clip.."_"..directions[(s.move_direction or 0)+1]]
  sprite.volibear_move_direction=s.move_direction or 0
  sprite.anchor.x,sprite.anchor.y=.5,34/256
  sprite.scale.x,sprite.scale.y=scale,scale
  sprite.flip_x=false
 else
  s.move_clip=nil
  sprite.volibear_move_direction=nil
  if sprite.name=="attack" or sprite.name=="attack2" or sprite.name=="q_attack" or sprite.name=="w" then
   s.move_direction=sprite.flip_x and 4 or 0
  end
  sprite.animation=nil
  sprite.anchor.x,sprite.anchor.y=266/512,181/512
  sprite.scale.x,sprite.scale.y=-.68*scale,.68*scale
 end
 if previous~=sprite.animation then sprite._render_state_ts=nil end
end
return M
