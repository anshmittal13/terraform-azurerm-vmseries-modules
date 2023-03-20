location             = "Australia Southeast"
tags                 = { environment = "dev" }
panorama_name        = "PN-southeast"
resource_group_name  = "panorama-RG-southeast"
vnet_name            = "vnet-southeast"
storage_account_name = "examplestorage22"
storage_share_name   = "bootdiagshare22"
enable_zones         = false
address_space        = ["10.113.0.0/16"]
panorama_version     = "10.1.8"

network_security_groups = {
  "network_security_group_1" = {
    location = "Australia Southeast"
    rules = {
      "AllOutbound" = {
        priority                   = 100
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      "AllowSSH" = {
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    }
  }
}

subnets = {
  "management" = {
    address_prefixes       = ["10.113.255.0/24"]
    network_security_group = "network_security_group_1"
  }
}

allow_inbound_mgmt_ips = [
  "13.235.26.197" # Put your own public IP address here, visit "https://ifconfig.me/"
]

