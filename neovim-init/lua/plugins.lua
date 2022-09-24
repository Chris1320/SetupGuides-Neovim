--[[
plugins.lua - This is part of a custom config file for Neovim v0.7.2+.

You can get it from:
https://github.com/SetupGuides/Neovim

This module initializes plugins to be used in Neovim.
]]--

local vars = require("vars")  -- Get variables.

local plugins_installed_path = io.open(vars["plugins_installed_path"], 'r')
if plugins_installed_path == nil then
    First_run = true

else
    if plugins_installed_path:read() == "true" then
        First_run = false

    else
        First_run = true

    end
end

Packer = require("packer")  -- Load Packer.

Packer.startup(
    function(use)
        -- Plugin Manager
        use("wbthomason/packer.nvim")                        -- The package manager that we are using.

        -- Linting and Syntax Checkers
        use("neovim/nvim-lspconfig")                         -- Quickstart configs for Neovim LSP.
        use("williamboman/mason.nvim")                       -- LSP, DAP, etc. Manager for Neovim.
        use("williamboman/mason-lspconfig.nvim")
        use("nvim-treesitter/nvim-treesitter")               -- Treesitter integration for Neovim
        use(                                                 -- diagnostics, quickfixes, etc.
            {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons"
            }
        )
        use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")  -- Show LSP diagnostics to a new line.

        -- Fuzzy Search
        use(                                                 -- Fuzzy finder
            {
                "nvim-telescope/telescope.nvim",
                requires = {{"nvim-lua/plenary.nvim"}}
            }
        )

        -- Visual plugins
        use(                                                 -- Catppuccin theme
            {
                "catppuccin/nvim",
                as = "catppuccin"
            }
        )
        use("lewis6991/gitsigns.nvim")                       -- Git Integration
        use("feline-nvim/feline.nvim")                       -- Customizable statusline
        use(                                                 -- Tabline plugin
            {
                "romgrk/barbar.nvim",
                requires = {{"kyazdani42/nvim-web-devicons"}}
            }
        )
        use("lukas-reineke/indent-blankline.nvim")           -- Indentation guides
        use(
            {
                "kevinhwang91/nvim-ufo",
                requires = {{"kevinhwang91/promise-async"}}
            }
        )
        use("folke/which-key.nvim")                          -- Displays possible key bindings
        use("folke/twilight.nvim")                           -- Dim inactive portions of the code

        -- Autocompletion
        use(                                                 -- The main autocompletion tool
            {
                "ms-jpq/coq_nvim",
                branch = "coq"
            }
        )
        use(                                                 -- coq autocompletion snippets
            {
                "ms-jpq/coq.artifacts",
                branch = "artifacts"
            }
        )
        use(                                                 -- coq 3rd-party sources
            {
                "ms-jpq/coq.thirdparty",
                branch = "3p"
            }
        )
        use("windwp/nvim-autopairs")                         -- Bracket auto-pairing
        use("windwp/nvim-ts-autotag")                        -- Auto-close/rename HTML tags

        -- File explorer
        use(
            {
                "kyazdani42/nvim-tree.lua",
                requires = {{"kyazdani42/nvim-web-devicons"}},
            }
        )
        if First_run == true then
            Packer.sync()
        end
    end
)

local function setupCatppuccin()
    local catppuccin = require("catppuccin")
    catppuccin.setup(
        {
            integrations = {
                barbar = true,
                bufferline = true,
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false
                },
                lsp_trouble = true,
                markdown = true,
                native_lsp = {
                    enabled = true
                },
                nvimtree = {
                    enabled = true,
                    show_root = true,
                    transparent_panel = true
                },
                telescope = true,
                treesitter = true,
                which_key = true
            }
        }
    )
    vim.g.catppuccin_flavour = vars["catppuccin_flavour"]  -- Set catppuccin variation
    vim.cmd("colorscheme catppuccin")                   -- Set theme
end

local function setupFeline()
    local feline = require("feline")
    local catppuccin_integration = require("catppuccin.groups.integrations.feline")
    feline.setup(
        {
            components = catppuccin_integration.get()
        }
    )
end

