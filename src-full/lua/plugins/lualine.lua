return {
    "nvim-lualine/lualine.nvim",

    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "gitsigns.nvim",
    },
    opts = function()
        local Util = require("lazyvim.util")
        -- PERF: we don't need this lualine require madness ??
        local lualine_require = require("lualine_require")
        lualine_require.require = require

        local icons = require("lazyvim.config").icons
        vim.o.laststatus = vim.g.lualine_laststatus

        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "branch",
                        on_click = function()
                            local has_telescope, telescope = pcall(require, "telescope.builtin")
                            if has_telescope then
                                telescope.git_branches()
                            end
                        end,
                    },
                },
                lualine_c = {
                    Util.lualine.root_dir(),
                    {
                        "diagnostics",
                        update_in_insert = true,
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                        on_click = function()
                            local has_trouble, trouble = pcall(require, "trouble")
                            if has_trouble then
                                trouble.toggle("document_diagnostics")
                            end
                        end,
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { Util.lualine.pretty_path() },
                },
                lualine_x = {
                    {
                        function()
                            ---@diagnostic disable-next-line: undefined-field
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = Util.ui.fg("Statement"),
                    },
                    {
                        function()
                            ---@diagnostic disable-next-line: undefined-field
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = Util.ui.fg("Constant"),
                    },
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = Util.ui.fg("Debug"),
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                        on_click = function()
                            local has_gitsigns, gitsigns = pcall(require, "gitsigns")
                            if has_gitsigns then
                                gitsigns.diffthis()
                            end
                        end,
                    },
                },
                lualine_y = {
                    "filesize",
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return "  " .. os.date("%H:%M:%S")
                    end,
                },
            },
            extensions = { "neo-tree", "lazy" },
        }
    end,
}
