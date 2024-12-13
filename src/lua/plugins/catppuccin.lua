return {
    "catppuccin/nvim",

    name = "catppuccin",
    enabled = true,
    priority = 1000,
    lazy = true,
    build = ":CatppuccinCompile",
    opts = {
        flavour = "mocha",
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        term_colors = true,
    },
}
