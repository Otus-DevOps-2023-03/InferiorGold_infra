#!/bin/bash
apt-get install apt-transport-https ca-certificates
apt remove --autoremove mongodb-org
rm /etc/apt/sources.list.d/mongodb*.list
apt update
echo "deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
sudo apt-get update  && sudo apt-get upgrade -y
sudo apt --fix-broken install
apt remove mongodb
apt purge mongodb
apt autoremove
apt-get install -y mongodb-org
#Start mongodb
systemctl enable mongod
systemctl start mongod
systemctl status mongod
