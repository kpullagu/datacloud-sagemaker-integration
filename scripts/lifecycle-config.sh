#!/bin/bash

set -eux
if [ $# -lt 3 ]; then
    echo "I need a minimum of 3 arguments to proceed. REGION, DomainName, UserProfileName" && exit 1
fi
# PARAMETERS
REGION=$1
DomainName=$2
UserProfileName=$3
SCRIPT_TYPE="JupyterServer"
#verify latest aws cli
echo "AWS Cli version after upgrade"
aws --version


LCC_CONTENT=`openssl base64 -A -in storesecret.sh`
LCC_SCRIPT_NAME='store-secret-to-file'

DOMAIN_ID=$(aws sagemaker list-domains --query "Domains[?DomainName=='$DomainName'].DomainId" --region $REGION --output text)

# Create a lifecycle configuration that runs when you launch an associated JupyterServer application
LifeCycleConfig_ARN=$(aws sagemaker create-studio-lifecycle-config --region $REGION --studio-lifecycle-config-name $LCC_SCRIPT_NAME --studio-lifecycle-config-content $LCC_CONTENT --studio-lifecycle-config-app-type $SCRIPT_TYPE --query "StudioLifecycleConfigArn" --output text)

# Associate the lifecycle configuration to a domain or userprofile
aws sagemaker update-domain --domain-id $DOMAIN_ID --default-user-settings '{"JupyterServerAppSettings": {"DefaultResourceSpec": {"InstanceType": "system", "LifecycleConfigArn": "'"$LifeCycleConfig_ARN"'"}, "LifecycleConfigArns": ["'"$LifeCycleConfig_ARN"'"]}}'
