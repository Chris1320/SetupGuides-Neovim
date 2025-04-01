return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
        editor = { tooltip = "I use Neovim btw" },
        display = {
            theme = "catppuccin",
            flavor = "dark",
        },
        timestamp = {
            enabled = true,
            reset_on_idle = false,
            reset_on_change = false,
        },
        idle = {
            enabled = true,
            timeout = 300000, -- 5 minutes
            show_status = true,
            ignore_focus = true,
            unidle_on_focus = true,
            smart_idle = true,
            details = "Idle, probably procrastinating",
            tooltip = "💤",
        },
        text = {
            default = nil,
            workspace = function(opts)
                return "In " .. opts.workspace
            end,
            viewing = function(opts)
                return "Viewing " .. opts.filename
            end,
            editing = function(opts)
                return "Editing " .. opts.filename
            end,
            file_browser = function(opts)
                return "Browsing files in " .. opts.name
            end,
            plugin_manager = function(opts)
                return "Managing plugins in " .. opts.name
            end,
            lsp = function(opts)
                return "Configuring LSP in " .. opts.name
            end,
            docs = function(opts)
                return "Reading " .. opts.name
            end,
            vcs = function(opts)
                return "Committing changes in " .. opts.name
            end,
            notes = function(opts)
                return "Taking notes in " .. opts.name
            end,
            debug = function(opts)
                return "Debugging in " .. opts.name
            end,
            test = function(opts)
                return "Testing in " .. opts.name
            end,
            diagnostics = function(opts)
                return "Fixing problems in " .. opts.name
            end,
            games = function(opts)
                return "Playing " .. opts.name
            end,
            terminal = function(opts)
                return "Running commands in " .. opts.name
            end,
            dashboard = "Home",
        },
        buttons = {
            {
                label = function(opts)
                    return opts.repo_url and "View Repository" or "My Neovim Setup"
                end,
                url = function(opts)
                    return opts.repo_url or "https://chris1320.github.io/SetupGuides/Text-Editors/Neovim/Neovim"
                end,
            },
        },
        hooks = {
            -- selene: allow(unused_variable)
            ready = function(...) ---@diagnostic disable-line: unused-vararg
                vim.notify("Connected to Discord!")
            end,
        },
        advanced = {
            discord = {
                reconnect = {
                    enabled = true,
                    interval = 10000,
                    initial = true,
                },
            },
        },
    },
}
