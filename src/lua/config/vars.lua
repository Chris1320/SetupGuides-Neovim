return {
    appearance = {
        tab_width = 4, -- 4 spaces is just the right amount of spaces... fight me.
        colorcolumn = {
            default_columns = { 80 }, -- Which columns should be highlighted
            custom_colorcolumns = {
                -- Line length references
                -- bash, sh, zsh: N/A
                -- c, cpp:        Google C++ Style Guide
                -- cs:            csharpier
                -- lua, luau:     StyLua
                -- python:        Black, Pylint
                bash = { 120 },
                c = { 80 },
                cpp = { 80 },
                cs = { 100 },
                java = { 120 },
                lua = { 120 },
                luau = { 120 },
                python = { 88, 100 },
                sh = { 120 },
                zsh = { 120 },
            },
        },
        git_blame_format = "<author>, on <author_time:%Y-%m-%d> • <summary>",
    },
    langs = {
        python = {
            pylint = {
                -- Ignore these pylint warnings
                ignored = {
                    "C0114",
                    "C0115",
                },
            },
        },
    },
}
