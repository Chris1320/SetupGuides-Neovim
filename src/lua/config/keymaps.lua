--# selene: allow(multiple_statements)

--- Keymaps are automatically loaded on the VeryLazy event
--- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--- Add any additional keymaps here
-- local Util = require("lazyvim.util")

-- NOTE: I'm sorry, I tried using hjkl, but I really prefer arrow keys
-- because my hands hurt when I'm using only the left side of my keyboard.

-- Move to window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> hjkl keys
vim.keymap.set("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- other keymaps I have
vim.keymap.set("n", "zZ", "zzzszH", { noremap = true, silent = true, desc = "Center cursor" })
vim.keymap.set(
    "x",
    "<leader>p",
    '"_dP',
    { noremap = true, silent = true, desc = "Paste without replacing clipboard content" }
)
