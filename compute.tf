# Generate an SSH key pair for the Linux VM
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a public IP for the Windows VM
resource "azurerm_public_ip" "windows_pip" {
  name                = "${var.prefix}-windows-pip"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create a network interface for the Windows VM
resource "azurerm_network_interface" "windows_nic" {
  name                = "${var.prefix}-windows-nic"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.windows_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip.id
  }
}

# Associate the NSG with the Windows NIC
resource "azurerm_network_interface_security_group_association" "windows_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.windows_nic.id
  network_security_group_id = azurerm_network_security_group.windows_nsg.id
}

# Create Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = "${var.prefix}-win-vm"
  resource_group_name   = azurerm_resource_group.proj1RG.name
  location              = azurerm_resource_group.proj1RG.location
  size                  = "Standard_DS1_v2"
  admin_username        = var.windows_admin_username
  admin_password        = random_password.windows_password.result
  network_interface_ids = [azurerm_network_interface.windows_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.prefix}-win-osdisk"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Create a public IP for the Linux VM
resource "azurerm_public_ip" "linux_pip" {
  name                = "${var.prefix}-linux-pip"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create a network interface for the Linux VM
resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.prefix}-linux-nic"
  location            = azurerm_resource_group.proj1RG.location
  resource_group_name = azurerm_resource_group.proj1RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip.id
  }
}

# Associate the NSG with the Linux NIC
resource "azurerm_network_interface_security_group_association" "linux_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.linux_nic.id
  network_security_group_id = azurerm_network_security_group.linux_nsg.id
}

# Create Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = "${var.prefix}-linux-vm"
  resource_group_name   = azurerm_resource_group.proj1RG.name
  location              = azurerm_resource_group.proj1RG.location
  size                  = "Standard_DS1_v2"
  admin_username        = var.username
  network_interface_ids = [azurerm_network_interface.linux_nic.id]

  admin_ssh_key {
    username   = var.username
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.prefix}-linux-osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}