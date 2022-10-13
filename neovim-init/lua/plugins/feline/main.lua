return {
    setup = function()
        -- Setup Catppuccin integration first according to the documentation.
        -- -- https://github.com/catppuccin/nvim#special-integrations

        local catppuccin_integration = require("catppuccin.groups.integrations.feline")
        catppuccin_integration.setup({})

        local feline = require("feline")
        feline.setup(
            {
                components = catppuccin_integration.get()
            }
        )
    end
}
