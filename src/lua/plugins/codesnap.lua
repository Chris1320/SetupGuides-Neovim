local save_path = "~/Pictures/CodeSnap"
return {
    "mistricky/codesnap.nvim",

    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave" },
    keys = {
        { "<leader>bsc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
        {
            "<leader>bss",
            "<cmd>CodeSnapSave<cr>",
            mode = "x",
            desc = "Save selected code snapshot in " .. save_path,
        },
    },
    opts = {
        -- fonts
        code_font_family = "JetBrainsMono Nerd Font",
        watermark_font_family = "Pacifico",

        -- style
        bg_theme = "bamboo",
        mac_window_bar = false,
        has_breadcrumbs = true,
        has_line_number = false,
        title = "CodeSnap.nvim",
        watermark = "",

        save_path = save_path,
    },
}
