#!/usr/bin/env bash

usage()
{
    cat << EOF
Prints video data in JSON

Usage: $0 <video>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
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

[ "$#" -lt 1 ] && usage

# @brief path to video file
video_path="$1"

set -euo pipefail
ffprobe -v quiet -show_streams -show_format -print_format json "${video_path}"
