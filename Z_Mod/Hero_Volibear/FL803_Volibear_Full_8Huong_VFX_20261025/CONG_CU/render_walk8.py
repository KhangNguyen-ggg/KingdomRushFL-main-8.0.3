"""Render real eight-view locomotion from the existing, untouched Volibear scene."""
import bpy, math, json, time, runpy, traceback
from pathlib import Path
from mathutils import Vector
from bpy_extras.object_utils import world_to_camera_view

ROOT=Path(r'D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3')
TASK=Path(r'D:/CodexTemp/KRFL_Voli_8Huong_20261025')
PACK=ROOT/'Z_Mod/Volibear/FL803_Volibear_Full_8Huong_VFX_20261025'
OUT=TASK/'frames';OUT.mkdir(exist_ok=True)
helpers=runpy.run_path(str(ROOT/'Z_Mod/Volibear/Volibear_Khada_Render_All_In_One.py'),run_name='voli_helpers')
scene=bpy.context.scene;rig=next(o for o in scene.objects if o.type=='ARMATURE')
meshes=[o for o in scene.objects if o.type=='MESH']
for obj in scene.objects:
 if obj.animation_data:
  for track in obj.animation_data.nla_tracks:track.mute=True
  if obj!=rig:obj.animation_data.action=None
cam=scene.camera
scene.render.resolution_x=scene.render.resolution_y=256
scene.render.resolution_percentage=100;scene.render.film_transparent=True
scene.render.image_settings.color_mode='RGBA';scene.render.image_settings.file_format='PNG'
scene.render.image_settings.compression=20
cam.data.ortho_scale*=.5/.68
ground=Vector((0,0,0));projected=world_to_camera_view(scene,cam,ground)
right=cam.rotation_euler.to_matrix()@Vector((1,0,0));up=cam.rotation_euler.to_matrix()@Vector((0,1,0))
cam.location+=right*(projected.x-.5)*cam.data.ortho_scale
cam.location+=up*(222/256-(1-projected.y))*cam.data.ortho_scale
bpy.context.view_layer.update()
pivot=bpy.data.objects.new('VOLI_DIRECTION',None);scene.collection.objects.link(pivot)
for obj in [rig]+meshes:obj.parent=pivot
az=math.radians(36);elevation=math.radians(30)
directions=['e','ne','n','nw','w','sw','s','se']
clips=[('Run_Base','walk8',24),('Volibear_spell1_run.anm','qrun8',20),('Spell4_Run','rrun8',24),('Idle_Base','idle8',24)]
report={'source_glb':'prestige_duality_dragon_volibear.glb','source_scene':'Untitled.blend','render_size':[256,256],
 'anchor_pixel':[128,222],'world_elevation':30,'directions':directions,'clips':[]}
start=time.time();total=sum(c[2]*8 for c in clips);done=0
try:
 for source,tag,count in clips:
  action=bpy.data.actions[source];first,last=map(float,action.frame_range);duration=(last-first)/30
  clip={'action':source,'tag':tag,'poses_per_direction':count,'duration':duration,'directions':[]}
  for index,direction in enumerate(directions):
   angle=index*math.pi/4
   desired=right*math.cos(angle)+Vector((-math.sin(az),math.cos(az),0))*math.sin(angle)/math.sin(elevation)
   yaw=math.atan2(desired.y,desired.x)+math.pi/2;pivot.rotation_euler.z=yaw
   dest=OUT/tag/direction;dest.mkdir(parents=True,exist_ok=True)
   helpers['choose_action'](rig,action)
   for i in range(count):
    frame=first+(last-first)*i/count
    scene.frame_set(math.floor(frame),subframe=frame-math.floor(frame));bpy.context.view_layer.update()
    path=dest/f'{tag}_{direction}_{i+1:04d}.png'
    if not path.exists():scene.render.filepath=str(path);bpy.ops.render.render(write_still=True)
    done+=1
    if done%8==0:
     progress={'done':done,'total':total,'clip':tag,'direction':direction,'seconds':round(time.time()-start,1)}
     (TASK/'progress.json').write_text(json.dumps(progress),encoding='utf-8')
     print('[WALK8]',json.dumps(progress),flush=True)
   clip['directions'].append({'name':direction,'yaw':math.degrees(yaw),'frames':count})
  report['clips'].append(clip)
  (TASK/'render_report.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
 report['seconds']=round(time.time()-start,1);report['total_frames']=done
 (TASK/'render_report.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
 (TASK/'render_result.txt').write_text(f'PASS {done} genuine 3D frames rendered, eight views for normal/Q/R movement and idle',encoding='utf-8')
except Exception:
 (TASK/'render_result.txt').write_text('FAIL '+traceback.format_exc(),encoding='utf-8')
 raise
