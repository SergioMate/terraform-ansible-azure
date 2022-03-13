# terraform-ansible-azure
This repository enables Kubernetes cluster atomatized deployment into Azure with Terraform and Ansible with the snake game application.

## Architecture
- Virtual machine with 2 vCPU, 16 GB RAM and 30 GB ROM with kubernetes master role and NFS service.
- 2 virtual machines with single vCPU, 14 GB RAM and 30 GB ROM with kubernetes workers role.

> NOTE: This architecture enables Azure deployment with Student account limitation of maximum 4 vCPU.

## Requirements
- Machine from which the environment will be deployed must have a Linux operating system.
- User with administrator privileges will be necessary.
- A pair of public-private keys without password and with access restricted to the user will be necessary.
- An Azure account will be necessary in which following image terms have been accepted:

      publisher = "cognosys"
      offer    	= "centos-8-stream-free"
      sku	    = "centos-8-stream-free"
      versión	= "1.2019.0810"

## Deployment
1. Run [controller_install.sh](controller_install.sh) script to install all needed packages in controller machine
2. Modify Azure [credentials](terraform/credentials.tf) for Terraform
3. Review Terraform variables \([correccion-vars.tf](terraform/correccion-vars.tf) and [vars.tf](terraform/vars.tf)\) and Ansible variables \([all.yml](ansible/group_vars/all.yml)\)
  > Kubernetes Ingress Controller Port default value will be replaced during deployment
4. Run [deploy.sh](deploy.sh) script to deploy infrastructure with Terraform, which will call Ansible playbook to install needed packages.

##Destroy
Run [destroy.sh](destroy.sh) script to destroy Azure infraestructure
