--[[
keymaps.lua - This is part of a custom config file for Neovim v0.8.0+.

You can get it from:
https://github.com/SetupGuides/Neovim

This modules defines keymaps for the end-user.
]]--

local cmds = require("core.utils.cmds")
local flagFile = require("core.utils.flagFile")

-- Check if the config has been installed already.
local setup_done = flagFile.exists()

return {
    setup = function()
        -- Set Neovim shortcuts
        vim.keymap.set('n', "<leader>/", ":nohlsearch<cr>", {noremap=true, silent=true, desc="Remove last search highlights"})
        vim.keymap.set('n', "<leader>w", ":set wrap!<cr>", {noremap=true, silent=true, desc="Toggle word wrap"})

        -- Neovim LSP shortcuts
        vim.keymap.set('n', "<leader>r", vim.lsp.buf.rename, {noremap=true, silent=true, desc="Rename symbol"})

        -- Barbar shortcuts
        if setup_done then
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

            vim.keymap.set('n', "<leader>be", ":BarbarEnable<cr>", {desc="Enable Barbar"})                                     -- Enable/disable barbar
            vim.keymap.set('n', "<leader>bd", ":BarbarDisable<cr>", {desc="Disable Barbar"})

        -- Telescope shortcuts
            vim.keymap.set('n', "<leader>tt", ":Telescope<cr>", {desc="Open Telescope"})
            vim.keymap.set('n', "<leader>tb", ":Telescope buffers<cr>", {desc="See open buffers"})
            vim.keymap.set('n', "<leader>tF", ":Telescope find_files<cr>", {desc="Search files"})
            vim.keymap.set('n', "<leader>ts", ":Telescope treesitter<cr>", {desc="See treesitter symbols"})
            vim.keymap.set('n', "<leader>tf", ":Telescope current_buffer_fuzzy_find<cr>", {desc="Search current buffer"})
            vim.keymap.set('n', "<leader>tr", ":Telescope lsp_references<cr>", {desc="Show References"})
            vim.keymap.set('n', "<leader>td", ":Telescope lsp_definitions<cr>", {desc="Show Definitions"})

            -- Git integration (Parent keymap `g` is supposed to be owned by Gitsigns plugin.)
            vim.keymap.set('n', "<leader>gs", ":Telescope git_status<cr>", {desc="Show Git status"})
            vim.keymap.set('n', "<leader>gc", ":Telescope git_commits<cr>", {desc="Show Git commits"})
            vim.keymap.set('n', "<leader>gb", ":Telescope git_branches<cr>", {desc="Show Git branches"})

            -- Notify integration
            vim.keymap.set('n', "<leader>th", ":Telescope notify<cr>", {desc="Show notification history"})

        -- Trouble shortcuts
            vim.keymap.set('n', "<leader>ewd", ":TroubleToggle workspace_diagnostics<cr>", {desc="See workspace diagnostics"})
            vim.keymap.set('n', "<leader>edd", ":TroubleToggle document_diagnostics<cr>", {desc="See document diagnostics"})
            vim.keymap.set('n', "<leader>eqf", ":TroubleToggle quickfix<cr>", {desc="See quick fixes"})
            vim.keymap.set('n', "<leader>elr", ":TroubleToggle lsp_references<cr>", {desc="See LSP references"})
            vim.keymap.set('n', "<leader>elc", ":TroubleToggle loclist<cr>", {desc="See loclists"})

        -- LSP Lines shortcuts
            vim.keymap.set(
                'n',
                "<leader>l",
                function()
                    -- Toggle values of `virtual_text` and `virtual_lines`.
                    vim.diagnostic.config(
                        {
                            virtual_text = not vim.diagnostic.config().virtual_text,
                            virtual_lines = not vim.diagnostic.config().virtual_lines
                        }
                    )
                end,
                {desc="Toggle LSP Lines"}
            )

        -- dap shortcuts
        --     vim.keymap.set('n', "<leader>dt", require("dap").toggle_breakpoint, {desc="Toggle Breakpoint"})
        --     vim.keymap.set('n', "<leader>ds", require("dap").continue, {desc="Start/Resume Debugging"})
        --     vim.keymap.set('n', "<leader>dz", require("dap").step_over, {desc="Step Over"})
        --     vim.keymap.set('n', "<leader>dx", require("dap").step_over, {desc="Step Into"})
        --     vim.keymap.set('n', "<leader>dr", require("dap").repl.open, {desc="Open REPL"})
        --     vim.keymap.set('n', "<leader>dp", require("dapui").toggle, {desc="Toggle DAP UI"})

        -- nvim-ufo shortcuts; override folding keymaps.
            vim.keymap.set('n', "zR", require("ufo").openAllFolds)
            vim.keymap.set('n', "zM", require("ufo").closeAllFolds)

        -- nvim-tree shortcuts
            vim.keymap.set('n', "<leader>fo", ":NvimTreeOpen<cr>", {noremap=true, silent=true, desc="Open nvim-tree"})
            vim.keymap.set('n', "<leader>fc", ":NvimTreeClose<cr>", {noremap=true, silent=true, desc="Close nvim-tree"})
            vim.keymap.set('n', "<leader>ff", ":NvimTreeFocus<cr>", {noremap=true, silent=true, desc="Focus to nvim-tree"})
            vim.keymap.set('n', "<leader>ft", ":NvimTreeToggle<cr>", {noremap=true, silent=true, desc="Toggle nvim-tree"})

        -- Gitsigns shortcuts
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

            vim.keymap.set('n', "<leader>iv", cmds.showConfigVersion, {noremap=true, silent=true, desc="Show Neovim config version"})
            vim.keymap.set('n', "<leader>il", ":LspInfo<cr>", {noremap=true, silent=true, desc="Show active LSP information"})
        end
    end
}
