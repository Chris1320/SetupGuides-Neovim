--[[
init.lua - This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

This is the entry point for the init script.
]]--

--[[
Cheatsheet:

vim.g    -- global variables (`let` command in vim)
vim.fn   -- functions
vim.cmd  -- commands
vim.opt  -- options (`set` command in vim)
]]--

local flagFile = require("core.utils.flagFile")

require("options").setup()  -- Set options.
local first_run = require("plugins.plugins").setup()  -- Load plugins.
require("keymaps").setup()  -- Set keymaps.

-- Update flag file.
local flag_file_update_result = flagFile.update()
if flag_file_update_result["exit_code"] ~= 0 then
    vim.notify(flag_file_update_result["message"])
end

require("post_ops").run(first_run)  -- Run post-install operations.
