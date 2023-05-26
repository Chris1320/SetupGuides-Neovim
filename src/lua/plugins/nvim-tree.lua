return {
    "kyazdani42/nvim-tree.lua",

    name = "nvim-tree",
    enabled = true,

    lazy = false,
    priority = 80,
    dependencies = {"kyazdani42/nvim-web-devicons"},
    opts = {
        filters = {
            dotfiles = false
        }
    }
}
