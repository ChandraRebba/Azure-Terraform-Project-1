resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "proj1RG" {
  location = var.resource_group_location
  name     = "${var.resource_group_name_prefix}-${var.prefix}-${random_string.random.result}"
}

resource "random_password" "windows_password" {
  length           = 16
  special          = true
  override_special = "!@#$%&"
}