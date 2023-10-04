#!/bin/bash

# prompt for the username
read -p "Enter your username: " username

# prompt for confirmation with "Y/n" defaulting to "Y"
read -p "Is '$username' your correct username? (Y/n) " confirmation

# convert the confirmation input to lowercase (to handle variations like "Y" or "y")
confirmation="${confirmation,,}"

# check if the input is empty or "y" (default) or "yes"
if [ -z "$confirmation" ] || [ "$confirmation" = "y" ] || [ "$confirmation" = "yes" ]; then
	echo "Using username: $username"
else
	echo "Exiting..."
	exit 1
fi
sudo xbps-install -Sy opendoas
sudo touch /etc/doas.conf
sudo echo "permit persist $username as root" >>/etc/doas.conf
sudo echo "ignorepkg=sudo" >>/etc/xbps.d/00-repository-main.conf
