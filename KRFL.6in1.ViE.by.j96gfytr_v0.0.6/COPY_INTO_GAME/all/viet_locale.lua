-- Runtime translation for hard-coded UI text. No network access.

local dictionary = require("viet_dictionary")

local M = {}

function M.text(source)

    local locale = package.loaded["i18n"]

    if type(source) ~= "string" or not locale or locale.current_locale ~= "vi" then

        return source

    end

    return dictionary[source] or source

end

function M.name(source)

    local locale = package.loaded["i18n"]

    if not locale or locale.current_locale ~= "vi" then return source end

    return require("viet_names")[source] or M.text(source)

end

return M

