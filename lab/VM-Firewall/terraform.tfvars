# --- GENERAL --- #
location            = "North Europe"
resource_group_name = "Palo-RG-PN-FW"
name_prefix         = "PA-VM-"
create_resource_group = false
tags = {
  "NOSTOP_REASON"   = "Lab-Work"
  "RunStatus" = "NoStop"
}
enable_zones = false


# --- VNET PART --- #
vnets = {
  "transit" = {
    name          = "Palo-panorama-vnet"
    create_virtual_network = false
    create_subnets = false
    address_space = ["10.1.0.0/16"]
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

vmseries_password = "admin123!"

# --- VMSERIES PART --- #
vmseries_version = "10.2.3"
vmseries_vm_size = "Standard_DS3_v2"
vmseries = {
  "fw-1" = {
    name              = "firewall01"
    vnet_key          = "transit"
    bootstrap_options = {
      type               = "dhcp-client"
      panorama-server    = "10.1.1.10"                       # TODO: update here                                      
      dgname             = "test-dg"                          # TODO: update here
      tplname            = "test-stack"                       # TODO: update here
      vm-auth-key           = "498831055216963"               # TODO: update here
      authcodes          = "D9709190"                         # TODO: update here
    }
      
      
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
