#!/usr/bin/env python3

import os
import sys
from typing import Final

FILELIST_PATH: Final[str] = "files.txt"
URL: Final[str] = "https://raw.githubusercontent.com/SetupGuides/Neovim/<branch>"  # <branch> will be replaced by install script.
SEP: Final[str] = '/'


def main() -> int:
    files = []
    for dirpath, _, filenames in os.walk("src"):  # Scan all files in `src/`
        for filename in filenames:
            filepath = f"{dirpath}{SEP}{filename}"
            files.append(f"{URL}{SEP}{filepath}")  # Result: URL + "src/" + file's filepath

    files.sort()
    with open(FILELIST_PATH, 'w') as f:
        f.write('\n'.join(files))

    print(f"Written {len(files)} lines in {FILELIST_PATH}.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
