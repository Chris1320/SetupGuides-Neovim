return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            check_outdated_packages_on_open = true,
            icons = {
                -- you can change these icons to whatever you want.
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
