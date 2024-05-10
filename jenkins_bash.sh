# bypass key checking step/option
# ssh into ec2
ssh -o  "StrictHostKeyChecking=no" ubuntu@52.50.223.145 <<EOF
# run update and upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

EOF

# copy new code
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@52.50.223.145:/home/ubuntu
rsync -avz -e "ssh -o StrictHostKeyChecking=no" environment ubuntu@52.50.223.145:/home/ubuntu

ssh -o  "StrictHostKeyChecking=no" ubuntu@52.50.223.145 <<EOF
# Install node
curl -fsSL https://deb.nodesource.com/setup_10.x | sudo DEBIAN_FRONTEND=noninteractive -E bash - && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

# install nginx
sudo apt-get install nginx -y
sudo systemctl enable nginx

# install npm
sudo apt install npm -y

# cd into app folder
cd app

# Install node packages
npm install

# Install pm2
sudo npm install pm2 -g

# stop any previously running versions of the app
pm2 stop app

# launch app
pm2 start app.js 


EOF

# navigate to the folder containing the script 
# install the required dependencies using provision.sh
# navigate to app folder
# run node packages with npm
# start app in the background
