--[[
options.lua - This is part of a custom config file for Neovim v0.7.2+.

You can get it from:
https://github.com/SetupGuides/Neovim

This module configures Neovim options.
]]--

local vars = require("vars")  -- Get variables.

return {
    setup = function()
        vim.g.mapleader = vars["leaderkey"]                         -- Set leader key.
        vim.cmd("filetype plugin on")                               -- enable loading plugins for specific file types.

        -- Editor-related configuration
        vim.opt.number = true                                       -- enable line numbers.
        vim.opt.showmatch = true                                    -- show matching brackets.
        vim.opt.cursorline = true                                   -- enable cursor line.
        vim.opt.wrap = false                                        -- Disable line wrapping.
        vim.opt.wildmode = {"longest", "list"}                      -- get bash-like tab completions.
        vim.opt.mouse = 'a'                                         -- enable usage of mouse in all modes.
        vim.opt.clipboard = "unnamedplus"                           -- enable usage of system clipboard.
        vim.opt.ttyfast = true                                      -- indicate fast terminal connection to speed up scrolling.
        vim.opt.termguicolors = true                                -- enable for consistent color scheme across terminals.
        vim.cmd("syntax on")                                        -- enable syntax highlighting
        vim.cmd("highlight LineNr ctermfg=" .. vars["ctermfg"])     -- Set the color of the line numbers

        -- Search-related configuration
        vim.opt.hlsearch = true                                     -- highlight search results.
        vim.opt.incsearch = true                                    -- enable incremental search.
        vim.opt.smartcase = true                                    -- smart case searching.
        vim.opt.ignorecase = true                                   -- case insensitive when searching.
        vim.opt.magic = true                                        -- enable regex.

        -- Indentation-related configuration
        vim.cmd("filetype plugin indent on")                        -- allow auto-indentation depending on file type.
        vim.opt.autoindent = true                                   -- Enable auto indent.
        -- vim.opt.smartindent = true                               -- Enable smart indent.
        vim.opt.indentexpr = "nvim_treesitter#indentexpr()"         -- Use treesitter for indentation.
        vim.opt.expandtab = vars["use_spaces"]                      -- converts tabs to white space.
        vim.opt.shiftwidth = 4                                      -- width for autoindents.
        vim.opt.tabstop = 4                                         -- number of columns occupied by a tab.
        vim.opt.softtabstop = 4                                     -- see multiple spaces as tabstops so <BS> does the right thing.

        vim.opt.foldmethod = "manual"                               -- use treesitter to determine where to fold.
        -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"          -- the expression to use for folding.

        vim.opt.foldcolumn = "1"
        vim.opt.foldlevel = 99                                      -- fold level.
        vim.opt.foldlevelstart = 99
        vim.opt.foldenable = true

        vim.opt.list = true                                         -- enable display of unprintable characters.
        if vars["show_eols"] then                                   -- Enable if you want to display spaces, trailing spaces, and EOLs.
            vim.opt.listchars:append("eol:" .. vars["eol_char"])

        end
        if vars["show_spaces"] then
            vim.opt.listchars:append("space:" .. vars["space_char"])

        end
        if vars["show_trails"] then
            vim.opt.listchars:append("trail:" .. vars["trail_char"])

        end

        vim.opt.fillchars:append(
            {
                fold = vars["fold_chars"]["fold"],
                foldopen = vars["fold_chars"]["open"],
                foldclose = vars["fold_chars"]["close"],
                foldsep = vars["fold_chars"]["sep"],
                eob = vars["fold_chars"]["eob"]
            }
        )
    end
}
