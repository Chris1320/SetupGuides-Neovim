return {
    hasWordsBefore = function()
        -- This function is taken from
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(
            0,
            line - 1,
            line,
            true
        )[1]:sub(col, col):match("%s") == nil
    end,

    --- Show the current config version.
    showConfigVersion = function()
        vim.notify(
            "Config Version: v"
                .. table.concat(
                    require("info").version,
                    '.'
                )
        )
    end,

    --- Get the list of treesitter grammars to automatically install.
    --- @return table x A list of languages to install.
    getEnsureInstalledTSParsers = function()
        local vars = require("vars").treesitter

        if vars.enforce_ensure_installed then return vars.languages
        else return {}
        end
    end,

    --- Get the list of LSP Servers to automatically install.
    --- @return table x A list of languages to install.
    getEnsureInstalledLSPServers = function()
        local vars = require("vars").lsp

        if vars.enforce_ensure_installed then return vars.ensure_installed
        else return {}
        end
    end
}
