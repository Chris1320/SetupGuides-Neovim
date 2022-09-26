--[[
keymaps.lua - This is part of a custom config file for Neovim v0.7.2+.

You can get it from:
https://github.com/SetupGuides/Neovim

This modules defines keymaps for the end-user.
]]--

local vars = require("vars")  -- Get variables.
local info = require("info")  -- Get version

-- Check if the config has been installed already.
local plugins_installed_path = io.open(vars["plugins_installed_path"], 'r')
if plugins_installed_path == nil then
    First_run = true

else
    if plugins_installed_path:read() == "v" .. info["version"][1] .. '.' .. info["version"][2] .. '.' .. info["version"][3] then
        First_run = false

    else
        First_run = true

    end
end

-- Set Neovim shortcuts
vim.keymap.set('n', "<leader>/", ":nohlsearch<cr>", {noremap=true, silent=true, desc="Remove last search highlights"})
vim.keymap.set('n', "<leader>w", ":set wrap!<cr>", {noremap=true, silent=true, desc="Toggle word wrap"})

-- Barbar shortcuts
if not First_run then
    vim.keymap.set('n', "<A-,>", ":BufferPrevious<cr>", {noremap=true, silent=true})                               -- Navigate buffers
    vim.keymap.set('n', "<A-.>", ":BufferNext<cr>", {noremap=true, silent=true})

    vim.keymap.set('n', "<A-1>", ":BufferGoto 1<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-2>", ":BufferGoto 2<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-3>", ":BufferGoto 3<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-4>", ":BufferGoto 4<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-5>", ":BufferGoto 5<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-6>", ":BufferGoto 6<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-7>", ":BufferGoto 7<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-8>", ":BufferGoto 8<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-9>", ":BufferGoto 9<cr>", {noremap=true, silent=true})
    vim.keymap.set('n', "<A-0>", ":BufferLast<cr>", {noremap=true, silent=true})

    vim.keymap.set('n', "<A-<>", ":BufferMovePrevious<cr>", {noremap=true, silent=true})                           -- Re-order buffers
    vim.keymap.set('n', "<A->>", ":BufferMoveNext<cr>", {noremap=true, silent=true})

    vim.keymap.set('n', "<leader>bp", ":BufferPin<cr>", {desc="Pin the current buffer"})                           -- More barbar shortcuts
    vim.keymap.set('n', "<leader>bon", ":BufferOrderByBufferNumber<cr>", {desc="Order buffers by buffer number"})
    vim.keymap.set('n', "<leader>bod", ":BufferOrderByDirectory<cr>", {desc="Order buffers by directory"})
    vim.keymap.set('n', "<leader>bol", ":BufferOrderByLanguage<cr>", {desc="Order buffers by language"})
    vim.keymap.set('n', "<leader>bow", ":BufferOrderByWindowNumber<cr>", {desc="Order buffers by window number"})

    vim.keymap.set('n', "<leader>be", ":BarbarEnable", {desc="Enable Barbar"})                                     -- Enable/disable barbar
    vim.keymap.set('n', "<leader>bd", ":BarbarDisable", {desc="Disable Barbar"})
end

-- Telescope shortcuts
if not First_run then
    vim.keymap.set('n', "<leader>tt", ":Telescope<cr>", {desc="Open Telescope"})
    vim.keymap.set('n', "<leader>tb", ":Telescope buffers<cr>", {desc="See open buffers"})
    vim.keymap.set('n', "<leader>tF", ":Telescope find_files<cr>", {desc="Search files"})
    vim.keymap.set('n', "<leader>ts", ":Telescope treesitter<cr>", {desc="See treesitter symbols"})
    vim.keymap.set('n', "<leader>tf", ":Telescope current_buffer_fuzzy_find<cr>", {desc="Search current buffer"})
end

-- Trouble shortcuts
if not First_run then
    vim.keymap.set('n', "<leader>ewd", ":TroubleToggle workspace_diagnostics<cr>", {desc="See workspace diagnostics"})
    vim.keymap.set('n', "<leader>edd", ":TroubleToggle document_diagnostics<cr>", {desc="See document diagnostics"})
    vim.keymap.set('n', "<leader>eqf", ":TroubleToggle quickfix<cr>", {desc="See quick fixes"})
    vim.keymap.set('n', "<leader>elr", ":TroubleToggle lsp_references<cr>", {desc="See LSP references"})
    vim.keymap.set('n', "<leader>elc", ":TroubleToggle loclist<cr>", {desc="See loclists"})
end

