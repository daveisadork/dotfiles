#!/usr/bin/env sh

if [ -n "$VIRTUAL_ENV" ]
then
    PYLS_BIN=$(which pyls)
    if [[ $? == 0 && "$PYLS_BIN" =~ "$VIRTUAL_ENV" ]]
    then
        exec "$PYLS_BIN" "$@"
    fi
fi

PYTHON_VERSION=$(python -V 2>&1 >/dev/null | ( IFS=".$IFS" ; read a b c && echo $b))
PYLS_BIN="$HOME/.vim/plugged-nvim/python-support.nvim/autoload/nvim_py$PYTHON_VERSION/bin/pyls"
exec "$PYLS_BIN" "$@"
