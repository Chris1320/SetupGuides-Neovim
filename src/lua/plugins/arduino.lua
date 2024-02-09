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
        vim.g.arduino_serial_cmd = "tio --timestamp --baudrate {baud} {port}"
    end,
    keys = {
        { "<leader>ai", "<cmd>ArduinoInfo<cr>", "n", desc = "Display internal information" },
        { "<leader>as", "<cmd>ArduinoSerial<cr>", "n", desc = "Connect to the board over a serial port" },

        { "<leader>av", "<cmd>ArduinoVerify<cr>", "n", desc = "Build the sketch" },
        { "<leader>au", "<cmd>ArduinoUpload<cr>", "n", desc = "Build and upload the sketch" },
        { "<leader>aU", "<cmd>ArduinoUploadAndSerial<cr>", "n", desc = "Build, upload, and connect" },

        { "<leader>aa", "<cmd>ArduinoAttach<cr>", "n", desc = "Automatically attach to board" },
        { "<leader>ab", "<cmd>ArduinoChooseBoard<cr>", "n", desc = "Select the type of board" },
        { "<leader>ap", "<cmd>ArduinoChoosePort<cr>", "n", desc = "Select the serial port" },
        { "<leader>aP", "<cmd>ArduinoChooseProgrammer<cr>", "n", desc = "Select the programmer" },
    },
}
