return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,
    build = function()
        require("nvim-treesitter.install").update({with_sync=true})
    end,
    cmd = {"TSInstall", "TSUpdate", "TSInstallInfo", "TSUninstall"},
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local misc = require("misc")
        local ts_config = require("nvim-treesitter.configs")

        ts_config.setup(
            {
                ensure_installed = misc.getEnsureInstalledTSParsers(),
                autotag = {enable=true},
                highlight = {enable=true},
                indent = {enable=true}
            }
        )
    end
}
