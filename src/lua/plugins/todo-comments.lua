return {
    "folke/todo-comments.nvim",

    enabled = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { search = { pattern = [[ \b(KEYWORDS):]] } },
}
