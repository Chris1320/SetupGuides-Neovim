return {
    "nvim-telescope/telescope.nvim",

    enabled = true,
    cmd = "Telescope",
    event = {"BufReadPost", "BufNewFile"},
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter",
        "trouble.nvim"
    },
    config = function()
        local trouble = require("trouble")
        local telescope = require("telescope")
        local telescope_actions = require("telescope.actions")

        telescope.setup(
            {
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = telescope_actions.close,
                            ["<C-t>"] = trouble.open_with_trouble
                        },
                        n = {["<C-t>"] = trouble.open_with_trouble}
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                }
            }
        )
        telescope.load_extension("notify")
        telescope.load_extension("fzf")
    end,
    keys = {
        {
            "<leader>tt",
            function()
                require("telescope.builtin").builtin(
                    require("telescope.themes").get_dropdown({previewer=false})
                )
            end,
            'n',
            desc = "Open Telescope"
        },
        {
            "<leader>tb",
            function()
                require("telescope.builtin").buffers(
                    require("telescope.themes").get_dropdown()
                )
            end,
            'n',
            desc = "See open buffers"
        },

        {
            "<leader>tf",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            'n',
            desc = "Search current buffer"
        },
        {
            "<leader>tS",
            function() require("telescope.builtin").live_grep() end,
            'n',
            desc = "Search text"
        },
        {
            "<leader>tF",
            function() require("telescope.builtin").find_files() end,
            'n',
            desc = "Search directory files"
        },
        {
            "<leader>tg",
            function() require("telescope.builtin").git_files() end,
            'n',
            desc = "Search Git files"
        },

        {
            "<leader>ts",
            function() require("telescope.builtin").treesitter() end,
            'n',
            desc = "See treesitter symbols"
        },
        {
            "<leader>tr",
            function()
                require("telescope.builtin").lsp_references(
                    require("telescope.themes").get_ivy()
                )
            end,
            'n',
            desc = "Show references"
        },
        {
            "<leader>td",
            function()
                require("telescope.builtin").lsp_definitions(
                    require("telescope.themes").get_cursor({previewer=false})
                )
            end,
            'n',
            desc = "Show definitions"
        },

        -- Git integration (Parent keymap `g` is
        -- supposed to be owned by Gitsigns plugin.)
        {
            "<leader>gs",
            function()
                require("telescope.builtin").git_status(
                    require("telescope.themes").get_dropdown()
                )
            end,
            'n',
            desc = "Show Git status"
        },
        {
            "<leader>gc",
            function()
                require("telescope.builtin").git_commits(
                    require("telescope.themes").get_dropdown()
                )
            end,
            'n',
            desc = "Show Git commits"
        },
        {
            "<leader>gb",
            function()
                require("telescope.builtin").git_branches(
                    require("telescope.themes").get_dropdown()
                )
            end,
            'n',
            desc = "Show Git branches"
        },
    }
}
