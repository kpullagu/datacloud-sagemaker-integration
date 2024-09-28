#!/bin/bash
set -eux
if [ $# -lt 2 ]; then
    echo "I need a minimum of 2 arguments to proceed. REGION, SalesforceOAuthSecretName" && exit 1
fi
REGION=$1
SalesforceOAuthSecretName=$2

AWS_SECRET_ARN=$(aws secretsmanager describe-secret --secret-id $SalesforceOAuthSecretName --region $REGION --output text --query ARN)
cat > ~/.sfgenie_identity_provider_oauth_config <<EOL
{
"secret_arn": "$AWS_SECRET_ARN"
}
EOL
