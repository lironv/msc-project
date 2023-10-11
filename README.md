
  <h3 align="center">- Msc Project -</h3>

<!-- ABOUT THE PROJECT -->
## 

This project aims to automate the deployment of an Azure Linux Virtual Machine (VM) with two service accounts using a file share system. It also involves creating and transferring 100 files between these accounts. This resources will be achieved through ARM templates, Continuous Integration and Continuous Deployment (CI/CD) with shell scripts, and Azure DevOps pipelines with a dedicated agent.

<!-- GETTING STARTED -->
## ARM templates
Azure resource manager - ARM templates are JSON files that define the resources you need to deploy in Azure, along with their configuration settings and dependencies. These templates enable you to define your infrastructure as code.
in this project i created 2 ARM templates which creates:
- linux virtual machine
- storage account which includes fileshare storage service.
* each of the template include all the necessary resources for deployment eg. compute, network subnets, public ip and such.

 
### Deployment

To deploy the project you will need the following:

1. Azure agent which connected to azure subscription account 
2. Azure devops project and connecting the agent to the project.
3. running the azure-pipelines.yml file from the Github repository 



<!-- USAGE EXAMPLES -->
## Usage

