return {
    "nvim-lualine/lualine.nvim",
    opts = function()
        -- PERF: we don't need this lualine require madness 🤷
        local lualine_require = require("lualine_require")
        local snacks = require("snacks")
        lualine_require.require = require

        -- selene: allow(undefined_variable)
        local icons = LazyVim.config.icons

        vim.o.laststatus = vim.g.lualine_laststatus

        local opts = {
            options = {
                theme = "auto",
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
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
                    -- selene: allow(undefined_variable)
                    LazyVim.lualine.root_dir(),
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
                    -- selene: allow(undefined_variable)
                    { LazyVim.lualine.pretty_path() },
                },
                -- Show the profiler status, command status, mode status, debug status, lazy status, and Git diff.
                lualine_x = {
                    snacks.profiler.status(),
                    {
                        function()
                            ---@diagnostic disable-next-line: undefined-field
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = function()
                            return { fg = snacks.util.color("Statement") }
                        end,
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
                        color = function()
                            return { fg = snacks.util.color("Constant") }
                        end,
                    },
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = function()
                            return { fg = snacks.util.color("Debug") }
                        end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function()
                            return { fg = snacks.util.color("Special") }
                        end,
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
            extensions = { "neo-tree", "lazy", "fzf" },
        }

        -- do not add trouble symbols if aerial is enabled
        -- And allow it to be overriden for some buffer types (see autocmds)
        -- selene: allow(undefined_variable)
        if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
            local trouble = require("trouble")
            local symbols = trouble.statusline({
                mode = "symbols",
                groups = {},
                title = false,
                filter = { range = true },
                format = "{kind_icon}{symbol.name:Normal}",
                hl_group = "lualine_c_normal",
            })
            table.insert(opts.sections.lualine_c, {
                symbols and symbols.get,
                cond = function()
                    return vim.b.trouble_lualine ~= false and symbols.has()
                end,
            })
        end

        return opts
    end,
}
