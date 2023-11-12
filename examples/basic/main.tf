provider "spotinst" {
  //  version = "~> 0.11"

  # Credentials should be fetched from ENV VARS injected by Jenkins
  token = "123456789123456789"
  account = "act-12345"
}
terraform {
  required_version = ">= 0.13.1"
  required_providers {
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">=1.105.0"
    }
  }
}

module "ocean-aks-np-vng" {
  source           = "../.."

  count = 1
  ocean_vng_name                            = "Terraform_AKS_NP_VNG_Test"
  ocean_id                                  = "o-12345"
  autoscale_headrooms_cpu_per_unit          = 6
  autoscale_headrooms_memory_per_unit       = 10
  autoscale_headrooms_gpu_per_unit          = 4
  autoscale_headrooms_num_of_units          = 10
  availability_zones                        = ["1", "3"]
  max_pods_per_node                         = 110
  enable_node_public_ip                     = false
  os_disk_size_gb                           = 128
  os_disk_type                              = "Managed"
  os_type                                   = "Linux"
  os_sku                                    = "Ubuntu"
  kubernetes_version                        = "1.26"
  pod_subnet_ids                            = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
  vnet_subnet_ids                           = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
  node_min_count                            = 0
  node_max_count                            = 1000
  spot_percentage                           = 100
  fallback_to_ondemand                      = true
  tags                                      = { "key1": "value1", "key2": "value2" }
  labels                                    = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
  taints                                    = [{"key":"key1","value":"value1", "effect" : "NoSchedule"}]
  vmsizes_filters_min_vcpu                 = 2
  vmsizes_filters_max_vcpu                 = 16
  vmsizes_filters_min_memory_gib           = 8
  vmsizes_filters_max_memory_gib           = 16
  vmsizes_filters_series                   = ["D v3", "Dds_v4", "Dsv2", "A", "A v2"]
  vmsizes_filters_exclude_series           = ["E v3","Esv3", "Eas_v5"]
  vmsizes_filters_architectures            = ["X86_64"]
  vmsizes_filters_accelerated_networking   = "Disabled"
  vmsizes_filters_disk_performance         = "Standard"
  #vmsizes_filters_min_gpu                  = 0
  #vmsizes_filters_max_gpu                  = 2
  vmsizes_filters_min_nics                 = 1
  vmsizes_filters_vm_types                 = ["generalPurpose"]
  vmsizes_filters_min_disk                 = 1
}