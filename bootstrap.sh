#!/bin/bash
cd ~
echo "This is clean-install bootstrap"
echo ""
echo "At first stage, I will need some human guidance."
echo "Please stand by for questions..."
echo ""
read -p "Presss any key to continue" DUMMY

if [ -f clean-install ]; then
rm clean-install
fi
if [ -d clean-install ]; then
rm -rf clean-install
fi
read -p "Would you like to have repositories available? (Y/N)" ANSWERREP
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	read -p "What is your e-mail? " EMAIL
	read -p "What is your name? " NAME
	echo "" | ssh-keygen -t rsa -C $EMAIL
fi
if [ "$ANSWERREP" = "Y" ]; then
	mkdir -p ~/.ssh
	cd ~/.ssh

	if [ ! -f id_rsa.pub ]; then
		echo ""
		echo "************************************************************"
		echo "Your public key has been generated."
		echo ""
		echo "Navigate to https://github.com/account/ssh and paste the key there."
	else
		echo ""
		echo "************************************************************"
		echo "Navigate to https://github.com/account/ssh and paste the key there."
	fi
	cat id_rsa.pub

	echo "Press any key when you finished this action."
	read dummy

	mkdir -p ~/tools
	rm -rf ~/tools/utilities
	if [ ! -f ~/.ssh/known_hosts ]; then
	echo "" > ~/.ssh/known_hosts
	fi
	KEYS=`grep "github.com" ~/.ssh/known_hosts`
	if [ "$KEYS" = "" ]; then
		echo "github.com" |  ssh-keyscan -f - -t rsa >> ~/.ssh/known_hosts
	fi
	sudo apt-get -y install git
	git config --global user.name $NAME
	git config --global user.email $EMAIL
	cd ~/tools && git clone git@github.com:jgillis/Utilities.git utilities
	cd ~ && git clone git@github.com:jgillis/Clean-install.git clean-install
else
	mkdir -p ~/tools
	wget https://github.com/jgillis/Utilities/tarball/master && tar -xvf master && mv jgillis-Utilities*  ~/tools/utilities
	cd ~ && wget https://github.com/jgillis/Clean-install/tarball/master && tar -xvf master && mv jgillis-Clean-install*  clean-install
fi
echo "Okay, you're off the hook now. I will continue automatically"
read -p "Presss any key to continue"  DUMMY
cd ~/tools/utilities && ./install.sh
cd ~/clean-install && sudo sh ./install.sh
cd ~
rm bootstrap.sh
