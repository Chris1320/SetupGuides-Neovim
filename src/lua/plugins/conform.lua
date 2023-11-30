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
            css = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            json = { "prettierd" },
            lua = { "stylua" },
            luau = { "stylua" },
            markdown = { "prettierd" },
            python = { "black", "isort" },
            scss = { "prettierd" },
            sh = { "shfmt" },
            typescript = { "prettierd" },
            vue = { "prettierd" },
            yaml = { "prettierd" },
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
                    }) or vim.fn.getcwd()
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
                    }) or vim.fn.getcwd()
                end,
            },
        },
    },
    init = function(plugin)
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        -- autocmd to enable <F3> keymap only if it doesn't already exist.
        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            callback = function()
                -- This happens when, for example, there is no LSP attached to the buffer.
                if require("misc").checkKeymapExists("<F3>", "n") then
                    return
                end
                if not vim.tbl_contains(vim.tbl_keys(plugin.opts.formatters_by_ft), vim.bo.filetype) then
                    return
                end

                vim.keymap.set("n", "<F3>", function()
                    print("[conform.nvim] Formatting file...")
                    require("conform").format({ async = true, lsp_fallback = true })
                end, { desc = "Format file", silent = true })
                vim.keymap.set("x", "<F3>", function()
                    print("[conform.nvim] Formatting selection...")
                    require("conform").format({ async = true, lsp_fallback = true })
                end, { desc = "Format selection", silent = true })
            end,
        })
    end,
}
