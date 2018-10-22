#!/bin/bash
# Set -e will cause the script to exit if it encounters an error.
set -e


# This is where it all starts.
# This script is run in the google cloud shell.
# Its main goal is to get us out of the google cloud shell ASAP.

# It's also the only part that requires interaction.
# There are two questions you'll be asked.

# The first question will be your project ID.
# This ID must be globally unique!!!
# You will NOT be asked for a project name. It will be your project ID by default.
# Project name can be set later.

# The second question will be your billin account ID.
# A billing account is required!!!

# No need to select an organization, as a non org project can be moved into an org later.
echo "Enter your desired project ID. This must be globally unique on google cloud."
read project_id < /dev/tty

gcloud beta billing accounts list

echo "Above you can see a list of billing accounts you have access to."
echo "Enter the billing account ID of the billing account you wish to link to this project."
read billing_id < /dev/tty

echo "##### Creating project $project_id #####"
# No beta version of this.
gcloud projects create "$project_id" --name="$project_id"
gcloud beta config set project "$project_id"

echo "##### Linking project $project_id with billing account $(gcloud beta billing accounts describe "$billing_id" --format json | jq -r .displayName) #####"
gcloud beta billing projects link "$project_id" --billing-account "$billing_id"

echo "##### Enabling the compute API #####"
gcloud beta services enable compute.googleapis.com

echo "##### Enabling OS login for the project #####"
gcloud beta compute project-info add-metadata --metadata enable-oslogin=TRUE

# We can query the instance metadata to determine the zone id of the cloud shell instance.
# We want to use the same zone for our bastion instance.
zone_id=$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/zone)
zone_id=${zone_id##*/}

echo "##### Your cloud shell is located in zone $zone_id #####"
echo "##### Setting the default zone for compute to $zone_id #####"
gcloud beta config set compute/zone "$zone_id"

echo "##### Creating a bastion instance #####"
gcloud beta compute instances create bastion \
       --machine-type=n1-highcpu-2 --subnet=default --network-tier=PREMIUM \
       --maintenance-policy=MIGRATE --image-family=debian-9 --image-project=debian-cloud \
       --boot-disk-size=20GB --boot-disk-type=pd-ssd --boot-disk-device-name=bastion \
       --min-cpu-platform="Intel Skylake" --scopes=https://www.googleapis.com/auth/cloud-platform
