#!/bin/bash

##### CONFIG #####

# Set slide format
ASCIINEMA_COLS=100
ASCIINEMA_ROWS=22
ASCIINEMA_FONT_SIZE=28

# Set typing speed (lower = faster)
ASCIINEMA_TYPING_SPEED=0.1

# Set prompt PS1
_user=adrien
_host=hpsfcon26
ASCIINEMA_PS1="\033[1;32m[\033[1;34m${_user}\033[1;32m@\033[1;31m${_host}\033[1;32m]\033[0m:\033[1;34m~\033[0m\033[1;32m\$\033[0m "

# FFMPEG options
FFMPEG_EXTRA_OPTS=${FFMPEG_EXTRA_OPTS:-}

# ASCIINEMA dry run variable, only typing animation but command does not run
ASCIINEMA_DRY_RUN=${ASCIINEMA_DRY_RUN:-"0"}
