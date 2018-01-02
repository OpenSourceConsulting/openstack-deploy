#!/bin/bash

echo "Install packages for ansible"
yum install -y python-devel libffi-devel gcc openssl-devel libselinux-python epel-release

echo "Install pip and ansible"
yum install -y python-pip
pip install -U pip

echo "Install ansible-2.4.0"
pip install ansible==2.4.0

# slack integrate test
