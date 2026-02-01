resource "local_file" "hosts_templatefile" {
  filename = "${abspath(path.module)}/hosts.ini"
  content = templatefile("${path.module}/hosts.tftpl",
  {
    groups = {
        "web"       = yandex_compute_instance.web,
        "db"        = values(yandex_compute_instance.db),
        "storage"   = [yandex_compute_instance.storage]
        }
    }
  )
}