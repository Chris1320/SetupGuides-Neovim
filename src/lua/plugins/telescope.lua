return {
    "nvim-telescope/telescope.nvim",

    enabled = true,

    priority = 80,
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
    end
}
