#!/bin/sh

quit=$(echo "Yes\nNo" | rofi -dmenu -i -p "Exit i3? " -l 2)

case $quit in
  Yes)
    i3-msg exit
    ;;
  *)
    ;;
esac
