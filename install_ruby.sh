#!/bin/bash
sudo apt-get update
# install ruby, bundler and git
sudo apt-get install -y ruby-full ruby-bundler build-essential git
ruby -v
bundler -v