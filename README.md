
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

## License

Code is licensed under the [Apache License 2.0](LICENSE).
