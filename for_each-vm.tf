
resource "yandex_compute_instance" "db_servers" {
  for_each = {
    for vm in var.each_vm : vm.vm_name => vm
  }

  name = each.value.vm_name

  resources {
    memory = each.value.ram
    cores  = each.value.cpu
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = each.value.disk_volume
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