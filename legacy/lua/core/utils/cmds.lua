--[[
This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim
]]--

local info = require("core.info")

local function showConfigVersion()
    vim.notify("Config Version: v" .. table.concat(info.version, '.'))
end

return {
    showConfigVersion = showConfigVersion
}
