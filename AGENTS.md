# AGENTS.md

Repository: **SetupGuides-Neovim**

This repository contains a distributable Neovim configuration (built on **LazyVim**), automated setup/installation scripts, and continuous integration linting workflows.

## Essential Commands

- **Regenerate raw GitHub file list** (must be run whenever files under `src/` are added, moved, or deleted):

  ```bash
  python3 ./scripts/generate_file_list.py
  ```

  Generates `files.txt` containing URL mappings for remote installation (`scripts/generate_file_list.py:11-33`).

- **Run interactive installer** (destructive; overwrites `~/.config/nvim`):

  ```bash
  ./install
  ```

- **Safely toggle local Neovim config/state/cache dirs for testing**:

  ```bash
  # Back up existing ~/.config/nvim, ~/.local/share/nvim, ~/.local/state/nvim, ~/.cache/nvim to *.bak
  python3 ./scripts/move.py

  # Restore backup directories
  python3 ./scripts/move.py --return
  ```

## Repository Structure

- `src/` — Neovim configuration installed to `~/.config/nvim/`
  - `src/init.lua` — Entrypoint loading `require("config.lazy")` (`src/init.lua:1-2`).
  - `src/lua/config/` — Core LazyVim/Neovim modules:
    - `lazy.lua` — Bootstraps `lazy.nvim` and configures LazyVim specs (`src/lua/config/lazy.lua:1-53`).
    - `options.lua` — Vim options, WSL clipboard integration, and LazyVim variable flags (`src/lua/config/options.lua:1-42`).
    - `keymaps.lua` — Custom keybindings (uses `vim.keymap.set`) (`src/lua/config/keymaps.lua:1-38`).
    - `misc.lua` — Exports list of Mason packages to auto-install (`src/lua/config/misc.lua:1-38`).
    - `autocmds.lua` — Autocommand definitions (`src/lua/config/autocmds.lua:1-9`).
  - `src/lua/plugins/` — Custom plugin specs and LazyVim overrides returning Lua tables:
    - `mason.nvim.lua` — Auto-installs packages configured in `config.misc` (`src/lua/plugins/mason.nvim.lua:1-32`).
    - `conform.lua` — Code formatting specs (`src/lua/plugins/conform.lua:1-91`).
    - `nvim-lint.lua` — Linter configuration (`src/lua/plugins/nvim-lint.lua:1-44`).
    - `lsp.lua` — Language server client settings (`src/lua/plugins/lsp.lua:1-51`).
  - `src/lazyvim.json` — Enabled LazyVim extras list.
- `install` — Bash installer supporting both local file copies and remote downloads from GitHub (`install:1-300`).
- `scripts/` — Helper scripts:
  - `generate_file_list.py` — Walks `src/` and creates `files.txt`.
  - `move.py` — Swaps Neovim runtime directories (`.config/nvim`, `.local/share/nvim`, `.local/state/nvim`, `.cache/nvim`) with `.bak` extensions.
  - `reset.sh` — Deletes local Neovim runtime directories (`scripts/reset.sh:1-6`).
- `files.txt` — Generated list of raw GitHub URLs for remote installer downloads.
- `.git-hooks/pre-commit` — Git hook that automatically runs `generate_file_list.py` and stages `files.txt` on commit (`.git-hooks/pre-commit:1-7`).

## Distribution Mechanism (`files.txt` + installer)

1. `files.txt` contains raw GitHub URLs for every file under `src/`, ordered alphabetically (`scripts/generate_file_list.py:23-31`).
2. The `install` script checks for minimum Neovim version (`0.12.0`). For remote installations, it downloads `files.txt` from GitHub and fetches each file into `~/.config/nvim`.
3. The pre-commit hook guarantees `files.txt` stays in sync with `src/` during git commits.

## Code Conventions & Formatting

- **Indent style**:
  - Lua files use **2-space indentation** configured via `stylua.toml` (`stylua.toml:1-3`).
  - Markdown files use 2-space indentation (`.editorconfig:10-11`).
  - Default project files use 4-space indentation (`.editorconfig:3-8`).
- **Mason package list**:
  - Centralized in `src/lua/config/misc.lua` (`mason_packages`).
  - Ensured and auto-installed on startup via `src/lua/plugins/mason.nvim.lua`.
- **LSP / Formatter Overrides**:
  - `g.lazyvim_python_lsp = "basedpyright"` in `src/lua/config/options.lua`.
  - `g.lazyvim_ts_lsp = "vtsls"` in `src/lua/config/options.lua`.
- **Selene Linting Pragmas**:
  - Lua directives such as `-- selene: allow(unused_variable)` or `--# selene: allow(multiple_statements)` are used where necessary (e.g. `src/lua/config/keymaps.lua:1`).

## CI & Automated Workflows

CI is specified in `.github/workflows/linter.yaml` and executes:

- **Selene** for Lua code linting (`selene.toml` uses `.selene.neovim` standard).
- **Super-Linter** (slim) validating GitHub Actions YAML, Markdown, Python (Pylint), and Shell scripts (shfmt).

## Safety Notes & Gotchas

- **Destructive Operations**: Running `./install` or `scripts/reset.sh` wipes `~/.config/nvim`. Use `python3 ./scripts/move.py` first to back up existing settings.
- **Minimum Neovim Version**: Minimum supported Neovim version is `0.12.0` (`install:23`).
- **Always update file list**: If files in `src/` are modified, created, or deleted, run `python3 ./scripts/generate_file_list.py` to keep `files.txt` synchronized.
