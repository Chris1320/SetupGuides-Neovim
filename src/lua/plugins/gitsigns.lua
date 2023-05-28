return {
    "lewis6991/gitsigns.nvim",

    enabled = true,
    priority = 80,
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local vars = require("vars")

        require("gitsigns").setup(
            {
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false
                },
                current_line_blame_formatter = vars.appearance.git_blame_format,
            }
        )
    end
}
