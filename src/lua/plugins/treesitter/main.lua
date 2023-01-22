local vars = require("vars")
local treesitter = require("nvim-treesitter.configs")

return {
    setup = function()
        treesitter.setup(
            {
                ensure_installed = vars["treesitter_languages"],  -- Install parsers for languages defined in <languages>.
                autotag = {
                    enable = true
                },
                highlight = {                  -- Use treesitter's syntax highlighting.
                    enable = true
                },
                indent = {                     -- Use treesitter for indentation.
                    enable = false             -- Disable indentation because it's currently broken.
                }
            }
        )
    end
}
