--[[
plugins.lua - This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

This module initializes plugins to be used in Neovim.
]]--

local flagFile = require("core.utils.flagFile")

local function setupPlugins()
    local plugin_list = {
        "packer",

        "catppuccin",
        "feline",
        "barbar",
        "dressing",
        "notify",
        "gitsigns",

        "lspconfig",
        "luasnip",
        "treesitter",
        "nvim-ufo",

        "lsplines",
        "indent-blankline",
        "autopairs",
        "trouble",
        "telescope",

        "illuminate",
        "which-key",
        "nvim-tree"
    }

    for _, pluginMain in ipairs(plugin_list) do
        require("plugins." .. pluginMain .. ".main").setup()

    end
end

local function setup()
    -- Returns `true` if it only syncs plugins.
    if not flagFile.exists() then
        vim.notify("Please restart Neovim after Packer finishes the synchronization process to finish the installation...")
        require("plugins.packer.main").setup()  -- Setup Packer first.
        require("packer").sync()  -- Call sync function of packer plugin. (Equivalent to `:PackerSync`)
        return true

    else
        setupPlugins()
        return false
    end
end

return {
    setup = setup
}
