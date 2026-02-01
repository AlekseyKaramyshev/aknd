# global vars

variable "public_key" {
  type    = string
  default = "~/.ssh/ter_id_ed25519.pub"
}

variable "cloud_id" {
  type        = string
  default     = "123"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "123"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network"
}

variable "vpc_subnet_name" {
  type        = string
  default     = "develop-a"
  description = "VPC network"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "family" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
}