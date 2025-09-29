#!/usr/bin/env bash

usage()
{
    cat << EOF
Encodes input video with specified bitrate

Usage: $0 <video> <bitrate>

Options:
    -h, --help Prints this help message

Arguments:
    video      Path to video file
    bitrate    Bit rate
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

# @brief bit rate
bitrate="$2"
set -euo pipefail

ffmpeg -i "${video_path}" -b:v "${bitrate}" pipe:1
