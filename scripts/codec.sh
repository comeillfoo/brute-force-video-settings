#!/usr/bin/env bash

usage()
{
    cat << EOF
Encodes input video with specified codec

Usage: $0 <video> <codec>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
    vcodec      Desired video codec name
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

# @brief target video codec name
vcodec="$2"

case "${vcodec}" in
    mp4|mov|avi|mkv|wmv)
        ;;
    *)
        echo "Unknown video codec '${vcodec}'" >&2
        exit 22 # EINVAL
        ;;
esac
set -euo pipefail

ffmpeg -i "${video_path}" -c:v "${vcodec}" pipe:1
