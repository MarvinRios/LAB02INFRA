resource "docker_container" "nginx" {
  name  = "nginx"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = 3000
  }
}