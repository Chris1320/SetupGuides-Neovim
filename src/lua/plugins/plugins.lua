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
    if not flagFile.exists() then
        vim.notify("Please restart Neovim after Packer finishes the synchronization process to finish the installation...")
        require("plugins.packer.main").setup()  -- Setup Packer first.
        require("packer").sync()  -- Call sync function of packer plugin. (Equivalent to `:PackerSync`)
        local flag_file_update_result = flagFile.update()
        if flag_file_update_result["exit_code"] ~= 0 then
            vim.notify(flag_file_update_result["message"])

        end
    else
        setupPlugins()

    end
end

return {
    setup = setup
}
