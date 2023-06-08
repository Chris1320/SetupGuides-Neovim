return {
    "neovim/nvim-lspconfig",

    enabled = true,
    lazy = false,
    -- Do not lazy load LSPs.
    -- Some servers fail to attach to buffers when we do that.
    -- event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- This part has a lot of stuff going on.
        local mlsp = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local lsp_vars = require("vars").lsp

        --- Detects the root project of the current buffer.
        -- This is used in omnisharp and omnisharp_mono LSPs.
        --
        -- @param filename The filename of the current buffer.
        -- @return The root project of the current buffer.
        local function detectRootProject(filename, _)
            local root

            root = lspconfig.util.find_git_ancestor(filename)
            root = root or lspconfig.util.root_pattern(".sln")
            root = root or lspconfig.util.root_pattern(".csproj")
            root = root or '.'

            return root
        end

        -- Setup mason-lspconfig
        mlsp.setup(
            {
                automatic_installation = lsp_vars.auto_install,
                ensure_installed = lsp_vars.ensure_installed
            }
        )

        -- Append client capabilities to default configuration.
        local lsp_capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )
        -- Tell LSP servers the capability of foldingRange
        lsp_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        -- setup automatic server handling
        mlsp.setup_handlers(
            {
                function(server_name)  -- the default handler
                    lspconfig[server_name].setup(
                        {capabilities=lsp_capabilities}
                    )
                end,
                ["bashls"] = function()  -- Custom handler for bashls LSP
                    lspconfig["bashls"].setup(
                        {
                            capabilities = lsp_capabilities,
                            filetypes = {"sh", "bash"},
                            single_file_support = true,
                            settings = {
                                bashIde = {
                                    highlightParsingErrors = true
                                }
                            }
                        }
                    )
                end,
                ["clangd"] = function()  -- Custom handler for clangd LSP
                    local clangd_capabilities = lsp_capabilities
                    -- Context: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                    clangd_capabilities.offsetEncoding = {"utf-16"}
                    lspconfig["clangd"].setup(
                        {
                            capabilities = clangd_capabilities,
                            single_file_support = true
                        }
                    )
                end,
                ["docker_compose_language_service"] = function()
                    lspconfig["docker_compose_language_service"].setup(
                        {
                            capabilities = lsp_capabilities,
                            single_file_support = true,
                            settings = {
                                telemetry = {
                                    enableTelemetry = false
                                }
                            }
                        }
                    )
                end,
                ["html"] = function()  -- Custom handler for html LSP
                    local html_capabilities = lsp_capabilities
                    html_capabilities.textDocument.completion
                        .completionItem.snippetSupport = true
                    lspconfig["html"].setup(
                        {
                            capabilities = html_capabilities,
                            init_options = {
                                provideFormatter = true
                            },
                            single_file_support = true,
                            settings = {
                                html = {
                                    format = {
                                        templating = true
                                    },
                                    mirrorCursorOnMatchingTag = true
                                }
                            }
                        }
                    )
                end,
                ["jdtls"] = function()
                    lspconfig["jdtls"].setup(
                        {
                            capabilities = lsp_capabilities,
                            single_file_support = true,
                            settings = {
                                redhat = {
                                    telemetry = {
                                        enabled = false
                                    }
                                }
                            }
                        }
                    )
                end,
                ["lua_ls"] = function()  -- Custom handler for sumneko_lua LSP
                    lspconfig["lua_ls"].setup(
                        {
                            capabilities = lsp_capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {"vim"}
                                    },
                                    telemetry = {
                                        enable = false
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false  -- Context: https://github.com/sumneko/lua-language-server/discussions/1688
                                    }
                                }
                            }
                        }
                    )
                end,
                ["omnisharp"] = function()  -- Custom handler for omnisharp LSP
                    local cs_capabilities = lsp_capabilities
                    cs_capabilities.semanticTokensProvider = nil

                    lspconfig["omnisharp"].setup(
                        {
                            capabilities = lsp_capabilities,
                            enable_editorconfig_support = true,
                            enable_roslyn_analyzers = true,
                            settings = {
                                root_dir = detectRootProject
                            }
                        }
                    )
                end,
                ["omnisharp_mono"] = function()  -- Custom handler for omnisharp LSP (mono version)
                    lspconfig["omnisharp_mono"].setup(
                        {capabilities = lsp_capabilities}
                    )
                end,
                ["pyright"] = function()  -- Custom handler for pyright LSP
                    lspconfig["pyright"].setup(
                        {
                            capabilities = lsp_capabilities,
                            single_file_support = true,
                            settings = {
                                python = {
                                    analysis = {
                                        typeCheckingMode = "basic",
                                        diagnosticMode = "workspace",
                                        useLibraryCodeForTypes = true
                                    }
                                }
                            }
                        }
                    )
                end,
                ["yamlls"] = function()  -- Custom handler for yamlls LSP
                    lspconfig["yamlls"].setup(
                        {
                            capabilities = lsp_capabilities,
                            single_file_support = true,
                            settings = {redhat={telemetry={enabled=false}}}
                        }
                    )
                end
            }
        )
    end
}
