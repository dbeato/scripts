#Prior to doing anytighing if you are basing this on a Debian 9 NetInstall you need to install the following packages as root
apt install ufw sudo -y
#Then setup the user in the sudo group
sudo adduser username sudo 
#Then you can start the install process as below
#1-Install the Zabbix Repository
wget wget https://repo.zabbix.com/zabbix/4.0/debian/pool/main/z/zabbix-release/zabbix-release_4.0-2+stretch_all.deb
sudo dpkg -i zabbix-release_4.0-2+stretch_all.deb
sudo apt update
#2- Install Zabbix Server Package
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-agent
#3-  Secure MariDB  & Create your MariaDB Database
sudo mysql_secure_installation
mysql -uroot -p
password
mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'password';
mysql> quit
#4- Import the Zabbix Server SQL Database to Mysql 
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
#5- Edit the Zabbix Server Configuration
sudo nano /etc/zabbix/zabbix_server.conf
#Change the DB password
#DBPassword=password
#6-Edit the Zabbix PHP for the frontend
sudo nano /etc/zabbix/apache.conf
#Uncommnent the following line and adjust to your time zone
#php_value date.timezone America/New_York 
#7- Start the Zabbix Server
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
#8- Edit the Zabbix Apache Configuration to be the root of the Webserver
sudo nano /etc/apache2/sites-available/000-default.conf
#Change the DocumentRoot from /var/www/html 
#to 
#DocumentRoot /usr/share/zabbix
#9- Edit the Zabbix Apache Alias Configuration
sudo nano /etc/apache2/conf-available/zabbix.conf
#Comment the following line 
#Alias /zabbix /usr/share/zabbix
#10- Restart the Apache2 Service
sudo systemctl restart apache2
#11- Go to your web browser and configure Zabbix
#![0_1542820456552_464c1de9-6a8e-424f-8c4e-6a7be313c805-image.png](https://i.imgur.com/zMlCr1V.png) 
#
#12- Press next and make sure your prerequisites are me
#![0_1542820519202_62fff5ff-379b-47a3-a3f6-69956d6847d6-image.png](https://i.imgur.com/zkui6c1.png) 
#![0_1542820524809_4d60afe4-ec00-4a9f-b802-33e2c9da992e-image.png](https://i.imgur.com/AiIGLZn.png) 
#13- Press Next and configure your Database Configuration
#![0_1542820583170_ae25d54b-1ec6-4563-8e9e-38f9ad94946b-image.png](https://i.imgur.com/q7yMlFH.png) 
#14- Press Next and configure the server name and port
#![0_1542820617534_72f060f0-2215-4614-8e47-2bbd84a34e42-image.png](https://i.imgur.com/K3tFxm1.png) 
#15- You will get a summary of the install and then press next
#![0_1542820644728_2e0aadd6-9e8e-4030-ae4a-9747d6105469-image.png](https://i.imgur.com/wTdkGXE.png) 
#16- You will then presented that your installation was successful
#![0_1542820682268_08fdcdf6-839f-4677-9c9f-5f970f835797-image.png](https://i.imgur.com/jprDzIK.png) 
#17- Press Finish
#18- You will be presented with the Login Screen 
#![0_1542820749717_4b544537-6754-4323-8070-7cd710e35310-image.png](https://i.imgur.com/a8aMQNF.png) 
#The default username and password is **Admin** and **zabbix** respectively.
#19- You will now be on the Zabbix Dashboard
#![0_1542820833552_51cf7579-df82-4ba1-b2da-5614da7de8df-image.png](https://i.imgur.com/4T1DiqQ.png)
#For your firewall rules open port 80,10050, 10051 and I decided on this post to limit it to my own network for SSH. (I only used port 80 because I plan on placing it behind a SSL proxy server)  
sudo ufw allow 80,10050,10051/tcp
sudo ufw allow from 192.168.x.0/24  to any port 22
sudo ufw enable
