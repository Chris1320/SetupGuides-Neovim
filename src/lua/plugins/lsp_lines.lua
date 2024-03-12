return {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = { only_current_line = true },
        })
    end,
    keys = {
        {
            "<leader>uD",
            function()
                local new_virtual_lines

                local diag = vim.diagnostic
                local new_virtual_text = not diag.config().virtual_text
                if type(diag.config().virtual_lines) == "table" then
                    new_virtual_lines = false
                else
                    new_virtual_lines = { only_current_line = true }
                end

                diag.config({
                    virtual_text = new_virtual_text,
                    virtual_lines = new_virtual_lines,
                })
            end,
            "n",
            desc = "Toggle LSP Lines",
        },
    },
}
