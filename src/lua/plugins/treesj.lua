return {
    "Wansmer/treesj",

    enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        use_default_keymaps = false,
    },
    config = function(_, opts)
        require("treesj").setup(opts)
    end,
    keys = {
        {
            "<leader>j",
            function()
                require("treesj").toggle()
            end,
            "n",
            desc = "Split/Join node",
        },
    },
}
