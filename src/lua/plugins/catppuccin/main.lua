local vars = require("vars")

return {
    setup = function()
        local catppuccin = require("catppuccin")
        catppuccin.setup(
            {
                flavour = vars["catppuccin_flavour"],
                compile_path = vars["catppuccin_cache_dir"],
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15
                },
                integrations = {
                    barbar = true,
                    cmp = true,
                    dap = {
                        enabled = true,
                        enable_ui = true
                    },
                    gitsigns = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false
                    },
                    lsp_trouble = true,
                    markdown = true,
                    native_lsp = {
                        enabled = true
                    },
                    nvimtree = {
                        enabled = true,
                        show_root = true,
                        transparent_panel = true
                    },
                    telescope = true,
                    treesitter = true,
                    which_key = true
                }
            }
        )
        vim.cmd.colorscheme("catppuccin")  -- Set theme
    end
}
