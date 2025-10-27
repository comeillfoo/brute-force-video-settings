#!/usr/bin/env bash
set -euo pipefail

# @brief path to original file
original="$1"

# @brief filename
original_fname="${original##*/}"

# @brief path to temp tagged
tagged="/tmp/${original_fname}"

ffmpeg -i "${original}" -c copy -metadata title="${original_fname}" "${tagged}"
mv "${tagged}" "${original}"
