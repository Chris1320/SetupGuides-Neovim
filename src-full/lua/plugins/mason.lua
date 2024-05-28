return {
    "williamboman/mason.nvim",

    enabled = true,
    build = ":MasonUpdate",
    opts = {
        ensure_installed = {
            -- LSPs
            "bash-language-server",
            "clangd",
            "html-lsp",
            "jdtls",
            "json-lsp",
            "lua-language-server",
            "marksman",
            "omnisharp",
            "phpactor",
            "pyright",
            "tailwindcss-language-server",
            "typescript-language-server",

            -- linters
            "codespell",
            "commitlint",
            "djlint",
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

            -- DAPs
            "codelldb",
            "debugpy",
            "java-test",
            "java-debug-adapter",
            "js-debug-adapter",
            "netcoredbg",
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
