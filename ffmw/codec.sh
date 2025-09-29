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
    dvvideo) # .dv
        ;;
    ffv1)    # .avi, .mkv, .mov
        ;;
    av1)     # .webm
        ;;
    h261)
        ;;
    h263)
        ;;
    h264)    # .mp4, .m4v
        ;;
    hevc)
        ;;
    mpeg1video)
        ;;
    mpeg2video)
        ;;
    mpeg4)   # .mp4
        ;;
    msmpeg4v1|msmpeg4v2|msmpeg4v3) # .mp4
        ;;
    *)
        echo "Unknown video codec '${vcodec}'" >&2
        exit 22 # EINVAL
        ;;
esac
set -euo pipefail

ffmpeg -i "${video_path}" -c:v "${vcodec}" pipe:1
