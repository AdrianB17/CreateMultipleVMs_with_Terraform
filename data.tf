data "azurerm_resource_group" "existing_resource_group" {
  name = "devops_lab"
}

data "azurerm_virtual_network" "existing_virtual_network" {
  name                = "tpl01-vnet"
  resource_group_name = data.azurerm_resource_group.existing_resource_group.name
}

# Locate the existing Subnet within a Virtual Network
data "azurerm_subnet" "subnets" {
  for_each             = toset(var.subnet_names)
  name                 = each.value
  virtual_network_name = "tpl01-vnet"
  resource_group_name  = "devops_lab"
}

data "azurerm_image" "existing_images" {
  count               = length(var.existing_images)
  name                = var.existing_images[count.index]
  resource_group_name = "devops_lab"  # Reemplaza con el nombre de tu grupo de recursos
}
