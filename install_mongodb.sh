#!/bin/bash
#sudo apt-get install apt-transport-https ca-certificates
echo "deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
sudo apt-get update  && sudo apt-get upgrade -y
sudo apt-get install -y mongodb-org
#Start mongodb
sudo systemctl enable mongod
sudo systemctl start mongod
sudo systemctl status mongod
