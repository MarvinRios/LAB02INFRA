resource "docker_container" "postgre" {
  name  = "postgre-${terraform.workspace}"
  image = "postgres:13-trixie"

env = [
  "POSTGRES_USER=admin",
  "POSTGRES_PASSWORD=admin123",
  "POSTGRES_DB=appdb"
  ]

  ports {
    internal = 5432
    external = var.postgre_external_port[terraform.workspace]
  }
  
  networks_advanced {
    name = docker_network.persistence_net.name
  }

  depends_on = [
    docker_container.app1,
    docker_container.app2,
    docker_container.app3
  ]
}