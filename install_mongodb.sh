#!/bin/bash
apt install apt-transport-https ca-certificates
apt update  && apt upgrade -y
#apt --fix-broken install
#apt update
apt install mongodb -y
apt update
#Start mongodb
systemctl enable mongod.service
systemctl start mongod.service
sudo systemctl status mongod.service
nc -zvv localhost 27017
mongo --version
mongod --version
