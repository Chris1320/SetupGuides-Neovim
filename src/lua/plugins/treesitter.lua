return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    cmd = { "TSInstall", "TSUpdate", "TSInstallInfo", "TSUninstall" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        ensure_installed = require("vars").ide.treesitter,
        auto_install = true,
        autotag = { enable = true },
        highlight = { enable = true },
        indent = { enable = true },
    },
    config = function(_, opts)
        local ts_config = require("nvim-treesitter.configs")

        ts_config.setup(opts)
    end,
}
