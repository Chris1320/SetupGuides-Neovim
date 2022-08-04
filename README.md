# Neovim

This guide will help you install Neovim and the following plugins:

- Plugin Manager
    - [packer](https://github.com/wbthomason/packer.nvim): Plugin Manager for Neovim.
- Linting and Syntax Checking
    - [copilot.vim](https://github.com/github/copilot.vim): GitHub Copilot for Vim.
    - [lsp_lines.nvim](https://git.sr.ht/%7Ewhynothugo/lsp_lines.nvim): Show LSP diagnostics in a separate line.
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Language Server Protocol (LSP) configuration helper.
    - [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer): Make installation of LSP servers easier.
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Better syntax highlighting.
    - [trouble.nvim](https://github.com/folke/trouble.nvim): Error and status line manager.
- Fuzzy Search
    - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Fuzzy Finder.
- Theming and Visual Plugins
    - [barbar.nvim](https://github.com/romgrk/barbar.nvim): Better tabs for Neovim.
    - [catppuccin](https://github.com/catppuccin/nvim): A Neovim theme.
    - [feline.nvim](https://github.com/feline-nvim/feline.nvim): A customizable statusline.
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Git Integration for buffers.
    - [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Indentation guides
    - [twilight.nvim](https://github.com/folke/twilight.nvim): Dim inactive parts of your code.
    - [which-key.nvim](https://github.com/folke/which-key.nvim): Show available key bindings.
- Code Completion
    - [auto-pairs](https://github.com/jiangmiao/auto-pairs): Bracket auto-pairing
    - [coq_nvim](https://github.com/ms-jpq/coq_nvim/): Code completion.
    - [coq.artifacts](https://github.com/ms-jpq/coq.artifacts): COQ snippets.
    - [coq.thirdparty](https://github.com/ms-jpq/coq.thirdparty): COQ 3rd-party integration.
    - [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): Auto-close/rename HTML tags.
- File Explorer
    - [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua): File explorer tree
- Dependencies
    - [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons): Provides filetype icons.
    - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): A Lua library.

**Custom Key Bindings**:

| Key           | Resulting Command                      | Action                                       | Plugin    |
|---------------|----------------------------------------|----------------------------------------------|-----------|
| `,`           |                                        | Leader key                                   |           |
|               |                                        |                                              |           |
| `<leader>/`   | `:nohlsearch`                          | Clear last search highlight                  |           |
|               |                                        |                                              |           |
| `<A-,>`       | `:BufferPrevious`                      | Go to previous buffer                        | Barbar    |
| `<A-.>`       | `:BufferNext`                          | Go to next buffer                            | Barbar    |
| `<A-1>`       | `:BufferGoto 1`                        | Go to the first buffer                       | Barbar    |
| `<A-2>`       | `:BufferGoto 2`                        | Go to the second buffer                      | Barbar    |
| `<A-3>`       | `:BufferGoto 3`                        | Go to the third buffer                       | Barbar    |
| `<A-4>`       | `:BufferGoto 4`                        | Go to the fourth buffer                      | Barbar    |
| `<A-5>`       | `:BufferGoto 5`                        | Go to the fifth buffer                       | Barbar    |
| `<A-6>`       | `:BufferGoto 6`                        | Go to the sixth buffer                       | Barbar    |
| `<A-7>`       | `:BufferGoto 7`                        | Go to the seventh buffer                     | Barbar    |
| `<A-8>`       | `:BufferGoto 8`                        | Go to the eighth buffer                      | Barbar    |
| `<A-9>`       | `:BufferGoto 9`                        | Go to the ninth buffer                       | Barbar    |
| `<A-0>`       | `:BufferLast`                          | Go to the last buffer                        | Barbar    |
| `<A-<>`       | `:BufferMovePrevious`                  | Move current buffer to [i-1]                 | Barbar    |
| `<A->>`       | `:BufferMoveNext`                      | Move current buffer to [i+1]                 | Barbar    |
| `<leader>bp`  | `:BufferPin`                           | Pin the current buffer                       | Barbar    |
| `<leader>bon` | `:BufferOrderByBufferNumber`           | Order buffers by buffer number               | Barbar    |
| `<leader>bod` | `:BufferOrderByDirectory`              | Order buffers by directory                   | Barbar    |
| `<leader>bol` | `:BufferOrderByLanguage`               | Order buffers by language                    | Barbar    |
| `<leader>bow` | `:BufferOrderByWindowNumber`           | Order buffers by windows number              | Barbar    |
| `<leader>be`  | `:BarbarEnable`                        | Enable Barbar                                | Barbar    |
| `<leader>bd`  | `:BarbarDisable`                       | Disable Barbar                               | Barbar    |
|               |                                        |                                              |           |
| `<leader>tt`  | `:Telescope`                           | Toggle Telescope                             | Telescope |
| `<leader>tb`  | `:Telescope buffers`                   | Toggle Telescope Buffer Searcher             | Telescope |
| `<leader>tF`  | `:Telescope find_files`                | Toggle Telescope File Searcher               | Telescope |
| `<leader>ts`  | `:Telescope treesitter`                | Toggle Telescope treesitter explorer         | Telescope |
| `<leader>tf`  | `:Telescope current_buffer_fuzzy_find` | Toggle fuzzy finder for current buffer       | Telescope |
|               |                                        |                                              |           |
| `<leader>ewd` | `:TroubleToggle workspace_diagnostics` | Toggle Trouble workspace diagnostics panel   | Trouble   |
| `<leader>edd` | `:TroubleToggle document_diagnostics`  | Toggle Trouble document diagnostics panel    | Trouble   |
| `<leader>eqf` | `:TroubleToggle quickfix`              | Toggle Trouble quick fix panel               | Trouble   |
| `<leader>elr` | `:TroubleToggle lsp_references`        | Toggle Trouble LSP References panel          | Trouble   |
| `<leader>elc` | `:TroubleToggle loclist`               | Toggle Trouble Location List panel           | Trouble   |
|               |                                        |                                              |           |
| `<leader>l`   |                                        | Toggle LSP Lines and LSP virtual text        | LSP Lines |
|               |                                        |                                              |           |
| `<leader>fo`  | `:NvimTreeOpen`                        | Open Nvim-tree                               | Nvim-tree |
| `<leader>fc`  | `:NvimTreeClose`                       | Close Nvim-tree                              | Nvim-tree |
| `<leader>ff`  | `:NvimTreeFocus`                       | (Open and) Focus the cursor to Nvim-tree     | Nvim-tree |
| `<leader>ft`  | `:NvimTreeToggle`                      | Toggle Nvim-tree file explorer               | Nvim-tree |
|               |                                        |                                              |           |
| `<leader>cc`  | `:COQnow --shut-up`                    | Enable code completion.                      | COQ       |
|               |                                        |                                              |           |
| `<leader>gdt` | `:Gitsigns diffthis`                   | Show `git diff` result of the current buffer | Gitsigns  |
|               |                                        |                                              |           |
| `<leader>z`   | `:Twilight`                            | Toggle Twilight.                             | Twilight  |

**Tested on the following platforms**:

- Kali Linux WSL
- Linux Mint
- Termux Android Terminal Emulator

*Windows version of this guide will be available soon.*

## Installation Script

*WIP*

## Customization Guide

1. Installing Neovim
    - Check if Neovim v0.7.2+ is available in your package manager. `$ apt show neovim`
    - If version 0.7.2 above is available, install it. `$ apt install --upgrade neovim`
    - Otherwise, download it from [their GitHub repository](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb) and install it. `$ dpkg -i nvim-linux64.deb`[^1]
2. Clone and install packer. `$ git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Copy the contents of [neovim-init/](https://github.com/Chris1320/SetupGuides/tree/main/resources/neovim-init) to your `~/.config/nvim/`. The directory must look like this:

    ```
    $ tree ~/.config/nvim/
    /home/<user>/.config/nvim/
    ├── init.lua
    └── lua
        └── plugins.lua
        └── vars.lua

    1 directory, 3 files
    ```

4. Install dependencies. `$ sudo apt install --upgrade clang curl python3 python3-pip python3-venv`[^2]
5. Run `nvim`. Packer will now update, install, and compile the plugins.
6. After installation, quit Neovim by entering `:q`.
7. Open `~/.config/nvim/vars.lua` and change the value of `installed` from `false` to `true`. (The resulting line must be `installed = true`)
8. Open `nvim`. nvim-treesitter will now install treesitter parsers. Run `:TSInstallInfo` to check if all languages you want to installed are now installed.[^3]
9. Run `:COQdeps` to install dependencies for COQ.
10. Enter `:PackerStatus` to verify all plugins are installed.
11. To check if everything is installed correctly, enter `:checkhealth`.
12. (*Optional*) Install LSP servers by running `:LspInstall <server>` inside Neovim.[^4] (Run `:LspInstallInfo` for more information.)
13. (*Optional*) Setup GitHub Copilot. `:Copilot setup`[^5]

[^1]: To download and install using wget and dpkg: `wget -O ./nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && sudo dpkg -i ./nvim-linux64.deb`
[^2]: You can also install optional additional packages used by Telescope and COQ: `$ sudo apt install --upgrade fd-find ripgrep bc` (`fd-find` is `fd` on Termux systems.)
[^3]: You can install a language by running `:TSInstall <language>` or editing the `languages` variable in `~/.config/nvim/lua/plugins.lua`. Read [the documentation](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages) for more information.
[^4]: Manual configuration is necessary for each LSP server.
[^5]: A GitHub account with Copilot subscription is required.

-----

**References**:

- [Neovim configuration for beginners](https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84)
- [Catppuccin for NeoVim](https://github.com/catppuccin/nvim)
- [Basic Neovim LSP Setup](https://codevion.github.io/#!vim/treelsp.md)

