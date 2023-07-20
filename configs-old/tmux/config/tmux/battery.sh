#!/usr/bin/env bash

OS=$(uname)
if [ "$OS" != "Darwin" ]; then
    exit 0
fi

function raw_data {
    ioreg -rc AppleSmartBattery
}

if raw_data | grep AppleSmartBattery >/dev/null
then
    CURRENT=$(raw_data | grep "CurrentCapacity" | awk '{ print $3 }')
    MAX=$(raw_data | grep "MaxCapacity" | awk '{ print $3 }')
    PERC=$(( $CURRENT * 100 / $MAX ))
    CHARGING=$(raw_data | grep "ExternalConnected" | grep "Yes")

    VOLT=""
    if [ ! -z "$CHARGING" ]
    then
        VOLT="⚡"
    else
        VOLT=" "
    fi

    if [ -z "$USE_POWERLINE" ]
    then
        A="#[fg=black,bg=${C}]"
    fi
    echo "${A}${VOLT}🔋 ${PERC}%"
fi
