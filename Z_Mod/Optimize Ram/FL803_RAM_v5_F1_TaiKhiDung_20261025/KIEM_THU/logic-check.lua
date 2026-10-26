local root='D:/CodexTemp/KRFL_RAM_803_805_20261025'
package.path=root..'/source803/lib/?.lua;'..package.path
love={graphics={isActive=function()return true end},filesystem={},timer={getTime=os.clock},system={getOS=function()return 'Windows'end}}
for _,file in ipairs({'all/director.lua','all-desktop/game_gui.lua','lib/klove/image_db.lua'})do assert(loadfile(root..'/candidate/'..file))end
local function image_db()local I=assert(loadfile(root..'/candidate/lib/klove/image_db.lua'))();I.use_canvas=false;I.queue_load_total_images=1;return I end
local function entry(results,running,err)
 local n=0
 return {{isRunning=function()return running end,getError=function()return err end},{push=function()end},{pop=function()n=n+1;return results[n]end}}
end
local tests={}
local I=image_db();I.threads={entry({},false,'decode failed')};local ok,err=pcall(I.queue_load_done,I);assert(not ok and tostring(err):find('decode failed',1,true),tostring(err));tests[#tests+1]='PASS stopped worker fails before stage entry'
I=image_db();I.threads={entry({{'ERROR','bad PNG','bad.png'}},true)};ok,err=pcall(I.queue_load_done,I);assert(not ok and tostring(err):find('bad PNG',1,true),tostring(err));tests[#tests+1]='PASS reported decode error propagates'
I=image_db();I.threads={entry({{'DONE'}},true)};ok,err=pcall(I.queue_load_done,I);assert(not ok and tostring(err):find('incomplete',1,true),tostring(err));tests[#tests+1]='PASS incomplete upload count is rejected'
love.graphics.newImage=function()return {isCompressed=function()return false end}end
I=image_db();I.threads={entry({{'OK','fixture',{},2,2},{'DONE'}},true)}
assert(I:queue_load_done()==false);assert(I:queue_load_done()==true);assert(I.db_images.fixture and #I.threads==0);tests[#tests+1]='PASS successful worker completes exactly once'
local f=assert(io.open(root..'/candidate/all/director.lua','rb'));local source=f:read('*a');f:close()
local a=assert(source:find('function director:load_deferred_cheat_textures',1,true))
local b=assert(source:find('function director:load_texture_groups',a,true))
local calls,stack=0,0
local D={params={texture_size='fullhd'},load_texture_groups=function()calls=calls+1 end}
local env={director=D,I={queue_load_done=function()return true end},replace_locale=function(v)return v end,TEXTURE_SIZE_FACTOR={kr_45=.6},G={push=function()stack=stack+1 end,pop=function()stack=stack-1 end},love={timer={step=function()end}},table=table}
local fn=assert(loadstring(source:sub(a,b-1)));setfenv(fn,env);fn()
local game={ref_res=768,required_textures={'base'},scale_required_textures={},deferred_cheat_textures={'extra'},deferred_cheat_scale_textures={'scaled'}}
D:load_deferred_cheat_textures(game);assert(calls==2 and stack==0);assert(game.required_textures[2]=='extra' and game.scale_required_textures[1]=='scaled');assert(game.deferred_cheat_textures==nil)
D:load_deferred_cheat_textures(game);assert(calls==2 and stack==0);tests[#tests+1]='PASS deferred groups join normal unload ownership; second call queues nothing'
tests[#tests+1]='PASS all 3 payload Lua files compile with the installed LuaJIT'
return table.concat(tests,'\n')
