
  <h3 align="center">- Msc Project -</h3>

<!-- ABOUT THE PROJECT -->
## 

This project aims to automate the deployment of an Azure Linux Virtual Machine (VM) with two service accounts using a file share system. It also involves creating and transferring 100 files between these accounts.
This resources will be achieved through ARM templates, Continuous Integration and Continuous Deployment (CI/CD) with shell scripts, and Azure DevOps pipelines with a dedicated agent.

<!-- GETTING STARTED -->

## ARM templates
Azure resource manager - ARM templates are JSON files that define the resources you need to deploy in Azure, along with their configuration settings and dependencies. These templates enable you to define your infrastructure as code.
In this project i created 2 ARM templates which creates:
- Linux virtual machine
- Storage account which includes fileshare storage service.
* each of the template include all the necessary resources for deployment eg. compute, network subnets, public ip and such.

## Parameters

For security i have added dummy values over the passwords, the linux vm password is generated and used, the storage accounts passwords are taken and added to the shell script thus not compromise security. 
Each of the ARM templates is using parameters files that can be changed for multiple deployments.


## CICD
Using azure devops pipeline we call the shell script which automatically deploys the resources.
In my methodology, inside the shell script i run another script called connect.sh that runs the creation of blobs and moving them between the resources.


## Deployment and run. 

To deploy the project you will need the following:

1. Azure agent which connected to azure subscription account.
2. Azure devops project and connecting the agent to the project.
3. Running the azure-pipelines.yml file from the Github repository.
   
## Execute
to run this project on your own bastion you need an azure self hosted agent and connecting it to azure subscription account.
1. define your wanted variables:
   - creationscript.sh: resource_group_name="your resource group name", vmpassword="password"(currently its auto generating a password)
   - bastion.parameters.json: "adminUsername": "value"
   - sa2param.parameters.json:
       - "storageAccountName": {"value": "(your storage account name here) projectmsc" }
       - "fileShareName": {"value": "(your fileshare name here)fs-share" }
   - saparam.parameters.json:
       - "storageAccountName": {"value": "(your storage account name here) projectmsc" }
       - "fileShareName": {"value": "(your fileshare name here)fs-share" }

     
     


<!-- USAGE EXAMPLES -->
## Usage
![image](https://github.com/lironv/msc-project/assets/45284793/d502997d-9497-451c-a32f-975d23bd262a)

## Monitor
![image](https://github.com/lironv/msc-project/assets/45284793/28a639eb-0158-4547-99b2-07c279f4a4a7)

