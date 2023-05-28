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
    end
}
