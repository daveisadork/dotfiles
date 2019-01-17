#!/usr/bin/env sh

CMD="$1"
shift

if [ -n "$VIRTUAL_ENV" ]
then
    CMD_BIN=$(which $CMD)
    if [[ $? == 0 && "$CMD_BIN" =~ "$VIRTUAL_ENV" ]]
    then
        exec "$CMD_BIN" "$@"
    fi
fi

PYTHON_VERSION=$(python -V 2>&1 >/dev/null | ( IFS=".$IFS" ; read a b c && echo $b))
if [ "$PYTHON_VERSION" == "" ]
then
    PYTHON_VERSION=$(python -V | ( IFS=".$IFS" ; read a b c && echo $b))
fi

CMD_BIN="$HOME/.vim/plugged-nvim/python-support.nvim/autoload/nvim_py$PYTHON_VERSION/bin/$CMD"
exec "$CMD_BIN" "$@"
