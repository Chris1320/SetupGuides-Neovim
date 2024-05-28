return {
    --- Detects the project root of the current buffer.
    --- @param landmarks table A table containing a list of files that are commonly found in the root directory.
    --- @param dir_context? string The directory context to start the search from. (Default: current buffer's directory)
    ---
    --- @return string|nil found_dir The root project of the current buffer. nil if nothing is found.
    -- selene: allow(shadowing)
    detectProjectRoot = function(landmarks, dir_context)
        local dir_context = dir_context or vim.fn.expand("%:p:h") --- @diagnostic disable-line: redefined-local
        local found_landmark = vim.fs.find(landmarks, { upward = true, path = dir_context })
        if found_landmark then
            return vim.fs.dirname(found_landmark[1])
        end
    end,
}
