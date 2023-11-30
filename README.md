# Neovim

This guide will help you install [Neovim](https://neovim.io/) and plugins that I use. I frequently work with terminals and I find [Vim](https://www.vim.org/) really helpful when editing code and text without needing a GUI. However, I didn't have the time and motivation to learn VimScript, but then I heard about Neovim. I have some experience with Lua so I thought that I might give it a try, and this is the result. Note that I am not an experienced Neovim (and Lua) user so expect that there will be occasional bugs.

## Plugins List

- Code Completion
  - [Comment.nvim](https://github.com/numToStr/Comment.nvim): Smart and powerful comment plugin for Neovim.
  - [nvim-autopairs](https://github.com/windwp/nvim-autopairs): A super powerful autopair plugin for Neovim that supports multiple characters.
  - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for neovim coded in Lua.
    - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer): nvim-cmp source for buffer words.
    - [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline): nvim-cmp source for cmdline.
    - [cmp-git](https://github.com/petertriho/cmp-git): nvim-cmp source for git.
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): nvim-cmp source for neovim builtin LSP client.
    - [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua): nvim-cmp source for nvim lua.
    - [cmp-path](https://github.com/hrsh7th/cmp-path): nvim-cmp source for filesystem paths.
    - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip): nvim-cmp source for LuaSnip.
      - [LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine for Neovim written in Lua.
      - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets): Snippet collection for different programming languages.
  - [nvim-surround](https://github.com/kylechui/nvim-surround): Add/change/delete surrounding delimiter pairs with ease.
- Debugging
  - [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim): mason.nvim and nvim-dap integration.
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap): Debug Adapter Protocol client implementation for Neovim.
  - [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): A UI for nvim-dap.
  - [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text): Adds virtual text support to nvim-dap.
- File Explorer
  - [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua): File explorer tree
- Fuzzy Search
  - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy Finder.
    - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim): Telescope native sorter.
- Linting and Syntax Checking/Highlighting
  - [conform.nvim](https://github.com/stevearc/conform.nvim): Lightweight yet powerful formatter plugin for Neovim.
  - [nvim-lint](https://github.com/mfussenegger/nvim-lint): An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Language Server Protocol (LSP) configuration helper.
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Better syntax highlighting.
  - [trouble.nvim](https://github.com/folke/trouble.nvim): Error and status line manager.
  - [vim-illuminate](https://github.com/RRethy/vim-illuminate): Highlight all occurrences of words under cursor.
- Plugin Managers
  - [lazy.nvim](https://github.com/folke/lazy.nvim): A modern plugin manager for Neovim.
  - [mason.nvim](https://github.com/williamboman/mason.nvim): LSP/DAP servers, linters, and formatters.
    - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): lspconfig integration for Mason.
    - [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim): Install and upgrade third party tools automatically.
- Proprietary Plugins[^4]
  - [copilot.lua](https://github.com/zbirenbaum/copilot.lua): Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot.
- Quality-of-Life Plugins
  - [gitignore.nvim](https://github.com/wintermute-cell/gitignore.nvim): A neovim plugin for generating .gitignore files.
- Theming and Visual Plugins
  - [barbar.nvim](https://github.com/romgrk/barbar.nvim): Better tabs for Neovim.
  - [catppuccin](https://github.com/catppuccin/nvim): A Neovim theme.
  - [ccc.nvim](https://github.com/uga-rosa/ccc.nvim): Color picker and highlighter plugin for Neovim.
  - [dressing.nvim](https://github.com/stevearc/dressing.nvim): A UI customization plugin.
  - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git Integration for buffers.
  - [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation guides.
  - [lspkind.nvim](https://github.com/onsails/lspkind.nvim/): VSCode-like pictograms for Neovim LSP completion items.
  - [lsp_lines.nvim](https://git.sr.ht/%7Ewhynothugo/lsp_lines.nvim): Show LSP diagnostics in a separate line.
  - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A Neovim statusline plugin.
  - [nvim-notify](https://github.com/rcarriga/nvim-notify): Notification Manager.
  - [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo): Modern fold in Neovim.
  - [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim): A Neovim plugin hiding your colorcolumn when unneeded.
  - [which-key.nvim](https://github.com/folke/which-key.nvim): Show available key bindings.

## Custom Key Bindings

The `which-key` plugin will show you available keymaps as you type.

| Key     | Resulting Command     | Action                                         | Source/Plugin |
| ------- | --------------------- | ---------------------------------------------- | ------------- |
| `,`     |                       | Leader key                                     | Neovim        |
|         |                       |                                                |               |
| `<A-,>` | `:BufferPrevious`     | Go to previous buffer                          | Barbar        |
| `<A-.>` | `:BufferNext`         | Go to next buffer                              | Barbar        |
| `<A-1>` | `:BufferGoto 1`       | Go to the first buffer                         | Barbar        |
| `<A-2>` | `:BufferGoto 2`       | Go to the second buffer                        | Barbar        |
| `<A-3>` | `:BufferGoto 3`       | Go to the third buffer                         | Barbar        |
| `<A-4>` | `:BufferGoto 4`       | Go to the fourth buffer                        | Barbar        |
| `<A-5>` | `:BufferGoto 5`       | Go to the fifth buffer                         | Barbar        |
| `<A-6>` | `:BufferGoto 6`       | Go to the sixth buffer                         | Barbar        |
| `<A-7>` | `:BufferGoto 7`       | Go to the seventh buffer                       | Barbar        |
| `<A-8>` | `:BufferGoto 8`       | Go to the eighth buffer                        | Barbar        |
| `<A-9>` | `:BufferGoto 9`       | Go to the ninth buffer                         | Barbar        |
| `<A-0>` | `:BufferLast`         | Go to the last buffer                          | Barbar        |
| `<A-<>` | `:BufferMovePrevious` | Move current buffer to [i-1]                   | Barbar        |
| `<A->>` | `:BufferMoveNext`     | Move current buffer to [i+1]                   | Barbar        |
|         |                       |                                                |               |
| `<esc>` |                       | Close the `nvim-cmp` panel if open.            | nvim-cmp      |
| `<cr>`  |                       | Accept suggestion if `nvim-cmp` panel is open. | nvim-cmp      |

## Platform Compatibility

This setup has been tested on the following platforms:

- Arch Linux
- Kali Linux WSL
- Linux Mint 21
- Termux Android Terminal Emulator

## Requirements

- [Neovim](https://neovim.io/) v0.9.0+
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
   - Check if Neovim v0.9.0+ is available in your package manager. `$ apt show neovim`
   - If version 0.9.0 above is available, install it. `$ apt install --upgrade neovim`
   - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
4. Install requirements.
5. Run the installer.
   - Using _wget_: `bash <(wget -q -O - https://raw.githubusercontent.com/SetupGuides/Neovim/main/install)`
   - Using _curl_: `bash <(curl -sSf https://raw.githubusercontent.com/SetupGuides/Neovim/main/install)`
6. Run `nvim` and allow installation of plugins.
7. Check for errors by running `:checkhealth`.
8. Install LSPs, DAPs, and linters using Mason. `:Mason`

### Manual Customization Guide

1. Install git. `$ sudo apt update -y && sudo apt install -y git`
2. Installing Neovim
   - Check if Neovim v0.9.0+ is available in your package manager. `$ apt show neovim`
   - If version 0.9.0 above is available, install it. `$ apt install --upgrade neovim`
   - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
3. Copy the contents of [src/](https://github.com/SetupGuides/Neovim/tree/main/src) to your `~/.config/nvim/`. The directory must look like this:

   ```text
   $ tree ~/.config/nvim/

   /home/<user>/.config/nvim/
   ├── init.lua
   └── lua
       ├── info.lua
       ├── keymaps.lua
       ├── misc.lua
       ├── options.lua
       ├── plugins
       │   └── <plugin-name>.lua
       └── vars.lua

   5 directories, 34 files
   ```

4. Install dependencies. `$ sudo apt install --upgrade clang curl make nodejs`[^2]
5. Run `nvim`. lazy.nvim will now update, install, and compile the plugins.
6. To check if everything is installed correctly, enter `:checkhealth`.
7. Install LSP/DAP servers, linters, and formatters by running `:Mason` inside Neovim.[^3]

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: You can also install recommended but optional additional packages used by Telescope: `$ sudo apt install --upgrade fd-find ripgrep` (`fd-find` is `fd` on Termux systems.)
[^3]: Manual configuration is necessary for each LSP server, but I configured some of them in `src/lua/plugins/lsp.lua`.
[^4]: Proprietary plugins are optional to install.
