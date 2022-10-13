--[[
vars.lua - This is part of a custom config file for Neovim v0.7.2+.

You can get it from:
https://github.com/SetupGuides/Neovim

This module provides easy-access to variables to the end-user.
]]--

return {
    -- Shortcuts
    leaderkey = ',',      -- Set leader key.

    -- Editor
    ctermfg = "grey",     -- The color of the line numbers.
    use_spaces = true,    -- Convert tabs to spaces.

    show_eols = false,    -- Show EOL characters.
    show_spaces = false,  -- Show space characters.
    show_trails = true,   -- Show trailing spaces.

    eol_char = '↴',       -- The character for EOLs when `list` is enabled.
    space_char = '⋅',     -- The character for a space when `list` is enabled.
    trail_char = '·',     -- The character for trailing spaces when `list` is enabled.
    fold_chars = {        -- Characters for fold indicators
        fold = " ",        -- Fold text
        open = "",       -- Opened fold
        close = "",      -- Closed fold
        sep = " ",         -- Fold separator
        eob = " "          -- Empty lines at the end of a buffer
    },

    -- Plugin Configurations

    -- catppuccin (theme)
    catppuccin_flavour = "mocha",  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`

    -- Gitsigns
    git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>",

    -- Treesitter
    treesitter_languages = {                          -- [add|remove] languages you [don't] want to use.
        "bash",                            -- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        "c",
        "cpp",
        "css",
        "c_sharp",
        "cmake",
        "dockerfile",
        "html",
        "java",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "kotlin",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "rst",
        "rust",
        "sql",
        "toml",
        "typescript",
        "vim",
        "yaml"
    },

    -- Silenced notifications for nvim-notify
    blocklisted_notifications = {
        "warning: multiple different client offset_encodings",  -- See `https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428`
                                                                -- for more information.
        "received `end` message with no corresponding `begin`",  -- Java lsp server error (WIP)
        "Could not find `Cargo.toml`"  -- Rust lspconfig warning (WIP)
    },

    mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/",
    catppuccin_cache_dir = vim.fn.stdpath("cache") .. "/catppuccin",
    plugins_installed_path = vim.fn.stdpath("data") .. "/.plugins_installed"  -- The file to look for when checking if nvim has already run.
}
