-- Q: Why stevearc/vim-arduino instead of glebzlat/Arduino.nvim?
-- A: vim-arduino looks more complete than Arduino.nvim.

return {
    "stevearc/vim-arduino",

    enabled = true,
    cmd = {
        "ArduinoAttach",
        "ArduinoChooseBoard",
        "ArduinoChooseProgrammer",
        "ArduinoChoosePort",
        "ArduinoVerify",
        "ArduinoUpload",
        "ArduinoSerial",
        "ArduinoUploadAndSerial",
        "ArduinoInfo",
    },
    ft = { "arduino", "tpp" },
    init = function()
        -- Prefer tio, then fallback to picocom or screen
        vim.g.arduino_serial_cmd = "tio --timestamp --baudrate {baud} {port}"
            .. " || picocom {port} -b {baud} -l"
            .. " || screen {port} {baud}"

        local wk_ok, wk = pcall(require, "which-key")
        if wk_ok then
            wk.add({ "<leader>dA", group = "arduino" })
        end
    end,
    keys = {
        { "<leader>dAi", "<cmd>ArduinoInfo<cr>", "n", desc = "Internal Information" },
        { "<leader>dAs", "<cmd>ArduinoSerial<cr>", "n", desc = "Connect to Board over Serial Port" },

        { "<leader>dAv", "<cmd>ArduinoVerify<cr>", "n", desc = "Build Sketch" },
        { "<leader>dAu", "<cmd>ArduinoUpload<cr>", "n", desc = "Build and Upload Sketch" },
        { "<leader>dAU", "<cmd>ArduinoUploadAndSerial<cr>", "n", desc = "Build, Upload, and Connect" },

        { "<leader>dAa", "<cmd>ArduinoAttach<cr>", "n", desc = "Automatically Attach to Board" },
        { "<leader>dAb", "<cmd>ArduinoChooseBoard<cr>", "n", desc = "Select Board Type" },
        { "<leader>dAp", "<cmd>ArduinoChoosePort<cr>", "n", desc = "Select Serial Port" },
        { "<leader>dAP", "<cmd>ArduinoChooseProgrammer<cr>", "n", desc = "Select Programmer" },
    },
}
