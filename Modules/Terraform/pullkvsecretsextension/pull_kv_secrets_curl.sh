#! /bin/bash

# This scripts installs jq: http://stedolan.github.io/jq/
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
chmod +x jq
sudo mv jq /usr/local/bin

accessToken=$(curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true  | /usr/local/bin/jq --raw-output -r '.access_token')

secretValue=$(curl https://${keyvaultName}.vault.azure.net//secrets/${secretName}?api-version=2016-10-01 -H "Authorization: Bearer $accessToken" | /usr/local/bin/jq --raw-output -r '.value')
echo $secretValue