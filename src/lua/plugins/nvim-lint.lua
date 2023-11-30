return {
    "mfussenegger/nvim-lint",

    enabled = true,
    opts = {
        -- TODO: `TextChanged` fixes the linter diagnostics not being updated after
        --          <F3> (format) problem, but it probably is not the best solution.
        lint_on_event = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
        -- linters that should be run on all filetypes.
        linters_for_all = { "codespell" },
        linters_by_ft = {
            bash = { "shellcheck" },
            gitcommit = { "commitlint" },
            json = { "jsonlint" },
            lua = { "selene" },
            luau = { "selene" },
            python = { "pylint" },
            sh = { "shellcheck" },
            yaml = { "yamllint" },
            zsh = { "shellcheck" },
        },
        linters_overrides = {
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
    config = function(_, opts)
        local nvim_lint = require("lint")

        -- Add the overrides to the linters' configs.
        for key, value in pairs(opts.linters_overrides) do
            nvim_lint.linters[key] = vim.tbl_deep_extend("force", nvim_lint.linters[key], value)
        end
        nvim_lint.linters_by_ft = opts.linters_by_ft

        -- Create autocmd
        vim.api.nvim_create_autocmd(opts.lint_on_event, {
            callback = function()
                nvim_lint.try_lint()
                for _, linter in ipairs(opts.linters_for_all) do
                    nvim_lint.try_lint(linter)
                end
            end,
        })
    end,
}
