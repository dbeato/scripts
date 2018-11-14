#Install Apache on the server
sudo apt-get update apt-get install apache2 php-curl
#Get the correct repository for your Linux Distribution on the below link:
#http://repo.z-hub.io/z-push:/final/
#In this case I was running it on a Ubuntu 16.04 server, so I used the commands below:

sudo echo "deb http://repo.z-hub.io/z-push:/final/Ubuntu_16.04/ /" > /etc/apt/sources.list.d/z-push.list
sudo wget -qO - http://repo.z-hub.io/z-push:/final/Ubuntu_16.04/Release.key | apt-key add -
#Then Updated the repos
sudo apt update
#Then installed z-push from the repo
sudo apt install z-push-common z-push-config-apache z-push-backend-combined z-push-ipc-sharedmemory
#Go to the Z-push Backend folder
cd /usr/share/z-push/backend
#Get the latest Z-Push Zimbra Backend file from https://sourceforge.net/projects/zimbrabackend/files in this case it will be Release68 (https://sourceforge.net/projects/zimbrabackend/files/Release68/)
wget https://sourceforge.net/projects/zimbrabackend/files/Release68/zimbra68.tgz
wget https://sourceforge.net/projects/zimbrabackend/files/Release68/zpzb-install.sh/
#Modify the zpzb-install.sh and run it after it to install the Zimbra backend release files
sudo chmod +700 zpzb-install.sh
chmod +x zpzb-install.sh
sudo ./zpzb-install.sh 68
#Modify the default-ssl.conf apache configuration to point to the Z-Push Backend folder
sudo nano /etc/apache2/sites-available/default-ssl.conf

#Then enable the SSL site and enable SSL for Apache.
sudo a2ensite default-ssl.conf
sudo a2enmod ssl 
sudo systemctl restart apache2
#Configure the Z-Push Backend Configuration File as below:
sudo nano /usr/share/z-push/config.php
#Configure the following lines for TimeZone (Use PHP Timezones), BackendProvider (For ZImbra), in my case this is what I needed
 #define('TIMEZONE', 'America/New_York');
 #define('BACKEND_PROVIDER', 'BackendZimbra');
#Modify the Zimbra Backend Configuration

sudo nano /usr/share/z-push/backend/zimbra/config.php
#Correct the Zimbra Configuration on the backend to point to your Zimbra internal or External Server
#define('ZIMBRA_URL', 'https://mail.domain.com');
#define('ZIMBRA_DISABLE_URL_OVERRIDE', true);
#If you don't want (Contact, Calendar, Tasks and Notes) to sync you can comment them on the configuration

#define('ZIMBRA_VIRTUAL_CONTACTS',true);
#define('ZIMBRA_VIRTUAL_APPOINTMENTS',true);
#define('ZIMBRA_VIRTUAL_TASKS',true);
#define('ZIMBRA_VIRTUAL_NOTES',true);
#Then allow your Z-Push Server to be white-listed on your Zimbra Server (Connect to your Zimbra server and do the following)
su zimbra
zmprov  mcf +zimbraHttpThrottleSafeIPs 192.168.xxx.xxx
zmcontrol restart
#In my case I have my Z-Push behind an Nginx and I configured it as needed and it worked properly after this. (For Nginx SSL Proxy you can look at @JaredBusch topic on the following URL: https://mangolassi.it/topic/16651/install-nginx-as-a-reverse-proxy-on-fedora-27. You will also need to create a DNS entry to point to your Z-push server. I chose not to setup Z-push on my Zimbra server as the configurations get removed every-time the server is updated and also I did not want to install Apache over the same server as well.