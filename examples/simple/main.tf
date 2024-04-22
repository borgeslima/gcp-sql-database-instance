locals {
  name                   = "quarks-labs"
  project                = "quarks-labs"
  region                 = "us-east1"
  database_version       = "POSTGRES_14"
  database_user_name     = "user@user"
  root_password          = "user@user"
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
  root_password       = local.root_password
  region              = local.region
  name                = local.name
  database_version    = local.database_version
  databases           = local.databases
  users               = local.users
  settings            = local.settings
  deletion_protection = local.deletion_protection
}