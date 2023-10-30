local vars = require("vars")

-- Disable some built-in plugins
vim.g.loaded_netrw = 1  -- netrw, recommended by nvim-tree
vim.g.loaded_netrwPlugin = 1

-- General options
vim.opt.termguicolors = true  -- consistent color scheme across terminals.
vim.opt.ttyfast = true  -- speed up scrolling.
vim.opt.scrolloff = 5
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.opt.updatetime = 50

vim.opt.mouse = 'a'  -- enable usage of mouse in all modes.

-- Check if running on WSL.
-- Source: https://mitchellt.com/2022/05/15/WSL-Neovim-Lua-and-the-Windows-Clipboard.html
if os.getenv("WSL_DISTRO_NAME") ~= nil then
    local wsl_copy_cmd = {"clip.exe"}
    local wsl_paste_cmd = {
        "powershell.exe", "-c",
        "[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))"
    }
    vim.g.clipboard = {
        name = "WSL Clipboard",
        copy = {['+']=wsl_copy_cmd, ['*']=wsl_copy_cmd},
        paste = {['+']=wsl_paste_cmd, ['*']=wsl_paste_cmd},
        cache_enabled = true
    }
end

vim.opt.number = true  -- enable line numbers.
vim.opt.relativenumber = true  -- enable relative line numbers.
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = vars.appearance.colorcolumn.default_columns
vim.cmd(  -- Set the color of the line numbers
    "highlight LineNr ctermfg="
        .. vars.appearance.colorscheme.line_number_color
)

vim.opt.showmatch = true  -- show matching brackets.
vim.opt.cursorline = true  -- enable cursor line.
vim.opt.wrap = vars.behavior.line_wrapping

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- for completion
vim.opt.wildmode = {"longest", "list"}  -- get bash-like tab completions.

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")  -- allow auto-indentation depending on file type.
vim.opt.autoindent = true  -- Enable auto indent.
vim.opt.smartindent = true  -- Enable smart indent.
-- vim.opt.indentexpr = "nvim_treesitter#indentexpr()"  -- Use treesitter for indentation.

vim.opt.expandtab = vars.behavior.use_spaces
vim.opt.shiftwidth = vars.behavior.tab_size
vim.opt.tabstop = vars.behavior.tab_size
vim.opt.softtabstop = vars.behavior.tab_size

vim.opt.foldmethod = "manual"
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99  -- Increased for nvim-ufo.
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Search-related configuration
vim.opt.hlsearch = true  -- highlight search results.
vim.opt.incsearch = true  -- enable incremental search.
vim.opt.smartcase = true  -- smart case searching.
vim.opt.ignorecase = true  -- case insensitive when searching.
vim.opt.magic = true  -- enable regex.

vim.cmd("filetype plugin on")  -- enable loading plugins for specific file types.

vim.opt.swapfile = false  -- disable swap files.
-- vim.opt.backup = false  -- disable backup files.

-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.list = true  -- enable display of unprintable characters.
if vars.appearance.show_eols then
    vim.opt.listchars:append("eol:" .. vars.appearance.icons.eol)
end

if vars.appearance.show_spaces then
    vim.opt.listchars:append("space:" .. vars.appearance.icons.space)
end

if vars.appearance.show_trails then
    vim.opt.listchars:append("trail:" .. vars.appearance.icons.trail)
end

vim.opt.fillchars:append(
    {
        fold = vars.appearance.icons.fold.fold,
        foldopen = vars.appearance.icons.fold.open,
        foldclose = vars.appearance.icons.fold.close,
        foldsep = vars.appearance.icons.fold.sep,
        eob = vars.appearance.icons.fold.eob
    }
)
