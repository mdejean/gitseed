#!/bin/bash
set -e

echo "#### Unpacking the repository ####"
mkdir ~/gitseed
tar -C ~/gitseed -zxf /tmp/gitseed.tar.gz
rm /tmp/gitseed.tar.gz

echo "#### Downloading and installing gotty ####"
gotty_url="https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz"
wget --progress=dot:giga -O /tmp/gotty.tar.gz "$gotty_url"
tar -C /tmp/ -zxvf /tmp/gotty.tar.gz
sudo cp /tmp/gotty /usr/local/bin/gotty
rm /tmp/gotty.tar.gz

echo "#### Executing phase_two in gotty ####"
sudo /usr/local/bin/gotty -p 80 --timeout 60 ~/gitseed/second_phase/second_phase.bash &> /tmp/gotty.log &
disown -h
echo "The gotty log is at /tmp/gotty.log"
echo "Visit http://$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google") to continue!"
