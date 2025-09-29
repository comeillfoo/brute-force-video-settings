#!/usr/bin/env bash
ffprobe -v quiet -show_streams -show_format -print_format json "$1"
