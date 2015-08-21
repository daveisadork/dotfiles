VENV_BASE=$HOME/.venv
PWD=$(basename `pwd`)

ACTIVATE="$VENV_BASE/$PWD/bin/activate"

if [[ -z $VIRTUAL_ENV ]]; then
    if [[ -a $ACTIVATE ]]; then
        source $ACTIVATE
        export AUTO_VENV="$VIRTUAL_ENV"
    fi
fi
