local nvim_tree = require("nvim-tree")

return {
    setup = function()
        nvim_tree.setup(
            {
                filters = {
                    dotfiles = false
                }
            }
        )
    end
}
