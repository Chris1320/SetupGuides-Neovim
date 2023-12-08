return {
    "jiaoshijie/undotree",

    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        position = "right",
        ignore_filetype = {
            "NvimTree",
            "TelescopePrompt",
            "Trouble",
            "mason",
            "qf",
            "spectre_panel",
            "tsplayground",
            "undotree",
            "undotreeDiff",
        },
    },
    keys = {
        {
            "<leader>u",
            function()
                require("undotree").toggle()
            end,
            "n",
            desc = "Open Undotree",
        },
    },
}
