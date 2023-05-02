#!/bin/bash

OPENWEATHER="9850ce246c8055c57bf6a5be30ff5489";
CITY="5404794";

# Check if jq is installed
if ! command -v jq &>/dev/null; then
    echo "Error: jq is not installed."
    exit 1
fi

# Check if curl is installed
if ! command -v curl &>/dev/null; then
    echo "Error: curl is not installed."
    exit 1
fi

type=false
if [ "$1" ]; then
    type=true
fi

url="http://api.openweathermap.org/data/2.5/weather?id=${CITY}&appid=${OPENWEATHER}&units=imperial"

response=$(curl -s "$url")

imperial=$(echo "$response" | jq '.main.temp')
celsius=$(echo "scale=2; ($imperial-32)/1.8" | bc)
desc=$(echo "$response" | jq -r '.weather[0].description')

get_icon() {
    local desc=$1
    local icon=""
    case $desc in
        "clear sky")
            hour=$(date +"%H")
            if [ "$hour" -lt 6 ] || [ "$hour" -gt 18 ]; then
                icon=""
            else
                icon=""
            fi
            ;;
        "few clouds"|"scattered clouds"|"broken clouds"|"overcast clouds")
            icon=""
            ;;
        "rain")
            icon=""
            ;;
        "thunderstorm")
            icon="⚡"
            ;;
        "snow")
            icon=""
            ;;
        "fog"|"haze"|"mist")
            icon=""
            ;;
        *)
            icon=""
            ;;
    esac
    echo "$icon"
}

to_caps() {
    local sentence=$1
    echo "$sentence" 
}

if $type; then
    echo "$(to_caps "$desc") $(get_icon "$desc")"
else
    printf "%dF°:%dC° %s\n" "${imperial%.*}" "${celsius%.*}" "$(get_icon "$desc")"
fi

