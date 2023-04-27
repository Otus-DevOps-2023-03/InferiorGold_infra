#!/bin/bash
apt install apt-transport-https ca-certificates
apt update  && apt upgrade -y
#apt --fix-broken install
#apt update
apt install mongodb -y
apt update
#Start mongodb
systemctl enable mongodb
systemctl start mongodb
systemctl status mongodb
service mongod enable
service mongod start
service mongod status
systemctl enable mongod
systemctl start mongod
systemctl status mongod
nc -zvv localhost 27017
mongo --version
mongod --version
