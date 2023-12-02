#!/usr/bin/env lua

--[[
Recursively search for all plugins in the plugins directory and generate a
list of plugins and their GitHub/source URLs for documentation.
--]]

--- Helper function to prettify the display of tables.
---
--- @param tbl table The table list to prettify.
--- @param headers? table A list of headers for the table.
--- @param opts? table Options to customize the output.
---
--- @return string|nil output The prettified table.
-- selene: allow(shadowing)
local function generateTable(tbl, headers, opts)
    -- OPTIMIZE: Refactor this function... This is a nightmare 'cause I haven't slept yet.
    local result = ""
    local max_col_lens = {}
    local headers = headers or {} --- @diagnostic disable-line: redefined-local
    local opts = opts --- @diagnostic disable-line: redefined-local
        or {
            padding = " ",
            newline = "\n",
            border = {
                topleft = "┌",
                topright = "┐",
                bottomleft = "└",
                bottomrright = "┘",

                vertical = "│",
                vert_sep_left = "├",
                vert_sep_right = "┤",

                horizontal = "─",
                horiz_sep_top = "┬",
                horiz_sep_bottom = "┴",

                center_sep = "┼",
            },
        }

    if #headers > 0 and #tbl > 0 then
        if #headers ~= #tbl[1] then
            error("Headers must be the same length as the table.")
            return
        end
    end

    --- Get the max length of each column.
    ---
    --- @param row table The row to get the max length of each column.
    ---
    --- @return table max_length The max length of each column.
    local function getMaxLength(row)
        local row_max_length = {}
        for _, col in ipairs(row) do
            table.insert(row_max_length, #col)
        end

        return row_max_length
    end

    --- Update the value of the max length of each column.
    ---
    --- @param row table The row to update the max length of each column.
    local function updateMaxLength(row)
        local max_length = getMaxLength(row)
        for idx, val in ipairs(max_length) do
            if max_col_lens[idx] == nil then
                max_col_lens[idx] = val
            else
                max_col_lens[idx] = math.max(max_col_lens[idx], val)
            end
        end
    end

    -- get the max length of each column of the headers and the table.
    for _, row in ipairs(headers) do
        updateMaxLength(row)
    end
    for _, row in ipairs(tbl) do
        updateMaxLength(row)
    end

    --- Generate a table row.
    ---
    --- @param row table The row to generate.
    --- @param padding_char string The padding character to use.
    --- @param center_sep string The center separator to use.
    --- @param left_sep string The left separator to use.
    --- @param right_sep string The right separator to use.
    local function generateTableRow(row, padding_char, center_sep, left_sep, right_sep)
        local table_row = string.format("%s%s", left_sep, padding_char)

        for i, col in ipairs(row) do
            local padding = string.rep(padding_char, (max_col_lens[i] - #col) + 1)
            if i == #row then
                table_row = table_row .. string.format("%s%s%s", col, padding, right_sep)
                break
            end
            table_row = table_row .. string.format("%s%s%s%s", col, padding, center_sep, padding_char)
        end

        return table_row .. opts.newline
    end

    local border_row = {}
    for _, n in ipairs(max_col_lens) do
        table.insert(border_row, string.rep(opts.border.horizontal, n + 1))
    end

    -- header
    result = result
        .. generateTableRow(
            border_row,
            opts.border.horizontal,
            opts.border.horiz_sep_top,
            opts.border.topleft,
            opts.border.topright
        )
    if #headers > 0 then
        result = result
            .. generateTableRow(headers, opts.padding, opts.border.vertical, opts.border.vertical, opts.border.vertical)
        result = result
            .. generateTableRow(
                border_row,
                opts.border.horizontal,
                opts.border.center_sep,
                opts.border.vert_sep_left,
                opts.border.vert_sep_right
            )
    end

    -- body
    for _, row in ipairs(tbl) do
        result = result
            .. generateTableRow(row, opts.padding, opts.border.vertical, opts.border.vertical, opts.border.vertical)
    end

    return result
        .. generateTableRow(
            border_row,
            opts.border.horizontal,
            opts.border.horiz_sep_bottom,
            opts.border.bottomleft,
            opts.border.bottomrright
        )
end

--- Helper function to recursively search a directory for files.
--- This uses an OS-specific command to search for files, so it may not work
--- on Windows OS.
---
--- @param root string The path of the directory to search.
--- @param pattern string The pattern to match filenames against.
--- @param recursive? boolean Whether to recursively search subdirectories. (Default: true)
---
--- @return table files A table of all files matching the pattern.
local function dirSearch(root, pattern, recursive)
    -- FIXME: Check OS and use appropriate command, and sanitize input.
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

--- Write the list to a file.
local function writeToFile(filename, plugins, plugins_with_errors)
    local file = io.open(filename, "w")
    if not file then
        error(string.format("Failed to open file %s.", filename))
        return
    end

    file:write("Plugins:\n\n")
    for _, row in ipairs(plugins) do
        file:write(string.format("- [%s](%s)\n", row[1], row[2]))
    end

    file:write("\nPlugins with errors:\n\n")
    for _, row in ipairs(plugins_with_errors) do
        file:write(row[1] .. "\n")
    end

    file:close()
end

--- The main function.
---
--- @param plugins_root string The path of the plugins directory.
---
--- @return number n The exit code.
function Main(plugins_root)
    -- FIXME: plugins that use neovim functions in their spec will cause an error.
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
                        path,
                        lazy_plugin[1] or lazy_plugin.url,
                    })
                end
            else
                table.insert(plugin_names, {
                    path,
                    plugin[1] or plugin.url,
                })
            end
        else
            table.insert(plugins_with_errors, { path, plugin })
        end
    end

    io.write(generateTable(plugin_names, { "Filepath", "Plugin Source" }))
    io.write(string.format("\nFailed to get information about %d plugins.\n", #plugins_with_errors))
    io.write("Do you want to see more information about these plugins? [y/N] >>> ")

    local answer = io.read("*l")
    if answer:lower() == "y" then
        for _, pwe in ipairs(plugins_with_errors) do
            local template = "\n==================== %s ====================\n%s\n"
            io.write(string.format(template, pwe[1], pwe[2]))
        end
    end

    writeToFile("plugins_list.md", plugin_names, plugins_with_errors)
    io.write("Written output to plugins_list.md\n")

    return 0
end

os.exit(Main(arg[1]))
