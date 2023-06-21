# --- GENERAL --- #
location              = "North Europe"
resource_group_name   = "RG-PN-FW"
name_prefix           = "Palo-"
create_resource_group = true
tags = {
  "NOSTOP_REASON"   = "Lab-Work"
  "RunStatus" = "NoStop"
}
enable_zones = false



# --- VNET PART --- #
vnets = {
  "vnet" = {
    name          = "panorama-vnet"
    address_space = ["10.1.0.0/16"]
    network_security_groups = {
      "panorama" = {
        name = "panorama-nsg"
        rules = {
          vmseries_mgmt_allow_inbound = {
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefixes    = ["0.0.0.0"] # TODO: whitelist public IP addresses that will be used to manage the appliances
            source_port_range          = "*"
            destination_address_prefix = "10.1.0.0/16"
            destination_port_ranges    = ["22", "443"]
          }
        }
      }
    }
    subnets = {
      "mgmt" = {
        name                   = "mgmt-snet"
        address_prefixes       = ["10.1.1.0/24"]
        network_security_group = "panorama"
      }
      "untrust"= {
        name                   = "untrust-snet"
        address_prefixes       = ["10.1.2.0/24"]
      }
      "trust" = {
        name                   = "trust-snet"
        address_prefixes       = ["10.1.3.0/24"]
      }
    }
  }
}

vmseries_password = "admin123!"

panorama_version = "10.2.3"

panoramas = {
  "pn-1" = {
    name     = "panorama01"
    vnet_key = "vnet"
    interfaces = [
      {
        name               = "management"
        subnet_key         = "mgmt"
        private_ip_address = "10.1.1.10"
        create_pip         = true
      },
    ]
  }
}
