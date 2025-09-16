resource "docker_container" "app1" {

  name  = "nginx_01-${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.app_net.name
  }
  depends_on = [docker_container.grafana]
}

resource "docker_container" "app2" {

  name  = "nginx_02-${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port_2[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.app_net.name
  }
  depends_on = [docker_container.grafana]
}

resource "docker_container" "app3" {

  name  = "nginx_03-${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port_3[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.app_net.name
  }
  depends_on = [docker_container.grafana]
}
