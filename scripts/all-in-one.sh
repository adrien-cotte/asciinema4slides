#!/usr/bin/env bash
#
# all-in-one.sh — Experimental wrapper to generate .cast, .gif and .mp4
#
# Usage:
#   ./all-in-one.sh <demo.sh>
#
# Example:
#   ./all-in-one.sh demo.sh
#
# This helper is experimental. It chains:
#   asciinema4slides.sh -> cast2gif.sh -> gif2mp4.sh
#
# Existing output files are not overwritten unless --force/-f is used.
#

set -euo pipefail

usage() {
    echo "Usage: $0 [--force/-f] <demo.sh>"
    exit 1
}

force=0

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
fi

if [[ $# -eq 2 ]]; then
    [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]] || usage
    force=1
    shift
fi

input="$1"

if [[ ! -f "$input" ]]; then
    echo "Error: file '$input' not found."
    exit 1
fi

if [[ "${input##*.}" != "sh" ]]; then
    echo "Error: input must be a .sh script."
    exit 1
fi

INPUT_DIR="$(cd -- "$(dirname -- "$input")" && pwd)"
INPUT_FILE="$(basename -- "$input")"
SCRIPT_BASENAME="${INPUT_FILE%.sh}"

cast_file="$INPUT_DIR/${SCRIPT_BASENAME}.cast"
gif_file="$INPUT_DIR/${SCRIPT_BASENAME}.gif"
mp4_file="$INPUT_DIR/${SCRIPT_BASENAME}.mp4"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

for f in "$cast_file" "$gif_file" "$mp4_file"; do
    if [[ -e "$f" && "$force" -ne 1 ]]; then
        echo "Error: '$f' already exists. Use --force to overwrite."
        exit 1
    fi
done

asciinema_opts=()
ffmpeg_opts=()

if [[ "$force" -eq 1 ]]; then
    asciinema_opts+=(--overwrite)
    ffmpeg_opts=(-y)
fi

"$SCRIPT_DIR/asciinema4slides.sh" \
    "${asciinema_opts[@]}" \
    -c "./$input" \
    "$cast_file"

"$SCRIPT_DIR/cast2gif.sh" "$cast_file"

FFMPEG_EXTRA_OPTS="${ffmpeg_opts[*]:-}" \
    "$SCRIPT_DIR/gif2mp4.sh" "$gif_file"

echo "Generated:"
echo "  => $cast_file"
echo "  => $gif_file"
echo "  => $mp4_file"
