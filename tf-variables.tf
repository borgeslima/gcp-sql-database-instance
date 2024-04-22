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
  type = string
  default = ""
}

variable "settings" {
  type  = object({
    tier = string
    ip_configuration = object({
      ipv4_enabled = bool
      authorized_networks = list(object({
        name = string
        range = string
      }))
    })
    disk_size = string
    disk_type = string
  })
}

variable "databases" {
  type = list(object({
    name = string
  }))
}

variable "users" {
  type = list(object({
    name = string
    password: string
  }))
}