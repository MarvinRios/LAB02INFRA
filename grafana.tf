resource "docker_container" "grafana" {
  name  = "grafana-${terraform.workspace}"
  image = "grafana/grafana:nightly-ubuntu"

  ports {
    internal = 3000
    external = var.grafana_external_port[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.monitor_net.name
  }
}