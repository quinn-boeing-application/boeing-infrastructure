#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

cat > /etc/nginx/sites-enabled/default <<"EOF"
upstream backend {
    server 10.0.0.13:8888;
    server 10.0.0.14:8888;
    #server 10.0.0.15:8888 backup;
    #server 10.0.0.16:8888 backup;
}
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    server_name _;

    location ~ /.well-known {
        try_files $uri $uri/ =404;
    }

    location / {
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
 
        proxy_pass http://backend;
        proxy_read_timeout 90;
 
        #proxy_redirect http://backend http://www.boeing.com;
    }
}
EOF

service nginx restart
