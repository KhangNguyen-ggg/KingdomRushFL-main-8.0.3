local task='D:/CodexTemp/KRFL_Abominor_Melee_20261026'
for _,file in ipairs({'payload/all/script_utils.lua','probe.lua','combat.lua'})do assert(loadfile(task..'/'..file))end
return 'PASS patched combat helper and native fixtures compile in installed LuaJIT'
