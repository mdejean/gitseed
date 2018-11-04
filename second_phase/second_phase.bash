#!/bin/bash
set -e
cd "${0%/*}"

echo "### Installing python-pip ###"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y python-pip

echo "### Installing ansible ###"
sudo pip install ansible

echo "### Running the local ansible playbook! ###"
export ANSIBLE_RETRY_FILES_ENABLED=False
ansible-playbook bastion.yml
