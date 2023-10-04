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

#install packages
if [ ! -f packages.txt ]; then
	echo "packages.txt file not found."
	exit 1
fi

while read -r package; do
	sudo xbps-install -Suy "$package"
done <packages.txt

# install oh-my-bash and wait, will resume when completed
(bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)") &

wait

src_dir="/home/$username/code/void-dotfiles"

# Define the destination directories
dest_dirs=(
	"/home/$username/Documents/"
	"/home/$username/Downloads/"
	"/home/$username/Music/"
	"/home/$username/Videos/"
	"/home/$username/Pictures/wallpaper/"
	"/home/$username/.config/i3/"
	"/home/$username/.config/i3status/"
	"/home/$username/.config/nvim/"
	"/home/$username/.config/copyq/"
	"/home/$username/.config/ranger/"
	"/home/$username/.config/xfce4/"
	"/home/$username/.local/share/"
	"/home/$username/Pictures/wallpaper/"
	"/usr/share/themes/"
	"/usr/share/icons/"
)

# Create destination directories if they don't exist
for dir in "${dest_dirs[@]}"; do
	sudo mkdir -p "$dir"
done

# Copy files and directories with no-clobber option (-n)
sudo cp -r "$src_dir/config/i3/" "/home/$username/.config/i3/"
sudo cp -r "$src_dir/config/i3status/" "/home/$username/.config/i3status/"
sudo cp -r "$src_dir/config/nvim/" "/home/$username/.config/nvim/"
sudo cp -r "$src_dir/config/copyq/" "/home/$username/.config/copyq/"
sudo cp -r "$src_dir/config/ranger/" "/home/$username/.config/ranger/"
sudo cp -r "$src_dir/config/xfce4/" "/home/$username/.config/xfce4/"
sudo cp -r "$src_dir/dotlocal/share/" "/home/$username/.local/share/"
sudo cp -r "$src_dir/wallpaper/" "/home/$username/Pictures/wallpaper/"
sudo cp -r "$src_dir/themes/" "/usr/share/themes/"
sudo cp -r "$src_dir/icons/" "/usr/share/icons/"

echo "Files and directories copied successfully."
