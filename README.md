# azure-module-terraform
This module creates a vnet with subnets containing a VM running Ubuntu 18.04 with the ADLoginForLinux extension enabled this allows you to ssh into and authorize using your active directory login.  

## Prerequisites
This module does make use of Terraform version constraints (see versions.tf) but can be summarised as:

Terraform 0.13.5 or above
Terraform Azure provider 2.33.0 or above

## Usage
This module is intended to be very simple to use:

```
module vnet {
  source = "github.com/LeapBeyond/azure-module-terraform"
 
  tags = { Owner = "Soren", Client = "Leap Beyond", Project = "Terraform Module Test" }

  region = "North Europe" 
  vnet_cidr       = "172.31.100.0/24"
  vnet_name       = "terraform-test"
  ssh_inbound    = "37.120.131.188"
}
```

| Variable | Comment |
| :------- | :------ |
| tags | a map of strings to use as the common set of tags for all generated assets |
| region | the region the module will be deployed |
| vnet_cidr | the CIDR block for the VNET. The VNET is split into 4 subnets |
| vnet_name | a name for the VPC that is used as a prefix on asset names and tags |
| ssh_inbound | a list of IP's or CIDR blocks which are permitted to SSH into public instances |

In this example we only allow SSH from a particular client.

There are a variety of outputs available from the module:

| Variable | Comment |
| :------- | :------ |
| resource_group | Name of the resource group which holds all resources created in this module |
| vnet_id | ID of the VPC that is built |
| subnet_cidr      | CIDR blocks for the subnets in the VNET |
| subnet_id   | ID for the subnets in the VNET |
| public_ip | Public IP address associated with the VM |
| network_security_group          | ID of the network security group attached to the NIC of the VM |
| vm_id    | ID of the generated vm |

Once set up, you will need to add the "Virtual Machine Administrator Login" to the AAD users you want to be able to login to this VM. See https://docs.microsoft.com/en-us/azure/virtual-machines/linux/login-using-aad for more details.

```
ssh -l soren.jensen@leapbeyond.ai 10.11.123.456
```
You are prompted to sign in to Azure AD with a one-time use code at https://microsoft.com/devicelogin. Copy and paste the one-time use code into the device login page.

where `soren.jensen@leapbeyond` is the AAD user profile to use. Note that while the IP address of the host will not change (as it has a static public IP attached to it), there is no guarantee for users that the host has not been destroyed and recreated, changing it's SSH signature in the process. To avoid the potential problems resulting from the host being "remembered" in `~/.ssh/known_hosts` they can easily replace the key, e.g.

```
$ ssh-keygen -R 35.177.199.127
$ ssh-keyscan 35.177.199.127 >> ~/.ssh/known_hosts
$ mssh -i connect_test i-067b509287e1f5cf4
```
and the users should be encouraged to script this up for transparent simplicity.

## License
Copyright 2020 Leap Beyond Emerging Technologies B.V.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.