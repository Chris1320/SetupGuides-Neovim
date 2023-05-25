local lsp_lines = require("lsp_lines")

return {
    setup = function()
        lsp_lines.setup()
        vim.diagnostic.config(
            {
                virtual_text = false,
                virtual_lines = true
            }
        )
    end
}
