

resource "azurerm_virtual_network" "demo-uat" {
  name                = "demo-uat-network"
  resource_group_name = azurerm_resource_group.demo-uat.name
  location            = azurerm_resource_group.demo-uat.location
  address_space       = ["10.254.0.0/16"]
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.demo-uat.name
  virtual_network_name = azurerm_virtual_network.demo-uat.name
  address_prefixes     = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.demo-uat.name
  virtual_network_name = azurerm_virtual_network.demo-uat.name
  address_prefixes     = ["10.254.2.0/24"]
}

resource "azurerm_public_ip" "demo-uat" {
  name                = "demo-uat-pip"
  resource_group_name = azurerm_resource_group.demo-uat.name
  location            = azurerm_resource_group.demo-uat.location
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "vm-subnet" {
  name                 = "vm-subnet"
  resource_group_name  = azurerm_resource_group.demo-uat.name
  virtual_network_name = azurerm_virtual_network.demo-uat.name
  address_prefixes     = ["10.254.3.0/24"]
}