return {
    "folke/zen-mode.nvim",

    enabled = true,
    opts = {},
    keys = {
        {
            "<leader>z",
            function()
                require("zen-mode").toggle()
            end,
            "n",
            desc = "Toggle Zen mode",
        },
    },
}
