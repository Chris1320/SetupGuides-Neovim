local function setupDap()

    --[[
    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch File",
            program = "${file}",
            pythonPath = function()
                return "/usr/bin/python3"
            end
        }
    }

    dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = {vars["mason_bin_path"] .. "pyright"}
    }
    ]]--

end

local function setupDapUI()
    local dap_ui = require("dapui")
    local dap = require("dap")

    dap_ui.setup()

    -- Automatically open and close DAP UI panel.
    dap.listeners.after.event_initialized["dapui_config"] = dap_ui.open
    dap.listeners.before.event_terminated["dapui_config"] = dap_ui.close
    dap.listeners.before.event_exited["dapui_config"] = dap_ui.close

end

return {
    setup = function()
        -- TODO
    end
}
