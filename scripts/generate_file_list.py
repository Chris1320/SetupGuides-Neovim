#!/usr/bin/env python3

"""
Generate a text file containing a list of all files in `src/` directory.
"""

import os
import sys
from typing import Final

FILELIST_PATH: Final[str] = "files.txt"
# <branch> will be replaced by install script.
URL: Final[str] = (
    "https://raw.githubusercontent.com/Chris1320/SetupGuides-Neovim/<branch>"
)


def main() -> int:
    """
    The main function.
    """
    files: list[str] = []
    for dirpath, _, filenames in os.walk("src"):  # Scan all files in `src/`
        for filename in filenames:
            filepath = "/".join((dirpath, filename))
            files.append("/".join((URL, filepath)))

    files.sort()  # So that Git can diff easily.
    with open(FILELIST_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(files))

    print(f"Written {len(files)} lines in {FILELIST_PATH}.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
