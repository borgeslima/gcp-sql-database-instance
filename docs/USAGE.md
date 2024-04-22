<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.24.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_service_networking_connection.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_networking_connection) | resource |
| [google-beta_google_sql_database_instance.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_sql_database_instance) | resource |
| [google_sql_database.this](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/resources/sql_database) | resource |
| [google_sql_user.this](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/resources/sql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | n/a | `string` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | <pre>list(object({<br>    name = string<br>  }))</pre> | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br>    enabled      = bool<br>    purpose      = optional(string)<br>    address_type = optional(string)<br>  })</pre> | <pre>{<br>  "address_type": "INTERNAL",<br>  "enabled": false,<br>  "purpose": "VPC_PEERING"<br>}</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | n/a | `string` | `""` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | n/a | <pre>object({<br>    tier = string<br>    data_cache_config = optional(object({<br>        data_cache_enabled = bool<br>    }))<br>    edition         = optional(string)<br>    ip_configuration = object({<br>      ipv4_enabled    = bool<br>      private_network = optional(string)<br>      enable_private_path_for_google_cloud_services = optional(bool)<br>      authorized_networks = list(object({<br>        name  = string<br>        range = string<br>      }))<br>    })<br>    disk_size = string<br>    disk_type = string<br>  })</pre> | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | n/a | <pre>list(object({<br>    name = string<br>    password : string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
<!-- END_TF_DOCS -->