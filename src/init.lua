--[[
https://github.com/SetupGuides/Neovim

This is the entry point for the init script.
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

require("options")  -- Setup options.
require("keymaps")  -- Setup keymaps.
require("lazy").setup(  -- Setup lazy.
    "plugins",
    {
        root = vars.lazy.path.root,
        install = vars.lazy.install,
        checker = vars.lazy.checker,
        change_detection = vars.lazy.change_detection,
    }
)
