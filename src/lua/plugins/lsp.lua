return {
    -- Set up lsp-zero
    {
        "VonHeikemen/lsp-zero.nvim",

        enabled = true,
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing
            -- it manually in the LSP section.
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },

    -- Set up mason.nvim
    {
        "williamboman/mason.nvim",

        enabled = true,
        lazy = false,
        build = ":MasonUpdate",
        opts = {
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
    },

    -- Set up nvim-cmp
    {
        "hrsh7th/nvim-cmp",

        enabled = true,
        lazy = false,
        -- event = "InsertEnter",
        dependencies = {
            -- Sources
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-cmdline"},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {
                "petertriho/cmp-git",
                dependencies = "nvim-lua/plenary.nvim"
            },
            {"github/copilot.vim"},

            -- Snippets
            {"L3MON4D3/LuaSnip"},
            {"rafamadriz/friendly-snippets"},
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_action = lsp_zero.cmp_action()

            -- Load LuaSnip snippets.
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup(
                {
                    formatting = lsp_zero.cmp_format(),
                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<C-Space>"] = cmp.mapping.complete(),
                            ["<Tab>"] = cmp.mapping.select_next_item(),
                            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                            ["<CR>"] = cmp.mapping.confirm(
                                {
                                    behavior = cmp.ConfirmBehavior.Replace,
                                    select = true
                                }
                            ),
                            ["<C-c>"] = cmp.mapping.abort(),

                            ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                            ["<C-j>"] = cmp.mapping.scroll_docs(4),
                            ["<C-l>"] = cmp_action.luasnip_jump_forward(),
                            ["<C-h>"] = cmp_action.luasnip_jump_backward(),
                        }
                    ),
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end
                    },
                    sources = {
                        {name="nvim_lsp", option={keyword_length=2}},
                        {name="luasnip", option={keyword_length=3}},
                        {name="buffer", option={keyword_length=2}},
                        {name="path", option={keyword_length=3}},
                        {name="copilot.vim"}
                    },
                    window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered()
                    }
                }
            )

            -- Show suggestions from buffer when searching and entering commands.
            cmp.setup.cmdline(
                {'/', '?'},
                {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({{name="buffer"}})
                }
            )
            cmp.setup.cmdline(
                ':',
                {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources(
                        {{name="path"}, {name="cmdline"}}
                    )
                }
            )

            cmp.setup.filetype(
                "gitcommit",
                {
                    sources = cmp.config.sources(
                        {{name="git"}, {name="buffer"}}
                    )
                }
            )

            -- Set up cmp-git for gitcommit buffers.
            local cmp_git_sort = require("cmp_git.sort")
            local cmp_git_format = require("cmp_git.format")
            require("cmp_git").setup(
                {
                    filetypes = {"gitcommit"},
                    git = {
                        commits = {
                            sort_by = cmp_git_sort.git.commits,
                            format = cmp_git_format.git.commits
                        }
                    },
                    github = {
                        issues = {
                            fields = {
                                "title",
                                "number",
                                "body",
                                "updatedAt",
                                "state"
                            },
                            filter = "all",
                            state = "open",
                            sort_by = cmp_git_sort.github.issues,
                            format = cmp_git_format.github.issues
                        },
                        mentions = {
                            sort_by = cmp_git_sort.github.mentions,
                            format = cmp_git_format.github.mentions
                        },
                        pull_requests = {
                            fields = {
                                "title",
                                "number",
                                "body",
                                "updatedAt",
                                "state"
                            },
                            state = "open", -- open, closed, merged, all
                            sort_by = cmp_git_sort.github.pull_requests,
                            format = cmp_git_format.github.pull_requests
                        }
                    },
                    gitlab = {
                        issues = {
                            state = "opened", -- opened, closed, all
                            sort_by = cmp_git_sort.gitlab.issues,
                            format = cmp_git_format.gitlab.issues
                        },
                        mentions = {
                            sort_by = cmp_git_sort.gitlab.mentions,
                            format = cmp_git_format.gitlab.mentions
                        },
                        pull_requests = {
                            state = "opened", -- opened, closed, locked, merged
                            sort_by = cmp_git_sort.gitlab.merge_requests,
                            format = cmp_git_format.gitlab.merge_requests
                        }
                    }
                }
            )
        end
    },

    -- Set up LSP
    {
        "neovim/nvim-lspconfig",
        cmd = {"LspInfo", "LspInstall", "LspStart"},
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            local misc = require("misc")
            local lspconfig = require("lspconfig")
            local lsp_zero = require("lsp-zero")
            local mlsp = require("mason-lspconfig")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(
                function(_, bufnr)
                    lsp_zero.default_keymaps({buffer = bufnr})
                end
            )

            -- Append client capabilities to default configuration.
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )
            -- Tell LSP servers the capability of foldingRange
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            mlsp.setup(
                {
                    ensure_installed = misc.getEnsureInstalledLSPServers(),
                    handlers = {
                        -- lsp_zero.default_setup,
                        function(name)
                            require("lsp-zero.server").setup(
                                name,
                                {capabilities=capabilities}
                            )
                        end,
                        lua_ls = function()
                            local overrides = {
                                capabilities = capabilities,
                                settings = {
                                    Lua = {
                                        telemetry = {enable=false},
                                        workspace = {checkThirdParty=false}
                                    }
                                }
                            }

                            lspconfig.lua_ls.setup(
                                vim.tbl_deep_extend(
                                    "force",
                                    lsp_zero.nvim_lua_ls(),
                                    overrides
                                )
                            )
                        end
                    }
                }
            )
        end
    }
}
