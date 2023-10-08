return {
    "github/copilot.vim",

    enabled = require("vars").proprietary.copilot,
    build = function()
        vim.notify(
            "Please run `:Copilot setup` to complete the setup process.",
            vim.log.levels.INFO
        )
    end
}
