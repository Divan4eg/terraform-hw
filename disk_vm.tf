resource "yandex_compute_disk" "data_disks" {
  count = 3

  name   = "data-disk-${count.index + 1}"
  type   = "network-hdd"
  size   = 1
#  zone   = var.default_zone
}

resource "yandex_compute_instance" "storage_vm" {
  name       = "storage"

  resources {
    memory = 2
    cores  = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    security_group_ids = [yandex_vpc_security_group.example.id]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh_key
  }
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
