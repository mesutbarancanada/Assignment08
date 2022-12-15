resource "azurerm_virtual_network" "a8vnet" {
  name                = "a8vnetmbrn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rga8.location
  resource_group_name = azurerm_resource_group.rga8.name
}

resource "azurerm_subnet" "a8subnet" {
  name                 = "a8subnetmbrn"
  resource_group_name  = azurerm_resource_group.rga8.name
  virtual_network_name = azurerm_virtual_network.a8vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "a8netinter" {
  name                = "a8netintermbrn"
  location            = azurerm_resource_group.rga8.location
  resource_group_name = azurerm_resource_group.rga8.name

  ip_configuration {
    name                          = "a8ipconfig"
    subnet_id                     = azurerm_subnet.a8subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "a8vmac" {
  name                  = "a8vmacmbrn"
  location              = azurerm_resource_group.rga8.location
  resource_group_name   = azurerm_resource_group.rga8.name
  network_interface_ids = [azurerm_network_interface.a8netinter.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "a8storage"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "a8computer"
    admin_username = "mesut"
    admin_password = "baran12345?"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
