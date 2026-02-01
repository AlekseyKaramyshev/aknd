# vm specific vars

# web vms
variable "vm_resource" {
      type          = map(object({
      cores         = number
      memory        = number
      core_fraction = number
      disk_volume   = number
    }))
    default       = {
      "vm_default"  = {
        cores           = 2
        memory          = 1
        core_fraction   = 20
        disk_volume     = 15
      }
    }
    description = "web vms variables"
}

# db vms
variable "each_vm" {
  type = list(object({
    vm_name         = string
    cores           = number
    memory          = number
    core_fraction   = number
    disk_volume     = number
  }))
  default = [
    {
      vm_name       = "main"
      cores         = 2
      memory        = 1
      core_fraction = 20
      disk_volume   = 15
    },
    {
      vm_name       = "replica"
      cores         = 2
      memory        = 2
      core_fraction = 20
      disk_volume   = 20
    }
  ]
  description = "db vms variables"
}

# storage vms
variable "storage" {
    type            = map(any)
    default         = {
        type        = "network-ssd"
        name        = "storage"
        size        = 1
    }
    description     = "persistent disk"
}