#!/usr/bin/env lua

--[[
Recursively search for all plugins in the plugins directory and generate a
list of plugins and their GitHub/source URLs for documentation.
--]]

--- Helper function to recursively search a directory for files.
--- This uses an OS-specific command to search for files, so it may not work
--- on Windows OS. (FIXME: Check OS and use appropriate command.)
---
--- @param root string The path of the directory to search.
--- @param pattern string The pattern to match filenames against.
--- @param recursive? boolean Whether to recursively search subdirectories. (Default: true)
---
--- @return table files A table of all files matching the pattern.
local function dirSearch(root, pattern, recursive)
    local files = {}
    local command = [[find '%s' -type f -name '%s']] -- recursive by default

    if recursive ~= nil then
        if not recursive then
            command = [[find '%s' -maxdepth 1 -type f -name '%s']]
        end
    end

    for path in io.popen(string.format(command, root, pattern)):lines() do
        table.insert(files, path)
    end

    return files
end

--- The main function.
---
--- @param plugins_root string The path of the plugins directory.
---
--- @return number n The exit code.
function Main(plugins_root)
    plugins_root = plugins_root or "src/lua/plugins"
    io.write("Searching in: " .. plugins_root .. "\n")

    local plugins_paths = dirSearch(plugins_root, "*.lua", true)
    io.write(string.format("Found %d plugins.\n", #plugins_paths))

    -- try to require the plugins and get the first element.
    local plugins_with_errors = {}
    local plugin_names = {}

    io.write("Attempting to load LazyPlugin specs...\n\n")
    for _, path in ipairs(plugins_paths) do
        local ok, plugin = pcall(loadfile(path)) --- @diagnostic disable-line: param-type-mismatch
        if ok and plugin then
            -- TODO: Get dependencies too.
            if type(plugin[1]) == "table" then
                -- multiple LazySpecs are in one module.
                for _, lazy_plugin in ipairs(plugin) do
                    table.insert(plugin_names, {
                        path = path,
                        url = lazy_plugin[1] or lazy_plugin.url,
                    })
                end
            else
                table.insert(plugin_names, {
                    path = path,
                    url = plugin[1] or plugin.url,
                })
            end
        else
            table.insert(plugins_with_errors, { path, plugin })
        end
    end

    -- make the output easier to read.
    local max_path_len = 0
    for _, p in ipairs(plugin_names) do
        max_path_len = math.max(max_path_len, #p.path)
    end

    for _, p in ipairs(plugin_names) do
        io.write(string.format("%s%s: %s\n", p.path, string.rep(" ", max_path_len - #p.path), p.url))
    end

    io.write(string.format("\nFailed to get information about %d plugins.\n", #plugins_with_errors))
    io.write("Do you want to see more information about these plugins? [y/N] >>> ")

    local answer = io.read("*l")
    if answer:lower() == "y" then
        for _, pwe in ipairs(plugins_with_errors) do
            local template = "\n==================== %s ====================\n%s\n"
            io.write(string.format(template, pwe[1], pwe[2]))
        end
    end

    return 0
end

os.exit(Main(arg[1]))
