return {
    "wookayin/semshi",

    enabled = true,
    opts = {
        pynvim_venv_path = vim.fn.stdpath("data") .. "/pynvim_venv",
    },
    build = function(plugin)
        -- Create virtual env if it doesn't exist yet
        if not vim.loop.fs_stat(plugin.opts.pynvim_venv_path) then
            vim.fn.system({
                "python3",
                "-m",
                "venv",
                plugin.opts.pynvim_venv_path,
            })
        end

        vim.g.python3_host_prog = vim.loop.fs_stat(plugin.opts.pynvim_venv_path .. "/Scripts/Activate.ps1")
                and plugin.opts.pynvim_venv_path .. "/Scripts/python3.exe"
            or plugin.opts.pynvim_venv_path .. "/bin/python3"
        vim.fn.system({
            vim.g.python3_host_prog,
            "-m",
            "pip",
            "install",
            "pynvim",
        })
        vim.notify("Neovim python virtualenv has been created.")
        vim.cmd("UpdateRemotePlugins")
    end,
    config = function(_, opts)
        vim.g.python3_host_prog = vim.loop.fs_stat(opts.pynvim_venv_path .. "/Scripts/Activate.ps1")
                and opts.pynvim_venv_path .. "/Scripts/python3.exe"
            or opts.pynvim_venv_path .. "/bin/python3"
    end,
}
