variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "database_version" {
  type = string
}

variable "deletion_protection" {
  type = bool
}

variable "root_password" {
  type    = string
  default = ""
}

variable "private_network" {
  type = object({
    enabled      = bool
    purpose      = optional(string)
    address_type = optional(string)
  })
  default = {
    enabled      = false
    purpose      = "VPC_PEERING"
    address_type = "INTERNAL"
  }
}

variable "settings" {
  type = object({
    tier = string
    edition         = optional(string)
    disk_size = string
    disk_type = string
    
    data_cache_config = optional(object({
        data_cache_enabled = bool
    }))

    ip_configuration = object({
      ipv4_enabled    = bool
      private_network = optional(string)
      enable_private_path_for_google_cloud_services = optional(bool)
      authorized_networks = list(object({
        name  = string
        range = string
      }))
    })

    backup_configuration = optional(object({
        enabled = bool
        binary_log_enabled = bool
    }))


  })
}

variable "availability_type" {
  type = string
  default = "REGIONAL"
}

variable "databases" {
  type = list(object({
    name = string
  }))
}

variable "users" {
  type = list(object({
    name = string
    password : string
  }))
}