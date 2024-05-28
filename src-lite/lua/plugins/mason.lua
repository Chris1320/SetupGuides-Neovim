return {
    "williamboman/mason.nvim",

    enabled = true,
    build = ":MasonUpdate",
    opts = {
        ensure_installed = {
            -- LSPs
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "marksman",
            "phpactor",
            "pyright",
            "tailwindcss-language-server",
            "typescript-language-server",

            -- linters
            "codespell",
            "commitlint",
            "jsonlint",
            "markdownlint",
            "phpstan",
            "pylint",
            "selene",
            "shellcheck",
            "yamllint",

            -- formatters
            "black",
            "clang-format",
            "csharpier",
            "isort",
            "pint",
            "prettierd",
            "shfmt",
            "stylua",
        },
        -- FIXME: We append because I'm not sure how
        -- to use Python virtualenvs with mason
        PATH = "append",
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
