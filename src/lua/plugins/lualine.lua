local vars_lualine = require("vars").lualine

return {
    "nvim-lualine/lualine.nvim",

    enabled = true,
    lazy = false,
    priority = 80,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
        "gitsigns.nvim"
    },
    opts = {
        options = {
            icons_enabled = true,
            theme = "catppuccin",  -- Use the catppuccin theme plugin.
            always_divide_middle = true,
            globalstatus = true
        },
        disabled_filetypes = {
            statusline = vars_lualine.ignored_filetypes,
            winbar = vars_lualine.ignored_filetypes
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {
                {
                    "branch",
                    on_click = function(...)
                        vim.cmd("Telescope git_branches")
                    end
                },
                {
                    "diff",
                    on_click = function(...)
                        require("gitsigns").diffthis()
                    end
                },
                {
                    "diagnostics",
                    update_in_insert = true,
                    always_visible = false,
                    on_click = function(...)
                        vim.cmd("TroubleToggle document_diagnostics")
                    end
                }
            },
            lualine_c = {vars_lualine.filename_config},
            lualine_x = {"encoding", "filesize", "filetype", "fileformat"},
            lualine_y = {"searchcount", "progress"},
            lualine_z = {"location"}
        },
        inactive_sections = {  -- This isn't used because globalstatus is set to true.
            lualine_a = {},
            lualine_b = {},
            lualine_c = {vars_lualine.filename_config},
            lualine_x = {"location", "filetype"},
            lualine_y = {},
            lualine_z = {}
        },
        extensions = {  -- Enable integrations.
            "nvim-tree",
            "quickfix"
        }
    }
}
