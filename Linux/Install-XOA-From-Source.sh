#This script is written to be installed on Debian. 
#Sources on https://xen-orchestra.com/docs/from_the_sources.html
sudo apt-get install -y cifs-utils nfs-common
sudo apt-get install -y curl software-properties-common
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt-get install -y nodejs
sudo npm install yarn -g
sudo apt-get install build-essential redis-server libpng-dev git python-minimal libvhdi-utils lvm2
git clone -b master http://github.com/vatesfr/xen-orchestra
sudo yarn
sudo yarn build
cd packages/xo-server
cp sample.config.yaml .xo-server.yaml
#Edit the .xo-server.yaml and enable this part for xo-web (mounts: '/': '../xo-web/dist/)
sudo yarn start

