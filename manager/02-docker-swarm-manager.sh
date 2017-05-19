#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

docker swarm init --advertise-addr 10.0.0.12
docker service create --name registry --publish 5000:5000 registry:2
