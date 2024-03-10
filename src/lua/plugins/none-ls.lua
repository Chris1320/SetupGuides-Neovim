return {
    "nvimtools/none-ls.nvim",

    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        sources = {
            require("null-ls").builtins.formatting.black,
            require("null-ls").builtins.formatting.clang_format,
            require("null-ls").builtins.formatting.csharpier,
            require("null-ls").builtins.formatting.isort,
            require("null-ls").builtins.formatting.prettierd,
            require("null-ls").builtins.formatting.shfmt,
            require("null-ls").builtins.formatting.stylua,

            require("null-ls").builtins.diagnostics.markdownlint,
        },
    },
}
