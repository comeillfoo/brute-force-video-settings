#!/usr/bin/env bash

usage()
{
    cat << EOF
Encodes input video with specified resolution

Usage: $0 <video> <resolution>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
    resolution Desired resolution (720p, 480p or 360p)
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

# @brief path to video file
video_path="$1"

# @brief target resolution
resolution="$2"
set -euo pipefail

scale='1280x720'
case "${resolution}" in
    360p)
        scale='640x360'
        ;;
    480p)
        scale='854x480'
        ;;
    720p)
        scale='1280x720'
        ;;
    1080p)
        scale='1920x1080'
        ;;
    *)
        echo "Unknown resolution '${resolution}'" >&2
        exit 22 # EINVAL
        ;;
esac
ffmpeg -i "${video_path}" -s "${scale}" -f "${video_path##*.}" pipe:
