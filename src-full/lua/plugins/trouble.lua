return {
    "folke/trouble.nvim",

    enabled = true,
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        use_diagnostic_signs = true,
        position = "bottom",
        icons = true,
        group = true,
        padding = true,
        indent_lines = true,
        auto_preview = true,
    },
}
