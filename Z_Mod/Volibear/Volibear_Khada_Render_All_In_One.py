# -*- coding: utf-8 -*-
"""
VOLIBEAR PRESTIGE DUALITY DRAGON - BLENDER ONE-FILE RENDERER
==========================================================
Blender 4.2+ (tested for Python syntax; runtime requires Blender).

HOW TO USE:
  1. Put this .py next to prestige_duality_dragon_volibear.glb.
  2. Blender -> Scripting -> Open this .py -> Run Script.
  3. If the GLB cannot be found automatically, select it in Blender's file picker.
  4. Wait for completion, then open 'Volibear_Real3D_Export' next to the GLB.

Alternative (Windows terminal):
  blender -b -t 0 --python Volibear_Khada_Render_All_In_One.py -- "C:\\path\\to\\prestige_duality_dragon_volibear.glb"

What this script exports:
  frames/<animation>/*.png      real 3D animation samples, transparent 512px RGBA
  atlases/go_volibear_<name>.png  trimmed and packed sprite sheets
  atlases/go_volibear_<name>.lua  Kingdom Rush FL atlas descriptors
  volibear_animation_map.lua     precomputed game-tick frame sequences
  render_report.json            source and sampling metadata

This renders the 3D *character*. Spell particles/VFX absent from the GLB
cannot be recovered automatically. Test the output before installing a mod.
"""

import bpy
import math
import json
import re
import sys
from pathlib import Path

from mathutils import Vector

try:
    import numpy as np   # Provided with official Blender Python builds.
except ImportError as exc:
    raise RuntimeError('Blender Python needs NumPy (normally bundled).') from exc

# ========================= EDITABLE SETTINGS ================================
GLB_FILE = ""                 # Blank: find matching GLB near this script / Downloads.
OUTPUT_FOLDER = ""            # Blank: <GLB folder>/Volibear_Real3D_Export
FRAME_SIZE = 512              # Change to 768/1024 for more detail; slower render.
GAME_FPS = 30                 # KR FL uses 30 timeline ticks per second.
RENDER_SAMPLES_PER_SECOND = 16 # Unique poses per second; gaps repeated in Lua.
ATLAS_MAX_SIDE = 4096
TRANSPARENT_BACKGROUND = True
VIEW_AZIMUTH = 36             # Degrees: rotate around the subject.
VIEW_ELEVATION = 30           # Degrees above horizontal.
CAMERA_PADDING = 1.5          # Increase to avoid head/arm clipping.
SKIP_EXISTING_PNG = False     # True to resume an interrupted render.

# Exact action names verified inside prestige_duality_dragon_volibear.glb.
# Export names are stable and designed for subsequent integration in KR FL.
# max_poses caps the unique renders; native duration is still preserved by
# repeated frame IDs in volibear_animation_map.lua.
ANIMATIONS = [
    ("Idle_Base", "idle", 36),
    ("Run_Base", "run", 24),
    ("Attack1", "attack1", 24),
    ("Attack2", "attack2", 24),
    ("Spell1_Intro", "q_intro", 20),
    ("Spell1_Attack", "q_attack", 14),
    ("Spell1_Outro", "q_outro", 25),
    ("Volibear_Spell2_Slash.anm", "w_slash", 24),
    ("Channel_Wndup", "e_windup", 12),
    ("Channel", "e_channel", 24),
    ("Spell3_Idle", "e_idle", 24),
    ("Spell4_Cast", "r_cast", 4),
    ("Spell4_Ground_Pound", "r_impact", 24),
    ("Spell4_Ground_Pound_Leadout", "r_outro", 12),
    ("Spell4_Run", "r_run", 22),
    ("Death", "death", 32),
    ("Respawn", "respawn", 26),
    ("KnockUp", "knockup", 18),
]

# =============================== HELPERS ====================================

def log(message):
    print('[VOLIBEAR] ' + str(message), flush=True)


def slug(s):
    return re.sub(r'[^a-z0-9_]+', '_', s.lower()).strip('_')


def find_glb():
    if GLB_FILE.strip():
        return Path(GLB_FILE).expanduser().resolve()

    # Blender Text Editor can expose the executing file path via __file__.
    paths = []
    try:
        paths.append(Path(__file__).resolve().parent)
    except Exception:
        pass
    paths.extend([Path.cwd(), Path.home() / 'Downloads', Path.home() / 'Desktop'])

    args = sys.argv[sys.argv.index('--') + 1:] if '--' in sys.argv else []
    if args:
        path = Path(args[0]).expanduser()
        if path.is_file():
            return path.resolve()

    names = ['prestige_duality_dragon_volibear.glb',
             'Prestige Duality Dragon Volibear.glb']
    for folder in paths:
        if not folder.exists():
            continue
        for name in names:
            candidate = folder / name
            if candidate.is_file():
                return candidate.resolve()
    return None


