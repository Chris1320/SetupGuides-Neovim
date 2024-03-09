return {
    "hrsh7th/nvim-cmp",

    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        -- Sources
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        {
            "petertriho/cmp-git",
            dependencies = "nvim-lua/plenary.nvim",
        },
        -- Snippets
        "L3MON4D3/LuaSnip",
        {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

        local cmp = require("cmp")
        local cmp_defaults = require("cmp.config.default")()
        local luasnip = require("luasnip")
        local cmp_git_sort = require("cmp_git.sort")
        local cmp_git_format = require("cmp_git.format")

        return {
            cmp = {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer", option = { keyword_length = 2 } },
                    { name = "path" },
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("lazyvim.config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sorting = cmp_defaults.sorting,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
            },
            search = {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "buffer" } }),
            },
            command = {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            },
            git = {
                sources = cmp.config.sources({
                    { name = "git" },
                    { name = "luasnip" },
                    { name = "buffer" },
                }),
            },
            cmp_git = {
                filetypes = { "gitcommit" },
                git = {
                    commits = {
                        sort_by = cmp_git_sort.git.commits,
                        format = cmp_git_format.git.commits,
                    },
                },
                github = {
                    issues = {
                        fields = {
                            "title",
                            "number",
                            "body",
                            "updatedAt",
                            "state",
                        },
                        filter = "all",
                        state = "open",
                        sort_by = cmp_git_sort.github.issues,
                        format = cmp_git_format.github.issues,
                    },
                    mentions = {
                        sort_by = cmp_git_sort.github.mentions,
                        format = cmp_git_format.github.mentions,
                    },
                    pull_requests = {
                        fields = {
                            "title",
                            "number",
                            "body",
                            "updatedAt",
                            "state",
                        },
                        state = "open", -- open, closed, merged, all
                        sort_by = cmp_git_sort.github.pull_requests,
                        format = cmp_git_format.github.pull_requests,
                    },
                },
                gitlab = {
                    issues = {
                        state = "opened", -- opened, closed, all
                        sort_by = cmp_git_sort.gitlab.issues,
                        format = cmp_git_format.gitlab.issues,
                    },
                    mentions = {
                        sort_by = cmp_git_sort.gitlab.mentions,
                        format = cmp_git_format.gitlab.mentions,
                    },
                    pull_requests = {
                        state = "opened", -- opened, closed, locked, merged
                        sort_by = cmp_git_sort.gitlab.merge_requests,
                        format = cmp_git_format.gitlab.merge_requests,
                    },
                },
            },
        }
    end,
    ---@param opts table<string, cmp.ConfigSchema>
    config = function(_, opts)
        local cmp = require("cmp")

        local function setSourceGroupIndex(sources)
            for _, source in ipairs(sources) do
                source.group_index = source.group_index or 1
            end
        end

        -- Set up cmp itself
        setSourceGroupIndex(opts.cmp.sources)
        cmp.setup(opts.cmp)

        -- Show suggestions from buffer when searching and entering commands.
        setSourceGroupIndex(opts.search.sources)
        setSourceGroupIndex(opts.command.sources)
        cmp.setup.cmdline({ "/", "?" }, opts.search)
        cmp.setup.cmdline(":", opts.command)

        -- Show suggestions from Git, GitHub, and GitLab when editing gitcommit
        setSourceGroupIndex(opts.git)
        cmp.setup.filetype("gitcommit", opts.git)
        require("cmp_git").setup(opts.cmp_git)
    end,
}
