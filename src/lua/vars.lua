--[[
This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

]]--

return {
    lazy = {
        path = {
            root = vim.fn.stdpath("data") .. "/lazy",
            home = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        },
        install = {
            missing = true,
            colorscheme = {"catppuccin-mocha"}
        },
        checker = {
            enabled = true,
            concurrency = nil,
            notify = true,
            frequency = 10800
        },
        change_detection = {
            enabled = true,
            notify = true
        }
    },
    colorscheme = {
        catppuccin_flavor = "mocha",  -- Available flavors: `latte`, `frappe`, `macchiato`, `mocha`
        catppuccin_cache_dir = vim.fn.stdpath("cache") .. "/catppuccin"
    },
    blocklisted_notifications = {

    }
}
