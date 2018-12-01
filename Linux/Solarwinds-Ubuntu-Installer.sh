
#Add the following line "deb http://repos.systemmonitor.co.uk/rmmagent/xUbuntu_17.04/ ./" to  /etc/apt/sources.list
#run as root the following commands
sudo wget -O - http://repos.systemmonitor.us/rmmagent/xUbuntu_17.04/Release.key | apt-key add -
sudo apt update
sudo apt install rmmagent
cd /usr/local/rmmagent
./rmmagentd -i
update-rc.d rmmagent defaults
find /etc/rc*.d/ -name *rmmagent*|grep rc|sort

