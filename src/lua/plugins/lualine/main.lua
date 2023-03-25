local lualine = require("lualine")

return {
    setup = function ()
        lualine.setup(
            {
                options = {
                    icons_enabled = true,
                    theme = "catppuccin"
                }
            }
        )
    end
}
