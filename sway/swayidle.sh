#!/bin/env bash
swayidle \
  timeout 270 'notify-send --app-name=swayidle "Screen will lock in 30 seconds"' \
  timeout 280 'notify-send --app-name=swayidle -u low "Screen will lock in 20 seconds"' \
  timeout 290 'notify-send --app-name=swayidle -u critical "Screen will lock in 10 seconds"' \
  timeout 300 "swaylock >> ~/.swaylock.log" \
  timeout 600 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep "swaylock" >>~/.swayidle.log
