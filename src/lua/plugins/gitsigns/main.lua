local vars = require("vars")
local gitsigns = require("gitsigns")

return {
    setup = function()
        gitsigns.setup(
            {
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false
                },
                current_line_blame_formatter = vars["git_blame_format"],
            }
        )
    end
}
