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
                cwd = function(...) --- @diagnostic disable-line: unused-vararg
                    return require("misc").detectProjectRoot({
                        "pyproject.toml",
                        "setup.cfg",
                        "setup.py",
                        ".git",
                        ".gitignore",
                    })
                end,
            },
            clang_format = { prepend_args = { "--fallback-style=Google" } },
            isort = { prepend_args = { "--profile", "black" } },
            shfmt = { prepend_args = { "--indent", "4" } },
            stylua = {
                prepend_args = function()
                    local result = { "--color", "Never" }

                    -- Do not override project config if they have one.
                    if
                        vim.fn.filereadable(vim.fn.getcwd() .. "/.stylua.toml") ~= 1
                        and vim.fn.filereadable(vim.fn.getcwd() .. "/stylua.toml") ~= 1
                    then
                        table.insert(result, "--call-parentheses")
                        table.insert(result, "Always")
                        table.insert(result, "--indent-type")
                        table.insert(result, "Spaces")
                    end

                    return result
                end,
                cwd = function(...) --- @diagnostic disable-line: unused-vararg
                    return require("misc").detectProjectRoot({
                        ".stylua.toml",
                        "stylua.toml",
                        ".git",
                        ".gitignore",
                    })
                end,
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
