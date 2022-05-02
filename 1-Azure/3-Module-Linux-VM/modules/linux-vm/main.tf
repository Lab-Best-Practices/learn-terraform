# Create modules linux virtual machine
resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  size                  = var.size

  os_disk {
    name                 = var.disk_name
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version_img
  }

  computer_name                   = var.computer_name
  admin_username                  = var.admin_username
  disable_password_authentication = var.disable_password_authentication
  admin_password                  = var.admin_password
}