def action_by_name(name, rig):
    exact = bpy.data.actions.get(name)
    candidates = [exact] if exact else []
    candidates.extend(a for a in bpy.data.actions
                      if a != exact and (a.name == name or a.name.startswith(name + '.')))
    if not candidates:
        candidates = [a for a in bpy.data.actions if a.name.casefold() == name.casefold()]
    for action in candidates:
        if action is None:
            continue
        # On Blender 4.4+, a slot is necessary; restrict to compatible slots.
        slots = getattr(action, 'slots', [])
        if not slots or any(getattr(slot, 'target_id_type', 'OBJECT') in
                            ('OBJECT', 'UNSPECIFIED') for slot in slots):
            return action
    return candidates[0] if candidates else None


def choose_action(rig, action):
    anim = rig.animation_data_create()
    for track in anim.nla_tracks:
        track.mute = True
    anim.action = action
    if hasattr(anim, 'action_suitable_slots'):
        suitable = list(anim.action_suitable_slots)
        if suitable:
            try:
                anim.action_slot = suitable[0]
            except (AttributeError, ValueError, TypeError) as exc:
                log('Warning: could not explicitly assign action slot: ' + str(exc))
        elif len(getattr(action, 'slots', [])):
            log('WARNING: action assigned without a matching Blender slot: ' + action.name)


def next_pow2(v):
    return 1 << max(0, int(v - 1).bit_length())


def setup_clean_scene():
    # Creates a NEW scene. Existing scenes/objects are not deleted.
    fresh = bpy.data.scenes.new('VOLIBEAR_3D_SPRITE_RENDER')
    if bpy.context.window:
        bpy.context.window.scene = fresh
    else:
        # Background Blender normally has a scene/window context; if not,
        # a context override is not available for all import operators.
        log('WARNING: no active Blender window; using the available scene context.')
        fresh = bpy.context.scene
    fresh.render.fps = GAME_FPS
    return fresh


def setup_render(scene):
    engines = ('BLENDER_EEVEE', 'BLENDER_EEVEE_NEXT', 'BLENDER_WORKBENCH')
    for engine in engines:
        try:
            scene.render.engine = engine
            log('Render engine: ' + engine)
            break
        except (TypeError, ValueError):
            continue
    else:
        raise RuntimeError('No compatible Blender render engine found.')
    scene.render.resolution_x = FRAME_SIZE
    scene.render.resolution_y = FRAME_SIZE
    scene.render.resolution_percentage = 100
    scene.render.film_transparent = TRANSPARENT_BACKGROUND
    scene.render.image_settings.file_format = 'PNG'
    scene.render.image_settings.color_mode = 'RGBA'
    scene.render.image_settings.color_depth = '8'
    scene.render.film_transparent = True
    try:
        scene.render.image_settings.compression = 15
    except Exception:
        pass
    try:
        scene.render.filter_size = 1.25
    except Exception:
        pass
    for setting, val in [('view_transform', 'Standard'), ('look', 'Medium High Contrast')]:
        try:
            setattr(scene.view_settings, setting, val)
        except Exception:
            pass
    try:
        scene.render.image_settings.color_mode = 'RGBA'
        scene.render.image_settings.file_format = 'PNG'
    except Exception:
        pass
    if getattr(scene, 'eevee', None) is not None:
        try:
            scene.eevee.taa_render_samples = 32  # Older Blender 4.x only.
        except Exception:
            pass
    scene.world = bpy.data.worlds.new('VOLI_WORLD')
    scene.world.use_nodes = True
    bg = scene.world.node_tree.nodes.get('Background')
    if bg:
        bg.inputs['Strength'].default_value = 0.75
        bg.inputs['Color'].default_value = (0.48, 0.48, 0.50, 1.0)


def scene_meshes(scene):
    return [obj for obj in scene.objects if obj.type == 'MESH']


def object_bounds(meshes):
    points = [obj.matrix_world @ Vector(corner) for obj in meshes for corner in obj.bound_box]
    if not points:
        raise RuntimeError('No skinned mesh found in imported GLB.')
    low = Vector(tuple(min(v[i] for v in points) for i in range(3)))
    high = Vector(tuple(max(v[i] for v in points) for i in range(3)))
    return low, high


