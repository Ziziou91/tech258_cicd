#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y
sudo systemctl enable nginx

# Set reverse proxy in nginx config
echo setting reverse proxy in nginx/sites-enabled/default
sudo sed -i '51s/.*/\t        proxy_pass http:\/\/localhost:3000;/' /etc/nginx/sites-enabled/default
echo DONE reverse proxy set

# restart nginx
echo restarting nginx...
sudo systemctl restart nginx
echo DONE nginx restarted


# install git
sudo apt-get install git -y

# Install node
curl -fsSL https://deb.nodesource.com/setup_10.x | sudo DEBIAN_FRONTEND=noninteractive -E bash - && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# install npm
sudo apt install npm -y

# cd into app folder
cd ~/app

# Install node packages
npm install

# Install pm2
sudo npm install pm2 -g

# stop any previously running versions of the app
pm2 stop app

# launch app
pm2 start app.js 

