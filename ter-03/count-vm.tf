resource "yandex_compute_instance" "web_servers" {
  count = 2
  name = "web-${count.index + 1}"

  depends_on = [
    yandex_compute_instance.db_servers
  ]

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

}

