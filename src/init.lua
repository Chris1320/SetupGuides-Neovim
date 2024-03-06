local home_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim plugin manager
if not vim.loop.fs_stat(home_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        home_path,
    })
end

vim.opt.rtp:prepend(home_path)

require("options")
require("keymaps")

-- Set up lazy.nvim
-- View the documentation here:
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-configuration
local lazy_opts = {
    root = vim.fn.stdpath("data") .. "/lazy",
    spec = { { import = "plugins" } },
    install = {
        missing = true,
        colorscheme = { "catppuccin-mocha" },
    },
    defaults = { version = false },
    change_detection = {
        enabled = true,
        notify = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

require("lazy").setup(lazy_opts)
