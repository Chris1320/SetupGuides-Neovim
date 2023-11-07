return {
    "nvim-lualine/lualine.nvim",

    enabled = true,
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "gitsigns.nvim",
    },
    opts = function(_, opts)
        local disabled_filetypes = {
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
        }
        return vim.tbl_deep_extend("force", opts, {
            options = {
                icons_enabled = true,
                theme = "catppuccin", -- Use the catppuccin theme plugin.
                always_divide_middle = true,
                globalstatus = true,
            },
            disabled_filetypes = {
                statusline = disabled_filetypes,
                winbar = disabled_filetypes,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        on_click = function()
                            vim.cmd("Telescope git_branches")
                        end,
                    },
                    {
                        "diff",
                        on_click = function()
                            require("gitsigns").diffthis()
                        end,
                    },
                    {
                        "diagnostics",
                        update_in_insert = true,
                        always_visible = false,
                        sources = { "nvim_lsp", "nvim_diagnostic" },
                        on_click = function()
                            vim.cmd("TroubleToggle document_diagnostics")
                        end,
                    },
                },
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        newfile_status = true,
                        path = 0, -- Show only the filename.
                    },
                },
                lualine_x = { "encoding", "filesize", "filetype", "fileformat" },
                lualine_y = { "searchcount", "progress" },
                lualine_z = { "location" },
            },
            extensions = { -- Enable integrations.
                "lazy",
                "nvim-dap-ui",
                "nvim-tree",
                "quickfix",
            },
        })
    end,
}
