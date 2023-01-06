local twilight = require("twilight")

return {
    setup = function()
        twilight.setup(
            {
                treesitter = true,
                expand = {  -- See https://github.com/folke/twilight.nvim#%EF%B8%8F-configuration for more information.
                    "function",
                    "method",
                    "table",
                    "if_statement"
                }
            }
        )
    end
}
