local lualine = require("lualine")
local gitsigns = require("gitsigns")

local ignored_filetypes = {
    "mason",
    "NvimTree",
    "TelescopePrompt",
    "Trouble"
}
local filename_config = {
    "filename",
    file_status = true,
    newfile_status = true,
    path = 0  -- Show only the filename.
}

return {
    setup = function()
        lualine.setup(
            {
                options = {
                    icons_enabled = true,
                    theme = "catppuccin",  -- Use the catppuccin theme plugin.
                    always_divide_middle = true,
                    globalstatus = true
                },
                disabled_filetypes = {
                    statusline = ignored_filetypes,
                    winbar = ignored_filetypes
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {
                        {
                            "branch",
                            on_click = function(...)
                                vim.cmd("Telescope git_branches")
                            end
                        },
                        {
                            "diff",
                            on_click = function(...)
                                gitsigns.diffthis()
                            end
                        },
                        {
                            "diagnostics",
                            update_in_insert = true,
                            always_visible = false,
                            on_click = function(...)
                                vim.cmd("TroubleToggle document_diagnostics")
                            end
                        }
                    },
                    lualine_c = {filename_config},
                    lualine_x = {"encoding", "filesize", "filetype", "fileformat"},
                    lualine_y = {"searchcount", "progress"},
                    lualine_z = {"location"}
                },
                inactive_sections = {  -- This isn't used because globalstatus is set to true.
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {filename_config},
                    lualine_x = {"location", "filetype"},
                    lualine_y = {},
                    lualine_z = {}
                },
                extensions = {  -- Enable integrations.
                    "nvim-tree",
                    "quickfix"
                }
            }
        )
    end
}
