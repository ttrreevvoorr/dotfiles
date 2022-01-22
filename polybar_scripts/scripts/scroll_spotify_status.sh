#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
				--scroll false\
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

#        --delay 0.5 \
#        --scroll-padding "  " \
