return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-cmdline",
        {
            "petertriho/cmp-git",
            dependencies = "nvim-lua/plenary.nvim",
        },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        local cmp = require("cmp")
        local cmp_git_sort = require("cmp_git.sort")
        local cmp_git_format = require("cmp_git.format")
        local lazyvim_cmp = require("lazyvim.util.cmp")

        local function setSourceGroupIndex(sources)
            for _, source in ipairs(sources) do
                source.group_index = source.group_index or 1
            end
        end

        local extra_opts = {
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

        -- Override cmp mappings.
        opts.mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-k>"] = cmp.mapping.scroll_docs(-4),
            ["<C-j>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = lazyvim_cmp.confirm({ select = false }),
            ["<S-CR>"] = lazyvim_cmp.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ["<C-CR>"] = function(fallback)
                cmp.abort()
                fallback()
            end,
        })

        -- Show suggestions from buffer when searching and entering commands.
        setSourceGroupIndex(extra_opts.search.sources)
        setSourceGroupIndex(extra_opts.command.sources)
        cmp.setup.cmdline({ "/", "?" }, extra_opts.search)
        cmp.setup.cmdline(":", extra_opts.command)

        -- Show suggestions from Git, GitHub, and GitLab when editing gitcommit
        setSourceGroupIndex(extra_opts.git)
        cmp.setup.filetype("gitcommit", extra_opts.git)
        require("cmp_git").setup(extra_opts.cmp_git)
    end,
}
