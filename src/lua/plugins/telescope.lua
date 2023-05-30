return {
    "nvim-telescope/telescope.nvim",

    enabled = true,

    priority = 80,
    cmd = "Telescope",
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        "nvim-lua/plenary.nvim",
        "trouble.nvim"
    },
    config = function()
        local telescope = require("telescope")
        local trouble = require("trouble")

        telescope.setup(
            {
                defaults = {
                    mappings = {
                        i = {["<C-t>"] = trouble.open_with_trouble},
                        n = {["<C-t>"] = trouble.open_with_trouble}
                    }
                },
                extensions = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                }
            }
        )
        telescope.load_extension("notify")
        telescope.load_extension("fzf")
    end,
    keys = {
        -- Telescope shortcuts
        {"<leader>tt", "<cmd>Telescope<cr>", 'n', desc="Open Telescope"},
        {"<leader>tb", "<cmd>Telescope buffers<cr>", 'n', desc="See open buffers"},
        {"<leader>tS", "<cmd>Telescope live_grep<cr>", 'n', desc="Search text"},
        {"<leader>tF", "<cmd>Telescope find_files<cr>", 'n', desc="Search files"},
        {"<leader>ts", "<cmd>Telescope treesitter<cr>", 'n', desc="See treesitter symbols"},
        {"<leader>tf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", 'n', desc="Search current buffer"},
        {"<leader>tr", "<cmd>Telescope lsp_references<cr>", 'n', desc="Show References"},
        {"<leader>td", "<cmd>Telescope lsp_definitions<cr>", 'n', desc="Show Definitions"},

        -- Git integration (Parent keymap `g` is supposed to be owned by Gitsigns plugin.)
        {"<leader>gs", "<cmd>Telescope git_status<cr>", 'n', desc="Show Git status"},
        {"<leader>gc", "<cmd>Telescope git_commits<cr>", 'n', desc="Show Git commits"},
        {"<leader>gb", "<cmd>Telescope git_branches<cr>", 'n', desc="Show Git branches"},

        -- Notify integration
        {"<leader>th", "<cmd>Telescope notify<cr>", 'n', desc="Show notification history"}
    }
}
