#!/usr/bin/env sh

PYENV=$(dirname "$0")/pyenv.sh
exec $PYENV flake8 "$@"
