#!/usr/bin/env bash

# @brief path to folder to get videos from
SOURCE_DIR="$1"

declare -A scales
scales['1080p']='1920x1280'
scales['720p']='1280x720'
scales['480p']='854x480'
scales['360p']='640x360'
set -euo pipefail

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "No folder at ${SOURCE_DIR}"
    exit 2 # ENOENT
fi

# @brief path to folder to save videos to
tempdir="$(mktemp -dt vary-scale.XXXXXX)"
trap 'rm -rf -- "${tempdir}"' EXIT

for src_vid in "${SOURCE_DIR}"/*; do
    ext="${src_vid##*.}"
    for resolution in '1080p' '720p' '480p' '360p'; do
        dst_vid="${src_vid##*/}"
        dst_vid="${tempdir}/${dst_vid%%.*}-${resolution}.${ext}"
        ffmpeg -i "${src_vid}" -s "${scales[${resolution}]}" "${dst_vid}"
    done
done
rm "${SOURCE_DIR}"/*
mv "${tempdir}"/* "${SOURCE_DIR}/"
