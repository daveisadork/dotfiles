#!/usr/bin/env sh

if [ -n "$VIRTUAL_ENV" ]
then
    PYLS_BIN=`which pyls`
    if [ $? == 0 ]
    then
        exec "$PYLS_BIN" "$@"
    fi
fi

PYTHON_VERSION=`python -V 2>&1 >/dev/null | ( IFS=".$IFS" ; read a b c && echo $b)`
exec "$HOME/.vim/plugged-nvim/python-support.nvim/autoload/nvim_py$PYTHON_VERSION/bin/pyls" "$@"
