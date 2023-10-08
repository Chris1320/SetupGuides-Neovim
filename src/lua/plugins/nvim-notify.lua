return {
    "rcarriga/nvim-notify",

    name = "nvim-notify",
    enabled = true,
    lazy = false,
    priority = 90,
    config = function()
        local vars = require("vars")
        local notify = require("notify")

        -- Change the default notification handler.
        vim.notify = function(msg, ...)
            for _, silenced_msg in ipairs(vars.notifications.blocked) do
                if msg:match(silenced_msg) then
                    -- Do not show notification if part of its
                    -- message is in <vars.blocklisted_notifications>.
                    return
                end
            end

            notify(msg, ...)  -- Pass the parameters to nvim-notify.
        end
    end,
    keys = {
        {
            "<leader>n",
            ":lua require('notify').dismiss()<cr>",
            'n', noremap=true, silent=true, desc="Dismiss notification"
        },

        -- Telescope integration
        {
            "<leader>th",
            "<cmd>Telescope notify theme=dropdown<cr>",
            'n', noremap=true, silent=true, desc="Show notification history"
        }
    }
}
