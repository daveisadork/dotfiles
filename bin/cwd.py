#!/usr/bin/env python3

from __future__ import print_function

import os
import sys

IMPORTANT = {
    ".nvmrc",
    ".python-version",
    "Pipfile",
    "main.py",
    "package.json",
    "pyproject.toml",
    "requirements.txt",
    "setup.cfg",
    "setup.py",
    ".git",
}

HOME = os.environ["HOME"]


def do_split(path):
    if path == HOME:
        return "~", ""

    head, tail = os.path.split(path)
    if not tail or tail.startswith(".") or IMPORTANT.intersection(os.listdir(path)):
        return head, tail

    dirs = os.scandir(head)
    dirs = [d.name for d in dirs if d.is_dir()]
    dirs.remove(tail)

    shortened = tail

    for index in range(1, len(tail) + 1):
        shortened = tail[:index]
        dirs = [d for d in dirs if d[:index] == shortened]
        if not dirs:
            break

    return head, shortened


def path_contains_mount(path):
    head, tail = os.path.split(os.path.realpath(path))
    while tail:
        if head == "/":
            break

        if os.path.ismount(head):
            return True

        head, tail = os.path.split(head)

    return False


def shorten(path):
    if path == HOME:
        return "~/"

    if len(path.replace(HOME, "~")) < 16:
        return path.replace(HOME, "~")

    head, tail = os.path.split(path)
    parts = []
    while tail:
        parts.append(tail)
        split_func = os.path.split if path_contains_mount(head) else do_split
        head, tail = split_func(head)

    parts.append(head)
    parts.reverse()
    return os.path.join(*parts)


def get_cwd():
    return os.environ.get("PWD", os.getcwd())
    pwd = os.environ.get("PWD", os.getcwd())
    cwd = os.getcwd()
    print("pwd", pwd)
    print("cwd", cwd)
    if os.path.samefile(pwd, cwd):
        return cwd

    return pwd


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
