#!/bin/bash

###

echo "Setting theme"
xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird-dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"

###

PACKAGE_LIST=(
	vim
#	vlc
	qbittorrent
	qt5-gtk2-platformtheme
	youtube-dl
	i3
	curl
	wget
	git-all
	compton
	htop
	neofetch
#	ranger
	g++
	python3
	python
	pythonpy
	make
	build-essential
	libxi-dev 
	libglu1-mesa-dev 
	libglew-dev 
	pkg-config
	screen
)

echo "Updating apt..."
sudo apt update

for package_name in ${PACKAGE_LIST[@]}; do
	echo "installing $package_name..."
	sleep .5
	sudo apt install "$package_name" -y
	echo "$package_name installed"
done

#####

PURGE_LIST=(
	pidgin
	gimp
	xfce4-verve-plugin/focal
)

for package_name in ${PURGE_LIST[@]}; do
	echo "removing $package_name..."
	sleep .5
	sudo apt purge --auto-remove "$package_name" -y
	echo "$package_name and its dependencies"
done

# Install NVM
echo "Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

