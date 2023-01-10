local telescope = require("telescope")
local trouble = require("trouble")

return {
    setup = function()
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
