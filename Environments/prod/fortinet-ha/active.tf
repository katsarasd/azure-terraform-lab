resource "azurerm_virtual_machine" "activefgtvm" {
  name                = var.firewallname1
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.size
  zones               = [var.zone1]

  network_interface_ids = [
    azurerm_network_interface.activeport1.id,
    azurerm_network_interface.activeport2.id,
    azurerm_network_interface.activeport3.id,
    azurerm_network_interface.activeport4.id
  ]

  primary_network_interface_id = azurerm_network_interface.activeport1.id

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.fgtoffer
    sku       = var.fgtsku[var.arch][var.license_type]
    version   = var.fgtversion
  }

  plan {
    name      = var.fgtsku[var.arch][var.license_type]
    publisher = var.publisher
    product   = var.fgtoffer
  }

  storage_os_disk {
    name              = "${var.firewallname1}-osdisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  storage_data_disk {
    name              = "${var.firewallname1}-datadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = 30
  }

  os_profile {
    computer_name  = var.firewallname1
    admin_username = var.adminusername
    admin_password = var.adminpassword

    custom_data = templatefile(
      "${path.module}/config-active.conf",
      {
        type          = var.license_type
        license_file  = var.license
        format        = var.license_format
        firewallname1 = var.firewallname1

        # port1: External / Untrust
        port1_ip   = var.activeport1
        port1_mask = var.activeport1mask

        # port2: Internal / Trust
        port2_ip   = var.activeport2
        port2_mask = var.activeport2mask

        # port3: Management
        port3_ip   = var.activeport3
        port3_mask = var.activeport3mask

        # port4: HA Sync
        port4_ip   = var.activeport4
        port4_mask = var.activeport4mask

        # HA peer is the Passive FortiGate port4
        passive_peerip = var.passiveport4

        # Management gateway belongs to the port3 subnet
        mgmt_gateway_ip = var.port3gateway

        # Default route goes through port1 external subnet
        defaultgwy = var.port1gateway

        # Gateways used for Azure Load Balancer probe return routes
        port1gateway = var.port1gateway
        port2gateway = var.port2gateway

        adminsport = var.adminsport
      }
    )
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
  }

  tags = merge(
    var.common_tags,
    {
      "additional_tag_key" = "additional_tag_value"
    }
  )
}