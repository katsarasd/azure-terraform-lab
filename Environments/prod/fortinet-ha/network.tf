# Active FortiGate Management Public IP
resource "azurerm_public_ip" "ActiveMGMTIP" {
  name                = "ActiveMGMTIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [var.zone1]

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Passive FortiGate Management Public IP
resource "azurerm_public_ip" "PassiveMGMTIP" {
  name                = "PassiveMGMTIP"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"

  zones = [var.zone2]

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}


# -------------------------------------------------------------------
# Active FortiGate NICs
# -------------------------------------------------------------------

# Active FortiGate port1: External / Untrust
resource "azurerm_network_interface" "activeport1" {
  name                  = "activeport1"
  location              = var.location
  resource_group_name   = var.resource_group_name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.activeport1
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Active FortiGate port2: Internal / Trust
resource "azurerm_network_interface" "activeport2" {
  name                  = "activeport2"
  location              = var.location
  resource_group_name   = var.resource_group_name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.activeport2
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Active FortiGate port3: Management
resource "azurerm_network_interface" "activeport3" {
  name                = "activeport3"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.ha_management_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.activeport3
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.ActiveMGMTIP.id
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Active FortiGate port4: HA Sync
resource "azurerm_network_interface" "activeport4" {
  name                = "activeport4"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.ha_sync_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.activeport4
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}


# -------------------------------------------------------------------
# Passive FortiGate NICs
# -------------------------------------------------------------------

# Passive FortiGate port1: External / Untrust
resource "azurerm_network_interface" "passiveport1" {
  name                  = "passiveport1"
  location              = var.location
  resource_group_name   = var.resource_group_name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.external_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.passiveport1
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Passive FortiGate port2: Internal / Trust
resource "azurerm_network_interface" "passiveport2" {
  name                  = "passiveport2"
  location              = var.location
  resource_group_name   = var.resource_group_name
  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.internal_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.passiveport2
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Passive FortiGate port3: Management
resource "azurerm_network_interface" "passiveport3" {
  name                = "passiveport3"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.ha_management_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.passiveport3
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.PassiveMGMTIP.id
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}

# Passive FortiGate port4: HA Sync
resource "azurerm_network_interface" "passiveport4" {
  name                = "passiveport4"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.ha_sync_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.passiveport4
    primary                       = true
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}