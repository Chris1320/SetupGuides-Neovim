--[[
vars.lua

This module provides easy-access to variables to the end-user.
]]--

return {
    installed = false,             -- set this to true after running `:PluginSync` in neovim.

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

    -- Plugin Configurations

    -- catppuccin (theme)
    catppuccin_flavour = "mocha",  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`

    -- Gitsigns
    git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>",

    -- Treesitter
    languages = {                          -- [add|remove] languages you [don't] want to use.
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
        "toml",
        "typescript",
        "yaml"
    }
}
