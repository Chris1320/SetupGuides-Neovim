return {
    "williamboman/mason.nvim",

    enabled = true,
    build = ":MasonUpdate",
    opts = {
        -- FIXME: We append because I'm not sure how
        -- to use Python virtualenvs with mason
        PATH = "append",
        ui = {
            check_outdated_packages_on_open = false,
            icons = {
                -- you can change these icons to whatever you want.
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
