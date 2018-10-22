#!/bin/bash
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

# We enable the compute API. The compute API is required in order to spin up a bastion instance.
#gcloud beta services enable compute.googleapis.com
