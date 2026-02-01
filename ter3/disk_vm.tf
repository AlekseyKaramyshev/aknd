# Task 2: create vm cloud persistent disk

resource "yandex_compute_disk" "my_disk" {
  count    = 3

  name     = "disk-${count.index}"
  type     = var.storage.type
  zone     = var.default_zone
  size     = var.storage.size
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage.name
  hostname    = var.storage.name
  platform_id = var.platform_id

  resources {
    cores         = var.each_vm.0.cores
    memory        = var.each_vm.0.memory
    core_fraction = var.each_vm.0.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts-db.image_id
      type     = "network-hdd"
      size     = var.each_vm.0.disk_volume
    }
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }

 dynamic "secondary_disk" {
    for_each = yandex_compute_disk.my_disk

    content {
      disk_id    = secondary_disk.value.id
      auto_delete = true
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.default_subnetwork.id
    nat       = true
  }
  allow_stopping_for_update = true
}