return {
    "folke/todo-comments.nvim",

    enabled = true,
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { search = { pattern = [[ \b(KEYWORDS):]] } },
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            "n",
            desc = "Next todo comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            "n",
            desc = "Previous todo comment",
        },
        {
            "<leader>ewt",
            function()
                require("misc").checkPluginThenRun("trouble.nvim", function()
                    vim.cmd("TroubleToggle todo")
                end, function()
                    vim.cmd("TodoQuickFix")
                end)
            end,
            "n",
            desc = "Toggle todo list",
        },
    },
}
