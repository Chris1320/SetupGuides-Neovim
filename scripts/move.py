#!/usr/bin/env python3

"""
Move Neovim directories to a temporary location and vice versa.
"""

import pathlib
import shutil
import sys
from typing import Final

# This list includes all directories that are used by Neovim.
SOURCE_PATHS: Final[list[str]] = [
    "~/.config/nvim",
    "~/.local/share/nvim",
    "~/.local/state/nvim",
    "~/.cache/nvim",
]
PATH_SUFFIX: Final[str] = ".bak"


def get_original_path(path: str) -> pathlib.Path:
    """
    Return the original path of the directory.
    """

    return pathlib.Path(path).expanduser()


def get_backup_path(path: str) -> pathlib.Path:
    """
    Return the backup path of the directory.
    """

    return pathlib.Path(path + PATH_SUFFIX).expanduser()


def main(return_to_original: bool = False, force: bool = False) -> int:
    """
    Temporarily rename Neovim directories to test new configuration changes.

    :param return_to_original: Return to the original directory names.
    :returns: 0 on success, 1 on failure.
    """

    for path in SOURCE_PATHS:
        source = (
            get_backup_path(path) if return_to_original else get_original_path(path)
        )
        destination = (
            get_original_path(path) if return_to_original else get_backup_path(path)
        )
        try:
            if not source.exists():
                print(f"[!] The directory `{source}` does not exist.")
                continue

            if destination.exists():
                if not force:
                    if (
                        input(
                            f"    [!] The directory `{destination}` already exists. Overwrite? (y/n) > "  # pylint: disable=line-too-long
                        )
                        != "y"
                    ):
                        print(f"[+] Skipping `{source}`.")
                        continue

                shutil.rmtree(destination)

            print(f"[+] Renaming `{source}` to `{destination}`.")
            shutil.move(source, destination)

        except Exception as e:  # pylint: disable=broad-exception-caught
            print(f"[!] Failed to rename `{source}` to `{destination}`.")
            print(f"[!] Error: {e}")
            return 1

    return 0


if __name__ == "__main__":
    if "--return" in sys.argv:
        if "--force" in sys.argv:
            print("[*] Forcibly returning to original directory names.")
            sys.exit(main(return_to_original=True, force=True))

        else:
            print("[*] Returning to original directory names.")
            sys.exit(main(return_to_original=True))

    print("[*] Renaming directories.")
    sys.exit(main())
