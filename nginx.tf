resource "docker_container" "nginx" {
  count = 3
  name  = "nginx-${terraform.workspace}-${count.index + 1}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace][count.index]
  }
}
