module "ocean-aks-np-vng" {
  source           = "../.."
  # Credentials.
  spotinst_token            = var.spotinst_token
  spotinst_account          = var.spotinst_account
  ocean_vng_name            = "Terraform_AKS_NP_VNG_Test"
  ocean_id                  = "o-12345"
  headrooms_cpu_per_unit    = 6
  headrooms_memory_per_unit = 10
  headrooms_gpu_per_unit    = 4
  headrooms_num_of_units    = 10
  availability_zones        = ["1", "3"]
  max_pods_per_node         = 110
  enable_node_public_ip     = false
  os_disk_size_gb           = 128
  os_disk_type              = "Managed"
  os_type                   = "Linux"
  node_min_count            = 0
  node_max_count            = 1000
  spot_percentage           = 100
  fallback_to_ondemand      = true
  tags                      = { "key1": "value1", "key2": "value2" }
  labels                    = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
  taints                    = [{"key":"noa","value":"veryMuch", "effect" : "NoSchedule"}]
}