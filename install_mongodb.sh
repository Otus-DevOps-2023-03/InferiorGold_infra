#!/bin/bash
sudo apt install apt-transport-https ca-certificates
sudo apt update  && sudo  apt upgrade -y
#apt --fix-broken install
#apt update
sudo apt install mongodb -y
sudo apt update
#Start mongodb
sudo systemctl enable mongod.service
sudo systemctl start mongod.service
sudo systemctl status mongod.service
nc -zvv localhost 27017
mongo --version
mongod --version
