#!/usr/bin/env bash

yum update
yum install git -y
yum install docker -y

usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

git clone https://github.com/farid-najafov/se-step-project.git

cd se-step-project/phonebook

docker build -t phonebook-app:v1.0.0 .
docker run --name phonebook-app -p 80:80 phonebook-app:v1.0.0
