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
  max_pods_per_node         = 200
  enable_node_public_ip     = true
  os_disk_size_gb           = 150
  os_disk_type              = "Managed"
  os_type                   = "Windows"
  node_min_count            = 10
  node_max_count            = 150
  spot_percentage           = 50
  fallback_to_ondemand      = false
  tags                      = { "key1": "value1", "key2": "value2" }
  labels                    = { "labelkey1": "labelvalue1","labelkey2": "labelvalue2"}
  taints                    = [{"key":"noa","value":"veryMuch", "effect" : "NoSchedule"}]
}