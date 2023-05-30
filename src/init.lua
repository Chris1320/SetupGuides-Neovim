--[[
This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

This is the entry point for the init script.

Cheatsheet:

vim.g    -- global variables (`let` command in vim)
vim.fn   -- functions
vim.cmd  -- commands
vim.opt  -- options (`set` command in vim)
]]--

local vars = require("vars")

-- Bootsrap lazy.nvim plugin manager
if not vim.loop.fs_stat(vars.lazy.path.home) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            vars.lazy.path.home,
        }
    )
end

vim.opt.rtp:prepend(vars.lazy.path.home)

-- Setup options.
require("options")

-- Setup keymaps.
require("keymaps")

-- Setup lazy.
require("lazy").setup(
    "plugins",
    {
        root = vars.lazy.path.root,
        install = vars.lazy.install,
        checker = vars.lazy.checker,
        change_detection = vars.lazy.change_detection,
    }
)
