###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Имя ВМ"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Тип платформы ВМ"
}

variable "vm_web_cores" {
  type        = string
  default     = 2
  description = "Количество ядер процессора"
}

variable "vm_web_memory" {
  type        = string
  default     = 1
  description = "Объем оперативной памяти"
}

variable "vm_web_core_fraction" {
  type        = string
  default     = 5
  description = "Доля использования ядра"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILuXO9N9zMuO6BE4oQ6qedhwPoxUvueiSMTbkY1r5S00 pda@IdeaPad"
  description = "ssh-keygen -t ed25519"
}
