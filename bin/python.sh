#!/usr/bin/env sh

PYTHON_VERSION=`python -V 2>&1 >/dev/null | ( IFS=".$IFS" ; read a b c && echo $b)`
exec "$HOME/.vim/plugged-nvim/python-support.nvim/autoload/nvim_py$PYTHON_VERSION/bin/python" "$@"
