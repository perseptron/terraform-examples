output "resource_group_name" {
  value = azurerm_resource_group.ssrv.name
}

output "azure_vm_name" {
  value = azurerm_linux_virtual_machine.ssrv.name
}

output "azure_vm_location" {
  value = azurerm_resource_group.ssrv.location
}

output "vm_size" {
  value = azurerm_linux_virtual_machine.ssrv.size
}

output "azure_os_disk_name" {
  value = azurerm_linux_virtual_machine.ssrv.os_disk[0].name
}

output "public_ip_address" {
  #value = data.azurerm_public_ip.ssrv.ip_address # need terraform refresh otherwise empty
  value = azurerm_linux_virtual_machine.ssrv.public_ip_address

}

output "tls_private_key" {
  sensitive = true
  value     = tls_private_key.rsa-4096.private_key_pem
}