-- Session settings from the Windows launcher. No save edits or Mod overrides.
local M = {}
function M.apply(params)
    if os.getenv('KRFL_WINDOWS_LAUNCHER') ~= '1' then return end
    local function value(key) return os.getenv('KRFL_LAUNCH_' .. string.upper(key)) end
    local function number(key, low, high)
        local n = tonumber(value(key))
        if n then params[key] = math.max(low, math.min(high, math.floor(n))) end
    end
    number('width',800,7680);number('height',600,4320)
    number('fps',30,60);number('max_threads',1,4);number('msaa',0,8)
    for _, key in ipairs({'fullscreen','vsync','highdpi','large_pointer','pause_on_switch','draw_stats'}) do
        if value(key) then params[key] = value(key) == '1' end
    end
    local kind = value('fullscreentype')
    if kind == 'desktop' or kind == 'exclusive' then params.fullscreentype = kind end
    local locale = value('locale')
    if locale == 'vi' or locale == 'en' then params.locale = locale end
    for _, key in ipairs({'volume_music','volume_fx'}) do
        local n = tonumber(value(key))
        if n then params[key] = math.max(0,math.min(100,n)) / 100 end
    end
    KRFL_LAUNCH_SHADER_EFFECTS = value('shader_effects') ~= '0'
    params.skip_settings_dialog = true
    params.log_file = os.getenv('KRFL_LAUNCH_LOG_FILE') or params.log_file
    if not M.window_hooked then
        M.window_hooked = true
        local original = love.window.setMode
        love.window.setMode = function(w,h,flags)
            flags = flags or {}
            if flags.fullscreen then flags.fullscreentype = params.fullscreentype or 'desktop' end
            return original(w,h,flags)
        end
    end
end
return M
