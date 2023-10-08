local vars = require("vars")

-- Disable some built-in plugins
vim.g.loaded_netrw = 1  -- netrw, recommended by nvim-tree
vim.g.loaded_netrwPlugin = 1

-- General options
vim.opt.termguicolors = true  -- enable for consistent color scheme across terminals.
vim.opt.ttyfast = true  -- indicate fast terminal connection to speed up scrolling.
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.mouse = 'a'  -- enable usage of mouse in all modes.
vim.opt.clipboard = "unnamedplus"  -- enable usage of system clipboard.

vim.opt.number = true  -- enable line numbers.
vim.opt.relativenumber = true  -- enable relative line numbers.
vim.opt.colorcolumn = vars.appearance.colorcolumn.default_columns  -- Highlight these columns.
vim.cmd("highlight LineNr ctermfg=" .. vars.appearance.colorscheme.line_number_color)  -- Set the color of the line numbers

vim.opt.showmatch = true  -- show matching brackets.
vim.opt.cursorline = true  -- enable cursor line.
vim.opt.wrap = vars.behavior.line_wrapping  -- Disable line wrapping by default.

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}  -- for completion
vim.opt.wildmode = {"longest", "list"}  -- get bash-like tab completions.

vim.cmd("syntax on")  -- enable syntax highlighting
vim.cmd("filetype plugin indent on")  -- allow auto-indentation depending on file type.
vim.opt.autoindent = true  -- Enable auto indent.
-- vim.opt.smartindent = true  -- Enable smart indent.
vim.opt.indentexpr = "nvim_treesitter#indentexpr()"  -- Use treesitter for indentation.

vim.opt.expandtab = vars.behavior.use_spaces  -- converts tabs to white space.
vim.opt.shiftwidth = vars.behavior.tab_size  -- width for autoindents.
vim.opt.tabstop = vars.behavior.tab_size  -- number of columns occupied by a tab.
vim.opt.softtabstop = vars.behavior.tab_size  -- see multiple spaces as tabstops so <BS> does the right thing.

vim.opt.foldmethod = "manual"  -- use treesitter to determine where to fold.
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- the expression to use for folding.
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

vim.opt.list = true  -- enable display of unprintable characters.
if vars.appearance.show_eols then  -- Enable if you want to display spaces, trailing spaces, and EOLs.
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
