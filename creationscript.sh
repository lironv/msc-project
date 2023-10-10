#!/bin/bash

#configuration
vmpassword=$(openssl rand -base64 10)
escappedvmpasswordvalue=$(printf '%s\n' "$vmpassword" | sed 's/[]\/$*.^[]/\\&/g')
sed -i -e "s/<<DUMMYVALUE>>/$vmpassword/" ./bastion.parameters.json

#deploy resources
az group create --name resourcegroup --location eastus
az deployment group create --resource-group resourcegroup --template-file storageaccount2.json --parameters saparam.parameters.json
az deployment group create --resource-group resourcegroup --template-file storageaccount2.json --parameters sa2param.parameters.json
az deployment group create --resource-group resourcegroup --template-file linuxtemplate.json --parameters bastion.parameters.json

#file templates setup
storageaccount1name=$(cat ./saparam.parameters.json | jq -r .parameters.storageAccountName.value | sed 's/projectmsc//')
storageaccount2name=$(cat ./sa2param.parameters.json | jq -r .parameters.storageAccountName.value | sed 's/projectmsc//')
storageaccount1pw=$(az storage account keys list --account-name sastorage01projectmsc  --query '[0].value' --output tsv)
storageaccount2pw=$(az storage account keys list --account-name sastorage02projectmsc  --query '[0].value' --output tsv)
escappedpasswordvalue1=$(printf '%s\n' "$storageaccount1pw" | sed 's/[]\/$*.^[]/\\&/g')
escappedpasswordvalue2=$(printf '%s\n' "$storageaccount2pw" | sed 's/[]\/$*.^[]/\\&/g')

sed -i -e "s/<<DUMMYVALUEPASSWORD1>>/${escappedpasswordvalue1}/" ./connect.sh
sed -i -e "s/<<DUMMYVALUEPASSWORD2>>/${escappedpasswordvalue2}/" ./connect.sh

#run file transfer
az vm run-command invoke -g resourcegroup -n bastion1 --command-id RunShellScript --scripts "@connect.sh" --parameters $storageaccount1name $storageaccount2name 
