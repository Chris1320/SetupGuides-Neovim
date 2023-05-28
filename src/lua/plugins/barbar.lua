return {
    "romgrk/barbar.nvim",

    enabled = true,
    lazy = false,
    priority = 80,
    dependencies = {
        "gitsigns.nvim",
        "kyazdani42/nvim-web-devicons"
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = true,
        auto_hide = true,
        tabpage = true,
        closable = true,
        clickable = true,
        icons = {
            buffer_index = false,
            buffer_number = false,
            diagnostics = {
                -- By default, only show errors and warnings.
                [vim.diagnostic.severity.ERROR] = {
                    enabled = true,
                    icon = ""
                },
                [vim.diagnostic.severity.WARN] = {
                    enabled = true,
                    icon = ""
                },
                [vim.diagnostic.severity.HINT] = {
                    enabled = false,
                    icon = ""
                },
                [vim.diagnostic.severity.INFO] = {
                    enabled = false,
                    icon = ""
                }
            },
            filetype = {  -- Show filetype icon
                custom_colors = true,
                enabled = true
            }
        }
    }
}
