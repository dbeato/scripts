curl https://name-of-msp.cmdm.comodo.com/enroll/linux/run/token/e7a271c684525ac6c1cade645507058911 --output itsm_7XrPQwon_installer.run
sudo chmod +x itsm_7XrPQwon_installer
sudo ./itsm_7XrPQwon_installer
#If you cannot run the installer due to a Libcurl issue run the following command
#sudo apt-get install libcurl4-openssl-dev