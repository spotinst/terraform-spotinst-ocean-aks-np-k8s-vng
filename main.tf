resource "spotinst_ocean_aks_np_virtual_node_group" "aks-np-vng" {
  name            = var.ocean_vng_name
  ocean_id        = var.ocean_id

  auto_headroom_percentage = var.autoscale_auto_headroom_percentage

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
  dynamic "linux_os_config" {
    for_each = var.linux_os_config != null ? [var.linux_os_config] : []
    content {
      sysctls {
        vm_max_map_count = linux_os_config.value.vm_max_map_count
      }
    }
  }

  dynamic "local_dns_profile" {
    for_each = var.local_dns_profile != null ? [var.local_dns_profile] : []
    content {
      mode = local_dns_profile.value.mode

      dynamic "vnet_dns_overrides" {
        for_each = local_dns_profile.value.vnet_dns_overrides != null ? local_dns_profile.value.vnet_dns_overrides : {}
        content {
          zone                             = vnet_dns_overrides.key
          query_logging                    = vnet_dns_overrides.value.query_logging
          protocol                         = vnet_dns_overrides.value.protocol
          forward_destination              = vnet_dns_overrides.value.forward_destination
          forward_policy                   = vnet_dns_overrides.value.forward_policy
          max_concurrent                   = vnet_dns_overrides.value.max_concurrent
          cache_duration_in_seconds        = vnet_dns_overrides.value.cache_duration_in_seconds
          serve_stale_duration_in_seconds  = vnet_dns_overrides.value.serve_stale_duration_in_seconds
          serve_stale                      = vnet_dns_overrides.value.serve_stale
        }
      }

      dynamic "kube_dns_overrides" {
        for_each = local_dns_profile.value.kube_dns_overrides != null ? local_dns_profile.value.kube_dns_overrides : {}
        content {
          zone                             = kube_dns_overrides.key
          query_logging                    = kube_dns_overrides.value.query_logging
          protocol                         = kube_dns_overrides.value.protocol
          forward_destination              = kube_dns_overrides.value.forward_destination
          forward_policy                   = kube_dns_overrides.value.forward_policy
          max_concurrent                   = kube_dns_overrides.value.max_concurrent
          cache_duration_in_seconds        = kube_dns_overrides.value.cache_duration_in_seconds
          serve_stale_duration_in_seconds  = kube_dns_overrides.value.serve_stale_duration_in_seconds
          serve_stale                      = kube_dns_overrides.value.serve_stale
        }
      }
    }
  }


  //vng nodeCountLimits
  min_count = var.node_min_count
  max_count = var.node_max_count

  //vng strategy
  spot_percentage      = var.spot_percentage
  fallback_to_ondemand = var.fallback_to_ondemand
  draining_timeout     = var.draining_timeout
  should_utilize_commitments = var.should_utilize_commitments
  restrict_scale_down = var.restrict_scale_down

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
    min_disk                = var.vmsizes_filters_min_disk
    gpu_types               = var.vmsizes_filters_gpu_types
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
  update_policy {
    should_roll                     = var.should_roll
    conditioned_roll                = var.conditioned_roll
    roll_config {
      respect_pdb                   = var.respect_pdb
      batch_size_percentage         = var.batch_size_percentage
      vng_ids                       = var.vng_ids
      batch_min_healthy_percentage  = var.batch_min_healthy_percentage
      comment                       = var.comment
      node_pool_names               = var.node_pool_names
      respect_restrict_scale_down   = var.respect_restrict_scale_down
      node_names                    = var.node_names
    }
  }

  # Scheduling ##
  scheduling {
    dynamic "shutdown_hours" {
      for_each = var.shutdown_hours != null ? [var.shutdown_hours] : []
      content {
        is_enabled   = shutdown_hours.value.is_enabled
        time_windows = shutdown_hours.value.time_windows
      }
    }
  }
}