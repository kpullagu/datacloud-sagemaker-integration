#!/bin/bash
set -eux
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 16
# wget https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-linux-x64.tar.gz
# mkdir ~/sfdx
# tar xvzf sfdx-linux-x64.tar.gz -C ~/sfdx --strip-components 1
# export PATH=~/sfdx/bin:$PATH
npm install sfdx-cli --global

echo "sfdx --version"
sfdx --version
