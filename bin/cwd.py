#!/usr/bin/env python

import os
import sys


IMPORTANT = {
    ".git",
    "Pipfile",
    "package.json",
    "requirements.txt",
    "setup.cfg",
    "setup.py",
}

HOME = os.environ["HOME"]


def do_split(path):
    if path == HOME:
        return "~", ""

    head, tail = os.path.split(path)
    if not tail or tail.startswith(".") or IMPORTANT.intersection(os.listdir(path)):  # noqa
        return head, tail

    dirs = os.listdir(head)
    dirs.remove(tail)
    dirs = [d for d in dirs if os.path.isdir(os.path.join(head, d))]

    for index in range(1, len(tail) + 1):
        shortened = tail[:index]
        dirs = [d for d in dirs if d.startswith(shortened)]
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
        parts.insert(0, tail)
        head, tail = do_split(head)

    parts.insert(0, head)
    return os.path.join(*parts)


def get_cwd():
    PWD = os.environ.get("PWD")
    cwd = os.getcwd()
    if os.path.samefile(PWD, cwd):
        return PWD

    return cwd


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
