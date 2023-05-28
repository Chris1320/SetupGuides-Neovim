local packer = require("packer")  -- Load Packer.

return {
    setup = function()
        packer.startup(
            function(use)
                -- Linting and Syntax Checkers
                use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")  -- Show LSP diagnostics to a new line.

                -- Visual plugins
                use("stevearc/dressing.nvim")                        -- UI Customization
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
                use("windwp/nvim-autopairs")                         -- Bracket auto-pairing

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
