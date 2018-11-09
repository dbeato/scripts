#First you need to add the certbot repository
sudo add-apt-repository ppa:certbot/certbot
#Then you install the software-properties-common package
sudo apt install software-properties-common
#Update the repositories
sudo apt  update
#Install the Certbot for Nginx
sudo apt-get install python-certbot-nginx
#Install the Python-Pip package
sudo apt install python-pip
#Install the Pip Module for Certbot-dns-cloudflare
sudo pip install certbot-dns-cloudflare
#Get your CloudFlare API key
#https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-Cloudflare-API-key-
#Then setup a secret file with your key on whichever path you want, I chose the /root/.secrets folder,
sudo mkdir /root/.secrest
sudo chmod 0700 /root/.secrets/
sudo touch /root/.secrets/cloudflare.cfg
sudo chmod 0400 /root/.secrets/cloudflare.cfg
#Edit the /root/.secrets/cloudflare.cfg by using nano
sudo nano /root/.secrets/cloudflare.cfg
#Edit the file and enter your CloudFlare Email and your API key as below
echo 'dns_cloudflare_email = "email@domain.com"' > /root/.secrets/cloudflare.cfg
echo 'dns_cloudflare_api_key = "2018c330b45f4ghytr420eaf66b49c5cabie4"' > /root/.secrets/cloudflare.cfg
#Request a single, SAN or wildcard SSL Certificate from Cloudflare as below
#
sudo /usr/local/bin/certbot certonly --dns-cloudflare --dns-cloudflare-credentials /root/.secrets/cloudflare.ini -d domain.com,*.domain.com --preferred-challenges dns-01
#Results should be showing confirmed configuration
#Then I added a cronjob as below
14 5 * * * /usr/local/bin/certbot renew --quiet --post-hook "/usr/sbin/service nginx reload" > /dev/null 2>&1
#Then I added manually the configuration for SSL on the Nginx Configuration File
sudo nano /etc/nginx/conf.d/domain.conf
#Added this section

#listen 443 ssl; # managed by Certbot
#   ssl_certificate /etc/letsencrypt/live/domain.com/fullchain.pem; # managed by Certbot
#  ssl_certificate_key /etc/letsencrypt/live/domain.com/privkey.pem; # managed by Certbot
#    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
#   ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
#Check your configuration

sudo nginx -t
#Reload Nginx
sudo nginx -s reload