#!/bin/bash
cd ~
echo "This is clean-install bootstrap"
if [ -f clean-install ]; then
rm clean-install
fi
if [ -d clean-install ]; then
rm -rf clean-install
fi
read -p "Would you like to have repositories available? (Y/N)" ANSWER
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	read -p "What is your e-mail? " EMAIL
	echo "" | ssh-keygen -t rsa -C $EMAIL
fi

if [ "$ANSWER" = "Y" ]; then
	mkdir -p ~/.ssh
	cd ~/.ssh

	sudo apt-get -y install xclip

	if [ ! -f id_rsa.pub ]; then
		echo ""
		echo "************************************************************"
		echo "Your public key has been generated and put on the clipboard."
		echo ""
		echo "Navigate to https://github.com/account/ssh and paste the key there."
	else
		echo ""
		echo "************************************************************"
		echo "Your public key has been put on the clipboard."
		echo "Navigate to https://github.com/account/ssh and paste the key there."
	fi
	cat id_rsa.pub | xclip
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
	cd ~/tools && git clone git@github.com:jgillis/Utilities.git utilities
	cd ~ && git clone git@github.com:jgillis/Clean-install.git clean-install
else
	mkdir -p ~/tools
	wget https://github.com/jgillis/Utilities/tarball/master && tar -xvf master && mv jgillis-Utilities*  ~/tools/utilities
	cd ~ && wget https://github.com/jgillis/Clean-install/tarball/master && tar -xvf master && mv jgillis-Clean-install*  clean-install
fi
cd ~/tools/utilities && ./install.sh
cd ~/clean-install && sudo sh ./install.sh
cd ~
rm bootstrap.sh
rm master
