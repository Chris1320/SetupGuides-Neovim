return {
    "folke/trouble.nvim",

    enabled = true,

    cmd = {"TroubleToggle", "Trouble"},
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        "kyazdani42/nvim-web-devicons"
    },
    opts = {
        use_diagnostic_signs = true,
        position = "bottom",
        icons = true,
        group = true,
        padding = true,
        indent_lines = true,
        auto_preview = true
    },
    keys = {
        {"<leader>ewd", "<cmd>TroubleToggle workspace_diagnostics<cr>", 'n', desc="See workspace diagnostics"},
        {"<leader>edd", "<cmd>TroubleToggle document_diagnostics<cr>", 'n', desc="See document diagnostics"},
        {"<leader>eqf", "<cmd>TroubleToggle quickfix<cr>", 'n', desc="See quick fixes"},
        {"<leader>elr", "<cmd>TroubleToggle lsp_references<cr>", 'n', desc="See LSP references"},
        {"<leader>elc", "<cmd>TroubleToggle loclist<cr>", 'n', desc="See loclists"}
    }
}
