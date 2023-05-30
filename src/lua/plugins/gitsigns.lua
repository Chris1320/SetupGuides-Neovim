return {
    "lewis6991/gitsigns.nvim",

    enabled = true,
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
    end,
    keys = {
        -- Gitsigns shortcuts
        -- Logic:
        -- * = lowercase characters
        -- ^ = uppercase characters
        --
        -- [g] Gitsigns
        --     [gP]  Buffer diff preview
        --     [gp*] Hunk preview operations
        --     [gh*] Hunk operations
        --     [gh^] Buffer operations
        --     [gt*] toggles/switches

        {
            "<leader>gP",
            function() require("gitsigns").diffthis() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Show buffer changes"
        },
        {
            "<leader>gps",
            function() require("gitsigns").preview_hunk() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Preview hunk"
        },
        {
            "<leader>gpa",
            function() require("gitsigns").prev_hunk() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Preview previous hunk"
        },
        {
            "<leader>gpd",
            function() require("gitsigns").next_hunk() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Preview next hunk"
        },
        {
            "<leader>ghs",
            function() require("gitsigns").stage_hunk() end,
            {'n', 'v'},
            noremap = true,
            silent = true,
            desc = "Stage hunk"
        },
        {
            "<leader>ghr",
            function() require("gitsigns").reset_hunk() end,
            {'n', 'v'},
            noremap = true,
            silent = true,
            desc = "Reset hunk"
        },
        {
            "<leader>ghS",
            function() require("gitsigns").stage_buffer() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Stage current buffer"
        },
        {
            "<leader>ghR",
            function() require("gitsigns").reset_buffer() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Reset current buffer"
        },
        {
            "<leader>ghu",
            function() require("gitsigns").undo_stage_hunk() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Undo stage hunk"
        },
        {
            "<leader>gtb",
            function() require("gitsigns").toggle_current_line_blame() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Toggle line blame"
        },
        {
            "<leader>gtd",
            function() require("gitsigns").toggle_deleted() end,
            'n',
            noremap = true,
            silent = true,
            desc = "Toggle deleted lines"
        }
    }
}
