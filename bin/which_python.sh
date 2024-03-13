#!/usr/bin/env bash

_python="$VIRTUAL_ENV/bin/python";
# If a virtualenv is active, use it
if [ -f $_python ]; then
    echo $_python;
    exit 0;
fi

# Check if poetry has a venv we should use
_python=$(poetry run which python 2>/dev/null);
if [ -f "$_python" ]; then
    echo $_python;
    exit 0;
fi

_python=$(which python);
# If python is a pyenv shim, use the pyenv version
if [[ "$_python" = "$PYENV_ROOT/shims/python" ]]; then
    echo $(pyenv which python);
else
    # Otherwise, use the system python
    echo $_python;
fi