def setup_camera_and_light(scene):
    meshes = scene_meshes(scene)
    bpy.context.view_layer.update()
    low, high = object_bounds(meshes)
    mid = (low + high) * 0.5
    radius = (high - low).length * 1.7
    az = math.radians(VIEW_AZIMUTH)
    el = math.radians(VIEW_ELEVATION)
    view_dir = Vector((math.sin(az)*math.cos(el), -math.cos(az)*math.cos(el), math.sin(el)))
    camera_data = bpy.data.cameras.new('VOLI_CAMERA_DATA')
    camera = bpy.data.objects.new('VOLI_CAMERA', camera_data)
    scene.collection.objects.link(camera)
    camera.location = mid + view_dir * max(5, radius)
    camera.rotation_euler = (mid - camera.location).to_track_quat('-Z', 'Y').to_euler()
    camera.data.type = 'ORTHO'
    # Perspective/isometric projection can extend bbox in both screen axes.
    # Use a conservative fixed framing for *all* actions, avoiding sprite jitter.
    extent = (high - low)
    camera.data.ortho_scale = max(extent.length, extent.z * 1.1) * CAMERA_PADDING
    scene.camera = camera
    light_settings = [
        ('VOLI_KEY',   (mid.x + 4, mid.y - 5, mid.z + 6), 1300, 5.0),
        ('VOLI_FILL',  (mid.x - 4, mid.y - 1, mid.z + 3),  650, 5.0),
        ('VOLI_RIM',   (mid.x - 3, mid.y + 4, mid.z + 5), 1100, 4.0),
    ]
    for name, pos, power, size in light_settings:
        ld = bpy.data.lights.new(name, 'AREA')
        ld.energy = power
        ld.shape = 'DISK'
        ld.size = size
        obj = bpy.data.objects.new(name, ld)
        scene.collection.objects.link(obj)
        obj.location = pos
        obj.rotation_euler = (mid - obj.location).to_track_quat('-Z','Y').to_euler()
    log('Camera center = {} | scale = {:.2f}'.format(tuple(round(x,3) for x in mid), camera.data.ortho_scale))


def assign_and_frame(rig, action, scene, frame):
    choose_action(rig, action)
    integer = math.floor(frame)
    scene.frame_set(integer, subframe=frame - integer)
    bpy.context.view_layer.update()


def choose_samples(action, max_unique):
    start, end = float(action.frame_range[0]), float(action.frame_range[1])
    duration = max(1.0 / GAME_FPS, (end - start) / GAME_FPS)
    count = min(max_unique, max(2, int(math.ceil(duration * RENDER_SAMPLES_PER_SECOND))))
    if end - start < 1.0:
        count = 1  # Spell4_Cast in this GLB is almost instantaneous.
    samples = [start + (end - start) * i / max(1, count-1) for i in range(count)]
    # Stretch the unique pose sequence to native motion duration when playing
    # through animation_db at GAME_FPS (which doesn't read A.db[..].fps).
    game_length = max(1, int(round(duration * GAME_FPS)))
    playback = [1 + int(round((count-1) * j / max(1, game_length-1))) for j in range(game_length)]
    return samples, playback, duration


def read_rgba_png(filepath):
    image = bpy.data.images.load(str(filepath), check_existing=False)
    try:
        width, height = image.size
        pixels = np.empty(width * height * 4, dtype=np.float32)
        image.pixels.foreach_get(pixels)
        # Blender pixel array is bottom-up; convert to top-down for atlas rows.
        return pixels.reshape(height, width, 4)[::-1].copy()
    finally:
        bpy.data.images.remove(image)


def rgba_bbox(arr):
    alpha_mask = arr[:,:,3] > (2 / 255)
    ys, xs = np.nonzero(alpha_mask)
    if len(xs) == 0:
        return 0, 0, 1, 1
    padding = 3
    return (max(0, int(xs.min()) - padding), max(0, int(ys.min()) - padding),
            min(arr.shape[1], int(xs.max())+1+padding),
            min(arr.shape[0], int(ys.max())+1+padding))


def pack_rectangles(sizes, width):
    placements = []
    x, y, row_height = 0, 0, 0
    for w, h in sizes:
        if w > width:
            return None, None
        if x > 0 and x + w > width:
            y += row_height
            x, row_height = 0, 0
        placements.append((x,y))
        x += w
        row_height = max(row_height,h)
    return placements, y+row_height


def save_image(data_topdown, path):
    height, width = data_topdown.shape[:2]
    image = bpy.data.images.new('TEMP_VOLI_ATLAS', width=width, height=height,
                                alpha=True, float_buffer=False)
    try:
        # Blender image.pixels expect bottom row first.
        image.pixels.foreach_set(np.ascontiguousarray(data_topdown[::-1]).ravel())
        image.file_format = 'PNG'
        image.filepath_raw = str(path)
        image.save()
    finally:
        bpy.data.images.remove(image)


