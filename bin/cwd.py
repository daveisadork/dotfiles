#!/usr/bin/env python

from __future__ import print_function

import os
import sys

IMPORTANT = {
    ".nvmrc",
    ".python-version",
    "Pipfile",
    "main.py",
#    "package.json",
    "pyproject.toml",
    "requirements.txt",
    "setup.cfg",
    "setup.py",
}

HOME = os.environ["HOME"]


def do_split(path):
    if path == HOME:
        return "~", ""

    head, tail = os.path.split(path)
    if (
        not tail
        or tail.startswith(".")
        or IMPORTANT.intersection(os.listdir(path))
    ):
        return head, tail

    dirs = os.scandir(head)
    dirs = [d.name for d in dirs if d.is_dir()]
    dirs.remove(tail)

    for index in range(1, len(tail) + 1):
        shortened = tail[:index]
        dirs = [d for d in dirs if d[:index] == shortened]
        if not dirs:
            break

    return head, shortened


def shorten(path):
    if path == HOME:
        return "~/"

    if len(path.replace(HOME, "~")) < 16:
        return path.replace(HOME, "~")

    head, tail = os.path.split(path)
    parts = []
    while tail:
        parts.append(tail)
        head, tail = do_split(head)

    parts.append(head)
    parts.reverse()
    return os.path.join(*parts)


def get_cwd():
    PWD = os.environ.get("PWD")
    cwd = os.getcwd()
    if os.path.samefile(PWD, cwd):
        return cwd

    return PWD


def main():
    try:
        if len(sys.argv) == 2:
            path = sys.argv[-1]
        else:
            path = get_cwd()

        print(shorten(path))
    except Exception:
        return 1
    else:
        return 0


if __name__ == "__main__":
    sys.exit(main())
