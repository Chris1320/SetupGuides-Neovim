--[[
-- This file is responsible for setting up multiple plugins:
-- - mason.nvim
-- - mason-lspconfig
-- - lspconfig
-- - nvim_cmp
--
-- I don't think I can separate the setup for those plugins
-- because they work closely together.
--]]

local misc = require("core.utils.misc")

-- LSP Servers
local mason = require("mason")
local mlsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")

-- Autocomplete
local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local cmp_git = require("cmp_git")

-- Snippets
local luasnip = require("luasnip")

local function setupLspconfig()
    -- Setup mason
    mason.setup(
        {
            ui = {
                check_outdated_packages_on_open = true,
                icons = {
                    -- you can change these icons to whatever you want.
                    package_installed = "✓",
                    server_pending = "➜",
                    server_uninstalled = "✗"
                }
            }
        }
    )

    -- Setup mason-lspconfig
    mlsp.setup()

    -- Append client capabilities to default configuration.
    local lsp_default_conf = lspconfig.util.default_config
    lsp_default_conf.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_default_conf.capabilities,
        cmp_nvim_lsp.default_capabilities()
    )
    lsp_default_conf.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    -- Setup nvim-cmp
    cmp.setup(
        {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            sources = {  -- Set autocomplete sources.
                {
                    name = "nvim_lsp",  -- Use LSPs as source.
                    option = {
                        keyword_length = 1
                    }
                },
                {
                    name = "luasnip",  -- Use LuaSnip as source.
                    option = {
                        keyword_length = 1,
                        show_autosnippets = true,
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end
                    }
                },
                {
                    name = "buffer",  -- Use the current buffer as source.
                    option = {
                        keyword_length = 1
                    }
                },
                {
                    name = "path",  -- Show filesystem paths as autocomplete suggestions.
                    option = {
                        keyword_length = 1
                    }
                },
                {name="nvim_lsp_signature_help"},
                {name="calc"}
            },
            mapping = cmp.mapping.preset.insert(
                {
                    ["<ESC>"] = cmp.mapping.abort(),  -- Close cmp panel.
                    ["TAB"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then  -- Select next item if cmp panel is visible.
                                cmp.select_next_item()

                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()

                            elseif misc.hasWordsBefore() then
                                cmp.complete()

                            else
                                fallback()
                            end
                        end,
                        {"i", "s"}
                    ),
                    ["S-Tab"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then  -- Select previous item if cmp panel is visible.
                                cmp.select_prev_item()

                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)

                            else
                                fallback()
                            end
                        end,
                        {"i", "s"}
                    ),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({select=true}), -- Accept currently selected item.
                }
            ),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            }
        }
    )

    cmp.setup.filetype(
        "gitcommit",
        {
            sources = cmp.config.sources(
                {
                    {name="cmp_git"},
                    {name="buffer"}
                }
            )
        }
    )

    cmp.setup.cmdline(  -- Show suggestions from buffer when searching.
        {'/', '?'},
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources{
                {name = "buffer"}
            }
        }
    )

    cmp.setup.cmdline(
        ':',
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources{
                {name = "path"},
                {name = "cmdline"}
            }
        }
    )

    cmp_git.setup()

    -- setup automatic server handling
    mlsp.setup_handlers(
        {
            function(server_name)  -- the default handler
                lspconfig[server_name].setup({capabilities=lsp_default_conf})
            end,
            ["sumneko_lua"] = function()  -- Custom handler for sumneko_lua LSP
                lspconfig["sumneko_lua"].setup(
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

return {
    setup = setupLspconfig
}
