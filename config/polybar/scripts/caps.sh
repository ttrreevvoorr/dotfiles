#!/bin/bash

caps_lock=$(xset q | grep "Caps Lock:" | awk '{print $4}')

if [[ $caps_lock == "on" ]]; then
    echo " "
else
    echo ""
fi

