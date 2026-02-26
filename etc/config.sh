#!/bin/bash

##### GET CONFIG VARS #####

source $(dirname $BASH_SOURCE[0])/user-config.sh

##### FUNCTIONS #####

__prompt() {

    # User prompt
    printf '%b' "${ASCIINEMA_PS1@P}"
}

# Wrapping function
ASCIINEMA() {

    # Simulate human reaction time after command
    sleep 1

    # Wait between each character to simulate human
    cmd=""
    for arg in "$@"; do
        cmd+="$(printf '%q' "$arg") "
    done

    for (( i=0; i<${#cmd}; i++ )); do
        printf "%s" "${cmd:$i:1}"
        sleep "$ASCIINEMA_TYPING_SPEED"
    done

    # Simulate human reaction time before 'enter'
    sleep 1
    printf '\n'

    # Run command
    "$@"

    __prompt
}

# Display the first prompt
__prompt
