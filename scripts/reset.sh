#!/usr/bin/env bash

echo "WARNING: This will remove all your nvim configuration and plugins. Press ENTER to continue or CTRL-C to abort."
read -r
rm -rf "$HOME/.config/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"
