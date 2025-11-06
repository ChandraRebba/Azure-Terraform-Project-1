# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Test"
  }
}

# Create a subnet for the Windows VM
resource "azurerm_subnet" "windows_subnet" {
  name                 = "windows-subnet"
  resource_group_name  = azurerm_resource_group.proj1RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a subnet for the Linux VM
resource "azurerm_subnet" "linux_subnet" {
  name                 = "linux-subnet"
  resource_group_name  = azurerm_resource_group.proj1RG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a network security group for the Windows VM to allow RDP
resource "azurerm_network_security_group" "windows_nsg" {
  name                = "${var.prefix}-windows-nsg"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

# Create a network security group for the Linux VM to allow SSH
resource "azurerm_network_security_group" "linux_nsg" {
  name                = "${var.prefix}-linux-nsg"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}