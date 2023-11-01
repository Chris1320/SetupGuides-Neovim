local vars = require("vars")
local misc = require("misc")

vim.g.mapleader = vars.keymapping.leaderkey
local vars_path = vim.fn.stdpath("config") .. "/lua/vars.lua"

-- Set Neovim shortcuts
vim.keymap.set(
    "n",
    "<leader>/",
    "<cmd>nohlsearch<cr>",
    { noremap = true, silent = true, desc = "Remove last search highlights" }
)
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { noremap = true, silent = true, desc = "Toggle word wrap" })

vim.keymap.set(
    "x",
    "<leader>p",
    '"_dP',
    { noremap = true, silent = true, desc = "Paste without replacing clipboard content" }
)

-- Other stuff
vim.keymap.set(
    "n",
    "<leader>ic",
    "<cmd>e " .. vars_path .. "<cr>",
    { noremap = true, silent = true, desc = "Edit vars.lua" }
)
vim.keymap.set(
    "n",
    "<leader>iv",
    misc.showConfigVersion,
    { noremap = true, silent = true, desc = "Show Neovim config version" }
)
vim.keymap.set(
    "n",
    "<leader>il",
    "<cmd>LspInfo<cr>",
    { noremap = true, silent = true, desc = "Show active LSP information" }
)
