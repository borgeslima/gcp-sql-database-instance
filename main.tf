resource "google_sql_database_instance" "this" {
  provider            = google-beta
  name                = lower(var.name)
  project             = var.project
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  root_password       = try(var.root_password, "")
  settings {
    tier = var.settings.tier
    ip_configuration {
      ipv4_enabled = var.settings.ip_configuration.ipv4_enabled
      dynamic "authorized_networks" {
        for_each = { for idx, ipv4 in var.settings.ip_configuration.authorized_networks : idx => ipv4 }
        iterator = each
        content {
          name  = "allow-${each.value.name}"
          value = each.value.range
        }
      }
      
    }
    disk_size = try(var.settings.disk_size, 10)
    disk_type = try(var.settings.disk_type, "PD_SSD")
  }
}

resource "google_sql_database" "this" {
  for_each = { for idx, database in var.databases : idx => database }
  name       = each.value.name
  project    = var.project
  instance   = google_sql_database_instance.this.name
  depends_on = [google_sql_database_instance.this]
}

resource "google_sql_user" "this" {
  for_each = { for idx, user in var.users : idx => user }
  project    = var.project
  instance = google_sql_database_instance.this.name
  name     = each.value.name
  password = each.value.password

  depends_on = [google_sql_database_instance.this]
}