#!/usr/bin/env bash

export QT_QPA_PLATFORM=offscreen
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

youtube-dl $*
