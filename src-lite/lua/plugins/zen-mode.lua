return {
    "folke/zen-mode.nvim",

    enabled = true,
    opts = {},
    keys = {
        {
            "<leader>uz",
            function()
                require("zen-mode").toggle()
            end,
            "n",
            desc = "Toggle Zen Mode",
        },
    },
}
