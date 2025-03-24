return {
    "stevearc/conform.nvim",

    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cO",
            "<cmd>ConformInfo<cr>",
            "n",
            noremap = true,
            silent = true,
            desc = "Conform Info",
        },
    },
    ---@class ConformOpts
    opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        default_format_opts = {
            timeout_ms = 3000,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
        },
        formatters_by_ft = {
            arduino = { "clang_format" },
            bash = { "shfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            cs = { "csharpier" },
            css = { "prettierd" },
            graphql = { "prettierd" },
            handlebars = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            less = { "prettierd" },
            lua = { "stylua" },
            luau = { "stylua" },
            markdown = { "prettierd" },
            ["markdown.mdx"] = { "prettierd" },
            php = { "pint" },
            python = { "black", "isort" },
            scss = { "prettierd" },
            sh = { "shfmt" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            vue = { "prettierd" },
            yaml = { "prettierd" },
            zsh = { "shfmt" },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
            black = {
                -- selene: allow(unused_variable)
                -- cwd = function(...) --- @diagnostic disable-line: unused-vararg
                --     return require("config.misc").detectProjectRoot({
                --         "pyproject.toml",
                --         "setup.cfg",
                --         "setup.py",
                --         ".git",
                --     }) or vim.fn.getcwd()
                -- end,
            },
            clang_format = { prepend_args = { "--fallback-style=Google" } },
            csharpier = {
                command = "dotnet-csharpier",
                args = { "--write-stdout" },
            },
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
                -- selene: allow(unused_variable)
                -- cwd = function(...) --- @diagnostic disable-line: unused-vararg
                --     return require("config.misc").detectProjectRoot({
                --         ".stylua.toml",
                --         "stylua.toml",
                --         ".git",
                --     }) or vim.fn.getcwd()
                -- end,
            },
        },
    },
}
