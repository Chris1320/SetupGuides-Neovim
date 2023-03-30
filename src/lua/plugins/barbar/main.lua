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
                icons = {
                    buffer_index = false,
                    buffer_number = false,
                    diagnostics = {
                        -- By default, only show errors and warnings.
                        [vim.diagnostic.severity.ERROR] = {
                            enabled = true,
                            icon = ""
                        },
                        [vim.diagnostic.severity.WARN] = {
                            enabled = true,
                            icon = ""
                        },
                        [vim.diagnostic.severity.HINT] = {
                            enabled = false,
                            icon = ""
                        },
                        [vim.diagnostic.severity.INFO] = {
                            enabled = false,
                            icon = ""
                        }
                    },
                    filetype = {  -- Show filetype icon
                        custom_colors = true,
                        enabled = true
                    }
                },
            }
        )
    end
}
