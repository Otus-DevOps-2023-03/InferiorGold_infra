#!/bin/bash
apt install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv B00A0BD1E2C63C11
echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org.list
#wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
apt update  && apt upgrade -y
apt --fix-broken install
apt update
apt install mongodb-org
apt update
#Start mongodb
systemctl enable mongodb.service
systemctl start mongodb.service
systemctl status mongodb.service
systemctl enable mongod.service
systemctl start mongod.service
systemctl status mongod.service
mongo --version
mongod --version