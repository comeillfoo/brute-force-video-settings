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
    for vcodec_ext in 'h264.mp4' 'hevc.mp4' 'mpeg1video.mp4' 'mpeg2video.mp4' \
            'mpeg4.mp4' 'msmpeg4v2.avi' 'msmpeg4v3.avi' 'wmv1.avi' \
            'wmv2.avi'; do
        vcodec="${vcodec_ext%%.*}"
        dst_vid="${src_vid##*/}"
        dst_vid="${tempdir}/${dst_vid}-${vcodec_ext}"
        ffmpeg -i "${src_vid}" -c:v "${vcodec}" "${dst_vid}"
    done
done
rm "${SOURCE_DIR}"/*
mv "${tempdir}"/* "${SOURCE_DIR}/"
