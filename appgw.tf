locals {
  backend_address_pool_name      = "${azurerm_virtual_network.demo-uat.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.demo-uat.name}-feport"
  frontend_port                  = 80
  frontend_ip_configuration_name = "${azurerm_virtual_network.demo-uat.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.demo-uat.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.demo-uat.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.demo-uat.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.demo-uat.name}-rdrcfg"
}

resource "azurerm_application_gateway" "app-gw" {
  name                = "demo-uat-appgateway"
  resource_group_name = azurerm_resource_group.demo-uat.name
  location            = azurerm_resource_group.demo-uat.location

  sku {
    name     = var.appgw_sku.name
    tier     = var.appgw_sku.tier
    capacity = var.appgw_sku.capacity
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = local.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.demo-uat.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
