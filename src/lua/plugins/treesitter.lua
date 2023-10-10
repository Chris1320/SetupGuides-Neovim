return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local ts_vars = require("vars").treesitter
        local ts_config = require("nvim-treesitter.configs")

        --- Get the list of languages to automatically install.
        --- @return table x A list of languages to install.
        local function getEnsureInstalled()
            if ts_vars.enforce_ensure_installed then return ts_vars.languages
            else return {}
            end
        end

        ts_config.setup(
            {
                ensure_installed = getEnsureInstalled(),
                autotag = {enable=true},
                highlight = {enable=true},
                indent = {enable=true}
            }
        )
    end
}
