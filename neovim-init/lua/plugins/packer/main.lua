local packer = require("packer")  -- Load Packer.

return {
    setup = function()
        packer.startup(
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
                use(                                                 -- Native Telescope Sorter
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        run = "make"
                    }
                )

                -- Visual plugins
                use(                                                 -- Catppuccin theme
                    {
                        "catppuccin/nvim",
                        as = "catppuccin",
                        run = ":CatppuccinCompile"  -- compile catppuccin for faster startup.
                    }
                )
                use("stevearc/dressing.nvim")                        -- UI Customization
                use("lewis6991/gitsigns.nvim")                       -- Git Integration
                use("feline-nvim/feline.nvim")                       -- Customizable statusline
                use("rcarriga/nvim-notify")                          -- Notification Manager
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
                use(
                    {
                        "RRethy/vim-illuminate"
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

                -- Debugging
                use("mfussenegger/nvim-dap")                         -- Debug Adapter Protocol
                use(
                    {
                        "rcarriga/nvim-dap-ui",
                        requires = {{"mfussenegger/nvim-dap"}}
                    }
                )
                if First_run == true then
                    packer.sync()
                end
            end
        )
    end
}
