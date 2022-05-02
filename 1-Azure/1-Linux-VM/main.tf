data "azurerm_resource_group" "my-rg" {
  name = "RG_MyRG_20220422"
}

####################################################

# Create virtual network
resource "azurerm_virtual_network" "my-vnet" {
  name                = "myvnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East Asia"
  resource_group_name = data.azurerm_resource_group.my-rg.name
}

# Create subnet
resource "azurerm_subnet" "my-subnet" {
  name                 = "mysubnet01"
  resource_group_name  = data.azurerm_resource_group.my-rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "my-pub-ip" {
  name                = "mypubip01"
  location            = "East Asia"
  resource_group_name = data.azurerm_resource_group.my-rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my-nsg" {
  name                = "mynsg01"
  location            = "East Asia"
  resource_group_name = data.azurerm_resource_group.my-rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}



# Create network interface
resource "azurerm_network_interface" "my-nic" {
  name                = "mynic01"
  location            = "East Asia"
  resource_group_name = data.azurerm_resource_group.my-rg.name

  ip_configuration {
    name                          = "mynicconf01"
    subnet_id                     = azurerm_subnet.my-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my-pub-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.my-nic.id
  network_security_group_id = azurerm_network_security_group.my-nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my-linux-vm" {
  name                  = "mylinuxvm"
  location              = "East Asia"
  resource_group_name   = data.azurerm_resource_group.my-rg.name
  network_interface_ids = [azurerm_network_interface.my-nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myosdisk01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "mylinuxvm"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  admin_password                  = "P@$$w0rd1234!"
}

####################################################
output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my-linux-vm.public_ip_address
}