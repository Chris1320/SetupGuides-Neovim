return {
    "nvim-treesitter/nvim-treesitter",

    enabled = true,

    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        local ts_vars = require("vars").treesitter
        local treesitter = require("nvim-treesitter.configs")

        local function getEnsureInstalled()
            if ts_vars.enforce_ensure_installed then
                return ts_vars.languages
            else
                return {}
            end
        end

        treesitter.setup(
            {
                ensure_installed = getEnsureInstalled(),
                autotag = {enable = true},
                highlight = {enable = true},
                indent = {enable = true}
            }
        )
    end
}
