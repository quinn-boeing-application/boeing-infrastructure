#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

cat >> /home/ubuntu/.ssh/authorized_keys <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcKnfhI337xc3XxOuZQTIUWG5c21+9a0EqQ5HRZthYV jenkins@localhost
EOF

chown -R ubuntu: /home/ubuntu/.ssh
