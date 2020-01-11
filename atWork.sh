#!/bin/bash

echo "Changing the APS WPA2 configuration."

echo "What is your APS email?"

read aps_email

echo "What is your current APS account password?"

read aps_pw

echo -e "\nnetwork={" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        ssid=\"APS\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        key_mgmt=WPA-EAP" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        eap=PEAP" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        identity=\"$aps_email\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        password=\"$aps_pw\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "        phase2=\"auth=MSCHAPV2\"" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo -e "}" >> /etc/wpa_supplicant/wpa_supplicant.conf

sleep 2
wpa_cli -i wlan0 reconfigure > /dev/null 2>&1
sleep 5
sudo shutdown -r now