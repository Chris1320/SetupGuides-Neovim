return {
    "uga-rosa/ccc.nvim",

    enabled = true,
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterToggle" },
    ft = { "markdown", "html", "css" },
    opts = {
        highlight_mode = "bg",
        highlighter = {
            auto_enable = false,
            lsp = true,
            update_insert = true,
        },
    },
    config = function(plugin, opts)
        require("ccc").setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = plugin.ft,
            callback = function(opt)
                require("ccc.highlighter").new(true):toggle(tonumber(opt.args))
            end,
        })
    end,
}
