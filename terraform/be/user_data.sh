#!/usr/bin/env bash

yum update
yum install docker -y
usermod -aG docker ec2-user
systemctl enable docker
systemctl start docker

