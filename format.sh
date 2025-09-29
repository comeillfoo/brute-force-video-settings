#!/usr/bin/env bash
# @brief path to input file
path="$1"

# @brief target format
format="$2"
set -euo pipefail

ffmpeg -i "${path}" -f "${format}" pipe:1
