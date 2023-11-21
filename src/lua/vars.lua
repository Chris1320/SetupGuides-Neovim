return {
    -- Configuration for lazy.nvim package manager
    --
    -- The `config` table is passed directly to lazy.nvim's `setup` function.
    -- View the documentation here:
    -- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-configuration
    lazy = {
        paths = {
            root = vim.fn.stdpath("data") .. "/lazy",
            home = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
        },
        config = {
            install = {
                missing = true,
                colorscheme = { "catppuccin-mocha" },
            },
            change_detection = {
                enabled = true,
                notify = true,
            },
        },
    },
    -- Enable or disable plugins that are proprietary.
    proprietary = {
        copilot = true,
    },
    keymapping = {
        leaderkey = ",",
    },
    behavior = {
        line_wrapping = false,
        use_spaces = true,
        tab_size = 4,
        notifications = {
            -- Silenced notifications for nvim-notify
            blocked = {
                -- This is a table of strings.
                -- Add notifications you don't want to see here.
                -- For example, if you want to silence all notifications
                -- with the word "annoying" in them, you would add that
                -- word to this table.
            },
        },
    },
    appearance = {
        show_eols = false, -- Show EOL characters
        show_spaces = false, -- Show spaces
        show_trails = true, -- Show trailing spaces
        colorcolumn = {
            default_columns = { 80 }, -- Which columns should be highlighted
            custom_colorcolumns = {
                -- NOTE: Line length references
                -- bash, sh, zsh: N/A
                -- c, cpp:        Google C++ Style Guide
                -- cs:            csharpier
                -- lua, luau:     StyLua
                -- python:        Black, Pylint
                bash = { 120 },
                c = { 80 },
                cpp = { 80 },
                cs = { 100 },
                java = { 120 },
                lua = { 120 },
                luau = { 120 },
                python = { 88, 100 },
                sh = { 120 },
                zsh = { 120 },
            },
        },
        colorscheme = {
            -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`
            catppuccin_flavor = "mocha",
            catppuccin_cache_dir = vim.fn.stdpath("cache") .. "/catppuccin",
            line_number_color = "grey",
        },
        git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>",
        icons = {
            eol = "¬",
            space = "⋅",
            trail = "·",
            fold = { -- Characters for fold indicators
                fold = " ", -- Fold text
                open = "", -- Opened fold
                close = "", -- Closed fold
                sep = " ", -- Fold separator
                eob = " ", -- Empty lines at the end of a buffer
            },
        },
    },
    ide = {
        -- [add|remove] languages you [don't] want to use.
        -- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        treesitter = {
            "bash",
            "c",
            "c_sharp",
            "comment",
            "cpp",
            "gitcommit",
            "java",
            "json",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
        },
        lsp = {
            "bashls",
            "clangd",
            "jdtls",
            "lua_ls",
            "omnisharp",
            "pyright",
        },
        linters = {
            "codespell",
            -- TODO: Add `commitlint` and configure it.
            -- "commitlint",
            "pylint",
            "selene",
            "shellcheck",
        },
        formatters = {
            "black",
            "clang-format",
            "csharpier",
            "isort",
            "shfmt",
            "stylua",
        },
        dap = {
            "debugpy",
        },
    },
}
