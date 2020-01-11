#!/bin/bash

echo "Are you at work or home? (Enter W or H)"

read location

if [[ "$location" == "W" ]] || [[ "$location" == "w" ]]; then
    echo At Work
    bash atWork.sh
elif [[ "$location" == "H" ]] || [[ "$location" == "h" ]]; then
    echo At Home
    bash atHome.sh
else
    echo "Uh oh, I didn't detect the correct input. Please try again."
    bash noconnection.sh
fi