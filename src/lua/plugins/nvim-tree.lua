return {
    "nvim-tree/nvim-tree.lua",

    name = "nvim-tree",
    enabled = true,
    lazy = false,
    dependencies = {"nvim-tree/nvim-web-devicons"},
    opts = {filters={dotfiles=false}},
    keys = {
        {
            "<leader>fo",
            "<cmd>NvimTreeOpen<cr>",
            'n', noremap=true, silent=true,
            desc="Open nvim-tree"
        },
        {
            "<leader>fc",
            "<cmd>NvimTreeClose<cr>",
            'n', noremap=true, silent=true,
            desc="Close nvim-tree"
        },
        {
            "<leader>ff",
            "<cmd>NvimTreeFocus<cr>",
            'n', noremap=true, silent=true,
            desc="Focus to nvim-tree"
        },
        {
            "<leader>fF",
            "<cmd>NvimTreeFindFile<cr>",
            'n', noremap=true, silent=true,
            desc="Find current file in nvim-tree"
        },
        {
            "<leader>ft",
            "<cmd>NvimTreeToggle<cr>",
            'n', noremap=true, silent=true,
            desc="Toggle nvim-tree"
        }
    }
}
