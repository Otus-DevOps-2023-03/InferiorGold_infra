#!/bin/bash
sudo apt-get update
# install ruby, bundler and git
sudo apt-get install -y ruby-full ruby-bundler build-essential git mongodb
sudo systemctl start mongodb
sudo systemctl enable mongodb
sudo systemctl status mongodb
ruby -v && bundler -v

