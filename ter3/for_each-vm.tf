# Task 2: create db vms before web

data "yandex_compute_image" "ubuntu-2404-lts-db" {
  family = var.family
}

resource "yandex_compute_instance" "db" {
  for_each    = { for vm_db in var.each_vm : vm_db.vm_name => vm_db }

  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = var.platform_id

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts-db.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
    }
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.default_subnetwork.id
    nat       = true
  }
  allow_stopping_for_update = true
}