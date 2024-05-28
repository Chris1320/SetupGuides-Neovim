#!/usr/bin/env python3

"""
Generate a text file containing a list
of all files in `src-*/` directories.
"""

import os
import sys
from typing import Final

FILELIST_PATH: Final[str] = "files"  # The directory where we will put the filelists.
# <branch> will be replaced by install script.
URL: Final[str] = "https://raw.githubusercontent.com/SetupGuides/Neovim/<branch>"
SRC_DIRS: Final[tuple[str, ...]] = ("src-full", "src-lite")


def main() -> int:
    """
    The main function.
    """

    if not os.path.isdir(FILELIST_PATH):
        os.mkdir(FILELIST_PATH)

    for src_dir in SRC_DIRS:
        files: list[str] = []
        for dirpath, _, filenames in os.walk(src_dir):
            for filename in filenames:
                filepath = "/".join((dirpath, filename))
                files.append("/".join((URL, filepath)))

        files.sort()  # So that Git can diff easily.
        output_path: str = os.path.join(
            FILELIST_PATH, f"{src_dir.partition('-')[2]}.txt"
        )

        with open(output_path, "w", encoding="utf-8") as f:
            f.write("\n".join(files))

        print(f"Written {len(files)} lines in {output_path}.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
