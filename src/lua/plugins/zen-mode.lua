return {
    "folke/zen-mode.nvim",

    enabled = true,
    opts = {
        plugins = {
            options = { enabled = true },
            twilight = { enabled = true },
            gitsigns = { enabled = false },
            tmux = { enabled = true },
        },
    },
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
