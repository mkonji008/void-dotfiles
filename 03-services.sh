#!/bin/bash

# function to check if a service is installed and enabled
check_service() {
	local service_name="$1"
	local service_path="/etc/sv/$service_name"

	if sv check "$service_name" &>/dev/null; then
		echo "$service_name is already installed and enabled."
	else
		# install the service
		sudo xbps-install -y "$service_name"

		# enable the service
		sudo ln -s "$service_path" /var/service/
		echo "$service_name has been installed and enabled."
	fi
}

# function to check and disable a service if it is enabled
disable_service() {
	local service_name="$1"

	if sv check "$service_name" &>/dev/null; then
		# disable the service
		sudo rm -f "/var/service/$service_name"
		echo "$service_name is enabled and has been disabled."
	else
		echo "$service_name is not enabled."
	fi
}

# check and disable if enabled
disable_service "wpa_supplicant"
disable_service "dhcpcd"

# Check and install/enable
check_service "NetworkManager"
check_service "elogind"
check_service "dbus"

# problem child service / no logic
sudo xbps-install -Sy lightdm lightdm-gtk3-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/

echo "Services check and setup completed."
