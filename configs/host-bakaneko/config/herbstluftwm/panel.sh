#!/usr/bin/env bash

hc() {
    herbstclient "$@"
}

monitor=${1:-0}

polybar --reload --config=$HOME/.config/herbstluftwm/polybar.config main
