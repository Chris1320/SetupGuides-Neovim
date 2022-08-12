--[[
init.lua - This is part of a custom config file for Neovim v0.7.2+.

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

require("vars")     -- Load variables
require("options")  -- Set options.
require("keymaps")  -- Set keymaps.
require("plugins")  -- Load plugins.
