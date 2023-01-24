# Neovim

This guide will help you install [Neovim](https://neovim.io/) and plugins that I use. I frequently work with terminals and I find [Vim](https://www.vim.org/) really helpful when editing code and text without needing a GUI. However, I didn't have the time and motivation to learn VimScript, but then I heard about Neovim. I have some experience with Lua so I thought that I might give it a try, and this is the result. Note that I am not an experienced Neovim (and Lua) user so expect that there will be occasional bugs.

## Plugins List

- Code Completion
    - [LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine for Neovim written in Lua.
        - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets): Snippet collection for different programming languages.
    - [nvim-autopairs](https://github.com/windwp/nvim-autopairs): A super powerful autopair plugin for Neovim that supports multiple characters.
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for neovim coded in Lua.
        - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer): nvim-cmp source for buffer words.
        - [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline): nvim-cmp source for cmdline.
        - [cmp-git](https://github.com/petertriho/cmp-git): nvim-cmp source for git.
        - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): nvim-cmp source for neovim builtin LSP client
        - [cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help): nvim-cmp source for displaying function signatures.
        - [cmp-path](https://github.com/hrsh7th/cmp-path): nvim-cmp source for filesystem paths.
        - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): nvim-cmp source for LuaSnip.
- Dependencies
    - [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons): Provides filetype icons.
    - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): A Lua library.
    - [promise-async](https://github.com/kevinhwang91/promise-async): A port of *Promise & Async* from JavaScript to Lua.
- File Explorer
    - [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua): File explorer tree
- Fuzzy Search
    - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy Finder.
        - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim): Telescope native sorter.
