return {
    "zbirenbaum/copilot.lua",

    enabled = require("vars").proprietary.copilot,
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    build = function()
        vim.notify("Please run `:Copilot auth` to complete the setup process.", vim.log.levels.INFO)
    end,
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
    end,
}
