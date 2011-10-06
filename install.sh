sudo apt-get -y install aptitude
sudo aptitude update

registerbashrc bashrc
./myreps.sh

./general.sh
./development.sh
./scientific.sh

sudo ME=`whoami`
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

echo "*****************************"
echo ""
echo "Done"
echo "Things to do:"
echo ""
echo "  (optional) connect to your fresh samba server. "
echo "      net use x: \\192.168.56.101\home * /user:$ME"
