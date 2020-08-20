#!/usr/bin/env python
import os
import sys
import black
import isort

def main():
    filename = sys.argv[1] if len(sys.argv) > 1 else "-"
    if filename == "-":
        a_name, b_name = "STDIN", "STDOUT"
        code = sys.stdin.read()
    else:
        a_name = b_name = filename
        with open(filename) as infile:
            code = infile.read()

    sorter = isort.SortImports(file_contents=code)
    formatted = black.format_str(sorter.output, mode=black.FileMode())
    sys.stdout.write(black.diff(code, formatted, a_name, b_name))

if __name__ == "__main__":
    main()
