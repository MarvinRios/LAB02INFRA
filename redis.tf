resource "docker_container" "redis" {
  name  = "redis-${terraform.workspace}"
  image = "redis:latest"

  ports {
    internal = 6379
    external = var.redis_external_port[terraform.workspace]
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