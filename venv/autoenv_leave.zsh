if [[ -n $VIRTUAL_ENV ]]; then
    if [[ -n $AUTO_VENV ]]; then
        if [[ "$VIRTUAL_ENV" == "$AUTO_VENV" ]]; then
            deactivate
            unset AUTO_VENV
        fi
    fi
fi
