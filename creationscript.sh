#!/bin/bash

#configuration
resource_group_name="resourcegroup"
vmname=$(cat ./ARMparameters/bastion.parameters.json | jq -r .parameters.vmName.value)
vmpassword=$(openssl rand -base64 10)
escappedvmpasswordvalue=$(printf '%s\n' "${vmpassword}" | sed 's/[]\/$*.^[]/\\&/g')
sed -i -e "s/<<DUMMYVALUE>>/${escappedvmpasswordvalue}/" ./ARMparameters/bastion.parameters.json

#deploy resources
az group create --name $resource_group_name --location eastus
az deployment group create --resource-group $resource_group_name --template-file ./ARMtemplates/storageaccount.json --parameters ./ARMparameters/saparam.parameters.json
az deployment group create --resource-group $resource_group_name --template-file ./ARMtemplates/storageaccount.json --parameters ./ARMparameters/sa2param.parameters.json
az deployment group create --resource-group $resource_group_name --template-file ./ARMtemplates/linuxtemplate.json --parameters ./ARMparameters/bastion.parameters.json

#file templates setup
storageaccount1name=$(cat ./ARMparameters/saparam.parameters.json | jq -r .parameters.storageAccountName.value | sed 's/projectmsc//')
storageaccount2name=$(cat ./ARMparameters/sa2param.parameters.json | jq -r .parameters.storageAccountName.value | sed 's/projectmsc//')
storageaccount1pw=$(az storage account keys list --account-name sastorage01projectmsc  --query '[0].value' --output tsv)
storageaccount2pw=$(az storage account keys list --account-name sastorage02projectmsc  --query '[0].value' --output tsv)
escappedpasswordvalue1=$(printf '%s\n' "${storageaccount1pw}" | sed 's/[]\/$*.^[]/\\&/g')
escappedpasswordvalue2=$(printf '%s\n' "${storageaccount2pw}" | sed 's/[]\/$*.^[]/\\&/g')

sed -i -e "s/<<DUMMYVALUEPASSWORD1>>/${escappedpasswordvalue1}/" ./connect.sh
sed -i -e "s/<<DUMMYVALUEPASSWORD2>>/${escappedpasswordvalue2}/" ./connect.sh
vmname=$(cat ./ARMparameters/bastion.parameters.json | jq -r .parameters.vmName.value)

#run file transfer
az vm run-command invoke -g $resource_group_name -n $vmname --command-id RunShellScript --scripts "@connect.sh" --parameters $storageaccount1name $storageaccount2name 
