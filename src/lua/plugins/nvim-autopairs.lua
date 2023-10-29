return {
    "windwp/nvim-autopairs",

    enabled = true,
    event = {"InsertEnter"},
    opts = {
        check_ts = true,
        disable_filetype = {
            "TelescopePrompt", "vim"
        },
        enable_check_bracket_line = true,
        ts_config = {}
    }
}
