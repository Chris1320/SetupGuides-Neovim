--[[
This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim
]]--

local info = require("core.info")
local vars = require("vars")

local function exists()
    --[[
    Check if the flag file exists and contains the version number of the configuration file.

    :returns bool: `true` if the flag file exists in designated path, otherwise flase.
    ]]--

    local plugins_installed_path = io.open(vars["plugins_installed_path"], 'r')
    if plugins_installed_path == nil then
        return false  -- If it is `nil` then it does not exist in the filesystem.

    end

    return plugins_installed_path:read() == "v" .. info["version"][1] .. '.' .. info["version"][2] .. '.' .. info["version"][3]
end

local function update()
    --[[
    Create the flag file if it doesn't exist and update the version number.

    :returns table[int, str]: A table containing the exit code and its message.
    ]]--

    local flag_file = io.open(vars["plugins_installed_path"], 'w')
    if flag_file == nil then
        return {
            exit_code = 1,
            message = "Failed to create flag file. please manually create a new empty file in `" .. vars["plugins_installed_path"] .. "`."
        }

    else
        flag_file:write("v" .. info["version"][1] .. '.' .. info["version"][2] .. '.' .. info["version"][3])
        flag_file:flush()
        flag_file:close()

        return {
            exit_code = 0,
            message = "Done."
        }

    end

end

return {
    exists = exists,
    update = update
}
