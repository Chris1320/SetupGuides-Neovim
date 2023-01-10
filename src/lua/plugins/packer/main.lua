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
                use(                                                 -- Treesitter integration for Neovim
                    {
                        "nvim-treesitter/nvim-treesitter",
                        run = ":TSUpdate"
                    }
                )
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
                use(
                    {
                        "feline-nvim/feline.nvim",
                        requires = {{"kyazdani42/nvim-web-devicons"}}
                    }
                )                       -- Customizable statusline
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

                -- Autocompletion
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
                    packer.sync()
                end
            end
        )
    end
}
