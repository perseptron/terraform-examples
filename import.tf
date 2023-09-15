resource "random_id" "ssrv" {
  keepers = {
    name_id = var.resource_group_name
  }
  byte_length = 8
}

resource "azurerm_resource_group" "ssrv" {
  location = var.resource_group_location
  name     = "${var.resource_group_name_prefix}-${random_id.ssrv.hex}"
}

resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename = "private_key.pem"
}
