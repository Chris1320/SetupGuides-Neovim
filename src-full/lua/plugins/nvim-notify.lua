return {
    "rcarriga/nvim-notify",

    enabled = true,
    keys = {
        {
            "<leader>n",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss all Notifications",
        },

        -- Telescope integration
        {
            "<leader>un",
            "<cmd>Telescope notify theme=dropdown<cr>",
            desc = "Show Notification History",
        },
    },
}
