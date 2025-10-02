#!/usr/bin/env bash

# @brief path to folder to get videos from
SOURCE_DIR="$1"
set -euo pipefail

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "No folder at ${SOURCE_DIR}"
    exit 2 # ENOENT
fi

# @brief path to folder to save videos to
tempdir="$(mktemp -dt vary-fps.XXXXXX)"
trap 'rm -rf -- "${tempdir}"' EXIT

for src_vid in "${SOURCE_DIR}"/*; do
    ext="${src_vid##*.}"
    for fps in 24 25; do
        dst_vid="${src_vid##*/}"
        dst_vid="${tempdir}/${dst_vid%%.*}-${fps}.${ext}"
        ffmpeg -i "${src_vid}" -r "${fps}" "${dst_vid}"
    done
done
rm "${SOURCE_DIR}"/*
mv "${tempdir}"/* "${SOURCE_DIR}/"
