output "windows_vm_public_ip" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.windows_pip.ip_address
}

output "windows_vm_admin_username" {
  description = "Admin username for the Windows VM"
  value       = var.windows_admin_username
}

output "windows_vm_admin_password" {
  description = "Admin password for the Windows VM"
  value       = random_password.windows_password.result
  sensitive   = true
}

output "linux_vm_public_ip" {
  description = "Public IP address of the Linux VM"
  value       = azurerm_public_ip.linux_pip.ip_address
}

output "linux_vm_private_ssh_key" {
  description = "Private SSH key to connect to the Linux VM. Save this to a file."
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
