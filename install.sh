sudo apt-get -y install aptitude
sudo aptitude update

mkdir -p ~/programs
mkdir -p ~/temp

registerbashrc bashrc
./myreps.sh

./general.sh
./development.sh
./scientific.sh


echo "*****************************"
echo ""
echo "Done"
echo "Things to do:"
read -p "Would you like to have SAMBA? (Y/N)" ANSWERSAMBA
if [ "$ANSWERSAMBA" = "Y" ]; then
	sudo smbpasswd -a `whoami`
	ME=`whoami`
	echo "
	[home]
	path = /home/$ME
	available = yes
	valid users = $ME
	read only = no
	browsable = yes
	public = yes
	writable = yes
	" | sudo tee /etc/samba/smb.conf
	sudo restart smbd
	echo "Done. net use x: \\\\192.168.56.101\\home * /user:$ME"
fi
read -p "Would you like to have a gateway? (Y/N)" ANSWERGATEWAY
if [ "$ANSWERSAMBA" = "Y" ]; then
  echo "First execute this in your host: https://github.com/jgillis/Clean-install/blob/master/winhost.bat"
  e=`whoami`
  sudo mkdir -p /home/gatewayhost
  sudo chown $e /home/gatewayhost
  sudo mount -t vboxsf gateway /home/gatewayhost
  sudo uniqueappend "gateway   /home/gatewayhost   vboxsf   defaults  0   0" /etc/fstab
fi
