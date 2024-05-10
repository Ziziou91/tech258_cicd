EC2_IP=18.201.193.156

# bypass key checking step/option
# ssh into ec2
ssh -o  "StrictHostKeyChecking=no" ubuntu@$EC2_IP <<EOF
# run update and upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

EOF

# copy new code
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@$EC2_IP:/home/ubuntu
rsync -avz -e "ssh -o StrictHostKeyChecking=no" environment ubuntu@$EC2_IP:/home/ubuntu

ssh -o  "StrictHostKeyChecking=no" ubuntu@$EC2_IP <<EOF
# cd into env app folder
cd environment/app

chmod +x provision.sh
./provision.sh

EOF