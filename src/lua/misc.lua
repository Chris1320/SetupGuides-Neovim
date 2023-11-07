return {
    hasWordsBefore = function()
        -- This function is taken from
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end,

    --- Show the current config version.
    showConfigVersion = function()
        vim.notify("Config Version: v" .. table.concat(require("info").version, "."))
    end,

    --- Get the list of treesitter grammars to automatically install.
    --- @return table x A list of languages to install.
    getEnsureInstalledTSParsers = function()
        local vars = require("vars").treesitter

        if vars.enforce_ensure_installed then
            return vars.languages
        else
            return {}
        end
    end,

    --- Get the list of LSP Servers to automatically install.
    --- @return table x A list of languages to install.
    getEnsureInstalledLSPServers = function()
        local vars = require("vars").lsp

        if vars.enforce_ensure_installed then
            return vars.ensure_installed
        else
            return {}
        end
    end,

    --- Detects the root project of the current buffer.
    --- @param landmarks table A table containing a list of files that are
    ---                         commonly found in the root directory.
    ---
    --- @return string root The root project of the current buffer.
    detectRootProject = function(landmarks)
        local root

        root = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";")
        if landmarks ~= nil then
            for _, landmark in ipairs(landmarks) do
                root = root or vim.fn.finddir(landmark, vim.fn.expand("%:p:h") .. ";")
            end
        end

        return root
    end,

    --- Check if a plugin is installed and enabled, and run the given function
    --- if the former conditions are true.
    ---
    --- @param plugin_name string The name of the plugin.
    --- @param fn function The function to run if the plugin is installed and enabled.
    --- @param alt_fn? function The function to run if the plugin is not installed or enabled.
    ---
    --- @return any fn_return The return value of the function.
    checkPluginThenRun = function(plugin_name, fn, alt_fn)
        local plugin = require("lazy.core.config").plugins[plugin_name]
        if plugin ~= nil then
            if plugin.enabled then
                return fn()
            end
        end

        if alt_fn ~= nil then
            return alt_fn()
        end
    end,
}
