return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,

    priority = 80,
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local vars = require("vars")
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup(
            {
                ensure_installed = vars.treesitter.languages,
                autotag = {enable = true},
                highlight = {enable = true},
                indent = {enable = true}
            }
        )
    end
}
