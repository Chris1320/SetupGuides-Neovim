return {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

    enabled = true,
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config(
            {
                virtual_text = false,
                virtual_lines = true
            }
        )
    end,
    keys = {
        {
            "<leader>l",
            function()
                -- Toggle values of `virtual_text` and `virtual_lines`.
                vim.diagnostic.config(
                    {
                        virtual_text = not vim.diagnostic.config().virtual_text,
                        virtual_lines = not vim.diagnostic.config().virtual_lines
                    }
                )
            end,
            'n',
            desc = "Toggle LSP Lines"
        }
    }
}
