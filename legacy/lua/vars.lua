--[[
vars.lua - This is part of a custom config file for Neovim v0.8.0+.

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

    mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/",
    catppuccin_cache_dir = vim.fn.stdpath("cache") .. "/catppuccin",
    plugins_installed_path = vim.fn.stdpath("data") .. "/.plugins_installed"  -- The file to look for when checking if nvim has already run.
}
