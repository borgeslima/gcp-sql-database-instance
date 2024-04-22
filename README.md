# GCP SQL INSTANCE Terraform module

Terraform module which creates SQL INSTANCE resources on GCP.


## Usage

```hcl

locals {
  name                   = "quarks-labs"
  project                = "quarks-labs"
  region                 = "us-east1"
  database_version       = "POSTGRES_14"
  root_password          = "$pw=user@2057"
  deletion_protection    = false
  databases              = [{
    name = "quarks-labs"
  }]
  users = [{
    name     = "quarks-labs",
    password = "quarks-labs@2057"
  }]
  settings = {
    tier      = "db-f1-micro"
    disk_size = "20"
    disk_type = "PD_SSD"
    ip_configuration = {
      ipv4_enabled = true
      authorized_networks = [{
        name  = "allow-all",
        range = "0.0.0.0/0"
      }]
    }
  }
}

module "database_instance" {
  source              = "../.."
  project             = local.project
  region              = local.region
  name                = local.name
  database_version    = local.database_version
  databases           = local.databases
  users               = local.users
  settings            = local.settings
  deletion_protection = local.deletion_protection
} 



```



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
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | n/a | `string` | `""` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | n/a | <pre>object({<br>    tier = string<br>    ip_configuration = object({<br>      ipv4_enabled = bool<br>      authorized_networks = list(object({<br>        name = string<br>        range = string<br>      }))<br>    })<br>    disk_size = string<br>    disk_type = string<br>  })</pre> | n/a | yes |
| <a name="input_users"></a> [users](#input\_users) | n/a | <pre>list(object({<br>    name = string<br>    password: string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | n/a |
<!-- END_TF_DOCS -->