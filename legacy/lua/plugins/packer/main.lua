local packer = require("packer")  -- Load Packer.

return {
    setup = function()
        packer.startup(
            function(use)
                -- Linting and Syntax Checkers
                use("neovim/nvim-lspconfig")                         -- Quickstart configs for Neovim LSP.
                use("williamboman/mason.nvim")                       -- LSP, DAP, etc. Manager for Neovim.
                use("williamboman/mason-lspconfig.nvim")
                use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")  -- Show LSP diagnostics to a new line.

                -- Visual plugins
                use("stevearc/dressing.nvim")                        -- UI Customization
                use("lewis6991/gitsigns.nvim")                       -- Git Integration
                use(
                    {
                        "nvim-lualine/lualine.nvim",
                        requires = "kyazdani42/nvim-web-devicons"
                    }
                )                       -- Customizable statusline
                use(                                                 -- Tabline plugin
                    {
                        "romgrk/barbar.nvim",
                        requires = "kyazdani42/nvim-web-devicons"
                    }
                )
                use("lukas-reineke/indent-blankline.nvim")           -- Indentation guides
                use(
                    {
                        "kevinhwang91/nvim-ufo",
                        requires = "kevinhwang91/promise-async"
                    }
                )
                use("RRethy/vim-illuminate")

                -- Autocompletion
                use("hrsh7th/nvim-cmp")                              -- LSP Autocompletion
                use("hrsh7th/cmp-nvim-lsp")                          -- nvim-cmp plugin for LSP integration
                use("hrsh7th/cmp-nvim-lsp-signature-help")           -- nvim-cmp plugin for showing LSP function signatures
                use("hrsh7th/cmp-buffer")                            -- nvim-cmp plugin for buffer suggestions
                use("hrsh7th/cmp-path")                              -- nvim-cmp plugin for filesystem suggestions
                use("hrsh7th/cmp-cmdline")                           -- nvim-cmp plugin for cmdline suggestions
                use(
                    {
                        "petertriho/cmp-git",                        -- nvim-cmp plugin for git integration
                        requires = "nvim-lua/plenary.nvim"
                    }
                )
                use("L3MON4D3/LuaSnip")                              -- Snippets
                use("saadparwaiz1/cmp_luasnip")                      -- LuaSnip integration for nvim-cmp
                use("rafamadriz/friendly-snippets")                  -- Collection of snippets for LuaSnip
                use("windwp/nvim-autopairs")                         -- Bracket auto-pairing

                -- File explorer

                -- Other stuff
                use(
                    {
                        "wintermute-cell/gitignore.nvim",  -- Generate .gitignore files.
                        requires = "nvim-telescope/telescope.nvim"
                    }
                )
            end
        )
    end
}
