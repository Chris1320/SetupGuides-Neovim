return {
    "kevinhwang91/nvim-ufo",

    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
    keys = {
        {
            "zR",
            function()
                require("ufo").openAllFolds()
            end,
            "n",
        },
        {
            "zM",
            function()
                require("ufo").closeAllFolds()
            end,
            "n",
        },
    },
}
