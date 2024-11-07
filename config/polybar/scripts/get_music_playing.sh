#!/bin/bash

echo "$(if [ "$(playerctl status)" = "Playing" ]; then echo ""; else echo ""; fi)"
