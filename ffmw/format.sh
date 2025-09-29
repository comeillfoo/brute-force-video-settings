#!/usr/bin/env bash

usage()
{
    cat << EOF
Encodes input video into specified format

Usage: $0 <video> <format>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
    format     Output format name
EOF
    exit 22 # EINVAL
}

while true; do
    case "$1" in
        -h | --help)
            usage
            ;;
        *)
            break
            ;;
    esac
done

[ "$#" -lt 2 ] && usage

# @brief path to file
video_path="$1"

# @brief target format
format="$2"

case "${format}" in
    mp4|mov|avi|mkv|wmv)
        ;;
    *)
        echo "Unknown format '${format}'" >&2
        exit 22 # EINVAL
        ;;
esac
set -euo pipefail

ffmpeg -i "${video_path}" -f "${format}" pipe:1
