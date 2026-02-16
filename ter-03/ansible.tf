resource "local_file" "hosts_templatefile" {
  content = templatefile("./hosts.tftpl", {
    webservers = yandex_compute_instance.web_servers,
    dbservers  = yandex_compute_instance.db_servers,
    storages   = yandex_compute_instance.storage_vm
  })

  filename = "${abspath(path.module)}/hosts.ini"
}