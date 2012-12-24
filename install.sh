#!/bin/bash

# Debug off (-x to enable debug)
set +x

script_name="install_dotfiles"
sublime_dir=~/Library/Application\ Support/Sublime\ Text\ 2/Packages

# Must run as root so that we can install packages
#if [ $(whoami) != "root" ]; then
#	echo "You need to run this script as root."
#	echo "Use 'sudo ./$script_name' then enter your password when prompted."
#	exit 1
#fi

main() {

	echo "\!/ WIP \!/"
	echo "Script to install a Dev environment on a fresh Linux box."
	

	# Install GIT
	if git --version &>/dev/null; then
		echo "Git is needed to clone the dotfiles repository, Git will install now."
		#read -p "Do you wish to install GIT (y/n)?"
		#if [ $REPLY == "y" ]; then
			installGit
		#fi
	else
		echo "GIT already installed"
	fi

	# clone this rep
	git clone git://github.com/NicolasRTT/dotfiles.git
	cd dotfiles
	
	# Copy .bashrc ?
	read -p "Do you wish to copy bashrc? (y/n)?"
	if [ $REPLY == "y" ]; then
		copyBashrc
	fi

	# Copy .gitconfig ?
	read -p "Do you wish to copy gitconfig (y/n)?"
	if [ $REPLY == "y" ]; then
		copyGitconfig
	fi

	# Install Sublime-text2 ?
	read -p "Do you wish to install Sublime-text2 (y/n)?"
	if [ $REPLY == "y" ]; then
		installSublimeText
	fi

	# Copy sublime-text2 dotfiles ?
	read -p "Do you wish to copy Sublime-text2 dotfiles from Github? (y/n)?"
	if [ $REPLY == "y" ]; then
		copySublimeDotFiles
	fi

}

installGit() {
	sudo apt-get install -y git
	happy_print "Install of GIT" "successful"
}

copyBashrc() {

	cp ${HOME}/.bashrc ${HOME}/.bashrc.backup
	echo ".bashrc file backup as .bashrc.backup"
	cp .bashrc ${HOME}/.bashrc
	happy_print "Copy of .bashrc" "successful"
}

copyGitconfig() {

	cp ${HOME}/.gitconfig ${HOME}/.gitconfig.backup
	echo ".gitconfig file backup as .gitconfig.backup"
	cp .gitconfig ${HOME}/.gitconfig
	happy_print "Copy of .gitconfig" "successful"
}



copySublimeDotFiles() {
	echo "Work in progress, try again later !"
	#mv "$sublime_dir/User" "$sublime_dir/User.backup"
	#cd "$sublime_dir"
	#echo "Installing Soda Theme..."
	#git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

	#rm -rf $ZSH/sublime2/User
	#cp -R ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User $ZSH/sublime2/User

}


installSublimeText() {

	sudo add-apt-repository ppa:webupd8team/sublime-text-2
	sudo apt-get update
	sudo apt-get install sublime-text
	happy_print "Install of sublime-text2" "successful"
}


#---------------------------------------------
# UTILITY METHODS
#---------------------------------------------
# Thanks Yeoman for these beautiful prints :)

# Print all in green and the ✔ and $1 in bold
happy_print() {
    echo -e "   [1;32m✔ $1[0;32m $2[0m"
}

# Print all in red and the ✖ and $1 in bold
sad_print() {
    echo -e "   [1;31m✖ $1[0;31m $2[0m"
}

main
