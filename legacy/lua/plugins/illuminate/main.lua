local illuminate = require("illuminate")

return {
    setup = function()
        illuminate.configure(
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
