return {
    "folke/trouble.nvim",

    enabled = true,

    priority = 80,
    cmd = {"TroubleToggle", "Trouble"},
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "kyazdani42/nvim-web-devicons"
    },
    opts = {
        use_diagnostic_signs = true,
        position = "bottom",
        icons = true,
        group = true,
        padding = true,
        indent_lines = true,
        auto_preview = true
    }
}
