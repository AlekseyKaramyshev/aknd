# Task 2: create vms with custom security group

resource "yandex_vpc_security_group" "web_sg" {
  name        = "web-security-group"
  folder_id   = var.folder_id
  network_id  = yandex_vpc_network.default_network.id
}

data "yandex_compute_image" "ubuntu-2404-lts-web" {
  family = var.family
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index+1}"
  hostname    = "web-${count.index+1}"
  platform_id = var.platform_id

  resources {
    cores         = var.vm_resource.vm_default.cores
    memory        = var.vm_resource.vm_default.memory
    core_fraction = var.vm_resource.vm_default.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts-web.image_id
      type     = "network-hdd"
      size     = var.vm_resource.vm_default.disk_volume
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.default_subnetwork.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.web_sg.id]
  }
  allow_stopping_for_update = true
  # wait for db instances deploy
  depends_on  = [yandex_compute_instance.db]
}