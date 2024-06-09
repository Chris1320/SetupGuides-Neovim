return {
    "nvim-lualine/lualine.nvim",

    enabled = true,
    opts = function()
        local Util = require("lazyvim.util")
        local icons = require("lazyvim.config").icons
        -- PERF: we don't need this lualine require madness 🤷
        local lualine_require = require("lualine_require")

        lualine_require.require = require
        vim.o.laststatus = vim.g.lualine_laststatus

        local opts = {
            options = {
                theme = "auto",
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                -- Show the current mode.
                lualine_a = { "mode" },
                -- Show the current Git branch.
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
                -- Show the project root directory, diagnostics, filetype, and the current file path.
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
                -- Show the command, mode, debug status, and Git diff.
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
                -- Show the file size, progress, and location.
                lualine_y = {
                    "filesize",
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                -- Show the current time.
                lualine_z = {
                    function()
                        return "  " .. os.date("%H:%M:%S")
                    end,
                },
            },
            extensions = { "neo-tree", "lazy" },
        }

        -- do not add trouble symbols if aerial is enabled
        if vim.g.trouble_lualine then
            local trouble = require("trouble")
            local symbols = trouble.statusline
                and trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
            table.insert(opts.sections.lualine_c, {
                symbols and symbols.get,
                cond = symbols and symbols.has,
            })
        end

        return opts
    end,
}