-- LSP Lines shortcuts
if not First_run then
    local function toggleLspLines()
        -- Enable virtual text if LSP Lines is disabled.
        local new_value = {
            virtual_text = not vim.diagnostic.config().virtual_text,
            virtual_lines = not vim.diagnostic.config().virtual_lines
        }
        vim.diagnostic.config(new_value)
    end

    vim.keymap.set('n', "<leader>l", toggleLspLines, {desc="Toggle LSP Lines"})
end

-- dap shortcuts
if not First_run then
    vim.keymap.set('n', "<leader>dt", require("dap").toggle_breakpoint, {desc="Toggle Breakpoint"})
    vim.keymap.set('n', "<leader>ds", require("dap").continue, {desc="Start/Resume Debugging"})
    vim.keymap.set('n', "<leader>dz", require("dap").step_over, {desc="Step Over"})
    vim.keymap.set('n', "<leader>dx", require("dap").step_over, {desc="Step Into"})
    vim.keymap.set('n', "<leader>dr", require("dap").repl.open, {desc="Open REPL"})
end

-- nvim-ufo shortcuts
if not First_run then
    vim.keymap.set('n', "zR", require("ufo").openAllFolds)
    vim.keymap.set('n', "zM", require("ufo").closeAllFolds)
end

-- nvim-tree shortcuts
if not First_run then
    vim.keymap.set('n', "<leader>fo", ":NvimTreeOpen<cr>", {noremap=true, silent=true, desc="Open nvim-tree"})
    vim.keymap.set('n', "<leader>fc", ":NvimTreeClose<cr>", {noremap=true, silent=true, desc="Close nvim-tree"})
    vim.keymap.set('n', "<leader>ff", ":NvimTreeFocus<cr>", {noremap=true, silent=true, desc="Focus to nvim-tree"})
    vim.keymap.set('n', "<leader>ft", ":NvimTreeToggle<cr>", {noremap=true, silent=true, desc="Toggle nvim-tree"})
end

-- coq shortcuts
if not First_run then
    local run_coq = function()
        vim.cmd("COQnow --shut-up")
        print("[i] Auto-completion is now active.")
    end

    vim.keymap.set('n', "<leader>c", run_coq, {noremap=true, silent=true, desc="Enable auto-completion"})
end

-- Gitsigns shortcuts
if not First_run then
    -- Logic:
    -- * = lowercase characters
    -- ^ = uppercase characters
    --
    -- [g] Gitsigns
    --     [gP]  Buffer diff preview
    --     [gp*] Hunk preview operations
    --     [gh*] Hunk operations
    --     [gh^] Buffer operations
    --     [gt*] toggles/switches

    vim.keymap.set('n', "<leader>gP", require("gitsigns").diffthis, {noremap=true, silent=true, desc="Show buffer changes"})

    vim.keymap.set('n', "<leader>gps", require("gitsigns").preview_hunk, {noremap=true, silent=true, desc="Preview hunk"})
    vim.keymap.set('n', "<leader>gpa", require("gitsigns").prev_hunk, {noremap=true, silent=true, desc="Preview previous hunk"})
    vim.keymap.set('n', "<leader>gpd", require("gitsigns").next_hunk, {noremap=true, silent=true, desc="Preview next hunk"})

    vim.keymap.set({'n', 'v'}, "<leader>ghs", require("gitsigns").stage_hunk, {noremap=true, silent=true, desc="Stage hunk"})
    vim.keymap.set({'n', 'v'}, "<leader>ghr", require("gitsigns").reset_hunk, {noremap=true, silent=true, desc="Reset hunk"})
    vim.keymap.set('n', "<leader>ghS", require("gitsigns").stage_buffer, {noremap=true, silent=true, desc="Stage current buffer"})
    vim.keymap.set('n', "<leader>ghR", require("gitsigns").reset_buffer, {noremap=true, silent=true, desc="Reset current buffer"})
    vim.keymap.set('n', "<leader>ghu", require("gitsigns").undo_stage_hunk, {noremap=true, silent=true, desc="Undo stage hunk"})

    vim.keymap.set('n', "<leader>gtb", require("gitsigns").toggle_current_line_blame, {noremap=true, silent=true, desc="Toggle line blame"})
    vim.keymap.set('n', "<leader>gtd", require("gitsigns").toggle_deleted, {noremap=true, silent=true, desc="Toggle deleted lines"})
end

-- twilight shortcuts
if not First_run then
    vim.keymap.set('n', "<leader>z", ":Twilight<cr>", {noremap=true, silent=true, desc="Toggle Twilight"})
end
