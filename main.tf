################################################################################
# GLOBAL ADDRESS
################################################################################


resource "google_compute_global_address" "this" {
  provider      = google-beta
  project       = var.project
  count         = (var.private_network.enabled ? 1 : 0)
  name          = lower(var.name)
  purpose       = var.private_network.purpose
  address_type  = var.private_network.address_type
  prefix_length = 16
  network       = var.settings.ip_configuration.private_network
}


################################################################################
# NETWORK CONNECTION
################################################################################

resource "google_service_networking_connection" "this" {
  provider                = google-beta
  count                   = (var.private_network.enabled ? 1 : 0)
  network                 = var.settings.ip_configuration.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.this[count.index].name]
  depends_on              = [google_compute_global_address.this]
}

################################################################################
# DATABASE INSTANCE
################################################################################


resource "google_sql_database_instance" "this" {
  provider            = google-beta
  name                = lower(var.name)
  project             = var.project
  region              = var.region
  database_version    = try(var.database_version, "")
  deletion_protection = try(var.deletion_protection, false)
  root_password       = try(var.root_password, "")

  settings {
    tier    = var.settings.tier
    edition =  var.settings.edition

    data_cache_config {
       data_cache_enabled = var.settings.data_cache_config.data_cache_enabled
    }

    backup_configuration {
      enabled = try(var.settings.backup_configuration.enabled, false)
      binary_log_enabled = try(var.settings.backup_configuration.binary_log_enabled, false)
    }

    ip_configuration {
      
      ipv4_enabled                                  = var.settings.ip_configuration.ipv4_enabled
      private_network                               = try(var.settings.ip_configuration.private_network, "")
      enable_private_path_for_google_cloud_services = try(var.settings.ip_configuration.enable_private_path_for_google_cloud_services, false)
      
      dynamic "authorized_networks" {
        for_each = { for idx, ipv4 in var.settings.ip_configuration.authorized_networks : idx => ipv4 }
        iterator = each
        content {
          name  = "allow-${each.value.name}"
          value = each.value.range
        }
      }

    }

    availability_type = try(var.availability_type, "")
    disk_size = try(var.settings.disk_size, 10)
    disk_type = try(var.settings.disk_type, "PD_SSD")
  }

  depends_on = [google_compute_global_address.this]
}



################################################################################
# DATABASES
################################################################################


resource "google_sql_database" "this" {
  for_each   = { for idx, database in var.databases : idx => database }
  name       = each.value.name
  project    = var.project
  instance   = google_sql_database_instance.this.name
  depends_on = [google_sql_database_instance.this]
}

################################################################################
# USERS
################################################################################


resource "google_sql_user" "this" {
  for_each = { for idx, user in var.users : idx => user }
  project  = var.project
  instance = google_sql_database_instance.this.name
  name     = each.value.name
  password = each.value.password

  depends_on = [google_sql_database_instance.this]
}