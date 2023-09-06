variable "ocean_vng_name" {
  type        = string
  description = "Enter a name for the virtual node group."
}
variable "ocean_id" {
  type        = string
  description = "Ocean cluster identifier."
}
## autoscale_headrooms ##
variable "autoscale_headrooms_num_of_units" {
  type        = number
  default     = null
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU and memory."
}
variable "autoscale_headrooms_cpu_per_unit" {
  type        = number
  default     = null
  description = "Configure the number of CPUs to allocate the headroom. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "autoscale_headrooms_gpu_per_unit" {
  type        = number
  default     = null
  description = "Amount of GPU to allocate for headroom unit."
}
variable "autoscale_headrooms_memory_per_unit" {
  type        = number
  default     = null
  description = "Configure the amount of memory (MiB) to allocate the headroom."
}
variable "max_pods_per_node" {
  type        = number
  default     = null
  description = "The maximum number of pods per node in an AKS cluster."
}
variable "enable_node_public_ip" {
  type        = bool
  default     = null
  description = "Enable node public IP."
}
variable "os_disk_size_gb" {
  type        = number
  default     = null
  description = "The size of the OS disk in GB."
}
variable "os_disk_type" {
  type        = string
  default     = null
  description = "The type of the OS disk."
}
variable "os_type" {
  type        = string
  default     = null
  description = "The os type of the os disk."
}
variable "node_min_count" {
  type        = number
  default     = null
  description = "Minimum node count limit."
}
variable "node_max_count" {
  type        = number
  default     = null
  description = "Maximum node count limit."
}
variable "spot_percentage" {
  type        = number
  default     = 100
  description = "Percentage of spot VMs to maintain."
}
variable "fallback_to_ondemand" {
  type        = bool
  default     = true
  description = "If no spot instance markets are available, enable Ocean to launch on-demand instances instead."
}
variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default     = null
  description = "Add taints to a virtual node group"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "A maximum of 10 unique key-value pairs for VM tags in the virtual node group."
}
variable "labels" {
  type        = map(string)
  default     = null
  description = "An array of labels to add to the virtual node group. Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels."
}
variable "availability_zones" {
  type        = list(string)
  default     = null
  description = "An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG."
}
variable "vmsizes_filters_min_vcpu" {
  type        = number
  default     = null
  description = "Minimum number of vcpus available."
}
variable "vmsizes_filters_max_vcpu" {
  type        = number
  default     = null
  description = "Maximum number of vcpus available."
}
variable "vmsizes_filters_min_memory_gib" {
  type        = number
  default     = null
  description = "Minimum amount of Memory (GiB)."
}
variable "vmsizes_filters_max_memory_gib" {
  type        = number
  default     = null
  description = "Maximum amount of Memory (GiB)."
}
variable "vmsizes_filters_architectures" {
  type        = list(string)
  default     = null
  description = "The filtered vm sizes will support at least one of the architectures from this list. x86_64 includes both intel64 and amd64."
}
variable "vmsizes_filters_series" {
  type        = list(string)
  default     = null
  description = "Vm sizes belonging to a series from the list will be available for scaling."
}