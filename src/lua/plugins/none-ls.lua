return {
    "nvimtools/none-ls.nvim",

    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = { sources = { require("null-ls").builtins.formatting.black } },
}
