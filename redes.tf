resource "docker_network" "monitor_net" {
  name = "monitor_net"
}

resource "docker_network" "app_net" {
  name = "app_net"
}

resource "docker_network" "persistence_net" {
  name = "persistence_net"
}

# Grafana
resource "docker_container" "grafana" {
  name  = "grafana-${terraform.workspace}"
  image = "grafana/grafana:nightly-ubuntu"

  networks_advanced {
    name = docker_network.monitor_net.name
  }

  ports {
    internal = 3000
    external = var.var.grafana_external_port[terraform.workspace]
  }
}

# Nginx 1
resource "docker_container" "app1" {

  name  = "nginx_01-${terraform.workspace}"
  image = "nginx:stable-perl"

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = var.var.nginx_external_port[terraform.workspace]
  }

  depends_on = [docker_container.grafana]
}

# Nginx 2
resource "docker_container" "app2" {

  name  = "nginx_02-${terraform.workspace}"
  image = "nginx:stable-perl"

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = var.var.nginx_external_port_2[terraform.workspace]
  }

  depends_on = [docker_container.grafana]
}

# Nginx 3
resource "docker_container" "app3" {
  name  = "nginx_03-${terraform.workspace}"
  image = "nginx:stable-perl"

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = var.var.nginx_external_port_3[terraform.workspace]
  }

  depends_on = [docker_container.grafana]
}

resource "docker_container" "redis" {
  name  = "redis-${terraform.workspace}"
  image = "redis:latest"

  networks_advanced {
    name = docker_network.persistence_net.name
  }

  ports {
    internal = 6379
    external = var.var.redis_external_port[terraform.workspace]
  }

  depends_on = [
    docker_container.app1,
    docker_container.app2,
    docker_container.app3
  ]
}

resource "docker_container" "postgre" {
  name  = "postgre-${terraform.workspace}"
  image = "postgres:13-trixie"

  env = [
  "POSTGRES_USER=admin",
  "POSTGRES_PASSWORD=admin123",
  "POSTGRES_DB=appdb"
  ]

  networks_advanced {
    name = docker_network.persistence_net.name
  }

  ports {
    internal = 5432
    external = var.postgre_external_port[terraform.workspace]
  }

  depends_on = [
    docker_container.app1,
    docker_container.app2,
    docker_container.app3
  ]
}