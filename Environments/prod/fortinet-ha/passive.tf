resource "azurerm_virtual_machine" "passivefgtvm" {
  name                = var.firewallname2
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.size
  zones               = [var.zone2]

  network_interface_ids = [
    azurerm_network_interface.passiveport1.id,
    azurerm_network_interface.passiveport2.id,
    azurerm_network_interface.passiveport3.id,
    azurerm_network_interface.passiveport4.id
  ]

  primary_network_interface_id = azurerm_network_interface.passiveport1.id

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
    name              = "${var.firewallname2}-osdisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  storage_data_disk {
    name              = "${var.firewallname2}-datadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = 30
  }

  os_profile {
    computer_name  = var.firewallname2
    admin_username = var.adminusername
    admin_password = var.adminpassword

    custom_data = templatefile(
      "${path.module}/config-passive.conf",
      {
        type          = var.license_type
        license_file  = var.license2
        format        = var.license_format
        firewallname2 = var.firewallname2

        # port1: External / Untrust
        port1_ip   = var.passiveport1
        port1_mask = var.passiveport1mask

        # port2: Internal / Trust
        port2_ip   = var.passiveport2
        port2_mask = var.passiveport2mask

        # port3: Management
        port3_ip   = var.passiveport3
        port3_mask = var.passiveport3mask

        # port4: HA Sync
        port4_ip   = var.passiveport4
        port4_mask = var.passiveport4mask

        # HA peer is the Active FortiGate port4
        active_peerip = var.activeport4

        # Management gateway belongs to port3 subnet
        mgmt_gateway_ip = var.port3gateway

        # Default gateway belongs to port1 external subnet
        defaultgwy = var.port1gateway

        # Azure health probe return paths
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