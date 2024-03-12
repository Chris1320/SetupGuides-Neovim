return {
    "wookayin/semshi",

    enabled = true,
    build = function()
        local pynvim_venv_path = vim.fn.stdpath("data") .. "/pynvim_venv"
        -- Create virtual env if it doesn't exist yet
        if not vim.loop.fs_stat(pynvim_venv_path) then
            vim.fn.system({
                "python3",
                "-m",
                "venv",
                pynvim_venv_path,
            })
        end

        vim.g.python3_host_prog = vim.loop.fs_stat(pynvim_venv_path .. "/Scripts/Activate.ps1")
                and pynvim_venv_path .. "/Scripts/python3.exe"
            or pynvim_venv_path .. "/bin/python3"
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
}
