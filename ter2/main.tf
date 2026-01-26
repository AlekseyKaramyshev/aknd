# default dev net ( shared for 2 vms )
resource "yandex_vpc_network" "develop-network-default" {
  name = var.vpc_name
}

# subnet dev instance 1
resource "yandex_vpc_subnet" "develop-a" {
  name           = var.vpc_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop-network-default.id
  v4_cidr_blocks = var.default_cidr
}

# subnet dev instance 2
resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vm_db_vpc_subnet_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop-network-default.id
  v4_cidr_blocks = var.vm_db_default_cidr
}


# dev instance 1
data "yandex_compute_image" "ubuntu" {
  family = var.family
}
resource "yandex_compute_instance" "platform" {
  name           = local.name.platform
  hostname       = var.name
  zone           = var.default_zone
  platform_id    = var.platform_id
  resources {
    cores         = var.vms_resources.vm_web.cores
    memory        = var.vms_resources.vm_web.memory
    core_fraction = var.vms_resources.vm_web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.vm_web.serial-port-enable
    ssh-keys           = "ubuntu:${file(var.metadata.vm_db_resources.ssh-keys)}"
  }

}


# dev instance 2
data "yandex_compute_image" "ubuntu1" {
  family = var.family
}
resource "yandex_compute_instance" "platform1" {
  name           = local.name.platform1
  hostname       = var.vm_db_name
  zone           = var.vm_db_default_zone
  platform_id    = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources.vm_db_resources.cores
    memory        = var.vms_resources.vm_db_resources.memory
    core_fraction = var.vms_resources.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id =  data.yandex_compute_image.ubuntu1.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.vm_db_resources.serial-port-enable
    ssh-keys           = "ubuntu:${file(var.metadata.vm_db_resources.ssh-keys)}"
  }

}
