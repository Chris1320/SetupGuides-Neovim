--- Set the keybindings for LSP-specific actions.
--- This function is to be used on the LSPs'
--- `on_attach` hooks.
--- @param overrides? table The overrides to apply to the default keybindings.
local function addLspKeybindings(overrides)
    local default_keybindings = {
        { "n", "K", vim.lsp.buf.hover, { desc = "Show symbol information" } },
        { "n", "gD", vim.lsp.buf.declaration, { desc = "Show symbol declaration" } },
        { "n", "gs", vim.lsp.buf.signature_help, { desc = "Show symbol signature" } },
        { "n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" } },
        { "n", "<F4>", vim.lsp.buf.code_action, { desc = "Show code actions" } },
        { "n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" } },
        { "n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" } },
        {
            "n",
            "gd",
            function()
                require("misc").checkPluginThenRun("telescope.nvim", function()
                    require("telescope.builtin").lsp_definitions(
                        require("telescope.themes").get_cursor({ previewer = false })
                    )
                end, vim.lsp.buf.definition)
            end,
            { desc = "Show symbol definition" },
        },
        {
            "n",
            "gi",
            function()
                require("misc").checkPluginThenRun("telescope.nvim", function()
                    require("telescope.builtin").lsp_implementations()
                end, vim.lsp.buf.implementation)
            end,
            { desc = "Show symbol implementation" },
        },
        {
            "n",
            "go",
            function()
                require("misc").checkPluginThenRun("telescope.nvim", function()
                    require("telescope.builtin").lsp_type_definitions()
                end, vim.lsp.buf.type_definition)
            end,
            { desc = "Show symbol type definition" },
        },
        {
            "n",
            "gr",
            function()
                require("misc").checkPluginThenRun("telescope.nvim", function()
                    require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy())
                end, vim.lsp.buf.references)
            end,
            { desc = "Show symbol references" },
        },
        {
            "n",
            "gl",
            function()
                require("misc").checkPluginThenRun("telescope.nvim", function()
                    require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown())
                end, vim.diagnostic.open_float)
            end,
            { desc = "Show diagnostics" },
        },
    }

    --- @param notify_desc string Correct the notification description message.
    local function formatFileOrSelection(notify_desc)
        local misc = require("misc")

        misc.checkPluginThenRun("conform.nvim", function()
            print(string.format("[conform.nvim] Formatting %s...", notify_desc))
            require("conform").format({ async = true, lsp_fallback = true })
        end, function()
            print(string.format("[LSP] Formatting %s...", notify_desc))
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
            PATH = "append",
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

    -- Set up mason-tool-installer.nvim
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        enabled = true,
        opts = {
            auto_update = false,
            run_on_start = true,
            start_delay = 3000,
        },
        config = function(_, opts)
            local ide_vars = require("vars").ide
            local tools = {}
            vim.list_extend(tools, ide_vars.lsp)
            vim.list_extend(tools, ide_vars.dap)
            vim.list_extend(tools, ide_vars.linters)
            vim.list_extend(tools, ide_vars.formatters)

            opts.ensure_installed = tools

            require("mason-tool-installer").setup(opts)
        end,
    },

    -- Set up nvim-cmp
    {
        "hrsh7th/nvim-cmp",

        enabled = true,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "onsails/lspkind.nvim" },

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
            local lspkind = require("lspkind")

            -- Load LuaSnip snippets.
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
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

            -- Additional features for C# development
            "Hoffs/omnisharp-extended-lsp.nvim",

            -- Additional features for Java development
            "mfussenegger/nvim-jdtls",
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
            mlsp.setup({ ensure_installed = require("vars").ide.lsp })
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
                            -- Context:
                            -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                            offsetEncoding = { "utf-16" },
                        },
                        cmd = {
                            "clangd",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                        },
                        root_dir = function()
                            return misc.detectProjectRoot({
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
                jdtls = function()
                    local landmarks = { "pom.xml", "build.xml", "mvnw", "gradlew", ".git" }
                    local config = {
                        cmd = {
                            "jdtls",
                            "-configuration",
                            vim.fn.getenv("HOME") .. "/.cache/jdtls/config",
                            "-data",
                            vim.fn.getenv("HOME")
                                .. "/.cache/jdtls/workspaces/"
                                .. vim.fn.fnamemodify(misc.detectProjectRoot(landmarks) or vim.fn.getcwd(), ":p:h:t"),
                        },
                        root_dir = vim.fs.dirname(vim.fs.find(landmarks, { upward = true })[1]),
                        capabilities = {
                            workspace = { configuration = true },
                            textDocument = { completion = { completionItem = { snippetSupport = true } } },
                        },

                        settings = {
                            java = {
                                completion = { enabled = true },
                                eclipse = { downloadSources = true },
                                format = {
                                    enabled = true,
                                    comments = { enabled = false },
                                    --[[ settings = {
                                        url = "...",
                                        profile = "...",
                                    }, ]]
                                },
                                implementationsCodeLens = { enabled = true },
                                rename = { enabled = true },
                                signatureHelp = { enabled = true, description = { enabled = true } },
                            },
                        },

                        -- TODO: Configure the Java Debug Adapter.
                        -- init_options = { bundles = {"java-debug"} },
                    }

                    -- jdtls.start_or_attach() needs to be called for every Java buffer.
                    vim.api.nvim_create_autocmd("FileType", {
                        pattern = "java",
                        callback = function()
                            require("jdtls").start_or_attach(vim.tbl_deep_extend("force", default_config, config))
                        end,
                    })
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
                omnisharp = function()
                    local pid = vim.fn.getpid()
                    local omnisharp_bin
                    if misc.isWindows() then
                        omnisharp_bin = "OmniSharp.exe"
                    else
                        omnisharp_bin = "omnisharp"
                    end

                    local overrides = {
                        cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
                        handlers = {
                            ["textDocument/definition"] = require("omnisharp_extended").handler,
                        },
                        -- enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                    }

                    lspconfig.omnisharp.setup(vim.tbl_deep_extend("force", default_config, overrides))
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
