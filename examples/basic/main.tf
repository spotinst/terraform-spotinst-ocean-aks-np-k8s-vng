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
  ocean_vng_name                  = "Terraform_AKS_NP_VNG_Test"
  ocean_id                        = "o-12345"
  headrooms_cpu_per_unit          = 6
  headrooms_memory_per_unit       = 10
  headrooms_gpu_per_unit          = 4
  headrooms_num_of_units          = 10
  availability_zones              = ["1", "3"]
  max_pods_per_node               = 110
  enable_node_public_ip           = false
  os_disk_size_gb                 = 128
  os_disk_type                    = "Managed"
  os_type                         = "Linux"
  node_min_count                  = 0
  node_max_count                  = 1000
  spot_percentage                 = 100
  fallback_to_ondemand            = true
  tags                            = { "key1": "value1", "key2": "value2" }
  labels                          = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
  taints                          = [{"key":"noa","value":"veryMuch", "effect" : "NoSchedule"}]
  vmsizes_filters_min_vcpu        = 2
  vmsizes_filters_max_vcpu        = 16
  vmsizes_filters_min_memory_gib  = 10
  vmsizes_filters_max_memory_gib  = 18
  vmsizes_filters_series          = ["D v3"]
  vmsizes_filters_architectures   = ["X86_64"]
}