# --- GENERAL --- #
location            = "North Europe"
resource_group_name = "Palo-RG-PN-FW"
name_prefix         = "PA-VM-"
create_resource_group = false
tags = {
  "CreatedBy"   = "Palo Alto Networks"
  "CreatedWith" = "Terraform"
}
enable_zones = false


# --- VNET PART --- #
vnets = {
  "transit" = {
    name          = "Palo-panorama-vnet"
    create_virtual_network = false
    create_subnets = false
    address_space = ["10.1.0.0/16"]
    network_security_groups = {
      "management" = {
        name = "mgmt-nsg"
        rules = {
          vmseries_mgmt_allow_inbound = {
            priority                   = 100
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "Tcp"
            source_address_prefixes    = ["0.0.0.0/0"] # TODO: whitelist public IP addresses that will be used to manage the appliances
            source_port_range          = "*"
            destination_address_prefix = "10.0.0.0/28"
            destination_port_ranges    = ["22", "443"]
          }
        }
      }
    }
    subnets = {
      "mgmt" = {
        name                   = "mgmt-snet"
        address_prefixes       = ["10.1.1.0/24"]
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


# --- VMSERIES PART --- #
vmseries_version = "10.2.3"
vmseries_vm_size = "Standard_DS3_v2"
vmseries = {
  "fw-1" = {
    name              = "firewall01"
    vnet_key          = "transit"
    bootsrap_options = "panorama-server=10.1.1.10"
      
      
    interfaces = [
      {
        name       = "mgmt"
        subnet_key = "mgmt"
        create_pip = true
      },
      {
        name       = "untrust"
        subnet_key = "untrust"
        private_ip_address = "10.1.2.11"
        create_pip = true
      },
      {
        name       = "trust"
        subnet_key = "trust"
        private_ip_address = "10.1.3.11"
      },
    ]
  }
}
