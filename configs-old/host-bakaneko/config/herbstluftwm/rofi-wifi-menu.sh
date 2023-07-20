#!/usr/bin/env bash

# Originally from https://github.com/zbaylin/rofi-wifi-menu. Heavily modified by
# me (Trevor Elliott), and copied into my dotfiles to avoid adding another git
# submodule.

set -euo pipefail

max_entries="16"

# Starts a scan of available broadcasting SSIDs
# nmcli dev wifi rescan

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {

  fields="SSID,SECURITY,BARS"
  ssid_list=$(
    nmcli --fields "${fields}" device wifi list | \
      sed '/^--/d' | \
      awk -F'  +' '{ if (!seen[$1]++) print}')

  # For some reason rofi always approximates character width 2 short... hmmm
  ((width=$(echo "$ssid_list" | head -n 1 | wc -c) + 1))

  # Gives a list of known wifi connections so we can parse it later
  knowncons=$(
    nmcli connection show | \
      tail -n +2 | \
      awk '{if ($2 == "wifi") print $1}'
  )

  # Determine if wifi is enabled
  connstate=$(nmcli --get-values WIFI general)

  currssid=$(
    nmcli --get-values=active,ssid dev wifi | \
      awk -F: '/^yes/ {print $2}' | \
      head -n 1)

  highline=""
  if [ -n "$currssid" ]; then
    ssid_list_index="$(
      echo "$ssid_list" | \
        awk -F'  +' '{print $1}' | \
        grep -Fxn -m 1 "$currssid" | \
        sed 's/:.*$//')"

    ((highline=ssid_list_index + 2))
  fi

  toggle="toggle on"
  height=1
  if [ "$connstate" = "enabled" ]; then
    # Dynamically change the height of the rofi menu
    height=$(echo "$ssid_list" | wc -l)
    ((height = height > max_entries ? max_entries : height))

    toggle="toggle off"
  fi

  rofi=(
    rofi
    -theme "${dir}/rofi.rasi"
    -theme-str "window {width: ${width}ch;}"
    -location 0
  )

  entry=$(
  set -x;
    echo -e "$toggle\nmanual\nrescan\n$ssid_list" | \
      "${rofi[@]}" -dmenu -p "> " -lines "${height}" -a "${highline:-}")

  ssid="$(echo "$entry" | awk -F'  +' '{print $1}')"

  case "$entry" in
    "manual")
      # Manual entry of the SSID and password (if appplicable)
      mssid=$(
        echo "enter the SSID of the network (SSID,password)" | \
          "${rofi[@]}" -dmenu -p "Manual Entry: " -lines 1)

      # Separating the password from the entered string
      # TODO: what if your password contains a comma?
      mpass=$(echo "$mssid" | awk -F "," '{print $2}')

      # If the user entered a manual password, then use the password nmcli
      # command
      if [ "$mpass" = "" ]; then
        nmcli dev wifi con "$mssid"
      else
        nmcli dev wifi con "$mssid" password "$mpass"
      fi
      ;;

    "rescan")
      nmcli dev wifi rescan
      main
      ;;

    "toggle on")
      nmcli radio wifi on
      ;;

    "toggle off")
      nmcli radio wifi off
      ;;

    *)
      # Parses the list of preconfigured connections to see if it already
      # contains the chosen SSID. This speeds up the connection process
      if echo "$knowncons" | grep -q "$ssid"; then
        nmcli con up "$ssid"
      else
        if [[ "$entry" =~ "WPA2" ]] || [[ "$entry" =~ "WEP" ]]; then
          wifipass=$(
            echo "if connection is stored, hit enter" | \
              "${rofi[@]}" -dmenu -p "password: " -lines 1)
        fi
        nmcli dev wifi con "$ssid" password "$wifipass"
      fi
      ;;

  esac

}

main
