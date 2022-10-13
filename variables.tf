variable "admin_password" {
  type          = string
  sensitive     = true
}

variable "sku" {
  type        = string
  default     = "Standard_B1s"
  description = "VM SKU"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Instance count"
}


variable "admin_user" {
  type          = string
  default       = "adminuser"
  sensitive     = true
}
variable "rg_name" {
  type        = string
  default     = "demo-rg"
}

variable "location" {
  type        = string
  default     = "Australia East"
}

variable "image" {
  type        = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default     = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-confidential-vm-experimental"
    sku       = "20_04"
    version   = "20.04.20210309"
  }
  description = "Ubuntu Linux Image"
}

variable "osdisk" {
  type        = object({
    storage_account_type = string
    caching = string
  })
  default     = {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  description = "description"
}

variable nic {
  type        = object({
    name = string
    primary = bool
    ip_configuration = object({
      name = string
      primary = bool
      subnet_id = string
      application_gateway_backend_address_pool_ids = list(string)
    })
  })
  default     = {
    name = "dummy"
    primary = true
    ip_configuration = {
      name = "dummy"
      primary = true
      subnet_id = "dummy"
      application_gateway_backend_address_pool_ids = ["dummy"]
    }
  }
  description = "description"
}

variable appgw_sku {
  type        = object({
    name = string
    tier = string
    capacity = number
  })
  default     = {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }
  description = "description"
}



