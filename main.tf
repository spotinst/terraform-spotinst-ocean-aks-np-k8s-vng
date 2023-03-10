provider "spotinst" {
  # Credentials should be fetched from ENV VARS injected by Jenkins
  token   = var.spotinst_token
  account = var.spotinst_account
}
resource "spotinst_ocean_aks_np_virtual_node_group" "aks-np-vng" {
  name            = var.ocean_vng_name
  ocean_id        = var.ocean_id

  headrooms {
    cpu_per_unit    = var.headrooms_cpu_per_unit
    memory_per_unit = var.headrooms_memory_per_unit
    gpu_per_unit    = var.headrooms_gpu_per_unit
    num_of_units    = var.headrooms_num_of_units
  }

  availability_zones=var.availability_zones

  //cluster nodePoolProperties
  max_pods_per_node     =var.max_pods_per_node
  enable_node_public_ip = var.enable_node_public_ip
  os_disk_size_gb       = var.os_disk_size_gb
  os_disk_type          = var.os_disk_type
  os_type               = var.os_type


  //Cluster nodeCountLimits
  min_count = var.node_min_count
  max_count = var.node_max_count

  //cluster strategy
  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand

  tags   = var.tags
  labels = var.labels

  dynamic "taints" {
    for_each = var.taints == null ? [] : var.taints
    content {
      key    = taints.value["key"]
      value  = taints.value["value"]
      effect = taints.value["effect"]
    }
  }
}