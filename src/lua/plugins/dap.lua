return {
    "mfussenegger/nvim-dap",

    enabled = true,
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "rcarriga/nvim-dap-ui",
        {
            "theHamsta/nvim-dap-virtual-text",
            enabled = true,
            opts = {}
        }
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
    end
}
