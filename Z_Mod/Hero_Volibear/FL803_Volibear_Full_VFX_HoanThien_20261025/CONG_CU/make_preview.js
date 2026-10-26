const fs=require('fs'), assert=require('assert');
const task='D:/CodexTemp/KRFL_Voli_FullVFX_20261025';
const pack='D:/Kingdom Rush Frontiers Tower Defense v5.4.07/KingdomRushFL-main 8.0.3/Z_Mod/Volibear/FL803_Volibear_Full_VFX_HoanThien_20261025';
const signature=Buffer.from([137,80,78,71,13,10,26,10]);
const table=Array.from({length:256},(_,n)=>{for(let i=0;i<8;i++)n=(n>>>1)^((n&1)?0xedb88320:0);return n>>>0;});
function crc(buf){let n=0xffffffff;for(const b of buf)n=table[(n^b)&255]^(n>>>8);return (n^0xffffffff)>>>0;}
function chunk(type,data){let out=Buffer.alloc(data.length+12);out.writeUInt32BE(data.length);out.write(type,4,'ascii');data.copy(out,8);out.writeUInt32BE(crc(out.subarray(4,-4)),out.length-4);return out;}
function parse(buf){assert(buf.subarray(0,8).equals(signature));let out=[];for(let i=8;i<buf.length;){let n=buf.readUInt32BE(i),type=buf.toString('ascii',i+4,i+8),data=buf.subarray(i+8,i+8+n);assert(buf.readUInt32BE(i+8+n)===crc(buf.subarray(i+4,i+8+n)));out.push({type,data});i+=n+12;}return out;}
const frames=fs.readdirSync(task+'/preview_frames').filter(n=>n.endsWith('.png')).sort().map(n=>parse(fs.readFileSync(task+'/preview_frames/'+n)));
assert(frames.length===24);const ihdr=frames[0][0].data;assert(ihdr.readUInt32BE(0)===1200&&ihdr.readUInt32BE(4)===720);
let animation=Buffer.alloc(8);animation.writeUInt32BE(frames.length);animation.writeUInt32BE(0,4);
const parts=[signature,chunk('IHDR',ihdr),chunk('acTL',animation)];let seq=0;
for(let i=0;i<frames.length;i++){
 assert(frames[i][0].data.equals(ihdr));let control=Buffer.alloc(26);control.writeUInt32BE(seq++);control.writeUInt32BE(1200,4);control.writeUInt32BE(720,8);control.writeUInt16BE(1,20);control.writeUInt16BE(12,22);
 parts.push(chunk('fcTL',control));
 for(const c of frames[i].filter(c=>c.type==='IDAT')){
  if(i===0)parts.push(chunk('IDAT',c.data));else{let index=Buffer.alloc(4);index.writeUInt32BE(seq++);parts.push(chunk('fdAT',Buffer.concat([index,c.data])));}
 }
}
parts.push(chunk('IEND',Buffer.alloc(0)));const result=Buffer.concat(parts);const check=parse(result);
assert(check.filter(c=>c.type==='fcTL').length===24&&check.find(c=>c.type==='acTL').data.readUInt32BE(0)===24);
fs.writeFileSync(pack+'/XEM_TRUOC_CHUYEN_DONG.png',result);console.log('PASS APNG: 24 frames, 1200x720, 12 FPS, '+result.length+' bytes; all chunk CRCs valid');
