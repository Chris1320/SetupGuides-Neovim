return {
    setup = function()
        local barbar = require("bufferline")
        barbar.setup(
            {
                animation = true,
                auto_hide = true,
                tabpage = true,
                closable = true,
                clickable = true,
                highlights = require("catppuccin.groups.integrations.bufferline").get(),  -- Catppuccin integration
                icons = true,
                icon_custom_colors = true
            }
        )
    end
}
