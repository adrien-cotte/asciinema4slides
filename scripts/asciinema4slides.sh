#!/bin/bash
#
# asciinema4slides.sh — Record an asciinema session with slide geometry
#
# Usage:
#   ./asciinema4slides.sh [asciinema options] <output.cast>
#
# Examples:
#   ./asciinema4slides.sh demo.cast
#   ./asciinema4slides.sh -c ./demo.sh demo.cast
#
# Geometry and defaults are loaded from:
#   ../etc/user-config.sh
#

set -euo pipefail

source "$(dirname ${BASH_SOURCE[0]})/../etc/user-config.sh"

asciinema rec --cols $ASCIINEMA_COLS --rows $ASCIINEMA_ROWS "${@}"
