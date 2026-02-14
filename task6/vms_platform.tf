variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}

/*variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Имя ВМ"
}
*/
variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Тип платформы ВМ"
}
/*
variable "vm_db_cores" {
  type        = string
  default     = 2
  description = "Количество ядер процессора"
}

variable "vm_db_memory" {
  type        = string
  default     = 2
  description = "Объем оперативной памяти"
}

variable "vm_db_core_fraction" {
  type        = string
  default     = 20
  description = "Доля использования ядра"
}
*/
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image"
}
/*
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Имя ВМ"
}
*/
variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Тип платформы ВМ"
}
/*
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
*/
variable "vms_resources" {
  description = "Ресурсы для ВМ"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "vm_metadata" {
  description = "Общие метаданные для ВМ"
  type = map(object({
    serial-port-enable = number
    ssh-keys = string
    additional = map(string)
  }))
  default = {
    common = {
      serial-port-enable = 1
      ssh-keys = ""
      additional = {}
    }
  }
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILuXO9N9zMuO6BE4oQ6qedhwPoxUvueiSMTbkY1r5S00 pda@IdeaPad"
  description = "ssh-keygen -t ed25519"
}