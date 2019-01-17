#!/usr/bin/env sh

PYENV=$(dirname "$0")/pyv.sh
exec $PYENV isort "$@"
