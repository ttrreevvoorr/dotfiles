#!/bin/bash

## Set theme and update package manager

echo "Setting theme"
xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird-dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"

echo "Updating apt..."
sudo apt update

## PURGE UNNECESSARY PACKAGES

PURGE_LIST=(
	pidgin
	gimp
	xfce4-verve-plugin/focal
)
DELETED=()
for package_name in ${PURGE_LIST[@]}; do
	if sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "removing $package_name..."
		sleep .5
		sudo apt purge --auto-remove "$package_name" -y
		echo "Removed $package_name and its dependencies"
		DELETED+=($package_name)
	else
		echo "$package_name was not removed, as it is not installed."
	fi
done

## INSTALL WANTED PACKAGES

PACKAGE_LIST=(
	vim
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
	ranger
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
	tty-clock
	bat
)

NEW=()
EXIST=()

for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo apt install "$package_name" -y
		echo "$package_name installed"
		NEW+=($package_name)
	else
		echo "$package_name already installed"
		EXIST+="$package_name"
	fi
done

## INSTALL PACKGES FROM SOURCE
if ! nvm; then
	echo "Installing NVM"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
else
	echo "Node Version Manager (nvm) is already installed"
	NPMV=$(nvm -v)
	echo "$NPMV"
fi


echo -en "New packages installed: \n${NEW}"
echo -en "Packages That Already Existed: \n${EXIST}"
echo -en "Deleted packages\n${DELETED}\n"
