return {
    "hrsh7th/nvim-cmp",

    enabled = true,
    lazy = false,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",                 -- nvim-cmp plugin for LSP integration
        "hrsh7th/cmp-nvim-lsp-signature-help",  -- nvim-cmp plugin for showing LSP function signatures
        "hrsh7th/cmp-buffer",                   -- nvim-cmp plugin for buffer suggestions
        "hrsh7th/cmp-path",                     -- nvim-cmp plugin for filesystem suggestions
        "hrsh7th/cmp-cmdline",                  -- nvim-cmp plugin for cmdline suggestions
        {
            "petertriho/cmp-git",               -- nvim-cmp plugin for git integration
            dependencies = "nvim-lua/plenary.nvim"
        },
        {
            "saadparwaiz1/cmp_luasnip",         -- LuaSnip integration for nvim-cmp
            dependencies = {"LuaSnip"}
        }
    },
    config = function()
        local cmp = require("cmp")
        local misc = require("misc")
        local luasnip = require("luasnip")

        -- Setup nvim-cmp
        cmp.setup(
            {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {  -- Set autocomplete sources.
                    {name = "nvim_lsp_signature_help"},
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
                    {name = "copilot.vim"}
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
                        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-j>'] = cmp.mapping.scroll_docs(4),
                        ['<CR>'] = cmp.mapping.confirm({select=false}), -- Accept currently selected item.
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
                        {name = "git"},
                        {name = "buffer"}
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

        require("cmp_git").setup(
            {
                filetypes = {"gitcommit"},
                git = {
                    commits = {
                        sort_by = require("cmp_git.sort").git.commits,
                        format = require("cmp_git.format").git.commits
                    }
                },
                github = {
                    issues = {
                        fields = {"title", "number", "body", "updatedAt", "state"},
                        filter = "all", -- assigned, created, mentioned, subscribed, all, repos
                        state = "open", -- open, closed, all
                        sort_by = require("cmp_git.sort").github.issues,
                        format = require("cmp_git.format").github.issues
                    },
                    mentions = {
                        sort_by = require("cmp_git.sort").github.mentions,
                        format = require("cmp_git.format").github.mentions
                    },
                    pull_requests = {
                        fields = {"title", "number", "body", "updatedAt", "state"},
                        state = "open", -- open, closed, merged, all
                        sort_by = require("cmp_git.sort").github.pull_requests,
                        format = require("cmp_git.format").github.pull_requests
                    }
                },
                gitlab = {
                    issues = {
                        state = "opened", -- opened, closed, all
                        sort_by = require("cmp_git.sort").gitlab.issues,
                        format = require("cmp_git.format").gitlab.issues
                    },
                    mentions = {
                        sort_by = require("cmp_git.sort").gitlab.mentions,
                        format = require("cmp_git.format").gitlab.mentions
                    },
                    pull_requests = {
                        state = "opened", -- opened, closed, locked, merged
                        sort_by = require("cmp_git.sort").gitlab.merge_requests,
                        format = require("cmp_git.format").gitlab.merge_requests
                    }
                }
            }
        )
    end
}
