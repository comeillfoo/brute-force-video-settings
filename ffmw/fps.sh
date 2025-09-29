#!/usr/bin/env bash

usage()
{
    cat << EOF
Encodes input video with specified FPS

Usage: $0 <video> <fps>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
    fps        Number of frames per second
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

# @brief number of fps
fps="$2"
set -euo pipefail

ffmpeg -i "${video_path}" -r "${fps}" pipe:1
