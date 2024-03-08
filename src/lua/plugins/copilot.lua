return {
    "zbirenbaum/copilot.lua",

    enabled = true,
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    build = function()
        vim.notify("Please run `:Copilot auth` to complete the setup process.", vim.log.levels.INFO)
    end,
    opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
    end,
}
