#!/usr/bin/env bash

# @brief path to folder to get videos from
SOURCE_DIR="$1"
set -euo pipefail

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "No folder at ${SOURCE_DIR}"
    exit 2 # ENOENT
fi

# @brief path to folder to save videos to
tempdir="$(mktemp -dt vary-vcodec.XXXXXX)"
trap 'rm -rf -- "${tempdir}"' EXIT

for src_vid in "${SOURCE_DIR}"/*; do
    ext="${src_vid##*.}"
    for vcodec in 'dvvideo' 'ffv1' 'av1' 'h261' 'h263' 'h264' 'hevc' \
            'mpeg1video' 'mpeg2video' 'mpeg4' 'msmpeg4v1' 'msmpeg4v2' \
            'msmpeg4v3'; do
        dst_vid="${src_vid##*/}"
        dst_vid="${tempdir}/${dst_vid%%.*}-${vcodec}.${ext}"
        ffmpeg -i "${src_vid}" -c:v "${vcodec}" "${dst_vid}"
    done
done
rm "${SOURCE_DIR}"/*
mv "${tempdir}"/* "${SOURCE_DIR}/"
