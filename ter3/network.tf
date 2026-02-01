# create default cloud network
resource "yandex_vpc_network" "default_network" {
  name        = var.vpc_name
}

# create default cloud subnet
resource "yandex_vpc_subnet" "default_subnetwork" {
  name           = var.vpc_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.default_network.id
  v4_cidr_blocks = var.default_cidr
}
