return {
    "RRethy/vim-illuminate",

    enabled = true,
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("illuminate").configure(
            {
                providers = {
                    "lsp",
                    "treesitter",
                    "regex"
                },
                filetypes_denylist = {
                    "mason",
                    "NvimTree",
                    "TelescopePrompt",
                    "Trouble"
                },
                under_cursor = true,
                min_count_to_highlight = 2,
                large_file_cutoff = 7500,
            }
        )
    end
}
