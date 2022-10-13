resource "azurerm_resource_group" "demo-uat" {
  name     = var.rg_name
  location = var.location
}