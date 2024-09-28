#!/bin/bash
set -eux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -u awscliv2.zip
#which aws
#ls -l /usr/bin/aws

sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/aws-cli --update
aws --version