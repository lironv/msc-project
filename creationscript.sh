#!/bin/bash

#appConfigName=runnerconfig

#az account set --subscription 98eb592d-460e-4f2a-a0fd-958deefc49e0
#az group create --name resourcegroup --location eastus
#vmpassword=$(openssl rand -base64 10)
#sed -i -e "s/<<DUMMYVALUE>>/$vmpassword/" ./bastion.parameters.json
#az deployment group create --resource-group resourcegroup --template-file storageaccount2.json --parameters saparam.parameters.json
#az deployment group create --resource-group resourcegroup --template-file storageaccount2.json --parameters sa2param.parameters.json
#az deployment group create --resource-group resourcegroup --template-file linuxtemplate.json --parameters bastion.parameters.json
#az vm show --resource-group resourcegroup --name bastion1 --show-details --query "publicIps" --output tsv >> login.ini
storageaccount1pw=$(az storage account keys list --account-name sastorage01projectmsc  --query '[0].value' --output tsv)
storageaccount2pw=$(az storage account keys list --account-name sastorage02projectmsc  --query '[0].value' --output tsv)
storageaccount1name="sastorage01"
storageaccount2name="sastorage02"
escappedpasswordvalue1=$(printf '%s\n' "$storageaccount1pw" | sed 's/[]\/$*.^[]/\\&/g')
escappedpasswordvalue2=$(printf '%s\n' "$storageaccount2pw" | sed 's/[]\/$*.^[]/\\&/g')

sed -i -e "s/<<DUMMYVALUEPASSWORD1>>/${escappedpasswordvalue1}/" ./connect.sh
sed -i -e "s/<<DUMMYVALUEPASSWORD2>>/${escappedpasswordvalue2}/" ./connect.sh


az vm run-command invoke -g resourcegroup -n bastion1 --command-id RunShellScript --scripts "@connect.sh" --parameters $storageaccount1name $storageaccount2name 

#sshpass -p Bastion5key1992 scp connect.sh passer.sh  Bastion@172.171.236.136:/home/Bastion
#sshpass -p Bastion5key1992 ssh Bastion@172.171.236.136 'sudo apt-get update; sudo apt-get install azure-cli -y; az account set --subscription 98eb592d-460e-4f2a-a0fd-958deefc49e0; /home/Bastion/connect.sh ;sudo /home/Bastion/passer.sh '
