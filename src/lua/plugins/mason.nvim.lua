return {
  "mason-org/mason.nvim",
  opts = {
    mason = {
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
    ensure_installed = {
      "astro-language-server",
      "basedpyright",
      "bash-language-server",
      "black",
      "clang-format",
      "commitlint",
      "djlint",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "eslint-lsp",
      "gofumpt",
      "goimports",
      "golangci-lint",
      "gopls",
      "hadolint",
      "isort",
      "json-lsp",
      "jsonlint",
      "lua-language-server",
      "markdown-toc",
      "markdownlint-cli2",
      "marksman",
      "omnisharp",
      "prettier",
      "prettierd",
      "pylint",
      "ruff",
      "selene",
      "shellcheck",
      "shfmt",
      "sqlfluff",
      "stylua",
      "tailwindcss-language-server",
      "taplo",
      "vtsls",
      "vue-language-server",
      "yaml-language-server",
      "yamllint",
    },
  },
  config = function(_, opts)
    require("mason").setup(opts.mason)
    local mr = require("mason-registry")
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end

    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
