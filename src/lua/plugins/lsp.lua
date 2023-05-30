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
        local vars = require("vars")

        -- Setup mason-lspconfig
        mlsp.setup(
            {
                automatic_installation = vars.lsp.auto_install,
                ensure_installed = vars.lsp.ensure_installed
            }
        )

        -- Append client capabilities to default configuration.
        local lsp_default_conf = lspconfig.util.default_config
        lsp_default_conf.capabilities = vim.tbl_deep_extend(
            "force",
            lsp_default_conf.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )
        lsp_default_conf.capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        -- setup automatic server handling
        mlsp.setup_handlers(
            {
                function(server_name)  -- the default handler
                    lspconfig[server_name].setup({capabilities=lsp_default_conf})
                end,
                ["lua_ls"] = function()  -- Custom handler for sumneko_lua LSP
                    lspconfig["lua_ls"].setup(
                        {
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
                            },
                            capabilities = lsp_default_conf
                        }
                    )
                end,
                ["bashls"] = function()  -- Custom handler for bashls LSP
                    lspconfig["bashls"].setup(
                        {
                            bashIde = {
                                highlightParsingErrors = true
                            }
                        }
                    )
                end,
                ["clangd"] = function()  -- Custom handler for clangd LSP
                    local clangd_capabilities = lsp_default_conf.capabilities
                    clangd_capabilities.offsetEncoding = {"utf-16"}  -- Context: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                    lspconfig["clangd"].setup({capabilities=clangd_capabilities})
                end,
                ["html"] = function()  -- Custom handler for html LSP
                    lspconfig["html"].setup(
                        {
                            html = {
                                format = {
                                    templating = true
                                },
                                mirrorCursorOnMatchingTag = true
                            }
                        }
                    )
                end,
                ["omnisharp"] = function()  -- Custom handler for omnisharp LSP
                    lspconfig["omnisharp"].setup(
                        {
                            root_dir = function(filename, _)
                                local root

                                root = lspconfig.util.find_git_ancestor(filename)
                                root = root or lspconfig.util.root_pattern(".sln")
                                root = root or lspconfig.util.root_pattern(".csproj")
                                root = root or '.'

                                return root
                            end
                        }
                    )
                end,
                ["omnisharp_mono"] = function()  -- Custom handler for omnisharp LSP (mono version)
                    lspconfig["omnisharp_mono"].setup(
                        {
                            root_dir = function(filename, _)
                                local root

                                root = lspconfig.util.find_git_ancestor(filename)
                                root = root or lspconfig.util.root_pattern(".sln")
                                root = root or lspconfig.util.root_pattern(".csproj")
                                root = root or '.'

                                return root
                            end
                        }
                    )
                end,
                ["pyright"] = function()  -- Custom handler for pyright LSP
                    lspconfig["pyright"].setup(
                        {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    diagnosticMode = "workspace",
                                    useLibraryCodeForTypes = true
                                }
                            }
                        }
                    )
                end,
                ["yamlls"] = function()  -- Custom handler for yamlls LSP
                    lspconfig["yamlls"].setup(
                        {
                            redhat = {
                                telemetry = {
                                    enabled = false
                                }
                            }
                        }
                    )
                end
            }
        )
    end
}
