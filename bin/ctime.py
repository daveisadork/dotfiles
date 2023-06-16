#!/usr/bin/env python

import os
import sys

from datetime import date

import dircolors

dc = dircolors.Dircolors()

def print_times(path: str):
    stat = os.stat(path)
    ctime = date.fromtimestamp(stat.st_ctime).isoformat()
    mtime = date.fromtimestamp(stat.st_mtime).isoformat()
    head, name = os.path.split(path)
    name = dc.format(name, cwd=head)
    if os.path.isdir(path):
        name = f"{name}/"

    if os.path.islink(path):
        name = f"{name}@"

    print("  ".join((ctime, mtime, name)))

def main():
    if len(sys.argv) > 1:
        base = sys.argv[-1]
    else:
        base = os.getcwd()
    print("created     modified    name")
    if os.path.isdir(base):
        for path in sorted(os.listdir(base)):
            print_times(os.path.join(base, path))
    else:
        print_times(base)

if __name__ == "__main__":
    main()
