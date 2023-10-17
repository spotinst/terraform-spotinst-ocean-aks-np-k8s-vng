resource "spotinst_ocean_aks_np_virtual_node_group" "aks-np-vng" {
  name            = var.ocean_vng_name
  ocean_id        = var.ocean_id

  headrooms {
    cpu_per_unit    = var.autoscale_headrooms_cpu_per_unit
    memory_per_unit = var.autoscale_headrooms_memory_per_unit
    gpu_per_unit    = var.autoscale_headrooms_gpu_per_unit
    num_of_units    = var.autoscale_headrooms_num_of_units
  }

  availability_zones=var.availability_zones

  //vng nodePoolProperties
  max_pods_per_node     = var.max_pods_per_node
  enable_node_public_ip = var.enable_node_public_ip
  os_disk_size_gb       = var.os_disk_size_gb
  os_disk_type          = var.os_disk_type
  os_type               = var.os_type
  os_sku                = var.os_sku
  kubernetes_version    = var.kubernetes_version
  pod_subnet_ids        = var.pod_subnet_ids
  vnet_subnet_ids       = var.vnet_subnet_ids


  //vng nodeCountLimits
  min_count = var.node_min_count
  max_count = var.node_max_count

  //vng strategy
  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand

  // vmSizes filter
  filters {
    min_vcpu                = var.vmsizes_filters_min_vcpu
    max_vcpu                = var.vmsizes_filters_max_vcpu
    min_memory_gib          = var.vmsizes_filters_min_memory_gib
    max_memory_gib          = var.vmsizes_filters_max_memory_gib
    architectures           = var.vmsizes_filters_architectures
    series                  = var.vmsizes_filters_series
    exclude_series          = var.vmsizes_filters_exclude_series
    accelerated_networking  = var.vmsizes_filters_accelerated_networking
    disk_performance        = var.vmsizes_filters_disk_performance
    min_gpu                 = var.vmsizes_filters_min_gpu
    max_gpu                 = var.vmsizes_filters_max_gpu
    min_nics                = var.vmsizes_filters_min_nics
    vm_types                = var.vmsizes_filters_vm_types
    min_data                = var.vmsizes_filters_min_data
  }

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