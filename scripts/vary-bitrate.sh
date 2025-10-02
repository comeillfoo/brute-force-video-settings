#!/usr/bin/env bash

# @brief path to folder to get videos from
SOURCE_DIR="$1"
set -euo pipefail

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "No folder at ${SOURCE_DIR}"
    exit 2 # ENOENT
fi

# @brief path to folder to save videos to
tempdir="$(mktemp -dt vary-bitrate.XXXXXX)"
trap 'rm -rf -- "${tempdir}"' EXIT

for src_vid in "${SOURCE_DIR}"/*; do
    ext="${src_vid##*.}"
    for bitrate in '2M' '4M' '6M'; do
        dst_vid="${src_vid##*/}"
        dst_vid="${tempdir}/${dst_vid%%.*}-${bitrate}.${ext}"
        ffmpeg -i "${src_vid}" -b:v "${bitrate}" "${dst_vid}"
    done
done
rm "${SOURCE_DIR}"/*
mv "${tempdir}"/* "${SOURCE_DIR}/"
