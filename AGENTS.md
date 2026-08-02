# AGENTS.md

Neovim configuration setup repository built on **LazyVim**.

## Core Constraints & Gotchas

- **Configuration Source**: All Neovim configuration files must be edited in `src/` (e.g., `src/lua/plugins/`), NOT at the repository root.
- **`files.txt` Manifest**: Any addition, deletion, or renaming of files under `src/` requires updating `files.txt`:

  ```bash
  python3 scripts/generate_file_list.py
  ```

  Enable automatic generation on commit:

  ```bash
  git config core.hooksPath .git-hooks
  ```

- **Neovim Version Requirement**: Installer enforces Neovim `>= 0.12.0`.

## Developer Commands

### Linting & Formatting

- **Lua Linting**: `selene .` (uses `selene.toml` and `.selene.neovim.yaml`)
- **Lua Formatting**: `stylua .` (or `stylua --check .` for CI check; 2 spaces, 120 column width)
- **Python Linting**: `pylint scripts/move.py scripts/generate_file_list.py` (pyright and pylint used in Neovim setup)
- **Markdown Linting**: `markdownlint .`
- **Shell Format Check**: `shfmt -d install scripts/reset.sh`

### Setup & Directory Operations

- **Install Local Config**: `./install` (overwrites `~/.config/nvim` with `src/`)
- **Backup Neovim Directories**: `python3 scripts/move.py` (safely moves `~/.config/nvim`, `~/.local/share/nvim`, `~/.local/state/nvim`, `~/.cache/nvim` to `.bak`)
- **Restore Backups**: `python3 scripts/move.py --return`
- **Reset Neovim State**: `./scripts/reset.sh` (destructive; removes all Neovim config, share, state, and cache directories)

## Conventions

- **Mason Packages**: Managed via `mason_packages` list in `src/lua/config/misc.lua` and auto-installed on startup by `src/lua/plugins/mason.nvim.lua`.
