return {
    "saghen/blink.cmp",
    opts = {
        signature = { enabled = true },
        sources = {
            -- adding any nvim-cmp sources here will enable them
            -- with blink.compat
            compat = {},
            default = { "lsp", "path", "snippets", "buffer" },
        },
    },
}
