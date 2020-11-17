# --------------------------------------------------------------------------------
# Copyright 2020 Leap Beyond Emerging Technologies B.V.
# --------------------------------------------------------------------------------

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.region
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  tags                 = merge({ "Name" = var.vnet_name }, var.tags)
}

# Create subnet
resource azurerm_subnet myterraformsubnet {
  count                = local.subnet_count
  name                 = "subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, ceil(log(local.subnet_count, 2)), count.index)]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "myNetworkSecurityGroup"
  location            = var.region
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh_inbound
    destination_address_prefix = var.vnet_cidr
  }

  tags = merge({ "Name" = var.vnet_name }, var.tags)
}

