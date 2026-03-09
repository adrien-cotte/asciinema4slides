#!/bin/bash
#
# gif2mp4.sh — Convert a GIF animation to an MP4 video
#
# Usage:
#   ./gif2mp4.sh <input.gif>
#
# Example:
#   ./gif2mp4.sh demo.gif
#

set -euo pipefail

input="$1"
output="${1//.gif/.mp4}"

ffmpeg -i $input \
    -movflags faststart \
    -pix_fmt yuv420p \
    -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
    $output

echo "=> $output"
