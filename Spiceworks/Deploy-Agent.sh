sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt-get update
sudo apt-get install mono-complete
wget https://spiceworks.jfrog.io/spiceworks/deb-public/pool/spiceworks-agentshell-cloud-inventory_0.3.16_all.deb
sudo SITE_KEY=site key dpkg –i spiceworks-agentshell-cloud-inventory_0.3.16_all.deb