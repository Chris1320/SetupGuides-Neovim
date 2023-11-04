--- Set the keybindings for LSP-specific actions.
--- This function is to be used on the LSPs'
--- `on_attach` hooks.
--- @param overrides? table The overrides to apply to the default keybindings.
local function addLspKeybindings(overrides)
    local default_keybindings = {
        { "n", "K", vim.lsp.buf.hover, { desc = "Show symbol information" } },
        { "n", "gd", vim.lsp.buf.definition, { desc = "Show symbol definition" } },
        { "n", "gD", vim.lsp.buf.declaration, { desc = "Show symbol declaration" } },
        { "n", "gi", vim.lsp.buf.implementation, { desc = "Show symbol implementation" } },
        { "n", "go", vim.lsp.buf.type_definition, { desc = "Show symbol type definition" } },
        { "n", "gr", vim.lsp.buf.references, { desc = "Show symbol references" } },
        { "n", "gs", vim.lsp.buf.signature_help, { desc = "Show symbol signature" } },
        { "n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" } },
        { "n", "<F4>", vim.lsp.buf.code_action, { desc = "Show code actions" } },
        { "n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" } },
        { "n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" } },
        { "n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" } },
    }

    --- @param notify_desc string Correct the notification description message.
    local function formatFileOrSelection(notify_desc)
        local misc = require("misc")

        misc.checkPluginThenRun("conform.nvim", function()
            vim.notify(string.format("Formatting %s...", notify_desc), vim.log.levels.INFO, { title = "conform.nvim" })
            require("conform").format({ async = true, lsp_fallback = true })
        end, function()
            vim.notify(string.format("Formatting %s...", notify_desc), vim.log.levels.INFO, { title = "LSP" })
            vim.lsp.buf.format({ async = true })
        end)
    end

    table.insert(default_keybindings, {
        "n",
        "<F3>",
        function()
            formatFileOrSelection("file")
        end,
        { desc = "Format file" },
    })
    table.insert(default_keybindings, {
        "x",
        "<F3>",
        function()
            formatFileOrSelection("selection")
        end,
        { desc = "Format selection" },
    })

    if vim.lsp.buf.range_code_action then
        table.insert(
            default_keybindings,
            { "x", "<F4>", vim.lsp.buf.range_code_action, { desc = "Show code actions" } }
        )
    else
        table.insert(default_keybindings, { "x", "<F4>", vim.lsp.buf.code_action, { desc = "Show code actions" } })
    end

    -- Add the default keybindings and then the overrides.
    for _, keybindings in ipairs({ default_keybindings, overrides }) do
        for _, keybinding in ipairs(keybindings) do
            vim.keymap.set(
                keybinding[1],
                keybinding[2],
                keybinding[3],
                vim.tbl_extend("force", { silent = true }, keybinding[4])
            )
        end
    end
end

return {
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
                    server_uninstalled = "✗",
                },
            },
        },
    },

    -- Set up nvim-cmp
    {
        "hrsh7th/nvim-cmp",

        enabled = true,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            -- Sources
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            {
                "petertriho/cmp-git",
                dependencies = "nvim-lua/plenary.nvim",
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
            },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local cmp = require("cmp")
            local misc = require("misc")
            local luasnip = require("luasnip")

            -- Load LuaSnip snippets.
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif misc.hasWordsBefore() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<C-c>"] = cmp.mapping.abort(),
                    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-j>"] = cmp.mapping.scroll_docs(4),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip", option = { keyword_length = 3 } },
                    { name = "buffer", option = { keyword_length = 2 } },
                    { name = "path", option = { keyword_length = 3 } },
                    { name = "copilot" },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            -- Show suggestions from buffer when
            -- searching and entering commands.
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "buffer" } }),
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({ { name = "git" }, { name = "buffer" } }),
            })

            -- Set up cmp-git for gitcommit buffers.
            local cmp_git_sort = require("cmp_git.sort")
            local cmp_git_format = require("cmp_git.format")
            require("cmp_git").setup({
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
            })
        end,
    },

    -- Set up LSP
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local misc = require("misc")
            local lspconfig = require("lspconfig")

            local lsp_defaults = lspconfig.util.default_config
            local nvim_ufo_capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            }

            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities(), -- Add nvim-cmp capabilities.
                nvim_ufo_capabilities -- Add nvim-ufo capabilities.
            )

            local default_config = {
                on_attach = addLspKeybindings,
                capabilities = lsp_defaults.capabilities,
            }

            local mlsp = require("mason-lspconfig")
            mlsp.setup({ ensure_installed = misc.getEnsureInstalledLSPServers() })
            mlsp.setup_handlers({
                -- the default handler
                function(server_name)
                    lspconfig[server_name].setup(default_config)
                end,
                bashls = function()
                    local overrides = {
                        filetypes = { "sh", "bash" },
                        single_file_support = true,
                        settings = {
                            bashIde = {
                                highlightParsingErrors = true,
                            },
                        },
                    }
                    lspconfig.bashls.setup(vim.tbl_deep_extend("force", default_config, overrides))
                end,
                clangd = function()
                    local overrides = {
                        capabilities = {
                            -- Manually set the offsetEncoding capability to utf-16.
                            -- Context: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                            offsetEncoding = { "utf-16" },
                        },
                        cmd = {
                            "clangd",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                        },
                        root_dir = function()
                            misc.detectRootProject({
                                "compile_commands.json",
                                "compile_flags.txt",
                                "configure.ac",
                                ".git",
                                ".clangd",
                                ".clang-tidy",
                                ".clang-format",
                            })
                        end,
                    }

                    lspconfig.clangd.setup(vim.tbl_deep_extend("force", default_config, overrides))
                end,
                lua_ls = function()
                    local runtime_path = vim.split(package.path, ";")
                    table.insert(runtime_path, "lua/?.lua")
                    table.insert(runtime_path, "lua/?/init.lua")

                    local overrides = {
                        settings = {
                            Lua = {
                                telemetry = { enable = false },
                                runtime = {
                                    version = "LuaJIT",
                                    path = runtime_path,
                                },
                                diagnostics = { globals = { "vim" } },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        -- Make the server aware of Neovim runtime files
                                        vim.fn.expand("$VIMRUNTIME/lua"),
                                        vim.fn.stdpath("config") .. "/lua",
                                    },
                                },
                            },
                        },
                    }

                    lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default_config, overrides))
                end,
                pyright = function()
                    local overrides = {
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
                                        reportIncompatibleMethodOverride = "warning",
                                        reportShadowedImports = "information",
                                        reportUninitializedInstanceVariable = "information",
                                        reportUnnecessaryTypeIgnoreComment = "information",
                                    },
                                    typeCheckingMode = "strict",
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    }
                    lspconfig.pyright.setup(vim.tbl_deep_extend("force", default_config, overrides))
                end,
            })
        end,
    },
}
