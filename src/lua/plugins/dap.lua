return {
    "mfussenegger/nvim-dap",

    enabled = true,
    lazy = false,
    -- DO NOT lazy load DAPs. I spent a few minutes figuring it out.
    -- event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui",
        {
            "theHamsta/nvim-dap-virtual-text",
            enabled = true,
            opts = {}
        }
    },
    init = function()
        -- Set up sign definitions at startup.
        vim.fn.sign_define("DapBreakpoint", {text='', texthl='', linehl='', numhl=''})
        vim.fn.sign_define("DapBreakpointCondition", {text='', texthl='', linehl='', numhl=''})
        vim.fn.sign_define("DapLogPoint", {text='', texthl='', linehl='', numhl=''})
        vim.fn.sign_define("DapStopped", {text='', texthl='', linehl='', numhl=''})
        vim.fn.sign_define("DapBreakpointRejected", {text='', texthl='', linehl='', numhl=''})
    end,
    config = function()
        local mdap = require("mason-nvim-dap")
        local dap = require("dap")
        local dapui = require("dapui")
        local mason_registry = require("mason-registry")
        local vars = require("vars")

        -- Try to find the path to the Python debugpy adapter.
        -- I haven't tried this on Windows systems yet.
        local function getPythonPath()
            local possible_python_paths = {
                -- Priority:
                -- - Mason-installed package
                -- - Activated virtualenv (via set environment variable)
                -- - random guesses
                -- - default Python installation path
                mason_registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python",
                (os.getenv("VIRTUAL_ENV") or "") .. "/bin/python",  -- FIXME: Is this method safe? I'm thinking of returning nil if env isn't set.
                vim.fn.getcwd() .. "/env/bin/python",               --        What if there's a malicious /bin/python executable?
                vim.fn.getcwd() .. "/venv/bin/python",
                vim.fn.getcwd() .. "/.env/bin/python",
                vim.fn.getcwd() .. "/.venv/bin/python",
                "/usr/bin/python"
            }
            for _, path in ipairs(possible_python_paths) do
                if vim.fn.executable(path) then return path end
            end
        end

        -- Setup mason-nvim-dap
        mdap.setup(
            {
                automatic_installation = vars.dap.auto_install,
                ensure_installed = vars.dap.ensure_installed,
                handlers = {
                    function(config)
                        mdap.default_setup(config)
                    end,
                    python = function(config)
                        config.adapters = {
                            type = "executable",
                            command = getPythonPath(),
                            args = {
                                "-m",
                                "debugpy.adapter"
                            }
                        }
                        config.configurations = {
                            {
                                type = "python",
                                request = "launch",
                                name = "Launch Single File",
                                program = "${file}",
                                cwd = vim.fn.getcwd,
                                pythonPath = getPythonPath()
                            },
                            {
                                type = "python",
                                request = "launch",
                                name = "Launch Module",
                                module = function()
                                    return vim.fn.input("Path to module: ", vim.fn.getcwd() .. '/', 'file')
                                end,
                                cwd = vim.fn.getcwd,
                                pythonPath = getPythonPath()
                            }
                        }
                        mdap.default_setup(config)
                    end
                }
            }
        )

        -- Setup DAP UI.
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            vim.cmd("NvimTreeClose")
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
    end,
    keys = {
        {"<leader>db", function() require("dap").toggle_breakpoint() end, 'n', desc="Toggle breakpoint"},
        {
            "<leader>dl",
            function()
                require("dap").set_breakpoint(
                    nil,
                    nil,
                    vim.fn.input("Log point message: ")
                )
            end,
            'n',
            desc = "Set log point"
        },

        {"<leader>dc", function() require("dap").continue() end, 'n', desc="Start/Continue"},
        {"<leader>dso", function() require("dap").step_over() end, 'n', desc="Step over"},
        {"<leader>dsi", function() require("dap").step_into() end, 'n', desc="Step into"},

        {"<leader>dr", function() require("dap").repl_open() end, 'n', desc="Open REPL"},
        {"<leader>dC", function() require("dap").run_last() end, 'n', desc="Run last"},

        {"<leader>du", function() require("dapui").toggle() end, 'n', desc="Toggle DAP UI"},
        {"<Leader>dph", function() require('dap.ui.widgets').hover() end, {'n', 'v'}, desc="Show hover panel"},
        {"<Leader>dpp", function() require('dap.ui.widgets').preview() end, {'n', 'v'}, desc="Show preview panel"},
        {
            "<Leader>dpf",
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.frames)
            end,
            'n',
            desc = "Show frame panel"
        },
        {
            "<Leader>dps",
            function()
                local widgets = require('dap.ui.widgets')
                widgets.centered_float(widgets.scopes)
            end,
            'n',
            desc = "Show variable scope panel"
        }
    }
}
