#!/bin/bash

#CHANGE TO sleep 25
sleep 10

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Online"
    cd "/home/pi/MagicMirror"
    DISPLAY=:0 npm start
else
    echo "Offline"
    cd "/home/pi/Desktop/AutoStart Network Troubleshooter/"
    sudo bash noconnection.sh
fi
