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
                under_cursor = true
            }
        )
    end
}
