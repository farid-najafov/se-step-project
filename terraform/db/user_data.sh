#!/usr/bin/env bash

yum update
yum install docker -y
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

docker run --name mysql_db -e MYSQL_ROOT_PASSWORD=my-secret-pw -e MYSQL_DATABASE=phonebook_db -d -p 3306:3306 mysql