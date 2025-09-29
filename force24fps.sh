#!/usr/bin/env bash
# @brief path to input file
path="$1"

# @brief number of fps
fps="$2"
set -euo pipefail

ffmpeg -i "$1" -r "${fps}" pipe:1
