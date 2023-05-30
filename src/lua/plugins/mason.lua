return {
    "williamboman/mason.nvim",

    enabled = true,
    lazy = false,
    build = ":MasonUpdate",
    opts = {
        ui = {
            check_outdated_packages_on_open = true,
            icons = {
                -- you can change these icons to whatever you want.
                package_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    }
}
