return {
    "wintermute-cell/gitignore.nvim",

    cmd = { "Gitignore" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
        {
            "<leader>gi",
            function()
                require("gitignore").generate({ nargs = "?", complete = "file" })
            end,
            "n",
            noremap = true,
            silent = true,
            desc = "Generate .gitignore file",
        },
    },
}
