-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g = vim.g
local o = vim.opt

o.scrolloff = 5
o.timeout = true
o.timeoutlen = 300
o.updatetime = 50

o.autowrite = false
o.swapfile = false -- disable swap files.
-- o.backup = false  -- disable backup files.
-- o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.clipboard = ""

-- Check if running on WSL.
-- Source: https://mitchellt.com/2022/05/15/WSL-Neovim-Lua-and-the-Windows-Clipboard.html
if os.getenv("WSL_DISTRO_NAME") ~= nil then
    local wsl_copy_cmd = { "clip.exe" }
    local wsl_paste_cmd = {
        "powershell.exe",
        "-c",
        '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    }
    g.clipboard = {
        name = "WSL Clipboard",
        copy = { ["+"] = wsl_copy_cmd, ["*"] = wsl_copy_cmd },
        paste = { ["+"] = wsl_paste_cmd, ["*"] = wsl_paste_cmd },
        cache_enabled = true,
    }
end

o.hlsearch = true -- highlight search results.
o.incsearch = true -- enable incremental search.
o.magic = true -- enable regex.

o.shiftwidth = require("config.vars").appearance.tab_width
o.tabstop = require("config.vars").appearance.tab_width
o.softtabstop = require("config.vars").appearance.tab_width

o.showmatch = true -- show matching brackets.
o.colorcolumn = require("config.vars").appearance.colorcolumn.default_columns

-- LazyVim-specific options
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"
