
resource "azurerm_linux_virtual_machine_scale_set" "demo-uat" {
  name                = "demo-uat-vmss"
  resource_group_name = azurerm_resource_group.demo-uat.name
  location            = azurerm_resource_group.demo-uat.location
  sku                 = var.sku
  instances           = var.instance_count
  admin_username      = var.admin_user
  admin_password      = var.admin_password
  disable_password_authentication  = false

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  os_disk {
    storage_account_type = var.osdisk.storage_account_type
    caching              = var.osdisk.caching
  }

  network_interface {
    name    = var.nic.name
    primary = var.nic.primary

    ip_configuration {
      name      = azurerm_subnet.vm-subnet.name
      primary   = var.nic.ip_configuration.primary
      subnet_id = azurerm_subnet.vm-subnet.id
      application_gateway_backend_address_pool_ids = [for s in azurerm_application_gateway.app-gw.backend_address_pool : s.id if s.name == "demo-uat-network-beap"] 
    }
  }
}