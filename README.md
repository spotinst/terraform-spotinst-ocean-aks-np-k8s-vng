
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
  kubernetes_version                        = "1.26"
  pod_subnet_ids                            = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
  vnet_subnet_ids                           = ["/subscriptions/123456-1234-1234-1234-123456789/resourceGroups/ExampleResourceGroup/providers/Microsoft.Network/virtualNetworks/ExampleVirtualNetwork/subnets/default"]
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
  should_roll                               = true
  conditioned_roll                          = false
  batch_size_percentage                     = 25
  batch_min_healthy_percentage              = 100
  vng_ids                                   = ["vng-12345"]

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

| Name                                                                                                                                                 | Description                                                                                                                                                                                                                                                                                                                                                                                                             | Type | Default | Required |
|------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|---------|:--------:|
| <a name="input_ocean_vng_name"></a> [ocean\_vng\_name](#input\_ocean\_vng\_name)                                                                     | Enter a name for the virtual node group.                                                                                                                                                                                                                                                                                                                                                                                | `string` | `null` | yes |
| <a name="input_ocean_id"></a> [ocean\_id](#input\_ocean\_id)                                                                                         | The Ocean cluster identifier. Required for Launch Spec creation.                                                                                                                                                                                                                                                                                                                                                        | `string` | `null` | yes |
| <a name="input_autoscale_headrooms_num_of_units"></a> [autoscale\_headrooms\_num\_of\_units](#input\_autoscale\_headrooms\_num\_of\_units)           | The number of units to retain as headroom, where each unit has the defined headroom CPU, memory.                                                                                                                                                                                                                                                                                                                        | `number` | `null` | no |
| <a name="input_autoscale_headrooms_cpu_per_unit"></a> [autoscale\_headrooms\_cpu\_per\_unit](#input\_autoscale\_headrooms\_cpu\_per\_unit)           | Configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU.                                                                                                                                                                                                                                                                                        | `number` | `null` | no |
| <a name="input_autoscale_headrooms_gpu_per_unit"></a> [autoscale\_headrooms\_gpu\_per\_unit](#input\_autoscale\_headrooms\_gpu\_per\_unit)           | Amont of GPU to allocate for headroom unit.                                                                                                                                                                                                                                                                                                                                                                             | `number` | `null` | no |
| <a name="input_autoscale_headrooms_memory_per_unit"></a> [autoscale\_headrooms\_memory\_per\_unit](#input\_autoscale\_headrooms\_memory\_per\_unit)  | Configure the amount of memory (MiB) to allocate the headroom                                                                                                                                                                                                                                                                                                                                                           | `number` | `null` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node)                                                          | The maximum number of pods per node in the node pools.                                                                                                                                                                                                                                                                                                                                                                  | `number` | `null` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip)                                              | Enable node public IP.                                                                                                                                                                                                                                                                                                                                                                                                  | `bool` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb)                                                                | The size of the OS disk in GB.                                                                                                                                                                                                                                                                                                                                                                                          | `number` | `null` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type)                                                                           | The type of the OS disk.                                                                                                                                                                                                                                                                                                                                                                                                | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type)                                                                                            | The os type of the os disk.                                                                                                                                                                                                                                                                                                                                                                                             | `string` | `null` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_type)                                                                                              | The OS SKU of the OS type. Must correlate with the os type.                                                                                                                                                                                                                                                                                                                                                             | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_os\_type)                                                                      | The desired Kubernetes version of the launched nodes. In case the value is null, the Kubernetes version of the control plane is used.                                                                                                                                                                                                                                                                                   | `string`            | `null` |    no    |
| <a name="input_pod_subnet_ids"></a> [pod\_subnet\_ids](#input\_os\_type)                                                                             | The IDs of subnets in an existing VNet into which to assign pods in the cluster (requires azure network-plugin).                                                                                                                                                                                                                                                                                                        | `list(string)`      | `null` |    no    |
| <a name="input_vnet_subnet_ids"></a> [vnet\_subnet\_ids](#input\_os\_type)                                                                           | The IDs of subnets in an existing VNet into which to assign nodes in the cluster (requires azure network-plugin).                                                                                                                                                                                                                                                                                                       | `list(string)`      | `null` |    no    |
| <a name="input_node_min_count"></a> [node\_min\_count](#input\_node\_min\_count)                                                                     | Minimum node count limit.                                                                                                                                                                                                                                                                                                                                                                                               | `number` | `null` | no |
| <a name="input_node_max_count"></a> [node\_max\_count](#input\_node\_max\_count)                                                                     | Maximum node count limit.                                                                                                                                                                                                                                                                                                                                                                                               | `number` | `null` | no |
| <a name="input_spot_percentage"></a> [spot\_percentage](#input\_spot\_percentage)                                                                    | Percentage of spot VMs to maintain.                                                                                                                                                                                                                                                                                                                                                                                     | `number` | `100` | no |
| <a name="input_fallback_to_ondemand"></a> [fallback_to_ondemand](#input\_fallback_to_ondemand)                                                       | If no spot instance markets are available, enable Ocean to launch on-demand instances instead.                                                                                                                                                                                                                                                                                                                          | `bool` | `true` | no |
| <a name="input_taints"></a> [taints](#input\_taints)                                                                                                 | Add taints to a virtual node group.                                                                                                                                                                                                                                                                                                                                                                                     | `list(map(string))` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                       | A maximum of 10 unique key-value pairs for VM tags in the virtual node group.                                                                                                                                                                                                                                                                                                                                           | ` map(string)` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels)                                                                                                 | An array of labels to add to the virtual node group.Only custom user labels are allowed, and not Kubernetes built-in labels or Spot internal labels.                                                                                                                                                                                                                                                                    | ` map(string)` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones)                                                           | An Array holding Availability Zones, this configures the availability zones the Ocean may launch instances in per VNG.                                                                                                                                                                                                                                                                                                  | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_min_vcpu"></a> [vmsizes\_filters\_min\_vcpu](#input\_vmsizes\_filters\_min\_vcpu)                                     | Minimum number of vcpus available.                                                                                                                                                                                                                                                                                                                                                                                      | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_vcpu"></a> [vmsizes\_filters\_max\_vcpu](#input\_vmsizes\_filters\_max\_vcpu)                                     | Maximum number of vcpus available.                                                                                                                                                                                                                                                                                                                                                                                      | `number` | `null` | no |
| <a name="input_vmsizes_filters_min_memory_gib"></a> [vmsizes\_filters\_min\_memory\_gib](#input\_vmsizes\_filters\_min\_memory\_gib)                 | Minimum amount of Memory (GiB).                                                                                                                                                                                                                                                                                                                                                                                         | `number` | `null` | no |
| <a name="input_vmsizes_filters_max_memory_gib"></a> [vmsizes\_filters\_max\_memory\_gib](#input\_vmsizes\_filters\_max\_memory\_gib)                 | Maximum amount of Memory (GiB).                                                                                                                                                                                                                                                                                                                                                                                         | `number` | `null` | no |
| <a name="input_vmsizes_filters_architectures"></a> [vmsizes\_filters\_architectures](#input\_vmsizes\_filters\_architectures)                        | The filtered vm sizes will support at least one of the architectures from this list. x86_64 includes both intel64 and amd64.                                                                                                                                                                                                                                                                                            | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_series"></a> [vmsizes_filters_series](#input\_vmsizes_filters_series)                                                 | Vm sizes belonging to a series from the list will be available for scaling                                                                                                                                                                                                                                                                                                                                              | `list(string)` | `null` | no |
| <a name="input_vmsizes_filters_exclude_series"></a> [vmsizes_filters_exclude_series](#input\_vmsizes_filters_exclude_series)                         | Vm sizes belonging to a series from the list will not be available for scaling.                                                                                                                                                                                                                                                                                                                                         | `list(string)`      | `null` |    no     |
| <a name="input_vmsizes_filters_accelerated_networking"></a> [vmsizes_filters_accelereated_networking](#input\_vmsizes_filters_accelerated_netwoking) | In case acceleratedNetworking is set to Enabled, accelerated networking applies only to the VM that enables it.                                                                                                                                                                                                                                                                                                         | `string`            | `null` |    no     |
| <a name="input_vmsizes_filters_disk_performance"></a> [vmsizes_filters_disk_performance](#input\_vmsizes_filters_disk_performance)                   | The filtered vm sizes will support at least one of the classes from this list.                                                                                                                                                                                                                                                                                                                                          | `string`            | `null` |    no     |
| <a name="input_vmsizes_filters_min_gpu"></a> [vmsizes_filters_min_gpu](#input\_vmsizes_filters_min_gpu)                                              | Minimum number of GPUs available.                                                                                                                                                                                                                                                                                                                                                                                       | `number`            | `null` |    no     |
| <a name="input_vmsizes_filters_max_gpu"></a> [vmsizes_filters_max_gpu](#input\_vmsizes_filters_max_gpu)                                              | Maximum number of GPUs available.                                                                                                                                                                                                                                                                                                                                                                                       | `number`            | `null` |    no     |
| <a name="input_vmsizes_filters_min_nics"></a> [vmsizes_filters_min_nics](#input\_vmsizes_filters_min_nics)                                           | Minimum number of network interfaces.                                                                                                                                                                                                                                                                                                                                                                                   | `number`            | `null` |    no     |
| <a name="input_vmsizes_filters_min_disk"></a> [vmsizes_filters_min_disk](#input\_vmsizes_filters_min_data)                                        | Minimum number of data disks available.                                                                                                                                                                                                                                                                                                                                                                                 | `number`            | `null` |    no     |
| <a name="input_vmsizes_filters_vm_types"></a> [vmsizes_filters_vm_types](#input\_vmsizes_filters_vm_types)                                           | The filtered vm types will belong to one of the vm types from this list.                                                                                                                                                                                                                                                                                                                                                | `list(string)`      | `null` |    no     |
| <a name="input_should_roll"></a> [should\_roll](#input\_should\_roll) | If set to true along with the vng update, roll will be triggered.| `bool`| `false` | no |
| <a name="input_conditioned_roll"></a> [conditioned\_roll](#input\_conditioned\_roll) | Default: false. Spot will perform a cluster Roll in accordance with a relevant modification of the cluster’s settings. When set to true , only specific changes in the cluster’s configuration will trigger a cluster roll (such as availability_zones, max_pods_per_node, enable_node_public_ip, os_disk_size_gb, os_disk_type, os_sku, kubernetes_version, vnet_subnet_ids, pod_subnet_ids, labels, taints and tags). | `bool`  | `null` | no |
| <a name="input_respect_pdb"></a> [respect\_pdb](#input\_respect\_pdb) | During the roll, if the parameter is set to true we honor PDB during the nodes replacement| `bool` | `true` | no |
| <a name="input_batch_size_percentage"></a> [batch\_size\_percentage](#input\_batch\_size\_percentage) | Value as a percent to set the size of a batch in a roll. Valid values are 0-100. In case of null as value, the default value in the backend will be 20%.| `number` | `20` | no |
| <a name="input_vng_ids"></a> [vng\_ids](#input\_vng\_ids) | List of virtual node group identifiers to be rolled. Each identifier is a string. vngIds can be null, and cannot be used together with nodeNames and nodePoolNames.| `list(string)` | `null` | no |
| <a name="input_batch_min_healthy_percentage"></a> [batch\_min\_healthy\_percentage](#input\_batch\_min\_healthy\_percentage) | Default: 50. Indicates the threshold of minimum healthy nodes in single batch. If the amount of healthy nodes in single batch is under the threshold, the roll will fail. If exists, the parameter value will be in range of 1-100. In case of null as value, the default value in the backend will be 50%. Value of param should represent the number in percentage (%) of the batch.| `number`| `null` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | Add a comment description for the roll. The comment is limited to 256 chars and optional.| `string`| `null` | no |
| <a name="input_node_pool_names"></a> [node\_pool\_names](#input\_node\_pool\_names) | List of node pools to be rolled. Each node pool name is a string. nodePoolNames can be null, and cannot be used together with nodeNames and vngIds.| `list(string)` | `null` | no |
| <a name="input_respect_restrict_scale_down"></a> [respect\_restrict\_scale\_down](#input\_respect\_restrict\_scale\_down)| During the roll, if the parameter is set to true we honor Restrict Scale Down label during the nodes replacement.| `bool`| `false` | no |
| <a name="input_node_names"></a> [node\_names](#input\_node\_names)| List of node names to be rolled. Each identifier is a string. nodeNames can be null, and cannot be used together with nodePoolNames and vngIds.| `list(string)` | `null` | no |


## Outputs

| Name | Description |
|------|-------------|

| <a name="output_vng_id"></a> [vng\_id](#output\_vng\_id) | The VirtualNodeGroup ID |
<!-- END_TF_DOCS -->

## License

Code is licensed under the [Apache License 2.0](LICENSE).
