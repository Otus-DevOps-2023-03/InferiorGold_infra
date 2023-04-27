#!/bin/bash
apt-get install apt-transport-https ca-certificates
echo "deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
sudo apt-get update  && sudo apt-get upgrade -y
sudo apt --fix-broken install
apt-get install -y mongodb
apt-get update
#Start mongodb
systemctl enable mongod
systemctl start mongod
systemctl status mongod
mongo --version
