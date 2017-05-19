#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y software-properties-common
apt-get update
add-apt-repository ppa:nginx/development -y
apt-get update
apt-get install -y nginx
