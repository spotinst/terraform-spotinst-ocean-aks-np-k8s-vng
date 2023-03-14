variable "spotinst_token" {
  type        = string
  description = "Spot Personal Access token"
}

variable "spotinst_account" {
  type        = string
  description = "Spot account ID"
}
variable "ocean_vng_name" {
  type        = string
  description = "Enter a name for the virtual node group."
}
variable "ocean_id" {
  type        = string
  description = "Ocean ID"
}
## autoscale_headrooms ##
variable "headrooms_num_of_units" {
  type        = number
  default     = 0
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU, memory and GPU."
}
variable "headrooms_cpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "headrooms_gpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of GPUS to allocate for each headroom unit."
}
variable "headrooms_memory_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the amount of memory (MiB) to allocate for each headroom unit."
}
variable "max_pods_per_node" {
  type        = number
  description = "The maximum number of pods per node in an AKS cluster."
}
variable "enable_node_public_ip" {
  type        = bool
  description = "enable node public IP."
}
variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in GB."
}
variable "os_disk_type" {
  type        = string
  description = "The type of the OS disk."
}
variable "os_type" {
  type        = string
  description = "The os type of the os disk."
}
variable "node_min_count" {
  type        = number
  description = "Minimum node count limit."
}
variable "node_max_count" {
  type        = number
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
  description = "taints / toleration"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags to be added to resources"
}
variable "labels" {
  type        = map(string)
  default     = null
  description = "An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels."
}
variable "availability_zones" {
  type        = list(string)
  default     = null
  description = "An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG."
}