local vars = require("vars")

return {
    "m4xshen/smartcolumn.nvim",

    enabled = true,
    event = "VeryLazy",
    opts = {
        colorcolumn = vars.appearance.colorcolumn.default_columns,
        disabled_filetypes = {
            -- Neovim and plugin filetypes
            "dap-repl",
            "dapui_breakpoints",
            "dapui_console",
            "dapui_scopes",
            "dapui_stacks",
            "dapui_watches",
            "help",
            "lazy",
            "mason",
            "NvimTree",
            "TelescopePrompt",
            "Trouble",

            -- Actual filetypes
            "markdown",
            "text"
        },
        custom_colorcolumn = vars.appearance.colorcolumn.custom_colorcolumns,
        scope = "window"
    }
}