def build_atlas(tag, pngs, folder):
    cropped, sizes, bounds = [], [], []
    for png in pngs:
        rgba = read_rgba_png(png)
        left, top, right, bottom = rgba_bbox(rgba)
        crop = rgba[top:bottom, left:right].copy()
        cropped.append(crop)
        sizes.append((crop.shape[1]+2, crop.shape[0]+2))  # 1px per edge gap.
        bounds.append((left, top, right, bottom, rgba.shape[1], rgba.shape[0]))
    choices = []
    for trial_w in [512,1024,2048,4096,8192]:
        if trial_w > ATLAS_MAX_SIDE:
            continue
        placements, used_height = pack_rectangles(sizes, trial_w)
        if placements is not None:
            height = next_pow2(used_height)
            if height <= ATLAS_MAX_SIDE:
                choices.append((trial_w * height, trial_w, height, placements))
    if not choices:
        raise RuntimeError('Atlas too large for ' + tag + '. Reduce FRAME_SIZE or caps.')
    _, width, height, placements = min(choices, key=lambda t:t[0])
    image = np.zeros((height,width,4), dtype=np.float32)
    atlas_key = 'go_volibear_' + tag
    atlas_path = folder / (atlas_key + '.png')
    desc_path = folder / (atlas_key + '.lua')
    lines = ['-- True 3D bone animations from Khada GLB; trimmed sprites.\nreturn {']
    for frame, box, loc in zip(cropped, bounds, placements):
        x,y = loc
        x+=1; y+=1
        h,w = frame.shape[:2]
        image[y:y+h,x:x+w] = frame
        l,t,r,b,source_w,source_h = box
        name = 'volibear_' + tag + '_{:04d}'.format(len(lines)-1)
        lines.append(('  {n}={{a_name="{an}.png",size={{{sw},{sh}}},'
                      'trim={{{l},{t},{rr},{bb}}},a_size={{{aw},{ah}}},'
                      'f_quad={{{x},{y},{w},{h}}},alias={{}}}},').format(
                      n=name,an=atlas_key,sw=source_w,sh=source_h,
                      l=l,t=t,rr=source_w-r,bb=source_h-b,
                      aw=width,ah=height,x=x,y=y,w=w,h=h))
    lines.append('}\n')
    save_image(image, atlas_path)
    desc_path.write_text('\n'.join(lines), encoding='utf-8')
    return str(atlas_path), width, height


