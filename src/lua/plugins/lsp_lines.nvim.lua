return {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
            "<leader>uv",
            function()
                local new_virtual_text
                local new_virtual_lines
                local diag = vim.diagnostic

                ---@diagnostic disable-next-line: undefined-field
                if type(diag.config().virtual_lines) == "table" then
                    new_virtual_text = true
                    new_virtual_lines = false
                else
                    new_virtual_text = false
                    new_virtual_lines = { only_current_line = true }
                end

                diag.config({
                    virtual_text = new_virtual_text,
                    virtual_lines = new_virtual_lines,
                })
            end,
            "n",
            desc = "Toggle LSP virtual lines",
        },
    },
}
