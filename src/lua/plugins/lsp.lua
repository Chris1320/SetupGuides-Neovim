return {
    "neovim/nvim-lspconfig",

    enabled = true,
    event = "LazyFile",
    dependencies = {
        {
            "folke/neoconf.nvim",
            cmd = "Neoconf",
            config = false,
            dependencies = { "nvim-lspconfig" },
        },
        {
            "folke/neodev.nvim",
            opts = {},
        },
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- "hrsh7th/cmp-nvim-lsp",
        -- "hrsh7th/cmp-nvim-lua",

        -- Additional features for C# development
        "Hoffs/omnisharp-extended-lsp.nvim",

        -- -- Additional features for Java development
        "mfussenegger/nvim-jdtls",
    },
    ---@class PluginLspOpts
    opts = function()
        local lspconfig = require("lspconfig")
        local lsp_defaults = lspconfig.util.default_config
        local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local nvim_cmp_capabilities = has_cmp_nvim_lsp == true and cmp_nvim_lsp.default_capabilities() or {}
        lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, nvim_cmp_capabilities)

        return {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    -- prefix = "?",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "?" when not supported
                    prefix = "icons",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
                        [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
                        [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
                    },
                },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = { enabled = true },
            -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the code lenses.
            codelens = { enabled = true },
            -- add any global capabilities here
            capabilities = lsp_defaults.capabilities,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = { ---@diagnostic disable-line: missing-fields
                bashls = { ---@diagnostic disable-line: missing-fields
                    filetypes = { "sh", "bash" },
                    single_file_support = true,
                },
                -- NOTE: These are set by the clangd extra from LazyVim
                clangd = { ---@diagnostic disable-line: missing-fields
                    keys = {
                        {
                            "<leader>cR",
                            "<cmd>ClangdSwitchSourceHeader<cr>",
                            desc = "Switch Source/Header (C/C++)",
                        },
                    },
                    capabilities = {
                        -- Manually set the offsetEncoding capability to utf-16.
                        -- Context:
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                        offsetEncoding = { "utf-16" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            "meson.build",
                            "meson_options.txt",
                            "build.ninja"
                        )(fname) or require("lspconfig.util").root_pattern(
                            "compile_commands.json",
                            "compile_flags.txt"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
                -- NOTE: These are set by the java extra from LazyVim
                jdtls = {}, ---@diagnostic disable-line: missing-fields
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    -- Use this to add any additional keymaps
                    -- for specific lsp servers
                    ---@type LazyKeysSpec[]
                    -- keys = {},
                    settings = {
                        Lua = {
                            -- runtime = {
                            --     version = "LuaJIT",
                            --     path = vim.tbl_deep_extend(
                            --         "force",
                            --         vim.split(package.path, ";"),
                            --         { "lua/?.lua", "lua/?/init.lua" }
                            --     ),
                            -- },
                            workspace = { checkThirdParty = false },
                            codeLens = { enable = true },
                            completion = { callSnippet = "Replace" },
                            telemetry = { enable = false },
                        },
                    },
                },
                omnisharp = { ---@diagnostic disable-line: missing-fields
                    cmd = {
                        vim.fn.has("win32") == 1 and "OmniSharp.exe" or "omnisharp",
                        "--languageserver",
                        "--hostPID",
                        tostring(vim.fn.getpid()),
                    },
                    handlers = {
                        ["textDocument/definition"] = require("omnisharp_extended").handler,
                    },
                    -- configuration options for omnisharp:
                    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
                    enable_editorconfig_support = true,
                    enable_roslyn_analyzers = true,
                    organize_imports_on_format = true,
                    enable_import_completion = true,
                },
                pyright = {
                    single_file_support = true,
                    settings = { ---@diagnostic disable-line: missing-fields
                        python = { ---@diagnostic disable-line: missing-fields
                            analysis = { ---@diagnostic disable-line: missing-fields
                                autoImportCompletions = true,
                                autoSearchPaths = true,
                                diagnosticMode = "workspace",
                                diagnosticSeverityOverrides = { ---@diagnostic disable-line: missing-fields
                                    reportDeprecated = "warning",
                                    reportImplicitOverride = "information",
                                    reportShadowedImports = "information",
                                    reportUninitializedInstanceVariable = "information",
                                    reportUnnecessaryTypeIgnoreComment = "information",
                                },
                                -- Add the virtual environment.
                                extraPaths = (
                                    vim.fn.getenv("VIRTUAL_ENV") ~= vim.NIL
                                    and { vim.fn.getenv("VIRTUAL_ENV") .. "/lib/python3.11/site-packages" }
                                ) or {},
                                typeCheckingMode = "strict",
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
                jdtls = function(_, _)
                    return true
                end,
            },
        }
    end,
}
