#!/bin/bash
cd ~
echo "This is clean-install bootstrap"
if [ -f clean-install ]; then
rm clean-install
fi
if [ -d clean-install ]; then
rm -rf clean-install
fi
wget https://github.com/jgillis/Clean-install/tarball/master && tar -xvf master && mv jgillis-Clean-install*  clean-install && cd clean-install && sudo sh ./install.sh
cd ~
rm bootstrap.sh
rm master
