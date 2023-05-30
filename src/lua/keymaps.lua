local vars = require("vars")
local misc = require("misc")

vim.g.mapleader = vars.keymapping.leaderkey

-- Set Neovim shortcuts
vim.keymap.set('n', "<leader>/", "<cmd>nohlsearch<cr>", {noremap=true, silent=true, desc="Remove last search highlights"})
vim.keymap.set('n', "<leader>w", "<cmd>set wrap!<cr>", {noremap=true, silent=true, desc="Toggle word wrap"})

-- Neovim LSP shortcuts
vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, {noremap=true, silent=true, desc="Rename symbol"})

-- Other stuff
vim.keymap.set('n', "<leader>iv", misc.showConfigVersion, {noremap=true, silent=true, desc="Show Neovim config version"})
vim.keymap.set('n', "<leader>il", "<cmd>LspInfo<cr>", {noremap=true, silent=true, desc="Show active LSP information"})
