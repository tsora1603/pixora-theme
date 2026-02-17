dir=$(pwd)
git pull
if [ -d "$HOME/.local/share/icons/pixelitos-dark" ] || [ -d "$HOME/.local/share/icons/pixelitos-light" ]; then
	echo 'Pixora Icon Theme already installed.'
	exit 1
fi
if [ ! -d "$HOME/.local/share/icons" ]; then
	mkdir "$HOME/.local/share/icons"
fi

echo 'How would you like to install? options:'
echo '1: Symbolic links - keeps git repo on system and allows use of git pull to keep up to date'
echo '2: Direct copy icons and remove git repo'
read -p 'option: ' choice
if [ "$choice" == "1" ]; then
	ln -s "$dir/pixelitos-dark" "$HOME/.local/share/icons/pixelitos-dark"
	ln -s "$dir/pixelitos-light" "$HOME/.local/share/icons/pixelitos-light"
elif [ "$choice" == "2" ]; then
	cp -r "$dir/pixelitos-dark" "$HOME/.local/share/icons/pixelitos-dark"
	cp -r "$dir/pixelitos-light" "$HOME/.local/share/icons/pixelitos-light"
	echo "You are about to remove the directory $dir. Are you sure? (y/n)"
	read confirm
	if [ "$confirm" == "y" ]; then
		rm -rf "$dir"
	else
		echo "Directory removal cancelled."
	fi
else
	echo 'Exiting as no valid option was selected.'
	exit 1
fi
echo 'Thanks for installing the Pixora Icon Theme!'
