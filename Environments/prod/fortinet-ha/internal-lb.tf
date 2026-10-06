resource "azurerm_lb" "internal_lb" {
  name                = var.internal_lb
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "internalFrontend"
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.internal_lb_frontend_ip
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

resource "azurerm_lb_backend_address_pool" "internal_lb_backend" {
  name            = "int-lb-backendpool"
  loadbalancer_id = azurerm_lb.internal_lb.id
}

resource "azurerm_lb_probe" "int_lb_probe" {
  name            = "int-lb-probe"
  loadbalancer_id = azurerm_lb.internal_lb.id

  protocol = "Tcp"
  port     = 8008
}

resource "azurerm_lb_rule" "int_lb_rule" {
  name            = "int-lb-rule"
  loadbalancer_id = azurerm_lb.internal_lb.id

  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "internalFrontend"

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.internal_lb_backend.id
  ]

  probe_id = azurerm_lb_probe.int_lb_probe.id

  floating_ip_enabled    = true
  idle_timeout_in_minutes = 5
  load_distribution      = "Default"
}

resource "azurerm_network_interface_backend_address_pool_association" "activeport2_intlb" {
  network_interface_id    = azurerm_network_interface.activeport2.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_lb_backend.id
}

resource "azurerm_network_interface_backend_address_pool_association" "passiveport2_intlb" {
  network_interface_id    = azurerm_network_interface.passiveport2.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_lb_backend.id
}