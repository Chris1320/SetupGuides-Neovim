-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g = vim.g
local o = vim.opt

o.hlsearch = true -- highlight search results
o.incsearch = true -- enable incremental search
o.magic = true -- enable regex

o.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
o.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
o.softtabstop = 4 -- number of spaces that a <Tab> counts for while editing

o.showmatch = true -- show matching brackets
-- o.colorcolumn = { 80 } -- Which columns should be highlighted

o.clipboard = "" -- Separate system clipboard

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

-- LazyVim-specific options
g.lazyvim_python_lsp = "basedpyright" -- Use basedpyright instead of pyright
-- g.lazyvim_prettier_needs_config = true -- If no prettier config file is found, the formatter will not be used
