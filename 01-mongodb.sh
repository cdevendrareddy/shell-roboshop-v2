#!/bin/bash

source ./common.sh

cp mongo.repo /etc/yum.repos.d/mongo.repo
validate $? "Adding MongoDB repo"

dnf install mongodb-org -y &>> $logs_file
validate $? "Installing MongoDB"

systemctl enable mongod &>> $logs_file
systemctl start mongod &>> $logs_file
validate $? "Starting MongoDB service"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
validate $? "Updating MongoDB config file"

systemctl restart mongod 
validate $? "Restarting MongoDB service"