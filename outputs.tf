# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

output resource_group {
  description = "Resource group name"
  value = azurerm_resource_group.myterraformgroup.name
}

output vnet_id {
  description = "VPC ID"
  value       = azurerm_virtual_network.myterraformnetwork.id
}

output subnet_cidr {
  description = "CIDR blocks for the subnets"
  value       = azurerm_subnet.myterraformsubnet[*].address_prefix
}

output subnet_id {
  description = "ID for the subnets"
  value       = azurerm_subnet.myterraformsubnet[*].id
}

output public_ip {
  description = "Public ip address"
  value       = azurerm_public_ip.myterraformpublicip.ip_address
}

output network_security_group {
  description = "ID of the network security group"
  value       =  azurerm_network_security_group.myterraformnsg.id
}

output vm_id {
  description = "ID of the generated vm"
  value       = azurerm_linux_virtual_machine.myterraformvm.id
}

