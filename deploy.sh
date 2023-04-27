#!/bin/bash
#enter in home directory
cd /home/yc-user
#clone repository app from git
git clone -b monolith https://github.com/express42/reddit.git
#enter in folder and install app
cd reddit && bundle install
#run app
puma -d
#check app and listen port
ps aux | grep puma
