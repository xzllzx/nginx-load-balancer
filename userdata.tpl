#!/bin/bash
sudo apt-get update -y &&
sudo apt-get install -y nginx

# Configure Nginx to retrieve CIDR block
cat <<EOF | sudo tee /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location /vend_ip {
        default_type application/json; 
        return 200 '{"ip_address": "$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/vpc-ipv4-cidr-block | cut -d '/' -f 1)", "subnet_size": "$(curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(curl -s http://169.254.169.254/latest/meta-data/mac)/vpc-ipv4-cidr-block | cut -d '/' -f 2)"}';
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF


# Enable the new Nginx configuration
sudo systemctl restart nginx