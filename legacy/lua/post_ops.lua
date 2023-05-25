local flagFile = require("core.utils.flagFile")

local commands = {
    {
        command = "CatppuccinCompile",
        run_once = true
    },
    "TSUpdate"
}

return {
    run = function(first_run)
        if flagFile.exists() then  -- Perform these commands only after setup is done. (This runs everytime after first run)
            -- use `pcall` to let them fail gracefully.
            for _, cmd in ipairs(commands) do
                if type(cmd) == "string" then
                    pcall(vim.cmd, cmd)

                else
                    if (first_run and cmd["run_once"]) then
                        pcall(vim.cmd, cmd["command"])
                    end
                end
            end
        end
    end
}
