
# Spot Ocean k8s Virtual Node Group Terraform Module

Spotinst Terraform Module to integrate existing k8s node groups with Ocean launchspec/Virtual Node group (VNG).

## Usage

```hcl
provider "spotinst" {
  token   = "redacted"
  account = "redacted"
}
terraform {
  required_version = ">= 0.13.1"
  required_providers {
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">=1.115.0"
    }
  }
}

module "ocean-aks-np-vng" {
  
  source = "spotinst/ocean-aks-np-k8s-vng/spotinst"
  ocean_vng_name                            = "testVng"
  ocean_id                                  = "o-134abcd"
  autoscale_headrooms_cpu_per_unit          = 1024
  autoscale_headrooms_memory_per_unit       = 512
  autoscale_headrooms_gpu_per_unit          = 0
  autoscale_headrooms_num_of_units          = 2
  availability_zones                        = ["1", "2", "3"]
  max_pods_per_node                         = 30
  enable_node_public_ip                     = true
  os_disk_size_gb                           = 30
  os_disk_type                              = "Managed"
  os_type                                   = "Linux"
  os_sku                                    = "Ubuntu"
  node_min_count                            = 1
  node_max_count                            = 100
  spot_percentage                           = 50
  fallback_to_ondemand                      = true
  tags                                      = { "tagKey": "env", "tagValue": "staging" }
  labels                                    = { "key": "env","value": "test"}
  taints                                    = [{"key":"taintKey","value":"taintValue", "effect" : "NoSchedule"}]
  vmsizes_filters_min_vcpu                  = 2
  vmsizes_filters_max_vcpu                  = 16
  vmsizes_filters_min_memory_gib            = 10
  vmsizes_filters_max_memory_gib            = 18
  vmsizes_filters_series                    = ["D v3", "Dds_v4", "Dsv2"]
  vmsizes_filters_architectures             = ["X86_64"]

}
```

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.115.0 |

## Modules
* `ocean-aks-np-k8s` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/spotinst/ocean-aks-np-k8s/spotinst/latest)
* `ocean-controller` - Create and installs spot ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst/latest)
* `ocean-aks-np-k8s-vng` - (Optional) Add custom virtual node groups [Doc](https://registry.terraform.io/modules/spotinst/ocean-aks-np-k8s-vng/spotinst/latest)

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](.github/CONTRIBUTING.md).

<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name                                                                                                                                                | Description | Type | Default | Required |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------|------|---------|:--------:|
| <a name="input_ocean_vng_name"></a> [ocean\_vng\_name](#input\_ocean\_vng\_name)                                                                    | Enter a name for the virtual node group. | `string` | `null` | yes |
| <a name="input_ocean_id"></a> [ocean\_id](#input\_ocean\_id)                                                                                        | The Ocean cluster identifier. Required for Launch Spec creation. | `string` | `null` | yes |
| <a name="input_autoscale_headrooms_num_of_units"></a> [autoscale\_headrooms\_num\_of\_units](#input\_autoscale\_headrooms\_num\_of\_units)          | The number of units to retain as headroom, where each unit has the defined headroom CPU, memory. | `number` | `null` | no |
| <a name="input_autoscale_headrooms_cpu_per_unit"></a> [autoscale\_headrooms\_cpu\_per\_unit](#input\_autoscale\_headrooms\_cpu\_per\_unit)          | Configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU. | `number` | `null` | no |
| <a name="input_autoscale_headrooms_gpu_per_unit"></a> [autoscale\_headrooms\_gpu\_per\_unit](#input\_autoscale\_headrooms\_gpu\_per\_unit)          | Amont of GPU to allocate for headroom unit. | `number` | `null` | no |
| <a name="input_autoscale_headrooms_memory_per_unit"></a> [autoscale\_headrooms\_memory\_per\_unit](#input\_autoscale\_headrooms\_memory\_per\_unit) | Configure the amount of memory (MiB) to allocate the headroom | `number` | `null` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node)                                                         | The maximum number of pods per node in the node pools. | `number` | `null` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip)                                             | Enable node public IP. | `bool` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb)                                                               | The size of the OS disk in GB. | `number` | `null` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type)                                                                          | The type of the OS disk. | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type)                                                                                           | The os type of the os disk. | `string` | `null` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_type)                                                                                             | The OS SKU of the OS type. Must correlate with the os type. | `string` | `null` | no |
| <a name="input_node_min_count"></a> [node\_min\_count](#input\_node\_min\_count)                                                                    | Minimum node count limit. | `number` | `null` | no |
| <a name="input_node_max_count"></a> [node\_max\_count](#input\_node\_max\_count)                                                                    | Maximum node count limit. | `number` | `null` | no |
| <a name="input_spot_percentage"></a> [spot\_percentage](#input\_spot\_percentage)                                                                   | Percentage of spot VMs to maintain. | `number` | `100` | no |
| <a name="input_fallback_to_ondemand"></a> [fallback_to_ondemand](#input\_fallback_to_ondemand)                                                      | If no spot instance markets are available, enable Ocean to launch on-demand instances instead. | `bool` | `true` | no |
| <a name="input_taints"></a> [taints](#input\_taints)                                                                                                | Add taints to a virtual node group. | `list(map(string))` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                      | A maximum of 10 unique key-value pairs for VM tags in the virtual node group. | ` map(string)` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels)                                                                                                | An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels. | ` map(string)` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones)                                                          | An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG. | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_min_vcpu"></a> [vmsizes\_filters\_min\_vcpu](#input\_vmsizes\_filters\_min\_vcpu)                                    | Minimum number of vcpus available. | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_vcpu"></a> [vmsizes\_filters\_max\_vcpu](#input\_vmsizes\_filters\_max\_vcpu)                                    | Maximum number of vcpus available. | `number` | `null` | no |
| <a name="input_vmsizes_filters_min_memory_gib"></a> [vmsizes\_filters\_min\_memory\_gib](#input\_vmsizes\_filters\_min\_memory\_gib)                | Minimum amount of Memory (GiB). | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_memory_gib"></a> [vmsizes\_filters\_max\_memory\_gib](#input\_vmsizes\_filters\_max\_memory\_gib)                | Maximum amount of Memory (GiB). | `number` | `null` | no |
| <a name="input_vmsizes_filters_architectures"></a> [vmsizes\_filters\_architectures](#input\_vmsizes\_filters\_architectures)                       | The filtered vm sizes will support at least one of the architectures from this list. x86_64 includes both intel64 and amd64. | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_series"></a> [vmsizes_filters_series](#input\_vmsizes_filters_series)                                                | Vm sizes belonging to a series from the list will be available for scaling | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|

| <a name="output_vng_id"></a> [vng\_id](#output\_vng\_id) | The VirtualNodeGroup ID |
<!-- END_TF_DOCS -->

## License

Code is licensed under the [Apache License 2.0](LICENSE).
