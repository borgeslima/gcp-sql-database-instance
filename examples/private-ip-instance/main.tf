locals {
  name    = "quarks-pocs"
  project = "quarks-pocs"
  region  = "us-east1"
}

provider "google" {
  project = local.project
  region  = local.region
}

resource "google_compute_network" "private_network" {
  provider = google-beta
  name     = local.name
  project  = local.project
}

module "database_instance" {
  source              = "../.."
  project             = local.project
  region              = local.region
  name                = local.name
  database_version    = "POSTGRES_14"
  deletion_protection = false

  private_network = {
    enabled      = true
    address_type = "INTERNAL"
    purpose      = "VPC_PEERING"
  }

  databases = [{
    name = "quarks-pocs"
  }]

  users = [{
    name     = "quarks",
    password = "quarks@2057"
  }]

  settings = {

    tier      = "db-f1-micro"
    disk_size = "20"
    disk_type = "PD_SSD"
    edition   = "ENTERPRISE"

    data_cache_config = {
      data_cache_enabled = true
    }

    backup_configuration = {
      enabled            = true
      binary_log_enabled = true
    }

    ip_configuration = {

      ipv4_enabled                                  = false
      enable_private_path_for_google_cloud_services = true
      private_network                               = google_compute_network.private_network.id

      authorized_networks = [{
        name  = "allow-all",
        range = "0.0.0.0/0"
      }]

    }
  }

  depends_on = [google_compute_network.private_network]
}

