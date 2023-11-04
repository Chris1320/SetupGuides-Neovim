--[[
https://github.com/SetupGuides/Neovim
]]

return {
    proprietary = {
        -- Set keys to true to enable the plugins.
        copilot = true,
    },
    lazy = { -- configuration for lazy.nvim package manager
        path = {
            root = vim.fn.stdpath("data") .. "/lazy",
            home = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
        },
        install = { -- This table is passed directly to lazy.nvim
            missing = true,
            colorscheme = { "catppuccin-mocha" },
        },
        checker = { -- This table is passed directly to lazy.nvim
            enabled = true,
            concurrency = nil,
            notify = true,
            frequency = 10800,
        },
        change_detection = { -- This table is passed directly to lazy.nvim
            enabled = true,
            notify = true,
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
                -- lua, luau:     StyLua
                -- python:        Black, Pylint
                bash = { 120 },
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
    behavior = {
        line_wrapping = false,
        use_spaces = true,
        -- if use_spaces is true, this is the number of spaces to use for each tab.
        tab_size = 4,
    },
    keymapping = {
        leaderkey = ",",
    },
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
    treesitter = {
        enforce_ensure_installed = true,
        auto_install = true,
        -- [add|remove] languages you [don't] want to use.
        -- Reference: https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        languages = {
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
    },
    lualine = {
        ignored_filetypes = {
            "dap-repl",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_stacks",
            "dapui_watches",
            "mason",
            "NvimTree",
            "TelescopePrompt",
            "Trouble",
        },
        filename_config = {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 0, -- Show only the filename.
        },
    },
    lsp = {
        enforce_ensure_installed = true,
        auto_install = false,
        ensure_installed = {
            "bashls",
            "clangd",
            "jdtls",
            "lua_ls",
            "omnisharp",
            "pyright",
        },
    },
    dap = {
        enforce_ensure_installed = true,
        auto_install = false,
        ensure_installed = {
            "python",
        },
    },
}
