#!/bin/bash
cd ~
echo "This is clean-install bootstrap"
wget https://github.com/jgillis/Clean-install/tarball/master && tar -xvf master && mv -f jgillis-Clean-install*  clean-install && cd clean-install && sudo sh ./install.sh
cd ~
rm bootstrap.sh
rm master
