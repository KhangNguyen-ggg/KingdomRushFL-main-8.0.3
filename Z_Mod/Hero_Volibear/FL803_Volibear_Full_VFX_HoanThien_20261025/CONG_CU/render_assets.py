"""Project original bones and render original VFX meshes; never saves the source scene."""
import bpy, math, json, runpy, traceback
from pathlib import Path
from mathutils import Vector, Matrix
from bpy_extras.object_utils import world_to_camera_view
ROOT=Path('D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3')
TASK=Path('D:/CodexTemp/KRFL_Voli_FullVFX_20261025')
PACK=ROOT/'Z_Mod/Volibear/FL803_Volibear_Full_VFX_HoanThien_20261025'
PART=ROOT/'Z_Mod/Volibear/Volibear_Original_VFX_Download_1_Click/Volibear_Skin09_Original/particles'
helpers=runpy.run_path(str(ROOT/'Z_Mod/Volibear/Volibear_Khada_Render_All_In_One.py'),run_name='helpers')
scene=bpy.context.scene;rig=next(o for o in scene.objects if o.type=='ARMATURE');cam=scene.camera
bones=['L_Hand','R_Hand','Head','L_Buffbone_Cstm_ShoulderArmor_Loc','R_Buffbone_Cstm_ShoulderArmor_Loc']
anchors={}
def project(key,combat):
 values=[]
 for name in bones:
  pt=world_to_camera_view(scene,cam,rig.matrix_world@rig.pose.bones[name].head)
  values.extend([round((266-pt.x*512)*.68,1),round((331-(1-pt.y)*512)*.68,1)] if combat else [round(pt.x*256-128,1),round(222-(1-pt.y)*256,1)])
 anchors[key]=values
