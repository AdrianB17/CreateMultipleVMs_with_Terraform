resource "random_integer" "random1" {
  min = 100
  max = 999
}

resource "random_string" "random2" {
  length  = 2
  upper   = false
  numeric  = true
  special = false  
}

resource "azurerm_network_interface" "example" {
  count               = length(var.subnet_names_create)
  name                = "${var.vm_names_create[count.index]}${random_integer.random1.result}_dev" #Usar una nomenclatura
  location            = data.azurerm_resource_group.existing_resource_group.location
  resource_group_name = data.azurerm_resource_group.existing_resource_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = values(data.azurerm_subnet.subnets)[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
  enable_accelerated_networking = false
}

resource "azurerm_virtual_machine" "vms" {
  count               = length(var.existing_images)
  name                = var.vm_names_create[count.index]
  location            = data.azurerm_resource_group.existing_resource_group.location
  resource_group_name = data.azurerm_resource_group.existing_resource_group.name

  network_interface_ids = [azurerm_network_interface.example[count.index].id]
  
  vm_size              = "Standard_B4ms"  # Ingresar un tamaño

  zones = ["1"] #Ingresar una zona

  storage_image_reference {
    id = data.azurerm_image.existing_images[count.index].id
  }

  storage_os_disk {
    name              = "${var.vm_names_create[count.index]}_dev_${random_string.random2.result}"  #Usar una nomenclatura
    caching           = "ReadWrite"
    create_option     = "FromImage"  #Attach or FromImage
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_names_create[count.index]
    admin_username = "admin"  #Ingresar el username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
  
  tags = var.tags

}