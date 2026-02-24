#!/bin/bash
#
# cast2gif.sh — Convert an asciinema .cast file to a slide-ready GIF
#
# Usage:
#   ./cast2gif.sh <input.cast>
#
# Example:
#   ./cast2gif.sh demo.cast
#
# The output GIF will use the geometry and font settings defined in:
#   ../etc/user-config.sh
#

set -euo pipefail

source "$(dirname ${BASH_SOURCE[0]})/../etc/user-config.sh"

input="$1"
output="${1//.cast/.gif}"

agg --no-loop \
    --font-size $ASCIINEMA_FONT_SIZE \
    --cols $ASCIINEMA_COLS \
    --rows $ASCIINEMA_ROWS \
    $input $output

echo "=> $output"
