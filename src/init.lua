local lazy_vars = require("vars").lazy

-- Bootstrap lazy.nvim plugin manager
if not vim.loop.fs_stat(lazy_vars.paths.home) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazy_vars.paths.home,
    })
end

vim.opt.rtp:prepend(lazy_vars.paths.home)

require("options")
require("keymaps")

-- Set up lazy.nvim
local lazy_opts = { root = lazy_vars.paths.root }
lazy_opts = vim.tbl_deep_extend("force", lazy_opts, lazy_vars.config)

require("lazy").setup("plugins", lazy_opts)
