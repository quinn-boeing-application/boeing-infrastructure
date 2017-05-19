#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get -y install git-core

cd /tmp
wget http://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-x64.tar.gz
tar -C /usr/local --strip-components 1 -xzf node-v6.10.3-linux-x64.tar.gz
rm node-v6.10.3-linux-x64.tar.gz
npm install -g npm
npm install -g mocha pm2

pm2 startup ubuntu -u jenkins --hp /var/lib/jenkins
