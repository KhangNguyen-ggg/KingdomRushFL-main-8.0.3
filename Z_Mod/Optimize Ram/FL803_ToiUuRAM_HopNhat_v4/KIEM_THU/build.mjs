import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
const root='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3';
const task='D:/CodexTemp/KRFL_RAM_v4_20261023';
const files=['lib/klove/image_db.lua','lib/klove/font_db.lua','lib/klove/sso.lua'];
const sources=new Map();const hashes={};
for(const file of files){const b=fs.readFileSync(root+'/'+file);hashes[file]=crypto.createHash('sha256').update(b).digest('hex');sources.set(file,b.toString('utf8'));}
function replace(file,before,after){const s=sources.get(file);if(s.split(before).length!==2)throw Error('Unique replacement missing: '+file+' '+before.slice(0,70));sources.set(file,s.replace(before,after));}
const im='lib/klove/image_db.lua';
let s=sources.get(im);const start=s.indexOf('local persistent_textures = {}');const end=s.indexOf('image_db.db_images = {}',start);
if(start<0||end<start)throw Error('Missing persistent whitelist');
sources.set(im,s.slice(0,start)+s.slice(end));
const nl=s.includes('\r\n')?'\r\n':'\n';
replace(im,['\tif persistent_textures[name] and self.atlas_uses[name_scale] then','\t\tlog.debug("persistent atlas %s already loaded", name_scale)','','\t\treturn','\tend',''].join(nl)+nl,'');
replace(im,['\tif persistent_textures[name] then','\t\tlog.debug("persistent atlas %s-%.6f kept loaded", name, ref_scale)','','\t\treturn','\tend',''].join(nl)+nl,'');
replace(im,['function image_db:queue_load_atlas(ref_scale, path, name)','\tref_scale = ref_scale or 1','','\tlocal name_scale = string.format("%s-%.6f", name, ref_scale)'].join(nl),['function image_db:queue_load_atlas(ref_scale, path, name)','\tref_scale = ref_scale or 1'].join(nl));
replace(im,'local queue_max_threads = tonumber(_MAX_THREADS) or calculate_image_thread_count()','-- Bound simultaneous decoded pixel buffers while uploading large atlases.'+nl+'\tlocal queue_max_threads = math.min(2, tonumber(_MAX_THREADS) or calculate_image_thread_count())');
replace(im,'\t\t\t\t\tcollectgarbage("step", math.ceil(w * h / 256))',[
'\t\t\t\t\tif w * h >= 4194304 then',
'\t\t\t\t\t\tcollectgarbage()',
'\t\t\t\t\telse',
'\t\t\t\t\t\tcollectgarbage("step", math.ceil(w * h / 256))',
'\t\t\t\t\tend'].join(nl));
const font='lib/klove/font_db.lua';const fnl=sources.get(font).includes('\r\n')?'\r\n':'\n';
replace(font,['\tif real_size > 6 then','\t\treal_size = math.floor(real_size + 0.5)','\tend'].join(fnl),'\treal_size = math.max(1, math.floor(real_size + 0.5))');
const sso='lib/klove/sso.lua';const snl=sources.get(sso).includes('\r\n')?'\r\n':'\n';
replace(sso,'local SSO = {}','local clear = require("table.clear")'+snl+'local SSO = {}');
replace(sso,['\tfunction SSO:reset(entities)','\t\tself.bb_all_entities = entities','\t\tself.bb_grids = {}','\tend'].join(snl),[
'\tfunction SSO:reset(entities)',
'\t\tif entities and entities == self.bb_all_entities then',
'\t\t\t-- Reuse cell arrays within this stage, but release every previous target.',
'\t\t\tfor _, g in pairs(self.bb_grids) do',
'\t\t\t\tfor _, column in pairs(g.grid) do',
'\t\t\t\t\tfor _, cell in pairs(column) do',
'\t\t\t\t\t\tclear(cell)',
'\t\t\t\t\tend',
'\t\t\t\tend',
'\t\t\tend',
'\t\telse',
'\t\t\tself.bb_grids = {}',
'\t\tend',
'\t\tself.bb_all_entities = entities',
'\tend'].join(snl));
replace(sso,'\t\tlocal g = {}','\t\tlocal g = self.bb_grids[name] or {}');
replace(sso,'\t\tg.grid = {}','\t\tg.grid = g.grid or {}');
for(const [file,source]of sources){const dest=task+'/candidate/'+file;fs.mkdirSync(path.dirname(dest),{recursive:true});fs.writeFileSync(dest,source);}
fs.writeFileSync(task+'/baseline-hashes.json',JSON.stringify(hashes,null,2));
console.log('Staged 3 files; live game untouched.');
