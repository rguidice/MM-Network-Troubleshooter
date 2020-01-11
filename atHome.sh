#!/bin/bash

echo "Here is a list of all the wifi networks in your area:"

mapfile -t network_array < <( sudo iwlist wlan0 scan|grep ESSID )

#printf '%s\n' "${network_array[@]}"

count=0

for i in "${network_array[@]}"
do
    currStr="$i"
    substr=$(echo $currStr| cut -d'"' -f 2)
    formatted_array[$count]="$substr"
    ((count++))
done

printf '%s\n' "${formatted_array[@]}"

echo "Which one would you like to connect to? (Please type out the exact name, matching case and whitespace.)"

read network_input

found_input=0

for i in "${formatted_array[@]}"
do
    currStr="$i"
    if [[ "$network_input" == "$currStr" ]]; then
        found_input=1
    fi
done


if [[ $found_input == 1 ]]; then
    echo "What is the password for this network?"
    read password
    echo -e "\nnetwork={" >> /etc/wpa_supplicant/wpa_supplicant.conf
    echo -e "        ssid=\"$network_input\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
    echo -e "        psk=\"$password\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
    echo -e "}" >> /etc/wpa_supplicant/wpa_supplicant.conf
    sleep 2
    wpa_cli -i wlan0 reconfigure > /dev/null 2>&1
    sleep 5
    sudo shutdown -r now
else
    echo "Incorrect input. Please try again."
    sleep 2
    bash atHome.sh
fi