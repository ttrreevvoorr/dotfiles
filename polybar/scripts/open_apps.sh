#!/bin/bash

# Get the list of running applications
apps=$(wmctrl -lp | awk '{print $3}')

# Print the list of running applications to the Polybar output
echo "$apps"

