local mason = require("mason")
local mlsp = require("mason-lspconfig")
local lsp = require("lspconfig")
local coq = require("coq")

local function setupLspconfig()
    -- Setup mason
    mason.setup(
        {
            ui = {
                check_outdated_packages_on_open = true,
                icons = {
                    -- you can change these icons to whatever you want.
                    package_installed = "✓",
                    -- server_pending = "➜",
                    -- server_uninstalled = "✗"
                }
            }
        }
    )

    -- Setup mason-lspconfig
    mlsp.setup()

    -- Setup lspconfig
    lsp.bashls.setup(
        coq.lsp_ensure_capabilities(
            {
                bashIde = {
                    highlightParsingErrors = true
                }
            }
        )
    )

    lsp.clangd.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.cmake.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.cssls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.cssmodules_ls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.diagnosticls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.dockerls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.html.setup(
        coq.lsp_ensure_capabilities(
            {
                html = {
                    format = {
                        templating = true
                    },
                    mirrorCursorOnMatchingTag = true
                }
            }
        )
    )

    lsp.jdtls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.jsonls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.kotlin_language_server.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.lemminx.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.ltex.setup(
        coq.lsp_ensure_capabilities(
            {
                ltex = {
                    completionEnabled = true,
                    languageToolHttpServerUri = "",
                    languageToolOrg = {
                        apiKey = "",
                        username = ""
                    }
                }
            }
        )
    )

    lsp.sumneko_lua.setup(
        coq.lsp_ensure_capabilities(
            {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            }
        )
    )

    lsp.marksman.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.omnisharp.setup(
        coq.lsp_ensure_capabilities(
            {
                root_dir = function(filename, _)
                    local root

                    root = lsp.util.find_git_ancestor(filename)
                    root = root or lsp.util.root_pattern(".sln")
                    root = root or lsp.util.root_pattern(".csproj")
                    root = root or '.'

                    return root
                end
            }
        )
    )

    lsp.omnisharp_mono.setup(
        coq.lsp_ensure_capabilities(
            {
                root_dir = function(filename, _)
                    local root

                    root = lsp.util.find_git_ancestor(filename)
                    root = root or lsp.util.root_pattern(".sln")
                    root = root or lsp.util.root_pattern(".csproj")
                    root = root or '.'

                    return root
                end
            }
        )
    )

    lsp.perlnavigator.setup(
        coq.lsp_ensure_capabilities()
    )

    -- Python configurations
    lsp.pyright.setup(
        coq.lsp_ensure_capabilities(
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
    )

    lsp.rust_analyzer.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.sqlls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.tailwindcss.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.texlab.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.tsserver.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.vimls.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.yamlls.setup(
        coq.lsp_ensure_capabilities(
            {
                redhat = {
                    telemetry = {
                        enabled = false
                    }
                }
            }
        )
    )
end

return {
    setup = setupLspconfig
}
