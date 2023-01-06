local ufo = require("ufo")
local lspconfig = require("lspconfig")

return {
    setup = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        for _, language_server in ipairs(lspconfig) do
            lspconfig[language_server].setup({capabilities = capabilities})

        end

        ufo.setup()
    end
}
