#!/usr/bin/env sh

if [ -n "$VIRTUAL_ENV" ]
then
    FLAKE8_BIN=$(which flake8)
    if [[ $? == 0 && "$FLAKE8_BIN" =~ "$VIRTUAL_ENV" ]]
    then
        exec "$FLAKE8_BIN" "$@"
    fi
fi

PYTHON_VERSION=$(python -V 2>&1 >/dev/null | ( IFS=".$IFS" ; read a b c && echo $b))
FLAKE8_BIN="$HOME/.vim/plugged-nvim/python-support.nvim/autoload/nvim_py$PYTHON_VERSION/bin/flake8"
exec "$FLAKE8_BIN" "$@"
