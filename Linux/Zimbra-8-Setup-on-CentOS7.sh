#Login to your CentOS 7 Server
#Run the following command
yum -y install unzip net-tools sysstat openssh-clients perl-core libaio nmap-ncat wget libreoffice-headless libreoffice bind-utils libstdc++.so.6
#Setup the Hostname of the server
hostnamectl set-hostname mail
#Setup local hostname for external server
echo "10.0.4.x mail.domain.com mail " >> /etc/hosts
#Download Zimbra Installer
wget https://files.zimbra.com/downloads/8.8.6_GA/zcs-8.8.6_GA_1906.RHEL7_64.20171130041047.tgz
#Extract and access the installer
tar xzvf zcs-8.8.6_GA_1906.RHEL7_64.20171130041047.tgz
cd zcs-8.8.6_GA_1906.RHEL7_64.20171130041047
#Start the install process
sudo ./install.sh
#Go through the installation settings
#
# Operations logged to /tmp/install.log.y1YeCSI5
#Checking for existing installation...
#    zimbra-chat...NOT FOUND
#    zimbra-drive...NOT FOUND
#   zimbra-imapd...NOT FOUND
#  zimbra-network-modules-ng...NOT FOUND
# zimbra-ldap...NOT FOUND
#zimbra-logger...NOT FOUND
#zimbra-mta...NOT FOUND
#zimbra-dnscache...NOT FOUND
#zimbra-snmp...NOT FOUND
#zimbra-store...NOT FOUND
#zimbra-apache...NOT FOUND
#zimbra-spell...NOT FOUND
#zimbra-convertd...NOT FOUND
#zimbra-memcached...NOT FOUND
#zimbra-proxy...NOT FOUND
#zimbra-archiving...NOT FOUND
#zimbra-core...NOT FOUND

#- Then slect the packages you want to use
#Checking for installable packages
#Found zimbra-core (local)
#Found zimbra-ldap (local)
#Found zimbra-logger (local)
#Found zimbra-mta (local)
#Found zimbra-dnscache (local)
#Found zimbra-snmp (local)
#Found zimbra-store (local)
#Found zimbra-apache (local)
#Found zimbra-spell (local)
#Found zimbra-convertd (local)
#Found zimbra-memcached (repo)
#Found zimbra-proxy (local)
#Found zimbra-archiving (local)
#Found zimbra-chat (repo)
#Found zimbra-drive (repo)
#Found zimbra-imapd (local)
#Found zimbra-network-modules-ng (local)
# make sure to answer this questions
'''
Use Zimbra's package repository [Y] y
Use internal development repo [N] n
Configuring package repository
Install zimbra-ldap [Y] y
Install zimbra-logger [Y] y
Install zimbra-mta [Y] y
Install zimbra-dnscache [Y] n
Install zimbra-snmp [Y] y
Install zimbra-store [Y] y
Install zimbra-apache [Y] y
Install zimbra-spell [Y] y
Install zimbra-convertd [Y] y
Install zimbra-memcached [Y] y
Install zimbra-proxy [Y] y
Install zimbra-archiving [N] y
Install zimbra-chat [Y] n
Install zimbra-drive [Y] n
Install zimbra-imapd [Y] n

Checking required space for zimbra-core
Checking space for zimbra-store
Checking required packages for zimbra-store

Installing:
    zimbra-core
    zimbra-ldap
    zimbra-logger
    zimbra-mta
    zimbra-snmp
    zimbra-store
    zimbra-apache
    zimbra-spell
    zimbra-convertd
    zimbra-memcached
    zimbra-proxy
    zimbra-archiving


The system will be modified.  Continue? [N] y
Then add the domain you will be using such as domain.com

Select option 6 for setting up the Admin user password

Main menu

  1) Common Configuration:
  2) zimbra-ldap: Enabled
  3) zimbra-logger: Enabled
  4) zimbra-mta: Enabled
  5) zimbra-snmp: Enabled
  6) zimbra-store: Enabled
  +Create Admin User: yes
  +Admin user to create: admin@domain.com
******* +Admin Password UNSET
  +Anti-virus quarantine user: virus-quarantine.bcsk28oyoe@domain.com
  +Enable automated spam training: yes
  +Spam training user: spam.dqxmkmf5t@domain.com

  +Non-spam(Ham) training user: ham.pcq8excwp@domain.com

  +SMTP host: mail.domain.com
  +Web server HTTP port: 8080
  +Web server HTTPS port: 8443
  +Web server mode: https
  +IMAP server port: 7143
  +IMAP server SSL port: 7993
  +POP server port: 7110
  +POP server SSL port: 7995
  +Use spell check server: yes
  +Spell server URL: http:// mail.domain.com:7780/aspell.php
  +Enable version update checks: TRUE
  +Enable version update notifications: TRUE
  +Version update notification email: admi@domain.com

  +Version update source email: admin@domain.com

  +Install mailstore (service webapp): yes
  +Install UI (zimbra,zimbraAdmin webapps): yes
******* +License filename: UNSET

  7) zimbra-spell: Enabled
  8) zimbra-convertd: Enabled
  9) zimbra-proxy: Enabled
  10) Default Class of Service Configuration:
  11) Enable default backup schedule: yes
  s) Save config to file
  x) Expand menu
  q) Quit

Address unconfigured (**) items (? - help)
Type r to return to the Main menu.

The store configuration menu displays.

Select the following from the store configuration menu:

Type 4 to set the Admin Password. The password must be six or more characters. Press Enter.
Type r to return to the Main menu.

If no other defaults need to be changed, type a to apply the configuration changes. Press Enter
*** CONFIGURATION COMPLETE - press 'a' to apply
Select from menu, or press 'a' to apply config (? - help

- Save configuration data to a file? [Yes]
- Save config in file: [/opt/zimbra/config.16039]
- Saving config in /opt/zimbra/config.16039...done.

The system will be modified - continue? [No] y
Operations logged to /tmp/zmsetup.20160711-234517.log
Setting local config values...done.

Moving /tmp/zmsetup.20160711-234517.log to /opt/zimbra/log

Configuration complete - press return to exit 
''
#If behind NAT and on my case, setup MTA to do HostLookup Native

zmprov ms mtaserver.com zimbraMtaLmtpHostLookup native
zmprov mcf zimbraMtaLmtpHostLookup native
zmmtactl restart
#Your ZImbra Server should be all set to be accessible and receive emails.