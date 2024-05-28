return {
    "RRethy/vim-illuminate",

    enabled = true,
    event = "LazyFile",
    opts = {
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        filetypes_denylist = {
            "mason",
            "TelescopePrompt",
            "Trouble",
        },
        under_cursor = true,
        min_count_to_highlight = 2,
        large_file_cutoff = 2000,
        large_file_overrides = nil,
    },
}
