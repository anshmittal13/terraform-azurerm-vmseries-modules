module "vmseries_vmss" {
  source = "../modules/vmss"

  for_each = var.vmseries_vmss

  resource_group_name = "RG-adbri-vmss"
  location            = "East US"
  name_prefix         = "test"
  name_scale_set      = "vmss-adbri"
  img_sku             = "byol"
  img_version         = "10.1.8"
  vm_size             = "Standard_DS3_v2"
  username            = "firewall"
  password            = "firewall@123"

  subnet_mgmt    = "/subscriptions/d47f1af8-9795-4e86-bbce-da72cfd0f8ec/resourceGroups/RG-adbri-vmss/providers/Microsoft.Network/virtualNetworks/vnet-adbri-vmss/subnets/Mgmt"
  subnet_private = "/subscriptions/d47f1af8-9795-4e86-bbce-da72cfd0f8ec/resourceGroups/RG-adbri-vmss/providers/Microsoft.Network/virtualNetworks/vnet-adbri-vmss/subnets/Trust"
  subnet_public  = "/subscriptions/d47f1af8-9795-4e86-bbce-da72cfd0f8ec/resourceGroups/RG-adbri-vmss/providers/Microsoft.Network/virtualNetworks/vnet-adbri-vmss/subnets/Untrust"
