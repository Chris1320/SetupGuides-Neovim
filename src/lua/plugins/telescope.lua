return {
    "nvim-telescope/telescope.nvim",

    enabled = true,
    cmd = "Telescope",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            enabled = vim.fn.executable("make") == 1,
            config = function()
                require("lazyvim.util").on_load("telescope.nvim", function()
                    require("telescope").load_extension("fzf")
                end)
            end,
        },
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter",
        "trouble.nvim",
    },
    opts = function()
        local trouble = require("trouble")
        local telescope_actions = require("telescope.actions")
        return {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = telescope_actions.close,
                        ["<C-t>"] = trouble.open_with_trouble,
                    },
                    n = { ["<C-t>"] = trouble.open_with_trouble },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
    end,
    keys = {
        {
            "<leader>t",
            function()
                require("telescope.builtin").builtin(require("telescope.themes").get_dropdown({ previewer = false }))
            end,
            "n",
            desc = "Telescope",
        },
        {
            "<leader>gb",
            function()
                require("telescope.builtin").git_branches(require("telescope.themes").get_dropdown())
            end,
            "n",
            desc = "branches",
        },
    },
}
