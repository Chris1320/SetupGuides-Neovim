return {
    "stevearc/conform.nvim",

    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        format_on_save = { lsp_fallback = true },
        notify_on_error = true,
        formatters_by_ft = {
            bash = { "shfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            cs = { "csharpier" },
            lua = { "stylua" },
            luau = { "stylua" },
            python = { "black", "isort" },
            sh = { "shfmt" },
            zsh = { "shfmt" },
        },
        formatters = {
            black = {
                cwd = function(...)
                    return require("conform.util").root_file({
                        "pyproject.toml",
                        "setup.cfg",
                        "setup.py",
                        ".git",
                        ".gitignore",
                    })(...)
                end,
            },
            clang_format = { prepend_args = { "--fallback-style=Google" } },
            isort = { prepend_args = { "--profile", "black" } },
            shfmt = { prepend_args = { "--indent", "4" } },
            stylua = {
                prepend_args = {
                    "--color",
                    "Never",
                    "--call-parentheses",
                    "Always",
                    "--indent-type",
                    "Spaces",
                },
                cwd = function(...)
                    return require("conform.util").root_file({
                        ".stylua.toml",
                        "stylua.toml",
                        ".git",
                        ".gitignore",
                    })(...)
                end,
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
