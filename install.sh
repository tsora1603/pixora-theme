#!/bin/bash

# Terminal colors
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY_BG='\033[0;90m'
NC='\033[0m'

dir=$(pwd)
git pull
if [ -d "$HOME/.icons/pixelitos-dark" ] && [ -d "$HOME/.icons/pixelitos-light" ] && [ -d "$HOME/.icons/pixora" ]; then
	echo "Pixora Icon Theme already installed."
	exit 1
fi

echo -e "\n\n╔═════════════════════════════════════╗"
echo -e "┆                                     ┆"										
echo -e "┆ ◄  Pixora Icon Theme - Installer  ► ┆"
echo -e "┆                                     ┆"
echo -e "╚═════════════════════════════════════╝\n\n"

if [ ! -d "$HOME/.icons" ]; then
	mkdir "$HOME/.icons"
fi

echo -e "Welcome!"
echo -e "How would you like to install? Type [1/2] to choose.\n"

echo -e "┍━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┑"
echo -e "┆ Option 1: Symbolic links - easy way to keep the theme up-to-date   ┆"
echo -e "┆ Option 2: Local installation - remove github connection entirely   ┆"
echo -e "┕━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┙\n"

read -p "► " choice
if [ "$choice" == "1" ]; then
	echo -e "\nBy choosing ${GREEN}Option 1${NC}, you should ${RED}NOT${NC} move or delete ${RED}[ $dir ]${NC},"
	echo -e "otherwise the theme is going to break.\n"
	read -p "Press Enter to continue..."
	echo -e "\nCreating symlinks...\n"
	
	ln -s "$dir/pixelitos-dark" "$HOME/.icons/pixelitos-dark"
	ln -s "$dir/pixelitos-light" "$HOME/.icons/pixelitos-light"
	ln -s "$dir/pixora" "$HOME/.icons/pixora"
	
	elif [ "$choice" = "2" ]; then
		echo -e "\n⚠️ By choosing ${GREEN}Option 2${NC}, you are aware that, in order to ${RED}update the theme${NC},"
		echo -e "you should ${RED}clone${NC} the repository again and either:"
		echo -e "1: Move the files to their right locations yourself;"
		echo -e "2: Run this install script again.\n"
		read -p "Press Enter to continue..."
		echo -e "\nCopying files..."
		
		cp -r "$dir/pixelitos-dark" "$HOME/.icons/pixelitos-dark"
		cp -r "$dir/pixelitos-light" "$HOME/.icons/pixelitos-light"
		cp -r "$dir/pixora" "$HOME/.icons/pixora"
		sleep 1
		echo -e "\nYou are about to remove the directory ${RED}[ $dir ]${NC}."
		echo -e -n "Are you sure? ${GREEN}[Y/n]${NC}: "
		read -r confirm
		confirm=${confirm,,}

		if [[ "$confirm" = "y" || -z "$confirm" ]]; then
			rm -rf $dir
			echo -e "\nDirectory sucessfully removed.\n"
		else
			echo -e "\nDirectory removal cancelled.\n"
		fi
else
	echo 'Exiting as no valid option was selected.'
	exit 1
fi

sleep 1
echo -e "================================================="
echo -e "★ Thanks for installing the Pixora Icon Theme! ★"
echo -e "================================================="
if [ "$choice" == "1" ]; then
	echo -e "\n${GRAY_BG}▌ ⚠️ NOTICE: To update the theme, go back to ${RED}[ $dir ]${NC} ${GRAY_BG}and run" 
	echo -e "${GRAY_BG}▌ ${GREEN}'git pull'${NC} ${GRAY_BG}or ${GREEN}'git pull origin main'${NC}." 
	exit 1
fi