###cloud unique to specific instance vars

# dev instance 1

variable "name" {
  type        = string
  default     = "platform-web"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
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

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


# dev instance 2

variable "vm_db_name" {
  type        = string
  default     = "platform-db"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "vm_db_vpc_subnet_name" {
  type        = string
  default     = "develop-b"
  description = "VPC network"
}

variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
