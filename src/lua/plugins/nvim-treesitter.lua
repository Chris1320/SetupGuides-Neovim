return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cpp",
            "diff",
            "gitcommit",
            "html",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "jsonc",
            "latex",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
    },
}
