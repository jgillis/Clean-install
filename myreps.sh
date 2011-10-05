#!/bin/bash
echo  -n "Would you like to have repositories available? (Y/N)"
read ANSWER
if [ "$ANSWER" = "Y" ]; then

  mkdir -p .ssh
  cd ~/.ssh
  echo -n "What is your e-mail? "

  echo "" | ssh-keygen -t rsa -C $email

  cat id_rsa.pub
  sudo aptitude -y install xclip
  xclip id_rsa.pub

  echo "Your public key has been generated and put on the clipboard."
  echo "Navigate to https://github.com/account/ssh and paste the key there."
  echo "Press any key when you finished this action."
  read dummy

  cd ~
  mkdir -p tools
  cd tools && git clone git@github.com:jgillis/Utilities.git utilities
  

else
  cd ~
  mkdir -p tools
  wget https://github.com/jgillis/Utilities/tarball/master && tar -xvf master && mv jgillis-Utilities*  tools/utilities

fi

cd ~/tools/utilities && ./install.sh
