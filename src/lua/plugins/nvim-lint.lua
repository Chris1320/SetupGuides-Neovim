return {
    "mfussenegger/nvim-lint",

    enabled = true,
    opts = {
        -- OPTIMIZE: `TextChanged` fixes the linter diagnostics not being updated after
        --          format problem, but it probably is not the best solution.
        lint_on_event = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
        -- linters that should be run on all filetypes.
        linters_for_all = { "codespell" },
        linters_by_ft = {
            bash = { "shellcheck" },
            gitcommit = { "commitlint" },
            html = { "djlint" },
            json = { "jsonlint" },
            lua = { "selene" },
            luau = { "selene" },
            markdown = { "markdownlint" },
            php = { "phpstan" },
            python = { "pylint" },
            sh = { "shellcheck" },
            yaml = { "yamllint" },
            zsh = { "shellcheck" },
        },
        linters = {
            commitlint = {
                -- FIXME: This should not be hardcoded. However, commitlint cannot find
                -- the module when it is used globally.
                args = {
                    "--extends",
                    vim.fn.stdpath("data") .. "/mason/packages/commitlint/node_modules/@commitlint/config-conventional",
                },
            },
            pylint = { args = { "--jobs", "0", "--output-format", "json" } },
        },
    },
}
