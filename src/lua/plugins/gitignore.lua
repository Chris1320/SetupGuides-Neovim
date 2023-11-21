return {
    "wintermute-cell/gitignore.nvim",

    enabled = true,
    cmd = { "Gitignore" },
    dependencies = { "telescope.nvim" },
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
