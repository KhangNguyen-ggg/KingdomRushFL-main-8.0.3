import fs from 'node:fs';
const root='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const pack=root+'/Z_Mod/Volibear/FL803_Volibear_CanChan_HuongDi_LoadNhanh_20261024';
for(const file of ['all/allied_volibear.lua','all/director.lua','all/sound_db.lua','lib/klove/image_db.lua','all-desktop/screen_map.lua'])fs.copyFileSync(pack+'/BACKUP_TRUOC_VA/'+file,pack+'/CAP_NHAT/'+file);
function edit(file,fn){const path=pack+'/CAP_NHAT/'+file;const src=fs.readFileSync(path,'utf8').replaceAll('\r\n','\n');fs.writeFileSync(path,fn(src));}
function replace(s,a,b){a=a.replaceAll('\r\n','\n');b=b.replaceAll('\r\n','\n');if(!s.includes(a))throw Error('Missing '+a);return s.replaceAll(a,b);}
edit('all/allied_volibear.lua',s=>{
 s=replace(s,'V.v(0.37,0.37)','V.v(-0.68,0.68)');
 s=replace(s,'V.v(0.4625,0.4625)','V.v(-0.85,0.85)');
 s=replace(s,'sp.anchor=V.v(0.5,0.13)','sp.anchor=V.v(266/512,181/512)');
 s=replace(s,'this.melee.range=58','this.melee.range=107');
 s=replace(s,'t.melee.range=58','t.melee.range=107');
 s=replace(s,'this.melee.range=71','this.melee.range=131');
 s=replace(s,'distance<=75','distance<=138');
 s=replace(s,'(s.ult_end and 88 or 81)','(s.ult_end and 162 or 149)');
 s=replace(s,'t.health_bar.offset=V.v(0,67)','t.health_bar.offset=V.v(0,159)');
 s=replace(s,'V.v(0,33),V.v(0,33)','V.v(0,75),V.v(0,75)');
 s=replace(s,'pos=V.v(-28,0),size=V.v(56,65)','pos=V.v(-40,0),size=V.v(80,150)');
 s=replace(s,'t.soldier.melee_slot_offset=V.v(28,0)','t.soldier.melee_slot_offset=V.v(51,0)');
 s=replace(s,' local sp=E:clone_c("sprite");',' -- Export faces left; mirror the artwork while keeping engine movement/attack flip flags. Feet are at pixel (266,331).\n local sp=E:clone_c("sprite");');
 return s;
});
edit('all-desktop/screen_map.lua',s=>s.includes('\t"ui_volibear_lol20",')?s:replace(s,'screen_map.required_textures = {','screen_map.required_textures = {\n\t"ui_volibear_lol20",'));
for(const file of ['lib/klove/image_db.lua','all/sound_db.lua']) edit(file,s=>{
 s=replace(s,'queue_unload_groups_per_frame = 1','queue_unload_groups_per_frame = 8');
 s=replace(s,'local batch_count = math.min(#self.unload_queue, self.queue_unload_groups_per_frame or 1)','local batch_count = math.min(#self.unload_queue, self.queue_unload_groups_per_frame or 8)\n\tlocal deadline = love.timer.getTime() + 0.004');
 s=replace(s,'self.unload_queue_done = self.unload_queue_done + 1','self.unload_queue_done = self.unload_queue_done + 1\n\t\tif love.timer.getTime() >= deadline then break end');
 return s;
});
edit('lib/klove/image_db.lua',s=>{
 s=replace(s,'local batch_count = math.min(#self.load_queue, self.queue_preload_groups_per_frame or #self.load_queue)',`local batch_count = math.min(#self.load_queue, self.queue_preload_groups_per_frame or #self.load_queue)
\t\t-- Different atlas scales can share the same PNG; decode/upload it once per queue.
\t\tlocal queued_files = {}
\t\tfor _, image in ipairs(self.image_name_queue) do queued_files[image[2] .. "/" .. image[1]] = true end`);
 s=replace(s,'for n in pairs(image_names) do\n\t\t\t\t\ttable.insert',`for n in pairs(image_names) do
\t\t\t\t\tlocal file = path .. "/" .. n
\t\t\t\t\tif not queued_files[file] then
\t\t\t\t\tqueued_files[file] = true
\t\t\t\t\ttable.insert`);
 s=replace(s,'self.queue_load_total_images = self.queue_load_total_images + 1\n\t\t\t\tend','self.queue_load_total_images = self.queue_load_total_images + 1\n\t\t\t\t\tend\n\t\t\t\tend');
 s=s.replace(/(\t{5}if not queued_files\[file\] then\n)([\s\S]*?)(\n\t{5}end)/,(_,a,b,c)=>a+b.split('\n').map(line=>'\t'+line).join('\n')+c);
 const start=s.indexOf('\tfor image_name, _ in pairs(remove_images) do');
 const stop=s.indexOf('\n\tlog.debug(" removed #frames:',start);
 if(start<0||stop<0)throw Error('Unload section');
 s=s.slice(0,start)+`\tlocal used_images = {}
\tfor _, frame in pairs(self.db_atlas) do used_images[frame.atlas] = true end
\tfor _, stack in pairs(self.db_atlas_shadow) do
\t\tfor _, frame in ipairs(stack) do used_images[frame.atlas] = true end
\tend
\tfor image_name in pairs(remove_images) do
\t\tif not used_images[image_name] then
\t\t\tself.db_images[image_name] = nil
\t\t\tremoved_images_count = removed_images_count + 1
\t\tend
\tend
`+s.slice(stop);
 return s;
});
edit('all/director.lua',s=>{
 s=replace(s,'if game and game.store and game.store.level_idx then\r\n\t\t\tlevel_idx = game.store.level_idx\r\n\t\telseif self.next_item_args then\r\n\t\t\tlevel_idx = self.next_item_args.level_idx\r\n\t\tend','if self.next_item_args and self.next_item_args.level_idx then\n\t\t\tlevel_idx = self.next_item_args.level_idx\n\t\telseif game and game.store then\n\t\t\tlevel_idx = game.store.level_idx\n\t\tend');
 s=replace(s,'self.active_item = loading\r\n\tend','self.active_item = loading\n\t\t-- Present the loading screen before synchronous atlas metadata/template work.\n\t\tif G.isActive() then\n\t\t\tG.push("all")\n\t\t\tG.setCanvas()\n\t\t\tG.origin()\n\t\t\tG.setScissor()\n\t\t\tG.clear()\n\t\t\tloading:draw()\n\t\t\tG.present()\n\t\t\tG.pop()\n\t\tend\n\tend');
 return s;
});
console.log('Staged 5 files; live unchanged');
