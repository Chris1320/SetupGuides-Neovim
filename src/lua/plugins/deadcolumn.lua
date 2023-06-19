return {
    "Bekaboo/deadcolumn.nvim",

    enabled = false,
    event = "VeryLazy",
    dependencies = {
        "catppuccin"
    },
    config = function()
        local palette = require("catppuccin.palettes").get_palette("mocha")

        require("deadcolumn").setup(
            {
                scope = "visible",
                modes = {'i', 'ic', 'ix', 'R', "Rc", "Rx", "Rv", "Rvc", "Rvx"},
                blending = {
                    threshold = 0.75,
                    colorcode = palette.Surface0,
                    hlgroup = {
                        "Normal",
                        "background"
                    }
                },
                warning = {
                    alpha = 0.4,
                    offset = 0,
                    colorcode = palette.red,
                    hlgroup = {
                        "Error",
                        "background"
                    }
                }
            }
        )
    end
}
