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
                }
            }
        )
        telescope.load_extension("notify")
        telescope.load_extension("fzf")
    end
}
