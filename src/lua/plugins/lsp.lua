return {
    "neovim/nvim-lspconfig",

    opts = {
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = { enabled = false },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = { enabled = false },
        servers = {
            bashls = {
                filetypes = { "sh", "bash" },
                single_file_support = true,
            },
            lua_ls = { settings = { Lua = { telemetry = { enable = false } } } },
            omnisharp = {
                cmd = {
                    vim.fn.has("win32") == 1 and "OmniSharp.exe" or "omnisharp",
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                },
                enable_editorconfig_support = true,
            },
            pyright = {
                single_file_support = true,
                settings = {
                    python = {
                        analysis = {
                            autoImportCompletions = true,
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            diagnosticSeverityOverrides = {
                                reportDeprecated = "warning",
                                reportImplicitOverride = "information",
                                reportShadowedImports = "information",
                                reportUninitializedInstanceVariable = "information",
                                reportUnnecessaryTypeIgnoreComment = "information",
                            },
                            typeCheckingMode = "strict",
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            },
        },
    },
}
