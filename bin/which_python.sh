#!/usr/bin/env zsh

APP="${1:-python}"

_python="$VIRTUAL_ENV/bin/$APP";
# If a virtualenv is active, use it
if [ -f $_python ]; then
    echo $_python;
    exit 0;
fi

# Check if poetry has a venv we should use
_python=$(poetry run which $APP 2>/dev/null);
if [ -f "$_python" ]; then
    echo $_python;
    exit 0;
fi

_python=$(which $APP);
# If python is a pyenv shim, use the pyenv version
if [[ "$_python" = "$PYENV_ROOT/shims/$APP" ]]; then
    echo $(pyenv which $APP);
else
    # Otherwise, use the system python
    echo $_python;
fi
