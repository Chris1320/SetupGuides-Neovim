return {
    "folke/which-key.nvim",

    name = "which-key",
    enabled = true,

    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {}
}
