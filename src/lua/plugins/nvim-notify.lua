return {
    "rcarriga/nvim-notify",

    name = "nvim-notify",
    enabled = true,
    lazy = false,
    priority = 90,
    config = function()
        local notify_vars = require("vars").behavior.notifications
        local notify = require("notify")

        -- Change the default notification handler.
        vim.notify = function(msg, ...) ---@diagnostic disable-line: duplicate-set-field
            for _, silenced_msg in ipairs(notify_vars.blocked) do
                if msg:match(silenced_msg) then
                    return
                end
            end

            notify(msg, ...) -- Pass the parameters to nvim-notify.
        end
    end,
    keys = {
        {
            "<leader>n",
            function()
                require("notify").dismiss()
            end,
            "n",
            noremap = true,
            silent = true,
            desc = "Dismiss notification",
        },

        -- Telescope integration
        {
            "<leader>th",
            "<cmd>Telescope notify theme=dropdown<cr>",
            "n",
            noremap = true,
            silent = true,
            desc = "Show notification history",
        },
    },
}
