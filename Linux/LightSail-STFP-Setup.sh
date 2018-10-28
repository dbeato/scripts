#Add User to the Bitnami Daemon Group
sudo adduser username Daemon
#Change SFTP Subsystem on /etc/ssh/sshd_config
Subsystem sftp internal-sftp

#Setup /etc/ssh/sshd_config
Match User username
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /home
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no

#Restart SSH Service
sudo service ssh Restart

#Change Home folder owner and bind the Apache/Ngnix Directory
chown root /home/username
sudo mkdir /home/username/www
sudo mount --bind /opt/bitnami/apps/wordpress/htdocs /home/username/www

#Permanent Mount
sudo nano /etc/fstab
/opt/bitnami/apps/wordpress/htdocs /home/username/www none bind