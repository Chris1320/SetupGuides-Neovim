return {
    hasWordsBefore = function()
        -- This function is taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end,
    showConfigVersion = function()
        vim.notify("Config Version: v" .. table.concat(require("info").version, '.'))
    end
}
