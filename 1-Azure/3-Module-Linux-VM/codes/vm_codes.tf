# Create virtual machine using modules
module "linux-vm" {
  source = "../modules/linux-vm/"

  # general
  name                  = "mylinuxvm"
  location              = "East Asia"
  resource_group_name   = data.azurerm_resource_group.my-rg.name
  network_interface_ids = [azurerm_network_interface.my-nic.id]
  size                  = "Standard_DS1_v2"

  # os disk
  disk_name            = "myosdisk01"
  caching              = "ReadWrite"
  storage_account_type = "Premium_LRS"

  # source image
  publisher   = "Canonical"
  offer       = "UbuntuServer"
  sku         = "18.04-LTS"
  version_img = "latest"

  # computer info
  computer_name                   = "mylinuxvm"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  admin_password                  = "P@$$w0rd1234!"
}