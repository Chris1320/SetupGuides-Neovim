return {
    "m4xshen/smartcolumn.nvim",

    enabled = true,
    event = "VeryLazy",
    opts = function(_, opts)
        local column_config = require("config.vars").appearance.colorcolumn
        return vim.tbl_extend("force", opts, {
            colorcolumn = column_config.default_columns,
            disabled_filetypes = {
                -- Neovim and plugin filetypes
                "alpha",
                "checkhealth",
                "dap-repl",
                "dapui_breakpoints",
                "dapui_console",
                "dapui_scopes",
                "dapui_stacks",
                "dapui_watches",
                "dashboard",
                "fish",
                "help",
                "lazy",
                "lspinfo",
                "mason",
                "noice",
                "NvimTree",
                "starter",
                "TelescopePrompt",
                "Trouble",
                "zsh",

                -- Actual filetypes
                "conf",
                "markdown",
                "text",
            },
            custom_colorcolumn = column_config.custom_colorcolumns,
            scope = "window",
        })
    end,
}