def render_all(glb_path):
    if not glb_path.exists():
        raise FileNotFoundError('GLB was not found: ' + str(glb_path))
    out = (Path(OUTPUT_FOLDER).expanduser() if OUTPUT_FOLDER else
           glb_path.parent / 'Volibear_Real3D_Export').resolve()
    out.mkdir(parents=True, exist_ok=True)
    frames_dir = out / 'frames'
    atlases_dir = out / 'atlases'
    atlases_dir.mkdir(exist_ok=True)
    scene = setup_clean_scene()
    setup_render(scene)  # FPS must be set before glTF import.
    log('Importing ' + str(glb_path))
    actions_before = set(bpy.data.actions)
    bpy.ops.import_scene.gltf(filepath=str(glb_path))
    imported_actions = [a for a in bpy.data.actions if a not in actions_before]
    rigs = [o for o in scene.objects if o.type == 'ARMATURE']
    if not rigs:
        raise RuntimeError('No armature/skeleton imported. Check the GLB file.')
    rig = max(rigs, key=lambda o:len(o.data.bones))
    log('Imported rig: {} / {} bones / {} total actions'.format(
        rig.name, len(rig.data.bones), len(imported_actions)))
    if len(imported_actions) < 5:
        log('WARNING: few actions detected; make sure GLB contains animation data.')

    # Suppress NLA and stale object actions so each clip is isolated.
    for obj in scene.objects:
        ad = obj.animation_data
        if ad is not None:
            for track in ad.nla_tracks:
                track.mute = True
            if obj != rig:
                ad.action = None

    idle = action_by_name('Idle_Base', rig)
    if idle:
        assign_and_frame(rig, idle, scene, idle.frame_range[0])
    setup_camera_and_light(scene)
    report = {'input_file':glb_path.name, 'size':glb_path.stat().st_size,
              'fps':GAME_FPS, 'render_resolution':[FRAME_SIZE,FRAME_SIZE],
              'source':'original GLB skin/skeleton/animations',
              'notice':'Game particle and spell effects not embedded in GLB are not rendered.',
              'animation_count_in_blender':len(imported_actions), 'animations': []}
    map_lines = [
        '-- Lua generated from original model samples; call M.register(hero_prefix, A).',
        '-- Frames include repeats to preserve GLB timing with KR FL animation_db FPS.',
        'local M = {}',
        'function M.register(hero_prefix, A)',
    ]
    for source_action, tag, cap in ANIMATIONS:
        action = action_by_name(source_action, rig)
        if action is None:
            log('SKIP missing animation: ' + source_action)
            continue
        dest = frames_dir / tag
        dest.mkdir(parents=True, exist_ok=True)
        samples, playback, duration = choose_samples(action, cap)
        log('Render {} -> {} | {} unique frames | {:.2f}s'.format(
            source_action,tag,len(samples),duration))
        pngs=[]
        choose_action(rig, action)
        for i, frame in enumerate(samples,1):
            target = dest / ('{}_{:04d}.png'.format(tag,i))
            pngs.append(target)
            if SKIP_EXISTING_PNG and target.exists():
                continue
            # Critical: subframe supports original GLB keyframe interpolation.
            base = math.floor(frame)
            scene.frame_set(base, subframe=frame-base)
            bpy.context.view_layer.update()
            scene.render.filepath = str(target)
            bpy.ops.render.render(write_still=True)
        atlas_file, width, height = build_atlas(tag,pngs,atlases_dir)
        lua_frame_list = ','.join(map(str,playback))
        map_lines.append('  A.db[hero_prefix .. "_{}"] = {{prefix="volibear_{}",frames={{{}}}}}'.format(
            tag,tag,lua_frame_list))
        report['animations'].append({'action':source_action,'tag':tag,'duration_s':round(duration,3),
             'unique_frames':len(samples),'playback_frames':len(playback),
             'atlas':Path(atlas_file).name, 'atlas_size':[width,height]})
    map_lines.extend(['end','return M',''])
    (out/'volibear_animation_map.lua').write_text('\n'.join(map_lines),encoding='utf-8')
    (out/'render_report.json').write_text(json.dumps(report,indent=2,ensure_ascii=False),encoding='utf-8')
    (out/'README_output.txt').write_text(
        'ORIGINAL 3D VOLIBEAR ANIMATION RENDER\n'
        '====================================\n'
        'frames/ = individual transparent PNG frames (fixed camera and canvas).\n'
        'atlases/ = PNG sprite sheets + matching .lua atlas metadata for KR FL.\n'
        'volibear_animation_map.lua = playback timing, including repeated frames.\n'
        'Important: these are character-only model frames, not full League VFX.\n'
        'The hero code still must register all go_volibear_* texture groups.\n'
        'Do not paste unintegrated files into the game and expect instant compatibility.\n',
        encoding='utf-8')
    log('DONE. Rendered {} animation groups.'.format(len(report['animations'])))
    log('OUTPUT: ' + str(out))
    return out


# Launch automatically when the file is next to the GLB; otherwise show picker.
class VOLI_OT_select_glb(bpy.types.Operator):
    bl_idname = 'volibear.select_glb_and_render'
    bl_label = 'Select Volibear GLB and Render PNG Sprites'

    filepath: bpy.props.StringProperty(name='Volibear GLB', subtype='FILE_PATH')
    filter_glob: bpy.props.StringProperty(default='*.glb', options={'HIDDEN'})

    def execute(self, context):
        try:
            render_all(Path(self.filepath).expanduser().resolve())
            self.report({'INFO'}, 'Volibear render completed; see export folder next to GLB.')
            return {'FINISHED'}
        except Exception as exc:
            import traceback
            traceback.print_exc()
            self.report({'ERROR'}, str(exc))
            return {'CANCELLED'}

    def invoke(self, context, event):
        context.window_manager.fileselect_add(self)
        return {'RUNNING_MODAL'}


def main():
    previous = getattr(bpy.types, 'VOLI_OT_select_glb', None)
    if previous:
        try:
            bpy.utils.unregister_class(previous)
        except Exception:
            pass
    bpy.utils.register_class(VOLI_OT_select_glb)
    glb = find_glb()
    if glb:
        render_all(glb)
    elif bpy.context.window:
        log('Model not found automatically. Blender will open a GLB file picker.')
        bpy.ops.volibear.select_glb_and_render('INVOKE_DEFAULT')
    else:
        raise RuntimeError('No GLB supplied. Pass the .glb path after --, or put .py beside GLB.')


if __name__ == '__main__':
    main()
