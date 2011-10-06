sudo apt-get -y install aptitude
sudo aptitude update

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
	" >> /etc/samba/smb.conf
	sudo restart smbd
	echo "Done. net use x: \\192.168.56.101\home * /user:$ME"
fi
