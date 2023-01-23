local autopairs = require("nvim-autopairs")

return {
    setup = function()
        autopairs.setup(
            {
                check_ts = true,
                disable_filetype = {
                    "TelescopePrompt", "vim"
                },
                enable_check_bracket_line = true,
                ts_config = {
                    lua = {
                        "string"
                    },
                    javascript = {
                        "template_string"
                    }
                }
            }
        )
    end
}
