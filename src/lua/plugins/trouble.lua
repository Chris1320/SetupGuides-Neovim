return {
    "folke/trouble.nvim",

    enabled = true,

    priority = 80,
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "kyazdani42/nvim-web-devicons"
    },
    opts = {
        position = "bottom",
        icons = true,
        group = true,
        padding = true,
        indent_lines = true,
        auto_preview = true
    }
}
