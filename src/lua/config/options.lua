-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- local g = vim.g
local o = vim.opt

o.hlsearch = true -- highlight search results.
o.incsearch = true -- enable incremental search.
o.magic = true -- enable regex.

o.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent.
o.tabstop = 4 -- number of spaces that a <Tab> in the file counts for.
o.softtabstop = 4 -- number of spaces that a <Tab> counts for while editing.

o.showmatch = true -- show matching brackets.
o.colorcolumn = { 80 } -- Which columns should be highlighted
