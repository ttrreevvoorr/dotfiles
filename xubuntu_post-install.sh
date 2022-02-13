#!/bin/bash

## Set theme and update package manager

echo "Setting theme"
xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird-dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita"

echo "Updating apt..."
sudo apt update

## PURGE UN-WANTED BLOAT

PURGE_LIST=(
	gnome-mines
	gnome-sudoku
	mate-calc
	parole
	pidgin
	sgt-puzzles
	xfce4-verve-plugin/focal
	xfce4-screensaver
	xfce4-taskmanager
)
DELETED=()
for package_name in ${PURGE_LIST[@]}; do
	if sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "removing $package_name..."
		sleep .5
		sudo apt-get purge --auto-remove "$package_name" -y
		echo "Removed $package_name and its dependencies"
		DELETED+=($package_name)
	else
		echo "$package_name was not removed, as it is not installed."
	fi
done

## INSTALL WANTED PACKAGES

PACKAGE_LIST=(
	bat
	build-essential
	compton
	curl
	ffmpeg
	fonts-font-awesome
	fonts-inconsolata
  galculator
	git-all
	g++
	htop
	i3
	iftop
	libglew-dev 
	libxi-dev 
	libglu1-mesa-dev 
	make
	neofetch
	python3
	python
	pythonpy
	pkg-config
	krita
	qbittorrent
	qt5-gtk2-platformtheme
	ranger
	screen
	tty-clock
	vim
	wget
	youtube-dl
)

NEW=()
EXIST=()

for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo apt list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo apt-get install "$package_name" -y
		echo "$package_name installed"
		NEW+=($package_name)
	else
		echo "$package_name already installed"
		EXIST+=($package_name)
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

## INSTALL PATHOGEN;VIM
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

## INSTALL NERDTREE;VIM
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree

# STOP APACHE FROM AUTO START
sudo update-rc.d apache2 disable

## PRINT FOR USE WHAT HAS HAPPENED

echo -en "\nNew packages installed:\n"
for value in "${NEW[@]}"
do
	echo $value"\n"
done	

echo -en "\nPackages That Already Existed:\n"
for value in "${EXIST[@]}"
do
	echo $value"\n"
done	

echo -en "\nDeleted packages:\n"
for value in "${DELETED[@]}"
do
	echo $value "\n"
done	
