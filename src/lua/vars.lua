--[[
This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

]]--

return {
    lazy = {
        path = {
            root = vim.fn.stdpath("data") .. "/lazy",
            home = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        },
        install = {
            missing = true,
            colorscheme = {"catppuccin-mocha"}
        },
        checker = {
            enabled = true,
            concurrency = nil,
            notify = true,
            frequency = 10800
        },
        change_detection = {
            enabled = true,
            notify = true
        }
    },
    colorscheme = {
        catppuccin_flavor = "mocha",  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`
        catppuccin_cache_dir = vim.fn.stdpath("cache") .. "/catppuccin"
    },
    treesitter = {
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
            "toml",
            "typescript",
            "vim",
            "yaml"
        }
    },
    notifications = {
        -- Silenced notifications for nvim-notify
        blocked = {
            -- This is a table of strings.
            -- Add notifications you don't want to see here.
        }
    }
}