- Linting and Syntax Checking/Highlighting
    - [mason.nvim](https://github.com/williamboman/mason.nvim): LSP/DAP servers, linters, and formatters.
        - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): lspconfig integration for Mason.
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Language Server Protocol (LSP) configuration helper.
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Better syntax highlighting.
    - [trouble.nvim](https://github.com/folke/trouble.nvim): Error and status line manager.
    - [vim-illuminate](https://github.com/RRethy/vim-illuminate): Highlight all occurrences of words under cursor.
- Plugin Manager
    - [packer](https://github.com/wbthomason/packer.nvim): Plugin Manager for Neovim.
- Theming and Visual Plugins
    - [barbar.nvim](https://github.com/romgrk/barbar.nvim): Better tabs for Neovim.
    - [catppuccin](https://github.com/catppuccin/nvim): A Neovim theme.
    - [dressing.nvim](https://github.com/stevearc/dressing.nvim): A UI customization plugin.
    - [feline.nvim](https://github.com/feline-nvim/feline.nvim): A customizable statusline.
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git Integration for buffers.
    - [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation guides.
    - [lsp_lines.nvim](https://git.sr.ht/%7Ewhynothugo/lsp_lines.nvim): Show LSP diagnostics in a separate line.
    - [nvim-notify](https://github.com/rcarriga/nvim-notify): Notification Manager.
    - [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo): Modern fold in Neovim.
    - [which-key.nvim](https://github.com/folke/which-key.nvim): Show available key bindings.

## Custom Key Bindings

The `which-key` plugin will also show you available keymaps as you type.

| Key           | Resulting Command                      | Action                                         | Plugin                |
|---------------|----------------------------------------|------------------------------------------------|-----------------------|
| `,`           |                                        | Leader key                                     |                       |
|               |                                        |                                                |                       |
| `<leader>/`   | `:nohlsearch`                          | Clear last search highlight                    |                       |
| `<leader>w`   | `:set wrap` or `:set nowrap`           | Toggle word wrap.                              |                       |
|               |                                        |                                                |                       |
| `<leader>r`   | `vim.lsp.buf.rename()`                 | Rename highlighted symbol.                     | LSP                   |
|               |                                        |                                                |                       |
| `<A-,>`       | `:BufferPrevious`                      | Go to previous buffer                          | Barbar                |
| `<A-.>`       | `:BufferNext`                          | Go to next buffer                              | Barbar                |
| `<A-1>`       | `:BufferGoto 1`                        | Go to the first buffer                         | Barbar                |
| `<A-2>`       | `:BufferGoto 2`                        | Go to the second buffer                        | Barbar                |
| `<A-3>`       | `:BufferGoto 3`                        | Go to the third buffer                         | Barbar                |
| `<A-4>`       | `:BufferGoto 4`                        | Go to the fourth buffer                        | Barbar                |
| `<A-5>`       | `:BufferGoto 5`                        | Go to the fifth buffer                         | Barbar                |
| `<A-6>`       | `:BufferGoto 6`                        | Go to the sixth buffer                         | Barbar                |
| `<A-7>`       | `:BufferGoto 7`                        | Go to the seventh buffer                       | Barbar                |
| `<A-8>`       | `:BufferGoto 8`                        | Go to the eighth buffer                        | Barbar                |
| `<A-9>`       | `:BufferGoto 9`                        | Go to the ninth buffer                         | Barbar                |
| `<A-0>`       | `:BufferLast`                          | Go to the last buffer                          | Barbar                |
| `<A-<>`       | `:BufferMovePrevious`                  | Move current buffer to [i-1]                   | Barbar                |
| `<A->>`       | `:BufferMoveNext`                      | Move current buffer to [i+1]                   | Barbar                |
| `<leader>bp`  | `:BufferPin`                           | Pin the current buffer                         | Barbar                |
| `<leader>bon` | `:BufferOrderByBufferNumber`           | Order buffers by buffer number                 | Barbar                |
| `<leader>bod` | `:BufferOrderByDirectory`              | Order buffers by directory                     | Barbar                |
| `<leader>bol` | `:BufferOrderByLanguage`               | Order buffers by language                      | Barbar                |
| `<leader>bow` | `:BufferOrderByWindowNumber`           | Order buffers by windows number                | Barbar                |
| `<leader>be`  | `:BarbarEnable`                        | Enable Barbar                                  | Barbar                |
| `<leader>bd`  | `:BarbarDisable`                       | Disable Barbar                                 | Barbar                |
|               |                                        |                                                |                       |
| `<leader>tt`  | `:Telescope`                           | Toggle Telescope                               | Telescope             |
| `<leader>tb`  | `:Telescope buffers`                   | Toggle Telescope Buffer Searcher               | Telescope             |
| `<leader>tF`  | `:Telescope find_files`                | Toggle Telescope File Searcher                 | Telescope             |
| `<leader>ts`  | `:Telescope treesitter`                | Toggle Telescope treesitter explorer           | Telescope, Treesitter |
| `<leader>tf`  | `:Telescope current_buffer_fuzzy_find` | Toggle fuzzy finder for current buffer         | Telescope             |
| `<leader>tr`  | `:Telescope lsp_references`            | Show references of highlighted symbol.         | Telescope, LSP        |
| `<leader>td`  | `:Telescope lsp_definitions`           | Show definitions of highlighted symbol.        | Telescope, LSP        |
| `<leader>th`  | `:Telescope notify`                    | Show notification history.                     | Telescope, Notify     |
| `<leader>gs`  | `:Telescope git_status`                | Show git status.                               | Telescope             |
| `<leader>gc`  | `:Telescope git_commits`               | Show git commits.                              | Telescope             |
| `<leader>gb`  | `:Telescope git_branches`              | Show git branches.                             | Telescope             |
|               |                                        |                                                |                       |
| `<leader>ewd` | `:TroubleToggle workspace_diagnostics` | Toggle Trouble workspace diagnostics panel     | Trouble               |
| `<leader>edd` | `:TroubleToggle document_diagnostics`  | Toggle Trouble document diagnostics panel      | Trouble               |
| `<leader>eqf` | `:TroubleToggle quickfix`              | Toggle Trouble quick fix panel                 | Trouble               |
| `<leader>elr` | `:TroubleToggle lsp_references`        | Toggle Trouble LSP References panel            | Trouble, LSP          |
| `<leader>elc` | `:TroubleToggle loclist`               | Toggle Trouble Location List panel             | Trouble               |
|               |                                        |                                                |                       |
| `<leader>l`   |                                        | Toggle LSP Lines and LSP virtual text          | LSP Lines             |
|               |                                        |                                                |                       |
| `<leader>fo`  | `:NvimTreeOpen`                        | Open Nvim-tree                                 | Nvim-tree             |
| `<leader>fc`  | `:NvimTreeClose`                       | Close Nvim-tree                                | Nvim-tree             |
| `<leader>ff`  | `:NvimTreeFocus`                       | (Open and) Focus the cursor to Nvim-tree       | Nvim-tree             |
| `<leader>ft`  | `:NvimTreeToggle`                      | Toggle Nvim-tree file explorer                 | Nvim-tree             |
|               |                                        |                                                |                       |
| `<leader>gP`  | `gitsigns.diffthis()`                  | Show buffer changes.                           | Gitsigns              |
| `<leader>gps` | `gitsigns.preview_hunk()`              | Preview hunk.                                  | Gitsigns              |
| `<leader>gpa` | `gitsigns.prev_hunk()`                 | Preview previous hunk.                         | Gitsigns              |
| `<leader>gpd` | `gitsigns.next_hunk()`                 | Preview next hunk.                             | Gitsigns              |
| `<leader>ghs` | `gitsigns.stage_hunk()`                | Stage hunk.                                    | Gitsigns              |
| `<leader>ghr` | `gitsigns.reset_hunk()`                | Reset hunk.                                    | Gitsigns              |
| `<leader>ghS` | `gitsigns.stage_buffer()`              | Stage current buffer.                          | Gitsigns              |
| `<leader>ghR` | `gitsigns.reset_buffer()`              | Reset current buffer.                          | Gitsigns              |
| `<leader>ghu` | `gitsigns.undo_stage_hunk()`           | Undo stage hunk.                               | Gitsigns              |
| `<leader>gtb` | `gitsigns.toggle_current_line_blame()` | Toggle line blame.                             | Gitsigns              |
| `<leader>gtd` | `gitsigns.toggle_deleted()`            | Toggle deleted lines.                          | Gitsigns              |
|               |                                        |                                                |                       |
| `<esc>`       |                                        | Close the `nvim-cmp` panel if open.            | Cmp                   |
| `<cr>`        |                                        | Accept suggestion if `nvim-cmp` panel is open. | Cmp                   |

## Platform Compatibility

This setup has been tested on the following platforms:

- Kali Linux WSL
- Linux Mint 21
- Termux Android Terminal Emulator

*Windows version of this guide will be available soon.*

## Requirements

- [Neovim](https://neovim.io/) v0.8.0+
- [Git](https://git-scm.com/)
- [gcc](https://gcc.gnu.org/) or [clang](https://clang.llvm.org/)
- [make](https://www.gnu.org/software/make/)
- [NodeJS](https://nodejs.org/)

## Installation

### Automatic Customization Guide

**NOTE**: This assumes that you are using APT as your package manager.

1. Update APT. `sudo apt update`
2. Install git. `sudo apt install git`
3. Install Neovim.
    - Check if Neovim v0.8.0+ is available in your package manager. `$ apt show neovim`
    - If version 0.8.0 above is available, install it. `$ apt install --upgrade neovim`
    - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
4. Install requirements.
5. Run the installer.
    - Using *wget*: `bash <(wget -q -O - https://raw.githubusercontent.com/SetupGuides/Neovim/main/install)`
    - Using *curl*: `bash <(curl -sSf https://raw.githubusercontent.com/SetupGuides/Neovim/main/install)`
6. Run `nvim` and allow installation of plugins.[^5]
7. Exit Neovim by running `:q` and re-run `nvim` to install tree-sitter grammars.[^3]
8. Configure LSPs using Mason. `:Mason`

### Manual Customization Guide

1. Install git. `$ sudo apt update -y && sudo apt install -y git`
2. Installing Neovim
    - Check if Neovim v0.8.0+ is available in your package manager. `$ apt show neovim`
    - If version 0.8.0 above is available, install it. `$ apt install --upgrade neovim`
    - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
3. Clone and install packer. `$ git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
4. Copy the contents of [src/](https://github.com/Chris1320/SetupGuides/tree/main/resources/src) to your `~/.config/nvim/`. The directory must look like this:

    ```
    $ tree ~/.config/nvim/
    /home/<user>/.config/nvim/
    ├── init.lua
    └── lua
        ├── core
        │   ├── info.lua
        │   └── utils
        │       ├── flagFile.lua
        │       └── misc.lua
        ├── keymaps.lua
        ├── options.lua
        ├── plugins
        │   ├── plugins.lua
        │   └── <plugin name>   <-- Most of the plugins have a `main.lua` file in their directory.
        │       └── main.lua
        ├── post_ops.lua
        └── vars.lua

    23 directories, 28 files
    ```

5. Install dependencies. `$ sudo apt install --upgrade clang curl make nodejs`[^2]
6. Run `nvim`. Packer will now update, install, and compile the plugins.
7. After installation, quit Neovim by entering `:q`.
8. Re-open `nvim`. nvim-treesitter will now install treesitter parsers. Run `:TSInstallInfo` to check if all languages you want to install are now installed.[^3]
9. Enter `:PackerStatus` to verify all plugins are installed.
10. To check if everything is installed correctly, enter `:checkhealth`.
11. Install LSP/DAP servers, linters, and formatters by running `:Mason` inside Neovim.[^4]

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: You can also install recommended but optional additional packages used by Telescope: `$ sudo apt install --upgrade fd-find ripgrep` (`fd-find` is `fd` on Termux systems.)
[^3]: You can install a language by running `:TSInstall <language>` or editing the `languages` variable in `~/.config/nvim/lua/vars.lua`. Read [the documentation](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages) for more information.
[^4]: Manual configuration is necessary for each LSP server, but I configured some of them in `src/lua/plugins/lspconfig/main.lua`.
[^5]: If a Packer installation fails, just retry with `:PackerSync`. You might need to restart Neovim.
