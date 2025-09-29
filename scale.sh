#!/usr/bin/env bash
# @brief path to input file
path="$1"

# @brief target resolution
resolution="$2"
set -euo pipefail


scale='1280:720'
case "${resolution}" in
    360p)
        scale='640:360'
        ;;
    480p)
        scale='854:480'
        ;;
    *)
        scale='1280:720'
        ;;
esac
ffmpeg -i "${path}" -vf "scale=${scale}" pipe:1