try:
 for source,tag,cap in helpers['ANIMATIONS']:
  action=bpy.data.actions[source];samples,_,_=helpers['choose_samples'](action,cap)
  for i,frame in enumerate(samples,1):
   helpers['assign_and_frame'](rig,action,scene,frame)
   project(f'volibear_{tag}_{i:04d}',True)
 meshes=[o for o in scene.objects if o.type=='MESH']
 pivot=bpy.data.objects.new('VFX_ANCHOR_DIRECTION',None);scene.collection.objects.link(pivot)
 for obj in [rig]+meshes:obj.parent=pivot
 cam.data.ortho_scale*=.5/.68
 right=cam.rotation_euler.to_matrix()@Vector((1,0,0));up=cam.rotation_euler.to_matrix()@Vector((0,1,0))
 pt=world_to_camera_view(scene,cam,Vector((0,0,0)))
 cam.location+=right*(pt.x-.5)*cam.data.ortho_scale+up*(222/256-(1-pt.y))*cam.data.ortho_scale
 for source,tag,count in [('Run_Base','walk8',24),('Volibear_spell1_run.anm','qrun8',20),('Spell4_Run','rrun8',24),('Idle_Base','idle8',24)]:
  action=bpy.data.actions[source];first,last=map(float,action.frame_range)
  for d,direction in enumerate(['e','ne','n','nw','w','sw','s','se']):
   a=d*math.pi/4;desired=right*math.cos(a)+Vector((-math.sin(math.radians(36)),math.cos(math.radians(36)),0))*math.sin(a)/.5
   pivot.rotation_euler.z=math.atan2(desired.y,desired.x)+math.pi/2
   for i in range(count):
    helpers['assign_and_frame'](rig,action,scene,first+(last-first)*i/count)
    project(f'volibear_{tag}_{direction}_{i+1:04d}',False)
 out=['-- Original GLB bone projections, matched to the existing combat and eight-view exports.','return {']
 for key,values in anchors.items():out.append(' '+key+'={'+','.join(str(x) for x in values)+'},')
 out.append('}');(PACK/'CAP_NHAT/all/volibear_vfx_anchors.lua').write_text('\n'.join(out),encoding='utf-8')
 # Separate transparent scene for the source meshes. OBJ is LoL Y-up.
 scene=bpy.data.scenes.new('VOLI_VFX_SOURCE_MESHES');bpy.context.window.scene=scene
 scene.render.engine='BLENDER_EEVEE';scene.render.resolution_x=scene.render.resolution_y=192;scene.render.resolution_percentage=100
 scene.render.film_transparent=True;scene.render.image_settings.color_mode='RGBA';scene.render.image_settings.file_format='PNG'
 scene.view_settings.view_transform='Standard';scene.render.image_settings.compression=30
 world=bpy.data.worlds.new('VFX_WORLD');world.use_nodes=True;world.node_tree.nodes['Background'].inputs['Strength'].default_value=.4;scene.world=world
 data=bpy.data.cameras.new('VFX_CAMERA');cam=bpy.data.objects.new('VFX_CAMERA',data);scene.collection.objects.link(cam);scene.camera=cam;data.type='ORTHO'
 cam.location=(3,-5,3.4);cam.rotation_euler=(-cam.location).to_track_quat('-Z','Y').to_euler()
 ld=bpy.data.lights.new('VFX_KEY','AREA');lo=bpy.data.objects.new('VFX_KEY',ld);scene.collection.objects.link(lo);lo.location=(1,-3,5);ld.energy=500;ld.shape='DISK';ld.size=4
 (TASK/'mesh_frames').mkdir(exist_ok=True)
 for tag,file,tex in [('bear','volibear_skin9_w2_bearhead01/lambert1.obj',TASK/'volibear_skin09_tx_cm.png'),('dragon','volibear_skin09_dragonmodelanim01/Dragon.obj',PART/'volibear_skin09_dragonbody.png')]:
  before=set(scene.objects);bpy.ops.wm.obj_import(filepath=str(PART/file),forward_axis='NEGATIVE_Z',up_axis='Y')
  imported=[o for o in scene.objects if o not in before and o.type=='MESH']
  for o in imported:
   transform=o.matrix_world.copy()
   for v in o.data.vertices:v.co=transform@v.co
   o.matrix_world=Matrix.Identity(4)
  points=[o.matrix_world@v.co for o in imported for v in o.data.vertices];low=Vector([min(p[i] for p in points) for i in range(3)]);high=Vector([max(p[i] for p in points) for i in range(3)])
  center=(low+high)/2;extent=max(high-low)
  meshpivot=bpy.data.objects.new('SOURCE_'+tag,None);scene.collection.objects.link(meshpivot)
  material=bpy.data.materials.new('ORIGINAL_'+tag);material.use_nodes=True;nt=material.node_tree;nt.nodes.clear()
  image=nt.nodes.new('ShaderNodeTexImage');image.image=bpy.data.images.load(str(tex))
  shader=nt.nodes.new('ShaderNodeBsdfPrincipled');shader.inputs['Roughness'].default_value=.48
  output=nt.nodes.new('ShaderNodeOutputMaterial');nt.links.new(image.outputs['Color'],shader.inputs['Base Color']);nt.links.new(shader.outputs[0],output.inputs['Surface'])
  if tag=='bear':
   mask=nt.nodes.new('ShaderNodeTexImage');mask.image=bpy.data.images.load(str(PART/'volibear_skin09_tx_mask01.png'))
   nt.links.new(mask.outputs['Color'],shader.inputs['Emission Color']);shader.inputs['Emission Strength'].default_value=2.5
  else:
   shader.inputs['Base Color'].default_value=(.5,.2,.07,1);shader.inputs['Emission Color'].default_value=(1,.55,.12,1);shader.inputs['Emission Strength'].default_value=.4
  for o in imported:
   for v in o.data.vertices:v.co=(v.co-center)*2/extent
   if tag=='dragon':
    # shortcut: OBJ has no rig; use bent views until the original VFX skeleton/animation is imported.
    axis=max(range(3),key=lambda i:high[i]-low[i]);cross=[i for i in range(3) if i!=axis]
    for v in o.data.vertices:
     p=v.co.copy();angle=(p[axis]+1)*math.pi*.83;radius=.7+p[cross[0]]
     v.co=Vector((radius*math.cos(angle),radius*math.sin(angle),p[cross[1]]))
   o.location=(0,0,0);o.parent=meshpivot;o.data.materials.clear();o.data.materials.append(material)
   for poly in o.data.polygons:poly.use_smooth=True
  data.ortho_scale=2.6
  for i in range(8):
   meshpivot.rotation_euler.z=i*math.pi/4
   scene.render.filepath=str(TASK/'mesh_frames'/f'{tag}_{i+1:04d}.png');bpy.ops.render.render(write_still=True)
  for o in imported:o.hide_render=True
 (TASK/'render_result.txt').write_text(f'PASS {len(anchors)} bone projection frames and 16 original mesh views')
except Exception:
 (TASK/'render_result.txt').write_text('FAIL '+traceback.format_exc());raise