local function setupBarbar()
    local barbar = require("bufferline")
    barbar.setup(
        {
            animation = true,
            auto_hide = true,
            tabpage = true,
            closable = true,
            clickable = true,
            icons = true,
            icon_custom_colors = true
        }
    )
end

local function setupGitsigns()
    local gitsigns = require("gitsigns")
    gitsigns.setup(
        {
            current_line_blame = true,
            current_line_blame_opts = {
              virt_text = true,
              virt_text_pos = 'eol',
              delay = 1000,
              ignore_whitespace = false
            },
            current_line_blame_formatter = vars["git_blame_format"],
        }
    )
end

local function setupIndentBlankline()
    local indent_blankline = require("indent_blankline")
    indent_blankline.setup()
end

local function setupAutoPairs()
    local autopairs = require("nvim-autopairs")
    autopairs.setup(
        {
            check_ts = true,
            disable_filetype = {
                "TelescopePrompt", "vim"
            },
            enable_check_bracket_line = true,
            ts_config = {
                lua = {
                    "string"
                },
                javascript = {
                    "template_string"
                }
            }
        }
    )
end

local function setupNvimUfo()
    local ufo = require("ufo")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    for _, language_server in ipairs(require("lspconfig")) do
        require("lspconfig")[language_server].setup({capabilities = capabilities})

    end

    ufo.setup()
end

local function setupWhichKey()
    local which_key = require("which-key")
    which_key.setup()
end

local function setupTwilight()
    local twilight = require("twilight")
    twilight.setup(
        {
            treesitter = true,
            expand = {  -- See https://github.com/folke/twilight.nvim#%EF%B8%8F-configuration for more information.
                "function",
                "method",
                "table",
                "if_statement"
            }
        }
    )
end

local function setupTrouble()
    local trouble = require("trouble")
    trouble.setup()
end

local function setupLspLines()
    local lsp_lines = require("lsp_lines")
    lsp_lines.setup()
    vim.diagnostic.config(
        {
            virtual_text = false,
            virtual_lines = true
        }
    )
end

local function setupTelescope()
    local telescope = require("telescope")
    local trouble = require("trouble")
    telescope.setup(
        {
            defaults = {
                mappings = {
                    i = {["<C-t>"] = trouble.open_with_trouble},
                    n = {["<C-t>"] = trouble.open_with_trouble}
                }
            }
        }
    )
end

local function setupNvimTree()
    local nvim_tree = require("nvim-tree")
    nvim_tree.setup(
        {
            filters = {
                dotfiles = false
            }
        }
    )
end

local function setupLspConfig()
    local mason = require("mason")
    local mlsp = require("mason-lspconfig")
    local lsp = require("lspconfig")
    local coq = require("coq")

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

local function setupTreesitter()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup(
        {
            ensure_installed = vars["languages"],  -- Install parsers for languages defined in <languages>.
            autotag = {
                enable = true
            },
            highlight = {                  -- Use treesitter's syntax highlighting.
                enable = true
            },
            indent = {                     -- Use treesitter for indentation.
                enable = false             -- Disable indentation because it's currently broken.
            }
        }
    )
end

local function setupCoq()
    Coq = require("coq")
    local coq3p = require("coq_3p")
    coq3p(
        {
            {  -- Requires bc `$ sudo apt install bc`
                src = "bc",
                short_name = "MATH",
                precision = 4
            },
        }
    )
end

if First_run then
    print("[i] Please restart Neovim after Packer finishes the synchronization process to finish the installation...")
    local create_flag_file = io.open(vars["plugins_installed_path"], 'w')
    if create_flag_file == nil then
        print("[E] Failed to create flag file. please manually create a new empty file in `" .. vars["plugins_installed_path"] .. "`.")

    else
        create_flag_file:write("true")
        create_flag_file:flush()
        create_flag_file:close()

    end

else
    -- run setup functions
    setupCatppuccin()
    setupFeline()
    setupBarbar()
    setupGitsigns()

    setupLspConfig()
    setupTreesitter()
    setupNvimUfo()
    setupCoq()

    setupLspLines()
    setupIndentBlankline()
    setupAutoPairs()
    setupTrouble()
    setupTelescope()

    setupWhichKey()
    setupTwilight()
    setupNvimTree()

end
