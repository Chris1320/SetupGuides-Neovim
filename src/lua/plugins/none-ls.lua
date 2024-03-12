return {
    "nvimtools/none-ls.nvim",

    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local ok, nls = pcall(require, "null-ls")
        if not ok then
            vim.notify("Please restart Neovim to use none-ls.")
            return {}
        end

        return {
            sources = {
                nls.builtins.formatting.black,
                nls.builtins.formatting.clang_format,
                nls.builtins.formatting.csharpier,
                nls.builtins.formatting.isort,
                nls.builtins.formatting.prettierd,
                nls.builtins.formatting.shfmt,
                nls.builtins.formatting.stylua,

                nls.builtins.diagnostics.markdownlint,
            },
        }
    end,
}
