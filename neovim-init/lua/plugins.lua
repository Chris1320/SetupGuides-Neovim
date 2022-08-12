--[[
plugins.lua - This is part of a custom config file for Neovim v0.7.2+.

You can get it from:
https://github.com/SetupGuides/Neovim

This module initializes plugins to be used in Neovim.
]]--

local vars = require("vars")  -- Get variables.

-- The code block is based on `https://github.com/wbthomason/packer.nvim#bootstrapping`.
local packer_install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then  -- Check if packer is already installed.
    local packer_bootstrap = vim.fn.system(  -- If not, clone Packer from GitHub.
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            packer_install_path
        }
    )
    vim.cmd("packadd packer.nvim")
end

Packer = require("packer")  -- Load Packer.

Packer.startup(
    function(use)  -- TODO: Continue rewriting this.
        -- Package Managers
        use("wbthomason/packer.nvim")                        -- The package manager that we are using

        -- Linting and syntax checkers
        use("neovim/nvim-lspconfig")                         -- Quickstart configs for Neovim LSP
        use("williamboman/mason.nvim")                       -- LSP, DAP, etc. Manager for Neovim.
        use("williamboman/mason-lspconfig.nvim")
        use("nvim-treesitter/nvim-treesitter")               -- Treesitter integration for Neovim
        use(                                                 -- diagnostics, quickfixes, etc.
            {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons"
            }
        )
        use("github/copilot.vim")                            -- GitHub Copilot integration
        use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")  -- Show LSP diagnostics to a line.

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
    end
)

local function setupCatppuccin()
    local catppuccin = require("catppuccin")
    catppuccin.setup(
        {
            --[[
            styles = {
                comments = "italic",
                conditionals = "italic",
                loops = "NONE",
                functions = "NONE",
                keywords = "NONE",
                strings = "NONE",
                variables = "NONE",
                numbers = "NONE",
                booleans = "NONE",
                properties = "NONE",
                types = "NONE",
                operators = "NONE",
            },
            --]]
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
    indent_blankline.setup(
        --[[
        {
            space_char_blankline = " ",
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            }
        }
        --]]
    )
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
    local lsp = require("lspconfig")
    local coq = require("coq")
    local lsp_installer = require("nvim-lsp-installer")

    -- Setup nvim-lsp-installer
    lsp_installer.setup(
        {
            automatic_installation = true,
            ui = {
                check_outdated_servers_on_open = true,
                icons = {
                    -- you can change these icons to whatever you want.
                    server_installed = "✓",
                    server_pending = "➜",
                    server_uninstalled = "✗"
                }
            }
        }
    )

    -- Setup lspconfig
    lsp.clangd.setup(  -- enable clangd because we're going to install clang anyway.
        coq.lsp_ensure_capabilities()
    )

    lsp.bashls.setup(
        coq.lsp_ensure_capabilities(
            {
                bashIde = {
                    highlightParsingErrors = true
                }
            }
        )
    )

    lsp.cmake.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.cssls.setup(
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

    lsp.omnisharp.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.pyright.setup(
        coq.lsp_ensure_capabilities()
    )

    lsp.rust_analyzer.setup(
        coq.lsp_ensure_capabilities()
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

    lsp.tsserver.setup(
        coq.lsp_ensure_capabilities()
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
    local coq = require("coq")
    local coq3p = require("coq_3p")
    coq3p(
        {
            {  -- Requires bc `$ sudo apt install bc`
                src = "bc",
                short_name = "MATH",
                precision = 4
            },
            {
                src = "copilot",
                short_name = "COP",
                accept_key = "<C-f>"
            }
        }
    )
end

if vars["installed"] then
    -- run setup functions
    setupCatppuccin()
    setupFeline()
    setupBarbar()
    setupGitsigns()
    setupIndentBlankline()
    setupAutoPairs()
    setupWhichKey()
    setupTwilight()
    setupTrouble()
    setupLspLines()
    setupTelescope()
    setupNvimTree()
    setupLspConfig()
    setupTreesitter()
    setupCoq()

else
    vim.cmd(":PackerSync")

end
