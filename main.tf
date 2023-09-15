# Create a virtual network within the resource group
resource "azurerm_virtual_network" "ssrv" {
  name                = "${var.azurerm_virtual_network_name}-net"
  resource_group_name = azurerm_resource_group.ssrv.name
  location            = azurerm_resource_group.ssrv.location
  address_space       = var.vnet_range
}
# Create subnet inside virtual network
resource "azurerm_subnet" "ssrv" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = azurerm_resource_group.ssrv.name
  virtual_network_name = azurerm_virtual_network.ssrv.name
  address_prefixes     = var.subnet_range
}
# Init public ip 
resource "azurerm_public_ip" "ssrv" {
  name                = "${var.azurerm_public_ip}-ip"
  location            = azurerm_resource_group.ssrv.location
  resource_group_name = azurerm_resource_group.ssrv.name
  allocation_method   = "Dynamic" # Static takes toooo long for me....
}
# Init NIC for our VM, set IP-addresses
resource "azurerm_network_interface" "ssrv" {
  name                = "${var.resource_group_name}-nic"
  location            = azurerm_resource_group.ssrv.location
  resource_group_name = azurerm_resource_group.ssrv.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ssrv.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ssrv.id
  }
}
# Create VM
resource "azurerm_linux_virtual_machine" "ssrv" {
  name                  = "${var.resource_group_name}-vm"
  computer_name         = var.computer_name
  resource_group_name   = azurerm_resource_group.ssrv.name
  location              = azurerm_resource_group.ssrv.location
  size                  = var.azurerm_vm_size
  admin_username        = var.user_name
  network_interface_ids = [azurerm_network_interface.ssrv.id]

  os_disk {
    name                 = "system-disk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  admin_ssh_key {
    username   = var.user_name # must match admin_username
    public_key = tls_private_key.rsa-4096.public_key_openssh
  }
}
# Set firewall rules 
resource "azurerm_network_security_group" "ssrv" {
  name                = "firewall-nsg"
  location            = azurerm_resource_group.ssrv.location
  resource_group_name = azurerm_resource_group.ssrv.name

  dynamic "security_rule" {
    for_each = var.open_ports
    content {
      name                       = "port_${security_rule.value}"
      priority                   = (security_rule.key + 1) * 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }

  }
}

# Running script on VM boot
resource "azurerm_virtual_machine_extension" "ssrv" {
  name                 = "hostname" # fail with other names... why???
  virtual_machine_id   = azurerm_linux_virtual_machine.ssrv.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = <<EOF
    {
        "script": "${base64encode(file(var.scfile))}"
    }
    EOF
}
