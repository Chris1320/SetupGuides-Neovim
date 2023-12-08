return {
    "RaafatTurki/hex.nvim",

    enabled = true,
    keys = {
        {
            "<leader>ht",
            function()
                require("hex").toggle()
            end,
            "n",
            desc = "Toggle hex view mode",
        },
        {
            "<leader>hd",
            function()
                require("hex").dump()
            end,
            "n",
            desc = "Enter hex view mode",
        },
        {
            "<leader>ha",
            function()
                require("hex").assemble()
            end,
            "n",
            desc = "Exit hex view mode",
        },
    },
}
