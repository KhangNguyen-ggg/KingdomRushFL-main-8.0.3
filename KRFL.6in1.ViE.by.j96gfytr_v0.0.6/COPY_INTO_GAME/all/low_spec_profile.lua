-- Optional low-spec session profile. Does not write save/settings files.
local M = {}
function M.apply(params)
    params.width = 1280
    params.height = 720
    params.fps = 30
    params.max_threads = 1
    params.msaa = 0
    params.vsync = false
    params.highdpi = false
    params.fullscreen = false
    params.texture_size = "fullhd"
    params.image_db_uses_canvas = false
    params.skip_settings_dialog = true
    params.draw_stats = false
end
return M
