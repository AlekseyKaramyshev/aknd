###cloud shared vars

variable "env" {
    type     = string
    default  = "netology-develop"
}

variable "family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vpc_name" {
  type        = string
  default     = "develop-network"
  description = "VPC network"
}

variable "cloud_id" {
  type        = string
  default     = "cloud_id"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "catalog_id"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vms_resources" {
  type        = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default     = {
    "vm_web"     = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
    "vm_db_resources" = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
  description = "Resource configuration for vms host"
}

variable "metadata" {
  type    = map(object({
    serial-port-enable  = number
    ssh-keys            = string
  }))
  default               = {
    "vm_web"            = {
      serial-port-enable = 0
      ssh-keys           = "~/.ssh/key.pub"
    }
    "vm_db_resources"   = {
      serial-port-enable = 1
      ssh-keys           = "~/.ssh/key.pub"
    }
  }
  description = "Metadata for vms"
}
